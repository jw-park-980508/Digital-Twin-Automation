function P1=getFFT(x,L)
%%% Apply FFT of x
%
% return chaged by FFT signal
% input:    x, signal length
% output:   FFT signal

Y=fft(x,L);   

%%% Compute the two-sided sspectrum P2
% Then compute the single-sided spectrum P1 based on P2 and the even-valued signal length L
%P1 =Y;
P2 = abs(Y/L);              %normalization
P1 = P2(1:L/2+1);           %양의 값만 보는것
P1(1:end-1)= 2*P1(1:end-1); 


end

