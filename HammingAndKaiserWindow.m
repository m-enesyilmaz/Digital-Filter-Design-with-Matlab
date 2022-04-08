%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Muhammed Enes Yılmaz                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear
clc

% For Kaiser window:
% M degree of FIR filter
% normalized transition region bandwidth: deltaW = (wr-wc)/2*pi
% stop band attenuation: A = -20*log(dirac2)
% M = (A-7.95)/(14.36*deltaW)
% beta shape parameter: 
% If b => A >= 50; 0.1102*(A - 8.7)
%      If 21 < A < 50; 0.5842*(A - 21)^0.4 + 0.07886*(A - 21)

% For the sample values given before the practice;
wc = 0.2*pi;
wr = 0.3*pi;
A = 50;
deltaW = (wr-wc)/(2*pi);
% cutoff freqz wd = 0.25*pi given as because the passband is centered for this frequency
wd = 0.25;

% For Hamming window;
m1 = 3.3/(deltaW);
M1 = round(m1);

% For Kaiser window;
m2 = (A-7.95) / (14.36*deltaW);
beta1 = 0.1102*(A - 8.7);
M2 = round(m2);

% window-based FIR filter design;
% b = fir1(n,Wn,ftype,window)
% n = degree of filter
% wd = cutoff frequency
% ftype = type of filter
% window = window method to apply
window1 = fir1(M1,wd,'low',hamming(M1+1));
window2 = fir1(M2,wd,'low',kaiser(M2+1,beta1));

% We know that an LTI filter is stable if and only if all its poles are 
% exactly inside the unit circle (|z|) in the complex z-plane. In particular, 
% a pole p outside the unit circle (|p|) results in an impulse-response 
% component proportional to p^n that grows exponentially over time n.

% If we see them side by side in the time and frequency domains:
wvtool(window1)
wvtool(window2)

% Let's examine it separately:
figure
freqz(window1,1,512)
title({'Hamming Window Implemented Filter';'M = 66'})
figure
freqz(window2,1,512)
title({'Kaiser Window Implemented Filter';'M = 59 ve \beta = 4.5513'})

figure
subplot(2,1,1)
impz(window1)
title({'Impulse Response';'Hamming Window'})
grid on
subplot(2,1,2)
impz(window2)
title({'Impulse Response';'Kaiser Window'})
grid on

H1 = tf(window1);
H2 = tf(window2);

% To definitively reverse a z-transform, we must know its region of convergence. 
% The critical question is whether the region of convergence contains the unit circle:
% If it does, each pole outside the unit circle is anticausal, finite-energy, 
% and exponential; each inner pole corresponds to its usual causal decreasing exponent.

% FIR filters contain zero (zeros) as well as poles (poles), but all poles 
% are at the origin (z = 0). Since all poles lie within the unit circle, 
% the FIR filter is apparently stable. 
% If zeros are outside the unit circle, what effect do they have on system behavior?
% If our system is stable and causal but has zeros outside the unit circle; 
% the inverse is not constant, meaning that the system has no minimum phase. 
% The minimum phase system has a minimum group delay. Systems that are causal 
% and stable but vice versa causal and unstable are known as non-minimum 
% phase systems. A non-minimum phase system has a larger phase contribution 
% than a minimum phase system for the same magnitude response.
% A pole outside the unit circle causes instability and zero leads to non-minimum 
% phase with the first response having a negative slope. This means that your 
% phase margin decreases and hence stability margins decrease.

figure
subplot(2,1,1)
zplane(window1)
legend('zeros','poles','unit circle')
title('Zero-Pole Plot on the Hamming Window Unit Circle')
grid on
subplot(2,1,2)
zplane(window2)
legend('zeros','poles','unit circle')
title('Zero-Pole Plot on Kaiser Window Unit Circle')
grid on

% Why always |z| We're looking at , why don't we look at any z > 0 and z < 0?
% To understand if our system is stable and causal.
% Zeros with z > 0 mean that the transfer function has a high pass character.
% Zeros with z < 0 means that the transfer function has a low pass character.

% A discrete LTI (Linear Time Invariant) system is said to be stable if it 
% satisfies the following property:
% A discrete LTI system if and only if ROC of the transfer function unit 
% circle |z| = if it contains 1,
% Causally discrete LTI system with rational transfer function H(z) 
% if and only if all poles of H(z) are on the unit circle |z| = 1, it is stable.

figure
zerophase(window1)
hold on
zerophase(window2)
legend('Hamming','Kaiser')
hold off
