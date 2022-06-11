function L_KNN = KNN(Train,Train_class,Test,Test_class)
%UNTITLED2 이 함수의 요약 설명 위치
%   자세한 설명 위치
rng(10); % For reproducibility

%-----------------------KNN Train-------------------------%
KNN = fitcknn(Train,Train_class,'NumNeighbors',1,'Standardize',1);

%-----------------Training loss(All data set)-------------%
ResubErr_KNN = resubLoss(KNN)

rng(0); % For reproducibility

%-----------------Cross-validation (k-fold)---------------%
cv_KNN = cvpartition(Train_class,'KFold',3);
cvMdl_KNN = crossval(KNN,'CVPartition',cv_KNN);
cvErr_KNN = kfoldLoss(cvMdl_KNN)  

%--------------------Predict test data--------------------%
trainPred_KNN = predict(KNN,Train);
testPred_KNN = predict(KNN,Test);

%---------------Calculate the loss  of Test---------------%
L_KNN =loss(KNN, Test, Test_class);

%------------Plot  Confusion matrix of Test data----------%
figure
subplot(1,2,1)
confusionchart(cellstr(Train_class),trainPred_KNN)
title('Confusion matrix of train data');

subplot(1,2,2)
confusionchart(cellstr(Test_class),testPred_KNN)
title('Confusion matrix of test data');
%end

