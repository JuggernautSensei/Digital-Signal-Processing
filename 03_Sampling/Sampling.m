%% Sampling.m
% 연속 정현파 x(t) = cos(2π·f0·t), f0 = 100 Hz를
% 샘플링 주파수 fs = 75, 100, 125, 400 Hz로 샘플링하고 원 신호와 겹쳐 그린다.
% 나이퀴스트 주파수(2·f0 = 200 Hz)보다 낮은 fs에서는 에일리어싱이 발생한다.

clc; clear; close all;

f0 = 100;                                       % 정현파 주파수 [Hz]

ti = -0.02;                                     % 시작 시각 [s]
tf =  0.02;                                     % 종료 시각 [s]
dt =  1e-5;                                     % 연속 신호를 그릴 간격 [s]

fs = [75, 100, 125, 400];                       % 샘플링 주파수 [Hz]

figure('Position', [100 100 800 600]);
for k = 1 : numel(fs)
    PlotSampledSignal(ti, tf, dt, fs(k), f0, 2, 2, k);
end

%% 로컬 함수
function PlotSampledSignal(ti, tf, dt, fs, f0, rows, cols, idx)
    % 연속 신호
    tCont = ti : dt : tf;
    xCont = cos(2 * pi * f0 * tCont);

    % 샘플링된 신호
    Ts    = 1 / fs;
    tSamp = ti : Ts : tf;
    xSamp = cos(2 * pi * f0 * tSamp);

    subplot(rows, cols, idx);
    plot(tCont, xCont, 'b-', 'LineWidth', 1); hold on;
    stem(tSamp, xSamp, 'r', 'filled', 'LineWidth', 1);
    hold off;
    title(sprintf('f_s = %d Hz', fs));
    xlabel('Time [s]'); ylabel('Amplitude');
    grid on;
end
