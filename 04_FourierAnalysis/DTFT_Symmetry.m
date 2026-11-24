%% DTFT_Symmetry.m
% 비주기 신호 x[n] = sin(πn/2), -5 <= n <= 10 에 대해
%   (a) DTFT X(e^{jΩ})의 실수부와 허수부를 구하고
%   (b) 우함수 성분 x_e[n], 기함수 성분 x_o[n]의 DTFT를 구해
%       Re{X} = DTFT{x_e},  j·Im{X} = DTFT{x_o} 임을 확인한다.

clc; clear; close all;

n = -5 : 10;
w = -pi : 1/200 : pi;
x = sin(pi * n / 2);

%% (a) 실수부 / 허수부
Xf = x * exp(-1j * n' * w);                     % DTFT를 행렬 곱으로 계산

figure;
subplot(2, 1, 1);
plot(w / (2*pi), real(Xf));
title('스펙트럼의 실수부'); xlabel('F (normalized)'); ylabel('Re\{X(e^{j\Omega})\}');
grid on;

subplot(2, 1, 2);
plot(w / (2*pi), imag(Xf));
title('스펙트럼의 허수부'); xlabel('F (normalized)'); ylabel('Im\{X(e^{j\Omega})\}');
grid on;

%% (b) 우함수 / 기함수 성분
m  = min([n, -n]) : max([n, -n]);               % -10 ~ 10, 원점 대칭 축
xx = zeros(1, length(m));
iStart = find(m == n(1));
xx(iStart : iStart + length(x) - 1) = x;

xe = 0.5 * (xx + fliplr(xx));                   % 우함수 성분
xo = 0.5 * (xx - fliplr(xx));                   % 기함수 성분

Xef = xe * exp(-1j * m' * w);
Xof = xo * exp(-1j * m' * w);

figure;
subplot(2, 1, 1);
plot(w / (2*pi), real(Xef));
title('우함수 성분의 스펙트럼'); xlabel('F'); grid on;

subplot(2, 1, 2);
plot(w / (2*pi), imag(Xof));
title('기함수 성분의 스펙트럼'); xlabel('F'); grid on;
