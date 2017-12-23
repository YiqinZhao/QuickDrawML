% Problem 7, MATLAB code
% 1530200066 赵一勤
% ================================
% 首先，绘制图像，分析本题数据

clear;

month_odd = [1 3 5 7 9 13 17 19];        % 奇数月份
month_even = [2 6 8 10 12 14 16 18 20];  % 偶数月份
value_odd = [1.85 1.6 1.93 1.638 1.92 2.05 2.46 2.35];       % 奇数月数据
value_even = [2.18 2.35 2.51 2.49 2.68 2.77 2.95 2.87 3.07]; % 偶数月数据

month = [month_odd month_even];
value = [value_odd value_even];

[month_sort, indices] = sort(month);
value_sort = value(indices);

plot(month_odd, value_odd, month_even, value_even);
plot(month_sort, value_sort);

% 可以获得如下两个曲线图
% 略

% 由图像可知，数据存在函数关系，可通过多项式拟合
[p1,S1] = polyfit(month_even,value_even,1) % 使用一次函数拟合偶数月
%  p1 = 0.0490    2.0750
%  S1 = R: [2×2 double]    df: 7    normr: 0.1560

[p2,S2] = polyfit(month_even,value_even,2) % 使用二次函数拟合奇数月
%  p2 = 0.0025	-0.0114	1.7684
%  S2 = R: [3×3 double]    df: 5    normr: 0.3562
