%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Muhammed Enes Yılmaz                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear
clc

% In applications that use filters to shape the frequency spectrum of a signal, 
% such as in communications or control systems, the shape or width of the roll-off, 
% also called the "passband" for a simple first-order filter, can be very long or wide. 
% Therefore, active filters designed with more than one "degree" are required. 
% Such filters are commonly known as "High order" or "nth order" filters.
% The complexity, or type of filter, is defined by the "order" of the filters, 
% and this depends on the number of reactive components in its design, such as 
% capacitors or inductors. We know that the rate of roll-off, and therefore 
% the width of the passband, depends on the degree value of the filter and 
% has a standard roll-off rate of 20dB/decimal or 6dB/octave for a simple 
% first-order filter. High-order filters, such as third, fourth, and fifth orders, 
% are usually created by cascades of single first-order and second-order filters together.

f = 1:0.01:12;
% cutoff frequencies;
fc1 = 2;
fc2 = 3;
fc3 = 5;
% order's;
N1 = 3;
N2 = 6;
N3 = 12;
% Hc(jOmega) = sqrt(1 / (1 + (omega/omegaC)^2N))
Hc1_1 = 1 ./ sqrt(1 + ((f ./ fc1).^(2.*N1)));
Hc1_2 = 1 ./ sqrt(1 + ((f ./ fc1).^(2.*N2)));
Hc1_3 = 1 ./ sqrt(1 + ((f ./ fc1).^(2.*N3)));

Hc2_1 = 1 ./ sqrt(1 + ((f ./ fc2).^(2.*N1)));
Hc2_2 = 1 ./ sqrt(1 + ((f ./ fc2).^(2.*N2)));
Hc2_3 = 1 ./ sqrt(1 + ((f ./ fc2).^(2.*N3)));

Hc3_1 = 1 ./ sqrt(1 + ((f ./ fc3).^(2.*N1)));
Hc3_2 = 1 ./ sqrt(1 + ((f ./ fc3).^(2.*N2)));
Hc3_3 = 1 ./ sqrt(1 + ((f ./ fc3).^(2.*N3)));

% Magnitudes of TF's;
mag1_1 = abs(Hc1_1);
mag1_2 = abs(Hc1_2);
mag1_3 = abs(Hc1_3);

mag2_1 = abs(Hc2_1);
mag2_2 = abs(Hc2_2);
mag2_3 = abs(Hc2_3);

mag3_1 = abs(Hc3_1);
mag3_2 = abs(Hc3_2);
mag3_3 = abs(Hc3_3);

% Decibel equivalents of Magnitudes;
db1_1 = mag2db(mag1_1);
db1_2 = mag2db(mag1_2);
db1_3 = mag2db(mag1_3);

db2_1 = mag2db(mag2_1);
db2_2 = mag2db(mag2_2);
db2_3 = mag2db(mag2_3);

db3_1 = mag2db(mag3_1);
db3_2 = mag2db(mag3_2);
db3_3 = mag2db(mag3_3);

% The frequency response of the Butterworth Filter approximation function is 
% also often referred to as the "maximum flat" (no ripple) response because 
% the passband will have a frequency response that is as flat as mathematically 
% possible from 0Hz (DC) to the cutoff frequency with no ripple at -3dB 
% designed in such a way. Higher frequencies beyond the cut-off point drop 
% to zero at 20dB/decade or 6dB/octave in the stopband. This is because it 
% has a "quality factor" of only 0.707, a "Q" value.

% The Butterworth filter provides the best Taylor series approximation to 
% the ideal low-pass filter response at analog frequencies Ω = 0 and Ω = ∞.

figure
subplot(1,2,1)
plot(f,mag1_1)
hold on
plot(f,mag1_2)
hold on
plot(f,mag1_3)
hold on
legend('3rd order & cutoff freq 2','6th order & cutoff freq 2','12th order & cutoff freq 2')
xlabel('Frequency')
ylabel('Magnitude')
grid on
subplot(1,2,2)
semilogx(f,db1_1)
hold on
semilogx(f,db1_2)
hold on
semilogx(f,db1_3)
hold on
legend({'3rd order & cutoff freq 2','6th order & cutoff freq 2','12th order & cutoff freq 2'},'Location','southwest')
xlabel('Frequency')
ylabel('Magnitude in dB')
grid on

figure
subplot(1,2,1)
plot(f,mag2_1)
hold on
plot(f,mag2_2)
hold on
plot(f,mag2_3)
hold on
legend('3rd order & cutoff freq 3','6th order & cutoff freq 3','12th order & cutoff freq 3')
xlabel('Frequency')
ylabel('Magnitude')
grid on
subplot(1,2,2)
semilogx(f,db2_1)
hold on
semilogx(f,db2_2)
hold on
semilogx(f,db2_3)
hold on
legend({'3rd order & cutoff freq 3','6th order & cutoff freq 3','12th order & cutoff freq 3'},'Location','southwest')
xlabel('Frequency')
ylabel('Magnitude in dB')
grid on

figure
subplot(1,2,1)
plot(f,mag3_1)
hold on
plot(f,mag3_2)
hold on
plot(f,mag3_3)
hold on
legend('3rd order & cutoff freq 5','6th order & cutoff freq 5','12th order & cutoff freq 5')
xlabel('Frequency')
ylabel('Magnitude')
grid on
subplot(1,2,2)
semilogx(f,db3_1)
hold on
semilogx(f,db3_2)
hold on
semilogx(f,db3_3)
hold on
legend({'3rd order & cutoff freq 5','6th order & cutoff freq 5','12th order & cutoff freq 5'},'Location','southwest')
xlabel('Frequency')
ylabel('Magnitude in dB')
grid on

% If we continue from the pole locations given in the homework example:
% Hc(s)*Hc(-s) = 1 / (1 + (s/jOmegc)^2N)
omegC = 1;
N4 = 4;
N5 = 5;
% given in the example; transfer function multiplied by its own complex conjugate:
s = tf('s');
HcHcc_1 = 1 / (1 + ((s/(i*omegC))^(2*N4)));
HcHcc_2 = 1 / (1 + ((s/(i*omegC))^(2*N5)));
[P1, Z1] = pzmap(HcHcc_1);
[P2, Z2] = pzmap(HcHcc_2);
Hc4_without_zeros = zpk(P1,[],1); %zero pole gain
Hc5_without_zeros = zpk(P2,[],1);

figure
subplot(1,2,1)
zplane([],P1)
grid on, legend('zeros','poles','unit circle')
title('Pole Positions for N=4 in Unit Circle');
subplot(1,2,2)
zplane([],P2)
grid on, legend('zeros','poles','unit circle')
title('Pole Positions for N=5 in Unit Circle');


%% HW Part 2
% N = 2(second order) The cutoff frequency transfer function for a system:
% Hc(s) = 1 / (s^2 + sqrt(2)*s + 1);
HcGiven = tf([1], [1 sqrt(2) 1]);
figure
[Psecond, Zsecond] = pzmap(HcGiven);
zplane(Zsecond,Psecond)
grid on, legend('zeros','poles','unit circle')
title('Pole and Zeros of the Second Order System Given in the Example')
figure
bode(HcGiven)
grid on
title('Hc(s)(given) Cutoff Transfer Function Bode Diagram')
