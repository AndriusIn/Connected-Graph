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
n = numel(V); m = numel(U); brnr = zeros(1,m);

% Briaun� sunumeravimas
for i = 1:m
    a = U{i}; u = a(1); v = a(2);
    if u > v
       uu = v; vv = u;
    else
        uu = u; vv = v;
    end
    brnr(i) = uu*100 + vv;
end

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

% Pagrindiniai skai�iavimai
figure(2)
title('Deikstros kelias')
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
        V1 = [v,k];
        if v > k
            vv = k; uu = v;
        else
            vv  =v; uu = k;
        end
        nrvk = vv*100 + uu;
        in = find(brnr==nrvk);
        a = U{in};
        U1 = {[v,k,a(3)]};
        V1kor = [Vkor(v,:);Vkor(k,:)];
        plotGraphVU1(V1,U1,1,0,V1kor,0,Fontsize,3,'r');
        U{in} = [];
    end
    
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
 % Atvirk�tini� briaun� (styg�) vaizdavimas 
 for i = 1:m
     a = U{i};
     if numel(a)~=0
         V2 = [a(1),a(2)];
         U2 = {[a(1),a(2),a(3)]};
         V2kor = [Vkor(a(1),:);Vkor(a(2),:)];
         plotGraphVU1(V2,U2,orgraf,arc,V2kor,poz,Fontsize,lstor,spalva);
     end
 end
return