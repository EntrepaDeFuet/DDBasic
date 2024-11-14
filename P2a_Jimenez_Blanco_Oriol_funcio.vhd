ENTITY banc_de_proves IS
END banc_de_proves;

-- Funcio Lógica Pràctica 2:

ENTITY funcio_logica IS
PORT (a,b,c: IN BIT; f: OUT BIT);
END funcio_logica;

ARCHITECTURE logica OF funcio_logica IS
BEGIN
f <= (((NOT a)AND b)OR((NOT c)AND a));
END logica;

ARCHITECTURE logicaretard OF funcio_logica IS
BEGIN
f <= (((NOT a)AND b)OR((NOT c)AND a)) AFTER 5 ns;
END logicaretard;

ARCHITECTURE estructural OF funcio_logica IS
COMPONENT portaand2 IS
PORT (a,b: IN BIT; z: OUT BIT);
END COMPONENT;
COMPONENT portaor2 IS
PORT (a,b: IN BIT; z: OUT BIT);
END COMPONENT;
COMPONENT portainv IS
PORT (a: IN BIT; z: OUT BIT);
END COMPONENT;

SIGNAL inva, invc, alpha, beta: BIT;

FOR DUT1: portainv USE ENTITY WORK.inversor(logicaretard);
FOR DUT2: portainv USE ENTITY WORK.inversor(logicaretard);
FOR DUT3: portaand2 USE ENTITY WORK.and2(logicaretard);
FOR DUT4: portaand2 USE ENTITY WORK.and2(logicaretard);
FOR DUT5: portaor2 USE ENTITY WORK.or2(logicaretard);

BEGIN
	DUT1: portainv PORT MAP(A,inva);
	DUT2: portainv PORT MAP(C,invc);
	DUT3: portaand2 PORT MAP(inva,B,alpha);
	DUT4: portaand2 PORT MAP(A,invc,beta);
	DUT5: portaor2 PORT MAP(alpha,beta,f);
END estructural;

-- Test Funció lògica:

ARCHITECTURE test_de_proves OF banc_de_proves IS

COMPONENT bloc_que_simulem IS
PORT(A,B,C: IN bit;
	f: OUT bit);
END COMPONENT;

SIGNAL senyalA,senyalB,senyalC: BIT;
SIGNAL sortida_f_logica, sortida_f_logica_r, sortida_f_estructural: BIT;

FOR DUT1: bloc_que_simulem USE ENTITY WORK.funcio_logica(logica);
FOR DUT1_R: bloc_que_simulem USE ENTITY WORK.funcio_logica(logicaretard);
FOR DUT2: bloc_que_simulem USE ENTITY WORK.funcio_logica(estructural);

BEGIN
DUT1: bloc_que_simulem PORT MAP(senyalA, senyalB, senyalC, sortida_f_logica);
DUT1_R: bloc_que_simulem PORT MAP(senyalA, senyalB, senyalC, sortida_f_logica_r);
DUT2: bloc_que_simulem PORT MAP(senyalA, senyalB, senyalC, sortida_f_estructural);
PROCESS (senyalA, senyalB, senyalC)
	BEGIN
senyalA <= NOT senyalA AFTER 200 ns;
senyalB <= NOT senyalB AFTER 100 ns;
senyalC <= NOT senyalC AFTER 50 ns;
	END PROCESS;
END test_de_proves;

-- Funcio f=(/a·b·/c+b·/d+a·c·d+a·/d) XOR (a+/d):

ENTITY funcio IS
PORT (a,b,c,d: IN BIT; f: OUT BIT);
END funcio;

ARCHITECTURE logica OF funcio IS
BEGIN
f <= (((NOT a)AND b AND (NOT c))OR (d AND (NOT d)) OR (a AND c AND d)OR(a AND (NOT d))) XOR (a AND (NOT d));
END logica;

ARCHITECTURE logicaretard OF funcio IS
BEGIN
f <= (((NOT a)AND b AND (NOT c))OR (d AND (NOT d)) OR (a AND c AND d)OR(a AND (NOT d))) XOR (a AND (NOT d)) AFTER 5 ns;
END logicaretard;

-- ESTRUCTURAL:

ARCHITECTURE estructural OF funcio IS
COMPONENT portaand2 IS
PORT (a,b: IN BIT; z: OUT BIT);
END COMPONENT;
COMPONENT portaand3 IS
PORT (a,b,c: IN BIT; z: OUT BIT);
END COMPONENT;
COMPONENT portaor4 IS
PORT (a,b,c,d: IN BIT; z: OUT BIT);
END COMPONENT;
COMPONENT portaxor2 IS
PORT (a,b: IN BIT; z: OUT BIT);
END COMPONENT;
COMPONENT portainv IS
PORT (a: IN BIT; z: OUT BIT);
END COMPONENT;

SIGNAL inva, invc, invd, alpha, beta, gamma, omega, x: BIT;

FOR DUT1: portainv USE ENTITY WORK.inversor(logica);
FOR DUT2: portainv USE ENTITY WORK.inversor(logica);
FOR DUT3: portainv USE ENTITY WORK.inversor(logica);
FOR DUT4: portaand3 USE ENTITY WORK.and3(logica);
FOR DUT5: portaand3 USE ENTITY WORK.and3(logica);
FOR DUT6: portaand3 USE ENTITY WORK.and3(logica);
FOR DUT7: portaand2 USE ENTITY WORK.and2(logica);
FOR DUT8: portaor4 USE ENTITY WORK.or4(logica);
FOR DUT9: portaxor2 USE ENTITY WORK.xor2(logica);


BEGIN
	DUT1: portainv PORT MAP(A,inva);
	DUT2: portainv PORT MAP(C,invc);
	DUT3: portainv PORT MAP(D,invd);
	DUT4: portaand3 PORT MAP(inva,B,invc,beta);
	DUT5: portaand3 PORT MAP(invc,B,invd,alpha);
	DUT6: portaand3 PORT MAP(A,C,D,gamma);
	DUT7: portaand2 PORT MAP(A,invd,omega);
	DUT8: portaor4 PORT MAP(alpha,beta,gamma,omega,x);
	DUT9: portaxor2 PORT MAP(x,omega,f);

END estructural;

-- ESTRUCTURAL_R:

ARCHITECTURE estructural_R OF funcio IS
COMPONENT portaand2 IS
PORT (a,b: IN BIT; z: OUT BIT);
END COMPONENT;
COMPONENT portaand3 IS
PORT (a,b,c: IN BIT; z: OUT BIT);
END COMPONENT;
COMPONENT portaor4 IS
PORT (a,b,c,d: IN BIT; z: OUT BIT);
END COMPONENT;
COMPONENT portaxor2 IS
PORT (a,b: IN BIT; z: OUT BIT);
END COMPONENT;
COMPONENT portainv IS
PORT (a: IN BIT; z: OUT BIT);
END COMPONENT;

SIGNAL inva, invc, invd, alpha, beta, gamma, omega, x: BIT;

FOR DUT1: portainv USE ENTITY WORK.inversor(logicaretard);
FOR DUT2: portainv USE ENTITY WORK.inversor(logicaretard);
FOR DUT3: portainv USE ENTITY WORK.inversor(logicaretard);
FOR DUT4: portaand3 USE ENTITY WORK.and3(logicaretard);
FOR DUT5: portaand3 USE ENTITY WORK.and3(logicaretard);
FOR DUT6: portaand3 USE ENTITY WORK.and3(logicaretard);
FOR DUT7: portaand2 USE ENTITY WORK.and2(logicaretard);
FOR DUT8: portaor4 USE ENTITY WORK.or4(logicaretard);
FOR DUT9: portaxor2 USE ENTITY WORK.xor2(logicaretard);


BEGIN
	DUT1: portainv PORT MAP(A,inva);
	DUT2: portainv PORT MAP(C,invc);
	DUT3: portainv PORT MAP(D,invd);
	DUT4: portaand3 PORT MAP(inva,B,invc,beta);
	DUT5: portaand3 PORT MAP(invc,B,invd,alpha);
	DUT6: portaand3 PORT MAP(A,C,D,gamma);
	DUT7: portaand2 PORT MAP(A,invd,omega);
	DUT8: portaor4 PORT MAP(alpha,beta,gamma,omega,x);
	DUT9: portaxor2 PORT MAP(x,omega,f);

END estructural_R;

-- Execucio:

ARCHITECTURE proves OF banc_de_proves IS

COMPONENT bloc_que_simulem IS
PORT(A,B,C,D: IN bit;
	f: OUT bit);
END COMPONENT;

SIGNAL senyalA,senyalB,senyalC,senyalD: BIT;
SIGNAL sortida_f_logica, sortida_f_logica_r, sortida_f_estructural,sortida_f_estructural_r: BIT;

FOR DUT1: bloc_que_simulem USE ENTITY WORK.funcio(logica);
FOR DUT1_R: bloc_que_simulem USE ENTITY WORK.funcio(logicaretard);
FOR DUT2: bloc_que_simulem USE ENTITY WORK.funcio(estructural);
FOR DUT2_R: bloc_que_simulem USE ENTITY WORK.funcio(estructural_R);

	BEGIN

DUT1: bloc_que_simulem PORT MAP(senyalA, senyalB, senyalC,senyalD, sortida_f_logica);
DUT1_R: bloc_que_simulem PORT MAP(senyalA, senyalB, senyalC,senyalD, sortida_f_logica_r);
DUT2: bloc_que_simulem PORT MAP(senyalA, senyalB, senyalC,senyalD, sortida_f_estructural);
DUT2_R: bloc_que_simulem PORT MAP(senyalA, senyalB, senyalC,senyalD, sortida_f_estructural_r);

PROCESS (senyalA, senyalB, senyalC,senyalD)

	BEGIN

senyalD <= NOT senyalD AFTER 400 ns;
senyalA <= NOT senyalA AFTER 200 ns;
senyalB <= NOT senyalB AFTER 100 ns;
senyalC <= NOT senyalC AFTER 50 ns;

	END PROCESS;
END proves;
