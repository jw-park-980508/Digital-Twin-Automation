function L_Tree = Decision_Tree(Train,Train_class,Test,Test_class)
%UNTITLED4 이 함수의 요약 설명 위치
%   자세한 설명 위치
rng(10); % For reproducibility

%------------------Decision Tree Train--------------------%
Tree = fitctree(Train, Train_class);

%-----------------Training loss(All data set)-------------%
ResubErr_Tree = resubLoss(Tree)

rng(0); % For reproducibility

%-----------------Cross-validation (k-fold)---------------%
cv_Tree = cvpartition(Train_class,'KFold',3);
cvMdl_Tree = crossval(Tree,'CVPartition',cv_Tree); 
cvErr_Tree = kfoldLoss(cvMdl_Tree)

%--------------------Predict test data--------------------%
testPred_Tree = predict(Tree,Test);
trainPred_Tree = predict(Tree,Train);

%---------------Calculate the loss  of Test---------------%
L_Tree = loss(Tree, Test, Test_class);
%------------Plot  Confusion matrix of Test data----------%
figure

subplot(1,2,1)
confusionchart(cellstr(Train_class),trainPred_Tree)
title('Confusion matrix of train data');

subplot(1,2,2)
confusionchart(cellstr(Test_class),testPred_Tree)
title('Confusion matrix of test data');
end

