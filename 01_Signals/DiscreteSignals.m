%% DiscreteSignals.m
% 여러 가지 기본 이산 신호를 -10 <= n <= 10 범위에서 그린다.
%   임펄스 δ[n], 계단 u[n+5], 사각 펄스 rect[n/8],
%   램프 0.2·r[n-3], sinc(n/3), 지수 감쇠 정현파 e^(-0.15n)cos(0.2πn)u[n]

clc; clear; close all;

n = -10 : 10;                                   % 시간 축

% 신호 정의
delta  = double(n == 0);                        % 임펄스
step   = double(n >= -5);                       % 계단 u[n+5]
rect   = double(abs(n) <= 4);                   % 사각 펄스 rect[n/8]
ramp   = 0.2 * (n - 3) .* double(n >= 3);       % 램프 0.2·r[n-3]

sincN      = ones(size(n));                     % sinc(n/3), n = 0 에서 1
idx        = (n ~= 0);
sincN(idx) = sin(pi * n(idx) / 3) ./ (pi * n(idx) / 3);

expCos = exp(-0.15 * n) .* cos(0.2 * pi * n) .* double(n >= 0);   % 지수 감쇠 정현파

% 그리기
signals = {delta, step, rect, ramp, sincN, expCos};
titles  = {'임펄스 신호 \delta[n]', '계단 신호 u[n+5]', '사각 펄스 rect[n/8]', ...
           '램프 신호 0.2 r[n-3]', 'sinc 함수 sinc(n/3)', '지수 감쇠 정현파'};

figure('Position', [100 100 800 600]);
for k = 1 : numel(signals)
    subplot(3, 2, k);
    stem(n, signals{k}, 'filled');
    title(titles{k});
    xlabel('n'); ylabel('Amplitude');
    grid on;
end
sgtitle('여러 가지 이산 신호');
