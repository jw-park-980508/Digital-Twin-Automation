function xfeature = timeFeatures_LAB(x)

% return time-domain deatures of vector x
% input:    x, 1-d vector
% output:   x Feature, table show

xfeature = table;
N=length(x);


% RMSd
xfeature.rms=rms(x);

% Square Root Average (SRA)s
xfeature.sra= (sum(sqrt(abs(x)))/N)^2;
%xfeature.sra= xfeature.rms / xfeature.mean;

% Skewness
xfeature.sk=skewness(x);

% Kurtosis
xfeature.kt=kurtosis(x);

% Average of Absolute Value
aav=sum(abs(x))/N;

% Peak
peak= max(abs(x));

% Peak2Peak
xfeature.ppv=peak2peak(x);

% Impulse Factor
xfeature.if= peak/aav;

% Shape Factor
xfeature.sf=xfeature.rms/aav;

% Crest Factor
xfeature.cf= peak / xfeature.rms;

% Marginal(Clearance) Factor
xfeature.mf= peak/xfeature.sra;

% Kurtosis Factor
xfeature.kf = xfeature.kt / (xfeature.rms)^4;


end
