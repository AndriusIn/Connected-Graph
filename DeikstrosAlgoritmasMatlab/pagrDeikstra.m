clc; close all; clear all 

V = [1 2 3 4 5 6 7 8]; % grafo virðûniø aibë
% Grafo briaunø ir jø svoriø aibë 
U = {[1 2 1],[2 3 2],[3 4 4],[3 5 1],[2 5 5],[5 4 1],[4 7 1],[1 6 2],[7 8 1],[5 6 3],[5 8 5]};
% Grafo virðûniø koordinates
Vkor = [-1 0; -0.33 1; 0.33 1; 0.33 0; -0.33 0; -0.33 -1; 1 0; 0.33 -1];

% Uþkomentavus 7 eilutæ ir atkomentavus 14-27 eilutes,
% grafo virðûnes galima paþymëti pele ekrane

% Grafo virðûniø þymëjimas ekrane
%  % Lango mastelis
%  hold on; axis equal; axis([-1.1,1.1,-1.1,1.1]); grid on
%  Vkor = []; %  nn = 0;
%  % Ciklas virðûnëms þymëti
%  title('Áveskite 7 virðûnes su kairiu pelës mygtuku, paskutinæ 8-àjà - su deðiniu')
%  disp('kairys mygtukas þymi taðkus nuo 1 iki (n-1)')
%  disp('deðinys - paskutiná taðkà n')
%  but = 1;
%  while but == 1
%      [xi,yi,but] = ginput(1);
%      plot(xi,yi,'ro')
%      nn = nn + 1;
%      Vkor(nn,1) = xi;
%      Vkor(nn,2) = yi;
%  end

disp('Darbo pradþia')
% Deikstros algoritmo skaièiavimas ir grafinis vaizdavimas
s = 5;  % pradinë kelio virðûnë
orgraf = 0;  % grafas neorientuotasis
% [d,prec] = deikstra(V,U,s,orgraf,Vkor)
[d,prec] = deikstra2(V,U,s,orgraf,Vkor)
disp('Darbo pabaiga')

  