%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Muhammed Enes Yılmaz                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear
clc

[signal,Fs] = audioread('Kayıt.m4a');
% signal: sound data , Fs: sampling
signal = signal(:, 1); % take first channel
N = length(signal);    % signal length
to = (0:N-1)/Fs;       % time vector

% signal will be an m x n matrix. Where m is the number of audio samples 
% read and n is the number of audio channels in the file. So if n is greater 
% than one, it means we have more than one channel.

figure
plot(to, signal, 'r')
xlim([0 max(to)])
ylim([-1.1*max(abs(signal)) 1.1*max(abs(signal))])
grid on
xlabel('Time, s')
ylabel('Amplitude, V')
title('Spoken in Sound: Muhammed Enes Yılmaz')

% When using the fft function to transform the signal into the frequency domain, 
% we first define a new input length. This will pad the X signal with trailing 
% zeros to improve fft's performance.
newLengthFFT = 2^nextpow2(N); % exponent of the next power of 2
spect = fft(signal,newLengthFFT)/N;
f = Fs/2*linspace(0,1,(newLengthFFT/2)+1);

spect2 = fft(signal);
spectABS = abs(spect2);

quest = 'Plot the spectrum of the signal?';
dlgtitle = 'Choice';
btn1 = 'FFT Magnitude Two Side';
btn2 = 'FFT Single Side';
defbtn = btn1;
answer = questdlg(quest, dlgtitle, btn1, btn2, defbtn);
switch answer
    case btn1
        figure
        plot(spectABS)
        grid on
        title("Signal FFT Received")
                                 
    case btn2
        figure
        plot(f,2*abs(spect(1:(newLengthFFT/2)+1)))
        grid on; xlabel('f(Hz)'); ylabel('|Signal(f)|')
        title('Single Sided Amplitude Spectrum of Signal')
end

% Periodogram power spectral density estimate
figure
periodogram(signal,[],N)

msgbox({"We saw the highest value of the frequency of our signal in the spectrum as 258.23 Hz.";
    'In this case, the cutoff frequency we will choose (fmax/2): 129.115 Hz'},'Informing','help')

cutoff_index = sprintf('Normalize CutOff Value = ((129.115)*2)/44100 = 0.0059 rad/sample')

% For TransitionSample = 0.5
filter1 = FilterFIR(Fs/2,0.5);
figure
freqz(filter1,1,N)
title('FSTechnique FIR Filter 1 T=0.5, fc = 0.0059 rad/sample');

% Filtering Sound with a Filter
filteredSound1 = conv(signal,filter1);
N2 = length(filteredSound1);
tFiltered = (0:N2-1)/Fs; % filtered time vector
figure
plot(tFiltered,filteredSound1)
xlim([0 max(tFiltered)])
ylim([-1.1*max(abs(filteredSound1)) 1.1*max(abs(filteredSound1))])
title('Time Domain Image of Filtered Sound with Filter 1')
xlabel('Time, s'); ylabel('Amplitude, V');
grid on

newLengthFFT2 = 2^nextpow2(N2);
fFiltered = Fs/2*linspace(0,1,newLengthFFT2/2+1);

% Frequency Spectrum Analysis of Filtered Sound with Filter 1
signalFiltered1 = fft(filteredSound1,newLengthFFT2)/Fs;
figure
plot(fFiltered,2*abs(signalFiltered1(1:newLengthFFT2/2+1)))
title('Frequency Spectrum View of the Sound Filtered by Filter 1')
xlabel('f(Hz)'); ylabel('|Signal(f)|');
grid on

% For TransitionSample = 0.38
filter2 = FilterFIR(Fs/2,0.38);
figure
freqz(filter2,1,N)
title('FSTechnique FIR Filter 2 T=0.38, fc = 0.0059 rad/sample');

% Filtering Sound with a Filter
filteredSound2 = conv(signal,filter2);
figure
plot(tFiltered,filteredSound2)
xlim([0 max(tFiltered)])
ylim([-1.1*max(abs(filteredSound2)) 1.1*max(abs(filteredSound2))])
title('Time Domain View of Filtered Sound with Filter 2')
xlabel('Time, s'); ylabel('Amplitude, V');
grid on

% Frequency Spectrum Analysis of Filtered Sound with Filter 2
signalFiltered2 = fft(filteredSound2,newLengthFFT2)/Fs;
figure
plot(fFiltered,2*abs(signalFiltered2(1:newLengthFFT2/2+1)))
title('Frequency Spectrum View of the Sound Filtered by Filter 2')
xlabel('f(Hz)'); ylabel('|Signal(f)|');
grid on

% For TransitionSample = 0.45
filter3 = FilterFIR(Fs/2,0.45);
figure
freqz(filter3,1,N)
title('FSTechnique FIR Filter 3 T=0.45, fc = 0.0059 rad/sample');

% Filtering Sound with a Filter
filteredSound3 = conv(signal,filter3);
figure
plot(tFiltered,filteredSound3)
xlim([0 max(tFiltered)])
ylim([-1.1*max(abs(filteredSound3)) 1.1*max(abs(filteredSound3))])
title('Time Domain View of Filtered Sound with Filter 3')
xlabel('Time, s'); ylabel('Amplitude, V');
grid on

% Frequency Spectrum Analysis of Filtered Sound with Filter 3
signalFiltered3 = fft(filteredSound3,newLengthFFT2)/Fs;
figure
plot(fFiltered,2*abs(signalFiltered3(1:newLengthFFT2/2+1)))
title('Frequency Spectrum View of the Sound Filtered by Filter 3')
xlabel('f(Hz)'); ylabel('|Signal(f)|');
grid on

% For TransitionSample = 0.4 
filter4 = FilterFIR(Fs/2,0.4);
figure
freqz(filter4,1,N)
title('FSTechnique FIR Filter 4 T=0.4, fc = 0.0059 rad/sample');

% Filtering Sound with a Filter
filteredSound4 = conv(signal,filter4);
figure
plot(tFiltered,filteredSound4)
xlim([0 max(tFiltered)])
ylim([-1.1*max(abs(filteredSound4)) 1.1*max(abs(filteredSound4))])
title('Time Domain View of Filtered Sound with Filter 4')
xlabel('Time, s'); ylabel('Amplitude, V');
grid on

% Frequency Spectrum Analysis of Filtered Sound with Filter 4
signalFiltered4 = fft(filteredSound4,newLengthFFT2)/Fs;
figure
plot(fFiltered,2*abs(signalFiltered4(1:newLengthFFT2/2+1)))
title('Frequency Spectrum View of the Sound Filtered by Filter 4')
xlabel('f(Hz)'); ylabel('|Signal(f)|');
grid on

% For TransitionSample = 0.3 
filter5 = FilterFIR(Fs/2,0.3);
figure
freqz(filter5,1,N)
title('FSTechnique FIR Filter 5 T=0.3, fc = 0.0059 rad/sample');

% Filtering Sound with a Filter
filteredSound5 = conv(signal,filter5);
figure
plot(tFiltered,filteredSound5)
xlim([0 max(tFiltered)])
ylim([-1.1*max(abs(filteredSound5)) 1.1*max(abs(filteredSound5))])
title('Time Domain View of Filtered Sound with Filter 5')
xlabel('Time, s'); ylabel('Amplitude, V');
grid on

% Frequency Spectrum Analysis of Filtered Sound with Filter 5
signalFiltered5 = fft(filteredSound5,newLengthFFT2)/Fs;
figure
plot(fFiltered,2*abs(signalFiltered5(1:newLengthFFT2/2+1)))
title('Frequency Spectrum View of the Sound Filtered by Filter 5')
xlabel('f(Hz)'); ylabel('|Signal(f)|');
grid on
