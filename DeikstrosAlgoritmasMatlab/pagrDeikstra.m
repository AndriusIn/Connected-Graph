clc; close all; clear all 

V = [1 2 3 4 5 6 7 8]; % grafo vir��ni� aib�
% Grafo briaun� ir j� svori� aib� 
U = {[1 2 1],[2 3 2],[3 4 4],[3 5 1],[2 5 5],[5 4 1],[4 7 1],[1 6 2],[7 8 1],[5 6 3],[5 8 5]};
% Grafo vir��ni� koordinates
Vkor = [-1 0; -0.33 1; 0.33 1; 0.33 0; -0.33 0; -0.33 -1; 1 0; 0.33 -1];

% U�komentavus 7 eilut� ir atkomentavus 14-27 eilutes,
% grafo vir��nes galima pa�ym�ti pele ekrane

% Grafo vir��ni� �ym�jimas ekrane
%  % Lango mastelis
%  hold on; axis equal; axis([-1.1,1.1,-1.1,1.1]); grid on
%  Vkor = []; %  nn = 0;
%  % Ciklas vir��n�ms �ym�ti
%  title('�veskite 7 vir��nes su kairiu pel�s mygtuku, paskutin� 8-�j� - su de�iniu')
%  disp('kairys mygtukas �ymi ta�kus nuo 1 iki (n-1)')
%  disp('de�inys - paskutin� ta�k� n')
%  but = 1;
%  while but == 1
%      [xi,yi,but] = ginput(1);
%      plot(xi,yi,'ro')
%      nn = nn + 1;
%      Vkor(nn,1) = xi;
%      Vkor(nn,2) = yi;
%  end

disp('Darbo prad�ia')
% Deikstros algoritmo skai�iavimas ir grafinis vaizdavimas
s = 5;  % pradin� kelio vir��n�
orgraf = 0;  % grafas neorientuotasis
% [d,prec] = deikstra(V,U,s,orgraf,Vkor)
[d,prec] = deikstra2(V,U,s,orgraf,Vkor)
disp('Darbo pabaiga')

  