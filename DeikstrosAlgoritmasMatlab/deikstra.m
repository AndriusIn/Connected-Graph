function [d,prec] = deikstra(V,U,s,orgraf,Vkor);
% DEIKSTRA funkcija apskaièiuoja trumpiausius kelius svoriniame
% grafe nuo virðûnës "s" iki likusiø grafo virðûniø.
%
%    Formalûs parametrai
% V    - grafo virðûniø aibë,
% U    - grafo briaunø aibë; [u,v,c]- (u,v) - briauna, c - jos ilgis/svoris,
% s    - pradinë kelio virðûnë,
% orgraf = 0,jei grafas neorientuotasis,
%        = 1,jei grafas orientuotasis, 
% Vkor - grafo virðûniø koordinatës; parametras nebûtinas;
%        jei Vkor nenurodytas arba Vkor=[], tai grafo virðûnës
%        iðdëstomos apskritimu; prieðingu atveju - pagal nurodytas
%        koordinates.

% Apibreþiame parametrà Vkor, jei jis nebuvo perduotas
if nargin < 5
    Vkor = [];
end

% Paruoðiamasis þingsnis
n = numel(V); m = numel(U); 
dz = zeros(1,n);  % virðûniø daþymo poþymiø masyvas
d = zeros(1,n); prec = zeros(1,n);
svoris = 1;
for i = 1:m
    a = U{i};
    svoris = svoris + a(3);
end
d = d + svoris;
d(s) = 0; prec(s) = s; t = true; 

% Gretimumo struktûros apskaièiavimas
GAM = UtoGAM(V,U,orgraf);

% Pradinio grafo brëþimas
arc=0; poz=0; Fontsize=10; lstor=2; spalva='b';
figure(1)
title('Duotasis grafas')
[VkorP] = plotGraphVU1(V,U,orgraf,arc,Vkor,poz,Fontsize,lstor,spalva);
hold on;

% Pagrindiniai skaièiavimai
zingNr = 0;
while (~all(dz)==1) && t
    % Randame virðûnæ, iki kurios trumpiausias kelias nusistovejæs
    kilg = min(d(dz==0));
    if kilg == svoris
        disp('Grafas G - nejungusis')
        return
    end
    ind = find((d==kilg)&~dz);
    k = V(ind(1)); v = prec(k);
    dz(k) = 1;    % nudaþome virðûnæ "k"

    % Briaunos daþymas (v,k)
    if k ~= v
        zingNr = zingNr + 1;
        title(sprintf('%d  þingsnis ',zingNr));
        V1 = [v,k];
        U1 = {[v,k]};
        V1kor = [Vkor(v,:);Vkor(k,:)];
        plotGraphVU1(V1,U1,1,0,V1kor,0,Fontsize,3,'r');
    end
    pause(1)
    
    % Perskaièiuojame masyvø d ir prec elementus
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