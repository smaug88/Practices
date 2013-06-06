:-index(tiempo(1,1,1,1,0)).

% ----------------------------------------------------------------------
% Factores necesarios para componer el tiempo de trayecto a partir
% de los tiempos de viaje entre estaciones. Son dependientes de la
% línea (?).
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
% asigna un tiempo de 60 sg general para cualquier cambio de línea.
% ----------------------------------------------------------------------
% Línea 1 (90)
% ----------------------------------------------------------------------
tiempo(1,'Pinar de Chamartín',1,'Bambú',383).
tiempo(1,'Bambú',1,'Chamartín',328).
tiempo(1,'Chamartín',1,'Plaza de Castilla',276). %Igual tiempo sobre línea 10
tiempo(1,'Plaza de Castilla',1,'Valdeacederas',264).
tiempo(1,'Valdeacederas',1,'Tetuán',271).
tiempo(1,'Tetuán',1,'Estrecho',305).
tiempo(1,'Estrecho',1,'Alvarado',268).
tiempo(1,'Alvarado',1,'Cuatro Caminos',251).
tiempo(1,'Cuatro Caminos',1,'Ríos Rosas',264).
tiempo(1,'Ríos Rosas',1,'Iglesia',301).
tiempo(1,'Iglesia',1,'Bilbao',295).
tiempo(1,'Bilbao',1,'Tribunal',258).
tiempo(1,'Tribunal',1,'Gran Vía',293).
tiempo(1,'Gran Vía',1,'Sol',233).
tiempo(1,'Sol',1,'Tirso de Molina',290).
tiempo(1,'Tirso de Molina',1,'Antón Martín',260).
tiempo(1,'Antón Martín',1,'Atocha',291).
tiempo(1,'Atocha',1,'Atocha Renfe',230).
tiempo(1,'Atocha Renfe',1,'Menéndez Pelayo',295).
tiempo(1,'Menéndez Pelayo',1,'Pacífico',267).
tiempo(1,'Pacífico',1,'Puente de Vallecas',296).
tiempo(1,'Puente de Vallecas',1,'Nueva Numancia',256).
tiempo(1,'Nueva Numancia',1,'Portazgo',274).
tiempo(1,'Portazgo',1,'Buenos Aires',272).
tiempo(1,'Buenos Aires',1,'Alto del Arenal',287).
tiempo(1,'Alto del Arenal',1,'Miguel Hernández',283).
tiempo(1,'Miguel Hernández',1,'Sierra de Guadalupe',398).
tiempo(1,'Sierra de Guadalupe',1,'Villa de Vallecas',263).
tiempo(1,'Villa de Vallecas',1,'Congosto',310).
tiempo(1,'Congosto',1,'La Gavia',375).
tiempo(1,'La Gavia',1,'Las Suertes',180).
tiempo(1,'Las Suertes',1,'Valdecarros',258).

% tiempos de correspondencias
tiempo(1,'Pinar de Chamartín',ml1,'Pinar de Chamartín',60).
tiempo(1,'Pinar de Chamartín',4,'Pinar de Chamartín',60).
tiempo(1,'Chamartín',10,'Chamartín',60).
tiempo(1,'Plaza de Castilla',9,'Plaza de Castilla',60).
tiempo(1,'Plaza de Castilla',10,'Plaza de Castilla',60).
tiempo(1,'Cuatro Caminos',2,'Cuatro Caminos',60).
tiempo(1,'Cuatro Caminos',6,'Cuatro Caminos',60).
tiempo(1,'Bilbao',4,'Bilbao',60).
tiempo(1,'Tribunal',10,'Tribunal',60).
tiempo(1,'Gran Vía',5,'Gran Vía',60).
tiempo(1,'Sol',2,'Sol',60).
tiempo(1,'Sol',3,'Sol',60).
tiempo(1,'Pacífico',6,'Pacífico',60).


% ----------------------------------------------------------------------
% Línea 2 (120)
% ----------------------------------------------------------------------
tiempo(2,'La Elipa',2,'Ventas',539).
tiempo(2,'Ventas',2,'Manuel Becerra',371).
tiempo(2,'Manuel Becerra',2,'Goya',373).
tiempo(2,'Goya',2,'Príncipe de Vergara',328).
tiempo(2,'Príncipe de Vergara',2,'Retiro',353).
tiempo(2,'Retiro',2,'Banco de España',397).
tiempo(2,'Banco de España',2,'Sevilla',336).
tiempo(2,'Sevilla',2,'Sol',312).
tiempo(2,'Sol',2,'Ópera',343).
tiempo(2,'Ópera',2,'Santo Domingo',331).
tiempo(2,'Santo Domingo',2,'Noviciado',326).
tiempo(2,'Noviciado',2,'San Bernardo',372).
tiempo(2,'San Bernardo',2,'Quevedo',299).
tiempo(2,'Quevedo',2,'Canal',392).
tiempo(2,'Canal',2,'Cuatro Caminos',397).

% tiempos de correspondencias
tiempo(2,'Ventas',5,'Ventas',60).
tiempo(2,'Manuel Becerra',6,'Manuel Becerra',60).
tiempo(2,'Goya',4,'Goya',60).
tiempo(2,'Príncipe de Vergara',9,'Príncipe de Vergara',60).
tiempo(2,'Sol',1,'Sol',60).
tiempo(2,'Sol',3,'Sol',60).
tiempo(2,'Ópera',5,'Ópera',60).
tiempo(2,'Ópera','R','Ópera',60).
tiempo(2,'Noviciado',3,'Plaza de España',300). % Anomalía
tiempo(2,'Noviciado',10,'Plaza de España',300).% Anomalía
tiempo(2,'San Bernardo',4,'San Bernardo',60).
tiempo(2,'Canal',7,'Canal',60).
tiempo(2,'Cuatro Caminos',1,'Cuatro Caminos',60).
tiempo(2,'Cuatro Caminos',6,'Cuatro Caminos',60).

% ----------------------------------------------------------------------
% Línea 3 (75)
% ----------------------------------------------------------------------
tiempo(3,'Villaverde Alto',3,'San Cristóbal',419).
tiempo(3,'San Cristóbal',3,'Villaverde Bajo-Cruce',308).
tiempo(3,'Villaverde Bajo-Cruce',3,'Ciudad de los Ángeles',324).
tiempo(3,'Ciudad de los Ángeles',3,'San Fermín-Orcasur',309).
tiempo(3,'San Fermín-Orcasur',3,'Hospital 12 de Octubre',235).
tiempo(3,'Hospital 12 de Octubre',3,'Almendrales',287).
tiempo(3,'Almendrales',3,'Legazpi',284).
tiempo(3,'Legazpi',3,'Delicias',266).
tiempo(3,'Delicias',3,'Palos de la Frontera',224).
tiempo(3,'Palos de la Frontera',3,'Embajadores',267).
tiempo(3,'Embajadores',3,'Lavapiés',219).
tiempo(3,'Lavapiés',3,'Sol',295).
tiempo(3,'Sol',3,'Callao',217).
tiempo(3,'Callao',3,'Plaza de España',235).
tiempo(3,'Plaza de España',3,'Ventura Rodríguez',214).
tiempo(3,'Ventura Rodríguez',3,'Argüelles',220).
tiempo(3,'Argüelles',3,'Moncloa',209).

% tiempos de correspondencias
tiempo(3,'Legazpi',6,'Legazpi',60).
tiempo(3,'Embajadores',5,'Acacias',420).%Anomalía
tiempo(3,'Sol',1,'Sol',60).
tiempo(3,'Sol',2,'Sol',60).
tiempo(3,'Callao',5,'Callao',60).
tiempo(3,'Plaza de España',2,'Noviciado',300). %Anomalía
tiempo(3,'Plaza de España',10,'Plaza de España',60).
tiempo(3,'Argüelles',4,'Argüelles',60).
tiempo(3,'Argüelles',6,'Argüelles',60).
tiempo(3,'Moncloa',6,'Moncloa',60).

% ----------------------------------------------------------------------
% Línea 4 (105)
% ----------------------------------------------------------------------
tiempo(4,'Argüelles',4,'San Bernardo',350).
tiempo(4,'San Bernardo',4,'Bilbao',276).
tiempo(4,'Bilbao',4,'Alonso Martínez',284).
tiempo(4,'Alonso Martínez',4,'Colón',274).
tiempo(4,'Colón',4,'Serrano',295).
tiempo(4,'Serrano',4,'Velázquez',272).
tiempo(4,'Velázquez',4,'Goya',293).
tiempo(4,'Goya',4,'Lista',306).
tiempo(4,'Lista',4,'Diego de León',306).
tiempo(4,'Diego de León',4,'Avenida de América',298).
tiempo(4,'Avenida de América',4,'Prosperidad',344).
tiempo(4,'Prosperidad',4,'Alfonso XIII',356).
tiempo(4,'Alfonso XIII',4,'Avenida de la Paz',318).
tiempo(4,'Avenida de la Paz',4,'Arturo Soria',340).
tiempo(4,'Arturo Soria',4,'Esperanza',352).
tiempo(4,'Esperanza',4,'Canillas',430).
tiempo(4,'Canillas',4,'Mar de Cristal',318).
tiempo(4,'Mar de Cristal',4,'San Lorenzo',292).
tiempo(4,'San Lorenzo',4,'Parque de Santa María',327).
tiempo(4,'Parque de Santa María',4,'Hortaleza',339).
tiempo(4,'Hortaleza',4,'Manoteras',408).
tiempo(4,'Manoteras',4,'Pinar de Chamartín',302).

% tiempos de correspondencias
tiempo(4,'Argüelles',3,'Argüelles',60).
tiempo(4,'Argüelles',6,'Argüelles',60).
tiempo(4,'San Bernardo',2,'San Bernardo',60).
tiempo(4,'Bilbao',1,'Bilbao',60).
tiempo(4,'Alonso Martínez',5,'Alonso Martínez',60).
tiempo(4,'Alonso Martínez',10,'Alonso Martínez',60).
tiempo(4,'Goya',2,'Goya',60).
tiempo(4,'Diego de León',5,'Diego de León',300).
tiempo(4,'Diego de León',6,'Diego de León',540).
tiempo(4,'Avenida de América',6,'Avenida de América',60).
tiempo(4,'Avenida de América',7,'Avenida de América',60).
tiempo(4,'Avenida de América',9,'Avenida de América',60).
tiempo(4,'Mar de Cristal',8,'Mar de Cristal',60).
tiempo(4,'Pinar de Chamartín',1,'Pinar de Chamartín',60).
tiempo(4,'Pinar de Chamartín',ml1,'Pinar de Chamartín',60).

% ----------------------------------------------------------------------
% Línea 5 (120)
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
tiempo(5,'Ventas',5,'Diego de León',378).
tiempo(5,'Diego de León',5,'Núñez de Balboa',344).
tiempo(5,'Núñez de Balboa',5,'Rubén Darío',343).
tiempo(5,'Rubén Darío',5,'Alonso Martínez',350).
tiempo(5,'Alonso Martínez',5,'Chueca',348).
tiempo(5,'Chueca',5,'Gran Vía',317).
tiempo(5,'Gran Vía',5,'Callao',293).
tiempo(5,'Callao',5,'Ópera',316).
tiempo(5,'Ópera',5,'La Latina',360).
tiempo(5,'La Latina',5,'Puerta de Toledo',332).
tiempo(5,'Puerta de Toledo',5,'Acacias',379).
tiempo(5,'Acacias',5,'Pirámides',324).
tiempo(5,'Pirámides',5,'Marqués de Vadillo',359).
tiempo(5,'Marqués de Vadillo',5,'Urgel',359).
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
tiempo(5,'Diego de León',4,'Diego de León',300).
tiempo(5,'Diego de León',6,'Diego de León',300).
tiempo(5,'Núñez de Balboa',9,'Núñez de Balboa',360).
tiempo(5,'Alonso Martínez',4,'Alonso Martínez',60).
tiempo(5,'Alonso Martínez',10,'Alonso Martínez',60).
tiempo(5,'Gran Vía',1,'Gran Vía',60).
tiempo(5,'Callao',3,'Callao',60).
tiempo(5,'Ópera','2','Ópera',60).
tiempo(5,'Ópera','R','Ópera',60).
tiempo(5,'Acacias',3,'Embajadores',420).%Anomalía
tiempo(5,'Oporto',6,'Oporto',60).
tiempo(5,'Casa de Campo',10,'Casa de Campo',60).

% ----------------------------------------------------------------------
% Línea 6 (112.5)
% ----------------------------------------------------------------------
tiempo(6,'Laguna',6,'Carpetana',325).
tiempo(6,'Carpetana',6,'Oporto',354).
tiempo(6,'Oporto',6,'Opañel',334).
tiempo(6,'Opañel',6,'Plaza Elíptica',325).
tiempo(6,'Plaza Elíptica',6,'Usera',363).
tiempo(6,'Usera',6,'Legazpi',367).
tiempo(6,'Legazpi',6,'Arganzuela-Planetario',321).
tiempo(6,'Arganzuela-Planetario',6,'Méndez Álvaro',339).
tiempo(6,'Méndez Álvaro',6,'Pacífico',349).
tiempo(6,'Pacífico',6,'Conde de Casal',331).
tiempo(6,'Conde de Casal',6,'Sainz de Baranda',344).
tiempo(6,'Sainz de Baranda',6,'O´Donnell',335).
tiempo(6,'O´Donnell',6,'Manuel Becerra',313).
tiempo(6,'Manuel Becerra',6,'Diego de León',333).
tiempo(6,'Diego de León',6,'Avenida de América',298).
tiempo(6,'Avenida de América',6,'República Argentina',351).
tiempo(6,'República Argentina',6,'Nuevos Ministerios',362).
tiempo(6,'Nuevos Ministerios',6,'Cuatro Caminos',334).
tiempo(6,'Cuatro Caminos',6,'Guzmán el Bueno',332).
tiempo(6,'Guzmán el Bueno',6,'Metropolitano',317).
tiempo(6,'Metropolitano',6,'Ciudad Universitaria',324).
tiempo(6,'Ciudad Universitaria',6,'Moncloa',416).
tiempo(6,'Moncloa',6,'Argüelles',209). % Igual a tiempo sobre línea 3
tiempo(6,'Argüelles',6,'Príncipe Pío',420).
tiempo(6,'Príncipe Pío',6,'Puerta del Ángel',390).
tiempo(6,'Puerta del Ángel',6,'Alto de Extremadura',373).
tiempo(6,'Alto de Extremadura',6,'Lucero',359).
tiempo(6,'Lucero',6,'Laguna',325).

% tiempos de correspondencias
tiempo(6,'Oporto',5,'Oporto',60).
tiempo(6,'Plaza Elíptica',11,'Plaza Elíptica',60).
tiempo(6,'Legazpi',3,'Legazpi',60).
tiempo(6,'Pacífico',1,'Pacífico',60).
tiempo(6,'Sainz de Baranda',9,'Sainz de Baranda',60).
tiempo(6,'Manuel Becerra',2,'Manuel Becerra',60).
tiempo(6,'Diego de León',4,'Diego de León',540).
tiempo(6,'Diego de León',5,'Diego de León',300).
tiempo(6,'Avenida de América',4,'Avenida de América',60).
tiempo(6,'Avenida de América',7,'Avenida de América',60).
tiempo(6,'Avenida de América',9,'Avenida de América',60).
tiempo(6,'Nuevos Ministerios',8,'Nuevos Ministerios',420).
tiempo(6,'Nuevos Ministerios',10,'Nuevos Ministerios',420).
tiempo(6,'Cuatro Caminos',1,'Cuatro Caminos',60).
tiempo(6,'Cuatro Caminos',2,'Cuatro Caminos',60).
tiempo(6,'Guzmán el Bueno',7,'Guzmán el Bueno',60).
tiempo(6,'Moncloa',3,'Moncloa',60).
tiempo(6,'Argüelles',3,'Argüelles',60).
tiempo(6,'Argüelles',4,'Argüelles',60).
tiempo(6,'Príncipe Pío',10,'Príncipe Pío',60).
tiempo(6,'Príncipe Pío','R','Príncipe Pío',60).


% ----------------------------------------------------------------------
% Línea 7 (172)
% ----------------------------------------------------------------------
tiempo(7,'Hospital del Henares',7,'Henares',425).
tiempo(7,'Henares',7,'Jarama',452).
tiempo(7,'Jarama',7,'San Fernando',501).
tiempo(7,'San Fernando',7,'La Rambla',518).
tiempo(7,'La Rambla',7,'Coslada Central',464).
tiempo(7,'Coslada Central',7,'Barrio del Puerto',408).
tiempo(7,'Barrio del Puerto',7,'Estadio Olímpico',733).
tiempo(7,'Estadio Olímpico',7,'Las Musas',326).
tiempo(7,'Las Musas',7,'San Blas',386).
tiempo(7,'San Blas',7,'Simancas',382).
tiempo(7,'Simancas',7,'García Noblejas',378).
tiempo(7,'García Noblejas',7,'Ascao',374).
tiempo(7,'Ascao',7,'Pueblo Nuevo',365).
tiempo(7,'Pueblo Nuevo',7,'Barrio de la Concepción',399).
tiempo(7,'Barrio de la Concepción',7,'Parque de las Avenidas',393).
tiempo(7,'Parque de las Avenidas',7,'Cartagena',365).
tiempo(7,'Cartagena',7,'Avenida de América',367).
tiempo(7,'Avenida de América',7,'Gregorio Marañón',414).
tiempo(7,'Gregorio Marañón',7,'Alonso Cano',353).
tiempo(7,'Alonso Cano',7,'Canal',333).
tiempo(7,'Canal',7,'Islas Filipinas',371).
tiempo(7,'Islas Filipinas',7,'Guzmán el Bueno',464).
tiempo(7,'Guzmán el Bueno',7,'Francos Rodríguez',421).
tiempo(7,'Francos Rodríguez',7,'Valdezarza',429).
tiempo(7,'Valdezarza',7,'Antonio Machado',387).
tiempo(7,'Antonio Machado',7,'Peñagrande',357).
tiempo(7,'Peñagrande',7,'Avenida de la Ilustración',342).
tiempo(7,'Avenida de la Ilustración',7,'Lacoma',360).
tiempo(7,'Lacoma',7,'Pitis',439).

% tiempos de correspondencias
tiempo(7,'Pueblo Nuevo',5,'Pueblo Nuevo',60).
tiempo(7,'Avenida de América',4,'Avenida de América',60).
tiempo(7,'Avenida de América',6,'Avenida de América',60).
tiempo(7,'Avenida de América',9,'Avenida de América',60).
tiempo(7,'Gregorio Marañón',10,'Gregorio Marañón',60).
tiempo(7,'Canal',2,'Canal',60).
tiempo(7,'Guzmán el Bueno',6,'Guzmán el Bueno',60).

% ----------------------------------------------------------------------
% Línea 8 (105)
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
% Línea 9 (105)
% ----------------------------------------------------------------------
tiempo(9,'Herrera Oria',9,'Barrio del Pilar',343).
tiempo(9,'Barrio del Pilar',9,'Ventilla',353).
tiempo(9,'Ventilla',9,'Plaza de Castilla',330).
tiempo(9,'Plaza de Castilla',9,'Duque de Pastrana',295).
tiempo(9,'Duque de Pastrana',9,'Pío XII',314).
tiempo(9,'Pío XII',9,'Colombia',308).
tiempo(9,'Colombia',9,'Concha Espina',310).
tiempo(9,'Concha Espina',9,'Cruz del Rayo',308).
tiempo(9,'Cruz del Rayo',9,'Avenida de América',309).
tiempo(9,'Avenida de América',9,'Núñez de Balboa',310).
tiempo(9,'Núñez de Balboa',9,'Príncipe de Vergara',323).
tiempo(9,'Príncipe de Vergara',9,'Ibiza',309).
tiempo(9,'Ibiza',9,'Sainz de Baranda',342).
tiempo(9,'Sainz de Baranda',9,'Estrella',326).
tiempo(9,'Estrella',9,'Vinateros',334).
tiempo(9,'Vinateros',9,'Artilleros',329).
tiempo(9,'Artilleros',9,'Pavones',339).
tiempo(9,'Pavones',9,'Valdebernardo',405).
tiempo(9,'Valdebernardo',9,'Vicálvaro',402).
tiempo(9,'Vicálvaro',9,'San Cipriano',280).
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
tiempo(9,'Avenida de América',4,'Avenida de América',60).
tiempo(9,'Avenida de América',6,'Avenida de América',60).
tiempo(9,'Avenida de América',7,'Avenida de América',60).
tiempo(9,'Núñez de Balboa',5,'Núñez de Balboa',360).
tiempo(9,'Príncipe de Vergara',2,'Príncipe de Vergara',60).
tiempo(9,'Sainz de Baranda',6,'Sainz de Baranda',60).

% ----------------------------------------------------------------------
% Línea 10 (149.6)
% ----------------------------------------------------------------------
tiempo(10,'Hospital Infanta Sofía',10,'Reyes Católicos',457).
tiempo(10,'Reyes Católicos',10,'Baunatal',429).
tiempo(10,'Baunatal',10,'Manuel de Falla',413).
tiempo(10,'Manuel de Falla',10,'Marqués de la Valdavia',431).
tiempo(10,'Marqués de la Valdavia',10,'La Moraleja',415).
tiempo(10,'La Moraleja',10,'La Granja',509).
tiempo(10,'La Granja',10,'Ronda de la Comunicación',427).
tiempo(10,'Ronda de la Comunicación',10,'Las Tablas',416).
tiempo(10,'Las Tablas',10,'Montecarmelo',556).
tiempo(10,'Montecarmelo',10,'Tres Olivos',383).
tiempo(10,'Tres Olivos',10,'Fuencarral',255).
tiempo(10,'Fuencarral',10,'Begoña',346).
tiempo(10,'Begoña',10,'Chamartín',300).
tiempo(10,'Chamartín',10,'Plaza de Castilla',276).
tiempo(10,'Plaza de Castilla',10,'Cuzco',284).
tiempo(10,'Cuzco',10,'Santiago Bernabéu',273).
tiempo(10,'Santiago Bernabéu',10,'Nuevos Ministerios',272).
tiempo(10,'Nuevos Ministerios',10,'Gregorio Marañón',279).
tiempo(10,'Gregorio Marañón',10,'Alonso Martínez',314).
tiempo(10,'Alonso Martínez',10,'Tribunal',245).
tiempo(10,'Tribunal',10,'Plaza de España',259).
tiempo(10,'Plaza de España',10,'Príncipe Pío',287).
tiempo(10,'Príncipe Pío',10,'Lago',359).
tiempo(10,'Lago',10,'Batán',399).
tiempo(10,'Batán',10,'Casa de Campo',288).
tiempo(10,'Casa de Campo',10,'Colonia Jardín',331).
tiempo(10,'Colonia Jardín',10,'Aviación Española',400).
tiempo(10,'Aviación Española',10,'Cuatro Vientos',294).
tiempo(10,'Cuatro Vientos',10,'Joaquín Vilumbrales',565).
tiempo(10,'Joaquín Vilumbrales',10,'Puerta del Sur',263).

% tiempos de correspondencias
tiempo(10,'Las Tablas',ml1,'Las Tablas',60).
%tiempo(10,'Tres Olivos',10,'Tres Olivos',60). % OJO: Cambio de tren
tiempo(10,'Chamartín',1,'Chamartín',60).
tiempo(10,'Plaza de Castilla',1,'Plaza de Castilla',60).
tiempo(10,'Plaza de Castilla',9,'Plaza de Castilla',60).
tiempo(10,'Nuevos Ministerios',6,'Nuevos Ministerios',420).
tiempo(10,'Nuevos Ministerios',8,'Nuevos Ministerios',60).
tiempo(10,'Gregorio Marañón',7,'Gregorio Marañón',60).
tiempo(10,'Alonso Martínez',4,'Alonso Martínez',60).
tiempo(10,'Alonso Martínez',5,'Alonso Martínez',60).
tiempo(10,'Tribunal',1,'Tribunal',60).
tiempo(10,'Plaza de España',2,'Noviciado',300).% Anomalía
tiempo(10,'Plaza de España',3,'Plaza de España',60).
tiempo(10,'Príncipe Pío',6,'Príncipe Pío',60).
tiempo(10,'Príncipe Pío','R','Príncipe Pío',60).
tiempo(10,'Casa de Campo',5,'Casa de Campo',60).
tiempo(10,'Colonia Jardín',ml2,'Colonia Jardín',60).
tiempo(10,'Colonia Jardín',ml3,'Colonia Jardín',60).
tiempo(10,'Puerta del Sur',12,'Puerta del Sur',60).

% ----------------------------------------------------------------------
% Línea 11 (179.6)
% ----------------------------------------------------------------------
tiempo(11,'Plaza Elíptica',11,'Abrantes',496).
tiempo(11,'Abrantes',11,'Pan Bendito',477).
tiempo(11,'Pan Bendito',11,'San Francisco',439).
tiempo(11,'San Francisco',11,'Carabanchel Alto',515).
tiempo(11,'Carabanchel Alto',11,'La Peseta',482).

% tiempos de correspondencias
tiempo(11,'Plaza Elíptica',6,'Plaza Elíptica',60).

% ----------------------------------------------------------------------
% Línea 12 (165)
% ----------------------------------------------------------------------
tiempo(12,'Puerta del Sur',12,'Parque Lisboa',408).
tiempo(12,'Parque Lisboa',12,'Alcorcón Central',440).
tiempo(12,'Alcorcón Central',12,'Parque Oeste',476).
tiempo(12,'Parque Oeste',12,'Universidad Rey Juan Carlos',565).
tiempo(12,'Universidad Rey Juan Carlos',12,'Móstoles Central',443).
tiempo(12,'Móstoles Central',12,'Pradillo',397).
tiempo(12,'Pradillo',12,'Hospital de Móstoles',424).
tiempo(12,'Hospital de Móstoles',12,'Manuela Malasaña',468).
tiempo(12,'Manuela Malasaña',12,'Loranca',590).
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
tiempo(12,'El Carrascal',12,'Julián Besteiro',424).
tiempo(12,'Julián Besteiro',12,'Casa del Reloj',453).
tiempo(12,'Casa del Reloj',12,'Hospital Severo Ochoa',411).
tiempo(12,'Hospital Severo Ochoa',12,'Leganés Central',430).
tiempo(12,'Leganés Central',12,'San Nicasio',429).
tiempo(12,'San Nicasio',12,'Puerta del Sur',408).

% tiempos de correspondencias
tiempo(12,'Puerta del Sur',10,'Puerta del Sur',60).

% ----------------------------------------------------------------------
% Línea 'R' (0)
% ----------------------------------------------------------------------
tiempo('R','Ópera','R','Príncipe Pío',592).

% tiempos de correspondencias
tiempo('R','Ópera',2,'Ópera',60).
tiempo('R','Ópera',5,'Ópera',60).
tiempo('R','Príncipe Pío',6,'Príncipe Pío',60).
tiempo('R','Príncipe Pío',10,'Príncipe Pío',60).

% ----------------------------------------------------------------------
% Línea ml1 (150)
% ----------------------------------------------------------------------
tiempo(ml1,'Pinar de Chamartín',ml1,'Fuente de la Mora',415).
tiempo(ml1,'Fuente de la Mora',ml1,'Virgen del Cortijo',397).
tiempo(ml1,'Virgen del Cortijo',ml1,'Antonio Saura',465).
tiempo(ml1,'Antonio Saura',ml1,'Álvarez de Villaamil',425).
tiempo(ml1,'Álvarez de Villaamil',ml1,'Blasco Ibáñez',434).
tiempo(ml1,'Blasco Ibáñez',ml1,'María Tudor',396).
tiempo(ml1,'María Tudor',ml1,'Palas de Rey',523).
tiempo(ml1,'Palas de Rey',ml1,'Las Tablas',425).

% tiempos de correspondencias
tiempo(ml1,'Pinar de Chamartín',1,'Pinar de Chamartín',60).
tiempo(ml1,'Pinar de Chamartín',4,'Pinar de Chamartín',60).
tiempo(ml1,'Las Tablas',10,'Las Tablas',60).

% ----------------------------------------------------------------------
% Línea ml2 (225)
% ----------------------------------------------------------------------
tiempo(ml2,'Colonia Jardín',ml2,'Prado de la Vega',588).
tiempo(ml2,'Prado de la Vega',ml2,'Colonia de los Ángeles',545).
tiempo(ml2,'Colonia de los Ángeles',ml2,'Prado del Rey',522).
tiempo(ml2,'Prado del Rey',ml2,'Somosaguas Sur',573).
tiempo(ml2,'Somosaguas Sur',ml2,'Somosaguas Centro',565).
tiempo(ml2,'Somosaguas Centro',ml2,'Pozuelo Oeste',552).
tiempo(ml2,'Pozuelo Oeste',ml2,'Bélgica',661).
tiempo(ml2,'Bélgica',ml2,'Dos Castillas',533).
tiempo(ml2,'Dos Castillas',ml2,'Campus de Somosaguas',542).
tiempo(ml2,'Campus de Somosaguas',ml2,'Avenida de Europa',562).
tiempo(ml2,'Avenida de Europa',ml2,'Berna',552).
tiempo(ml2,'Berna',ml2,'Estación de Aravaca',553).

% tiempos de correspondencias
tiempo(ml2,'Colonia Jardín', 10,'Colonia Jardín',60).
tiempo(ml2,'Colonia Jardín', ml3,'Colonia Jardín',60).

% ----------------------------------------------------------------------
% Línea ml3 (225)
% ----------------------------------------------------------------------
tiempo(ml3,'Colonia Jardín',ml3,'Ciudad de la Imagen',591).
tiempo(ml3,'Ciudad de la Imagen',ml3,'José Isbert',535).
tiempo(ml3,'José Isbert',ml3,'Ciudad del Cine',522).
tiempo(ml3,'Ciudad del Cine',ml3,'Cocheras',592).
tiempo(ml3,'Cocheras',ml3,'Retamares',638).
tiempo(ml3,'Retamares',ml3,'Montepríncipe',713).
tiempo(ml3,'Montepríncipe',ml3,'Ventorro del Cano',525).
tiempo(ml3,'Ventorro del Cano',ml3,'Prado del Espino',574).
tiempo(ml3,'Prado del Espino',ml3,'Cantabria',679).
tiempo(ml3,'Cantabria',ml3,'Ferial de Boadilla',726).
tiempo(ml3,'Ferial de Boadilla',ml3,'Boadilla Centro',551).
tiempo(ml3,'Boadilla Centro',ml3,'Nuevo Mundo',540).
tiempo(ml3,'Nuevo Mundo',ml3,'Siglo XXI',539).
tiempo(ml3,'Siglo XXI',ml3,'Infante Don Luis',512).
tiempo(ml3,'Infante Don Luis',ml3,'Puerta de Boadilla',542).

% tiempos de correspondencias
tiempo(ml3,'Colonia Jardín', 10,'Colonia Jardín',60).
tiempo(ml3,'Colonia Jardín', ml2,'Colonia Jardín',60).

% Parche para arreglar algunos problemas.
tiempo(L,Est,L,Est,0).












