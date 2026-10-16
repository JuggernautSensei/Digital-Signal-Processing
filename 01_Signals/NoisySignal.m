%% NoisySignal.m
% 정현파 s(t) = cos(2πt)에 백색잡음을 원하는 SNR로 섞는다.
%   x(t) = s(t) + a·n(t),   a = σ_s / (σ_n · 10^(SNR/20))
%   균일분포 잡음은 SNR = 15 dB, 정규분포 잡음은 SNR = 10 dB

clc; clear; close all;
rng(0);                                         % 재현성을 위한 시드 고정

% 1) 시간 축과 원 신호
t      = 0 : 0.001 : 2;
signal = cos(2 * pi * t);

% 2) 평균 0인 백색잡음 생성
noiseUniform  = rand(size(signal)) - 0.5;       % 균일분포
noiseGaussian = randn(size(signal));            % 정규분포

% 3) 목표 SNR [dB]
snrUniform  = 15;
snrGaussian = 10;

% 4) 잡음 크기 a 계산
aUniform  = std(signal) / (std(noiseUniform)  * 10^(snrUniform  / 20));
aGaussian = std(signal) / (std(noiseGaussian) * 10^(snrGaussian / 20));

% 5) 잡음 섞인 신호
xUniform  = signal + aUniform  * noiseUniform;
xGaussian = signal + aGaussian * noiseGaussian;

% 6) 그리기
figure('Position', [100 100 800 600]);

subplot(2, 2, 1);
plot(t, noiseUniform); axis([0 2 -2 2]);
title('균일분포 백색잡음'); xlabel('t [s]'); ylabel('Amplitude'); grid on;

subplot(2, 2, 2);
plot(t, noiseGaussian); axis([0 2 -2 2]);
title('정규분포 백색잡음'); xlabel('t [s]'); ylabel('Amplitude'); grid on;

subplot(2, 2, 3);
plot(t, signal, 'k', 'LineWidth', 1.5); hold on;
plot(t, xUniform); axis([0 2 -2 2]);
title(sprintf('균일잡음 섞인 신호 (SNR=%d dB)', snrUniform));
legend('s(t)', 's(t)+u(t)', 'Location', 'best'); grid on;

subplot(2, 2, 4);
plot(t, signal, 'k', 'LineWidth', 1.5); hold on;
plot(t, xGaussian); axis([0 2 -2 2]);
title(sprintf('정규잡음 섞인 신호 (SNR=%d dB)', snrGaussian));
legend('s(t)', 's(t)+n(t)', 'Location', 'best'); grid on;

% 7) 잡음 크기 출력
fprintf('균일분포 백색잡음 a 값은 %.4f\n', aUniform);
fprintf('정규분포 백색잡음 a 값은 %.4f\n', aGaussian);
