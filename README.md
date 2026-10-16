# Digital Signal Processing with MATLAB

![MATLAB](https://img.shields.io/badge/MATLAB-R2020a+-0076A8?logo=mathworks&logoColor=white)
![Topic](https://img.shields.io/badge/Topic-Digital%20Signal%20Processing-4B8BBE)

> 신호 생성부터 컨벌루션, 샘플링, 푸리에 해석까지. 디지털 신호 처리의 핵심 개념을 MATLAB으로 직접 구현하고 결과를 그래프로 확인한 실습 모음입니다.

![샘플링 주파수에 따른 에일리어싱](Resources/05_Sampling.png)

## 프로젝트 소개

디지털신호처리 과목(2025년 1학기)을 수강하며 수행한 MATLAB 실습과 보고서를 정리한 저장소입니다. 교재의 MATLAB 실습 문제를 직접 구현했고, 개념이 쌓이는 순서에 맞춰 네 단계로 다시 묶었습니다.

1. **신호와 잡음**: 기본 이산 신호를 만들고, 원하는 SNR에 맞춰 잡음을 섞습니다.
2. **컨벌루션과 LTI 시스템**: 컨벌루션을 계산하고, 이동평균 필터로 잡음을 제거합니다.
3. **샘플링과 양자화**: 샘플링 주파수에 따른 에일리어싱과 양자화 오차를 확인합니다.
4. **푸리에 해석**: DTFS, DTFT, DFT/FFT를 구현하고 시간 영역 연산과 주파수 영역 연산의 결과가 같은지 비교합니다.

모든 과정을 관통하는 질문은 하나입니다. **"시간 영역의 컨벌루션은 주파수 영역의 곱으로 바뀌고, 이를 FFT로 빠르게 계산할 수 있다"는 성질을 직접 구현해서 확인할 수 있는가?**

- 작성자: 안지우 (부경대학교 컴퓨터공학과 4학년)
- 교재: 디지털 신호 처리 (2판) – 기본 이론부터 MATLAB 실습까지

## 실습 목록

| 단계 | 실습 | 파일 | 핵심 개념 |
|---|---|---|---|
| 1 | 여러 가지 이산 신호 | [`DiscreteSignals.m`](01_Signals/DiscreteSignals.m) | 임펄스, 계단, 사각 펄스, 램프, sinc, 지수 감쇠 정현파 |
| 1 | 잡음에 오염된 신호 | [`NoisySignal.m`](01_Signals/NoisySignal.m) | 균일·정규분포 백색잡음, SNR |
| 2 | 연속·이산 컨벌루션 | [`Convolution.m`](02_Convolution/Convolution.m) | 컨벌루션 적분 근사, 컨벌루션 합 |
| 2 | 이동평균 필터 | [`MovingAverageFilter.m`](02_Convolution/MovingAverageFilter.m) | FIR 필터, 임펄스 응답 |
| 3 | 샘플링과 에일리어싱 | [`Sampling.m`](03_Sampling/Sampling.m), [`SamplingSpectrum.m`](03_Sampling/SamplingSpectrum.m) | 나이퀴스트 주파수, 주파수 중첩 |
| 3 | 양자화 | [`Quantization.m`](03_Sampling/Quantization.m) | 양자화 간격, 양자화 오차, SNR |
| 4 | FT를 이용한 컨벌루션 | [`ConvolutionByFT.m`](04_FourierAnalysis/ConvolutionByFT.m) | 컨벌루션 성질 |
| 4 | 이산 주기 신호의 푸리에 해석 | [`DTFS.m`](04_FourierAnalysis/DTFS.m), [`DTFT_Inverse.m`](04_FourierAnalysis/DTFT_Inverse.m) | DTFS 계수, 영채우기, IDTFT |
| 4 | DTFT의 대칭성과 주파수 이동 | [`DTFT_Symmetry.m`](04_FourierAnalysis/DTFT_Symmetry.m), [`DTFT_FrequencyShift.m`](04_FourierAnalysis/DTFT_FrequencyShift.m) | 우함수·기함수 분해, 주파수 이동 성질 |
| 4 | DFT를 이용한 선형·원형 컨벌루션 | [`CircularConvolution.m`](04_FourierAnalysis/CircularConvolution.m) | 원형 컨벌루션, 시간 영역 중첩 |

## 주요 내용

### 1. 신호와 잡음

#### 여러 가지 이산 신호

임펄스 δ[n]을 기준으로 계단, 사각 펄스, 램프, sinc, 지수 감쇠 정현파를 -10 ≤ n ≤ 10 구간에서 만들었습니다. 각 신호는 비교 연산(`n >= 0`)과 원소별 연산(`.*`)만으로 정의할 수 있습니다. 이 신호들은 이후 실습에서 입력과 임펄스 응답을 만드는 재료가 됩니다.

![여러 가지 이산 신호](Resources/01_DiscreteSignals.png)

#### 잡음에 오염된 신호

정현파 s(t) = cos(2πt)에 균일분포 잡음과 정규분포 잡음을 섞었습니다. 잡음의 크기 a는 목표 SNR에서 거꾸로 계산합니다.

$$
a = \frac{\sigma_s}{\sigma_n \cdot 10^{\mathrm{SNR}/20}}
$$

| 잡음 | 목표 SNR | 계산된 a |
|---|---|---|
| 균일분포 백색잡음 | 15 dB | 0.4424 |
| 정규분포 백색잡음 | 10 dB | 0.2236 |

SNR이 낮을수록 신호에 섞이는 잡음이 커지는 것을 그래프로 확인할 수 있습니다.

![잡음에 오염된 신호](Resources/02_NoisySignal.png)

### 2. 컨벌루션과 LTI 시스템

#### 연속·이산 컨벌루션

LTI 시스템의 출력은 입력과 임펄스 응답의 컨벌루션입니다. 연속 신호는 `conv` 결과에 샘플 간격 dt를 곱해 적분을 근사했고, 이산 신호는 컨벌루션 합을 그대로 계산했습니다. 출력의 인덱스 범위는 두 신호 시작 인덱스의 합부터 끝 인덱스의 합까지입니다.

![연속·이산 컨벌루션](Resources/03_Convolution.png)

#### 이동평균 필터에 의한 잡음 제거

송신 신호 s[n] = (1.02)ⁿ에 주기 8인 잡음 v[n] = 0.5cos(2πn/8 + π/4)가 섞여 들어온 상황입니다. 최근 7개 샘플의 평균을 내는 이동평균 필터를 적용했습니다.

$$
h[n] = \frac{1}{7}\sum_{k=0}^{6}\delta[n-k], \qquad y[n] = x[n] * h[n]
$$

필터를 통과한 y[n]에서는 진동하는 잡음이 대부분 사라지고, 송신 신호와 비슷한 증가 곡선이 남습니다. 앞쪽 6개 샘플은 필터 창이 다 차지 않아 과도 응답이 나타납니다.

![이동평균 필터](Resources/04_MovingAverageFilter.png)

### 3. 샘플링과 양자화

#### 샘플링 주파수에 따른 에일리어싱

f₀ = 100 Hz 정현파를 네 가지 샘플링 주파수로 샘플링하고, FFT로 스펙트럼을 확인했습니다. 나이퀴스트 주파수는 2f₀ = 200 Hz입니다.

| f<sub>s</sub> | 나이퀴스트 조건 | 스펙트럼에서 보이는 주파수 |
|---|---|---|
| 75 Hz | 만족하지 않음 | ±25 Hz (100 − 75) |
| 100 Hz | 만족하지 않음 | 0 Hz (직류처럼 보임) |
| 125 Hz | 만족하지 않음 | ±25 Hz (125 − 100) |
| 400 Hz | 만족 | ±100 Hz (원래 주파수) |

조건을 만족하지 못하면 100 Hz 성분이 f<sub>s</sub>/2 안쪽으로 접혀 다른 주파수처럼 보입니다. 샘플 값만으로는 원래 신호와 접힌 신호를 구별할 수 없습니다.

![샘플링된 신호](Resources/05_Sampling.png)
![샘플링된 신호의 스펙트럼](Resources/06_SamplingSpectrum.png)

#### 양자화와 양자화 오차

sin(2πt)를 3비트 양자화기로 양자화했습니다. 양자화 간격은 Δ = R / 2ᵇ이고, 양자화 오차 e[n] = x<sub>q</sub>[n] − x[n]은 ±Δ/2 안에 머뭅니다. 신호 기울기가 완만한 꼭짓점 근처에서는 오차가 천천히 변하고, 기울기가 큰 구간에서는 빠르게 진동합니다.

![양자화](Resources/07_Quantization.png)

### 4. 푸리에 해석

#### 푸리에 변환을 이용한 컨벌루션

폭 2인 사각 펄스를 자기 자신과 컨벌루션하면 삼각 펄스가 됩니다. 시간 영역에서 직접 계산한 결과와 `fft` → 곱셈 → `ifft`로 계산한 결과가 일치합니다.

$$
y(t) = x(t) * x(t) \quad\Longleftrightarrow\quad Y(\omega) = X(\omega)\,X(\omega)
$$

![FT를 이용한 컨벌루션](Resources/08_ConvolutionByFT.png)

#### 이산 주기 신호의 푸리에 해석 (DTFS → DTFT)

주기 N = 18인 신호의 DTFS 계수를 정의식으로 계산했습니다. 진폭 스펙트럼은 k = N/2를 기준으로 대칭이고, 위상 스펙트럼은 반대칭입니다. 실수 신호의 켤레 대칭성이 드러납니다.

![DTFS](Resources/09_DTFS.png)

이어서 한 주기만 떼어낸 비주기 신호를 1024점으로 영채우기하고 FFT를 수행해 연속에 가까운 DTFT 스펙트럼을 얻었습니다. n < 0 구간의 샘플은 DFT의 주기성을 이용해 배열 뒤쪽에 배치했습니다. IFFT로 되돌리면 원래 신호가 복원됩니다.

![DTFT와 역변환](Resources/10_DTFT_Inverse.png)

#### DTFT의 대칭성과 주파수 이동 성질

x[n] = sin(πn/2) (−5 ≤ n ≤ 10)을 우함수 성분 x<sub>e</sub>[n]과 기함수 성분 x<sub>o</sub>[n]으로 나눴습니다. 실수 신호의 DTFT에서는 실수부가 우함수 성분의 스펙트럼과, 허수부가 기함수 성분의 스펙트럼과 같습니다.

| 스펙트럼의 실수부·허수부 | 우함수·기함수 성분의 스펙트럼 |
|---|---|
| ![실수부와 허수부](Resources/11_DTFT_RealImag.png) | ![우함수와 기함수](Resources/12_DTFT_EvenOdd.png) |

x[n]에 e<sup>jπn/4</sup>를 곱하면 스펙트럼 전체가 π/4 (정규화 주파수로 1/8)만큼 이동합니다.

$$
y[n] = e^{j\pi n/4}\,x[n] \quad\Longleftrightarrow\quad Y(e^{j\Omega}) = X\!\left(e^{j(\Omega - \pi/4)}\right)
$$

![주파수 이동](Resources/13_DTFT_FrequencyShift.png)

#### DFT를 이용한 선형·원형 컨벌루션

길이 8인 두 신호로 세 가지를 확인했습니다.

| 실험 | 방법 | 결과 |
|---|---|---|
| (a) 원형 컨벌루션 | 선형 컨벌루션을 길이 8로 접어 더한 값과 `ifft(fft(x).*fft(h))` 비교 | 두 결과 일치 |
| (b) 영채우기 | 두 신호를 길이 15 (= 8 + 8 − 1)로 영채우기 후 원형 컨벌루션 | 선형 컨벌루션과 일치 |
| (c) 주기 2배 | 신호를 두 번 이어 붙여 길이 16으로 원형 컨벌루션 | (a) 결과의 2배가 두 번 반복 |

원형 컨벌루션은 선형 컨벌루션이 주기 N으로 겹쳐진 결과입니다. 영채우기로 길이를 N<sub>x</sub> + N<sub>h</sub> − 1 이상으로 늘리면 겹침이 사라지므로, FFT로 선형 컨벌루션을 빠르게 계산할 수 있습니다.

| (a) 원형 컨벌루션 | (b) 영채우기로 구한 선형 컨벌루션 |
|---|---|
| ![원형 컨벌루션](Resources/14_CircularConvolution.png) | ![선형 컨벌루션](Resources/15_LinearConvolutionByDFT.png) |

![주기가 2배인 원형 컨벌루션](Resources/16_CircularConvolutionDoublePeriod.png)

## 개념 정리

| 문서 | 내용 |
|---|---|
| [개념 정리](Docs/개념%20정리.md) | 신호와 시스템, 샘플링, 푸리에 해석의 핵심 개념과 변환 사이의 관계 |
| [푸리에 급수와 푸리에 변환 – 이론, 차이, 그리고 실제](Docs/푸리에%20급수와%20푸리에%20변환%20보고서.pdf) | 직교 기저에서 출발해 푸리에 급수와 푸리에 변환을 유도하고, 영상 처리와 전력 시스템의 활용 사례를 정리한 보고서 |
| [문제풀이](Docs/문제풀이) | 장별 연습 문제 손풀이 |

## 실행 방법

- MATLAB R2020a 이상을 권장합니다. 소스 파일은 UTF-8로 저장되어 있어 이전 버전에서는 한글 주석과 그래프 제목이 깨질 수 있습니다.
- 추가 툴박스는 필요하지 않습니다.
- 각 `.m` 파일은 독립된 스크립트입니다. 파일을 열고 실행(F5)하면 해당 실습의 그래프가 나타납니다.

## 저장소 구조

```
DigitalSignalProcessing-MATLAB/
├── 01_Signals/
│   ├── DiscreteSignals.m
│   └── NoisySignal.m
├── 02_Convolution/
│   ├── Convolution.m
│   └── MovingAverageFilter.m
├── 03_Sampling/
│   ├── Sampling.m
│   ├── SamplingSpectrum.m
│   └── Quantization.m
├── 04_FourierAnalysis/
│   ├── ConvolutionByFT.m
│   ├── DTFS.m
│   ├── DTFT_Inverse.m
│   ├── DTFT_Symmetry.m
│   ├── DTFT_FrequencyShift.m
│   └── CircularConvolution.m
├── Docs/
│   ├── 개념 정리.md
│   ├── 푸리에 급수와 푸리에 변환 보고서.pdf
│   └── 문제풀이/
├── Resources/
└── README.md
```
"# Digital-Signal-Processing-Study" 
