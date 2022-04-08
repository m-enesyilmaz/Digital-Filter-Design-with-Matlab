%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Muhammed Enes Yılmaz                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear
clc

% length; If 128 is 2*pi, we set the cutoff 16 (pi/4)
% linspace(a,b,n); Divide from a to b into n equal parts, we get a vector
length = 128;
arrayLength = linspace(0,1,128);
lwp_1s = linspace(1,1,16);
lwp_0s = linspace(0,0,112);
magnitude = [lwp_1s lwp_0s];
hwM = magnitude;

% phase stage 1:
hwp1 = linspace(0,0,length);
% phase stage 2:
hwp2 = linspace(0,1,length);
hwp3 = linspace(0,2,length);
hwp4 = linspace(0,-3,length);
hwp5 = linspace(0,-10,length);
% phase stage 3:
wd = 1/4;
length2 = 127;
fir_filter = fir1(length2,wd,'low',hamming(length2+1));
hwp6 = angle(fir_filter); 

% Fast Fourier transform (FFT) is an algorithm that calculates the discrete 
% Fourier transform (DFT) or inverse (IDFT) of a sequence. Fourier analysis 
% converts a signal from its original domain (usually time or space) to 
% a representation in the frequency domain and vice versa (from frequency 
% domain to time or space domain). DFT is obtained by decomposing a set of 
% values into components of different frequencies. This DFT operation is 
% useful in many areas, but it is too slow to be calculated directly from 
% the definition. An FFT quickly calculates such transformations by factoring 
% the DFT matrix into sparse (mostly zero) factors.

figure
plot(arrayLength,hwM); grid on, title("hwM Magnitude")
axis([-0.05 1.05 -0.05 1.05])

figure('Name','Phase Values We Have Given')
subplot(2,3,1)
plot(arrayLength,hwp1)
grid on
title('The Phase We Give: 0')
subplot(2,3,2)
plot(arrayLength,hwp2)
grid on
title("The Phase We Give: Linear 0 to 1")
subplot(2,3,3)
plot(arrayLength,hwp3)
grid on
title("The Phase We Give: Linear 0 to 2")
subplot(2,3,4)
plot(arrayLength,hwp4)
grid on
title("The Phase We Give: Linear 0 to -3")
subplot(2,3,5)
plot(arrayLength,hwp5)
grid on
title("The Phase We Give: Linear 0 to -10")
subplot(2,3,6)
plot(arrayLength,hwp6)
grid on
title("The Phase We Give: obtained phase from fir1")

hw1 = hwM.*exp(i*hwp1);
hw2 = hwM.*exp(i*hwp2);
hw3 = hwM.*exp(i*hwp3);
hw4 = hwM.*exp(i*hwp4);
hw5 = hwM.*exp(i*hwp5);
hw6 = hwM.*exp(i*hwp6);

mag_hw1 = abs(hw1);
phase_hw1 = angle(hw1);
mag_hw2 = abs(hw2);
phase_hw2 = angle(hw2);
mag_hw3 = abs(hw3);
phase_hw3 = angle(hw3);
mag_hw4 = abs(hw4);
phase_hw4 = angle(hw4);
mag_hw5 = abs(hw5);
phase_hw5 = angle(hw5);
mag_hw6 = abs(hw6);
phase_hw6 = angle(hw6);

figure
subplot(3,4,1)
plot(arrayLength,mag_hw1)
grid on; title("hw1"); ylabel("Magnitude");
subplot(3,4,2)
plot(arrayLength,phase_hw1)
grid on; title("hw1"); ylabel("Phase");
subplot(3,4,3)
plot(arrayLength,mag_hw2)
grid on; title("hw2"); ylabel("Magnitude");
subplot(3,4,4)
plot(arrayLength,phase_hw2)
grid on; title("hw2"); ylabel("Phase");
subplot(3,4,5)
plot(arrayLength,mag_hw3)
grid on; title("hw3"); ylabel("Magnitude");
subplot(3,4,6)
plot(arrayLength,phase_hw3)
grid on; title("hw3"); ylabel("Phase");
subplot(3,4,7)
plot(arrayLength,mag_hw4)
grid on; title("hw4"); ylabel("Magnitude");
subplot(3,4,8)
plot(arrayLength,phase_hw4)
grid on; title("hw4");ylabel("Phase");
subplot(3,4,9)
plot(arrayLength,mag_hw5)
grid on; title("hw5"); ylabel("Magnitude");
subplot(3,4,10)
plot(arrayLength,phase_hw5)
grid on; title("hw5"); ylabel("Phase");
subplot(3,4,11)
plot(arrayLength,mag_hw6)
grid on; title("hw6"); ylabel("Magnitude");
subplot(3,4,12)
plot(arrayLength,phase_hw6)
grid on; title("hw6"); ylabel("Phase");

figure
freqz(hw1,1,128);
title("hw1 frequency response - normalized")
figure
freqz(hw2,1,128);
title("hw2 frequency response - normalized")
figure
freqz(hw3,1,128);
title("hw3 frequency response - normalized")
figure
freqz(hw4,1,128);
title("hw4 frequency response - normalized")
figure
freqz(hw5,1,128);
title("hw5 frequency response - normalized")
figure
freqz(hw6,1,128);
title("hw6 frequency response - normalized")

hn1 = ifft(hw1);
hn2 = ifft(hw2);
hn3 = ifft(hw3);
hn4 = ifft(hw4);
hn5 = ifft(hw5);
hn6 = ifft(hw6);

figure
freqz(hn1)
title("hn1 frequency response - normalized")
figure
freqz(hn2)
title("hn2 frequency response - normalized")
figure
freqz(hn3)
title("hn3 frequency response - normalized")
figure
freqz(hn4)
title("hn4 frequency response - normalized")
figure
freqz(hn5)
title("hn5 frequency response - normalized")
figure
freqz(hn6)
title("hn6 frequency response - normalized")

mag1 = abs(hn1);
phase1 = angle(hn1);
mag2 = abs(hn2);
phase2 = angle(hn2);
mag3 = abs(hn3);
phase3 = angle(hn3);
mag4 = abs(hn4);
phase4 = angle(hn4);
mag5 = abs(hn5);
phase5 = angle(hn5);
mag6 = abs(hn6);
phase6 = angle(hn6);

figure
subplot(3,4,1)
plot(arrayLength,mag1)
grid on; title("hn1 = ifft(hw1) Magnitude"); xlabel("n = 128 sample"); ylabel("Magnitude");
subplot(3,4,2)
plot(arrayLength,phase1)
grid on; title("hn1 = ifft(hw1) Phase"); xlabel("n = 128 sample"); ylabel("Phase");
subplot(3,4,3)
plot(arrayLength,mag2)
grid on; title("hn2 = ifft(hw2) Magnitude"); xlabel("n = 128 sample"); ylabel("Magnitude");
subplot(3,4,4)
plot(arrayLength,phase2)
grid on; title("hn2 = ifft(hw2) Phase"); xlabel("n = 128 sample"); ylabel("Phase");
subplot(3,4,5)
plot(arrayLength,mag3)
grid on; title("hn3 = ifft(hw3) Magnitude"); xlabel("n = 128 sample"); ylabel("Magnitude");
subplot(3,4,6)
plot(arrayLength,phase3)
grid on; title("hn3 = ifft(hw3) Phase"); xlabel("n = 128 sample"); ylabel("Phase");
subplot(3,4,7)
plot(arrayLength,mag4)
grid on; title("hn4 = ifft(hw4) Magnitude"); xlabel("n = 128 sample"); ylabel("Magnitude");
subplot(3,4,8)
plot(arrayLength,phase4)
grid on; title("hn4 = ifft(hw4) Phase"); xlabel("n = 128 sample"); ylabel("Phase");
subplot(3,4,9)
plot(arrayLength,mag5)
grid on; title("hn5 = ifft(hw5) Magnitude"); xlabel("n = 128 sample"); ylabel("Magnitude");
subplot(3,4,10)
plot(arrayLength,phase5)
grid on; title("hn5 = ifft(hw5) Phase"); xlabel("n = 128 sample"); ylabel("Phase");
subplot(3,4,11)
plot(arrayLength,mag6)
grid on; title("hn6 = ifft(hw6) Magnitude"); xlabel("n = 128 sample"); ylabel("Magnitude");
subplot(3,4,12)
plot(arrayLength,phase6)
grid on; title("hn6 = ifft(hw6) Phase"); xlabel("n = 128 sample"); ylabel("Phase");

% As we observed here, we see that when the frequency is normalized, our π/4 
% value cuts off, as we have observed, in the values we have given with 
% the arrays and the frequency response resulting from the cutoff value 
% we are considering.
% When different phase values are given, when we look at our frequency response 
% as a result of Inverse Fast Fourier Transform, it is observed that the ripple 
% values change in the “passband” region of our lowpass filter for each 
% different phase value, and it is seen that these values decrease as the 
% phase gets larger.
