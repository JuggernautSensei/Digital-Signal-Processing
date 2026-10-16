%% DTFS.m
% 주기 N = 18인 이산 주기 신호 x[n]의 이산 시간 푸리에 급수(DTFS) 계수를 구한다.
%   X[k] = (1/N) Σ_{n=<N>} x[n] e^{-j(2π/N)kn},   n = -8 ~ 9

clc; clear; close all;

N  = 18;
x  = [0 1 2 3 2 1 0 -1 -1 -1 0 -1 0 -1 0 1 2 1];   % 한 주기
w0 = 2 * pi / N;                                % 기본 각주파수
n  = -N/2 + 1 : N/2;                            % -8 ~ 9
WN = exp(-1j * w0 * n);

Xk = zeros(1, N);
for m = 1 : N
    Xk(m) = sum(x .* (WN .^ (m - 1))) / N;
end

k = 0 : N - 1;
disp(Xk.');

% 그리기
figure;

subplot(2, 1, 1);
stem(k, abs(Xk), 'filled');
title('진폭 스펙트럼'); xlabel('k'); grid on;

subplot(2, 1, 2);
stem(k, angle(Xk), 'filled');
title('위상 스펙트럼'); xlabel('k'); grid on;
