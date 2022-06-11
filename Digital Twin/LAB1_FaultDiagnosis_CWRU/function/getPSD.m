function psdx2 = getPSD(x,L,Fs)

Y = fft(x,L);
P2 = abs(Y);    % Not normalized by L as fft
psdx = (1/(Fs*L))*P2(1:L/2+1).^2;  % Power normalized by L and Fs
                                    %제곱하고 나누어줌
psdx(2:end-1) = 2*psdx(2:end-1);
f = 0:Fs/L:Fs/2;
psdx2 = psdx;

end

