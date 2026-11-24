%% Quantization.m
% 정현파 x(t) = sin(2πt)를 한 주기에 100개 샘플로 샘플링한 뒤
% b = 3 비트 양자화기로 양자화하고, 양자화 오차 e[n]과 SNR을 구한다.
%   Δ = R / 2^b,  x_q[n] = Δ · round(x[n] / Δ),  e[n] = x_q[n] - x[n]
%   SNR = 10 log10( Σx² / Σe² )

clc; clear; close all;

b = 3;                                          % 양자화 비트 수

t = 0 : 0.01 : 1;                               % 한 주기에 100개 샘플
x = sin(2 * pi * t);                            % 샘플링된 정현파 x[n]

R  = max(x) - min(x);                           % 신호 값의 전체 범위
L  = 2^b;                                       % 양자화 레벨 수
dq = R / L;                                     % 양자화 간격

xq = dq * round(x / dq);                        % 양자화된 신호
eq = xq - x;                                    % 양자화 오차

snr = 10 * log10(sum(x .* x) / sum(eq .* eq));  % 양자화 잡음에 대한 SNR

% 그리기
figure('Position', [100 100 800 600]);

subplot(2, 1, 1);
plot(t, x, 'r'); hold on;
stem(t, xq);
title('양자화기의 출력 신호 x_q[n]'); grid on;

subplot(2, 1, 2);
stem(t, eq);
title('양자화 오차 e[n]'); grid on;

fprintf('양자화기의 SNR은 %.4f dB\n', snr);
