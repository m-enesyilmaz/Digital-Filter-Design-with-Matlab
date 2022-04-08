%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Muhammed Enes Yılmaz                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear
clc

n = 20; % order
% linspace(a,b,n); Divide from a to b into n equal parts, we get a vector 
fs = linspace(0,1,1500); % sampling frequency
bp1 = 0.35; % bandpass interval initial value
bp2 = 0.7; % bandpass interval end value
Rs = 80; % ripple
w = fs*2*pi;
cut1 = bp1*2*pi; % rads/second
cut2 = bp2*2*pi;

% analog prototype design:
[z,p,k] = cheb2ap(n,Rs); % chebyshev type 2 lowpass design
% we will convert it to a state-space form;
[A, B, C, D] = zp2ss(z,p,k);

Bw = cut2 - cut1; % bandwidth
Wo = sqrt(cut1*cut2); % center frequency

% lowpass to bandpass conversion:
[At,Bt,Ct,Dt] = lp2bp (A,B,C,D,Wo,Bw);

[num,den] = ss2tf(At,Bt,Ct,Dt); % Converting to Transfer Function Form
h = freqs(num,den,w); % we calculate the frequency response
figure
semilogy(w/2/pi,abs(h))
xlabel('Frekans')
ylabel("Magnitude")
title("Magnitude of Our Bandpass Filter")
grid on
figure
plot(w/2/pi,phase(h))
xlabel('Frekans')
ylabel("Faz")
title("Phase of Our Bandpass Filter")
grid on

% Impulse invariance is a technique used to design discrete-time infinite 
% impulse response (IIR) filters from continuous-time filters, in which 
% the impulse response of the continuous-time system is sampled to produce 
% the impulse response of the discrete-time system.

% Impulse Invariance Transformation:
% [bz,az] = impinvar(b,a,fs)
% We scale with 1/fs, fs sampling rate
[numIIT,denIIT] = impinvar(num,den);
figure
freqz(numIIT,denIIT,w/2)
title('20th Order Bandpass Filter IIT Frequency Response')
fvtool(numIIT,denIIT)
title('20th Degree Bandpass Filter IIT Magnitude and Phase')

[numIIT2,denIIT2] = impinvar(num,den,2);
figure
freqz(numIIT2,denIIT2,w/2)
title('20th Order Bandpass Filter IIT Frequency Response','IIT Transformation Sampling Rate 2')
fvtool(numIIT2,denIIT2)
title('20th Degree Bandpass Filter IIT Magnitude and Phase','IIT Transformation Sampling Rate 2')

[numIIT3,denIIT3] = impinvar(num,den,10);
figure
freqz(numIIT3,denIIT3,w/2)
title('20th Order Bandpass Filter IIT Frequency Response','IIT Transformation Sampling Rate 10')
fvtool(numIIT3,denIIT3)
title('220th Degree Bandpass Filter IIT Magnitude and Phase','IIT Transformation Sampling Rate 10')

% The impulse-invariant method converts analog filter transfer functions to 
% digital filter transfer functions such that the impulse response is the 
% same (invariant) at sampling instants. The order of the filter is preserved 
% and IIR analog filters are mapped to IIR digital filters. However, 
% the frequency response of the digital filter is a version of the frequency 
% response of the analog filter, which is aliasing (an effect that causes 
% different signals to become indistinguishable when sampled).
% Because we were trying to digitize a higher order filter with an impulse 
% invariant transform, aliasing occurred during the conversion.

% Bilinear Transformation:
% [Ad,Bd,Cd,Dd] = bilinear(A,B,C,D,fs) It converts the continuous time state-space 
% system in the A, B, C and D matrices to the discrete time system.
% [Ad,Bd,Cd,Dd] = bilinear(A,B,C,D,fs,fp)
% fs; Sampling rate specified as a positive scalar.
% fp; The frequency of the match, specified as a positive scalar.
[Ad,Bd,Cd,Dd] = bilinear(At,Bt,Ct,Dt,1);
[bz,az] = ss2tf(Ad,Bd,Cd,Dd); % Converting to Transfer Function
figure
freqz(bz,az)
title('20th Order Bandpass Filter Bilinear Transformation Frequency Response','Sampling Rate of Bilinear Transformation 1')
fvtool(bz,az)
title('20th Degree Bandpass Filter Bilinear Transformation Magnitude and Phase','Sampling Rate of Bilinear Transformation 1')

[Ad2,Bd2,Cd2,Dd2] = bilinear(At,Bt,Ct,Dt,2,0.1);
[bz2,az2] = ss2tf(Ad2,Bd2,Cd2,Dd2);
figure
freqz(bz2,az2)
title('20th Order Bandpass Filter Bilinear Transformation Frequency Response','Sampling Rate of Bilinear Transformation 2')
fvtool(bz2,az2)
title('20th Degree Bandpass Filter Bilinear Transformation Magnitude and Phase','Sampling Rate of Bilinear Transformation 2')

[Ad3,Bd3,Cd3,Dd3] = bilinear(At,Bt,Ct,Dt,5,0.1);
[bz3,az3] = ss2tf(Ad3,Bd3,Cd3,Dd3);
figure
freqz(bz3,az3)
title('20th Order Bandpass Filter Bilinear Transformation Frequency Response','Sampling Rate of Bilinear Transformation 5')
fvtool(bz3,az3)
title('20th Degree Bandpass Filter Bilinear Transformation Magnitude and Phase','Sampling Rate of Bilinear Transformation 5')

% Bilinear transformation is a special conformal mapping used to convert a 
% transfer function H(s) of a linear time-invariant (LTI) filter in the 
% continuous time domain to a transfer function H(z) of a linear, shift-invariant 
% filter in the discrete time domain. method.
% Bilinear transform maintains stability and maps each point of the H(jΩ) 
% frequency response of the continuous time filter to a corresponding point 
% in the frequency response of the discrete time filter, Hd (𝑒^jΩT), in despite of 
% with a slightly different frequency. This means that for every feature seen 
% in the frequency response of the analog filter, there is a corresponding 
% feature in the frequency response of the digital filter, perhaps at a slightly 
% different frequency, with the same gain and phase shift. This is barely noticeable 
% at low frequencies, but quite noticeable at frequencies close to the Nyquist frequency.
