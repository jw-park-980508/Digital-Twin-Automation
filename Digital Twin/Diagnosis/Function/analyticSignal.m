function z = analyticSignal(x)
% x is a real-valued record of length N, where N is even %returns the analytic signal z[n]
% input: signal
% output: 

x = x(:); %serialize
N = length(x);

%%% YOUR CODE GOES HERE
% FFT of x
X = fft(x,N);    %YOUR CODE

% Create P[m]=Z[m]  from m=1 to N
P = [X(1); 2*X(2:N/2); X(N/2 + 1); zeros(N/2-1,1)];  %YOUR CODE

% Create z(t)=Zr+j(Zi) from ifft(P)
z =ifft(P,N);       %YOUR CODE

% Envelope extraction
%inst_amplitude = abs(z); 


end

