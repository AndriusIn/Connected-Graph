%-----------------------------------------------------------------------------
% | In�inerinis projektas | Andrius In�iura | IF-6/1 | 20 u�duotis (B lygis) |
%-----------------------------------------------------------------------------
%-----------------------------------
% PAGRINDIN� FUNKCIJA
%-----------------------------------
function virsuniuPoaibisJungusGrafas
clc; clear all; close all;

% Briaun� aib�s
U = [ 1 1 1 2 2 3 4;   % Neorientuotas grafas 1 pvz.
      2 4 5 3 6 4 5 ];
%U = [ 1 3 3 4 5 5 6;   % Orientuotas grafas 1 pvz.
%      2 2 4 1 1 4 2 ];
%U = [ 1 2 2 3 4;       % Orientuotas grafas 2 pvz.
%      2 3 4 4 1 ];
%U = [ 2 2 2 3 4;       % Orientuotas grafas 3 pvz.
%      1 3 4 4 1 ];
%U = [ 1 2 2 2 3;       % Orientuotas grafas 4 pvz.
%      4 1 3 4 4 ];

% Grafo tipas (0 - neorientuotas; 1 - orientuotas)
Gtipas = 0;

% Duoto grafo vir��ni� skai�ius
n = max(max(U));

% Duoto grafo vir��ni� aib�
V = 1:n;

% Nurodytas vir��ni� poaibis
Vpoaibis = [ 1 4 5 ];

% Duoto grafo gretimumo strukt�ra
GR = gautiGretimuma(U, Gtipas);

% Spausdina duoto grafo gretimumo strukt�r�
disp('Duoto grafo gretimumo strukt�ra:');
for i = 1:length(GR)
    GRtoString = mat2str(GR{i});
    GRtoString(GRtoString=='[')=[];
    GRtoString(GRtoString==']')=[];
    text = [num2str(i),'| ',GRtoString];
    disp(text);
end;
fprintf('\n');

% Spausdina duot� graf� (naudoja plotGraphVU1.m funkcij�)
spausdintiGrafa(V,GR,Gtipas,'Duotas grafas');

% Nustato, ar duotame grafe nurodytas vir��ni� poaibis indukuoja jung� graf�
arJungusGrafas(Vpoaibis, GR, Gtipas);
end

%--------------------------------------------------
% FUNKCIJA
%--------------------------------------------------
% Spausdina graf� (naudoja plotGraphVU1.m funkcij�)
%--------------------------------------------------
function spausdintiGrafa(virsuniuPoaibis, poaibioGretimumoStruktura, grafoTipas, grafoVardas)
% Vir��ni� s�ra�as
V = sort(virsuniuPoaibis);

% Formuojame briaun� matric�
U = []; BrNr = 0;
for i = 1:length(poaibioGretimumoStruktura)
    for j = 1:length(poaibioGretimumoStruktura{i})
        BrNr = BrNr + 1;
        U{BrNr} = [V(i);poaibioGretimumoStruktura{i}(j)];
    end;
end;

% Vir��ni� koordinat�s pagal nutyl�jim� ratu
Vkor = [];

% Parametr� priskyrimas grafo spausdinimui naudojant f-j� plotGraphVU1.m
arc=0; poz=0; orgraf=grafoTipas; Fontsize=10; storis=2; spalva='b';
figure();
title(grafoVardas);
plotGraphVU1(V,U,orgraf,arc,Vkor,poz,Fontsize,storis,spalva);
end

%---------------------------------------------------------------------
% FUNKCIJA
%---------------------------------------------------------------------
% Gauna orientuoto (1) arba neorientuoto (0) grafo gretimumo strukt�r�
%---------------------------------------------------------------------
function GR = gautiGretimuma(briaunuMatrica, grafoTipas)
m = length(briaunuMatrica(1,:)); % briaun� skai�ius
n = max(max(briaunuMatrica)); % vir��ni� skai�ius
GR{n} = []; % gretimumo strukt�ra
d(1:n) = 0; % laipsniai

% Jei grafas neorientuotas
if (grafoTipas == 0)
    for j = 1:m
    k = briaunuMatrica(1,j);
    d(k) = d(k) + 1;
    GR{k} = [GR{k},briaunuMatrica(2,j)];
    k = briaunuMatrica(2,j);
    d(k) = d(k) + 1;
    GR{k} = [GR{k},briaunuMatrica(1,j)];
    end;
end;

% Jei grafas orientuotas    
if (grafoTipas == 1)
    for j = 1:m
    k = briaunuMatrica(1,j);
    d(k) = d(k) + 1;
    GR{k} = [GR{k},briaunuMatrica(2,j)];
    end;
end;
end

%-------------------------------------------------------
% FUNKCIJA
%-------------------------------------------------------
% Sudaro nauj� gretimumo strukt�r� pagal duotas vir��nes
%-------------------------------------------------------
function GRN = gautiGretimumaPagalVirsunes(virsuniuPoaibis, gretimumoStruktura)
virsuniuPoaibis = sort(virsuniuPoaibis);
poaibioDydis = length(virsuniuPoaibis);
GRN{poaibioDydis} = []; % nauja gretimumo strukt�ra

% Ciklas per naujos gretimumo stukt�ros masyvus
for i = 1:length(GRN)
    gretimuVirsuniuSkaicius = length(gretimumoStruktura{virsuniuPoaibis(i)});
    indeksas = 0;
    
    % Ciklas per duotas vir��nes
    for j = 1:poaibioDydis
        % Ciklas per duotos j-osios vir��n�s gretimas vir��nes
        for k = 1:gretimuVirsuniuSkaicius
            if (gretimumoStruktura{virsuniuPoaibis(i)}(k) == virsuniuPoaibis(j))
                indeksas = indeksas + 1;
                GRN{i}(indeksas) = virsuniuPoaibis(j);
            end;
        end;
    end;
end;
end

%-----------------------------------------------------------------
% FUNKCIJA
%-----------------------------------------------------------------
% Paver�ia orgraf� neorientuotu grafu ir gauna gretimumo strukt�r�
%-----------------------------------------------------------------
function GRO = OrientuotasToNeorientuotas(virsuniuPoaibis, gretimumoStruktura, virsuniuIndeksaiStrukturoje)
poaibioDydis = length(virsuniuPoaibis);
GRO = gretimumoStruktura; % nauja gretimumo strukt�ra

% Ciklas per duotas vir��nes
for i = 1:poaibioDydis
    gretimuVirsuniuSkaicius = length(gretimumoStruktura{i});
    
    % Ciklas per duotos i-osios vir��n�s gretimas vir��nes
    for j = 1:gretimuVirsuniuSkaicius
        virsunesIndeksas = virsuniuIndeksaiStrukturoje(GRO{i}(j));
        GRO{virsunesIndeksas}(length(GRO{virsunesIndeksas}) + 1) = virsuniuPoaibis(i);
    end;
end;
end

%--------------------------------------------------------------------------
% FUNKCIJA
%--------------------------------------------------------------------------
% Tikrina, ar galima apeiti neorientuot� graf� (jei galima - grafas jungus)
%--------------------------------------------------------------------------
function PG = apeitiNeorientuotaGrafa(virsuniuPoaibis, poaibioGretimumoStruktura, virsuniuIndeksaiStrukturoje)
% Gretimumo strukt�ros pagal duotas vir��nes kopija
GRK = poaibioGretimumoStruktura;

pradineVirsune = virsuniuPoaibis(1);
esameVirsune = pradineVirsune;

poaibioDydis = length(virsuniuPoaibis);

% Aplankyt� vir��ni� masyvas prec
prec = zeros(1,poaibioDydis);
prec(virsuniuIndeksaiStrukturoje(pradineVirsune)) = pradineVirsune;

% Pradin� vir��n� �aliname i� visos gretimumo strukt�ros
% Ciklas per gretimumo stukt�ros masyvus (duotas vir��nes)
for k = 1:length(GRK)
    % Ciklas per duotos k-osios vir��n�s gretimas vir��nes
    for l = 1:length(GRK{k})
        if (k == virsuniuIndeksaiStrukturoje(pradineVirsune))
            break;
        elseif (GRK{k}(l) == pradineVirsune)
            GRK{k}(l) = [];
            break;
        end;
    end;
end;

% Paie�ka gilyn (kol prec masyve yra nuli� - neaplankyt� vir��ni�)
while (ismember(0, prec) == 1)
    % Vir��n�, i� kurios at�jome (reikalinga prec masyvui)
    ankstesneVirsune = esameVirsune;
    gretimuVirsuniuSkaicius = length(GRK{virsuniuIndeksaiStrukturoje(esameVirsune)});

    % Jeigu neb�ra kur eiti, gr��tame � ankstesn� vir��n�
    if (gretimuVirsuniuSkaicius == 0)
        esameVirsune = prec(virsuniuIndeksaiStrukturoje(esameVirsune));

        % Jeigu gr��ome � pradin� vir��n� ir neb�ra kur eiti,
        % paie�k� gilyn nutraukiame
        if (esameVirsune == pradineVirsune && isempty(GRK{virsuniuIndeksaiStrukturoje(esameVirsune)}))
            break;
        end;
    else
        esameVirsune = GRK{virsuniuIndeksaiStrukturoje(esameVirsune)}(1);
        prec(virsuniuIndeksaiStrukturoje(esameVirsune)) = ankstesneVirsune;

        % Sekan�i� vir��n� �aliname i� visos gretimumo strukt�ros
        % Ciklas per gretimumo stukt�ros masyvus (duotas vir��nes)
        for m = 1:length(GRK)
            % Ciklas per duotos k-osios vir��n�s gretimas vir��nes
            for n = 1:length(GRK{m})
                if (m == virsuniuIndeksaiStrukturoje(esameVirsune))
                    break;
                elseif (GRK{m}(n) == esameVirsune)
                    GRK{m}(n) = [];
                    break;
                end;
            end;
        end;
    end;
end

% Jeigu prec masyve visos vir��n�s apeitos (neb�ra nuli�), gr��iname true
% (neorientuotas grafas yra jungus)
if (ismember(0, prec) == 0)
    PG = true;
else
    PG = false;
end;
end

%---------------------------------------------------------------------------
% FUNKCIJA
%---------------------------------------------------------------------------
% Nustato, ar duotame grafe nurodytas vir��ni� poaibis indukuoja jung� graf�
%---------------------------------------------------------------------------
function JG = arJungusGrafas(virsuniuPoaibis, gretimumoStruktura, grafoTipas)
virsuniuPoaibis = sort(virsuniuPoaibis);
poaibioDydis = length(virsuniuPoaibis);

% Sudarome nauj� gretimumo strukt�r� pagal duotas vir��nes
GR = gautiGretimumaPagalVirsunes(virsuniuPoaibis, gretimumoStruktura);

% Spausdina indukuoto grafo gretimumo strukt�r�
disp('Indukuoto grafo gretimumo strukt�ra:');
for i = 1:length(GR)
    GRtoString = mat2str(GR{i});
    GRtoString(GRtoString=='[')=[];
    GRtoString(GRtoString==']')=[];
    text = [num2str(virsuniuPoaibis(i)),'| ',GRtoString];
    disp(text);
end;
fprintf('\n');

% U�pildome duot� vir��ni� indeks� gretimumo strukt�roje masyv�
virsuniuIndeksaiStrukturoje = zeros(1, max(virsuniuPoaibis));
for i = 1:poaibioDydis
    virsuniuIndeksaiStrukturoje(virsuniuPoaibis(i)) = i;
end;

% Jei grafas neorientuotas
if (grafoTipas == 0)
    % Tikriname ar �manoma apeiti indukuot� neorientuot� graf�
    % (jeigu galima - indukuotas grafas yra jungus)
    if (apeitiNeorientuotaGrafa(virsuniuPoaibis, GR, virsuniuIndeksaiStrukturoje) == true)
        JG = true;
        disp('Duotame neorientuotame grafe nurodytas vir��ni� poaibis indukuoja jung� graf�');
        
        % Spausdina indukuot� graf� (naudoja plotGraphVU1.m funkcij�)
        spausdintiGrafa(virsuniuPoaibis,GR,grafoTipas,'Indukuotas grafas');
    else
        JG = false;
        disp('Duotame neorientuotame grafe nurodytas vir��ni� poaibis neindukuoja jungaus grafo');
        
        % Spausdina indukuot� graf� (naudoja plotGraphVU1.m funkcij�)
        spausdintiGrafa(virsuniuPoaibis,GR,grafoTipas,'Indukuotas grafas');
    end;
% Jei grafas orientuotas
elseif (grafoTipas == 1)
    virsuniuPoruSkaicius = factorial(poaibioDydis) / (factorial(2) * factorial(poaibioDydis - 2));
    abipusiuPoruSkaicius = 0;
    vienakrypciuPoruSkaicius = 0;
    virsuniuPoros{virsuniuPoruSkaicius} = [];
    porosIndeksas = 0;
    
    % Sudarome vir��ni� por� masyv�
    % Ciklai per duotas vir��nes
    for i = 1:poaibioDydis-1
        for j = i+1:poaibioDydis
            porosIndeksas = porosIndeksas + 1;
            virsuniuPoros{porosIndeksas}(1) = virsuniuPoaibis(i);
            virsuniuPoros{porosIndeksas}(2) = virsuniuPoaibis(j);
        end;
    end;
    
    % Ciklas per vir��ni� poras
    for i = 1:virsuniuPoruSkaicius
        radoKeliaNuoPirmosVirsunes = false;
        radoKeliaNuoAntrosVirsunes = false;
        
        % Du kartus vykdysime paie�k� gilyn (1(2) vir��n� -> 2(1) vir��n�)
        for j = 1:2
            GRK = GR; % Gretimumo strukt�ros pagal duotas vir��nes kopija
            pradineVirsune = virsuniuPoros{i}(j);
            galutineVirsune = 0;
            esameVirsune = pradineVirsune;
            
            % Aplankyt� vir��ni� masyvas prec
            prec = zeros(1,max(virsuniuPoaibis));
            prec(pradineVirsune) = pradineVirsune;
            
            % Nustatome galutin� vir��n�
            if (j == 1)
                galutineVirsune = virsuniuPoros{i}(2);
            else
                galutineVirsune = virsuniuPoros{i}(1);
            end;
            
            % Pradin� vir��n� �aliname i� visos gretimumo strukt�ros
            % Ciklas per gretimumo stukt�ros masyvus (duotas vir��nes)
            for k = 1:length(GRK)
                % Ciklas per duotos k-osios vir��n�s gretimas vir��nes
                for l = 1:length(GRK{k})
                    if (k == virsuniuIndeksaiStrukturoje(pradineVirsune))
                        break;
                    elseif (GRK{k}(l) == pradineVirsune)
                        GRK{k}(l) = [];
                        break;
                    end;
                end;
            end;
            
            % Paie�ka gilyn
            while (esameVirsune ~= galutineVirsune)
                % Vir��n�, i� kurios at�jome (reikalinga prec masyvui)
                ankstesneVirsune = esameVirsune;
                
                % Esamos vir��n�s gretim� vir��ni� skai�ius
                gretimuVirsuniuSkaicius = length(GRK{virsuniuIndeksaiStrukturoje(esameVirsune)});
                
                % Jeigu neb�ra kur eiti, gr��tame � ankstesn� vir��n�
                if (gretimuVirsuniuSkaicius == 0)
                    esameVirsune = prec(esameVirsune);
                    
                    % Jeigu gr��ome � pradin� vir��n� ir neb�ra kur eiti,
                    % paie�k� gilyn nutraukiame (paie�ka nes�kminga)
                    if (esameVirsune == pradineVirsune && isempty(GRK{virsuniuIndeksaiStrukturoje(esameVirsune)}))
                        break;
                    end;
                else
                    esameVirsune = GRK{virsuniuIndeksaiStrukturoje(esameVirsune)}(1);
                    prec(esameVirsune) = ankstesneVirsune;
                    
                    % Sekan�i� vir��n� �aliname i� visos gretimumo
                    % strukt�ros
                    % Ciklas per gretimumo stukt�ros masyvus (duotas
                    % vir��nes)
                    for m = 1:length(GRK)
                        % Ciklas per duotos k-osios vir��n�s gretimas
                        % vir��nes
                        for n = 1:length(GRK{m})
                            if (m == virsuniuIndeksaiStrukturoje(esameVirsune))
                                break;
                            elseif (GRK{m}(n) == esameVirsune)
                                GRK{m}(n) = [];
                                break;
                            end;
                        end;
                    end;
                end;
                
                % Jeigu pasiek�me reikiam� vir��n� (paie�ka s�kminga)
                if (esameVirsune == galutineVirsune)
                    if (j == 1)
                        radoKeliaNuoPirmosVirsunes = true;
                    else
                        radoKeliaNuoAntrosVirsunes = true;
                    end;
                    
                    % Tikriname, ar atrado abipusi� arba vienekryp�i� por�
                    if (radoKeliaNuoPirmosVirsunes == true && radoKeliaNuoAntrosVirsunes == true)
                        abipusiuPoruSkaicius = abipusiuPoruSkaicius + 1;
                    elseif (radoKeliaNuoPirmosVirsunes == true && radoKeliaNuoAntrosVirsunes == false)
                        vienakrypciuPoruSkaicius = vienakrypciuPoruSkaicius + 1;
                    elseif (radoKeliaNuoPirmosVirsunes == false && radoKeliaNuoAntrosVirsunes == true)
                        vienakrypciuPoruSkaicius = vienakrypciuPoruSkaicius + 1;
                    end;
                end;
            end
        end;
    end;
    
    % Paver�iame orgraf� neorientuotu grafu ir gauname gretimumo strukt�r�
    % (reikalinga patikrinti, ar orgrafas yra silpnai jungus)
    GR2 = OrientuotasToNeorientuotas(virsuniuPoaibis, GR, virsuniuIndeksaiStrukturoje);
    
    % Tikriname, ar duotame orgrafe nurodytas vir��ni� poaibis indukuoja
    % jung� orgraf�
    if (abipusiuPoruSkaicius == virsuniuPoruSkaicius)
        JG = true;
        disp('Duotame orgrafe nurodytas vir��ni� poaibis indukuoja stipriai jung� orgraf�.');
        
        % Spausdina indukuot� graf� (naudoja plotGraphVU1.m funkcij�)
        spausdintiGrafa(virsuniuPoaibis,GR,grafoTipas,'Indukuotas grafas');
    elseif (vienakrypciuPoruSkaicius == virsuniuPoruSkaicius)
        JG = true;
        disp('Duotame orgrafe nurodytas vir��ni� poaibis indukuoja vienakrypti�kai jung� orgraf�.');
        
        % Spausdina indukuot� graf� (naudoja plotGraphVU1.m funkcij�)
        spausdintiGrafa(virsuniuPoaibis,GR,grafoTipas,'Indukuotas grafas');
    elseif (apeitiNeorientuotaGrafa(virsuniuPoaibis, GR2, virsuniuIndeksaiStrukturoje) == true)
        JG = true;
        disp('Duotame orgrafe nurodytas vir��ni� poaibis indukuoja silpnai jung� orgraf�.');
        
        % Spausdina indukuot� graf� (naudoja plotGraphVU1.m funkcij�)
        spausdintiGrafa(virsuniuPoaibis,GR,grafoTipas,'Indukuotas grafas');
    else
        JG = false;
        disp('Duotame orgrafe nurodytas vir��ni� poaibis neindukuoja jungaus orgrafo.');
        
        % Spausdina indukuot� graf� (naudoja plotGraphVU1.m funkcij�)
        spausdintiGrafa(virsuniuPoaibis,GR,grafoTipas,'Indukuotas grafas');
    end;
end;
end