function xfeature = timeFeatures_LAB(x)

% return time-domain deatures of vector x
% input:    x, 1-d vector
% output:   x Feature, table show

xfeature = table;
N=length(x);

%STD
xfeature.std=std(x);

%RMS
xfeature.rms=rms(x);
% xrms = sqrt(sum(x.^2)/N);

% Square Root Average (SRA)
xfeature.sra=(sum(sqrt(abs(x)))/N)^2;

% Kurtosis
xfeature.kv=kurtosis(x);

% Skewness
xfeature.sv=skewness(x);

% Peak2Peak
xfeature.ppv=peak2peak(x);

% Crest Factor
xfeature.cf=max(abs(x))/xfeature.rms;

% Impulse Factor
xfeature.if=max(abs(x))/(sum(abs(x))/N);

% Marginal(Clearance) Factor 
xfeature.mf=max(abs(x))/xfeature.sra;

% Shape Factor
xfeature.sf=xfeature.rms/(sum(abs(x))/N);
% kf
xfeature.kf=kurtosis(x)/(sum(x.^2)/N).^2;

end