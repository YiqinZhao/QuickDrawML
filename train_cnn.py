# -- coding: utf-8 --
# Problem 8, Python code
# 1530200066 赵一勤
# CNN 分类代码
import h5py
from keras.models import Sequential
from keras.layers import Conv2D, Dense, MaxPooling2D, Flatten, Dropout
from keras.utils import to_categorical

# 读取数据
f = h5py.File('./raw_data.mat', 'r')
data = {}
for k in f.keys():
    data[k] = f[k][:]

test_data = data['test_data'].transpose().reshape(500, 28, 28, 1)
test_label = to_categorical(data['test_label'].transpose() - 1, 5)
train_data = data['train_data'].transpose().reshape(4500, 28, 28, 1)
train_label = to_categorical(data['train_label'].transpose() - 1, 5)

# 构建神经网络
model = Sequential()
model.add(Conv2D(32, kernel_size=(3, 3), input_shape=(28, 28, 1), activation='relu'))
model.add(MaxPooling2D(pool_size=(2, 2)))
model.add(Conv2D(32, kernel_size=(3, 3)))
model.add(MaxPooling2D(pool_size=(2, 2)))
model.add(Flatten())
model.add(Dropout(0.5))
model.add(Dense(100, activation='relu'))
model.add(Dense(5, activation='softmax'))
model.compile(loss='categorical_crossentropy', optimizer='RMSprop',
              metrics=['accuracy'])
model.summary()

model.fit(train_data, train_label, epochs=20, batch_size=50,
          validation_data=(test_data, test_label), verbose=1)
