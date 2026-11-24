%% SamplingSpectrum.m
% Sampling.m 에서 샘플링한 신호의 진폭 스펙트럼을 FFT로 구한다.
%   fs = 75, 125 Hz : 100 Hz 성분이 ±25 Hz로 접혀 나타난다 (에일리어싱).
%   fs = 100 Hz     : 0 Hz(직류)로 보인다.
%   fs = 400 Hz     : ±100 Hz에 올바르게 나타난다.

clc; clear; close all;

fs = [75, 100, 125, 400];                       % 샘플링 주파수 [Hz]
N  = 1024;                                      % FFT 길이

figure('Position', [100 100 800 600]);
for k = 1 : numel(fs)
    PlotSampledSpectrum(fs(k), N, k);
end

%% 로컬 함수
function PlotSampledSpectrum(fs, N, idx)
    f0 = 100;                                   % 정현파 주파수 [Hz]
    Ts = 1 / fs;
    df = fs / N;                                % 주파수 해상도

    t = (0 : N - 1) * Ts;                       % 샘플 시각
    x = cos(2 * pi * f0 * t);

    X    = fftshift(fft(x));
    f    = (-N/2 : N/2 - 1) * df;               % fftshift 순서에 맞춘 주파수 축
    Xmag = abs(X) / max(abs(X));                % 최댓값으로 정규화

    subplot(2, 2, idx);
    plot(f, Xmag);
    axis([f(1) f(end) 0 1.2]);
    title(sprintf('샘플링된 신호의 진폭 스펙트럼 (f_s = %d Hz)', fs));
    xlabel('f (Hz)');
    grid on;
end
