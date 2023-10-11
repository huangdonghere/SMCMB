%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% This is a demo for the SMCMB (Scalable Multi-view Clustering via Many   %
% Bipartite Graphs) algorithm, which is presented in the following paper. %
%                                                                         %
% Jinghuan Lao, Dong Huang, Chang-Dong Wang, Jian-Huang Lai.              %
% Towards Scalable Multi-view Clustering via Joint Learning of Many       %
% Bipartite Graphs. IEEE Transactions on Big Data, 2023.                  %
%                                                                         %
% Latest version: https://github.com/huangdonghere/SMCMB                  %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function demo_SMCMB()

clear all;
close all;
clc;

%% Load the data.
dataName = 'ALOI';
load(['data_',dataName,'.mat'],'fea','gt'); 
V = length(fea); % Number of views
N = numel(gt);   % Number of samples
K = numel(unique(gt)); % Number of clusters

% Number of bipartite graphs (to be learned and partitioned) per view
m = 5;

%% Parameters
q = 100;        % Number of anchors. Suggested to be tuned in {K, 50, 100}.
beta = 1e-4;    % Hyperparameter. Suggested to be tuned in {10^-5, 10^-4, ..., 10^5}.

%% Run SMCMB
Label = SMCMB_paralleled(fea, K, m, q, beta);   % Paralleled version. Faster on multi-core machines.
% Label = SMCMB(fea, K, m, q, beta);            % Single-thread version

%% Display the NMI score
nmiScore = NMImax(Label,gt);
disp(['NMI = ',num2str(nmiScore)]);