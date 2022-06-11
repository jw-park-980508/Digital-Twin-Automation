function [Train, Train_class, Test, Test_class] = Train_Test(table)
%UNTITLED5 이 함수의 요약 설명 위치
%   자세한 설명 위치
env_N = length(table.Class);

rng('default');
env_partition = cvpartition(env_N,'Holdout',0.3);

idxTrain = training(env_partition);
Train_class = table.Class(idxTrain,:);
Train = table(idxTrain,:);

Train(:,end) = [];

idxTest = test(env_partition);
Test_class = table.Class(idxTest,:);
Test = table(idxTest,:);
end

