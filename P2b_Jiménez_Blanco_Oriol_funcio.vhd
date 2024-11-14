-- d) S'observa a 770 ns una dent que dura 10ns en estructural_r això és degut al retard acumulat de les funcions internes. Doncs el retard no es produeix al final de la operacio sinó per cada una de les operacions. També s'observa el fet de que el retard es major per el mateix motiu.
-- f) Són tan diferents degut a que el propi retard en funció de la variació de les senyals és molt gran, provocant així que el propi retard actuï com una senyal més. 

ENTITY banc_de_proves IS
END banc_de_proves;

-- Funcio 2.

ENTITY funcio_2 IS
PORT (a,b,c,d: IN BIT; f: OUT BIT);
END funcio_2;

-- Logica

ARCHITECTURE logica OF funcio_2 IS
BEGIN
f <= (a AND c AND (a XOR d)) OR ((NOT b)AND c);
END logica;

-- Logicaretard: 

ARCHITECTURE logicaretard OF funcio_2 IS
BEGIN
f <= (a AND c AND (a XOR d)) OR ((NOT b)AND c) AFTER 5 ns;
END logicaretard;

-- Estructural:

ARCHITECTURE estructural OF funcio_2 IS
COMPONENT portaand2 IS
PORT (a,b: IN BIT; z: OUT BIT);
END COMPONENT;
COMPONENT portaand3 IS
PORT (a,b,c: IN BIT; z: OUT BIT);
END COMPONENT;
COMPONENT portaor2 IS
PORT (a,b: IN BIT; z: OUT BIT);
END COMPONENT;
COMPONENT portaxor2 IS
PORT (a,b: IN BIT; z: OUT BIT);
END COMPONENT;
COMPONENT portainv IS
PORT (a: IN BIT; z: OUT BIT);
END COMPONENT;

SIGNAL  invb, alpha, beta, gamma: BIT;

FOR DUT1: portainv USE ENTITY WORK.inversor(logica);
FOR DUT2: portaand2 USE ENTITY WORK.and2(logica);
FOR DUT3: portaxor2 USE ENTITY WORK.xor2(logica);
FOR DUT4: portaand3 USE ENTITY WORK.and3(logica);
FOR DUT5: portaor2 USE ENTITY WORK.or2(logica);



BEGIN
	DUT1: portainv PORT MAP(B,invb);
	DUT2: portaand2 PORT MAP(invb,c,alpha);
	DUT3: portaxor2 PORT MAP(a,d,beta);
	DUT4: portaand3 PORT MAP(a,beta,c,gamma);
	DUT5: portaor2 PORT MAP(alpha, gamma, f);


END estructural;

-- Estructural_r:

ARCHITECTURE estructural_r OF funcio_2 IS
COMPONENT portaand2 IS
PORT (a,b: IN BIT; z: OUT BIT);
END COMPONENT;
COMPONENT portaand3 IS
PORT (a,b,c: IN BIT; z: OUT BIT);
END COMPONENT;
COMPONENT portaor2 IS
PORT (a,b: IN BIT; z: OUT BIT);
END COMPONENT;
COMPONENT portaxor2 IS
PORT (a,b: IN BIT; z: OUT BIT);
END COMPONENT;
COMPONENT portainv IS
PORT (a: IN BIT; z: OUT BIT);
END COMPONENT;

SIGNAL  invb, alpha, beta, gamma: BIT;

FOR DUT1: portainv USE ENTITY WORK.inversor(logicaretard);
FOR DUT2: portaand2 USE ENTITY WORK.and2(logicaretard);
FOR DUT3: portaxor2 USE ENTITY WORK.xor2(logicaretard);
FOR DUT4: portaand3 USE ENTITY WORK.and3(logicaretard);
FOR DUT5: portaor2 USE ENTITY WORK.or2(logicaretard);



BEGIN
	DUT1: portainv PORT MAP(B,invb);
	DUT2: portaand2 PORT MAP(invb,c,alpha);
	DUT3: portaxor2 PORT MAP(a,d,beta);
	DUT4: portaand3 PORT MAP(a,beta,c,gamma);
	DUT5: portaor2 PORT MAP(alpha, gamma, f);


END estructural_r;

-- Execucio:

ARCHITECTURE proves_2 OF banc_de_proves IS

COMPONENT bloc_que_simulem IS
PORT(A,B,C,D: IN bit;
	f: OUT bit);
END COMPONENT;

SIGNAL senyalA,senyalB,senyalC,senyalD: BIT;
SIGNAL sortida_f_logica, sortida_f_logica_r, sortida_f_estructural,sortida_f_estructural_r: BIT;

FOR DUT1: bloc_que_simulem USE ENTITY WORK.funcio_2(logica);
FOR DUT1_R: bloc_que_simulem USE ENTITY WORK.funcio_2(logicaretard);
FOR DUT2: bloc_que_simulem USE ENTITY WORK.funcio_2(estructural);
FOR DUT2_R: bloc_que_simulem USE ENTITY WORK.funcio_2(estructural_R);

	BEGIN

DUT1: bloc_que_simulem PORT MAP(senyalA, senyalB, senyalC,senyalD, sortida_f_logica);
DUT1_R: bloc_que_simulem PORT MAP(senyalA, senyalB, senyalC,senyalD, sortida_f_logica_r);
DUT2: bloc_que_simulem PORT MAP(senyalA, senyalB, senyalC,senyalD, sortida_f_estructural);
DUT2_R: bloc_que_simulem PORT MAP(senyalA, senyalB, senyalC,senyalD, sortida_f_estructural_r);

PROCESS (senyalA, senyalB, senyalC,senyalD)

	BEGIN

senyalD <= NOT senyalD AFTER 400 ns;
senyalC <= NOT senyalC AFTER 200 ns;
senyalB <= NOT senyalB AFTER 100 ns;
senyalA <= NOT senyalA AFTER 50 ns;

	END PROCESS;
END proves_2;

-- Proves ràpides:

ARCHITECTURE proves_rapid OF banc_de_proves IS

COMPONENT bloc_que_simulem IS
PORT(A,B,C,D: IN bit;
	f: OUT bit);
END COMPONENT;

SIGNAL senyalA,senyalB,senyalC,senyalD: BIT;
SIGNAL sortida_f_logica, sortida_f_logica_r, sortida_f_estructural,sortida_f_estructural_r: BIT;

FOR DUT1: bloc_que_simulem USE ENTITY WORK.funcio_2(logica);
FOR DUT1_R: bloc_que_simulem USE ENTITY WORK.funcio_2(logicaretard);
FOR DUT2: bloc_que_simulem USE ENTITY WORK.funcio_2(estructural);
FOR DUT2_R: bloc_que_simulem USE ENTITY WORK.funcio_2(estructural_R);

	BEGIN

DUT1: bloc_que_simulem PORT MAP(senyalA, senyalB, senyalC,senyalD, sortida_f_logica);
DUT1_R: bloc_que_simulem PORT MAP(senyalA, senyalB, senyalC,senyalD, sortida_f_logica_r);
DUT2: bloc_que_simulem PORT MAP(senyalA, senyalB, senyalC,senyalD, sortida_f_estructural);
DUT2_R: bloc_que_simulem PORT MAP(senyalA, senyalB, senyalC,senyalD, sortida_f_estructural_r);

PROCESS (senyalA, senyalB, senyalC,senyalD)

	BEGIN

senyalD <= NOT senyalD AFTER 40 ns;
senyalC <= NOT senyalC AFTER 20 ns;
senyalB <= NOT senyalB AFTER 10 ns;
senyalA <= NOT senyalA AFTER 5 ns;

	END PROCESS;
END proves_rapid;