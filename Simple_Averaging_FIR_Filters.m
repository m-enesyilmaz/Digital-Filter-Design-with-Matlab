%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Muhammed Enes Yılmaz                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear
clc

% A low pass filter (LPF) is a filter that passes signals at a frequency 
% lower than a selected cutoff frequency and attenuates signals with frequencies 
% higher than the cutoff frequency. The exact frequency response of the filter 
% depends on the filter design. An ideal low-pass filter can be mathematically 
% (theoretically) implemented with a sinc function, multiplying a signal 
% by the rectangular function in the frequency domain or doubling with 
% the impulse response in the time domain. However, the ideal filter is 
% impossible to realize without infinitely large signals in time, and so 
% it often needs to be approximated for real ongoing signals, as the support 
% region of the sinc function extends to all past and future tenses. Therefore, 
% to perform conv, the filter must have infinite delay or infinite future 
% and past information.

h3 = ones(1,3)/3;
h5 = ones(1,5)/5;
h7 = ones(1,7)/7;
h4 = ones(1,4)/4;
h6 = ones(1,6)/6;

% freqz = Frequency response
% [h,w] = freqz(b,a,n);
% b ve a; Transfer function coefficients specified as vectors
% n; number of measuring/fixing points
% w;  the corresponding angular frequency vector w for the digital filter
% w = pi corresponds to the Nyquist frequency
% h; frequency response
[H3,w] = freqz(h3,1,128);
H5 = freqz(h5,1,128);
H7 = freqz(h7,1,128);
H4 = freqz(h4,1,128);
H6 = freqz(h6,1,128);

figure
freqz(h3,1,128)
title("3's frequency response")
figure
freqz(h4,1,128)
title("4's frequency response")
figure
freqz(h5,1,128)
title("5's frequency response")
figure
freqz(h6,1,128)
title("6's frequency response")
figure
freqz(h7,1,128)
title("7's frequency response")

f = w/pi;

mag3 = abs(H3);
phase3 = angle(H3);
mag5 = abs(H5);
phase5 = angle(H5);
mag7 = abs(H7);
phase7 = angle(H7);
mag4 = abs(H4);
phase4 = angle(H4);
mag6 = abs(H6);
phase6 = angle(H6);

% Magnitude and phases of 3 4 5 6 and 7
figure
subplot(5,2,1)
plot(f,mag3); grid on, title("3's magnitude") 
subplot(5,2,2)
plot(f,phase3); grid on, title("3's phase")
subplot(5,2,3)
plot(f,mag4); grid on, title("4's magnitude") 
subplot(5,2,4)
plot(f,phase4); grid on, title("4's phase")
subplot(5,2,5)
plot(f,mag5); grid on, title("5's magnitude")
subplot(5,2,6)
plot(f,phase5); grid on, title("5's phase")
subplot(5,2,7)
plot(f,mag6); grid on, title("6's magnitude") 
subplot(5,2,8)
plot(f,phase6); grid on, title("6's phase")
subplot(5,2,9)
plot(f,mag7); grid on, title("7's magnitude") 
subplot(5,2,10)
plot(f,phase7); grid on, title("7's phase")

% Real filters for real-time applications approach the ideal filter by truncating 
% and windowing the infinite impulse response to create a finite impulse response. 
% Applying this filter requires delaying the signal for a reasonable time interval, 
% allowing the computation to "look" into the future a bit (lagging). This delay 
% manifests itself as a phase shift. Higher accuracy in approximation requires a longer delay.

% Analysis of H3 H4 H5 H6 and H7 (normalized)
fvtool(H3,'Analysis','freq'), title("3's magnitude and phase responses")
fvtool(H4,'Analysis','freq'), title("4's magnitude and phase responses")
fvtool(H5,'Analysis','freq'), title("5's magnitude and phase responses")
fvtool(H6,'Analysis','freq'), title("6's magnitude and phase responses")
fvtool(H7,'Analysis','freq'), title("7's magnitude and phase responses")

% In signal processing, the Nyquist frequency (or folding frequency), named 
% after Harry Nyquist, is a continuous function or property of a sampler that 
% converts a signal into a discrete sequence. The Nyquist frequency is half 
% the sampling rate of a discrete signal processing system.
% When the highest frequency (bandwidth) of a signal is less than the Nyquist 
% frequency of the sampler, the resulting discrete time sequence is said to be 
% free of distortion known as Aliasing. And the corresponding sampling rate is 
% said to be above the Nyquist rate for the signal.

% Nyquist plots according to given
figure('Name',"3's 4's 5's 6's and 7's Nyquist Diagrams, respectively");
subplot(5,1,1)
Nyquist3 = tf(h3,1);
nyquist(Nyquist3), grid on
subplot(5,1,2)
Nyquist4 = tf(h4,1);
nyquist(Nyquist4), grid on
subplot(5,1,3)
Nyquist5 = tf(h5,1);
nyquist(Nyquist5), grid on
subplot(5,1,4)
Nyquist6 = tf(h6,1);
nyquist(Nyquist6), grid on
subplot(5,1,5)
Nyquist7 = tf(h7,1);
nyquist(Nyquist7), grid on

% Nyquist bode diagrams
figure
subplot(1,5,1)
bode(Nyquist3), legend('Nyquist3'), grid on
subplot(1,5,2)
bode(Nyquist4), legend('Nyquist4'), grid on
subplot(1,5,3)
bode(Nyquist5), legend('Nyquist5'), grid on
subplot(1,5,4)
bode(Nyquist6), legend('Nyquist6'), grid on
subplot(1,5,5)
bode(Nyquist7), legend('Nyquist7'), grid on

% conv 
hConv1 = conv(h3,h5);
hConv2 = conv(h5,h7);
Hconv1FreqResp = freqz(hConv1,1,128);
Hconv2FreqResp = freqz(hConv2,1,128);
magConv1 = abs(Hconv1FreqResp);
magConv2 = abs(Hconv2FreqResp);
phaseConv1 = angle(Hconv1FreqResp);
phaseConv2 = angle(Hconv2FreqResp);

% The magnitude and phase of the conv states
figure
subplot(2,2,1)
plot(f,magConv1); grid on, title("hConv1(3's ve 5's) magnitude") 
subplot(2,2,2)
plot(f,phaseConv1); grid on, title("hConv1(3's ve 5's) phase")
subplot(2,2,3)
plot(f,magConv2); grid on, title("hConv2(5's ve 7's) magnitude") 
subplot(2,2,4)
plot(f,phaseConv2); grid on, title("hConv2(5's ve 7's) phase")

% impulse response
figure
subplot(1,2,1)
impz(hConv1), grid on, title("3's ve 5's conv impulse response")
subplot(1,2,2)
impz(hConv2), grid on, title("5's ve 7's conv impulse response")

% z plane zeros and poles
figure
subplot(1,2,1)
zplane(hConv1), grid on, title("hConv(3's ve 5's) zeros and poles")
subplot(1,2,2)
zplane(hConv2), grid on, title("hConv(5's ve 7's) zeros and poles")

% Shift phase angles
phaseUnwrap1 = unwrap(phaseConv1);
phaseUnwrap2 = unwrap(phaseConv2);
figure
subplot(1,2,1)
plot(f,phaseUnwrap1), grid on, title("hConv's(3's ve 5's) Shift phase angles")
subplot(1,2,2)
plot(f,phaseUnwrap2), grid on, title("hConv's(5's ve 7's) Shift phase angles")

% cascade 3 4 5 and 6 smoothing
firstConv = conv(h3,h4);
secondConv = conv(firstConv,h5);
lastConv = conv(secondConv,h6);
fvtool(lastConv,'Analysis','freq'), title('Cascade 3 4 5 6 smoothing')

% Impulse response in 3 4 5 6 conv's
figure
subplot(1,3,1)
impz(firstConv), grid on, title("3's ve 4's conv impulse response")
subplot(1,3,2)
impz(secondConv), grid on, title("3's 4's ve 5's conv impulse response")
subplot(1,3,3)
impz(lastConv), grid on, title("3's 4's 5's ve 6's conv impulse response")
