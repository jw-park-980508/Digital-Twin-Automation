function L_SVM = SVM(Train,Train_class,Test,Test_class)
%UNTITLED3 이 함수의 요약 설명 위치
%   자세한 설명 위치
rng(10); % For reproducibility

%-----------------------SVM Train-------------------------%
%t = templateSVM('Standardize',true,'SaveSupportVectors',true);
% SVM = fitcecoc(Train,cellstr(Train_class),'Learners',t,...
%     'ClassNames',unique(Train_class(:,1)));
SVM = fitcecoc(Train,cellstr(Train_class), ...
    'ClassNames',unique(Train_class(:,1)));
%-----------------Training loss(All data set)-------------%
ResubErr_SVM = resubLoss(SVM)
rng(0); % For reproducibility

%-----------------Cross-validation (k-fold)---------------%
cv_SVM = cvpartition(cellstr(Train_class),'KFold',3);
cvMdl_SVM = crossval(SVM,'CVPartition',cv_SVM); 
cvErr_SVM = kfoldLoss(cvMdl_SVM)

%--------------------Predict test data--------------------%
testPred_SVM = predict(SVM,Test);
trainPred_SVM = predict(SVM,Train);
%---------------Calculate the loss  of Test---------------%
L_SVM = loss(SVM, Test, Test_class);

%------------Plot  Confusion matrix of Test data----------%
figure
subplot(1,2,1)
confusionchart(cellstr(Train_class),trainPred_SVM)
title('Confusion matrix of train data');

subplot(1,2,2)
confusionchart(cellstr(Test_class),testPred_SVM)
title('Confusion matrix of test data');
end

