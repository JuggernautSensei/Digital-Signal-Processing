%% Convolution.m
% 연속 신호와 이산 신호의 컨벌루션을 계산하고 비교한다.
%   연속: x(t) = u(t+2) - u(t-2),  h(t) = (-t+3)[u(t) - u(t-3)]
%   이산: x[n] = u[n+2] - u[n-3],  h[n] = (-n+3)[u[n] - u[n-3]]
%   연속 컨벌루션은 conv 결과에 dt를 곱해 적분을 근사한다.
%   conv 전체 결과의 시간 축은 2*t(1)에서 시작하므로,
%   t 구간에 해당하는 부분만 잘라낸다.

clc; clear; close all;

% 연속 신호
dt  = 0.001;
t   = -4 : dt : 6;
x_t = double(t >= -2) - double(t >= 2);
h_t = (-t + 3) .* double(t >= 0 & t < 3);

yFull  = conv(x_t, h_t) * dt;                   % 적분 근사 (시간 축: 2*t(1) 부터)
offset = round(-t(1) / dt);                     % t(1) 에 해당하는 위치까지의 샘플 수
y_t    = yFull(offset + (1 : numel(t)));

% 이산 신호
n   = -4 : 6;
x_n = double(n >= -2) - double(n >= 3);
h_n = (-n + 3) .* (double(n >= 0) - double(n >= 3));
y_n = conv(x_n, h_n);
m   = (2 * min(n)) : (2 * max(n));              % y[n]의 인덱스 축

% 그리기
figure('Position', [100 100 800 600]);

subplot(3, 2, 1);
plot(t, x_t, 'b', 'LineWidth', 1.2);
title('x(t) = u(t+2) - u(t-2)'); xlabel('t'); ylabel('x(t)');
axis([-4 6 -0.5 2.5]); grid on;

subplot(3, 2, 2);
stem(n, x_n, 'filled');
title('x[n] = u[n+2] - u[n-3]'); xlabel('n'); ylabel('x[n]');
axis([-4 6 -0.5 2.5]); grid on;

subplot(3, 2, 3);
plot(t, h_t, 'r', 'LineWidth', 1.2);
title('h(t) = (-t+3)u(t) - (-t+3)u(t-3)'); xlabel('t'); ylabel('h(t)');
axis([-4 6 -1 4]); grid on;

subplot(3, 2, 4);
stem(n, h_n, 'filled');
title('h[n] = (-n+3)u[n] - (-n+3)u[n-3]'); xlabel('n'); ylabel('h[n]');
axis([-4 6 -1 4]); grid on;

subplot(3, 2, 5);
plot(t, y_t, 'k', 'LineWidth', 1.2);
title('y(t) = x(t) * h(t)'); xlabel('t'); ylabel('y(t)');
axis([-4 6 -1 6]); grid on;

subplot(3, 2, 6);
stem(m, y_n, 'filled');
title('y[n] = x[n] * h[n]'); xlabel('n'); ylabel('y[n]');
axis([min(m) max(m) -1 7]); grid on;
