%% MovingAverageFilter.m
% 7점 이동평균(MA) 필터로 수신 신호의 잡음을 제거한다.
%   송신 신호 s[n] = (1.02)^n
%   잡음     v[n] = 0.5 cos(2πn/8 + π/4)
%   수신 신호 x[n] = s[n] + v[n]
%   필터     h[n] = (1/7) Σ_{k=0}^{6} δ[n-k],   y[n] = x[n] * h[n]

clc; clear; close all;

n = 0 : 50;

s = 1.02 .^ n;                                  % 송신 신호
v = 0.5 * cos(2 * pi * n / 8 + pi / 4);         % 잡음
x = s + v;                                      % 수신 신호

h  = ones(1, 7) / 7;                            % 7점 이동평균 필터의 임펄스 응답
y  = conv(x, h);                                % 필터 출력
ny = 0 : length(y) - 1;

% 그리기
figure('Position', [100 100 600 800]);

subplot(3, 1, 1);
stem(n, s, 'filled');
title('s[n] = (1.02)^n'); xlabel('n'); ylabel('Amplitude');
axis([0 50 0 4]); grid on;

subplot(3, 1, 2);
stem(n, x, 'filled');
title('x[n] = s[n] + v[n]'); xlabel('n'); ylabel('Amplitude');
axis([0 50 -2 4]); grid on;

subplot(3, 1, 3);
stem(ny, y, 'filled');
title('y[n] = x[n] * h[n]'); xlabel('n'); ylabel('Amplitude');
axis([0 50 0 4]); grid on;
