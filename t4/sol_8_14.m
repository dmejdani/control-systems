clc; clear all; close all;
%% We know that the asymptotes have real axis intercept at sigma = -5.
%% Thus the break-away point has to be between poles (-6 and 0)

%% values of s for the section [-6, 0]
s = -6:.01:0;

%% Values of K can be found with: K = -1 / (G(s)*H(s))
K = -(s .* (s + 6) .* (s + 9));
%% We can plot K versus s to see that there is one maximum
figure(1)
plot(s, K)
xlabel('\sigma')
ylabel('K')

[maxK index] = max(K);
break_ptn = s(index);
fprintf('The break-away point is in the vicinity of s = %f\n\n', break_ptn);


%% Finding the jw crossings
%% The sum of angles from the finite open-loop poles and zeros must add to (2k + 1)180°
s_jw = (0:0.01:20) .* 1j;
ang = angle(1 ./ (s_jw .* (s_jw + 6) .* (s_jw + 9)));
%% mod with 2pi to find the odd pi multiple point
mod_ang = mod(ang, 2 * pi);
%% remainder of about 1pi as it is a odd multiple
jw_index = mod_ang > 0.999 * pi & mod_ang < 1.001 * pi;
figure(2)
plot(imag(s_jw), mod_ang)
hold on
plot(imag(s_jw(jw_index)), mod_ang(jw_index), 'x')
xlabel('jw')
ylabel('(-\Sigma ang(finite poles)) mod 2\pi')
legend('Remainder from mod', 'Remainder from mod is \pi - Odd multiple of pi')


jw_cross_start = s_jw(jw_index)(1);
jw_cross_end = s_jw(jw_index)(end);
fprintf("The jw crossing is between: %fj and %fj\n and in its corresponding conjugate:\n between -%fj and -%fj\n",...
    imag(jw_cross_start), imag(jw_cross_end), imag(jw_cross_end), imag(jw_cross_start));