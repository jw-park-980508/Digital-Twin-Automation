function xfeature2 = freqFeatures(P)
%frequency Feature return
% x:        Input data
% xfeature: Table for feature of x


% Create table variable xfeature
xfeature2 = table;

xfeature2.fc= mean(P);

xfeature2.rmsf = rms(P);

xfeature2.rvf = rms(P-xfeature2.fc);
end

