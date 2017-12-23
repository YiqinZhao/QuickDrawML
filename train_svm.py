# -- coding: utf-8 --
# Problem 8, Python code
# 1530200066 赵一勤
# SVM 分类代码
import h5py
import numpy as np
from sklearn.svm import SVC
from sklearn.multiclass import OneVsRestClassifier
from sklearn.multiclass import OutputCodeClassifier

# 读取数据
f = h5py.File('./pca_data.mat', 'r')
data = {}
for k in f.keys():
    data[k] = f[k][:]

test_data = data['test_data'].transpose()
test_label = np.ravel(data['test_label'].transpose())
train_data = data['train_data'].transpose()
train_label = np.ravel(data['train_label'].transpose())

# 开始训练
clf = OutputCodeClassifier(SVC(kernel='rbf'))
model = clf.fit(train_data, train_label)
train_acc = model.score(train_data, train_label)
test_acc = model.score(test_data, test_label)

# 输出训练和测试正确率
print('[Train accuracy]: %s, [Test accuracy]: %s' %(train_acc, test_acc))
