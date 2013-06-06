:-index(tiempo(1,1,1,1,0)).

% ----------------------------------------------------------------------
% Factores necesarios para componer el tiempo de trayecto a partir
% de los tiempos de viaje entre estaciones. Son dependientes de la
% l�nea (?).
% ----------------------------------------------------------------------
offset(1,90).
offset(2,119.6).
offset(3,74.6).
offset(4,104.6).
offset(5,119.6).
offset(6,112.5).
offset(7,172).
offset(8,105).
offset(9,105).
offset(10,90).
offset(10,149.6).
offset(11,179.6).
offset(12,165).

offset('R',0).
offset(ml1,149.6).
offset(ml2,224.6).
offset(ml3,225).


% ----------------------------------------------------------------------
% Cuando en el plano del metro los enlaces se consideran "cortos" se
% asigna un tiempo de 60 sg general para cualquier cambio de l�nea.
% ----------------------------------------------------------------------
% L�nea 1 (90)
% ----------------------------------------------------------------------
tiempo(1,'Pinar de Chamart�n',1,'Bamb�',383).
tiempo(1,'Bamb�',1,'Chamart�n',328).
tiempo(1,'Chamart�n',1,'Plaza de Castilla',276). %Igual tiempo sobre l�nea 10
tiempo(1,'Plaza de Castilla',1,'Valdeacederas',264).
tiempo(1,'Valdeacederas',1,'Tetu�n',271).
tiempo(1,'Tetu�n',1,'Estrecho',305).
tiempo(1,'Estrecho',1,'Alvarado',268).
tiempo(1,'Alvarado',1,'Cuatro Caminos',251).
tiempo(1,'Cuatro Caminos',1,'R�os Rosas',264).
tiempo(1,'R�os Rosas',1,'Iglesia',301).
tiempo(1,'Iglesia',1,'Bilbao',295).
tiempo(1,'Bilbao',1,'Tribunal',258).
tiempo(1,'Tribunal',1,'Gran V�a',293).
tiempo(1,'Gran V�a',1,'Sol',233).
tiempo(1,'Sol',1,'Tirso de Molina',290).
tiempo(1,'Tirso de Molina',1,'Ant�n Mart�n',260).
tiempo(1,'Ant�n Mart�n',1,'Atocha',291).
tiempo(1,'Atocha',1,'Atocha Renfe',230).
tiempo(1,'Atocha Renfe',1,'Men�ndez Pelayo',295).
tiempo(1,'Men�ndez Pelayo',1,'Pac�fico',267).
tiempo(1,'Pac�fico',1,'Puente de Vallecas',296).
tiempo(1,'Puente de Vallecas',1,'Nueva Numancia',256).
tiempo(1,'Nueva Numancia',1,'Portazgo',274).
tiempo(1,'Portazgo',1,'Buenos Aires',272).
tiempo(1,'Buenos Aires',1,'Alto del Arenal',287).
tiempo(1,'Alto del Arenal',1,'Miguel Hern�ndez',283).
tiempo(1,'Miguel Hern�ndez',1,'Sierra de Guadalupe',398).
tiempo(1,'Sierra de Guadalupe',1,'Villa de Vallecas',263).
tiempo(1,'Villa de Vallecas',1,'Congosto',310).
tiempo(1,'Congosto',1,'La Gavia',375).
tiempo(1,'La Gavia',1,'Las Suertes',180).
tiempo(1,'Las Suertes',1,'Valdecarros',258).

% tiempos de correspondencias
tiempo(1,'Pinar de Chamart�n',ml1,'Pinar de Chamart�n',60).
tiempo(1,'Pinar de Chamart�n',4,'Pinar de Chamart�n',60).
tiempo(1,'Chamart�n',10,'Chamart�n',60).
tiempo(1,'Plaza de Castilla',9,'Plaza de Castilla',60).
tiempo(1,'Plaza de Castilla',10,'Plaza de Castilla',60).
tiempo(1,'Cuatro Caminos',2,'Cuatro Caminos',60).
tiempo(1,'Cuatro Caminos',6,'Cuatro Caminos',60).
tiempo(1,'Bilbao',4,'Bilbao',60).
tiempo(1,'Tribunal',10,'Tribunal',60).
tiempo(1,'Gran V�a',5,'Gran V�a',60).
tiempo(1,'Sol',2,'Sol',60).
tiempo(1,'Sol',3,'Sol',60).
tiempo(1,'Pac�fico',6,'Pac�fico',60).


% ----------------------------------------------------------------------
% L�nea 2 (120)
% ----------------------------------------------------------------------
tiempo(2,'La Elipa',2,'Ventas',539).
tiempo(2,'Ventas',2,'Manuel Becerra',371).
tiempo(2,'Manuel Becerra',2,'Goya',373).
tiempo(2,'Goya',2,'Pr�ncipe de Vergara',328).
tiempo(2,'Pr�ncipe de Vergara',2,'Retiro',353).
tiempo(2,'Retiro',2,'Banco de Espa�a',397).
tiempo(2,'Banco de Espa�a',2,'Sevilla',336).
tiempo(2,'Sevilla',2,'Sol',312).
tiempo(2,'Sol',2,'�pera',343).
tiempo(2,'�pera',2,'Santo Domingo',331).
tiempo(2,'Santo Domingo',2,'Noviciado',326).
tiempo(2,'Noviciado',2,'San Bernardo',372).
tiempo(2,'San Bernardo',2,'Quevedo',299).
tiempo(2,'Quevedo',2,'Canal',392).
tiempo(2,'Canal',2,'Cuatro Caminos',397).

% tiempos de correspondencias
tiempo(2,'Ventas',5,'Ventas',60).
tiempo(2,'Manuel Becerra',6,'Manuel Becerra',60).
tiempo(2,'Goya',4,'Goya',60).
tiempo(2,'Pr�ncipe de Vergara',9,'Pr�ncipe de Vergara',60).
tiempo(2,'Sol',1,'Sol',60).
tiempo(2,'Sol',3,'Sol',60).
tiempo(2,'�pera',5,'�pera',60).
tiempo(2,'�pera','R','�pera',60).
tiempo(2,'Noviciado',3,'Plaza de Espa�a',300). % Anomal�a
tiempo(2,'Noviciado',10,'Plaza de Espa�a',300).% Anomal�a
tiempo(2,'San Bernardo',4,'San Bernardo',60).
tiempo(2,'Canal',7,'Canal',60).
tiempo(2,'Cuatro Caminos',1,'Cuatro Caminos',60).
tiempo(2,'Cuatro Caminos',6,'Cuatro Caminos',60).

% ----------------------------------------------------------------------
% L�nea 3 (75)
% ----------------------------------------------------------------------
tiempo(3,'Villaverde Alto',3,'San Crist�bal',419).
tiempo(3,'San Crist�bal',3,'Villaverde Bajo-Cruce',308).
tiempo(3,'Villaverde Bajo-Cruce',3,'Ciudad de los �ngeles',324).
tiempo(3,'Ciudad de los �ngeles',3,'San Ferm�n-Orcasur',309).
tiempo(3,'San Ferm�n-Orcasur',3,'Hospital 12 de Octubre',235).
tiempo(3,'Hospital 12 de Octubre',3,'Almendrales',287).
tiempo(3,'Almendrales',3,'Legazpi',284).
tiempo(3,'Legazpi',3,'Delicias',266).
tiempo(3,'Delicias',3,'Palos de la Frontera',224).
tiempo(3,'Palos de la Frontera',3,'Embajadores',267).
tiempo(3,'Embajadores',3,'Lavapi�s',219).
tiempo(3,'Lavapi�s',3,'Sol',295).
tiempo(3,'Sol',3,'Callao',217).
tiempo(3,'Callao',3,'Plaza de Espa�a',235).
tiempo(3,'Plaza de Espa�a',3,'Ventura Rodr�guez',214).
tiempo(3,'Ventura Rodr�guez',3,'Arg�elles',220).
tiempo(3,'Arg�elles',3,'Moncloa',209).

% tiempos de correspondencias
tiempo(3,'Legazpi',6,'Legazpi',60).
tiempo(3,'Embajadores',5,'Acacias',420).%Anomal�a
tiempo(3,'Sol',1,'Sol',60).
tiempo(3,'Sol',2,'Sol',60).
tiempo(3,'Callao',5,'Callao',60).
tiempo(3,'Plaza de Espa�a',2,'Noviciado',300). %Anomal�a
tiempo(3,'Plaza de Espa�a',10,'Plaza de Espa�a',60).
tiempo(3,'Arg�elles',4,'Arg�elles',60).
tiempo(3,'Arg�elles',6,'Arg�elles',60).
tiempo(3,'Moncloa',6,'Moncloa',60).

% ----------------------------------------------------------------------
% L�nea 4 (105)
% ----------------------------------------------------------------------
tiempo(4,'Arg�elles',4,'San Bernardo',350).
tiempo(4,'San Bernardo',4,'Bilbao',276).
tiempo(4,'Bilbao',4,'Alonso Mart�nez',284).
tiempo(4,'Alonso Mart�nez',4,'Col�n',274).
tiempo(4,'Col�n',4,'Serrano',295).
tiempo(4,'Serrano',4,'Vel�zquez',272).
tiempo(4,'Vel�zquez',4,'Goya',293).
tiempo(4,'Goya',4,'Lista',306).
tiempo(4,'Lista',4,'Diego de Le�n',306).
tiempo(4,'Diego de Le�n',4,'Avenida de Am�rica',298).
tiempo(4,'Avenida de Am�rica',4,'Prosperidad',344).
tiempo(4,'Prosperidad',4,'Alfonso XIII',356).
tiempo(4,'Alfonso XIII',4,'Avenida de la Paz',318).
tiempo(4,'Avenida de la Paz',4,'Arturo Soria',340).
tiempo(4,'Arturo Soria',4,'Esperanza',352).
tiempo(4,'Esperanza',4,'Canillas',430).
tiempo(4,'Canillas',4,'Mar de Cristal',318).
tiempo(4,'Mar de Cristal',4,'San Lorenzo',292).
tiempo(4,'San Lorenzo',4,'Parque de Santa Mar�a',327).
tiempo(4,'Parque de Santa Mar�a',4,'Hortaleza',339).
tiempo(4,'Hortaleza',4,'Manoteras',408).
tiempo(4,'Manoteras',4,'Pinar de Chamart�n',302).

% tiempos de correspondencias
tiempo(4,'Arg�elles',3,'Arg�elles',60).
tiempo(4,'Arg�elles',6,'Arg�elles',60).
tiempo(4,'San Bernardo',2,'San Bernardo',60).
tiempo(4,'Bilbao',1,'Bilbao',60).
tiempo(4,'Alonso Mart�nez',5,'Alonso Mart�nez',60).
tiempo(4,'Alonso Mart�nez',10,'Alonso Mart�nez',60).
tiempo(4,'Goya',2,'Goya',60).
tiempo(4,'Diego de Le�n',5,'Diego de Le�n',300).
tiempo(4,'Diego de Le�n',6,'Diego de Le�n',540).
tiempo(4,'Avenida de Am�rica',6,'Avenida de Am�rica',60).
tiempo(4,'Avenida de Am�rica',7,'Avenida de Am�rica',60).
tiempo(4,'Avenida de Am�rica',9,'Avenida de Am�rica',60).
tiempo(4,'Mar de Cristal',8,'Mar de Cristal',60).
tiempo(4,'Pinar de Chamart�n',1,'Pinar de Chamart�n',60).
tiempo(4,'Pinar de Chamart�n',ml1,'Pinar de Chamart�n',60).

% ----------------------------------------------------------------------
% L�nea 5 (120)
% ----------------------------------------------------------------------
tiempo(5,'Alameda de Osuna',5,'El Capricho',355).
tiempo(5,'El Capricho',5,'Canillejas',462).
tiempo(5,'Canillejas',5,'Torre Arias',395).
tiempo(5,'Torre Arias',5,'Suanzes',360).
tiempo(5,'Suanzes',5,'Ciudad Lineal',388).
tiempo(5,'Ciudad Lineal',5,'Pueblo Nuevo',326).
tiempo(5,'Pueblo Nuevo',5,'Quintana',322).
tiempo(5,'Quintana',5,'El Carmen',351).
tiempo(5,'El Carmen',5,'Ventas',347).
tiempo(5,'Ventas',5,'Diego de Le�n',378).
tiempo(5,'Diego de Le�n',5,'N��ez de Balboa',344).
tiempo(5,'N��ez de Balboa',5,'Rub�n Dar�o',343).
tiempo(5,'Rub�n Dar�o',5,'Alonso Mart�nez',350).
tiempo(5,'Alonso Mart�nez',5,'Chueca',348).
tiempo(5,'Chueca',5,'Gran V�a',317).
tiempo(5,'Gran V�a',5,'Callao',293).
tiempo(5,'Callao',5,'�pera',316).
tiempo(5,'�pera',5,'La Latina',360).
tiempo(5,'La Latina',5,'Puerta de Toledo',332).
tiempo(5,'Puerta de Toledo',5,'Acacias',379).
tiempo(5,'Acacias',5,'Pir�mides',324).
tiempo(5,'Pir�mides',5,'Marqu�s de Vadillo',359).
tiempo(5,'Marqu�s de Vadillo',5,'Urgel',359).
tiempo(5,'Urgel',5,'Oporto',343).
tiempo(5,'Oporto',5,'Vista Alegre',354).
tiempo(5,'Vista Alegre',5,'Carabanchel',338).
tiempo(5,'Carabanchel',5,'Eugenia de Montijo',330).
tiempo(5,'Eugenia de Montijo',5,'Aluche',386).
tiempo(5,'Aluche',5,'Empalme',345).
tiempo(5,'Empalme',5,'Campamento',310).
tiempo(5,'Campamento',5,'Casa de Campo',426).

% tiempos de correspondencias
tiempo(5,'Pueblo Nuevo',7,'Pueblo Nuevo',60).
tiempo(5,'Ventas',2,'Ventas',60).
tiempo(5,'Diego de Le�n',4,'Diego de Le�n',300).
tiempo(5,'Diego de Le�n',6,'Diego de Le�n',300).
tiempo(5,'N��ez de Balboa',9,'N��ez de Balboa',360).
tiempo(5,'Alonso Mart�nez',4,'Alonso Mart�nez',60).
tiempo(5,'Alonso Mart�nez',10,'Alonso Mart�nez',60).
tiempo(5,'Gran V�a',1,'Gran V�a',60).
tiempo(5,'Callao',3,'Callao',60).
tiempo(5,'�pera','2','�pera',60).
tiempo(5,'�pera','R','�pera',60).
tiempo(5,'Acacias',3,'Embajadores',420).%Anomal�a
tiempo(5,'Oporto',6,'Oporto',60).
tiempo(5,'Casa de Campo',10,'Casa de Campo',60).

% ----------------------------------------------------------------------
% L�nea 6 (112.5)
% ----------------------------------------------------------------------
tiempo(6,'Laguna',6,'Carpetana',325).
tiempo(6,'Carpetana',6,'Oporto',354).
tiempo(6,'Oporto',6,'Opa�el',334).
tiempo(6,'Opa�el',6,'Plaza El�ptica',325).
tiempo(6,'Plaza El�ptica',6,'Usera',363).
tiempo(6,'Usera',6,'Legazpi',367).
tiempo(6,'Legazpi',6,'Arganzuela-Planetario',321).
tiempo(6,'Arganzuela-Planetario',6,'M�ndez �lvaro',339).
tiempo(6,'M�ndez �lvaro',6,'Pac�fico',349).
tiempo(6,'Pac�fico',6,'Conde de Casal',331).
tiempo(6,'Conde de Casal',6,'Sainz de Baranda',344).
tiempo(6,'Sainz de Baranda',6,'O�Donnell',335).
tiempo(6,'O�Donnell',6,'Manuel Becerra',313).
tiempo(6,'Manuel Becerra',6,'Diego de Le�n',333).
tiempo(6,'Diego de Le�n',6,'Avenida de Am�rica',298).
tiempo(6,'Avenida de Am�rica',6,'Rep�blica Argentina',351).
tiempo(6,'Rep�blica Argentina',6,'Nuevos Ministerios',362).
tiempo(6,'Nuevos Ministerios',6,'Cuatro Caminos',334).
tiempo(6,'Cuatro Caminos',6,'Guzm�n el Bueno',332).
tiempo(6,'Guzm�n el Bueno',6,'Metropolitano',317).
tiempo(6,'Metropolitano',6,'Ciudad Universitaria',324).
tiempo(6,'Ciudad Universitaria',6,'Moncloa',416).
tiempo(6,'Moncloa',6,'Arg�elles',209). % Igual a tiempo sobre l�nea 3
tiempo(6,'Arg�elles',6,'Pr�ncipe P�o',420).
tiempo(6,'Pr�ncipe P�o',6,'Puerta del �ngel',390).
tiempo(6,'Puerta del �ngel',6,'Alto de Extremadura',373).
tiempo(6,'Alto de Extremadura',6,'Lucero',359).
tiempo(6,'Lucero',6,'Laguna',325).

% tiempos de correspondencias
tiempo(6,'Oporto',5,'Oporto',60).
tiempo(6,'Plaza El�ptica',11,'Plaza El�ptica',60).
tiempo(6,'Legazpi',3,'Legazpi',60).
tiempo(6,'Pac�fico',1,'Pac�fico',60).
tiempo(6,'Sainz de Baranda',9,'Sainz de Baranda',60).
tiempo(6,'Manuel Becerra',2,'Manuel Becerra',60).
tiempo(6,'Diego de Le�n',4,'Diego de Le�n',540).
tiempo(6,'Diego de Le�n',5,'Diego de Le�n',300).
tiempo(6,'Avenida de Am�rica',4,'Avenida de Am�rica',60).
tiempo(6,'Avenida de Am�rica',7,'Avenida de Am�rica',60).
tiempo(6,'Avenida de Am�rica',9,'Avenida de Am�rica',60).
tiempo(6,'Nuevos Ministerios',8,'Nuevos Ministerios',420).
tiempo(6,'Nuevos Ministerios',10,'Nuevos Ministerios',420).
tiempo(6,'Cuatro Caminos',1,'Cuatro Caminos',60).
tiempo(6,'Cuatro Caminos',2,'Cuatro Caminos',60).
tiempo(6,'Guzm�n el Bueno',7,'Guzm�n el Bueno',60).
tiempo(6,'Moncloa',3,'Moncloa',60).
tiempo(6,'Arg�elles',3,'Arg�elles',60).
tiempo(6,'Arg�elles',4,'Arg�elles',60).
tiempo(6,'Pr�ncipe P�o',10,'Pr�ncipe P�o',60).
tiempo(6,'Pr�ncipe P�o','R','Pr�ncipe P�o',60).


% ----------------------------------------------------------------------
% L�nea 7 (172)
% ----------------------------------------------------------------------
tiempo(7,'Hospital del Henares',7,'Henares',425).
tiempo(7,'Henares',7,'Jarama',452).
tiempo(7,'Jarama',7,'San Fernando',501).
tiempo(7,'San Fernando',7,'La Rambla',518).
tiempo(7,'La Rambla',7,'Coslada Central',464).
tiempo(7,'Coslada Central',7,'Barrio del Puerto',408).
tiempo(7,'Barrio del Puerto',7,'Estadio Ol�mpico',733).
tiempo(7,'Estadio Ol�mpico',7,'Las Musas',326).
tiempo(7,'Las Musas',7,'San Blas',386).
tiempo(7,'San Blas',7,'Simancas',382).
tiempo(7,'Simancas',7,'Garc�a Noblejas',378).
tiempo(7,'Garc�a Noblejas',7,'Ascao',374).
tiempo(7,'Ascao',7,'Pueblo Nuevo',365).
tiempo(7,'Pueblo Nuevo',7,'Barrio de la Concepci�n',399).
tiempo(7,'Barrio de la Concepci�n',7,'Parque de las Avenidas',393).
tiempo(7,'Parque de las Avenidas',7,'Cartagena',365).
tiempo(7,'Cartagena',7,'Avenida de Am�rica',367).
tiempo(7,'Avenida de Am�rica',7,'Gregorio Mara��n',414).
tiempo(7,'Gregorio Mara��n',7,'Alonso Cano',353).
tiempo(7,'Alonso Cano',7,'Canal',333).
tiempo(7,'Canal',7,'Islas Filipinas',371).
tiempo(7,'Islas Filipinas',7,'Guzm�n el Bueno',464).
tiempo(7,'Guzm�n el Bueno',7,'Francos Rodr�guez',421).
tiempo(7,'Francos Rodr�guez',7,'Valdezarza',429).
tiempo(7,'Valdezarza',7,'Antonio Machado',387).
tiempo(7,'Antonio Machado',7,'Pe�agrande',357).
tiempo(7,'Pe�agrande',7,'Avenida de la Ilustraci�n',342).
tiempo(7,'Avenida de la Ilustraci�n',7,'Lacoma',360).
tiempo(7,'Lacoma',7,'Pitis',439).

% tiempos de correspondencias
tiempo(7,'Pueblo Nuevo',5,'Pueblo Nuevo',60).
tiempo(7,'Avenida de Am�rica',4,'Avenida de Am�rica',60).
tiempo(7,'Avenida de Am�rica',6,'Avenida de Am�rica',60).
tiempo(7,'Avenida de Am�rica',9,'Avenida de Am�rica',60).
tiempo(7,'Gregorio Mara��n',10,'Gregorio Mara��n',60).
tiempo(7,'Canal',2,'Canal',60).
tiempo(7,'Guzm�n el Bueno',6,'Guzm�n el Bueno',60).

% ----------------------------------------------------------------------
% L�nea 8 (105)
% ----------------------------------------------------------------------
tiempo(8,'Nuevos Ministerios',8,'Colombia',375).
tiempo(8,'Colombia',8,'Pinar del Rey',465).
tiempo(8,'Pinar del Rey',8,'Mar de Cristal',286).
tiempo(8,'Mar de Cristal',8,'Campo de las Naciones',404).
tiempo(8,'Campo de las Naciones',8,'Aeropuerto T1T2T3',568).
tiempo(8,'Aeropuerto T1T2T3',8,'Barajas',334).
tiempo(8,'Barajas',8,'Aeropuerto T4',392).

% tiempos de correspondencias
tiempo(8,'Nuevos Ministerios',6,'Nuevos Ministerios',420).
tiempo(8,'Nuevos Ministerios',10,'Nuevos Ministerios',60).
tiempo(8,'Colombia',9,'Colombia',60).
tiempo(8,'Mar de Cristal',4,'Mar de Cristal',60).

% ----------------------------------------------------------------------
% L�nea 9 (105)
% ----------------------------------------------------------------------
tiempo(9,'Herrera Oria',9,'Barrio del Pilar',343).
tiempo(9,'Barrio del Pilar',9,'Ventilla',353).
tiempo(9,'Ventilla',9,'Plaza de Castilla',330).
tiempo(9,'Plaza de Castilla',9,'Duque de Pastrana',295).
tiempo(9,'Duque de Pastrana',9,'P�o XII',314).
tiempo(9,'P�o XII',9,'Colombia',308).
tiempo(9,'Colombia',9,'Concha Espina',310).
tiempo(9,'Concha Espina',9,'Cruz del Rayo',308).
tiempo(9,'Cruz del Rayo',9,'Avenida de Am�rica',309).
tiempo(9,'Avenida de Am�rica',9,'N��ez de Balboa',310).
tiempo(9,'N��ez de Balboa',9,'Pr�ncipe de Vergara',323).
tiempo(9,'Pr�ncipe de Vergara',9,'Ibiza',309).
tiempo(9,'Ibiza',9,'Sainz de Baranda',342).
tiempo(9,'Sainz de Baranda',9,'Estrella',326).
tiempo(9,'Estrella',9,'Vinateros',334).
tiempo(9,'Vinateros',9,'Artilleros',329).
tiempo(9,'Artilleros',9,'Pavones',339).
tiempo(9,'Pavones',9,'Valdebernardo',405).
tiempo(9,'Valdebernardo',9,'Vic�lvaro',402).
tiempo(9,'Vic�lvaro',9,'San Cipriano',280).
tiempo(9,'San Cipriano',9,'Puerta de Arganda',300).
tiempo(9,'Puerta de Arganda',9,'Rivas Urbanizaciones',730).
tiempo(9,'Rivas Urbanizaciones',9,'Rivas Futura',573).
tiempo(9,'Rivas Futura',9,'Rivas Vaciamadrid',439).
tiempo(9,'Rivas Vaciamadrid',9,'La Poveda',633).
tiempo(9,'La Poveda',9,'Arganda del Rey',586).

% tiempos de correspondencias
tiempo(9,'Plaza de Castilla',1,'Plaza de Castilla',60).
tiempo(9,'Plaza de Castilla',10,'Plaza de Castilla',60).
tiempo(9,'Colombia',8,'Colombia',60).
tiempo(9,'Avenida de Am�rica',4,'Avenida de Am�rica',60).
tiempo(9,'Avenida de Am�rica',6,'Avenida de Am�rica',60).
tiempo(9,'Avenida de Am�rica',7,'Avenida de Am�rica',60).
tiempo(9,'N��ez de Balboa',5,'N��ez de Balboa',360).
tiempo(9,'Pr�ncipe de Vergara',2,'Pr�ncipe de Vergara',60).
tiempo(9,'Sainz de Baranda',6,'Sainz de Baranda',60).

% ----------------------------------------------------------------------
% L�nea 10 (149.6)
% ----------------------------------------------------------------------
tiempo(10,'Hospital Infanta Sof�a',10,'Reyes Cat�licos',457).
tiempo(10,'Reyes Cat�licos',10,'Baunatal',429).
tiempo(10,'Baunatal',10,'Manuel de Falla',413).
tiempo(10,'Manuel de Falla',10,'Marqu�s de la Valdavia',431).
tiempo(10,'Marqu�s de la Valdavia',10,'La Moraleja',415).
tiempo(10,'La Moraleja',10,'La Granja',509).
tiempo(10,'La Granja',10,'Ronda de la Comunicaci�n',427).
tiempo(10,'Ronda de la Comunicaci�n',10,'Las Tablas',416).
tiempo(10,'Las Tablas',10,'Montecarmelo',556).
tiempo(10,'Montecarmelo',10,'Tres Olivos',383).
tiempo(10,'Tres Olivos',10,'Fuencarral',255).
tiempo(10,'Fuencarral',10,'Bego�a',346).
tiempo(10,'Bego�a',10,'Chamart�n',300).
tiempo(10,'Chamart�n',10,'Plaza de Castilla',276).
tiempo(10,'Plaza de Castilla',10,'Cuzco',284).
tiempo(10,'Cuzco',10,'Santiago Bernab�u',273).
tiempo(10,'Santiago Bernab�u',10,'Nuevos Ministerios',272).
tiempo(10,'Nuevos Ministerios',10,'Gregorio Mara��n',279).
tiempo(10,'Gregorio Mara��n',10,'Alonso Mart�nez',314).
tiempo(10,'Alonso Mart�nez',10,'Tribunal',245).
tiempo(10,'Tribunal',10,'Plaza de Espa�a',259).
tiempo(10,'Plaza de Espa�a',10,'Pr�ncipe P�o',287).
tiempo(10,'Pr�ncipe P�o',10,'Lago',359).
tiempo(10,'Lago',10,'Bat�n',399).
tiempo(10,'Bat�n',10,'Casa de Campo',288).
tiempo(10,'Casa de Campo',10,'Colonia Jard�n',331).
tiempo(10,'Colonia Jard�n',10,'Aviaci�n Espa�ola',400).
tiempo(10,'Aviaci�n Espa�ola',10,'Cuatro Vientos',294).
tiempo(10,'Cuatro Vientos',10,'Joaqu�n Vilumbrales',565).
tiempo(10,'Joaqu�n Vilumbrales',10,'Puerta del Sur',263).

% tiempos de correspondencias
tiempo(10,'Las Tablas',ml1,'Las Tablas',60).
%tiempo(10,'Tres Olivos',10,'Tres Olivos',60). % OJO: Cambio de tren
tiempo(10,'Chamart�n',1,'Chamart�n',60).
tiempo(10,'Plaza de Castilla',1,'Plaza de Castilla',60).
tiempo(10,'Plaza de Castilla',9,'Plaza de Castilla',60).
tiempo(10,'Nuevos Ministerios',6,'Nuevos Ministerios',420).
tiempo(10,'Nuevos Ministerios',8,'Nuevos Ministerios',60).
tiempo(10,'Gregorio Mara��n',7,'Gregorio Mara��n',60).
tiempo(10,'Alonso Mart�nez',4,'Alonso Mart�nez',60).
tiempo(10,'Alonso Mart�nez',5,'Alonso Mart�nez',60).
tiempo(10,'Tribunal',1,'Tribunal',60).
tiempo(10,'Plaza de Espa�a',2,'Noviciado',300).% Anomal�a
tiempo(10,'Plaza de Espa�a',3,'Plaza de Espa�a',60).
tiempo(10,'Pr�ncipe P�o',6,'Pr�ncipe P�o',60).
tiempo(10,'Pr�ncipe P�o','R','Pr�ncipe P�o',60).
tiempo(10,'Casa de Campo',5,'Casa de Campo',60).
tiempo(10,'Colonia Jard�n',ml2,'Colonia Jard�n',60).
tiempo(10,'Colonia Jard�n',ml3,'Colonia Jard�n',60).
tiempo(10,'Puerta del Sur',12,'Puerta del Sur',60).

% ----------------------------------------------------------------------
% L�nea 11 (179.6)
% ----------------------------------------------------------------------
tiempo(11,'Plaza El�ptica',11,'Abrantes',496).
tiempo(11,'Abrantes',11,'Pan Bendito',477).
tiempo(11,'Pan Bendito',11,'San Francisco',439).
tiempo(11,'San Francisco',11,'Carabanchel Alto',515).
tiempo(11,'Carabanchel Alto',11,'La Peseta',482).

% tiempos de correspondencias
tiempo(11,'Plaza El�ptica',6,'Plaza El�ptica',60).

% ----------------------------------------------------------------------
% L�nea 12 (165)
% ----------------------------------------------------------------------
tiempo(12,'Puerta del Sur',12,'Parque Lisboa',408).
tiempo(12,'Parque Lisboa',12,'Alcorc�n Central',440).
tiempo(12,'Alcorc�n Central',12,'Parque Oeste',476).
tiempo(12,'Parque Oeste',12,'Universidad Rey Juan Carlos',565).
tiempo(12,'Universidad Rey Juan Carlos',12,'M�stoles Central',443).
tiempo(12,'M�stoles Central',12,'Pradillo',397).
tiempo(12,'Pradillo',12,'Hospital de M�stoles',424).
tiempo(12,'Hospital de M�stoles',12,'Manuela Malasa�a',468).
tiempo(12,'Manuela Malasa�a',12,'Loranca',590).
tiempo(12,'Loranca',12,'Hospital de Fuenlabrada',535).
tiempo(12,'Hospital de Fuenlabrada',12,'Parque Europa',401).
tiempo(12,'Parque Europa',12,'Fuenlabrada Central',403).
tiempo(12,'Fuenlabrada Central',12,'Parque de los Estados',447).
tiempo(12,'Parque de los Estados',12,'Arroyo Culebro',576).
tiempo(12,'Arroyo Culebro',12,'Conservatorio',422).
tiempo(12,'Conservatorio',12,'Alonso de Mendoza',438).
tiempo(12,'Alonso de Mendoza',12,'Getafe Central',449).
tiempo(12,'Getafe Central',12,'Juan de la Cierva',444).
tiempo(12,'Juan de la Cierva',12,'El Casar',471).
tiempo(12,'El Casar',12,'Los Espartales',409).
tiempo(12,'Los Espartales',12,'El Bercial',439).
tiempo(12,'El Bercial',12,'El Carrascal',464).
tiempo(12,'El Carrascal',12,'Juli�n Besteiro',424).
tiempo(12,'Juli�n Besteiro',12,'Casa del Reloj',453).
tiempo(12,'Casa del Reloj',12,'Hospital Severo Ochoa',411).
tiempo(12,'Hospital Severo Ochoa',12,'Legan�s Central',430).
tiempo(12,'Legan�s Central',12,'San Nicasio',429).
tiempo(12,'San Nicasio',12,'Puerta del Sur',408).

% tiempos de correspondencias
tiempo(12,'Puerta del Sur',10,'Puerta del Sur',60).

% ----------------------------------------------------------------------
% L�nea 'R' (0)
% ----------------------------------------------------------------------
tiempo('R','�pera','R','Pr�ncipe P�o',592).

% tiempos de correspondencias
tiempo('R','�pera',2,'�pera',60).
tiempo('R','�pera',5,'�pera',60).
tiempo('R','Pr�ncipe P�o',6,'Pr�ncipe P�o',60).
tiempo('R','Pr�ncipe P�o',10,'Pr�ncipe P�o',60).

% ----------------------------------------------------------------------
% L�nea ml1 (150)
% ----------------------------------------------------------------------
tiempo(ml1,'Pinar de Chamart�n',ml1,'Fuente de la Mora',415).
tiempo(ml1,'Fuente de la Mora',ml1,'Virgen del Cortijo',397).
tiempo(ml1,'Virgen del Cortijo',ml1,'Antonio Saura',465).
tiempo(ml1,'Antonio Saura',ml1,'�lvarez de Villaamil',425).
tiempo(ml1,'�lvarez de Villaamil',ml1,'Blasco Ib��ez',434).
tiempo(ml1,'Blasco Ib��ez',ml1,'Mar�a Tudor',396).
tiempo(ml1,'Mar�a Tudor',ml1,'Palas de Rey',523).
tiempo(ml1,'Palas de Rey',ml1,'Las Tablas',425).

% tiempos de correspondencias
tiempo(ml1,'Pinar de Chamart�n',1,'Pinar de Chamart�n',60).
tiempo(ml1,'Pinar de Chamart�n',4,'Pinar de Chamart�n',60).
tiempo(ml1,'Las Tablas',10,'Las Tablas',60).

% ----------------------------------------------------------------------
% L�nea ml2 (225)
% ----------------------------------------------------------------------
tiempo(ml2,'Colonia Jard�n',ml2,'Prado de la Vega',588).
tiempo(ml2,'Prado de la Vega',ml2,'Colonia de los �ngeles',545).
tiempo(ml2,'Colonia de los �ngeles',ml2,'Prado del Rey',522).
tiempo(ml2,'Prado del Rey',ml2,'Somosaguas Sur',573).
tiempo(ml2,'Somosaguas Sur',ml2,'Somosaguas Centro',565).
tiempo(ml2,'Somosaguas Centro',ml2,'Pozuelo Oeste',552).
tiempo(ml2,'Pozuelo Oeste',ml2,'B�lgica',661).
tiempo(ml2,'B�lgica',ml2,'Dos Castillas',533).
tiempo(ml2,'Dos Castillas',ml2,'Campus de Somosaguas',542).
tiempo(ml2,'Campus de Somosaguas',ml2,'Avenida de Europa',562).
tiempo(ml2,'Avenida de Europa',ml2,'Berna',552).
tiempo(ml2,'Berna',ml2,'Estaci�n de Aravaca',553).

% tiempos de correspondencias
tiempo(ml2,'Colonia Jard�n', 10,'Colonia Jard�n',60).
tiempo(ml2,'Colonia Jard�n', ml3,'Colonia Jard�n',60).

% ----------------------------------------------------------------------
% L�nea ml3 (225)
% ----------------------------------------------------------------------
tiempo(ml3,'Colonia Jard�n',ml3,'Ciudad de la Imagen',591).
tiempo(ml3,'Ciudad de la Imagen',ml3,'Jos� Isbert',535).
tiempo(ml3,'Jos� Isbert',ml3,'Ciudad del Cine',522).
tiempo(ml3,'Ciudad del Cine',ml3,'Cocheras',592).
tiempo(ml3,'Cocheras',ml3,'Retamares',638).
tiempo(ml3,'Retamares',ml3,'Montepr�ncipe',713).
tiempo(ml3,'Montepr�ncipe',ml3,'Ventorro del Cano',525).
tiempo(ml3,'Ventorro del Cano',ml3,'Prado del Espino',574).
tiempo(ml3,'Prado del Espino',ml3,'Cantabria',679).
tiempo(ml3,'Cantabria',ml3,'Ferial de Boadilla',726).
tiempo(ml3,'Ferial de Boadilla',ml3,'Boadilla Centro',551).
tiempo(ml3,'Boadilla Centro',ml3,'Nuevo Mundo',540).
tiempo(ml3,'Nuevo Mundo',ml3,'Siglo XXI',539).
tiempo(ml3,'Siglo XXI',ml3,'Infante Don Luis',512).
tiempo(ml3,'Infante Don Luis',ml3,'Puerta de Boadilla',542).

% tiempos de correspondencias
tiempo(ml3,'Colonia Jard�n', 10,'Colonia Jard�n',60).
tiempo(ml3,'Colonia Jard�n', ml2,'Colonia Jard�n',60).

% Parche para arreglar algunos problemas.
tiempo(L,Est,L,Est,0).












