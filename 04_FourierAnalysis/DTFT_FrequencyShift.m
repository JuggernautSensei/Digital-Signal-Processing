%% DTFT_FrequencyShift.m
% 주파수 이동 성질을 확인한다.
%   y[n] = e^{jπn/4} x[n]  ->  Y(e^{jΩ}) = X(e^{j(Ω - π/4)})
%   x[n] = sin(πn/2), -5 <= n <= 10

clc; clear; close all;

n = -5 : 10;
w = -pi : 1/200 : pi;

x = sin(pi * n / 2);
y = x .* exp(1j * pi * n / 4);

Xf = x * exp(-1j * n' * w);
Yf = y * exp(-1j * n' * w);

figure;

subplot(2, 2, 1);
plot(w / (2*pi), abs(Xf));
title('신호 x[n]의 진폭 스펙트럼'); xlabel('F (정규화된 주파수)'); ylabel('|X(e^{j\Omega})|');
grid on;

subplot(2, 2, 2);
plot(w / (2*pi), angle(Xf));
title('신호 x[n]의 위상 스펙트럼'); xlabel('F'); ylabel('\angle X(e^{j\Omega})');
grid on;

subplot(2, 2, 3);
plot(w / (2*pi), abs(Yf));
title('신호 y[n]의 진폭 스펙트럼'); xlabel('F'); ylabel('|Y(e^{j\Omega})|');
grid on;

subplot(2, 2, 4);
plot(w / (2*pi), angle(Yf));
title('신호 y[n]의 위상 스펙트럼'); xlabel('F'); ylabel('\angle Y(e^{j\Omega})');
grid on;
