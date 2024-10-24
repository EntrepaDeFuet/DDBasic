ENTITY banc_de_proves IS
END banc_de_proves;

--Test inversor
ARCHITECTURE inversor OF banc_de_proves IS

COMPONENT inversor

PORT (a: IN BIT; z: OUT BIT);

END COMPONENT;

SIGNAL entrada, sortida,sortidaretard: BIT; 

FOR DUT0: inversor USE ENTITY WORK.inversor(logica);
FOR DUT1: inversor USE ENTITY WORK.inversor(logicaretard);

BEGIN

DUT0: inversor PORT MAP (entrada,sortida);
DUT1: inversor PORT MAP (entrada,sortidaretard);

PROCESS (entrada)
BEGIN
entrada <= NOT entrada AFTER 50 ns;
END PROCESS;
END inversor;

-- Test de and2(amb retard implementat):
ARCHITECTURE test_and2 OF banc_de_proves IS

COMPONENT la_porta_and2

PORT (a,b: IN BIT; z: OUT BIT);

END COMPONENT;

SIGNAL entand1, entand0, sortidand, sortidaretard: BIT; 

FOR DUT0: la_porta_and2 USE ENTITY WORK.and2(logica);
FOR DUT1: la_porta_and2 USE ENTITY WORK.and2(logicaretard);

BEGIN

DUT0: la_porta_and2 PORT MAP (entand1,entand0,sortidand);
DUT1: la_porta_and2 PORT MAP (entand1,entand0,sortidaretard);


PROCESS (entand1,entand0)
BEGIN
entand1 <= NOT entand1 AFTER 50 ns;
entand0 <= NOT entand0 AFTER 100 ns;
END PROCESS;
END test_and2;

-- Test de or2:
ARCHITECTURE test_or2 OF banc_de_proves IS

COMPONENT la_porta_or2

PORT (a,b: IN BIT; z: OUT BIT);

END COMPONENT;

SIGNAL entor1, entor0, sortidaor1,sortidaretard: BIT; 

FOR DUT1: la_porta_or2 USE ENTITY WORK.or2(logica);
FOR DUT2: la_porta_or2 USE ENTITY WORK.or2(logicaretard);

BEGIN

DUT1: la_porta_or2 PORT MAP (entor1,entor0,sortidaor1);
DUT2: la_porta_or2 PORT MAP (entor1,entor0,sortidaretard);


PROCESS (entor1,entor0)
BEGIN
entor1 <= NOT entor1 AFTER 50 ns;
entor0 <= NOT entor0 AFTER 100 ns;
END PROCESS;
END test_or2;


-- Test de or3:
ARCHITECTURE test_or3 OF banc_de_proves IS

COMPONENT la_porta_or3

PORT (a,b,c: IN BIT; z: OUT BIT);

END COMPONENT;

SIGNAL entor2, entor3, entor4, sortidaor2, sortidaretard: BIT; 

FOR DUT0: la_porta_or3 USE ENTITY WORK.or3(logica);
FOR DUT3: la_porta_or3 USE ENTITY WORK.or3(logicaretard);

BEGIN
DUT0: la_porta_or3 PORT MAP (entor2,entor3,entor4,sortidaor2);
DUT3: la_porta_or3 PORT MAP (entor2,entor3,entor4,sortidaretard);


PROCESS (entor2,entor3,entor4)
BEGIN
entor2 <= NOT entor2 AFTER 50 ns;
entor3 <= NOT entor3 AFTER 100 ns;
entor4 <= NOT entor4 AFTER 200 ns;
END PROCESS;
END test_or3;

-- Test de or4:
ARCHITECTURE test_or4 OF banc_de_proves IS

COMPONENT la_porta_or4

PORT (a,b,c,d: IN BIT; z: OUT BIT);

END COMPONENT;

SIGNAL entor5, entor6, entor7, entor8, sortidaor3, sortidaretard: BIT; 

FOR DUT0: la_porta_or4 USE ENTITY WORK.or4(logica);
FOR DUT4: la_porta_or4 USE ENTITY WORK.or4(logicaretard);

BEGIN
DUT0: la_porta_or4 PORT MAP (entor5,entor6,entor7,entor8, sortidaor3);
DUT4: la_porta_or4 PORT MAP (entor5,entor6,entor7,entor8, sortidaretard);


PROCESS (entor5,entor6,entor7,entor8)
BEGIN
entor5 <= NOT entor5 AFTER 50 ns;
entor6 <= NOT entor6 AFTER 100 ns;
entor7 <= NOT entor7 AFTER 200 ns;
entor8 <= NOT entor7 AFTER 400 ns;
END PROCESS;
END test_or4;

-- Test de and3:
ARCHITECTURE test_and3 OF banc_de_proves IS

COMPONENT la_porta_and3

PORT (a,b,c: IN BIT; z: OUT BIT);

END COMPONENT;

SIGNAL entand2, entand3, entand4, sortidand2, sortidaretard: BIT; 

FOR DUT0: la_porta_and3 USE ENTITY WORK.and3(logica);
FOR DUT5: la_porta_and3 USE ENTITY WORK.and3(logicaretard);

BEGIN

DUT0: la_porta_and3 PORT MAP (entand2,entand3,entand4, sortidand2);
DUT5: la_porta_and3 PORT MAP (entand2,entand3,entand4, sortidaretard);


PROCESS (entand2,entand3,entand4)
BEGIN
entand2 <= NOT entand2 AFTER 50 ns;
entand3 <= NOT entand3 AFTER 100 ns;
entand4 <= NOT entand4 AFTER 200 ns;
END PROCESS;
END test_and3;

-- Test de and4:
ARCHITECTURE test_and4 OF banc_de_proves IS

COMPONENT la_porta_and4

PORT (a,b,c,d: IN BIT; z: OUT BIT);

END COMPONENT;

SIGNAL entand5, entand6, entand7,entand8, sortidand3,sortidaretard: BIT; 

FOR DUT6: la_porta_and4 USE ENTITY WORK.and4(logica);
FOR DUT0: la_porta_and4 USE ENTITY WORK.and4(logicaretard);
BEGIN

DUT6: la_porta_and4 PORT MAP (entand5,entand6,entand7,entand8, sortidand3);
DUT0: la_porta_and4 PORT MAP (entand5,entand6,entand7,entand8, sortidaretard);

PROCESS (entand5,entand6,entand7,entand8)
BEGIN
entand5 <= NOT entand5 AFTER 50 ns;
entand6 <= NOT entand6 AFTER 100 ns;
entand7 <= NOT entand7 AFTER 200 ns;
entand8 <= NOT entand8 AFTER 400 ns;
END PROCESS;
END test_and4;

--Test ALL
ARCHITECTURE test_all OF banc_de_proves IS

COMPONENT la_porta_inv
PORT (a: IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT la_porta_and2
PORT (a,b: IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT la_porta_and3
PORT (a,b,c: IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT la_porta_and4
PORT (a,b,c,d: IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT la_porta_or2
PORT (a,b: IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT la_porta_or3
PORT (a,b,c: IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT la_porta_or4
PORT (a,b,c,d: IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT la_porta_xor2
PORT (a,b: IN BIT; z: OUT BIT);
END COMPONENT;

SIGNAL ent0, ent1, ent2, ent3, sort_inversor, sort_and2_logica, sort_and3_logica, sort_and4_logica, sort_or2_logica,sort_or3_logica,sort_or4_logica , sortinvretard, sortand2retard, sortand3retard, sortand4retard, sortor2retard, sortor3retard, sortor4retard, sxor2, sxor2retard: BIT;

FOR DUT7: la_porta_inv USE ENTITY WORK.inversor(logica);
FOR DUT0: la_porta_inv USE ENTITY WORK.inversor(logicaretard);
--
FOR DUT8: la_porta_and2 USE ENTITY WORK.and2(logica);
FOR DUT1: la_porta_and2 USE ENTITY WORK.and2(logicaretard);
--
FOR DUT9: la_porta_and3 USE ENTITY WORK.and3(logica);
FOR DUT2: la_porta_and3 USE ENTITY WORK.and3(logicaretard);
--
FOR DUT10: la_porta_and4 USE ENTITY WORK.and4(logica);
FOR DUT3: la_porta_and4 USE ENTITY WORK.and4(logicaretard);
--
FOR DUT11: la_porta_or2 USE ENTITY WORK.or2(logica);
FOR DUT4: la_porta_or2 USE ENTITY WORK.or2(logicaretard);
--
FOR DUT12: la_porta_or3 USE ENTITY WORK.or3(logica);
FOR DUT5: la_porta_or3 USE ENTITY WORK.or3(logicaretard);
--
FOR DUT13: la_porta_or4 USE ENTITY WORK.or4(logica);
FOR DUT6: la_porta_or4 USE ENTITY WORK.or4(logicaretard);
--
FOR DUT15: la_porta_xor2 USE ENTITY WORK.xor2(logica);
FOR DUT14: la_porta_xor2 USE ENTITY WORK.xor2(logicaretard);

BEGIN

DUT7: la_porta_inv PORT MAP (ent0,sort_inversor);
DUT0: la_porta_inv PORT MAP (ent0,sortinvretard);
--
DUT8: la_porta_and2 PORT MAP (ent0,ent1,sort_and2_logica);
DUT1: la_porta_and2 PORT MAP (ent0,ent1,sortand2retard);
--
DUT9: la_porta_and3 PORT MAP (ent0,ent1,ent2,sort_and3_logica);
DUT2: la_porta_and3 PORT MAP (ent0,ent1,ent2,sortand3retard);
--
DUT10: la_porta_and4 PORT MAP (ent0,ent1,ent2,ent3,sort_and4_logica);
DUT3: la_porta_and4 PORT MAP (ent0,ent1,ent2,ent3,sortand4retard);
--
DUT11: la_porta_or2 PORT MAP (ent0,ent1,sort_or2_logica);
DUT4: la_porta_or2 PORT MAP (ent0,ent1,sortor2retard);
--
DUT12: la_porta_or3 PORT MAP (ent0,ent1,ent2,sort_or3_logica);
DUT5: la_porta_or3 PORT MAP (ent0,ent1,ent2,sortor3retard);
--
DUT13: la_porta_or4 PORT MAP (ent0,ent1,ent2,ent3,sort_or4_logica);
DUT6: la_porta_or4 PORT MAP (ent0,ent1,ent2,ent3,sortor4retard);
--
DUT15: la_porta_xor2 PORT MAP (ent0,ent1,sxor2);
DUT14: la_porta_xor2 PORT MAP (ent0,ent1,sxor2retard);

PROCESS (ent0,ent1,ent2,ent3)
BEGIN
ent0 <= NOT ent0 AFTER 50 ns;
ent1 <= NOT ent1 AFTER 100 ns;
ent2 <= NOT ent2 AFTER 200 ns;
ent3 <= NOT ent3 AFTER 400 ns;
END PROCESS;
END test_all;

-- Test de xor2:
ARCHITECTURE test_xor2 OF banc_de_proves IS

COMPONENT la_porta_xor2

PORT (a,b: IN BIT; z: OUT BIT);

END COMPONENT;

SIGNAL entor1, entor0, sortidaxor1,sortidaretard: BIT; 

FOR DUT1: la_porta_xor2 USE ENTITY WORK.xor2(logica);
FOR DUT2: la_porta_xor2 USE ENTITY WORK.xor2(logicaretard);

BEGIN

DUT1: la_porta_xor2 PORT MAP (entor1,entor0,sortidaxor1);
DUT2: la_porta_xor2 PORT MAP (entor1,entor0,sortidaretard);


PROCESS (entor1,entor0)
BEGIN
entor1 <= NOT entor1 AFTER 50 ns;
entor0 <= NOT entor0 AFTER 100 ns;
END PROCESS;
END test_xor2;