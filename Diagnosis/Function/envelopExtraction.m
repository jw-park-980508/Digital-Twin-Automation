function amplitude = envelopExtraction(x)
%   input: time domain - signal
%   output: envelopExtraction

%   a(t) 즉, envelope 함수를 return
    z = hilbert(x);
    amplitude = abs(z);

end

