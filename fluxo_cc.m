

%% FLUXO DE POTÊNCIA CC
% Wesley Peres em 20/03/2023

%%
clear all
close all
clc

%% DADOS DE BARRA (em pu)
%      NUM  THETA  PG   PD
DBAR = [1   0      0    0
        2   0      0    0.5 
        3   0      0    1   ];

%% DADOS DE LINHA (em pu)
%         DE  PARA   xkm
DLIN  = [ 1   2      1/3;
          1   3      1/2;
          2   3      1/2];

%% BARRA DE REFERÊNCIA (BALANÇO)
bref = 1;

%% NÚMERO DE BARRAS e DE LINHAS
nb = size(DBAR,1);
nl = size(DLIN,1);

%% MATRIZ B
B = zeros(nb,nb);

for s = 1:nl
    k = DLIN(s,1);
    m = DLIN(s,2);
    bkm = inv(DLIN(s,3));
    
    B(k,k) = B(k,k) + bkm;
    B(k,m) = B(k,m) - bkm;
    B(m,k) = B(m,k) - bkm;
    B(m,m) = B(m,m) + bkm;
end

B(bref,bref) = 1e10;  % Excluindo barra de referência

%% VETOR INDEPENDENTE P

PG = DBAR(:,3);
PD = DBAR(:,4);
P  = PG-PD;
P(bref) = 0;    % Barra de referência

%% RESOLVENDO O PROBLEMA
TH = B\P;   % Fatoração LU    
%% GERAÇÃO DA BARRA DE BALANÇO
Perdas = 0;       % sistema sem perdas (rkm = 0 para todos os ramos)
PGref  = -sum(P);
%%
[[1:nb]' TH]   
PGref 
%%

