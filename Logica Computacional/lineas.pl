:- index(línea(1,0,0,0)).
:- index(correspondencia(1,1,1)).

:- discontiguous linea/5, correspondencia/3.

:- ensure_loaded('estaciones.pl').
:- ensure_loaded('costes.pl').
:- ensure_loaded('utilidades.pl').

:- load_test_files([]).
:- run_tests.

% ----------------------------------------------------------------------
% Línea 1
% ----------------------------------------------------------------------
linea(1,'Pinar de Chamartín', 'Valdecarros', lineal,
      ['Pinar de Chamartín', 'Bambú', 'Chamartín', 'Plaza de Castilla',
       'Valdeacederas', 'Tetuán', 'Estrecho', 'Alvarado',
       'Cuatro Caminos', 'Ríos Rosas', 'Iglesia', 'Bilbao', 'Tribunal',
       'Gran Vía', 'Sol', 'Tirso de Molina', 'Antón Martín', 'Atocha',
       'Atocha Renfe', 'Menéndez Pelayo', 'Pacífico', 'Puente de Vallecas',
       'Nueva Numancia', 'Portazgo', 'Buenos Aires', 'Alto del Arenal',
       'Miguel Hernández', 'Sierra de Guadalupe', 'Villa de Vallecas',
       'Congosto', 'La Gavia', 'Las Suertes', 'Valdecarros']).

correspondencia(1,'Pinar de Chamartín',ml1).
correspondencia(1,'Pinar de Chamartín',4).
correspondencia(1,'Chamartín',10).
correspondencia(1,'Plaza de Castilla',9).
correspondencia(1,'Plaza de Castilla',10).
correspondencia(1,'Cuatro Caminos',2).
correspondencia(1,'Cuatro Caminos',6).
correspondencia(1,'Bilbao',4).
correspondencia(1,'Tribunal',10).
correspondencia(1,'Gran Vía',5).
correspondencia(1,'Sol',2).
correspondencia(1,'Sol',3).
correspondencia(1,'Pacífico',6).


% ----------------------------------------------------------------------
% Línea 2
% ----------------------------------------------------------------------
linea(2,'La Elipa', 'Cuatro Caminos', lineal,
      ['La Elipa', 'Ventas', 'Manuel Becerra', 'Goya', 'Príncipe de Vergara',
       'Retiro', 'Banco de España', 'Sevilla', 'Sol', 'Ópera',
       'Santo Domingo', 'Noviciado', 'San Bernardo', 'Quevedo',
       'Canal', 'Cuatro Caminos']).

correspondencia(2,'Ventas',5).
correspondencia(2,'Manuel Becerra',6).
correspondencia(2,'Goya',4).
correspondencia(2,'Príncipe de Vergara',9).
correspondencia(2,'Sol',1).
correspondencia(2,'Sol',3).
correspondencia(2,'Ópera',5).
correspondencia(2,'Ópera','R').
correspondencia(2,'Noviciado',3).
correspondencia(2,'Noviciado',10).
correspondencia(2,'San Bernardo',4).
correspondencia(2,'Canal',7).
correspondencia(2,'Cuatro Caminos',1).
correspondencia(2,'Cuatro Caminos',6).

% ----------------------------------------------------------------------
% Línea 3
% ----------------------------------------------------------------------
linea(3,'Villaverde Alto', 'Moncloa', lineal,
      ['Villaverde Alto', 'San Cristóbal', 'Villaverde Bajo-Cruce',
       'Ciudad de los Ángeles', 'San Fermín-Orcasur',
       'Hospital 12 de Octubre', 'Almendrales', 'Legazpi', 'Delicias',
       'Palos de la Frontera', 'Embajadores', 'Lavapiés', 'Sol',
       'Callao', 'Plaza de España', 'Ventura Rodríguez', 'Argüelles',
       'Moncloa']).

correspondencia(3,'Legazpi',6).
correspondencia(3,'Embajadores',5).
correspondencia(3,'Sol',1).
correspondencia(3,'Sol',2).
correspondencia(3,'Callao',5).
correspondencia(3,'Plaza de España',2).
correspondencia(3,'Plaza de España',10).
correspondencia(3,'Argüelles',4).
correspondencia(3,'Argüelles',6).
correspondencia(3,'Moncloa',6).

% ----------------------------------------------------------------------
% Línea 4
% ----------------------------------------------------------------------
linea(4, 'Argüelles', 'Pinar de Chamartín', lineal,
      ['Argüelles', 'San Bernardo', 'Bilbao', 'Alonso Martínez', 'Colón',
       'Serrano', 'Velázquez', 'Goya', 'Lista', 'Diego de León',
       'Avenida de América', 'Prosperidad', 'Alfonso XIII',
       'Avenida de la Paz', 'Arturo Soria', 'Esperanza', 'Canillas',
       'Mar de Cristal', 'San Lorenzo', 'Parque de Santa María',
       'Hortaleza', 'Manoteras', 'Pinar de Chamartín']).

correspondencia(4, 'Argüelles', 3).
correspondencia(4, 'Argüelles', 6).
correspondencia(4, 'San Bernardo', 2).
correspondencia(4, 'Bilbao', 1).
correspondencia(4, 'Alonso Martínez', 5).
correspondencia(4, 'Alonso Martínez', 10).
correspondencia(4, 'Goya', 2).
correspondencia(4, 'Diego de León', 5).
correspondencia(4, 'Diego de León', 6).
correspondencia(4, 'Avenida de América', 6).
correspondencia(4, 'Avenida de América', 7).
correspondencia(4, 'Avenida de América', 9).
correspondencia(4, 'Mar de Cristal', 8).
correspondencia(4, 'Pinar de Chamartín', 1).
correspondencia(4, 'Pinar de Chamartín', ml1).

% ----------------------------------------------------------------------
% Línea 5
% ----------------------------------------------------------------------
linea(5, 'Alameda de Osuna', 'Casa de Campo', lineal,
      ['Alameda de Osuna', 'El Capricho', 'Canillejas', 'Torre Arias',
       'Suanzes', 'Ciudad Lineal', 'Pueblo Nuevo', 'Quintana',
       'El Carmen', 'Ventas', 'Diego de León', 'Núñez de Balboa',
       'Rubén Darío', 'Alonso Martínez', 'Chueca', 'Gran Vía', 'Callao',
       'Ópera', 'La Latina', 'Puerta de Toledo', 'Acacias', 'Pirámides',
       'Marqués de Vadillo', 'Urgel', 'Oporto', 'Vista Alegre',
       'Carabanchel', 'Eugenia de Montijo', 'Aluche', 'Empalme',
       'Campamento', 'Casa de Campo']).

correspondencia(5,'Pueblo Nuevo', 7).
correspondencia(5,'Ventas', 2).
correspondencia(5,'Diego de León', 4).
correspondencia(5,'Diego de León', 6).
correspondencia(5,'Núñez de Balboa', 9).
correspondencia(5,'Alonso Martínez', 4).
correspondencia(5,'Alonso Martínez', 10).
correspondencia(5,'Gran Vía', 1).
correspondencia(5,'Callao', 3).
correspondencia(5,'Ópera', '2').
correspondencia(5,'Ópera', 'R').
correspondencia(5,'Acacias', 3).
correspondencia(5,'Oporto', 6).
correspondencia(5,'Casa de Campo', 10).

% ----------------------------------------------------------------------
% Línea 6, Circular
% ----------------------------------------------------------------------
linea(6, 'Laguna', 'Lucero', circular,
      ['Laguna', 'Carpetana', 'Oporto', 'Opañel', 'Plaza Elíptica',
       'Usera', 'Legazpi', 'Arganzuela-Planetario', 'Méndez Álvaro',
       'Pacífico', 'Conde de Casal', 'Sainz de Baranda', 'O´Donnell',
       'Manuel Becerra', 'Diego de León', 'Avenida de América',
       'República Argentina', 'Nuevos Ministerios', 'Cuatro Caminos',
       'Guzmán el Bueno', 'Metropolitano', 'Ciudad Universitaria',
       'Moncloa', 'Argüelles', 'Príncipe Pío', 'Puerta del Ángel',
       'Alto de Extremadura','Lucero']).

correspondencia(6,'Oporto', 5).
correspondencia(6,'Plaza Elíptica', 11).
correspondencia(6,'Legazpi', 3).
correspondencia(6,'Pacífico', 1).
correspondencia(6,'Sainz de Baranda', 9).
correspondencia(6,'Manuel Becerra', 2).
correspondencia(6,'Diego de León', 4).
correspondencia(6,'Diego de León', 5).
correspondencia(6,'Avenida de América', 4).
correspondencia(6,'Avenida de América', 7).
correspondencia(6,'Avenida de América', 9).
correspondencia(6,'Nuevos Ministerios', 8).
correspondencia(6,'Nuevos Ministerios', 10).
correspondencia(6,'Cuatro Caminos', 1).
correspondencia(6,'Cuatro Caminos', 2).
correspondencia(6,'Guzmán el Bueno', 7).
correspondencia(6,'Moncloa', 3).
correspondencia(6,'Argüelles', 3).
correspondencia(6,'Argüelles', 4).
correspondencia(6,'Príncipe Pío', 10).
correspondencia(6,'Príncipe Pío', 'R').

% ----------------------------------------------------------------------
% Línea 7
% ----------------------------------------------------------------------
linea(7, 'Hospital de Henares', 'Pitis', lineal,
      ['Hospital del Henares', 'Henares', 'Jarama', 'San Fernando',
       'La Rambla', 'Coslada Central', 'Barrio del Puerto',
       'Estadio Olímpico', 'Las Musas', 'San Blas', 'Simancas',
       'García Noblejas', 'Ascao', 'Pueblo Nuevo',
       'Barrio de la Concepción', 'Parque de las Avenidas',
       'Cartagena', 'Avenida de América', 'Gregorio Marañón',
       'Alonso Cano', 'Canal', 'Islas Filipinas', 'Guzmán el Bueno',
       'Francos Rodríguez', 'Valdezarza', 'Antonio Machado',
       'Peñagrande', 'Avenida de la Ilustración', 'Lacoma', 'Pitis']).

correspondencia(7,'Pueblo Nuevo', 5).
correspondencia(7,'Avenida de América', 4).
correspondencia(7,'Avenida de América', 6).
correspondencia(7,'Avenida de América', 9).
correspondencia(7,'Gregorio Marañón', 10).
correspondencia(7,'Canal', 2).
correspondencia(7,'Guzmán el Bueno', 6).


% ----------------------------------------------------------------------
% Línea 8
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
% Línea 9
% ----------------------------------------------------------------------
linea(9,'Herrera Oria', 'Arganda del Rey', lineal,
      ['Herrera Oria', 'Barrio del Pilar', 'Ventilla',
       'Plaza de Castilla', 'Duque de Pastrana', 'Pío XII',
       'Colombia', 'Concha Espina', 'Cruz del Rayo',
       'Avenida de América', 'Núñez de Balboa', 'Príncipe de Vergara',
       'Ibiza', 'Sainz de Baranda', 'Estrella', 'Vinateros',
       'Artilleros', 'Pavones', 'Valdebernardo', 'Vicálvaro',
       'San Cipriano', 'Puerta de Arganda', 'Rivas Urbanizaciones',
       'Rivas Futura', 'Rivas Vaciamadrid', 'La Poveda',
       'Arganda del Rey']).

correspondencia(9,'Plaza de Castilla', 1).
correspondencia(9,'Plaza de Castilla', 10).
correspondencia(9,'Colombia', 8).
correspondencia(9,'Avenida de América', 4).
correspondencia(9,'Avenida de América', 6).
correspondencia(9,'Avenida de América', 7).
correspondencia(9,'Núñez de Balboa', 5).
correspondencia(9,'Príncipe de Vergara', 2).
correspondencia(9,'Sainz de Baranda', 6).

% ----------------------------------------------------------------------
% Línea 10
% ----------------------------------------------------------------------
linea(10,'Hospital Infanta Sofía', 'Puerta del Sur', lineal,
      ['Hospital Infanta Sofía',
       'Reyes Católicos', 'Baunatal', 'Manuel de Falla',
       'Marqués de la Valdavia', 'La Moraleja', 'La Granja',
       'Ronda de la Comunicación', 'Las Tablas', 'Montecarmelo',
       'Tres Olivos', 'Fuencarral', 'Begoña', 'Chamartín',
       'Plaza de Castilla', 'Cuzco', 'Santiago Bernabéu',
       'Nuevos Ministerios', 'Gregorio Marañón', 'Alonso Martínez',
       'Tribunal', 'Plaza de España', 'Príncipe Pío', 'Lago', 'Batán',
       'Casa de Campo', 'Colonia Jardín', 'Aviación Española',
       'Cuatro Vientos', 'Joaquín Vilumbrales', 'Puerta del Sur']).

correspondencia(10,'Las Tablas', ml1).
%correspondencia(10,'Tres Olivos', 10). % OJO: cambio de tren
correspondencia(10,'Chamartín', 1).
correspondencia(10,'Plaza de Castilla', 1).
correspondencia(10,'Nuevos Ministerios', 6).
correspondencia(10,'Nuevos Ministerios', 8).
correspondencia(10,'Gregorio Marañón', 7).
correspondencia(10,'Alonso Martínez', 4).
correspondencia(10,'Alonso Martínez', 5).
correspondencia(10,'Tribunal', 1).
correspondencia(10,'Plaza de España', 3).
correspondencia(10,'Príncipe Pío', 6).
correspondencia(10,'Príncipe Pío', 'R').
correspondencia(10,'Casa de Campo', 5).
correspondencia(10,'Colonia Jardín', ml2).
correspondencia(10,'Colonia Jardín', ml3).
correspondencia(10,'Puerta del Sur', l2).

% ----------------------------------------------------------------------
% Línea 11
% ----------------------------------------------------------------------
linea(11,'Plaza Elíptica', 'La Peseta', lineal,
      ['Plaza Elíptica', 'Abrantes', 'Pan Bendito', 'San Francisco',
       'Carabanchel Alto', 'La Peseta']).

correspondencia(11,'Plaza Elíptica', 6).

% ----------------------------------------------------------------------
% Línea 12
% ----------------------------------------------------------------------
linea(12,'Puerta del Sur', 'San Nicasio', circular,
      ['Puerta del Sur', 'Parque Lisboa', 'Alcorcón Central',
       'Parque Oeste', 'Universidad Rey Juan Carlos', 'Móstoles Central',
       'Pradillo', 'Hospital de Móstoles', 'Manuela Malasaña',
       'Loranca', 'Hospital de Fuenlabrada', 'Parque Europa',
       'Fuenlabrada Central', 'Parque de los Estados', 'Arroyo Culebro',
       'Conservatorio', 'Alonso de Mendoza', 'Getafe Central',
       'Juan de la Cierva', 'El Casar', 'Los Espartales', 'El Bercial',
       'El Carrascal', 'Julián Besteiro', 'Casa del Reloj',
       'Hospital Severo Ochoa', 'Leganés Central', 'San Nicasio']).

correspondencia(12,'Puerta del Sur', 10).

% ----------------------------------------------------------------------
% Línea R, Ramal
% ----------------------------------------------------------------------
linea('R', 'Ópera', 'Príncipe Pío', lineal,
      ['Ópera', 'Príncipe Pío']).

correspondencia('R','Ópera', 2).
correspondencia('R','Ópera', 5).
correspondencia('R','Príncipe Pío', 6).
correspondencia('R','Príncipe Pío', 10).

% ----------------------------------------------------------------------
% Línea Metro Ligero 1
% ----------------------------------------------------------------------
linea(ml1, 'Pinar de Chamartín', 'Las Tablas', lineal,
      ['Pinar de Chamartín', 'Fuente de la Mora', 'Virgen del Cortijo',
       'Antonio Saura', 'Álvarez de Villaamil', 'Blasco Ibáñez',
       'María Tudor', 'Palas de Rey', 'Las Tablas']).

correspondencia(ml1,'Pinar de Chamartín', 1).
correspondencia(ml1,'Pinar de Chamartín', 4).
correspondencia(ml1,'Las Tablas', 10).

% ----------------------------------------------------------------------
% Línea Metro Ligero 2
% ----------------------------------------------------------------------
linea(ml2, 'Colonia Jardín', 'Estación de Aravaca', lineal,
      ['Colonia Jardín', 'Prado de la Vega', 'Colonia de los Ángeles',
       'Prado del Rey', 'Somosaguas Sur', 'Somosaguas Centro',
       'Pozuelo Oeste', 'Bélgica', 'Dos Castillas',
       'Campus de Somosaguas', 'Avenida de Europa', 'Berna',
       'Estación de Aravaca']).

correspondencia(ml2,'Colonia Jardín', 10).
correspondencia(ml2,'Colonia Jardín', ml3).

% ----------------------------------------------------------------------
% Línea Metro Ligero 3
% ----------------------------------------------------------------------
linea(ml3, 'Colonia Jardín', 'Puerta de Boadilla', lineal,
      ['Colonia Jardín', 'Ciudad de la Imagen', 'José Isbert',
       'Ciudad del Cine', 'Cocheras', 'Retamares', 'Montepríncipe',
       'Ventorro del Cano', 'Prado del Espino', 'Cantabria',
       'Ferial de Boadilla', 'Boadilla Centro', 'Nuevo Mundo',
       'Siglo XXI', 'Infante Don Luis', 'Puerta de Boadilla']).

correspondencia(ml3,'Colonia Jardín', 10).
correspondencia(ml3,'Colonia Jardín', ml2).

