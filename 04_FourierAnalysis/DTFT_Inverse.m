%% DTFT_Inverse.m
% 주기 신호의 한 주기를 비주기 신호 y[n]으로 보고
%   1) 영채우기 후 FFT로 DTFT 스펙트럼을 근사하고
%   2) IFFT로 다시 시간 영역 신호를 복원한다.
% n < 0 구간은 FFT 배열의 뒤쪽에 배치한다 (DFT의 주기성).

clc; clear; close all;

% 파라미터
N  = 1024;                                      % FFT 길이 (영채우기 포함)
df = 1 / N;
f  = df * (-N/2 + 1 : N/2);                     % 정규화 주파수 축

% 시간 신호 (n = -8 부터)
x = [0 1 2 1 2 3 2 1 0 -1 -1 0 -1 0 -1 0 1 2 1];

% 영채우기: n >= 0 은 앞쪽, n < 0 은 뒤쪽
xa = zeros(1, N);
xa(1 : 10)    = x(9 : 18);                      % n = 0 ~ 9
xa(N-7 : N)   = x(1 : 8);                       % n = -8 ~ -1

% FFT
Xf  = fft(xa);
Xfr = fftshift(Xf);

% 스펙트럼 그리기
figure(1);

subplot(2, 1, 1);
plot(f, abs(Xfr));
title('진폭 스펙트럼'); xlabel('f'); grid on;

subplot(2, 1, 2);
plot(f, angle(Xfr));
title('위상 스펙트럼'); xlabel('f'); grid on;

% IFFT로 복원
yn = ifft(Xf);
y  = [yn(N-9 : N), yn(1 : 11)];                 % n = -10 ~ 10 순서로 재배열

n = -10 : 10;
figure(2);
stem(n, real(y), 'filled');
title('비주기 신호 y[n]'); xlabel('n'); grid on;
