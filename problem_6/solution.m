% Problem 6, MATLAB code
% 1530200066 赵一勤
% ================================
% 本题可以抽象为有向图的最短路径求解问题
% 可以使用狄杰斯特拉算法求解，也可以使用 MATLAB 自带的  graphshortestpath 函数

v0 = 1; % 起始点
vt = 7; % 目标点
lbl = {'A','B1','B2','C1','C2','C3','D'}; % 点的标签

% 首先根据题意定义邻接矩阵
S = [1 2 4 2 2 5 1 3 3 3 6 7];
T = [2 4 7 6 5 7 3 4 5 6 7 7];
W = [2 3 1 1 3 3 4 2 3 1 4 0];
DG = sparse(S,T,W);

% 绘制有向图
h = view(biograph(DG,lbl,'ShowWeights','on','LayoutType','equilibrium'));
[dist, path, pred] = graphshortestpath(DG, v0, vt);
set(h.Nodes(path),'Color',[1 0.4 0.4])
edges = getedgesbynodeid(h,get(h.Nodes(path),'ID'));
set(edges,'LineColor',[1 0 0])
set(edges,'LineWidth',1.5)

% 输出结果
result = [];
for i = 1:size(path,2)
    result = [result lbl{path(i)} ' '];
end

result % 程序输出 A B1 C1 D