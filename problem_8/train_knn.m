% Problem 8, MATLAB code
% 1530200066 赵一勤
% ================================
% 本程序通过对 Google Quick Draw 数据集进行处理，实现降维、可视化、分类

clear;
load('quick-draw.mat');

% 采样，每个类别采样 1000 条数据，方便调试，连接数据构造矩阵
concat = im2double([apple(1:1000,:);banana(1:1000,:);
                    blueberry(1:1000,:);pineapple(1:1000,:);
                    strawberry(1:1000,:)]);
% 构造标签
labels = [ones(1000,1);ones(1000,1) * 2;ones(1000,1) * 3;
          ones(1000,1) * 4;ones(1000,1) * 5;];

% PCA 处理
[coeff, score, latent, tsquare] = pca(concat);
% 计算各个维度特征贡献百分比
contribute = cumsum(latent)./sum(latent);
% 提取前 270 纬特征
pca_data = score(:,1:270);

% t-SNE 降纬，可视化
% 注：t-SNE 函数来自 drtoolbox 开源工具箱代码
mappedX = tsne(pca_data,labels,2);

% 准备训练和测试数据
data = [pca_data labels];
shuffle = data(randperm(size(data, 1)),:);

train_data = shuffle(1:4500,1:270);
train_label = shuffle(1:4500,271);
test_data = shuffle(4501:5000,1:270);
test_label = shuffle(4501:5000,271);

%% kNN 分类
% 训练 kNN 分类器
knn_mdl = fitcknn(train_data,train_label,'NumNeighbors',5);
% 输出训练 loss
knn_mdl_cv = crossval(knn_mdl);
knn_kloss = kfoldLoss(knn_mdl_cv)

knn_predict = predict(knn_mdl,test_data);
knn_result = 0;
for i=1:500
    if knn_predict(i) == test_label(i)
        knn_result = knn_result + 1;
    end
end

% kNN 分类正确率
knn_acc = knn_result / 500

%% SVM 分类
% 训练 SVM 分类器
svm_mdl = fitcecoc(train_data,train_label);
% 训练正确率
svm_mdl_cv = crossval(svm_mdl);
svm_kloss = kfoldLoss(svm_mdl_cv)

svm_predict = predict(svm_mdl,test_data);
svm_result = 0;
for i=1:500
    if svm_predict(i) == test_label(i)
        svm_result = svm_result + 1;
    end
end
svm_acc = svm_result / 500


