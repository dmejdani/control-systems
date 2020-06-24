clc; clear all; close all;
%% part b)
%% finding the agle which corresponds for zeta = 0.8
theta = pi - acos(0.8);
r = 0:0.01:5;
s = r .* e^(theta*j);

function [g_values] = g(s)
  g_values = (s + 6) ./ ((s + 2) .* (s + 4) .* (s + 7) .* (s + 8));
endfunction

%% finding the angle of G(s) and checking the point which it is closer to pi
ang = angle(g(s));  # (s + 6) ./ ((s + 2) .* (s + 4) .* (s + 7) .* (s + 8)));
ang_mod = mod(ang, 2 * pi) - pi;
s_dom_poles_index = ang_mod < 0.01 & ang_mod > -0.01;
s_dom_poles = s(s_dom_poles_index);

%% plotting the remainder of mod with respect to s, finding the odd multiple of pi radians
figure(1)
plot(real(s), ang_mod)
hold on
plot(real(s)(s_dom_poles_index), ang_mod(s_dom_poles_index), 'x')
xlabel('\sigma')
ylabel('(Angle of G(s) mod 2\pi) - \pi ')
figure(2)
plot(imag(s), ang_mod)
hold on
plot(imag(s)(s_dom_poles_index), ang_mod(s_dom_poles_index), 'x')
xlabel('jw')
ylabel('(Angle of G(s) mod 2\pi) - \pi ')

fprintf('The position of the dominant poles are in the vicinity of s = %f + %fj and its conjugate\n',...
 real(s_dom_poles(1)), imag(s_dom_poles(1)));

%% part c)
%% finding the value of K
s_dom_poles = s_dom_poles(1);
K = 1 / abs(g(s_dom_poles));

%% part d)
%% finding the location of the compensator pole 
T_s = 1;

%% finding the coordinate of the dominant pole when compansated
real_s_c = - 4 / T_s;               % real part of the dom poles
imag_s_c = real_s_c * tan(theta);   % imaginary part of the dom poles
s_c = real_s_c + 1j*imag_s_c;

% sum of all angles of G(s) with the addition of the compensating zero
ang_to_s_c = angle(g(s_c)*(s_c + 4.5)); 

% the angle of the compensating pole to the root locus point that we are interested in
ang_comp_pole = mod(ang_to_s_c, 2*pi) - pi;

% the position of the pole
comp_pole = - (4  + imag_s_c / tan(ang_comp_pole));
fprintf('The position of the compensator pole is at s=%f\n', comp_pole);

%% finding the value of K for the root locus point we are interested in
K = 1 / abs(g(s_c) * (s_c + 4.5) / (s_c - comp_pole));
fprintf('The value of K is %f\n', K);
