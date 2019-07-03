%-----------------------------------------------------------------------------
% | Inþinerinis projektas | Andrius Inèiura | IF-6/1 | 20 uþduotis (B lygis) |
%-----------------------------------------------------------------------------
%-----------------------------------
% PAGRINDINË FUNKCIJA
%-----------------------------------
function virsuniuPoaibisJungusGrafas
clc; clear all; close all;

% Briaunø aibës
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

% Duoto grafo virðûniø skaièius
n = max(max(U));

% Duoto grafo virðûniø aibë
V = 1:n;

% Nurodytas virðûniø poaibis
Vpoaibis = [ 1 4 5 ];

% Duoto grafo gretimumo struktûra
GR = gautiGretimuma(U, Gtipas);

% Spausdina duoto grafo gretimumo struktûrà
disp('Duoto grafo gretimumo struktûra:');
for i = 1:length(GR)
    GRtoString = mat2str(GR{i});
    GRtoString(GRtoString=='[')=[];
    GRtoString(GRtoString==']')=[];
    text = [num2str(i),'| ',GRtoString];
    disp(text);
end;
fprintf('\n');

% Spausdina duotà grafà (naudoja plotGraphVU1.m funkcijà)
spausdintiGrafa(V,GR,Gtipas,'Duotas grafas');

% Nustato, ar duotame grafe nurodytas virðûniø poaibis indukuoja jungø grafà
arJungusGrafas(Vpoaibis, GR, Gtipas);
end

%--------------------------------------------------
% FUNKCIJA
%--------------------------------------------------
% Spausdina grafà (naudoja plotGraphVU1.m funkcijà)
%--------------------------------------------------
function spausdintiGrafa(virsuniuPoaibis, poaibioGretimumoStruktura, grafoTipas, grafoVardas)
% Virðûniø sàraðas
V = sort(virsuniuPoaibis);

% Formuojame briaunø matricà
U = []; BrNr = 0;
for i = 1:length(poaibioGretimumoStruktura)
    for j = 1:length(poaibioGretimumoStruktura{i})
        BrNr = BrNr + 1;
        U{BrNr} = [V(i);poaibioGretimumoStruktura{i}(j)];
    end;
end;

% Virðûniø koordinatës pagal nutylëjimà ratu
Vkor = [];

% Parametrø priskyrimas grafo spausdinimui naudojant f-jà plotGraphVU1.m
arc=0; poz=0; orgraf=grafoTipas; Fontsize=10; storis=2; spalva='b';
figure();
title(grafoVardas);
plotGraphVU1(V,U,orgraf,arc,Vkor,poz,Fontsize,storis,spalva);
end

%---------------------------------------------------------------------
% FUNKCIJA
%---------------------------------------------------------------------
% Gauna orientuoto (1) arba neorientuoto (0) grafo gretimumo struktûrà
%---------------------------------------------------------------------
function GR = gautiGretimuma(briaunuMatrica, grafoTipas)
m = length(briaunuMatrica(1,:)); % briaunø skaièius
n = max(max(briaunuMatrica)); % virðûniø skaièius
GR{n} = []; % gretimumo struktûra
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
% Sudaro naujà gretimumo struktûrà pagal duotas virðûnes
%-------------------------------------------------------
function GRN = gautiGretimumaPagalVirsunes(virsuniuPoaibis, gretimumoStruktura)
virsuniuPoaibis = sort(virsuniuPoaibis);
poaibioDydis = length(virsuniuPoaibis);
GRN{poaibioDydis} = []; % nauja gretimumo struktûra

% Ciklas per naujos gretimumo stuktûros masyvus
for i = 1:length(GRN)
    gretimuVirsuniuSkaicius = length(gretimumoStruktura{virsuniuPoaibis(i)});
    indeksas = 0;
    
    % Ciklas per duotas virðûnes
    for j = 1:poaibioDydis
        % Ciklas per duotos j-osios virðûnës gretimas virðûnes
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
% Paverèia orgrafà neorientuotu grafu ir gauna gretimumo struktûrà
%-----------------------------------------------------------------
function GRO = OrientuotasToNeorientuotas(virsuniuPoaibis, gretimumoStruktura, virsuniuIndeksaiStrukturoje)
poaibioDydis = length(virsuniuPoaibis);
GRO = gretimumoStruktura; % nauja gretimumo struktûra

% Ciklas per duotas virðûnes
for i = 1:poaibioDydis
    gretimuVirsuniuSkaicius = length(gretimumoStruktura{i});
    
    % Ciklas per duotos i-osios virðûnës gretimas virðûnes
    for j = 1:gretimuVirsuniuSkaicius
        virsunesIndeksas = virsuniuIndeksaiStrukturoje(GRO{i}(j));
        GRO{virsunesIndeksas}(length(GRO{virsunesIndeksas}) + 1) = virsuniuPoaibis(i);
    end;
end;
end

%--------------------------------------------------------------------------
% FUNKCIJA
%--------------------------------------------------------------------------
% Tikrina, ar galima apeiti neorientuotà grafà (jei galima - grafas jungus)
%--------------------------------------------------------------------------
function PG = apeitiNeorientuotaGrafa(virsuniuPoaibis, poaibioGretimumoStruktura, virsuniuIndeksaiStrukturoje)
% Gretimumo struktûros pagal duotas virðûnes kopija
GRK = poaibioGretimumoStruktura;

pradineVirsune = virsuniuPoaibis(1);
esameVirsune = pradineVirsune;

poaibioDydis = length(virsuniuPoaibis);

% Aplankytø virðûniø masyvas prec
prec = zeros(1,poaibioDydis);
prec(virsuniuIndeksaiStrukturoje(pradineVirsune)) = pradineVirsune;

% Pradinæ virðûnæ ðaliname ið visos gretimumo struktûros
% Ciklas per gretimumo stuktûros masyvus (duotas virðûnes)
for k = 1:length(GRK)
    % Ciklas per duotos k-osios virðûnës gretimas virðûnes
    for l = 1:length(GRK{k})
        if (k == virsuniuIndeksaiStrukturoje(pradineVirsune))
            break;
        elseif (GRK{k}(l) == pradineVirsune)
            GRK{k}(l) = [];
            break;
        end;
    end;
end;

% Paieðka gilyn (kol prec masyve yra nuliø - neaplankytø virðûniø)
while (ismember(0, prec) == 1)
    % Virðûnë, ið kurios atëjome (reikalinga prec masyvui)
    ankstesneVirsune = esameVirsune;
    gretimuVirsuniuSkaicius = length(GRK{virsuniuIndeksaiStrukturoje(esameVirsune)});

    % Jeigu nebëra kur eiti, gráþtame á ankstesnæ virðûnæ
    if (gretimuVirsuniuSkaicius == 0)
        esameVirsune = prec(virsuniuIndeksaiStrukturoje(esameVirsune));

        % Jeigu gráþome á pradinæ virðûnæ ir nebëra kur eiti,
        % paieðkà gilyn nutraukiame
        if (esameVirsune == pradineVirsune && isempty(GRK{virsuniuIndeksaiStrukturoje(esameVirsune)}))
            break;
        end;
    else
        esameVirsune = GRK{virsuniuIndeksaiStrukturoje(esameVirsune)}(1);
        prec(virsuniuIndeksaiStrukturoje(esameVirsune)) = ankstesneVirsune;

        % Sekanèià virðûnæ ðaliname ið visos gretimumo struktûros
        % Ciklas per gretimumo stuktûros masyvus (duotas virðûnes)
        for m = 1:length(GRK)
            % Ciklas per duotos k-osios virðûnës gretimas virðûnes
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

% Jeigu prec masyve visos virðûnës apeitos (nebëra nuliø), gràþiname true
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
% Nustato, ar duotame grafe nurodytas virðûniø poaibis indukuoja jungø grafà
%---------------------------------------------------------------------------
function JG = arJungusGrafas(virsuniuPoaibis, gretimumoStruktura, grafoTipas)
virsuniuPoaibis = sort(virsuniuPoaibis);
poaibioDydis = length(virsuniuPoaibis);

% Sudarome naujà gretimumo struktûrà pagal duotas virðûnes
GR = gautiGretimumaPagalVirsunes(virsuniuPoaibis, gretimumoStruktura);

% Spausdina indukuoto grafo gretimumo struktûrà
disp('Indukuoto grafo gretimumo struktûra:');
for i = 1:length(GR)
    GRtoString = mat2str(GR{i});
    GRtoString(GRtoString=='[')=[];
    GRtoString(GRtoString==']')=[];
    text = [num2str(virsuniuPoaibis(i)),'| ',GRtoString];
    disp(text);
end;
fprintf('\n');

% Uþpildome duotø virðûniø indeksø gretimumo struktûroje masyvà
virsuniuIndeksaiStrukturoje = zeros(1, max(virsuniuPoaibis));
for i = 1:poaibioDydis
    virsuniuIndeksaiStrukturoje(virsuniuPoaibis(i)) = i;
end;

% Jei grafas neorientuotas
if (grafoTipas == 0)
    % Tikriname ar ámanoma apeiti indukuotà neorientuotà grafà
    % (jeigu galima - indukuotas grafas yra jungus)
    if (apeitiNeorientuotaGrafa(virsuniuPoaibis, GR, virsuniuIndeksaiStrukturoje) == true)
        JG = true;
        disp('Duotame neorientuotame grafe nurodytas virðûniø poaibis indukuoja jungø grafà');
        
        % Spausdina indukuotà grafà (naudoja plotGraphVU1.m funkcijà)
        spausdintiGrafa(virsuniuPoaibis,GR,grafoTipas,'Indukuotas grafas');
    else
        JG = false;
        disp('Duotame neorientuotame grafe nurodytas virðûniø poaibis neindukuoja jungaus grafo');
        
        % Spausdina indukuotà grafà (naudoja plotGraphVU1.m funkcijà)
        spausdintiGrafa(virsuniuPoaibis,GR,grafoTipas,'Indukuotas grafas');
    end;
% Jei grafas orientuotas
elseif (grafoTipas == 1)
    virsuniuPoruSkaicius = factorial(poaibioDydis) / (factorial(2) * factorial(poaibioDydis - 2));
    abipusiuPoruSkaicius = 0;
    vienakrypciuPoruSkaicius = 0;
    virsuniuPoros{virsuniuPoruSkaicius} = [];
    porosIndeksas = 0;
    
    % Sudarome virðûniø porø masyvà
    % Ciklai per duotas virðûnes
    for i = 1:poaibioDydis-1
        for j = i+1:poaibioDydis
            porosIndeksas = porosIndeksas + 1;
            virsuniuPoros{porosIndeksas}(1) = virsuniuPoaibis(i);
            virsuniuPoros{porosIndeksas}(2) = virsuniuPoaibis(j);
        end;
    end;
    
    % Ciklas per virðûniø poras
    for i = 1:virsuniuPoruSkaicius
        radoKeliaNuoPirmosVirsunes = false;
        radoKeliaNuoAntrosVirsunes = false;
        
        % Du kartus vykdysime paieðkà gilyn (1(2) virðûnë -> 2(1) virðûnë)
        for j = 1:2
            GRK = GR; % Gretimumo struktûros pagal duotas virðûnes kopija
            pradineVirsune = virsuniuPoros{i}(j);
            galutineVirsune = 0;
            esameVirsune = pradineVirsune;
            
            % Aplankytø virðûniø masyvas prec
            prec = zeros(1,max(virsuniuPoaibis));
            prec(pradineVirsune) = pradineVirsune;
            
            % Nustatome galutinæ virðûnæ
            if (j == 1)
                galutineVirsune = virsuniuPoros{i}(2);
            else
                galutineVirsune = virsuniuPoros{i}(1);
            end;
            
            % Pradinæ virðûnæ ðaliname ið visos gretimumo struktûros
            % Ciklas per gretimumo stuktûros masyvus (duotas virðûnes)
            for k = 1:length(GRK)
                % Ciklas per duotos k-osios virðûnës gretimas virðûnes
                for l = 1:length(GRK{k})
                    if (k == virsuniuIndeksaiStrukturoje(pradineVirsune))
                        break;
                    elseif (GRK{k}(l) == pradineVirsune)
                        GRK{k}(l) = [];
                        break;
                    end;
                end;
            end;
            
            % Paieðka gilyn
            while (esameVirsune ~= galutineVirsune)
                % Virðûnë, ið kurios atëjome (reikalinga prec masyvui)
                ankstesneVirsune = esameVirsune;
                
                % Esamos virðûnës gretimø virðûniø skaièius
                gretimuVirsuniuSkaicius = length(GRK{virsuniuIndeksaiStrukturoje(esameVirsune)});
                
                % Jeigu nebëra kur eiti, gráþtame á ankstesnæ virðûnæ
                if (gretimuVirsuniuSkaicius == 0)
                    esameVirsune = prec(esameVirsune);
                    
                    % Jeigu gráþome á pradinæ virðûnæ ir nebëra kur eiti,
                    % paieðkà gilyn nutraukiame (paieðka nesëkminga)
                    if (esameVirsune == pradineVirsune && isempty(GRK{virsuniuIndeksaiStrukturoje(esameVirsune)}))
                        break;
                    end;
                else
                    esameVirsune = GRK{virsuniuIndeksaiStrukturoje(esameVirsune)}(1);
                    prec(esameVirsune) = ankstesneVirsune;
                    
                    % Sekanèià virðûnæ ðaliname ið visos gretimumo
                    % struktûros
                    % Ciklas per gretimumo stuktûros masyvus (duotas
                    % virðûnes)
                    for m = 1:length(GRK)
                        % Ciklas per duotos k-osios virðûnës gretimas
                        % virðûnes
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
                
                % Jeigu pasiekëme reikiamà virðûnæ (paieðka sëkminga)
                if (esameVirsune == galutineVirsune)
                    if (j == 1)
                        radoKeliaNuoPirmosVirsunes = true;
                    else
                        radoKeliaNuoAntrosVirsunes = true;
                    end;
                    
                    % Tikriname, ar atrado abipusiø arba vienekrypèiø porø
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
    
    % Paverèiame orgrafà neorientuotu grafu ir gauname gretimumo struktûrà
    % (reikalinga patikrinti, ar orgrafas yra silpnai jungus)
    GR2 = OrientuotasToNeorientuotas(virsuniuPoaibis, GR, virsuniuIndeksaiStrukturoje);
    
    % Tikriname, ar duotame orgrafe nurodytas virðûniø poaibis indukuoja
    % jungø orgrafà
    if (abipusiuPoruSkaicius == virsuniuPoruSkaicius)
        JG = true;
        disp('Duotame orgrafe nurodytas virðûniø poaibis indukuoja stipriai jungø orgrafà.');
        
        % Spausdina indukuotà grafà (naudoja plotGraphVU1.m funkcijà)
        spausdintiGrafa(virsuniuPoaibis,GR,grafoTipas,'Indukuotas grafas');
    elseif (vienakrypciuPoruSkaicius == virsuniuPoruSkaicius)
        JG = true;
        disp('Duotame orgrafe nurodytas virðûniø poaibis indukuoja vienakryptiðkai jungø orgrafà.');
        
        % Spausdina indukuotà grafà (naudoja plotGraphVU1.m funkcijà)
        spausdintiGrafa(virsuniuPoaibis,GR,grafoTipas,'Indukuotas grafas');
    elseif (apeitiNeorientuotaGrafa(virsuniuPoaibis, GR2, virsuniuIndeksaiStrukturoje) == true)
        JG = true;
        disp('Duotame orgrafe nurodytas virðûniø poaibis indukuoja silpnai jungø orgrafà.');
        
        % Spausdina indukuotà grafà (naudoja plotGraphVU1.m funkcijà)
        spausdintiGrafa(virsuniuPoaibis,GR,grafoTipas,'Indukuotas grafas');
    else
        JG = false;
        disp('Duotame orgrafe nurodytas virðûniø poaibis neindukuoja jungaus orgrafo.');
        
        % Spausdina indukuotà grafà (naudoja plotGraphVU1.m funkcijà)
        spausdintiGrafa(virsuniuPoaibis,GR,grafoTipas,'Indukuotas grafas');
    end;
end;
end