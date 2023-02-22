function demo_SMCMB()

clear;close;clc

load(['ALOI.mat'],'gt','fea');
K = numel(unique(gt));

%% Set up
m = 5; % Number of bipartite graphs for each view.
q = 100; % Number of anchors.

%% Hyper-parameter
beta = 1e-4;

%% Run the SMCMB algorithm
label = SMCMB(fea, K, m, q, beta);

%% Display the score
score = NMImax(label,gt);
disp(['NMI = ', num2str(score)]);

end


