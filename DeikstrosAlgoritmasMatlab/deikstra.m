function [d,prec] = deikstra(V,U,s,orgraf,Vkor);
% DEIKSTRA funkcija apskai�iuoja trumpiausius kelius svoriniame
% grafe nuo vir��n�s "s" iki likusi� grafo vir��ni�.
%
%    Formal�s parametrai
% V    - grafo vir��ni� aib�,
% U    - grafo briaun� aib�; [u,v,c]- (u,v) - briauna, c - jos ilgis/svoris,
% s    - pradin� kelio vir��n�,
% orgraf = 0,jei grafas neorientuotasis,
%        = 1,jei grafas orientuotasis, 
% Vkor - grafo vir��ni� koordinat�s; parametras neb�tinas;
%        jei Vkor nenurodytas arba Vkor=[], tai grafo vir��n�s
%        i�d�stomos apskritimu; prie�ingu atveju - pagal nurodytas
%        koordinates.

% Apibre�iame parametr� Vkor, jei jis nebuvo perduotas
if nargin < 5
    Vkor = [];
end

% Paruo�iamasis �ingsnis
n = numel(V); m = numel(U); 
dz = zeros(1,n);  % vir��ni� da�ymo po�ymi� masyvas
d = zeros(1,n); prec = zeros(1,n);
svoris = 1;
for i = 1:m
    a = U{i};
    svoris = svoris + a(3);
end
d = d + svoris;
d(s) = 0; prec(s) = s; t = true; 

% Gretimumo strukt�ros apskai�iavimas
GAM = UtoGAM(V,U,orgraf);

% Pradinio grafo br��imas
arc=0; poz=0; Fontsize=10; lstor=2; spalva='b';
figure(1)
title('Duotasis grafas')
[VkorP] = plotGraphVU1(V,U,orgraf,arc,Vkor,poz,Fontsize,lstor,spalva);
hold on;

% Pagrindiniai skai�iavimai
zingNr = 0;
while (~all(dz)==1) && t
    % Randame vir��n�, iki kurios trumpiausias kelias nusistovej�s
    kilg = min(d(dz==0));
    if kilg == svoris
        disp('Grafas G - nejungusis')
        return
    end
    ind = find((d==kilg)&~dz);
    k = V(ind(1)); v = prec(k);
    dz(k) = 1;    % nuda�ome vir��n� "k"

    % Briaunos da�ymas (v,k)
    if k ~= v
        zingNr = zingNr + 1;
        title(sprintf('%d  �ingsnis ',zingNr));
        V1 = [v,k];
        U1 = {[v,k]};
        V1kor = [Vkor(v,:);Vkor(k,:)];
        plotGraphVU1(V1,U1,1,0,V1kor,0,Fontsize,3,'r');
    end
    pause(1)
    
    % Perskai�iuojame masyv� d ir prec elementus
    a = GAM{k};
    [~,nn] = size(a);
    for i = 1:nn
        u = a(1,i);
        if (dz(u)==0) && (d(u)>d(k) + a(2,i))
            d(u) = d(k) + a(2,i);
            prec(u) = k;
        end
    end  % for
end  %while
return