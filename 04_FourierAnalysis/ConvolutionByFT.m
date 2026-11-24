%% ConvolutionByFT.m
% 사각 펄스 x(t) = u(t+1) - u(t-1)에 대해 y(t) = x(t) * x(t)를
%   1) 시간 영역에서 직접 컨벌루션
%   2) 푸리에 변환의 컨벌루션 성질 (Y = X·X) 로 계산
% 한 뒤 두 결과를 비교한다.

clc; clear; close all;

N  = 512;
dt = 6 / N;
t  = (-N/2 : N/2) * dt;                         % -3 ~ 3 구간

x = double(t >= -1) - double(t >= 1);           % 사각 펄스

% 1) 시간 영역 컨벌루션
y1 = conv(x, x) * dt;                           % 시간 축: 2*t(1) 부터
y1 = y1(N/2 + (1 : numel(t)));                  % t 구간에 해당하는 부분

% 2) 주파수 영역 곱
X  = fft(x);
Yf = dt * X .* X;
y2 = fftshift(ifft(Yf));

% 그리기
figure('Name', '컨벌루션 비교', 'NumberTitle', 'off');

subplot(2, 1, 1);
plot(t, y1, 'b-', 'LineWidth', 1);
title('시간 영역 컨벌루션 결과');
axis([-3 3 0 2.5]); xlabel('t'); grid on;

subplot(2, 1, 2);
plot(t, real(y2), 'r-', 'LineWidth', 1);
title('FT에 의한 컨벌루션 결과');
axis([-3 3 0 2.5]); xlabel('t'); grid on;
