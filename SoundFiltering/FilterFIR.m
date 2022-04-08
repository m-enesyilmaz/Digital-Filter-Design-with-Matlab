function hn = FilterFIR(N,transition)
% FIR Filter with Cutoff = 129.115 Hz

% N = 22050; % Sample
% Normalize CutOff value = ((129.115)*2)/44100 = 0.0059 rad/sample
% So 59 elements with a length of 11025 magnitude are 1.
alpha = (N-1)/2;
ones = linspace(1,1,59);
onesMissingOne = linspace(1,1,58);
zeros = linspace(0,0,21931);
Hmag = [ones,transition,zeros,transition,onesMissingOne];

k1 = 0:floor((N-1)/2); 
k2 = floor((N-1)/2)+1:N-1;

hPhase = [-alpha*(2*pi)/N*k1, alpha*(2*pi)/N*(N-k2)];
H = Hmag.*exp(i*hPhase); 
hn = real(ifft(H,N));
end
