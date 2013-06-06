:- index(l�nea(1,0,0,0)).
:- index(correspondencia(1,1,1)).

:- discontiguous linea/5, correspondencia/3.

:- ensure_loaded('estaciones.pl').
:- ensure_loaded('costes.pl').
:- ensure_loaded('utilidades.pl').

:- load_test_files([]).
:- run_tests.

% ----------------------------------------------------------------------
% L�nea 1
% ----------------------------------------------------------------------
linea(1,'Pinar de Chamart�n', 'Valdecarros', lineal,
      ['Pinar de Chamart�n', 'Bamb�', 'Chamart�n', 'Plaza de Castilla',
       'Valdeacederas', 'Tetu�n', 'Estrecho', 'Alvarado',
       'Cuatro Caminos', 'R�os Rosas', 'Iglesia', 'Bilbao', 'Tribunal',
       'Gran V�a', 'Sol', 'Tirso de Molina', 'Ant�n Mart�n', 'Atocha',
       'Atocha Renfe', 'Men�ndez Pelayo', 'Pac�fico', 'Puente de Vallecas',
       'Nueva Numancia', 'Portazgo', 'Buenos Aires', 'Alto del Arenal',
       'Miguel Hern�ndez', 'Sierra de Guadalupe', 'Villa de Vallecas',
       'Congosto', 'La Gavia', 'Las Suertes', 'Valdecarros']).

correspondencia(1,'Pinar de Chamart�n',ml1).
correspondencia(1,'Pinar de Chamart�n',4).
correspondencia(1,'Chamart�n',10).
correspondencia(1,'Plaza de Castilla',9).
correspondencia(1,'Plaza de Castilla',10).
correspondencia(1,'Cuatro Caminos',2).
correspondencia(1,'Cuatro Caminos',6).
correspondencia(1,'Bilbao',4).
correspondencia(1,'Tribunal',10).
correspondencia(1,'Gran V�a',5).
correspondencia(1,'Sol',2).
correspondencia(1,'Sol',3).
correspondencia(1,'Pac�fico',6).


% ----------------------------------------------------------------------
% L�nea 2
% ----------------------------------------------------------------------
linea(2,'La Elipa', 'Cuatro Caminos', lineal,
      ['La Elipa', 'Ventas', 'Manuel Becerra', 'Goya', 'Pr�ncipe de Vergara',
       'Retiro', 'Banco de Espa�a', 'Sevilla', 'Sol', '�pera',
       'Santo Domingo', 'Noviciado', 'San Bernardo', 'Quevedo',
       'Canal', 'Cuatro Caminos']).

correspondencia(2,'Ventas',5).
correspondencia(2,'Manuel Becerra',6).
correspondencia(2,'Goya',4).
correspondencia(2,'Pr�ncipe de Vergara',9).
correspondencia(2,'Sol',1).
correspondencia(2,'Sol',3).
correspondencia(2,'�pera',5).
correspondencia(2,'�pera','R').
correspondencia(2,'Noviciado',3).
correspondencia(2,'Noviciado',10).
correspondencia(2,'San Bernardo',4).
correspondencia(2,'Canal',7).
correspondencia(2,'Cuatro Caminos',1).
correspondencia(2,'Cuatro Caminos',6).

% ----------------------------------------------------------------------
% L�nea 3
% ----------------------------------------------------------------------
linea(3,'Villaverde Alto', 'Moncloa', lineal,
      ['Villaverde Alto', 'San Crist�bal', 'Villaverde Bajo-Cruce',
       'Ciudad de los �ngeles', 'San Ferm�n-Orcasur',
       'Hospital 12 de Octubre', 'Almendrales', 'Legazpi', 'Delicias',
       'Palos de la Frontera', 'Embajadores', 'Lavapi�s', 'Sol',
       'Callao', 'Plaza de Espa�a', 'Ventura Rodr�guez', 'Arg�elles',
       'Moncloa']).

correspondencia(3,'Legazpi',6).
correspondencia(3,'Embajadores',5).
correspondencia(3,'Sol',1).
correspondencia(3,'Sol',2).
correspondencia(3,'Callao',5).
correspondencia(3,'Plaza de Espa�a',2).
correspondencia(3,'Plaza de Espa�a',10).
correspondencia(3,'Arg�elles',4).
correspondencia(3,'Arg�elles',6).
correspondencia(3,'Moncloa',6).

% ----------------------------------------------------------------------
% L�nea 4
% ----------------------------------------------------------------------
linea(4, 'Arg�elles', 'Pinar de Chamart�n', lineal,
      ['Arg�elles', 'San Bernardo', 'Bilbao', 'Alonso Mart�nez', 'Col�n',
       'Serrano', 'Vel�zquez', 'Goya', 'Lista', 'Diego de Le�n',
       'Avenida de Am�rica', 'Prosperidad', 'Alfonso XIII',
       'Avenida de la Paz', 'Arturo Soria', 'Esperanza', 'Canillas',
       'Mar de Cristal', 'San Lorenzo', 'Parque de Santa Mar�a',
       'Hortaleza', 'Manoteras', 'Pinar de Chamart�n']).

correspondencia(4, 'Arg�elles', 3).
correspondencia(4, 'Arg�elles', 6).
correspondencia(4, 'San Bernardo', 2).
correspondencia(4, 'Bilbao', 1).
correspondencia(4, 'Alonso Mart�nez', 5).
correspondencia(4, 'Alonso Mart�nez', 10).
correspondencia(4, 'Goya', 2).
correspondencia(4, 'Diego de Le�n', 5).
correspondencia(4, 'Diego de Le�n', 6).
correspondencia(4, 'Avenida de Am�rica', 6).
correspondencia(4, 'Avenida de Am�rica', 7).
correspondencia(4, 'Avenida de Am�rica', 9).
correspondencia(4, 'Mar de Cristal', 8).
correspondencia(4, 'Pinar de Chamart�n', 1).
correspondencia(4, 'Pinar de Chamart�n', ml1).

% ----------------------------------------------------------------------
% L�nea 5
% ----------------------------------------------------------------------
linea(5, 'Alameda de Osuna', 'Casa de Campo', lineal,
      ['Alameda de Osuna', 'El Capricho', 'Canillejas', 'Torre Arias',
       'Suanzes', 'Ciudad Lineal', 'Pueblo Nuevo', 'Quintana',
       'El Carmen', 'Ventas', 'Diego de Le�n', 'N��ez de Balboa',
       'Rub�n Dar�o', 'Alonso Mart�nez', 'Chueca', 'Gran V�a', 'Callao',
       '�pera', 'La Latina', 'Puerta de Toledo', 'Acacias', 'Pir�mides',
       'Marqu�s de Vadillo', 'Urgel', 'Oporto', 'Vista Alegre',
       'Carabanchel', 'Eugenia de Montijo', 'Aluche', 'Empalme',
       'Campamento', 'Casa de Campo']).

correspondencia(5,'Pueblo Nuevo', 7).
correspondencia(5,'Ventas', 2).
correspondencia(5,'Diego de Le�n', 4).
correspondencia(5,'Diego de Le�n', 6).
correspondencia(5,'N��ez de Balboa', 9).
correspondencia(5,'Alonso Mart�nez', 4).
correspondencia(5,'Alonso Mart�nez', 10).
correspondencia(5,'Gran V�a', 1).
correspondencia(5,'Callao', 3).
correspondencia(5,'�pera', '2').
correspondencia(5,'�pera', 'R').
correspondencia(5,'Acacias', 3).
correspondencia(5,'Oporto', 6).
correspondencia(5,'Casa de Campo', 10).

% ----------------------------------------------------------------------
% L�nea 6, Circular
% ----------------------------------------------------------------------
linea(6, 'Laguna', 'Lucero', circular,
      ['Laguna', 'Carpetana', 'Oporto', 'Opa�el', 'Plaza El�ptica',
       'Usera', 'Legazpi', 'Arganzuela-Planetario', 'M�ndez �lvaro',
       'Pac�fico', 'Conde de Casal', 'Sainz de Baranda', 'O�Donnell',
       'Manuel Becerra', 'Diego de Le�n', 'Avenida de Am�rica',
       'Rep�blica Argentina', 'Nuevos Ministerios', 'Cuatro Caminos',
       'Guzm�n el Bueno', 'Metropolitano', 'Ciudad Universitaria',
       'Moncloa', 'Arg�elles', 'Pr�ncipe P�o', 'Puerta del �ngel',
       'Alto de Extremadura','Lucero']).

correspondencia(6,'Oporto', 5).
correspondencia(6,'Plaza El�ptica', 11).
correspondencia(6,'Legazpi', 3).
correspondencia(6,'Pac�fico', 1).
correspondencia(6,'Sainz de Baranda', 9).
correspondencia(6,'Manuel Becerra', 2).
correspondencia(6,'Diego de Le�n', 4).
correspondencia(6,'Diego de Le�n', 5).
correspondencia(6,'Avenida de Am�rica', 4).
correspondencia(6,'Avenida de Am�rica', 7).
correspondencia(6,'Avenida de Am�rica', 9).
correspondencia(6,'Nuevos Ministerios', 8).
correspondencia(6,'Nuevos Ministerios', 10).
correspondencia(6,'Cuatro Caminos', 1).
correspondencia(6,'Cuatro Caminos', 2).
correspondencia(6,'Guzm�n el Bueno', 7).
correspondencia(6,'Moncloa', 3).
correspondencia(6,'Arg�elles', 3).
correspondencia(6,'Arg�elles', 4).
correspondencia(6,'Pr�ncipe P�o', 10).
correspondencia(6,'Pr�ncipe P�o', 'R').

% ----------------------------------------------------------------------
% L�nea 7
% ----------------------------------------------------------------------
linea(7, 'Hospital de Henares', 'Pitis', lineal,
      ['Hospital del Henares', 'Henares', 'Jarama', 'San Fernando',
       'La Rambla', 'Coslada Central', 'Barrio del Puerto',
       'Estadio Ol�mpico', 'Las Musas', 'San Blas', 'Simancas',
       'Garc�a Noblejas', 'Ascao', 'Pueblo Nuevo',
       'Barrio de la Concepci�n', 'Parque de las Avenidas',
       'Cartagena', 'Avenida de Am�rica', 'Gregorio Mara��n',
       'Alonso Cano', 'Canal', 'Islas Filipinas', 'Guzm�n el Bueno',
       'Francos Rodr�guez', 'Valdezarza', 'Antonio Machado',
       'Pe�agrande', 'Avenida de la Ilustraci�n', 'Lacoma', 'Pitis']).

correspondencia(7,'Pueblo Nuevo', 5).
correspondencia(7,'Avenida de Am�rica', 4).
correspondencia(7,'Avenida de Am�rica', 6).
correspondencia(7,'Avenida de Am�rica', 9).
correspondencia(7,'Gregorio Mara��n', 10).
correspondencia(7,'Canal', 2).
correspondencia(7,'Guzm�n el Bueno', 6).


% ----------------------------------------------------------------------
% L�nea 8
% ----------------------------------------------------------------------
linea(8, 'Nuevos Ministerios','Aeropuerto T4', lineal,
      ['Nuevos Ministerios', 'Colombia', 'Pinar del Rey',
       'Mar de Cristal', 'Campo de las Naciones',
       'Aeropuerto T1T2T3', 'Barajas', 'Aeropuerto T4']).

correspondencia(8,'Nuevos Ministerios', 6).
correspondencia(8,'Nuevos Ministerios', 10).
correspondencia(8,'Colombia', 9).
correspondencia(8,'Mar de Cristal', 4).

% ----------------------------------------------------------------------
% L�nea 9
% ----------------------------------------------------------------------
linea(9,'Herrera Oria', 'Arganda del Rey', lineal,
      ['Herrera Oria', 'Barrio del Pilar', 'Ventilla',
       'Plaza de Castilla', 'Duque de Pastrana', 'P�o XII',
       'Colombia', 'Concha Espina', 'Cruz del Rayo',
       'Avenida de Am�rica', 'N��ez de Balboa', 'Pr�ncipe de Vergara',
       'Ibiza', 'Sainz de Baranda', 'Estrella', 'Vinateros',
       'Artilleros', 'Pavones', 'Valdebernardo', 'Vic�lvaro',
       'San Cipriano', 'Puerta de Arganda', 'Rivas Urbanizaciones',
       'Rivas Futura', 'Rivas Vaciamadrid', 'La Poveda',
       'Arganda del Rey']).

correspondencia(9,'Plaza de Castilla', 1).
correspondencia(9,'Plaza de Castilla', 10).
correspondencia(9,'Colombia', 8).
correspondencia(9,'Avenida de Am�rica', 4).
correspondencia(9,'Avenida de Am�rica', 6).
correspondencia(9,'Avenida de Am�rica', 7).
correspondencia(9,'N��ez de Balboa', 5).
correspondencia(9,'Pr�ncipe de Vergara', 2).
correspondencia(9,'Sainz de Baranda', 6).

% ----------------------------------------------------------------------
% L�nea 10
% ----------------------------------------------------------------------
linea(10,'Hospital Infanta Sof�a', 'Puerta del Sur', lineal,
      ['Hospital Infanta Sof�a',
       'Reyes Cat�licos', 'Baunatal', 'Manuel de Falla',
       'Marqu�s de la Valdavia', 'La Moraleja', 'La Granja',
       'Ronda de la Comunicaci�n', 'Las Tablas', 'Montecarmelo',
       'Tres Olivos', 'Fuencarral', 'Bego�a', 'Chamart�n',
       'Plaza de Castilla', 'Cuzco', 'Santiago Bernab�u',
       'Nuevos Ministerios', 'Gregorio Mara��n', 'Alonso Mart�nez',
       'Tribunal', 'Plaza de Espa�a', 'Pr�ncipe P�o', 'Lago', 'Bat�n',
       'Casa de Campo', 'Colonia Jard�n', 'Aviaci�n Espa�ola',
       'Cuatro Vientos', 'Joaqu�n Vilumbrales', 'Puerta del Sur']).

correspondencia(10,'Las Tablas', ml1).
%correspondencia(10,'Tres Olivos', 10). % OJO: cambio de tren
correspondencia(10,'Chamart�n', 1).
correspondencia(10,'Plaza de Castilla', 1).
correspondencia(10,'Nuevos Ministerios', 6).
correspondencia(10,'Nuevos Ministerios', 8).
correspondencia(10,'Gregorio Mara��n', 7).
correspondencia(10,'Alonso Mart�nez', 4).
correspondencia(10,'Alonso Mart�nez', 5).
correspondencia(10,'Tribunal', 1).
correspondencia(10,'Plaza de Espa�a', 3).
correspondencia(10,'Pr�ncipe P�o', 6).
correspondencia(10,'Pr�ncipe P�o', 'R').
correspondencia(10,'Casa de Campo', 5).
correspondencia(10,'Colonia Jard�n', ml2).
correspondencia(10,'Colonia Jard�n', ml3).
correspondencia(10,'Puerta del Sur', l2).

% ----------------------------------------------------------------------
% L�nea 11
% ----------------------------------------------------------------------
linea(11,'Plaza El�ptica', 'La Peseta', lineal,
      ['Plaza El�ptica', 'Abrantes', 'Pan Bendito', 'San Francisco',
       'Carabanchel Alto', 'La Peseta']).

correspondencia(11,'Plaza El�ptica', 6).

% ----------------------------------------------------------------------
% L�nea 12
% ----------------------------------------------------------------------
linea(12,'Puerta del Sur', 'San Nicasio', circular,
      ['Puerta del Sur', 'Parque Lisboa', 'Alcorc�n Central',
       'Parque Oeste', 'Universidad Rey Juan Carlos', 'M�stoles Central',
       'Pradillo', 'Hospital de M�stoles', 'Manuela Malasa�a',
       'Loranca', 'Hospital de Fuenlabrada', 'Parque Europa',
       'Fuenlabrada Central', 'Parque de los Estados', 'Arroyo Culebro',
       'Conservatorio', 'Alonso de Mendoza', 'Getafe Central',
       'Juan de la Cierva', 'El Casar', 'Los Espartales', 'El Bercial',
       'El Carrascal', 'Juli�n Besteiro', 'Casa del Reloj',
       'Hospital Severo Ochoa', 'Legan�s Central', 'San Nicasio']).

correspondencia(12,'Puerta del Sur', 10).

% ----------------------------------------------------------------------
% L�nea R, Ramal
% ----------------------------------------------------------------------
linea('R', '�pera', 'Pr�ncipe P�o', lineal,
      ['�pera', 'Pr�ncipe P�o']).

correspondencia('R','�pera', 2).
correspondencia('R','�pera', 5).
correspondencia('R','Pr�ncipe P�o', 6).
correspondencia('R','Pr�ncipe P�o', 10).

% ----------------------------------------------------------------------
% L�nea Metro Ligero 1
% ----------------------------------------------------------------------
linea(ml1, 'Pinar de Chamart�n', 'Las Tablas', lineal,
      ['Pinar de Chamart�n', 'Fuente de la Mora', 'Virgen del Cortijo',
       'Antonio Saura', '�lvarez de Villaamil', 'Blasco Ib��ez',
       'Mar�a Tudor', 'Palas de Rey', 'Las Tablas']).

correspondencia(ml1,'Pinar de Chamart�n', 1).
correspondencia(ml1,'Pinar de Chamart�n', 4).
correspondencia(ml1,'Las Tablas', 10).

% ----------------------------------------------------------------------
% L�nea Metro Ligero 2
% ----------------------------------------------------------------------
linea(ml2, 'Colonia Jard�n', 'Estaci�n de Aravaca', lineal,
      ['Colonia Jard�n', 'Prado de la Vega', 'Colonia de los �ngeles',
       'Prado del Rey', 'Somosaguas Sur', 'Somosaguas Centro',
       'Pozuelo Oeste', 'B�lgica', 'Dos Castillas',
       'Campus de Somosaguas', 'Avenida de Europa', 'Berna',
       'Estaci�n de Aravaca']).

correspondencia(ml2,'Colonia Jard�n', 10).
correspondencia(ml2,'Colonia Jard�n', ml3).

% ----------------------------------------------------------------------
% L�nea Metro Ligero 3
% ----------------------------------------------------------------------
linea(ml3, 'Colonia Jard�n', 'Puerta de Boadilla', lineal,
      ['Colonia Jard�n', 'Ciudad de la Imagen', 'Jos� Isbert',
       'Ciudad del Cine', 'Cocheras', 'Retamares', 'Montepr�ncipe',
       'Ventorro del Cano', 'Prado del Espino', 'Cantabria',
       'Ferial de Boadilla', 'Boadilla Centro', 'Nuevo Mundo',
       'Siglo XXI', 'Infante Don Luis', 'Puerta de Boadilla']).

correspondencia(ml3,'Colonia Jard�n', 10).
correspondencia(ml3,'Colonia Jard�n', ml2).

