% Sanjeev Khemani
% Machine Learning
% Project 4
% KSU Fall 2021 

unzip('DS_IDRID.zip');

imdsTrainNonDR = imageDatastore('DS_IDRID/Train/*-0.jpg');
num = numel(imdsTrainNonDR.Files)
[temp{1:num}] = deal('Non-DR');
temp = categorical(temp);
imdsTrainNonDR.Labels = temp;
clear('temp');
clear ('num');
imdsTrainDR1 = imageDatastore('DS_IDRID/Train/*-3.jpg');
num = numel(imdsTrainDR1.Files)
[temp{1:num}] = deal('DR');
temp = categorical(temp);
imdsTrainDR1.Labels = temp;
clear('temp');
clear ('num');
imdsTrainDR2 = imageDatastore('DS_IDRID/Train/*-4.jpg');
num = numel(imdsTrainDR2.Files)
[temp{1:num}] = deal('DR');
temp = categorical(temp);
imdsTrainDR2.Labels = temp;
clear('temp');
clear ('num');
imdsTrain = imageDatastore(cat(1, imdsTrainNonDR.Files, imdsTrainDR1.Files, imdsTrainDR2.Files));
imdsTrain.Labels = cat(1, imdsTrainNonDR.Labels, imdsTrainDR1.Labels, imdsTrainDR2.Labels);
imdsTrain = imdsTrain.shuffle();

imdsTestNonDR = imageDatastore('DS_IDRID/Test/*-0.jpg');
num = numel(imdsTestNonDR.Files)
[temp{1:num}] = deal('Non-DR');
temp = categorical(temp);
imdsTestNonDR.Labels = temp;
clear('temp');
clear ('num');
imdsTestDR1 = imageDatastore('DS_IDRID/Test/*-3.jpg');
num = numel(imdsTestDR1.Files)
[temp{1:num}] = deal('DR');
temp = categorical(temp);
imdsTestDR1.Labels = temp;
clear('temp');
clear ('num');
imdsTestDR2 = imageDatastore('DS_IDRID/Test/*-4.jpg');
num = numel(imdsTestDR2.Files)
[temp{1:num}] = deal('DR');
temp = categorical(temp);
imdsTestDR2.Labels = temp;
clear('temp');
clear ('num');
imdsValidation = imageDatastore(cat(1, imdsTestNonDR.Files, imdsTestDR1.Files, imdsTestDR2.Files));
imdsValidation.Labels = cat(1, imdsTestNonDR.Labels, imdsTestDR1.Labels, imdsTestDR2.Labels);
imdsValidation = imdsValidation.shuffle();

DRnet = alexnet;
analyzeNetwork(DRnet)

inputSize = DRnet.Layers(1).InputSize;
layersTransfer = DRnet.Layers(1:end-3);
numClasses = numel(categories(imdsTrain.Labels));
layers = [
    layersTransfer
    fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
    softmaxLayer
    classificationLayer];

pixelRange = [-30 30];
imageAugmenter = imageDataAugmenter( ...
    'RandXReflection',true, ...
    'RandXTranslation',pixelRange, ...
    'RandYTranslation',pixelRange);
augimdsTrain = augmentedImageDatastore(inputSize(1:2),imdsTrain, ...
    'DataAugmentation',imageAugmenter);

augimdsValidation = augmentedImageDatastore(inputSize(1:2),imdsValidation);

options = trainingOptions('sgdm', ...
    'MiniBatchSize',10, ...
    'MaxEpochs',6, ...
    'InitialLearnRate',1e-4, ...
    'Shuffle','every-epoch', ...
    'ValidationData',augimdsValidation, ...
    'ValidationFrequency',5, ...
    'Verbose',false, ...
    'Plots','training-progress');

netTransfer = trainNetwork(augimdsTrain,layers,options);

[YPred,scores] = classify(netTransfer,augimdsValidation);
YValidation = imdsValidation.Labels;
validationAccuracy = mean(YPred == YValidation)
plotconfusion(YValidation,YPred)

%-------------------------------------------------------------
%DECAP

%[XPred,scores] = classify(netTransfer,augimdsTrain);
%YTrain = imdsTrain.Labels;
%TrainAccuracy = mean(XPred == YTrain)
%plotconfusion(YTrain,XPred)

% Train = dir("DS_IDRID\Train")
% filenames = {Train.name};
% for i = 1:numel(filenames)
%     filename = filenames{i};
%        filename
%     if filename == "*-2.jpg"
%         filenames.remove("filename");
%     elseif filename == "*-1.jpg"
%         filenames.remove("filename");
%     end
% end
% 
% Train = dir("DS_IDRID\Train")
%imDR = dir('DS_IDRID/**/**-0.jpg');
%imnonDR = dir('DS_IDRID/*/*-0.jpg') || dir('DS_IDRID/*/*-4.jpg') || dir('DS_IDRID/*/*-3.jpg');

% imds = imageDatastore(cat(1, imdsTrain.Files, imdsValidation.Files));
% imds.Labels = cat(1, imdsTrain.Labels, imdsValidation.Labels);
% [imdsValidation, imdsTrain] = splitEachLabel(imds, 0.2);