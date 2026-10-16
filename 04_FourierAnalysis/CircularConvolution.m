%% CircularConvolution.m
% DFT를 이용한 선형 컨벌루션과 원형 컨벌루션 (N = 8)
%   x[n] = [1 1 2 1 0 -1 -2 -1],  h[n] = [1 1 2 3 2 3 2 1]
%
%   (a) 원형 컨벌루션 y_N[n] = x[n] ⊛ h[n]
%       - 시간 영역: 선형 컨벌루션 결과를 길이 N으로 접어서 더함  y_N[n] = y[n] + y[n+N]
%       - 주파수 영역: IDFT( DFT{x} · DFT{h} )
%   (b) 길이 Nx+Nh-1 로 영채우기 후 원형 컨벌루션 = 선형 컨벌루션
%   (c) 신호를 두 번 이어 붙여 주기를 2N 으로 늘린 원형 컨벌루션

clc; clear; close all;

x  = [1 1 2 1 0 -1 -2 -1];
h  = [1 1 2 3 2 3 2 1];
N  = length(x);
Nx = length(x);
Nh = length(h);

%% (a) 원형 컨벌루션: 시간 영역 vs 주파수 영역
yl    = conv(x, h);                             % 선형 컨벌루션 (길이 2N-1)
ylPad = [yl, zeros(1, 1)];                      % 길이 2N 으로 맞춤
yc    = ylPad(1 : N) + ylPad(N+1 : 2*N);        % 시간 영역 원형 컨벌루션
yp    = ifft(fft(x, N) .* fft(h, N));           % 주파수 영역 원형 컨벌루션

n = 0 : N - 1;
figure;
subplot(2, 2, 1); stem(n, x);           title('신호 x[n]');                     xlabel('n'); grid on;
subplot(2, 2, 2); stem(n, h);           title('신호 h[n]');                     xlabel('n'); grid on;
subplot(2, 2, 3); stem(n, yc);          title('시간 영역 원형 컨벌루션 결과');  xlabel('n'); grid on;
subplot(2, 2, 4); stem(n, real(yp));    title('주파수 영역 원형 컨벌루션 결과'); xlabel('n'); grid on;

%% (b) 영채우기로 원형 컨벌루션 = 선형 컨벌루션
L  = Nx + Nh - 1;
xa = [x, zeros(1, L - Nx)];
ha = [h, zeros(1, L - Nh)];
yc2 = ifft(fft(xa) .* fft(ha));

n = 0 : L - 1;
figure;
subplot(2, 1, 1); stem(n, yl, 'filled');        title('직접 컨벌루션 계산 결과');       xlabel('n'); grid on;
subplot(2, 1, 2); stem(n, real(yc2), 'filled'); title('원형 컨벌루션 이용 계산 결과'); xlabel('n'); grid on;

%% (c) 주기가 2배인 원형 컨벌루션
x2 = [x, x];
h2 = [h, h];
N2 = length(x2);
y2 = ifft(fft(x2, N2) .* fft(h2, N2));

n = 0 : N2 - 1;
figure;
stem(n, real(y2), 'filled');
title('주기가 2배인 원형 컨벌루션 결과'); xlabel('n'); grid on;
