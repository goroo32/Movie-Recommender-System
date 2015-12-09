clear all, close all
load movies.mat
Ytrain = Y(:,1:500);

%%
% Y = [5 3 0;
%     5 2 4;
%     2 5 0;
%     4 2 0];
[sim_p,den] = sim_mat_p(Ytrain);
sim_p1 = corr(Ytrain');
%load sim_p.mat
%%
load genres.mat
%%
options = [2,1000,1e-8,1];
k = [5:5:100]; % # of clusters
for i = 1:length(k)
    [~,U,~] = fuzzy(genres(:,1:end-1),k(i),options);
    % U = [.98 1 .01 .95;.0013 .0002 .95 .012];

    c = .4;
    [S,sim_c] = sim_mat_ac(U,sim_p,c);


    u = [501:943];
    k = [1:1682];
    n = 30;
    P = collab_predict(S,Y,Ytrain,n,u,k);


    MAE(i) = mean(mean(abs(P-Y)))

    Y1 = Y;
    Y1(Y1 == 0) = NaN;

    MAE1(i) = nanmean(nanmean(abs(P-Y1)))
end