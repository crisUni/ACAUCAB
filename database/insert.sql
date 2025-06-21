-- ▗▖   ▗▖ ▗▖ ▗▄▄▖ ▗▄▖ ▗▄▄▖ 
-- ▐▌   ▐▌ ▐▌▐▌   ▐▌ ▐▌▐▌ ▐▌
-- ▐▌   ▐▌ ▐▌▐▌▝▜▌▐▛▀▜▌▐▛▀▚▖
-- ▐▙▄▄▖▝▚▄▞▘▝▚▄▞▘▐▌ ▐▌▐▌ ▐▌

-- FUNCTIONS --
-- Insert Estados --
CREATE OR REPLACE PROCEDURE insert_estados(varchar(50)[]) AS $$
DECLARE
    x varchar(50);
BEGIN
    FOREACH x IN ARRAY $1
    LOOP
    INSERT INTO Lugar (nombre, tipo, fk_lugar)
VALUES (x, 'ESTADO', NULL);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Insert Municipios --
CREATE OR REPLACE PROCEDURE insert_municipios(varchar(50)[], text) AS $$
DECLARE
    fid integer = (SELECT eid FROM Lugar WHERE nombre = $2 AND tipo = 'ESTADO' LIMIT 1);
    x varchar(50);
BEGIN
    FOREACH x IN ARRAY $1
    LOOP
    INSERT INTO Lugar (nombre, tipo, fk_lugar)
VALUES (x, 'MUNICIPIO', fid);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Insert Parroquias --
CREATE OR REPLACE PROCEDURE insert_parroquias(varchar(50)[], text) AS $$
DECLARE
    fid integer = (SELECT eid FROM Lugar WHERE nombre = $2 AND tipo = 'MUNICIPIO' LIMIT 1);
    x varchar(40);
BEGIN
    FOREACH x IN ARRAY $1
    LOOP
    INSERT INTO Lugar (nombre, tipo, fk_lugar)
VALUES (x, 'PARROQUIA', fid);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

DELETE FROM Lugar;

-- INSERT --
CALL insert_estados(ARRAY ['Amazonas', 'Anzoategui', 'Apure', 'Aragua', 'Barinas', 'Bolivar', 'Carabobo', 'Cojedes', 'Delta Amacuro', 'Distrito Capital', 'Falcon', 'Guarico', 'La Guaira', 'Lara', 'Merida', 'Miranda', 'Monagas', 'Nueva Esparta', 'Portuguesa', 'Sucre', 'Tachira', 'Trujillo', 'Yaracuy', 'Zulia']);

-- Amazonas
CALL insert_municipios(ARRAY['Altures', 'Alto Orinoco', 'Atabapo', 'Autana', 'Manapiare', 'Maroa', 'Rio Negro'], 'Amazonas');
CALL insert_parroquias(ARRAY['Fernando Giron Tovar', 'Luis Alberto Gomez', 'Parhueña', 'Platanillal'], 'Altures');
CALL insert_parroquias(ARRAY['La Esmeralda', 'Marawaka', 'Mavaca', 'Sierra Parima'], 'Alto Orinoco');
CALL insert_parroquias(ARRAY['San Fernando de Atabapo', 'Laja Lisa', 'Santa Barbara', 'Guarinuma'], 'Atabapo');
CALL insert_parroquias(ARRAY['Isla Raton', 'San Pedro del Orinoco', 'Pendare', 'Manduapo', 'Samariapo'], 'Autana');
CALL insert_parroquias(ARRAY['San Juan de Manapiare', 'Camani', 'Capure', 'Manueta'], 'Manapiare');
CALL insert_parroquias(ARRAY['Maroa', 'Comunidad', 'Victorino'], 'Maroa');
CALL insert_parroquias(ARRAY['San Carlos de Rio Negro', 'Solano', 'Curimacare', 'Santa Lucia'], 'Rio Negro');

-- Anzoategui
CALL insert_municipios(ARRAY['Anaco', 'Aragua', 'Diego Bautista Urbaneja', 'Fernando de Peñalver', 'Francisco del Carmen Carvajal', 'Francisco de Miranda', 'Guanta', 'Independencia', 'Jose Gregorio Monagas', 'Juan Antonio Sotillo', 'Juan Manuel Cajigal', 'Libertad', 'Manuel Ezequiel Bruzual', 'Pedro Maria Freites', 'Piritu', 'Guanipa', 'San Juan de Capistrano', 'Santa Ana', 'Simon Bolivar', 'Simon Rodriguez', 'Sir Arthur McGregor'], 'Anzoategui');
CALL insert_parroquias(ARRAY['Anaco', 'San Joaquin'], 'Anaco');
CALL insert_parroquias(ARRAY['Cachipo', 'Aragua de Barcelona'], 'Aragua');
CALL insert_parroquias(ARRAY['Lecheria', 'El Morro'], 'Diego Bautista Urbaneja');
CALL insert_parroquias(ARRAY['San Miguel', 'Sucre'], 'Fernando de Peñalver');
CALL insert_parroquias(ARRAY['Valle de Guanape', 'Santa Barbara'], 'Francisco del Carmen Carvajal');
CALL insert_parroquias(ARRAY['Atapirire', 'Boca del Pao', 'El Pao', 'Pariaguan'], 'Francisco de Miranda');
CALL insert_parroquias(ARRAY['Guanta', 'Chorreron'], 'Guanta');
CALL insert_parroquias(ARRAY['Mamo', 'Soledad'], 'Independencia');
CALL insert_parroquias(ARRAY['Mapire', 'Piar', 'Santa Clara', 'San Diego de Cabrutica', 'Uverito', 'Zuata'], 'Jose Gregorio Monagas');
CALL insert_parroquias(ARRAY['Puerto La Cruz', 'Pozuelos'], 'Juan Antonio Sotillo');
CALL insert_parroquias(ARRAY['Onoto', 'San Pablo'], 'Juan Manuel Cajigal');
CALL insert_parroquias(ARRAY['San Mateo', 'El Carito', 'Santa Ines', 'La Romereña'], 'Libertad');
CALL insert_parroquias(ARRAY['Clarines', 'Guanape', 'Sabana de Uchire'], 'Manuel Ezequiel Bruzual');
CALL insert_parroquias(ARRAY['Cantaura', 'Libertador', 'Santa Rosa', 'Urica'], 'Pedro Maria Freites');
CALL insert_parroquias(ARRAY['Piritu', 'San Francisco'], 'Piritu');
CALL insert_parroquias(ARRAY['San Jose de Guanipa'], 'Guanipa');
CALL insert_parroquias(ARRAY['Boca de Uchire', 'Boca de Chavez'], 'San Juan de Capistrano');
CALL insert_parroquias(ARRAY['Pueblo Nuevo', 'Santa Ana'], 'Santa Ana');
CALL insert_parroquias(ARRAY['Bergantin', 'El Pilar', 'Naricual', 'San Cristobal'], 'Simon Bolivar');
CALL insert_parroquias(ARRAY['Edmundo Barrios', 'Miguel Otero Silva'], 'Simon Rodriguez');
CALL insert_parroquias(ARRAY['El Chaparro', 'Tomas Alfaro', 'Calatrava'], 'Sir Arthur McGregor');

-- Apure
CALL insert_municipios(ARRAY['Achaguas', 'Biruaca', 'Muñoz', 'Paez', 'Pedro Camejo', 'Romulo Gallegos', 'San Fernando'], 'Apure');
CALL insert_parroquias(ARRAY['Achaguas', 'Apurito', 'El Yagual', 'Guachara', 'Mucuritas', 'Queseras del Medio'], 'Achaguas');
CALL insert_parroquias(ARRAY['Biruaca'], 'Biruaca');
CALL insert_parroquias(ARRAY['Bruzual', 'Santa Barbara'], 'Muñoz');
CALL insert_parroquias(ARRAY['Guasdualito', 'Aramendi', 'El Amparo', 'San Camilo', 'Urdaneta', 'Canagua', 'Dominga Ortiz de Paez', 'Santa Rosalia'], 'Paez');
CALL insert_parroquias(ARRAY['San Juan de Payara', 'Codazzi', 'Cunaviche'], 'Pedro Camejo');
CALL insert_parroquias(ARRAY['Elorza', 'La Trinidad de Orichuna'], 'Romulo Gallegos');
CALL insert_parroquias(ARRAY['El Recreo', 'Peñalver', 'San Fernando de Apure', 'San Rafael de Atamaica'], 'San Fernando');

-- Aragua 
CALL insert_municipios(ARRAY['Girardot', 'Bolivar', 'Mario Briceño Iragorry', 'Santos Michelena', 'Sucre', 'Santiago Mariño', 'Jose angel Lamas', 'Francisco Linares Alcantara', 'San Casimiro', 'Urdaneta', 'Jose Felix Ribas', 'Jose Rafael Revenga', 'Ocumare de la Costa de Oro', 'Tovar', 'Camatagua', 'Zamora', 'San Sebastian', 'Libertador'], 'Aragua'); 
CALL insert_parroquias(ARRAY['Bolivar San Mateo'], 'Bolivar');
CALL insert_parroquias(ARRAY['Camatagua', 'Carmen de Cura'], 'Camatagua');
CALL insert_parroquias(ARRAY['Santa Rita', 'Francisco de Miranda', 'Moseñor Feliciano Gonzalez Paraparal'], 'Francisco Linares Alcantara');
CALL insert_parroquias(ARRAY['Pedro Jose Ovalles', 'Joaquin Crespo', 'Jose Casanova Godoy', 'Madre Maria de San Jose', 'Andres Eloy Blanco', 'Los Tacarigua', 'Las Delicias', 'Choroni'], 'Girardot');
CALL insert_parroquias(ARRAY['Santa Cruz'], 'Jose angel Lamas');
CALL insert_parroquias(ARRAY['Jose Felix Ribas', 'Castor Nieves Rios', 'Las Guacamayas', 'Pao de Zarate', 'Zuata'], 'Jose Felix Ribas');
CALL insert_parroquias(ARRAY['Jose Rafael Revenga'], 'Jose Rafael Revenga');
CALL insert_parroquias(ARRAY['Palo Negro', 'San Martin de Porres'], 'Libertador');
CALL insert_parroquias(ARRAY['El Limon', 'Caña de Azucar'], 'Mario Briceño Iragorry');
CALL insert_parroquias(ARRAY['Ocumare de la Costa'], 'Ocumare de la Costa de Oro');
CALL insert_parroquias(ARRAY['San Casimiro', 'Güiripa', 'Ollas de Caramacate', 'Valle Morin'], 'San Casimiro');
CALL insert_parroquias(ARRAY['San Sebastian'], 'San Sebastian');
CALL insert_parroquias(ARRAY['Turmero', 'Arevalo Aponte', 'Chuao', 'Saman de Güere', 'Alfredo Pacheco Miranda'], 'Santiago Mariño');
CALL insert_parroquias(ARRAY['Santos Michelena', 'Tiara'], 'Santos Michelena');
CALL insert_parroquias(ARRAY['Cagua', 'Bella Vista'], 'Sucre');
CALL insert_parroquias(ARRAY['Tovar'], 'Tovar');
CALL insert_parroquias(ARRAY['Urdaneta', 'Las Peñitas', 'San Francisco de Cara', 'Taguay'], 'Urdaneta');
CALL insert_parroquias(ARRAY['Zamora', 'Magdaleno', 'San Francisco de Asis', 'Valles de Tucutunemo', 'Augusto Mijares'], 'Zamora');

-- Barinas
CALL insert_municipios(ARRAY['Alberto Arvelo Torrealba', 'Andres Eloy Blanco', 'Antonio Jose de Sucre', 'Arismendi', 'Barinas', 'Bolivar', 'Cruz Paredes', 'Ezequiel Zamora', 'Obispos', 'Pedraza', 'Sosa', 'Rojas'], 'Barinas');
CALL insert_parroquias(ARRAY['Arismendi', 'Guadarrama', 'La Union', 'San Antonio'], 'Arismendi');
CALL insert_parroquias(ARRAY['Barinas', 'Alfredo Arvelo Larriva', 'San Silvestre', 'Santa Ines', 'Santa Lucia', 'Torunos', 'El Carmen', 'Romulo Betancourt', 'Corazon de Jesus', 'Ramon Ignacio Mendez', 'Alto Barinas', 'Manuel Palacio Fajardo', 'Juan Antonio Rodriguez Dominguez', 'Dominga Ortiz de Paez'], 'Barinas');
CALL insert_parroquias(ARRAY['El Canton', 'Santa Cruz de Guacas', 'Puerto Vivas'], 'Andres Eloy Blanco');
CALL insert_parroquias(ARRAY['Barinitas', 'Altamira de Caceres', 'Calderas'], 'Bolivar');
CALL insert_parroquias(ARRAY['Masparrito', 'El Socorro', 'Barrancas'], 'Cruz Paredes');
CALL insert_parroquias(ARRAY['Obispos', 'El Real', 'La Luz', 'Los Guasimitos'], 'Obispos');
CALL insert_parroquias(ARRAY['Ciudad Bolivia', 'Ignacio Briceño', 'Jose Felix Ribas', 'Paez'], 'Pedraza');
CALL insert_parroquias(ARRAY['Libertad', 'Dolores', 'Santa Rosa', 'Simon Rodriguez', 'Palacio Fajardo'], 'Rojas');
CALL insert_parroquias(ARRAY['Ciudad de Nutrias', 'El Regalo', 'Puerto Nutrias', 'Santa Catalina', 'Simon Bolivar'], 'Sosa');
CALL insert_parroquias(ARRAY['Ticoporo', 'Nicolas Pulido', 'Andres Bello'], 'Antonio Jose de Sucre');
CALL insert_parroquias(ARRAY['Sabaneta', 'Juan Antonio Rodriguez Dominguez'], 'Alberto Arvelo Torrealba');
CALL insert_parroquias(ARRAY['Santa Barbara', 'Pedro Briceño Mendez', 'Ramon Ignacio Mendez', 'Jose Ignacio del Pumar'], 'Ezequiel Zamora');

-- Bolivar
CALL insert_municipios(ARRAY['Caroni', 'Cedeño', 'El Callao', 'Gran Sabana', 'Heres', 'Padre Pedro Chien', 'Piar', 'Angostura', 'Roscio', 'Sifontes', 'Sucre'], 'Bolivar');
CALL insert_parroquias(ARRAY['Cachamay', 'Chirica', 'Dalla Costa', 'Once de Abril', 'Simon Bolivar', 'Unare', 'Universidad', 'Vista al Sol', 'Pozo Verde', 'Yocoima', '5 de Julio'], 'Caroni');
CALL insert_parroquias(ARRAY['Cedeño', 'Altagracia', 'Ascension Farreras', 'Guaniamo', 'La Urbana', 'Pijiguaos'], 'Cedeño');
CALL insert_parroquias(ARRAY['El Callao'], 'El Callao');
CALL insert_parroquias(ARRAY['Gran Sabana', 'Ikabaru'], 'Gran Sabana');
CALL insert_parroquias(ARRAY['Catedral', 'Zea', 'Orinoco', 'Jose Antonio Paez', 'Marhuanta', 'Agua Salada', 'Vista Hermosa', 'La Sabanita', 'Panapana'], 'Heres');
CALL insert_parroquias(ARRAY['Padre Pedro Chien'], 'Padre Pedro Chien');
CALL insert_parroquias(ARRAY['Andres Eloy Blanco', 'Pedro Cova', 'Upata'], 'Piar');
CALL insert_parroquias(ARRAY['Raul Leoni', 'Barceloneta', 'Santa Barbara', 'San Francisco'], 'Angostura');
CALL insert_parroquias(ARRAY['Roscio', 'Salom'], 'Roscio');
CALL insert_parroquias(ARRAY['Tumeremo', 'Dalla Costa', 'San Isidro'], 'Sifontes');
CALL insert_parroquias(ARRAY['Sucre', 'Aripao', 'Guarataro', 'Las Majadas', 'Moitaco'], 'Sucre');

-- Carabobo
CALL insert_municipios(ARRAY['Bejuma','Carlos Arvelo','Diego Ibarra','Guacara','Juan Jose Mora','Libertador','Los Guayos','Miranda','Montalban','Naguanagua','Puerto Cabello','San Diego','San Joaquin','Valencia'],'Carabobo');
CALL insert_parroquias(ARRAY['Canoabo', 'Simon Bolivar'], 'Bejuma');
CALL insert_parroquias(ARRAY['Güigüe', 'Belen', 'Tacarigua'], 'Carlos Arvelo');
CALL insert_parroquias(ARRAY['Mariara', 'Aguas Calientes'], 'Diego Ibarra');
CALL insert_parroquias(ARRAY['Ciudad Alianza', 'Guacara', 'Yagua'], 'Guacara');
CALL insert_parroquias(ARRAY['Moron', 'Urama'], 'Juan Jose Mora');
CALL insert_parroquias(ARRAY['Tocuyito Valencia', 'Independencia Campo Carabobo'], 'Libertador');
CALL insert_parroquias(ARRAY['Los Guayos Valencia'], 'Los Guayos');
CALL insert_parroquias(ARRAY['Miranda'], 'Miranda');
CALL insert_parroquias(ARRAY['Montalban'], 'Montalban');
CALL insert_parroquias(ARRAY['Urbana Naguanagua Valencia'], 'Naguanagua');
CALL insert_parroquias(ARRAY['Bartolome Salom', 'Democracia', 'Fraternidad', 'Goaigoaza', 'Juan Jose Flores', 'Union', 'Borburata', 'Patanemo'], 'Puerto Cabello');
CALL insert_parroquias(ARRAY['San Diego Valencia'], 'San Diego');
CALL insert_parroquias(ARRAY['San Joaquin'], 'San Joaquin');
CALL insert_parroquias(ARRAY['Urbana Candelaria', 'Urbana Catedral', 'Urbana El Socorro', 'Urbana Miguel Peña', 'Urbana Rafael Urdaneta', 'Urbana San Blas', 'Urbana San Jose', 'Urbana Santa Rosa', 'Rural Negro Primero'], 'Valencia');

-- Cojedes
CALL insert_municipios(ARRAY['Anzoategui','Pao de San Juan Bautista','Tinaquillo','Girardot','Lima Blanco','Ricaurte','Romulo Gallegos','Ezequiel Zamora','Tinaco'],'Cojedes');
CALL insert_parroquias(ARRAY['Cojedes', 'Juan de Mata Suarez'], 'Anzoategui');
CALL insert_parroquias(ARRAY['El Pao'], 'Pao de San Juan Bautista');
CALL insert_parroquias(ARRAY['Tinaquillo'], 'Tinaquillo');
CALL insert_parroquias(ARRAY['El Baul', 'Sucre'], 'Girardot');
CALL insert_parroquias(ARRAY['La Aguadita', 'Macapo'], 'Lima Blanco');
CALL insert_parroquias(ARRAY['El Amparo', 'Libertad de Cojedes'], 'Ricaurte');
CALL insert_parroquias(ARRAY['Romulo Gallegos (Las Vegas)'], 'Romulo Gallegos');
CALL insert_parroquias(ARRAY['San Carlos de Austria', 'Juan angel Bravo', 'Manuel Manrique'], 'Ezequiel Zamora');
CALL insert_parroquias(ARRAY['General en Jefe Jos Laurencio Silva'], 'Tinaco');

-- Delta Amacuro
CALL insert_municipios(ARRAY['Antonio Diaz','Casacoima','Pedernales','Tucupita'],'Delta Amacuro');
CALL insert_parroquias(ARRAY['Curiapo','Almirante Luis Brion','Francisco Aniceto Lugo','Manuel Renaud','Padre Barral','Santos de Abelgas'],'Antonio Diaz');
CALL insert_parroquias(ARRAY['Imataca','Juan Bautista Arismendi','Manuel Piar','Romulo Gallegos'],'Casacoima');
CALL insert_parroquias(ARRAY['Pedernales','Luis Beltran Prieto Figueroa'],'Pedernales');
CALL insert_parroquias(ARRAY['San Jose','Jose Vidal Marcano','Leonardo Ruiz Pineda','Mariscal Antonio Jose de Sucre','Monseñor Argimiro Garcia','Virgen del Valle','San Rafael','Juan Millan'],'Tucupita');

-- Distrito Federal
CALL insert_municipios(ARRAY['Libertador'],'Distrito Capital');
CALL insert_parroquias(ARRAY['23 de Enero','Altagracia','Antimano','Caricuao','Catedral','Coche','El Junquito','El Paraiso','El Recreo','El Valle','La Candelaria','La Pastora','La Vega','Macarao','San Agustin','San Bernardino','San Jose','San Juan','San Pedro','Santa Rosalia','Santa Teresa','Sucre'],'Libertador');

-- Falcon
CALL insert_municipios(ARRAY['Acosta','Bolivar','Buchivacoa','Cacique Manaure','Carirubana','Colina','Dabajuro','Democracia','Falcon','Federacion','Jacura','Los Taques','Mauroa','Miranda','Monseñor Iturriza','Palmasola','Petit','Piritu','San Francisco','Jose Laurencio Silva','Sucre','Tocopero','Union','Urumaco','Zamora'],'Falcon');
CALL insert_parroquias(ARRAY['Capadare', 'La Pastora', 'Libertador', 'San Juan de los Cayos'], 'Acosta');
CALL insert_parroquias(ARRAY['Aracua', 'La Peña', 'San Luis'], 'Bolivar');
CALL insert_parroquias(ARRAY['Bariro', 'Borojo', 'Capatarida', 'Guajiro', 'Seque', 'Valle de Eroa', 'Zazarida'], 'Buchivacoa');
CALL insert_parroquias(ARRAY['Cacique Manaure (Yaracal)'], 'Cacique Manaure');
CALL insert_parroquias(ARRAY['Norte', 'Carirubana', 'Santa Ana', 'Urbana Punta Cardon'], 'Carirubana');
CALL insert_parroquias(ARRAY['La Vela de Coro', 'Acurigua', 'Guaibacoa', 'Las Calderas', 'Mataruca'], 'Colina');
CALL insert_parroquias(ARRAY['Dabajuro'], 'Dabajuro');
CALL insert_parroquias(ARRAY['Agua Clara', 'Avaria', 'Pedregal', 'Piedra Grande', 'Purureche'], 'Democracia');
CALL insert_parroquias(ARRAY['Adaure', 'Adicora', 'Baraived', 'Buena Vista', 'Jadacaquiva', 'El Vinculo', 'El Hato', 'Moruy', 'Pueblo Nuevo'], 'Falcon');
CALL insert_parroquias(ARRAY['Agua Larga', 'Churuguara', 'El Pauji', 'Independencia', 'Maparari'], 'Federacion');
CALL insert_parroquias(ARRAY['Agua Linda', 'Araurima', 'Jacura'], 'Jacura');
CALL insert_parroquias(ARRAY['Tucacas', 'Boca de Aroa'], 'Jose Laurencio Silva');
CALL insert_parroquias(ARRAY['Los Taques', 'Judibana'], 'Los Taques');
CALL insert_parroquias(ARRAY['Mene de Mauroa', 'San Felix', 'Casigua'], 'Mauroa');
CALL insert_parroquias(ARRAY['Guzman Guillermo', 'Mitare', 'Rio Seco', 'Sabaneta', 'San Antonio', 'San Gabriel', 'Santa Ana'], 'Miranda');
CALL insert_parroquias(ARRAY['Boca del Tocuyo', 'Chichiriviche', 'Tocuyo de la Costa'], 'Monseñor Iturriza');
CALL insert_parroquias(ARRAY['Palmasola'], 'Palmasola');
CALL insert_parroquias(ARRAY['Cabure', 'Colina', 'Curimagua'], 'Petit');
CALL insert_parroquias(ARRAY['San Jose de la Costa', 'Piritu'], 'Piritu');
CALL insert_parroquias(ARRAY['Capital San Francisco Mirimire'], 'San Francisco');
CALL insert_parroquias(ARRAY['Sucre', 'Pecaya'], 'Sucre');
CALL insert_parroquias(ARRAY['Tocopero'], 'Tocopero');
CALL insert_parroquias(ARRAY['El Charal', 'Las Vegas del Tuy', 'Santa Cruz de Bucaral'], 'Union');
CALL insert_parroquias(ARRAY['Bruzual', 'Urumaco'], 'Urumaco');
CALL insert_parroquias(ARRAY['Puerto Cumarebo', 'La Cienaga', 'La Soledad', 'Pueblo Cumarebo', 'Zazarida'], 'Zamora');

-- Guarico
CALL insert_municipios(ARRAY['Leonardo Infante','Julian Mellado','Francisco de Miranda','Monagas','Ribas','Roscio','Camaguan','San Jose de Guaribe','Las Mercedes','El Socorro','Ortiz','Santa Maria de Ipire','Chaguaramas','San Jeronimo de Guayabal', 'Juan Jose Rondon', 'Jose Felix Ribas', 'Jose Tadeo Monagas','Juan German Roscio','Pedro Zaraza'],'Guarico');
CALL insert_parroquias(ARRAY['Camaguan', 'Puerto Miranda', 'Uverito'], 'Camaguan');
CALL insert_parroquias(ARRAY['Chaguaramas'], 'Chaguaramas');
CALL insert_parroquias(ARRAY['El Socorro'], 'El Socorro');
CALL insert_parroquias(ARRAY['El Calvario', 'El Rastro', 'Guardatinajas', 'Capital Urbana Calabozo'], 'Francisco de Miranda');
CALL insert_parroquias(ARRAY['Tucupido', 'San Rafael de Laya'], 'Jose Felix Ribas');
CALL insert_parroquias(ARRAY['Altagracia de Orituco', 'San Rafael de Orituco', 'San Francisco Javier de Lezama', 'Paso Real de Macaira', 'Carlos Soublette', 'San Francisco de Macaira', 'Libertad de Orituco'], 'Jose Tadeo Monagas');
CALL insert_parroquias(ARRAY['Cantagallo', 'San Juan de los Morros', 'Parapara'], 'Juan German Roscio');
CALL insert_parroquias(ARRAY['El Sombrero', 'Sosa'], 'Julian Mellado');
CALL insert_parroquias(ARRAY['Las Mercedes', 'Cabruta', 'Santa Rita de Manapire'], 'Juan Jose Rondon');
CALL insert_parroquias(ARRAY['Valle de la Pascua', 'Espino'], 'Leonardo Infante');
CALL insert_parroquias(ARRAY['San Jose de Tiznados', 'San Francisco de Tiznados', 'San Lorenzo de Tiznados', 'Ortiz'], 'Ortiz');
CALL insert_parroquias(ARRAY['San Jose de Unare', 'Zaraza'], 'Pedro Zaraza');
CALL insert_parroquias(ARRAY['Guayabal', 'Cazorla'], 'San Jeronimo de Guayabal');
CALL insert_parroquias(ARRAY['San Jose de Guaribe'], 'San Jose de Guaribe');
CALL insert_parroquias(ARRAY['Santa Maria de Ipire', 'Altamira'], 'Santa Maria de Ipire');

-- La Guaira
CALL insert_municipios(ARRAY['Vargas'], 'La Guaira');
CALL insert_parroquias(ARRAY['Caraballeda','Carayaca','Carlos Soublette','Caruao','Catia La Mar','El Junko','La Guaira','Macuto','Maiquetia','Naiguata','Urimare'],'Vargas');

-- Lara
CALL insert_municipios(ARRAY['Iribarren','Jimenez','Crespo','Andres Eloy Blanco','Urdaneta','Torres','Palavecino','Moran','Simon Planas'],'Lara');
CALL insert_parroquias(ARRAY['Quebrada Honda de Guache', 'Pio Tamayo', 'Yacambu'], 'Andres Eloy Blanco');
CALL insert_parroquias(ARRAY['Freitez', 'Jose Maria Blanco'], 'Crespo');
CALL insert_parroquias(ARRAY['Anzoategui', 'Bolivar', 'Guarico', 'Hilario Luna y Luna', 'Humocaro Bajo', 'Humocaro Alto', 'La Candelaria', 'Moran'], 'Moran');
CALL insert_parroquias(ARRAY['Cabudare', 'Jose Gregorio Bastidas', 'Agua Viva'], 'Palavecino');
CALL insert_parroquias(ARRAY['Buria', 'Gustavo Vega', 'Sarare'], 'Simon Planas');
CALL insert_parroquias(ARRAY['Altagracia', 'Antonio Diaz', 'Camacaro', 'Castañeda', 'Cecilio Zubillaga', 'Chiquinquira', 'El Blanco', 'Espinoza de los Monteros', 'Heriberto Arrollo', 'Lara', 'Las Mercedes', 'Manuel Morillo', 'Montaña Verde', 'Montes de Oca', 'Reyes de Vargas', 'Torres', 'Trinidad Samuel'], 'Torres');
CALL insert_parroquias(ARRAY['Xaguas', 'Siquisique', 'San Miguel', 'Moroturo'], 'Urdaneta');
CALL insert_parroquias(ARRAY['Aguedo Felipe Alvarado', 'Buena Vista', 'Catedral', 'Concepcion', 'El Cuji', 'Juares', 'Guerrera Ana Soto', 'Santa Rosa', 'Tamaca', 'Union'], 'Iribarren');
CALL insert_parroquias(ARRAY['Juan Bautista Rodriguez', 'Cuara', 'Diego de Lozada', 'Paraiso de San Jose', 'San Miguel', 'Tintorero', 'Jose Bernardo Dorante', 'Coronel Mariano Peraza'], 'Jimenez');

-- Merida
CALL insert_municipios(ARRAY['Antonio Pinto Salinas','Aricagua','Arzobispo Chacon','Campo Elias','Caracciolo Parra Olmedo','Cardenal Quintero','Chacanta','El Mucuy','Guaraque','Julio Cesar Salas','Justo Briceño','Libertador','Luis Cristobal Moncada','Rivas Davila','Rangel','Santos Marquina','Tovar','Tulio Febres Cordero','Alberto Adriani','Andres Bello','Miranda','Zea','Sucre','Pueblo Llano','Obispo Ramos de Lora','Padre Noguera'],'Merida');
CALL insert_parroquias(ARRAY['Presidente Betancourt','Presidente Paez','Presidente Romulo Gallegos','Gabriel Picon Gonzalez','Hector Amable Mora','Jose Nucete Sardi','Pulido Mendez'],'Alberto Adriani');
CALL insert_parroquias(ARRAY['Santa Cruz de Mora','Mesa Bolivar','Mesa de Las Palmas'],'Antonio Pinto Salinas');
CALL insert_parroquias(ARRAY['La Azulita'],'Andres Bello');
CALL insert_parroquias(ARRAY['Aricagua','San Antonio'],'Aricagua');
CALL insert_parroquias(ARRAY['Canagua','Capuri','Chacanta','El Molino','Guaimaral','Mucutuy','Mucuchachi'],'Arzobispo Chacon');
CALL insert_parroquias(ARRAY['Fernandez Peña','Matriz','Montalban','Acequias','Jaji','La Mesa','San Jose del Sur'],'Campo Elias');
CALL insert_parroquias(ARRAY['Tucani','Florencio Ramirez'],'Caracciolo Parra Olmedo');
CALL insert_parroquias(ARRAY['Santo Domingo','Las Piedras'],'Cardenal Quintero');
CALL insert_parroquias(ARRAY['Guaraque','Mesa Quintero','Rio Negro'],'Guaraque');
CALL insert_parroquias(ARRAY['Arapuey','Palmira'],'Julio Cesar Salas');
CALL insert_parroquias(ARRAY['San Cristobal de Torondoy','Torondoy'],'Justo Briceño');
CALL insert_parroquias(ARRAY['Antonio Spinetti Dini','Arias','Caracciolo Parra Perez','Domingo Peña', 'Gonzalo Picon Febres','Jacinto Plaza','Juan Rodriguez Suarez','Lasso de la Vega','Mariano Picon Salas','Milla','Osuna Rodriguez','Sagrario','El Morro','Los Nevados'],'Libertador');
CALL insert_parroquias(ARRAY['Andres Eloy Blanco','La Venta','Piñango','Timotes'],'Miranda');
CALL insert_parroquias(ARRAY['Eloy Paredes','San Rafael de Alcazar','Santa Elena de Arenales'],'Obispo Ramos de Lora');
CALL insert_parroquias(ARRAY['Santa Maria de Caparo'],'Padre Noguera');
CALL insert_parroquias(ARRAY['Pueblo Llano'],'Pueblo Llano');
CALL insert_parroquias(ARRAY['Cacute','La Toma','Mucuchies','Mucuruba','San Rafael'],'Rangel');
CALL insert_parroquias(ARRAY['Geronimo Maldonado','Bailadores'],'Rivas Davila');
CALL insert_parroquias(ARRAY['Tabay'],'Santos Marquina');
CALL insert_parroquias(ARRAY['Chiguara','Estanques','Lagunillas','La Trampa','Pueblo Nuevo del Sur','San Juan'],'Sucre');
CALL insert_parroquias(ARRAY['El Amparo','El Llano','San Francisco','Tovar'],'Tovar');
CALL insert_parroquias(ARRAY['Independencia','Maria de la Concepcion Palacios Blanco','Nueva Bolivia','Santa Apolonia'],'Tulio Febres Cordero');
CALL insert_parroquias(ARRAY['Caño El Tigre','Zea'],'Zea');

-- Miranda
CALL insert_municipios(ARRAY['Acevedo','Andres Bello','Baruta','Brion','Buroz','Carrizal','Chacao','Cristobal Rojas','El Hatillo','Guaicaipuro','Independencia','Lander','Los Salias','Paez','Paz Castillo','Pedro Gual','Plaza','Simon Bolivar','Sucre','Urdaneta','Zamora'],'Miranda');
CALL insert_parroquias(ARRAY['Aragüita','Arevalo Gonzalez','Capaya','Caucagua','Panaquire','Ribas','El Cafe','Marizapa','Yaguapa'],'Acevedo');
CALL insert_parroquias(ARRAY['Cumbo','San Jose de Barlovento'],'Andres Bello');
CALL insert_parroquias(ARRAY['El Cafetal','Las Minas','Nuestra Señora del Rosario'],'Baruta');
CALL insert_parroquias(ARRAY['Higuerote','Curiepe','Tacarigua de Brion','Chirimena','Birongo'],'Brion');
CALL insert_parroquias(ARRAY['Mamporal'],'Buroz');
CALL insert_parroquias(ARRAY['Carrizal'],'Carrizal');
CALL insert_parroquias(ARRAY['Chacao'],'Chacao');
CALL insert_parroquias(ARRAY['Charallave','Las Brisas'],'Cristobal Rojas');
CALL insert_parroquias(ARRAY['Santa Rosalia de Palermo de El Hatillo'],'El Hatillo');
CALL insert_parroquias(ARRAY['Altagracia de la Montaña','Cecilio Acosta','Los Teques','El Jarillo','San Pedro','Tacata','Paracotos'],'Guaicaipuro');
CALL insert_parroquias(ARRAY['el Cartanal','Santa Teresa del Tuy'],'Independencia');
CALL insert_parroquias(ARRAY['La Democracia','Ocumare del Tuy','Santa Barbara','La Mata','La Cabrera'],'Lander');
CALL insert_parroquias(ARRAY['San Antonio de los Altos'],'Los Salias');
CALL insert_parroquias(ARRAY['Rio Chico','El Guapo','Tacarigua de la Laguna','Paparo','San Fernando del Guapo'],'Paez');
CALL insert_parroquias(ARRAY['Santa Lucia del Tuy','Santa Rita','Siquire','Soapire'],'Paz Castillo');
CALL insert_parroquias(ARRAY['Cupira','Machurucuto','Guarabe'],'Pedro Gual');
CALL insert_parroquias(ARRAY['Guarenas'],'Plaza');
CALL insert_parroquias(ARRAY['San Antonio de Yare','San Francisco de Yare'],'Simon Bolivar');
CALL insert_parroquias(ARRAY['Cua','Nueva Cua'],'Urdaneta');
CALL insert_parroquias(ARRAY['Leoncio Martinez','Caucagüita','Filas de Mariche','La Dolorita','Petare'],'Sucre');
CALL insert_parroquias(ARRAY['Guatire','Araira'],'Zamora');

-- Monagas
CALL insert_municipios(ARRAY['Acosta','Aguasay','Bolivar','Caripe','Cedeño','Ezequiel Zamora','Libertador','Maturin','Piar','Punceres','Santa Barbara','Sotillo','Uracoa'],'Monagas');
CALL insert_parroquias(ARRAY['San Antonio de Maturin','San Francisco de Maturin'],'Acosta');
CALL insert_parroquias(ARRAY['Aguasay'],'Aguasay');
CALL insert_parroquias(ARRAY['Caripito'],'Bolivar');
CALL insert_parroquias(ARRAY['El Guacharo','La Guanota','Sabana de Piedra','San Agustin','Teresen','Caripe'],'Caripe');
CALL insert_parroquias(ARRAY['Areo','Capital Cedeño','San Felix de Cantalicio','Viento Fresco'],'Cedeño');
CALL insert_parroquias(ARRAY['El Tejero','Punta de Mata'],'Ezequiel Zamora');
CALL insert_parroquias(ARRAY['Chaguaramas','Las Alhuacas','Tabasca','Temblador'],'Libertador');
CALL insert_parroquias(ARRAY['Alto de los Godos','Boqueron','Las Cocuizas','La Cruz','San Simon','El Corozo','El Furrial','Jusepin','La Pica','San Vicente'],'Maturin');
CALL insert_parroquias(ARRAY['Aparicio','Aragua de Maturin','Chaguaramal','El Pinto','Guanaguana','La Toscana','Taguaya'],'Piar');
CALL insert_parroquias(ARRAY['Cachipo','Quiriquire'],'Punceres');
CALL insert_parroquias(ARRAY['Santa Barbara','Moron'],'Santa Barbara');
CALL insert_parroquias(ARRAY['Barrancas','Los Barrancos de Fajardo'],'Sotillo');
CALL insert_parroquias(ARRAY['Uracoa'],'Uracoa');

-- Nueva Esparta
CALL insert_municipios(ARRAY['Antolin del Campo','Arismendi','Diaz','Garcia','Gomez','Maneiro','Marcano','Mariño','Macanao','Tubores','Villalba'],'Nueva Esparta');
CALL insert_parroquias(ARRAY['Antolin del Campo'],'Antolin del Campo');
CALL insert_parroquias(ARRAY['Arismendi'],'Arismendi');
CALL insert_parroquias(ARRAY['San Juan Bautista','Zabala'],'Diaz');
CALL insert_parroquias(ARRAY['Garcia','Francisco Fajardo'],'Garcia');
CALL insert_parroquias(ARRAY['Bolivar','Guevara','Matasiete','Santa Ana','Sucre'],'Gomez');
CALL insert_parroquias(ARRAY['Aguirre','Maneiro'],'Maneiro');
CALL insert_parroquias(ARRAY['Adrian','Juan Griego'],'Marcano');
CALL insert_parroquias(ARRAY['Mariño'],'Mariño');
CALL insert_parroquias(ARRAY['San Francisco de Macanao','Boca de Rio'],'Macanao');
CALL insert_parroquias(ARRAY['Tubores','Los Barales'],'Tubores');
CALL insert_parroquias(ARRAY['Vicente Fuentes','Villalba'],'Villalba');

-- Portuguesa
CALL insert_municipios(ARRAY['Araure','Esteller','Guanare','Guanarito','Ospino','Paez','Sucre','Turen','Monseñor Jose V. de Unda','Agua Blanca','Papelon','San Genaro de Boconoito','San Rafael de Onoto','Santa Rosalia'],'Portuguesa');
CALL insert_parroquias(ARRAY['Araure','Rio Acarigua'],'Araure');
CALL insert_parroquias(ARRAY['Agua Blanca'],'Agua Blanca');
CALL insert_parroquias(ARRAY['Piritu','Uveral'],'Esteller');
CALL insert_parroquias(ARRAY['Cordova','Guanare','San Jose de la Montaña','San Juan de Guanaguanare','Virgen de Coromoto'],'Guanare');
CALL insert_parroquias(ARRAY['Guanarito','Trinidad de la Capilla','Divina Pastora'],'Guanarito');
CALL insert_parroquias(ARRAY['Chabasquen','Peña Blanca'],'Monseñor Jose V. de Unda');
CALL insert_parroquias(ARRAY['Aparicion','La Estacion','Ospino'],'Ospino');
CALL insert_parroquias(ARRAY['Acarigua','Payara','Pimpinela','Ramon Peraza'],'Paez');
CALL insert_parroquias(ARRAY['Caño Delgadito','Papelon'],'Papelon');
CALL insert_parroquias(ARRAY['Antolin Tovar Aquino','Boconoito'],'San Genaro de Boconoito');
CALL insert_parroquias(ARRAY['Santa Fe','San Rafael de Onoto','Thelmo Morles'],'San Rafael de Onoto');
CALL insert_parroquias(ARRAY['Florida','El Playon'],'Santa Rosalia');
CALL insert_parroquias(ARRAY['Biscucuy','Concepcion','San Rafael de Palo Alzado.','San Jose de Saguaz','Uvencio Antonio Velasquez.','Villa Rosa.'],'Sucre');
CALL insert_parroquias(ARRAY['Villa Bruzual','Canelones','Santa Cruz','San Isidro Labrador la colonia'],'Turen');

-- Sucre
CALL insert_municipios(ARRAY['Andres Eloy Blanco','Andres Mata','Arismendi','Benitez','Bermudez','Bolivar','Cajigal','Cruz Salmeron Acosta','Libertador','Mariño','Mejia','Montes','Ribero','Sucre','Valdez'],'Sucre');
CALL insert_parroquias(ARRAY['Mariño','Romulo Gallegos'],'Andres Eloy Blanco');
CALL insert_parroquias(ARRAY['San Jose de Areocuar','Tavera Acosta'],'Andres Mata');
CALL insert_parroquias(ARRAY['Rio Caribe','Antonio Jose de Sucre','El Morro de Puerto Santo','Puerto Santo','San Juan de las Galdonas'],'Arismendi');
CALL insert_parroquias(ARRAY['El Pilar','El Rincon','General Francisco Antonio Vazquez','Guaraunos','Tunapuicito','Union'],'Benitez');
CALL insert_parroquias(ARRAY['Santa Catalina','Santa Rosa','Santa Teresa','Bolivar','Maracapana'],'Bermudez');
CALL insert_parroquias(ARRAY['Marigüitar'],'Bolivar');
CALL insert_parroquias(ARRAY['Libertad','El Paujil','Yaguaraparo'],'Cajigal');
CALL insert_parroquias(ARRAY['Araya','Chacopata','Manicuare'],'Cruz Salmeron Acosta');
CALL insert_parroquias(ARRAY['Tunapuy','Campo Elias'],'Libertador');
CALL insert_parroquias(ARRAY['Irapa','Campo Claro','Marabal','San Antonio de Irapa','Soro'],'Mariño');
CALL insert_parroquias(ARRAY['San Antonio del Golfo'],'Mejia');
CALL insert_parroquias(ARRAY['Cumanacoa','Arenas','Aricagua','Cocollar','San Fernando','San Lorenzo'],'Montes');
CALL insert_parroquias(ARRAY['Cariaco','Catuaro','Rendon','Santa Cruz','Santa Maria'],'Ribero');
CALL insert_parroquias(ARRAY['Altagracia Cumana','Santa Ines Cumana','Valentin Valiente Cumana','Ayacucho Cumana','San Juan','Raul Leoni','Gran Mariscal'],'Sucre');
CALL insert_parroquias(ARRAY['Cristobal Colon','Bideau','Punta de Piedras','Güiria'],'Valdez');

-- Tachira
CALL insert_municipios(ARRAY['Andres Bello','Antonio Romulo Acosta','Ayacucho','Bolivar','Cardenas','Cordoba','Fernandez Feo','Francisco de Miranda','Garcia de Hevia','Guasimos','Independencia','Jauregui','Jose Maria Vargas','Junin','Libertad','Libertador','Lobatera','Michelena','Panamericano','Pedro Maria Ureña','Rafael Urdaneta','Samuel Dario Maldonado','San Cristobal','San Judas Tadeo','Seboruco','Simon Rodriguez','Tariba','Torbes','Uribante'],'Tachira');
CALL insert_parroquias(ARRAY['Cordero'],'Andres Bello');
CALL insert_parroquias(ARRAY['Virgen del Carmen'],'Antonio Romulo Acosta');
CALL insert_parroquias(ARRAY['Rivas Berti','San Juan de Colon','San Pedro del Rio'],'Ayacucho');
CALL insert_parroquias(ARRAY['Isaias Medina Angarita','Juan Vicente Gomez','Palotal','San Antonio del Tachira'],'Bolivar');
CALL insert_parroquias(ARRAY['Amenodoro Rangel Lamus','La Florida','Tariba'],'Cardenas');
CALL insert_parroquias(ARRAY['Santa Ana del Tachira'],'Cordoba');
CALL insert_parroquias(ARRAY['Alberto Adriani','San Rafael del Piñal','Santo Domingo'],'Fernandez Feo');
CALL insert_parroquias(ARRAY['San Jose de Bolivar'],'Francisco de Miranda');
CALL insert_parroquias(ARRAY['Boca de Grita','Jose Antonio Paez','La Fria'],'Garcia de Hevia');
CALL insert_parroquias(ARRAY['Palmira'],'Guasimos');
CALL insert_parroquias(ARRAY['Capacho Nuevo','Juan German Roscio','Roman Cardenas'],'Independencia');
CALL insert_parroquias(ARRAY['Emilio Constantino Guerrero','La Grita','Monseñor Miguel Antonio Salas'],'Jauregui');
CALL insert_parroquias(ARRAY['El Cobre'],'Jose Maria Vargas');
CALL insert_parroquias(ARRAY['Bramon','La Petrolea','Quinimari','Rubio'],'Junin');
CALL insert_parroquias(ARRAY['Capacho Viejo','Cipriano Castro','Manuel Felipe Rugeles'],'Libertad');
CALL insert_parroquias(ARRAY['Abejales','Doradas','Emeterio Ochoa','San Joaquin de Navay'],'Libertador');
CALL insert_parroquias(ARRAY['Lobatera','Constitucion'],'Lobatera');
CALL insert_parroquias(ARRAY['Michelena'],'Michelena');
CALL insert_parroquias(ARRAY['San Pablo','La Palmita'],'Panamericano');
CALL insert_parroquias(ARRAY['Ureña','Nueva Arcadia'],'Pedro Maria Ureña');
CALL insert_parroquias(ARRAY['Delicias'],'Rafael Urdaneta');
CALL insert_parroquias(ARRAY['Bocono','Hernandez','La Tendida'],'Samuel Dario Maldonado');
CALL insert_parroquias(ARRAY['Francisco Romero Lobo','La Concordia','Pedro Maria Morantes','San Juan Bautista','San Sebastian'],'San Cristobal');
CALL insert_parroquias(ARRAY['San Judas Tadeo'],'San Judas Tadeo');
CALL insert_parroquias(ARRAY['Seboruco'],'Seboruco');
CALL insert_parroquias(ARRAY['San Simon'],'Simon Rodriguez');
CALL insert_parroquias(ARRAY['Eleazar Lopez Contreras','Capital Sucre','San Pablo'],'Sucre');
CALL insert_parroquias(ARRAY['San Josecito'],'Torbes');
CALL insert_parroquias(ARRAY['Cardenas','Juan Pablo Peñaloza','Potosi','Pregonero'],'Uribante');

-- Trujillo
CALL insert_municipios(ARRAY['Andres Bello','Bocono','Bolivar','Candelaria','Carache','Escuque','Jose Felipe Marquez Cañizales','Juan Vicente Campo Elias','La Ceiba','Miranda','Monte Carmelo','Motatan','Pampan','Pampanito','Rafael Rangel','San Rafael de Carvajal','Sucre','Trujillo','Urdaneta','Valera'],'Trujillo');
CALL insert_parroquias(ARRAY['Santa Isabel','Araguaney','El Jaguito','La Esperanza'],'Andres Bello');
CALL insert_parroquias(ARRAY['Bocono','Ayacucho','Burbusay','El Carmen','General Ribas','Guaramacal','Monseñor Jauregui','Mosquey','Rafael Rangel','San Jose','San Miguel','Vega de Guaramacal'],'Bocono');
CALL insert_parroquias(ARRAY['Sabana Grande','Cheregüe','Granados'],'Bolivar');
CALL insert_parroquias(ARRAY['Chejende','Arnoldo Gabaldon','Bolivia','Carrillo','Cegarra','Manuel Salvador Ulloa','San Jose'],'Candelaria');
CALL insert_parroquias(ARRAY['Carache','Cuicas','La Concepcion','Panamericana','Santa Cruz'],'Carache');
CALL insert_parroquias(ARRAY['Escuque','La Union','Sabana Libre','Santa Rita'],'Escuque');
CALL insert_parroquias(ARRAY['El Socorro','Antonio Jose de Sucre','Los Caprichos'],'Jose Felipe Marquez Cañizales');
CALL insert_parroquias(ARRAY['Campo Elias','Arnoldo Gabaldon'],'Juan Vicente Campo Elias');
CALL insert_parroquias(ARRAY['Santa Apolonia','El Progreso','La Ceiba','Tres de Febrero'],'La Ceiba');
CALL insert_parroquias(ARRAY['El Dividive','Agua Caliente','Agua Santa','El Cenizo','Valerita'],'Miranda');
CALL insert_parroquias(ARRAY['Monte Carmelo','Buena Vista','Santa Maria del Horcon'],'Monte Carmelo');
CALL insert_parroquias(ARRAY['Motatan','El Baño','Jalisco'],'Motatan');
CALL insert_parroquias(ARRAY['Pampan','Flor de Patria','La Paz','Santa Ana'],'Pampan');
CALL insert_parroquias(ARRAY['Pampanito','La Concepcion','Pampanito II'],'Pampanito');
CALL insert_parroquias(ARRAY['Betijoque','Jose Gregorio Hernandez','La Pueblita','Los Cedros'],'Rafael Rangel');
CALL insert_parroquias(ARRAY['Carvajal','Antonio Nicolas Briceño','Campo Alegre','Jose Leonardo Suarez'],'San Rafael de Carvajal');
CALL insert_parroquias(ARRAY['Sabana de Mendoza','El Paraiso','Junin','Valmore Rodriguez'],'Sucre');
CALL insert_parroquias(ARRAY['Matriz','Andres Linares','Chiquinquira','Cristobal Mendoza','Cruz Carrillo','Monseñor Carrillo','Tres Esquinas'],'Trujillo');
CALL insert_parroquias(ARRAY['La Quebrada','Cabimbu','Jajo','La Mesa','Santiago','Tuñame'],'Urdaneta');
CALL insert_parroquias(ARRAY['Mercedes Diaz','Juan Ignacio Montilla','La Beatriz','La Puerta','Mendoza del Valle de Momboy','San Luis'],'Valera');

-- Yaracuy
CALL insert_municipios(ARRAY['Aristides Bastidas','Bolivar','Bruzual','Cocorote','Independencia','Jose Antonio Paez','La Trinidad','Manuel Monge','Nirgua','Peña','San Felipe','Sucre','Urachiche','Veroes'],'Yaracuy');
CALL insert_parroquias(ARRAY['Aristides Bastidas'],'Aristides Bastidas');
CALL insert_parroquias(ARRAY['Bolivar'],'Bolivar');
CALL insert_parroquias(ARRAY['Chivacoa','Campo Elias'],'Bruzual');
CALL insert_parroquias(ARRAY['Cocorote'],'Cocorote');
CALL insert_parroquias(ARRAY['Independencia'],'Independencia');
CALL insert_parroquias(ARRAY['Jose Antonio Paez'],'Jose Antonio Paez');
CALL insert_parroquias(ARRAY['La Trinidad'],'La Trinidad');
CALL insert_parroquias(ARRAY['Manuel Monge'],'Manuel Monge');
CALL insert_parroquias(ARRAY['Salom','Temerla','Nirgua','Cogollos'],'Nirgua');
CALL insert_parroquias(ARRAY['San Andres','Yaritagua'],'Peña');
CALL insert_parroquias(ARRAY['San Javier','Albarico','San Felipe'],'San Felipe');
CALL insert_parroquias(ARRAY['Sucre'],'Sucre');
CALL insert_parroquias(ARRAY['Urachiche'],'Urachiche');
CALL insert_parroquias(ARRAY['El Guayabo','Farriar'],'Veroes');

-- Zulia
CALL insert_municipios(ARRAY['Almirante Padilla','Baralt','Cabimas','Catatumbo','Colon','Francisco Javier Pulgar','Guajira','Jesus Enrique Lossada','Jesus Maria Semprun','La Cañada de Urdaneta','Lagunillas','Machiques de Perija','Mara','Maracaibo','Miranda','Rosario de Perija','San Francisco','Santa Rita','Simon Bolivar','Sucre','Valmore Rodriguez'],'Zulia');
CALL insert_parroquias(ARRAY['Isla de Toas','Monagas'],'Almirante Padilla');
CALL insert_parroquias(ARRAY['San Timoteo','General Urdaneta','Libertador','Marcelino Briceño','Pueblo Nuevo','Manuel Guanipa Matos'],'Baralt');
CALL insert_parroquias(ARRAY['Ambrosio','Aristides Calvani','Carmen Herrera','German Rios Linares','Jorge Hernandez','La Rosa','Punta Gorda','Romulo Betancourt','San Benito'],'Cabimas');
CALL insert_parroquias(ARRAY['Encontrados','Udon Perez'],'Catatumbo');
CALL insert_parroquias(ARRAY['San Carlos del Zulia','Moralito','Santa Barbara','Santa Cruz del Zulia','Urribarri'],'Colon');
CALL insert_parroquias(ARRAY['Simon Rodriguez','Agustin Codazzi','Carlos Quevedo','Francisco Javier Pulgar'],'Francisco Javier Pulgar');
CALL insert_parroquias(ARRAY['Sinamaica','Alta Guajira','Elias Sanchez Rubio','Guajira'],'Guajira');
CALL insert_parroquias(ARRAY['La Concepcion','San Jose','Mariano Parra Leon','Jose Ramon Yepez'],'Jesus Enrique Lossada');
CALL insert_parroquias(ARRAY['Jesus Maria Semprun','Bari'],'Jesus Maria Semprun');
CALL insert_parroquias(ARRAY['Concepcion','Andres Bello','Chiquinquira','El Carmelo','Potreritos'],'La Cañada de Urdaneta');
CALL insert_parroquias(ARRAY['Alonso de Ojeda','Libertad','Eleazar Lopez Contreras','Campo Lara','Venezuela','El Danto'],'Lagunillas');
CALL insert_parroquias(ARRAY['Libertad','Bartolome de las Casas','Rio Negro','San Jose de Perija'],'Machiques de Perija');
CALL insert_parroquias(ARRAY['San Rafael','La Sierrita','Las Parcelas','Luis De Vicente','Monseñor Marcos Sergio Godoy','Ricaurte','Tamare'],'Mara');
CALL insert_parroquias(ARRAY['Antonio Borjas Romero','Bolivar','Cacique Mara','Carracciolo Parra Perez','Cecilio Acosta','Chinquinquira','Coquivacoa','Cristo de Aranza','Francisco Eugenio Bustamante','Idelfonzo Vasquez','Juana de avila','Luis Hurtado Higuera','Manuel Dagnino','Olegario Villalobos','Raul Leoni','San Isidro','Santa Lucia','Venancio Pulgar'],'Maracaibo');
CALL insert_parroquias(ARRAY['Altagracia','Ana Maria Campos','Faria','San Antonio','San Jose'],'Miranda');
CALL insert_parroquias(ARRAY['El Rosario','Donaldo Garcia','Sixto Zambrano'],'Rosario de Perija');
CALL insert_parroquias(ARRAY['San Francisco','El Bajo','Domitila Flores','Francisco Ochoa','Los Cortijos','Marcial Hernandez','Jose Domingo Rus'],'San Francisco');
CALL insert_parroquias(ARRAY['Santa Rita','El Mene','Jose Cenobio Urribarri','Pedro Lucas Urribarri'],'Santa Rita');
CALL insert_parroquias(ARRAY['Manuel Manrique','Rafael Maria Baralt','Rafael Urdaneta'],'Simon Bolivar');
CALL insert_parroquias(ARRAY['Bobures','El Batey','Gibraltar','Heras','Monseñor Arturo alvarez','Romulo Gallegos'],'Sucre');
CALL insert_parroquias(ARRAY['Rafael Urdaneta','La Victoria','Raul Cuenca'],'Valmore Rodriguez');


-- ▗▄▄▖ ▗▄▄▄▖ ▗▄▄▖▗▄▄▄▖▗▄▄▄▖▗▄▖ 
-- ▐▌ ▐▌▐▌   ▐▌   ▐▌     █ ▐▌ ▐▌
-- ▐▛▀▚▖▐▛▀▀▘▐▌   ▐▛▀▀▘  █ ▐▛▀▜▌
-- ▐▌ ▐▌▐▙▄▄▖▝▚▄▄▖▐▙▄▄▖  █ ▐▌ ▐▌

INSERT INTO RECETA (nombre, descripcion) VALUES
('Receta Clásica de Pale Ale', 'Descripción de la elaboración de una Pale Ale balanceada y aromática.'),
('Receta Estándar de Lager', 'Pasos para preparar una Lager limpia, refrescante y de baja fermentación.'),
('Receta de IPA con Dry Hopping', 'Detalles para una Indian Pale Ale con alto lúpulo y aroma cítrico.'),
('Receta de Stout Oatmeal', 'Elaboración de una Stout oscura con cuerpo cremoso y notas a café y chocolate.'),
('Receta de Porter Robusta', 'Proceso para una Porter con carácter tostado y final seco.'),
('Receta de Cerveza de Trigo Alemana', 'Instrucciones para una Hefeweizen con perfiles de banana y clavo.'),
('Receta de Pilsner Auténtica', 'Guía para una Pilsner crujiente y amarga, al estilo tradicional checo.'),
('Receta de Sour de Frutas Rojas', 'Descripción de una cerveza ácida con adición de frutos rojos para un sabor vibrante.'),
('Receta de Saison Especiada', 'Elaboración de una Saison rústica con toques especiados y frutales.'),
('Receta de Barleywine Añejada', 'Proceso para una Barleywine de alta graduación, ideal para madurar en botella.'),
('Receta de Pale Ale Ligera', 'Una versión más ligera de la Pale Ale, ideal para el día a día.'),
('Receta de Brown Ale Tradicional', 'Receta clásica de Brown Ale con maltas tostadas.'),
('Receta de Red Ale Maltosa', 'Red Ale con énfasis en el dulzor de la malta.'),
('Receta de Amber Ale Equilibrada', 'Amber Ale con un equilibrio perfecto entre malta y lúpulo.'),
('Receta de Pumpkin Ale de Otoño', 'Cerveza de calabaza con especias de temporada.'),
('Receta de Golden Ale Brillante', 'Golden Ale de color dorado y sabor suave.'),
('Receta de Blond Ale Refrescante', 'Blond Ale ligera y muy fácil de beber.'),
('Receta de ESB Amarga Balanceada', 'Extra Special Bitter con amargor distintivo y final persistente.'),
('Receta de Hefeweizen Clásica', 'Hefeweizen con notas a banana y clavo, sin filtrar.'),
('Receta de English Bitter Suave', 'Bitter inglesa de baja graduación y amargor moderado.'),
('Receta de American Amber Ale Aromática', 'Amber Ale americana con lúpulos cítricos y florales.'),
('Receta de American Pale Ale Refrescante', 'Pale Ale americana con perfil de lúpulo intenso.'),
('Receta de American IPA Intensa', 'IPA americana con un punch de amargor y aroma a frutas tropicales.'),
('Receta de Cerveza de Abadía Fuerte', 'Cerveza de abadía compleja y de alta graduación.'),
('Receta de Cerveza Trapense Auténtica', 'Receta de cerveza trapense, elaborada en monasterios.'),
('Receta de Ámbar Belga Afrutada', 'Cerveza ámbar belga con notas a caramelo y frutas.'),
('Receta de Flamenca Acida', 'Cerveza flamenca con un perfil ácido y afrutado.'),
('Receta de Belgian Barleywine Robusta', 'Barleywine belga, fuerte y con carácter afrutado.'),
('Receta de Trappist Quadrupel Oscura', 'Quadrupel trapense oscura, compleja y de alta graduación.'),
('Receta de Cerveza Navideña Belga', 'Cerveza belga especiada, ideal para las fiestas.'),
('Receta de Belgian Stout Compleja', 'Stout belga con notas a café, chocolate y frutas oscuras.'),
('Receta de Belgian IPA Doble', 'IPA belga con doble dry-hopping y levadura belga.'),
('Receta de Blond Trappist Table Beer Ligera', 'Cerveza de mesa trapense, ligera y refrescante.'),
('Receta de Blond Artesanal Fresca', 'Cerveza artesanal rubia, fresca y fácil de beber.'),
('Receta de Amber Artesanal Balanceada', 'Cerveza artesanal ámbar con un buen equilibrio.'),
('Receta de Brown Artesanal Maltosa', 'Cerveza artesanal marrón con un rico perfil de malta.'),
('Receta de Flanders Red/Brown con Frutas', 'Cerveza ácida de Flandes con adición de frutas.'),
('Receta de Pilsner Clásica', 'Pilsner tradicional con un final limpio y seco.'),
('Receta de Spezial Lager', 'Lager Spezial, de cuerpo medio y sabor suave.'),
('Receta de Dortmunster Fuerte', 'Lager Dortmunster, robusta y con buen cuerpo.'),
('Receta de Schwarzbier Oscura', 'Schwarzbier o cerveza negra, ligera y con notas a café.'),
('Receta de Vienna Lager Maltosa', 'Lager Vienna con un perfil de malta tostada.'),
('Receta de Bock Maltosa', 'Cerveza Bock, fuerte y con un dulzor maltoso.'),
('Receta de Weisse Beer', 'Receta de cerveza de trigo estilo Weisse.'),
('Receta de Weizen-Weissbier', 'Receta de Weissbier de trigo.'),
('Receta de Imperial Stout Potente', 'Imperial Stout con alta graduación y sabor intenso.'),
('Receta de Chocolate Stout Deliciosa', 'Stout con adición de cacao para un sabor a chocolate.'),
('Receta de Coffee Stout Vibrante', 'Stout con café, ideal para los amantes de ambas bebidas.'),
('Receta de Milk Stout Cremosa', 'Stout con lactosa para un acabado cremoso y dulce.'),
('Receta de Sweet Stout Suave', 'Stout dulce, ideal para postres o como postre.'),
('Receta de Eisbock Congelada', 'Bock concentrada por congelación, muy fuerte.'),
('Receta de Strong Saison', 'Saison fuerte y especiada.'),
('Receta de Dark Saison', 'Saison oscura con notas tostadas.'),
('Receta de Blonde Ale', 'Blonde Ale, ligera y dorada.');

INSERT INTO INSTRUCCION (descripcion) VALUES
('Moler la malta hasta obtener una molienda gruesa.'),
('Realizar la maceración a 65°C durante 60 minutos.'),
('Lavar el grano con agua caliente a 78°C.'),
('Hervir el mosto durante 60 minutos, añadiendo lúpulos en diferentes etapas.'),
('Enfriar el mosto rápidamente a temperatura de fermentación.'),
('Airear el mosto antes de inocular la levadura.'),
('Fermentar a 18°C durante 7 días.'),
('Realizar un dry-hopping durante 3 días si se desea.'),
('Embotellar o embasurar la cerveza con azúcar para carbonatación.'),
('Dejar madurar la cerveza en botella o barril por al menos 2 semanas.');

INSERT INTO RECE_INST (fk_instruccion, fk_receta, orden) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1),
(6, 6, 1),
(7, 7, 1),
(8, 8, 1),
(9, 9, 1),
(10, 10, 1),
(1, 11, 1),
(2, 12, 1),
(3, 13, 1),
(4, 14, 1),
(5, 15, 1),
(6, 16, 1),
(7, 17, 1),
(8, 18, 1),
(9, 19, 1),
(10, 20, 1),
(1, 21, 1),
(2, 22, 1),
(3, 23, 1),
(4, 24, 1),
(5, 25, 1),
(6, 26, 1),
(7, 27, 1),
(8, 28, 1),
(9, 29, 1),
(10, 30, 1),
(1, 31, 1),
(2, 32, 1),
(3, 33, 1),
(4, 34, 1),
(5, 35, 1),
(6, 36, 1),
(7, 37, 1),
(8, 38, 1),
(9, 39, 1),
(10, 40, 1),
(1, 41, 1),
(2, 42, 1),
(3, 43, 1),
(4, 44, 1),
(5, 45, 1),
(6, 46, 1),
(7, 47, 1),
(8, 48, 1),
(9, 49, 1),
(10, 50, 1),
(1, 51, 1),
(2, 52, 1),
(3, 53, 1),
(4, 54, 1),
(5, 55, 1);

-- ▗▄▄▖ ▗▄▄▖ ▗▄▄▄▖ ▗▄▄▖▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖▗▄▖  ▗▄▄▖▗▄▄▄▖ ▗▄▖ ▗▖  ▗▖
-- ▐▌ ▐▌▐▌ ▐▌▐▌   ▐▌   ▐▌   ▐▛▚▖▐▌  █ ▐▌ ▐▌▐▌     █  ▐▌ ▐▌▐▛▚▖▐▌
-- ▐▛▀▘ ▐▛▀▚▖▐▛▀▀▘ ▝▀▚▖▐▛▀▀▘▐▌ ▝▜▌  █ ▐▛▀▜▌▐▌     █  ▐▌ ▐▌▐▌ ▝▜▌
-- ▐▌   ▐▌ ▐▌▐▙▄▄▖▗▄▄▞▘▐▙▄▄▖▐▌  ▐▌  █ ▐▌ ▐▌▝▚▄▄▖▗▄█▄▖▝▚▄▞▘▐▌  ▐▌

INSERT INTO PRESENTACION (nombre, cantidad) VALUES
('Botella 330ml', 330),
('Lata 330ml', 330),
('Botella 500ml', 500),
('Botella 750ml', 750),
('Barril 20L', 20000),
('Barril 50L', 50000),
('Pack 6 Latas 330ml', 1980),
('Caja 12 Botellas 330ml', 3960),
('Vaso Degustación', 200),
('Copa Pinta', 568);

-- ▗▄▄▄  ▗▄▄▄▖ ▗▄▄▖ ▗▄▄▖▗▖ ▗▖▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖▗▄▖
-- ▐▌  █ ▐▌   ▐▌   ▐▌   ▐▌ ▐▌▐▌   ▐▛▚▖▐▌  █ ▐▌ ▐▌  
-- ▐▌  █ ▐▛▀▀▘ ▝▀▚▖▐▌   ▐▌ ▐▌▐▛▀▀▘▐▌ ▝▜▌  █ ▐▌ ▐▌ 
-- ▐▙▄▄▀ ▐▙▄▄▖▗▄▄▞▘▝▚▄▄▖▝▚▄▞▘▐▙▄▄▖▐▌  ▐▌  █ ▝▚▄▞▘

INSERT INTO DESCUENTO (porcentaje)
VALUES (10), (25), (30), (40), (50), (60), (75), (80), (90), (100);

-- ▗▄▄▄▖▗▄▄▄▖▗▄▄▄▖▗▖  ▗▖▗▄▄▄   ▗▄▖     ▗▖  ▗▖▗▄▄▄▖▗▄▄▖▗▄▄▄▖▗▖ ▗▖ ▗▄▖ ▗▖ 
--   █    █  ▐▌   ▐▛▚▖▐▌▐▌  █ ▐▌ ▐▌    ▐▌  ▐▌  █  ▐▌ ▐▌ █  ▐▌ ▐▌▐▌ ▐▌▐▌ 
--   █    █  ▐▛▀▀▘▐▌ ▝▜▌▐▌  █ ▐▛▀▜▌    ▐▌  ▐▌  █  ▐▛▀▚▖ █  ▐▌ ▐▌▐▛▀▜▌▐▌ 
--   █  ▗▄█▄▖▐▙▄▄▖▐▌  ▐▌▐▙▄▄▀ ▐▌ ▐▌     ▝▚▞▘ ▗▄█▄▖▐▌ ▐▌ █  ▝▚▄▞▘▐▌ ▐▌▐▙▄▄▖

INSERT INTO TIENDA_VIRTUAL (descripcion) VALUES
('Tienda online oficial para cervezas artesanales.'),
('Plataforma de venta de productos locales y orgánicos.'),
('Ecommerce especializado en licores importados.'),
('Tienda de regalos personalizados y cestas de cerveza.'),
('Mercado en línea para pequeños productores de cerveza.'),
('Sitio web para suscripciones mensuales de cerveza.'),
('Tienda virtual con ofertas exclusivas y eventos online.'),
('Plataforma de venta al por mayor para cervecerías.'),
('Tienda online para productos de bar y accesorios cerveceros.'),
('Portal de venta de experiencias de cata y tours cerveceros.');

--  ▗▄▄▖ ▗▄▖ ▗▄▄▖  ▗▄▖  ▗▄▄▖▗▄▄▄▖▗▄▄▄▖▗▄▄▖ ▗▄▄▄▖ ▗▄▄▖▗▄▄▄▖▗▄▄▄▖ ▗▄▄▖ ▗▄▖  
-- ▐▌   ▐▌ ▐▌▐▌ ▐▌▐▌ ▐▌▐▌     █  ▐▌   ▐▌ ▐▌  █  ▐▌     █    █  ▐▌   ▐▌ ▐▌ 
-- ▐▌   ▐▛▀▜▌▐▛▀▚▖▐▛▀▜▌▐▌     █  ▐▛▀▀▘▐▛▀▚▖  █   ▝▀▚▖  █    █  ▐▌   ▐▛▀▜▌ 
-- ▝▚▄▄▖▐▌ ▐▌▐▌ ▐▌▐▌ ▐▌▝▚▄▄▖  █  ▐▙▄▄▖▐▌ ▐▌▗▄█▄▖▗▄▄▞▘  █  ▗▄█▄▖▝▚▄▄▖▐▌ ▐▌

INSERT INTO CARACTERISTICA (nombre) 
VALUES ('Grado de alcohol'),('Color'), ('IBU'), ('Sabor'), ('Aroma'), ('Historia'), ('Espuma'), ('Apariencia'), ('Caracter'),('Impresion general');

-- ▗▖ ▗▖ ▗▄▖ ▗▄▄▖  ▗▄▖ ▗▄▄▖ ▗▄▄▄▖ ▗▄▖                        
-- ▐▌ ▐▌▐▌ ▐▌▐▌ ▐▌▐▌ ▐▌▐▌ ▐▌  █  ▐▌ ▐▌                       
-- ▐▛▀▜▌▐▌ ▐▌▐▛▀▚▖▐▛▀▜▌▐▛▀▚▖  █  ▐▌ ▐▌                       
-- ▐▌ ▐▌▝▚▄▞▘▐▌ ▐▌▐▌ ▐▌▐▌ ▐▌▗▄█▄▖▝▚▄▞▘     

INSERT INTO HORARIO (hora_entrada, hora_salida, dia_semana) VALUES
('09:00:00', '17:00:00', 'Lunes'),
('09:00:00', '17:00:00', 'Martes'),
('09:00:00', '17:00:00', 'Miercoles'),
('09:00:00', '17:00:00', 'Jueves'),
('09:00:00', '17:00:00', 'Viernes'),
('10:00:00', '14:00:00', 'Sabado'),
('11:00:00', '15:00:00', 'Domingo'),
('08:00:00', '16:00:00', 'Lunes'),
('10:00:00', '18:00:00', 'Martes'),
('12:00:00', '20:00:00', 'Miercoles');

-- ▗▄▄▖ ▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖▗▄▄▄▖▗▄▄▄▖ ▗▄▄▖▗▄▄▄▖ ▗▄▖             
-- ▐▌ ▐▌▐▌   ▐▛▚▖▐▌▐▌   ▐▌     █  ▐▌     █  ▐▌ ▐▌            
-- ▐▛▀▚▖▐▛▀▀▘▐▌ ▝▜▌▐▛▀▀▘▐▛▀▀▘  █  ▐▌     █  ▐▌ ▐▌            
-- ▐▙▄▞▘▐▙▄▄▖▐▌  ▐▌▐▙▄▄▖▐▌   ▗▄█▄▖▝▚▄▄▖▗▄█▄▖▝▚▄▞▘  

INSERT INTO BENEFICIO (nombre, descripcion) VALUES
('Seguro Médico Integral', 'Cobertura médica completa para el empleado y su familia.'),
('Bono de Alimentación', 'Tarjeta o vales para la compra de alimentos.'),
('Transporte Subsidiado', 'Ayuda económica para el transporte diario al trabajo.'),
('Gimnasio Corporativo', 'Acceso gratuito a un gimnasio dentro o cerca de la empresa.'),
('Clases de Idiomas', 'Cursos de idiomas pagados por la empresa.'),
('Guardería', 'Servicio de guardería para hijos de empleados.'),
('Plan de Pensiones', 'Contribución de la empresa a un plan de retiro.'),
('Flexibilidad Horaria', 'Posibilidad de ajustar los horarios de entrada y salida.'),
('Descuentos en Productos', 'Descuentos especiales en los productos de la empresa.'),
('Días Libres Adicionales', 'Días de vacaciones extra por buen desempeño.');

-- ▗▄▄▖ ▗▄▄▖ ▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖▗▖   ▗▄▄▄▖ ▗▄▄▖▗▄▄▄▖ ▗▄▖        
-- ▐▌ ▐▌▐▌ ▐▌  █  ▐▌  ▐▌  █  ▐▌   ▐▌   ▐▌     █  ▐▌ ▐▌       
-- ▐▛▀▘ ▐▛▀▚▖  █  ▐▌  ▐▌  █  ▐▌   ▐▛▀▀▘▐▌▝▜▌  █  ▐▌ ▐▌       
-- ▐▌   ▐▌ ▐▌▗▄█▄▖ ▝▚▞▘ ▗▄█▄▖▐▙▄▄▖▐▙▄▄▖▝▚▄▞▘▗▄█▄▖▝▚▄▞▘  

INSERT INTO PRIVILEGIO (nombre, descripcion) VALUES
('Gestionar Usuarios', 'Permite crear, editar y eliminar cuentas de usuario.'),
('Gestionar Productos', 'Permite añadir, modificar y eliminar productos del inventario.'),
('Ver Reportes Financieros', 'Acceso a informes detallados de ventas, gastos e ingresos.'),
('Procesar Pagos', 'Habilidad para autorizar y procesar transacciones de pago.'),
('Administrar Contenido Web', 'Control sobre el contenido de la página web (textos, imágenes, ofertas).'),
('Realizar Compras', 'Permite a los usuarios registrar pedidos y efectuar compras.'),
('Ver Historial de Compras', 'Acceso al historial personal de pedidos y transacciones.'),
('Actualizar Perfil', 'Permite a los usuarios modificar su información personal y preferencias.'),
('Gestionar Eventos', 'Permite crear, programar y administrar eventos y catas.'),
('Gestionar Proveedores', 'Permite añadir, editar y eliminar información de proveedores.');

-- ▗▄▄▄▖▗▖  ▗▖ ▗▄▄▖▗▄▄▖ ▗▄▄▄▖▗▄▄▄  ▗▄▄▄▖▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖▗▄▄▄▖
--   █  ▐▛▚▖▐▌▐▌   ▐▌ ▐▌▐▌   ▐▌  █   █  ▐▌   ▐▛▚▖▐▌  █  ▐▌   
--   █  ▐▌ ▝▜▌▐▌▝▜▌▐▛▀▚▖▐▛▀▀▘▐▌  █   █  ▐▛▀▀▘▐▌ ▝▜▌  █  ▐▛▀▀▘
-- ▗▄█▄▖▐▌  ▐▌▝▚▄▞▘▐▌ ▐▌▐▙▄▄▖▐▙▄▄▀ ▗▄█▄▖▐▙▄▄▖▐▌  ▐▌  █  ▐▙▄▄▖

INSERT INTO INGREDIENTE (nombre) 
VALUES ('Malta Best Malz Pale Ale'),
('Malta Best Malz Aromatic'), 
('Malta Best Malz Caramel Light '), 
('Lúpulo Columbus'), ('Lúpulo Cascade'), 
('Malta de cebada'), ('Frutas tropicales'), 
('Levadura: Danstar Bry-97'), ('Agua'), ('Azucar Blanca');



-- ▗▄▄▖  ▗▄▖ ▗▖                                                 
-- ▐▌ ▐▌▐▌ ▐▌▐▌                                                 
-- ▐▛▀▚▖▐▌ ▐▌▐▌                                                 
-- ▐▌ ▐▌▝▚▄▞▘▐▙▄▄▖ 

INSERT INTO ROL (nombre, descripcion) VALUES
('Administrador del Sistema', 'Acceso completo a la configuración del sistema, gestión de usuarios, productos y reportes.'),
('Cliente Registrado', 'Usuario con cuenta que puede realizar pedidos, ver historial de compras y gestionar su perfil.'),


-- ▗▄▄▖  ▗▄▖ ▗▖  ▗▖ ▗▄▄▖ ▗▄▖                                    
-- ▐▌ ▐▌▐▌ ▐▌▐▛▚▖▐▌▐▌   ▐▌ ▐▌                                   
-- ▐▛▀▚▖▐▛▀▜▌▐▌ ▝▜▌▐▌   ▐▌ ▐▌                                   
-- ▐▙▄▞▘▐▌ ▐▌▐▌  ▐▌▝▚▄▄▖▝▚▄▞▘

INSERT INTO BANCO (nombre) VALUES
('Banco de Venezuela'),
('Banesco'),
('Mercantil'),
('BBVA Provincial'),
('Banco Nacional de Crédito'),
('Banco Occidental de Descuento'),
('Bancaribe'),
('Banco Exterior'),
('Banco Activo'),
('Banco Plaza');

-- ▗▄▄▄▖▗▄▄▄▖▗▄▄▖  ▗▄▖     ▗▄▄▄▖▗▄▖ ▗▄▄▖    ▗▖▗▄▄▄▖▗▄▄▄▖▗▄▖     
--   █    █  ▐▌ ▐▌▐▌ ▐▌      █ ▐▌ ▐▌▐▌ ▐▌   ▐▌▐▌     █ ▐▌ ▐▌    
--   █    █  ▐▛▀▘ ▐▌ ▐▌      █ ▐▛▀▜▌▐▛▀▚▖   ▐▌▐▛▀▀▘  █ ▐▛▀▜▌    
--   █  ▗▄█▄▖▐▌   ▝▚▄▞▘      █ ▐▌ ▐▌▐▌ ▐▌▗▄▄▞▘▐▙▄▄▖  █ ▐▌ ▐▌ 

INSERT INTO TIPO_TARJETA (nombre, procesador) VALUES
('Crédito Visa', 'Visa'),
('Débito Visa', 'Visa'),
('Crédito Mastercard', 'Mastercard'),
('Débito Mastercard', 'Mastercard'),
('Crédito American Express', 'American Express'),
('Débito Maestro', 'Maestro'),
('Crédito Diners Club', 'Diners Club'),
('Tarjeta Prepago Visa', 'Visa'),
('Tarjeta Prepago Mastercard', 'Mastercard'),
('Tarjeta de Regalo', 'Interno');

-- ▗▄▄▄▖ ▗▄▄▖▗▄▄▄▖▗▄▖▗▄▄▄▖▗▖ ▗▖ ▗▄▄▖                            
-- ▐▌   ▐▌     █ ▐▌ ▐▌ █  ▐▌ ▐▌▐▌                               
-- ▐▛▀▀▘ ▝▀▚▖  █ ▐▛▀▜▌ █  ▐▌ ▐▌ ▝▀▚▖                            
-- ▐▙▄▄▖▗▄▄▞▘  █ ▐▌ ▐▌ █  ▝▚▄▞▘▗▄▄▞▘ 

INSERT INTO ESTATUS (nombre) VALUES
('Pendiente'),
('En Proceso'),
('Completado'),
('Cancelado'),
('En Espera'),
('Rechazado'),
('Enviado'),
('Entregado'),
('Devuelto'),
('Archivado');
                    
-- ▗▄▄▄▖▗▄▖  ▗▄▄▖ ▗▄▖      ▗▄▄▖ ▗▄▖ ▗▖  ▗▖▗▄▄▖ ▗▄▄▄▖ ▗▄▖        
--   █ ▐▌ ▐▌▐▌   ▐▌ ▐▌    ▐▌   ▐▌ ▐▌▐▛▚▞▜▌▐▌ ▐▌  █  ▐▌ ▐▌       
--   █ ▐▛▀▜▌ ▝▀▚▖▐▛▀▜▌    ▐▌   ▐▛▀▜▌▐▌  ▐▌▐▛▀▚▖  █  ▐▌ ▐▌       
--   █ ▐▌ ▐▌▗▄▄▞▘▐▌ ▐▌    ▝▚▄▄▖▐▌ ▐▌▐▌  ▐▌▐▙▄▞▘▗▄█▄▖▝▚▄▞▘  

INSERT INTO TASA_CAMBIO (fecha_inicio, fecha_fin, tasa_bs_dolar, tasa_bs_punto) VALUES
('2024-01-01', '2024-01-14', 36.50, 36.50),
('2024-01-15', '2024-01-31', 37.00, 37.00),
('2024-02-01', '2024-02-14', 37.25, 37.25),
('2024-02-15', '2024-02-29', 37.50, 37.50),
('2024-03-01', '2024-03-14', 38.00, 38.00),
('2024-03-15', '2024-03-31', 38.10, 38.10),
('2024-04-01', '2024-04-14', 38.30, 38.30),
('2024-04-15', '2024-04-30', 38.50, 38.50),
('2024-05-01', '2024-05-14', 38.75, 38.75),
('2024-05-15', '2024-05-31', 39.00, 39.00);

-- ▗▖   ▗▖ ▗▖ ▗▄▄▖ ▗▄▖ ▗▄▄▖     ▗▄▄▄▖▗▄▄▄▖▗▄▄▄▖▗▖  ▗▖▗▄▄▄   ▗▄▖ 
-- ▐▌   ▐▌ ▐▌▐▌   ▐▌ ▐▌▐▌ ▐▌      █    █  ▐▌   ▐▛▚▖▐▌▐▌  █ ▐▌ ▐▌
-- ▐▌   ▐▌ ▐▌▐▌▝▜▌▐▛▀▜▌▐▛▀▚▖      █    █  ▐▛▀▀▘▐▌ ▝▜▌▐▌  █ ▐▛▀▜▌
-- ▐▙▄▄▖▝▚▄▞▘▝▚▄▞▘▐▌ ▐▌▐▌ ▐▌      █  ▗▄█▄▖▐▙▄▄▖▐▌  ▐▌▐▙▄▄▀ ▐▌ ▐▌

INSERT INTO LUGAR_TIENDA (nombre, tipo, fk_lugar_tienda) VALUES
('Tienda', 'TIENDA', NULL),
('Pasillo A', 'PASILLO', 1),
('Pasillo B', 'PASILLO', 1),
('Pasillo C', 'PASILLO', 1);
('Anaquel A1', 'ANAQUEL', 2),
('Anaquel A2', 'ANAQUEL', 2), 
('Anaquel B1', 'ANAQUEL', 3), 
('Anaquel B2', 'ANAQUEL', 3), 
('Anaquel C1', 'ANAQUEL', 4), 
('Anaquel C2', 'ANAQUEL', 4);

-- ▗▖  ▗▖▗▄▄▄▖▗▄▄▄▖▗▄▖ ▗▄▄▄   ▗▄▖     ▗▄▄▖  ▗▄▖  ▗▄▄▖ ▗▄▖       
-- ▐▛▚▞▜▌▐▌     █ ▐▌ ▐▌▐▌  █ ▐▌ ▐▌    ▐▌ ▐▌▐▌ ▐▌▐▌   ▐▌ ▐▌      
-- ▐▌  ▐▌▐▛▀▀▘  █ ▐▌ ▐▌▐▌  █ ▐▌ ▐▌    ▐▛▀▘ ▐▛▀▜▌▐▌▝▜▌▐▌ ▐▌      
-- ▐▌  ▐▌▐▙▄▄▖  █ ▝▚▄▞▘▐▙▄▄▀ ▝▚▄▞▘    ▐▌   ▐▌ ▐▌▝▚▄▞▘▝▚▄▞▘ 

INSERT INTO METODO_PAGO (monto) VALUES
(1000),
(2500),
(500),
(7500),
(1200),
(3000),
(800),
(4500),
(150),
(6000);

-- ▗▄▄▄▖▗▖  ▗▖ ▗▄▄▖▗▄▄▖     ▗▄▄▖ ▗▄▄▄▖ ▗▄▄▖▗▄▄▄▖                
--   █  ▐▛▚▖▐▌▐▌   ▐▌ ▐▌    ▐▌ ▐▌▐▌   ▐▌   ▐▌                   
--   █  ▐▌ ▝▜▌▐▌▝▜▌▐▛▀▚▖    ▐▛▀▚▖▐▛▀▀▘▐▌   ▐▛▀▀▘                
-- ▗▄█▄▖▐▌  ▐▌▝▚▄▞▘▐▌ ▐▌    ▐▌ ▐▌▐▙▄▄▖▝▚▄▄▖▐▙▄▄▖ 

INSERT INTO INGR_RECE (fk_ingrediente, fk_receta, fecha_inicio) VALUES
(1, 1, '2025-01-01'),
(2, 1, '2025-01-02'),
(3, 2, '2025-01-03'),
(4, 2, '2025-01-04'),
(5, 3, '2025-01-05'),
(6, 3, '2025-01-06'),
(7, 4, '2025-01-07'),
(8, 4, '2025-01-08'),
(9, 5, '2025-01-09'),
(10, 5, '2025-01-10');


-- ▗▄▄▖  ▗▄▖ ▗▖       ▗▄▄▖ ▗▄▄▖ ▗▄▄▄▖▗▖  ▗▖ 
-- ▐▌ ▐▌▐▌ ▐▌▐▌       ▐▌ ▐▌▐▌ ▐▌  █  ▐▌  ▐▌ 
-- ▐▛▀▚▖▐▌ ▐▌▐▌       ▐▛▀▘ ▐▛▀▚▖  █  ▐▌  ▐▌ 
-- ▐▌ ▐▌▝▚▄▞▘▐▙▄▄▖    ▐▌   ▐▌ ▐▌▗▄█▄▖ ▝▚▞▘  

INSERT INTO ROL_PRIV (fk_rol, fk_privilegio) VALUES
(1, 1), 
(1, 2), 
(1, 3), 
(1, 4), 
(1, 5), 
(1, 9), 
(1, 10),
(2, 6), 
(2, 7), 
(2, 8); 


-- ▗▄▄▖ ▗▄▄▖  ▗▄▖ ▗▖  ▗▖▗▄▄▄▖▗▄▄▄▖▗▄▄▄   ▗▄▖ ▗▄▄▖  
-- ▐▌ ▐▌▐▌ ▐▌▐▌ ▐▌▐▌  ▐▌▐▌   ▐▌   ▐▌  █ ▐▌ ▐▌▐▌ ▐▌ 
-- ▐▛▀▘ ▐▛▀▚▖▐▌ ▐▌▐▌  ▐▌▐▛▀▀▘▐▛▀▀▘▐▌  █ ▐▌ ▐▌▐▛▀▚▖ 
-- ▐▌   ▐▌ ▐▌▝▚▄▞▘ ▝▚▞▘ ▐▙▄▄▖▐▙▄▄▖▐▙▄▄▀ ▝▚▄▞▘▐▌ ▐▌ 

INSERT INTO PROVEEDOR (rif, direccion, denominacion_comercial, razon_social, pagina_web, fk_lugar_1, fk_lugar_2) VALUES
('J-12345678-0', 'Calle Real, Sector El Centro, Altagracia', 'Cervecería La Capital', 'Cervezas La Capital C.A.', 'www.lacapital.com', 1, 2), 
('G-98765432-1', 'Av. Intercomunal, Urb. Las Palmas, Chacao', 'Distribuidora Miranda Premium', 'Distribuciones Miranda Premium S.A.', 'www.mirandapremium.com', 3, 4), 
('J-23456789-2', 'Zona Industrial Carabobo, Galpón 15', 'Malta Carabobo Supply', 'Suministros Malta Carabobo C.A.', 'www.maltacarabobo.com', 5, 6), 
('G-87654321-3', 'Calle Bolívar, Urb. Central, Pueblo Nuevo', 'Lúpulos Anzoátegui Export', 'Lúpulos Anzoátegui Export S.A.', NULL, 7, 8), 
('J-34567890-4', 'Av. Apure, Urb. Los Llanos, San Juan de Payara', 'Empaque Apureño', 'Empaques Apureños C.A.', 'www.empaquesapure.com', 9, 10), 
('G-76543210-5', 'Sector La Laguna, La Azulita, Mérida', 'Fábrica de Envases Andinos', 'Envases Andinos S.R.L.', NULL, 11, 12), 
('J-45678901-6', 'Centro Empresarial Paraguaná, Guzmán Guillermo', 'Fermentadores Falcón', 'Fermentadores Falcón C.A.', 'www.fermentadoresfalcon.com', 13, 14),
('G-65432109-7', 'Calle Comercio, Urb. Las Flores, Valle de la Pascua', 'Cebada Guárico Global', 'Cebada Guárico Global S.A.', 'www.cebadaguarico.com', 15, 16),
('J-56789012-8', 'Urbanización Delta, Calle 3, San Jose', 'Ingredientes Delta', 'Ingredientes Delta C.A.', NULL, 17, 18), 
('G-54321098-9', 'Zona Industrial Turmero, El Limón, Choroni', 'Levaduras Aragua Innova', 'Levaduras Aragua Innova S.A.', 'www.levadurasaragua.com', 19, 20),
('J-10000000-0', 'Calle Las Palmas, Edificio Norte, Suite 101, Caracas', 'Materias Primas C.A.', 'Materias Primas C.A.', 'http://www.materiasprimas.com', 1, 15),
('G-20000000-1', 'Avenida Los Próceres, Galpón 5, Maracaibo', 'Suministros Industriales Zulia', 'Suministros Industriales Zulia S.A.', NULL, 24, 220),
('J-30000000-2', 'Zona Industrial II, Calle A, Nave 8, Valencia', 'Equipos Cerveceros del Centro', 'Equipos Cerveceros del Centro R.L.', 'http://www.equiposcerveceros.com', 7, 45),
('G-40000000-3', 'Carretera Nacional, Km 12, Barquisimeto', 'Empaques del Oeste', 'Empaques del Oeste C.A.', NULL, 14, 100),
('J-50000000-4', 'Urbanización Ciudad Roca, Sector Este, Puerto Ordaz', 'Aditivos del Sur', 'Aditivos del Sur S.A.', 'http://www.aditivosdelsur.net', 10, 80),
('G-60000000-5', 'Avenida Libertador, Sector Las Vegas, Mérida', 'Logística Andes', 'Logística Andes C.A.', NULL, 15, 160),
('J-70000000-6', 'Calle La Marina, Dársena 3, Puerto La Cruz', 'Granos Marítimos', 'Granos Marítimos S.R.L.', 'http://www.granosmaritimos.com', 2, 20),
('G-80000000-7', 'Via Principal, Pueblo Arriba, San Felipe', 'Botellas del Valle', 'Botellas del Valle C.A.', NULL, 23, 210),
('J-90000000-8', 'Sector El Sol, Galpón 4, Coro', 'Insumos Industriales Falcón', 'Insumos Industriales Falcón S.A.', 'http://www.insumosfalcon.com', 9, 70),
('G-99999999-9', 'Avenida Los Samanes, Local 2, Ciudad Bolívar', 'Esencias del Sur', 'Esencias del Sur C.A.', NULL, 10, 80);

--  ▗▄▄▖▗▖   ▗▄▄▄▖▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖▗▄▄▄▖  
-- ▐▌   ▐▌     █  ▐▌   ▐▛▚▖▐▌  █  ▐▌     
-- ▐▌   ▐▌     █  ▐▛▀▀▘▐▌ ▝▜▌  █  ▐▛▀▀▘ 
-- ▝▚▄▄▖▐▙▄▄▖▗▄█▄▖▐▙▄▄▖▐▌  ▐▌  █  ▐▙▄▄▖  

INSERT INTO CLIENTE (rif, direccion, numero_registro, fk_lugar_1, fk_lugar_2) VALUES
('V-10203040-5', 'Av. Principal, Res. Los Apamates, Apto 5B, Caracas', 1001, 1, 15),
('E-20304050-6', 'Calle La Paz, Casa 8, Maracaibo', 1002, 24, 220),
('J-30405060-7', 'Urb. Las Mercedes, Torre C, Piso 10, Valencia', 1003, 7, 45),
('G-40506070-8', 'Carrera 20, Edif. Blanco, Local 3, Barquisimeto', 1004, 14, 100),
('V-50607080-9', 'Zona Industrial, Galpón 10, Puerto Ordaz', 1005, 10, 80),
('E-60708090-0', 'Calle Real, Quinta Los Girasoles, Mérida', 1006, 15, 160),
('J-70809010-1', 'Av. Atlántico, CC. El Faro, Local 20, Porlamar', 1800, 18, 175),
('G-80901020-2', 'Sector El Carmen, Calle 5, Maturín', 1008, 17, 170),
('V-90102030-3', 'Plaza Bolívar, Edif. Azul, Oficina 7, San Felipe', 1009, 23, 210),
('E-01020304-4', 'Av. Las Delicias, Local 15, Ciudad Ojeda', 1010, 24, 230),
('J-11223344-5', 'Av. Rómulo Gallegos, Edif. Este, Piso 3, Caracas', 1011, 1, 15),
('G-22334455-6', 'Calle Miranda, Local 7, Puerto La Cruz', 1012, 2, 20),
('J-33445566-7', 'Zona Industrial Sur, Galpón 5, Valencia', 1013, 7, 45),
('G-44556677-8', 'Carrera 23, Esquina Calle 30, Barquisimeto', 1014, 14, 100),
('J-55667788-9', 'Av. Las Américas, CC. El Dorado, Local 12, Mérida', 1015, 15, 160),
('G-66778899-0', 'Calle Bolívar, Sector Centro, San Cristóbal', 1016, 21, 200),
('J-77889900-1', 'Av. Principal, Urb. La Granja, Maracay', 1017, 4, 25),
('G-88990011-2', 'Vía La Costa, Urb. Las Aves, La Guaira', 1018, 13, 140),
('J-99001122-3', 'Calle Comercio, Centro, Maturín', 1019, 17, 170),
('G-00112233-4', 'Av. 22, Sector Belloso, Maracaibo', 1020, 24, 220),
('V-00112233-4', 'Calle 5, Urb. Los Robles, Apto 1A, Caracas', 1021, 1, 16),
('E-00223344-5', 'Av. 2, Sector Milagro Norte, Maracaibo', 1022, 24, 221),
('J-00334455-6', 'Urb. Guaparo, Res. El Lago, Piso 8, Valencia', 1023, 7, 46),
('G-00445566-7', 'Calle 30, Carrera 25, Local 10, Barquisimeto', 1024, 14, 101),
('V-00556677-8', 'Sector Castillito, Casa 30, Puerto Ordaz', 1025, 10, 81),
('E-00667788-9', 'Av. 3, Urb. Los Sauces, Mérida', 1026, 15, 161),
('J-00778899-0', 'Calle Las Flores, CC. La Casona, Local 5, Porlamar', 1027, 18, 176),
('G-00889900-1', 'Urb. La Viña, Calle Principal, Maturín', 1028, 17, 171),
('V-00990011-2', 'Calle Real, Edif. Centro, Oficina 4, San Felipe', 1029, 23, 211),
('E-01011223-3', 'Av. Venezuela, Urb. Los Olivos, Apto 2B, Caracas', 1030, 1, 17),
('J-01122334-4', 'Carrera 18, Res. El Bosque, Maracay', 1031, 4, 26),
('G-01233445-5', 'Calle Junín, Local 1, Barquisimeto', 1032, 14, 102),
('J-01344556-6', 'Urb. Agua Viva, Casa 7, Cabudare', 1033, 14, 103),
('G-01455667-7', 'Av. Urdaneta, Edif. El Faro, Piso 2, Coro', 1034, 9, 71),
('J-01566778-8', 'Sector El Dique, Calle 1, Cumaná', 1035, 20, 206),
('G-01677889-9', 'Av. Los Próceres, Urb. Don Bosco, San Cristóbal', 1036, 21, 201),
('J-01788990-0', 'Calle Miranda, Edif. Central, Oficina 9, Valera', 1037, 22, 215),
('G-01899001-1', 'Zona Industrial, Galpón 20, Puerto La Cruz', 1038, 2, 21),
('J-01900112-2', 'Av. Intercomunal, CC. Las Naves, Punto Fijo', 1039, 11, 91),
('G-02011223-3', 'Sector Las Garzas, Casa 10, Barinas', 1040, 5, 30);

-- ▗▄▄▄▖▗▄▄▄▖▗▄▄▄▖▗▖  ▗▖▗▄▄▄   ▗▄▖     ▗▄▄▄▖▗▄▄▄▖ ▗▄▄▖▗▄▄▄▖ ▗▄▄▖ ▗▄▖
--   █    █  ▐▌   ▐▛▚▖▐▌▐▌  █ ▐▌ ▐▌    ▐▌     █  ▐▌     █  ▐▌   ▐▌ ▐▌
--   █    █  ▐▛▀▀▘▐▌ ▝▜▌▐▌  █ ▐▛▀▜▌    ▐▛▀▀▘  █   ▝▀▚▖  █  ▐▌   ▐▛▀▜▌
--   █  ▗▄█▄▖▐▙▄▄▖▐▌  ▐▌▐▙▄▄▀ ▐▌ ▐▌    ▐▌   ▗▄█▄▖▗▄▄▞▘▗▄█▄▖▝▚▄▄▖▐▌ ▐▌

INSERT INTO TIENDA_FISICA (capacidad, direccion, fk_lugar) VALUES
(50, 'Av. Francisco de Miranda, Edif. Comer, Local 1, Caracas', 15),
(30, 'Calle 72, Sector Bella Vista, Maracaibo', 220),
(40, 'Centro Comercial Sambil, Nivel Feria, Valencia', 45),
(25, 'Carrera 19, entre calles 20 y 21, Barquisimeto', 100),
(35, 'Zona Alta, CC. Orinoco, Local 5, Puerto Ordaz', 80),
(20, 'Calle 24, Centro, Mérida', 160),
(15, 'Bulevar 5 de Julio, Local 10, Cumaná', 205),
(28, 'Av. Bolívar, Centro, San Cristóbal', 200),
(22, 'Calle Urdaneta, Edif. El Sol, Piso PB, Coro', 90),
(32, 'Av. Intercomunal, CC. Metrópolis, Local 1, Cabudare', 100);

-- ▗▄▄▄▖▗▖  ▗▖▗▄▄▖ ▗▖   ▗▄▄▄▖ ▗▄▖ ▗▄▄▄   ▗▄▖
-- ▐▌   ▐▛▚▞▜▌▐▌ ▐▌▐▌   ▐▌   ▐▌ ▐▌▐▌  █ ▐▌ ▐▌
-- ▐▛▀▀▘▐▌  ▐▌▐▛▀▘ ▐▌   ▐▛▀▀▘▐▛▀▜▌▐▌  █ ▐▌ ▐▌
-- ▐▙▄▄▖▐▌  ▐▌▐▌   ▐▙▄▄▖▐▙▄▄▖▐▌ ▐▌▐▙▄▄▀ ▝▚▄▞▘

INSERT INTO EMPLEADO (cedula, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, genero, fecha_union, fk_lugar) VALUES
('V-12345678', 'Ana', NULL, 'Pérez', 'García', '1990-03-15', 'Femenino', '2023-01-10', 1),
('E-87654321', 'Luis', 'Alberto', 'Rodríguez', 'Martínez', '1985-07-22', 'Masculino', '2022-05-20', 1),
('V-23456789', 'María', 'Fernanda', 'González', 'López', '1992-11-01', 'Femenino', '2024-03-01', 1),
('V-34567890', 'José', NULL, 'Hernández', 'Díaz', '1988-04-30', 'Masculino', '2021-08-15', 1),
('E-98765432', 'Carla', 'Alexandra', 'Sánchez', 'Ruiz', '1995-09-10', 'Femenino', '2023-11-01', 1),
('V-45678901', 'Pedro', 'Antonio', 'Ramírez', 'Flores', '1980-01-25', 'Masculino', '2020-02-01', 1),
('V-56789012', 'Sofía', NULL, 'Torres', 'Vargas', '1998-06-18', 'Femenino', '2024-06-10', 1),
('E-10987654', 'Ricardo', 'Jesús', 'Morales', 'Castro', '1983-12-05', 'Masculino', '2021-04-20', 1),
('V-67890123', 'Elena', 'Beatriz', 'Gómez', 'Silva', '1993-02-28', 'Femenino', '2022-09-01', 1),
('V-78901234', 'Andrés', 'Manuel', 'Ortega', 'Rojas', '1987-10-12', 'Masculino', '2023-07-05', 1);


-- ▗▄▄▄▖▗▄▖ ▗▄▄▖    ▗▖▗▄▄▄▖▗▄▄▄▖▗▄▖ 
--   █ ▐▌ ▐▌▐▌ ▐▌   ▐▌▐▌     █ ▐▌ ▐▌
--   █ ▐▛▀▜▌▐▛▀▚▖   ▐▌▐▛▀▀▘  █ ▐▛▀▜▌ 
--   █ ▐▌ ▐▌▐▌ ▐▌▗▄▄▞▘▐▙▄▄▖  █ ▐▌ ▐▌

INSERT INTO TARJETA (fk_metodo_pago, fk_banco, fk_tipo_tarjeta, numero_tarjeta, fecha_vence, nombre_titular, cvv) VALUES
(4, 1, 1, 1234567890, '2027-12-31', 'Juan Perez', 123),
(5, 2, 2, 9876543210, '2026-11-30', 'Maria Rodriguez', 456),
(6, 3, 1, 1122334455, '2028-06-30', 'Pedro Garcia', 789),

--  ▗▄▄▖▗▖ ▗▖▗▄▄▄▖▗▄▄▄▖ ▗▖ ▗▖▗▄▄▄▖ 
-- ▐▌   ▐▌ ▐▌▐▌   ▐▌ ▐▌ ▐▌ ▐▌▐▌
-- ▐▌   ▐▛▀▜▌▐▛▀▀▘▐▌ ▐▌ ▐▌ ▐▌▐▛▀▀▘
-- ▝▚▄▄▖▐▌ ▐▌▐▙▄▄▖▐▙▄▟▙▖▝▚▄▞▘▐▙▄▄▖ 

INSERT INTO CHEQUE (fk_metodo_pago, numero, fk_banco, memo) VALUES
(1, 1001, 1, 'Pago de servicios'),
(2, 1002, 2, 'Compra de insumos'),
(3, 1003, 3, 'Alquiler local'),


-- ▗▄▄▄▖▗▄▄▄▖▗▄▄▄▖ ▗▄▄▖▗▄▄▄▖▗▄▄▄▖▗▖  ▗▖ ▗▄▖
-- ▐▌   ▐▌   ▐▌   ▐▌     █    █  ▐▌  ▐▌▐▌ ▐▌
-- ▐▛▀▀▘▐▛▀▀▘▐▛▀▀▘▐▌     █    █  ▐▌  ▐▌▐▌ ▐▌
-- ▐▙▄▄▖▐▌   ▐▙▄▄▖▝▚▄▄▖  █  ▗▄█▄▖ ▝▚▞▘ ▝▚▄▞▘

INSERT INTO EFECTIVO (fk_metodo_pago, denominacion, tipo_moneda) VALUES
(7, 100, 'Bolívares'),
(8, 50, 'Bolívares'),
(9, 20, 'Dólares'),


-- ▗▄▄▖ ▗▖ ▗▖▗▖  ▗▖▗▄▄▄▖▗▄▖
-- ▐▌ ▐▌▐▌ ▐▌▐▛▚▖▐▌  █ ▐▌ ▐▌ 
-- ▐▛▀▘ ▐▌ ▐▌▐▌ ▝▜▌  █ ▐▌ ▐▌ 
-- ▐▌   ▝▚▄▞▘▐▌  ▐▌  █ ▝▚▄▞▘

INSERT INTO PUNTO (fk_metodo_pago) VALUES
(10);


--  ▗▄▖ ▗▄▄▄▖▗▄▄▄▖▗▖   ▗▄▄▄▖ ▗▄▖  ▗▄▄▖▗▄▄▄▖ ▗▄▖ ▗▖  ▗▖
-- ▐▌ ▐▌▐▌     █  ▐▌     █  ▐▌ ▐▌▐▌     █  ▐▌ ▐▌▐▛▚▖▐▌ 
-- ▐▛▀▜▌▐▛▀▀▘  █  ▐▌     █  ▐▛▀▜▌▐▌     █  ▐▌ ▐▌▐▌ ▝▜▌
-- ▐▌ ▐▌▐▌   ▗▄█▄▖▐▙▄▄▖▗▄█▄▖▐▌ ▐▌▝▚▄▄▖▗▄█▄▖▝▚▄▞▘▐▌  ▐▌ 

INSERT INTO AFILIACION (fecha, monto_mensual, fk_proveedor) VALUES
('2024-01-01', 50.00, 1),  
('2024-01-15', 75.00, 2), 
('2024-02-01', 60.00, 3), 
('2024-02-10', 45.00, 4),  
('2024-03-01', 80.00, 5), 
('2024-03-20', 55.00, 6),  
('2024-04-05', 70.00, 7),  
('2024-04-15', 65.00, 8),  
('2024-05-01', 90.00, 9),  
('2024-05-10', 50.00, 10);


--  ▗▄▄▖ ▗▄▖ ▗▖  ▗▖▗▄▄▖ ▗▄▄▖  ▗▄▖
-- ▐▌   ▐▌ ▐▌▐▛▚▞▜▌▐▌ ▐▌▐▌ ▐▌▐▌ ▐▌ 
-- ▐▌   ▐▌ ▐▌▐▌  ▐▌▐▛▀▘ ▐▛▀▚▖▐▛▀▜▌
-- ▝▚▄▄▖▝▚▄▞▘▐▌  ▐▌▐▌   ▐▌ ▐▌▐▌ ▐▌


-- ▗▄▄▖ ▗▖  ▗▖ ▗▄▖▗▄▄▄▖▗▖ ▗▖▗▄▄▖  ▗▄▖ ▗▖    
-- ▐▌ ▐▌▐▛▚▖▐▌▐▌ ▐▌ █  ▐▌ ▐▌▐▌ ▐▌▐▌ ▐▌▐▌    
-- ▐▛▀▘ ▐▌ ▝▜▌▐▛▀▜▌ █  ▐▌ ▐▌▐▛▀▚▖▐▛▀▜▌▐▌    
-- ▐▌   ▐▌  ▐▌▐▌ ▐▌ █  ▝▚▄▞▘▐▌ ▐▌▐▌ ▐▌▐▙▄▄▖

INSERT INTO PNATURAL (fk_cliente, cedula, nombre, apellido, fecha_nacimiento) VALUES
(1, 'V-12345678', 'Ana', 'Pérez', '1985-03-15'),
(2, 'V-23456789', 'Luis', 'García', '1990-07-22'),
(3, 'V-34567890', 'Sofía', 'Rodríguez', '1992-11-01'),
(4, 'V-45678901', 'Diego', 'Hernández', '1988-04-30'),
(5, 'V-56789012', 'María', 'Sánchez', '1995-09-10'),
(6, 'V-67890123', 'Carlos', 'Díaz', '1980-01-25'),
(7, 'V-78901234', 'Elena', 'González', '1998-06-18'),
(8, 'V-89012345', 'Pedro', 'Ruiz', '1983-12-05'),
(9, 'V-90123456', 'Laura', 'Martínez', '1993-02-28'),
(10, 'V-01234567', 'Andrés', 'López', '1987-10-12'),
(21, 'V-10112233', 'Roberto', 'Vargas', '1979-08-01'),
(22, 'V-10223344', 'Camila', 'Silva', '1991-04-19'),
(23, 'V-10334455', 'Fernando', 'Peña', '1984-11-05'),
(24, 'V-10445566', 'Valeria', 'Reyes', '1996-02-14'),
(25, 'V-10556677', 'Gabriel', 'Castro', '1982-07-28'),
(26, 'V-10667788', 'Victoria', 'Medina', '1994-09-03'),
(27, 'V-10778899', 'Ricardo', 'Navas', '1989-01-11'),
(28, 'V-10889900', 'Paula', 'Moreno', '1997-05-20'),
(29, 'V-10990011', 'Jorge', 'Herrera', '1981-12-07'),
(30, 'V-11001122', 'Daniela', 'Soto', '1993-06-25');


-- ▗▄▄▖ ▗▖▗▖ ▗▖▗▄▄▖ ▗▖ ▗▖▗▄▄▄  ▗▄▄▄▖ ▗▄▄▖ ▗▄▖    
-- ▐▌ ▐▌▐▌▐▌ ▐▌▐▌ ▐▌▐▌ ▐▌▐▌  █   █  ▐▌   ▐▌ ▐▌   
-- ▐▛▀▘ ▐▌▐▌ ▐▌▐▛▀▚▖▐▌ ▐▌▐▌  █   █  ▐▌   ▐▌ ▐▌   
-- ▐▌▗▄▄▞▘▝▚▄▞▘▐▌ ▐▌▝▚▄▞▘▐▙▄▄▀ ▗▄█▄▖▝▚▄▄▖▝▚▄▞▘   

INSERT INTO PJURIDICO (fk_cliente, denominacion_comercial, razon_social, pagina_web, capital_disponible) VALUES
(11, 'Cervecería Artesanal El Morro', 'Cervezas Artesanales El Morro C.A.', 'http://www.elmorrococuy.com', 500000.00),
(12, 'Distribuidora Oriental de Bebidas', 'Distribuidora Oriental de Bebidas S.A.', NULL, 750000.00),
(13, 'Embotelladora del Centro', 'Embotelladora del Centro C.A.', 'http://www.embocentro.com.ve', 1200000.00),
(14, 'Grupo Cervecero Lara', 'Grupo Cervecero Lara S.R.L.', NULL, 300000.00),
(15, 'Andina de Cervezas', 'Andina de Cervezas G.P.', 'http://www.andinacervezas.com', 800000.00),
(16, 'Empresas Cerveceras del Táchira', 'Empresas Cerveceras del Táchira C.A.', NULL, 600000.00),
(17, 'Fábrica de Malta Aragua', 'Fábrica de Malta Aragua S.A.', 'http://www.maltaragua.com', 900000.00),
(18, 'Importadora La Guaira Bebidas', 'Importadora La Guaira Bebidas C.A.', NULL, 400000.00),
(19, 'Corporación Cervecera Monagas', 'Corporación Cervecera Monagas S.R.L.', 'http://www.cervezasmonagas.net', 1100000.00),
(20, 'Almacenes Zulia Cervezas', 'Almacenes Zulia Cervezas S.A.', NULL, 1500000.00),
(31, 'Importadora del Centro C.A.', 'Importaciones del Centro S.A.', NULL, 650000.00),
(32, 'Servicios Logísticos Barquisimeto', 'Servicios Logísticos Barquisimeto R.L.', 'http://www.logisticabqto.com', 400000.00),
(33, 'Cervezas Artesanales Cabudare', 'Cervezas Artesanales Cabudare C.A.', 'http://www.cabudarebrew.com', 950000.00),
(34, 'Envases y Embalajes Coro', 'Envases y Embalajes Coro S.A.', NULL, 280000.00),
(35, 'Distribuidores Cumaná Global', 'Distribuidores Cumaná Global C.A.', 'http://www.distribuidorascumana.com', 720000.00),
(36, 'Productos Gourmet Táchira', 'Productos Gourmet Táchira S.R.L.', NULL, 550000.00),
(37, 'Tecnología Cervecera Valera', 'Tecnología Cervecera Valera S.A.', 'http://www.tecvalera.com', 1000000.00),
(38, 'Insumos Industriales Anzoátegui', 'Insumos Industriales Anzoátegui C.A.', NULL, 480000.00),
(39, 'Suministros Costa Oriental', 'Suministros Costa Oriental S.A.', 'http://www.suministroscosta.net', 880000.00),
(40, 'Agroindustrias Barinas', 'Agroindustrias Barinas C.A.', NULL, 700000.00);

-- ▗▄▄▄  ▗▄▄▄▖▗▄▄▖  ▗▄▖ ▗▄▄▖▗▄▄▄▖▗▄▖ ▗▖  ▗▖▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖▗▄▖  
-- ▐▌  █ ▐▌   ▐▌ ▐▌▐▌ ▐▌▐▌ ▐▌ █ ▐▌ ▐▌▐▛▚▞▜▌▐▌   ▐▛▚▖▐▌  █ ▐▌ ▐▌ 
-- ▐▌  █ ▐▛▀▀▘▐▛▀▘ ▐▛▀▜▌▐▛▀▚▖ █ ▐▛▀▜▌▐▌  ▐▌▐▛▀▀▘▐▌ ▝▜▌  █ ▐▌ ▐▌ 
-- ▐▙▄▄▀ ▐▙▄▄▖▐▌   ▐▌ ▐▌▐▌ ▐▌ █ ▐▌ ▐▌▐▌  ▐▌▐▙▄▄▖▐▌  ▐▌  █ ▝▚▄▞▘   

INSERT INTO DEPARTAMENTO (nombre, descripcion, fk_tienda_fisica) VALUES
('Cervezas Nacionales', 'Departamento encargado de la venta de cervezas producidas en el país.', 1),
('Cervezas Importadas', 'Departamento para la distribución y venta de cervezas de origen internacional.', 1),
('Accesorios Cerveceros', 'Sección dedicada a la venta de vasos, destapadores y otros utensilios de cerveza.', 2),
('Alimentos y Snacks', 'Ofrece una variedad de pasapalos y comidas para acompañar las bebidas.', 2),
('Ventas Online', 'Gestiona los pedidos y envíos realizados a través de la tienda virtual.', 3),
('Atención al Cliente', 'Área de soporte y resolución de dudas para los clientes.', 3),
('Producción Artesanal', 'Espacio dedicado a la elaboración de lotes de cerveza artesanal.', 4),
('Control de Calidad', 'Departamento que asegura la calidad de las cervezas y materias primas.', 4),
('Administración', 'Oficina central para la gestión administrativa y financiera de la tienda.', 5),
('Recursos Humanos', 'Sección encargada de la gestión de personal y contratación.', 5);

-- ▗▄▄▄▖▗▖  ▗▖▗▄▄▖ ▗▖       ▗▖ ▗▖ ▗▄▖ ▗▄▄▖  ▗▄▖       
-- ▐▌   ▐▛▚▞▜▌▐▌ ▐▌▐▌       ▐▌ ▐▌▐▌ ▐▌▐▌ ▐▌▐▌ ▐▌      
-- ▐▛▀▀▘▐▌  ▐▌▐▛▀▘ ▐▌       ▐▛▀▜▌▐▌ ▐▌▐▛▀▚▖▐▛▀▜▌      
-- ▐▙▄▄▖▐▌  ▐▌▐▌   ▐▙▄▄▖    ▐▌ ▐▌▝▚▄▞▘▐▌ ▐▌▐▌ ▐▌ 


INSERT INTO EMPL_HORA (fk_empleado, fk_horario, asistencia) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 0),
(4, 4, 1),
(5, 5, 1),
(6, 6, 1),
(7, 7, 0),
(8, 8, 1),
(9, 9, 1),
(10, 10, 1);


-- ▗▖ ▗▖ ▗▄▄▖▗▖ ▗▖ ▗▄▖ ▗▄▄▖ ▗▄▄▄▖ ▗▄▖     
-- ▐▌ ▐▌▐▌   ▐▌ ▐▌▐▌ ▐▌▐▌ ▐▌  █  ▐▌ ▐▌   
-- ▐▌ ▐▌ ▝▀▚▖▐▌ ▐▌▐▛▀▜▌▐▛▀▚▖  █  ▐▌ ▐▌    
-- ▝▚▄▞▘▗▄▄▞▘▝▚▄▞▘▐▌ ▐▌▐▌ ▐▌▗▄█▄▖▝▚▄▞▘  

INSERT INTO USUARIO (nombre, contraseña, fk_empleado, fk_cliente, fk_proveedor, fk_rol) VALUES
('sys_admin', MD5('secureAdminPass'), 1, NULL, NULL, 1), 
('cliente_web_1', MD5('webuser123'), NULL, 2, NULL, 2),    
('proveedor_admin', MD5('provAdmin!'), NULL, NULL, 1, 1), 
('cliente_corporativo_user', MD5('corpUserPass'), NULL, 11, NULL, 2), 
('empleado_user_sales', MD5('salespass'), 3, NULL, NULL, 2), 
('cliente_web_2', MD5('webuser456'), NULL, 4, NULL, 2),    
('dev_admin', MD5('devAdminPass'), 5, NULL, NULL, 1),    
('cliente_vip_user', MD5('vipClientSecure'), NULL, 13, NULL, 2), 
('proveedor_basic_user', MD5('basicProvPass'), NULL, NULL, 3, 2), 
('empleado_user_hr', MD5('hrpass'), 7, NULL, NULL, 2);

-- ▗▄▄▄▖▗▄▄▄▖▗▖   ▗▄▄▄▖▗▄▄▄▖ ▗▄▖ ▗▖  ▗▖ ▗▄▖   
--   █  ▐▌   ▐▌   ▐▌   ▐▌   ▐▌ ▐▌▐▛▚▖▐▌▐▌ ▐▌  
--   █  ▐▛▀▀▘▐▌   ▐▛▀▀▘▐▛▀▀▘▐▌ ▐▌▐▌ ▝▜▌▐▌ ▐▌  
--   █  ▐▙▄▄▖▐▙▄▄▖▐▙▄▄▖▐▌   ▝▚▄▞▘▐▌  ▐▌▝▚▄▞▘ 

INSERT INTO TELEFONO (codigo_pais, numero, fk_proveedor, fk_cliente, fk_empleado) VALUES
(58, 4121234567, 1, NULL, NULL), 
(58, 2129876543, NULL, 1, NULL),  
(58, 4147654321, NULL, NULL, 1), 
(58, 4160123456, 11, NULL, NULL),
(58, 2415551234, NULL, 12, NULL), 
(58, 4243334455, NULL, NULL, 2),  
(58, 2866667788, 2, NULL, NULL),   
(58, 2959990011, NULL, 21, NULL), 
(58, 4125556677, NULL, NULL, 3),  
(58, 4168889900, NULL, 31, NULL); 


--  ▗▄▄▖ ▗▄▖ ▗▄▄▖ ▗▄▄▖ ▗▄▄▄▖ ▗▄▖        
-- ▐▌   ▐▌ ▐▌▐▌ ▐▌▐▌ ▐▌▐▌   ▐▌ ▐▌     
-- ▐▌   ▐▌ ▐▌▐▛▀▚▖▐▛▀▚▖▐▛▀▀▘▐▌ ▐▌     
-- ▝▚▄▄▖▝▚▄▞▘▐▌ ▐▌▐▌ ▐▌▐▙▄▄▖▝▚▄▞▘  

INSERT INTO CORREO (correo, dominio, fk_proveedor, fk_cliente, fk_empleado) VALUES
('contacto', 'cervecerialacapital.com', 1, NULL, NULL),  
('ana.perez', 'ejemplo.com', NULL, 1, NULL),           
('juan.perez', 'empresa.com', NULL, NULL, 1),         
('info', 'distribuidoramiranda.net', 2, NULL, NULL),   
('luis.garcia', 'correo.org', NULL, 2, NULL),          
('maria.rodriguez', 'mycompany.com', NULL, NULL, 2),   
('ventas', 'maltacarabobo.com', 3, NULL, NULL),     
('sofia.rodriguez', 'email.com', NULL, 3, NULL),       
('pedro.garcia', 'corp-email.com', NULL, NULL, 3),    
('clientes', 'lupulosanzoategui.com', 4, NULL, NULL); 


-- ▗▄▄▄▖ ▗▄▄▖▗▄▄▄▖▗▄▖      ▗▄▄▖ ▗▄▖ ▗▖  ▗▖▗▄▄▖    
-- ▐▌   ▐▌     █ ▐▌ ▐▌    ▐▌   ▐▌ ▐▌▐▛▚▞▜▌▐▌ ▐▌   
-- ▐▛▀▀▘ ▝▀▚▖  █ ▐▛▀▜▌    ▐▌   ▐▌ ▐▌▐▌  ▐▌▐▛▀▘   
-- ▐▙▄▄▖▗▄▄▞▘  █ ▐▌ ▐▌    ▝▚▄▄▖▝▚▄▞▘▐▌  ▐▌▐▌  


-- ▗▄▄▄  ▗▄▄▄▖▗▄▄▄▖▗▄▖ ▗▖   ▗▖   ▗▄▄▄▖     ▗▄▄▖ ▗▄▖ ▗▖  ▗▖▗▄▄▖ ▗▄▄▖  ▗▄▖               
-- ▐▌  █ ▐▌     █ ▐▌ ▐▌▐▌   ▐▌   ▐▌       ▐▌   ▐▌ ▐▌▐▛▚▞▜▌▐▌ ▐▌▐▌ ▐▌▐▌ ▐▌              
-- ▐▌  █ ▐▛▀▀▘  █ ▐▛▀▜▌▐▌   ▐▌   ▐▛▀▀▘    ▐▌   ▐▌ ▐▌▐▌  ▐▌▐▛▀▘ ▐▛▀▚▖▐▛▀▜▌              
-- ▐▙▄▄▀ ▐▙▄▄▖  █ ▐▌ ▐▌▐▙▄▄▖▐▙▄▄▖▐▙▄▄▖    ▝▚▄▄▖▝▚▄▞▘▐▌  ▐▌▐▌   ▐▌ ▐▌▐▌ ▐▌     


--  ▗▄▄▖ ▗▄▖ ▗▄▄▖  ▗▄▄▖ ▗▄▖                                                            
-- ▐▌   ▐▌ ▐▌▐▌ ▐▌▐▌   ▐▌ ▐▌                                                           
-- ▐▌   ▐▛▀▜▌▐▛▀▚▖▐▌▝▜▌▐▌ ▐▌                                                           
-- ▝▚▄▄▖▐▌ ▐▌▐▌ ▐▌▝▚▄▞▘▝▚▄▞▘ 

INSERT INTO CARGO (nombre) VALUES
('Gerente'),
('Supervisor'),
('Asistente'),
('Operador'),
('Especialista'),
('Coordinador'),
('Analista'),
('Director'),
('Técnico'),
('Practicante');


-- ▗▄▄▖ ▗▄▄▄▖▗▄▄▖  ▗▄▄▖ ▗▄▖ ▗▖  ▗▖ ▗▄▖ ▗▖        ▗▄▄▖ ▗▄▖ ▗▖  ▗▖▗▄▄▄▖▗▄▖  ▗▄▄▖▗▄▄▄▖▗▄▖ 
-- ▐▌ ▐▌▐▌   ▐▌ ▐▌▐▌   ▐▌ ▐▌▐▛▚▖▐▌▐▌ ▐▌▐▌       ▐▌   ▐▌ ▐▌▐▛▚▖▐▌  █ ▐▌ ▐▌▐▌     █ ▐▌ ▐▌
-- ▐▛▀▘ ▐▛▀▀▘▐▛▀▚▖ ▝▀▚▖▐▌ ▐▌▐▌ ▝▜▌▐▛▀▜▌▐▌       ▐▌   ▐▌ ▐▌▐▌ ▝▜▌  █ ▐▛▀▜▌▐▌     █ ▐▌ ▐▌
-- ▐▌   ▐▙▄▄▖▐▌ ▐▌▗▄▄▞▘▝▚▄▞▘▐▌  ▐▌▐▌ ▐▌▐▙▄▄▖    ▝▚▄▄▖▝▚▄▞▘▐▌  ▐▌  █ ▐▌ ▐▌▝▚▄▄▖  █ ▝▚▄▞▘

INSERT INTO PERSONAL_CONTACTO (nombre, apellido, fk_juridico, fk_proveedor, fk_cargo) VALUES
('Juan', 'Martínez', 1, NULL, 1),  
('María', 'Fernández', NULL, 1, 2),  
('Pedro', 'González', 2, NULL, 3),  
('Ana', 'Díaz', NULL, 2, 4),  
('Luis', 'Ramírez', 3, NULL, 5),  
('Sofía', 'Castro', NULL, 3, 6),  
('José', 'Torres', 4, NULL, 7),  
('Laura', 'Vargas', NULL, 4, 8),  
('Carlos', 'Sánchez', 5, NULL, 9),  
('Elena', 'Ruiz', NULL, 5, 10);


-- ▗▄▄▄▖▗▄▄▄▖▗▄▄▖  ▗▄▖      ▗▄▄▖▗▄▄▄▖▗▄▄▖ ▗▖  ▗▖▗▄▄▄▖▗▄▄▄▄▖ ▗▄▖  
--   █    █  ▐▌ ▐▌▐▌ ▐▌    ▐▌   ▐▌   ▐▌ ▐▌▐▌  ▐▌▐▌      ▗▞▘▐▌ ▐▌   
--   █    █  ▐▛▀▘ ▐▌ ▐▌    ▐▌   ▐▛▀▀▘▐▛▀▚▖▐▌  ▐▌▐▛▀▀▘ ▗▞▘  ▐▛▀▜▌ 
--   █  ▗▄█▄▖▐▌   ▝▚▄▞▘    ▝▚▄▄▖▐▙▄▄▖▐▌ ▐▌ ▝▚▞▘ ▐▙▄▄▖▐▙▄▄▄▖▐▌ ▐▌  

INSERT INTO TIPO_CERVEZA (nombre, fk_tipo_cerveza, fk_receta) VALUES
('Ale', NULL, 1),
('Lager', NULL, 2),
('Cervezas de trigo', NULL, 3),
('Sour', NULL, 4),
('Witbier', NULL, 5),
('Spice, Herb o Vegetable Beer', NULL, 6),
('Pale', 1, 7),
('Brown', 1, 8),
('Red', 1, 9),
('Amber', 1, 10),
('Pumpkin', 1, 11),
('Golden', 1, 12),
('Blond', 1, 13),
('Stout', 1, 14),
('IPA', 1, 15),
('ESB', 1, 16),
('Porter', 1, 17),
('Barley Wine', 1, 18),
('English Bitter', 1, 19),
('American Amber Ale', 1, 20),
('American Pale Ale', 1, 21),
('American IPA', 1, 22),
('Belgian Specialty Ale', 1, 23),
('Cerveza de Abadía', 1, 24),
('Trapense', 1, 25),
('Ámbar', 1, 26),
('Flamenca', 1, 27),
('Belgian Barleywine', 1, 28),
('Trappist Quadrupel', 1, 29),
('Belgian Spiced Christmas Beer', 1, 30),
('Belgian Stout', 1, 31),
('Belgian IPA', 1, 32),
('Blond Trappist Table Beer', 1, 33),
('Artisanal Blond', 1, 34),
('Artisanal Amber', 1, 35),
('Artisanal Brown', 1, 36),
('Flanders Red/Brown con frutas', 1, 37),
('Pilsner', 2, 38),
('Spezial', 2, 39),
('Dortmunster', 2, 40),
('Schwarzbier', 2, 41),
('Vienna', 2, 42),
('Bock', 2, 43),
('Hefeweizen', 3, 44),
('Weisse Beer', 3, 45),
('Weizen-Weissbier', 3, 46),
('Imperial Stout', 14, 47),
('Chocolate', 14, 48),
('Coffee', 14, 49),
('Milk Stout', 14, 50),
('Sweet Stout', 14, 51),
('Eisbock', 43, 52),
('Strong Saison', 23, 53),
('Dark Saison', 23, 54),
('Blonde Ale', 1, 55);


--  ▗▄▄▖▗▄▄▄▖▗▄▄▖ ▗▖  ▗▖▗▄▄▄▖▗▄▄▄▄▖ ▗▄▖  
-- ▐▌   ▐▌   ▐▌ ▐▌▐▌  ▐▌▐▌      ▗▞▘▐▌ ▐▌   
-- ▐▌   ▐▛▀▀▘▐▛▀▚▖▐▌  ▐▌▐▛▀▀▘ ▗▞▘  ▐▛▀▜▌   
-- ▝▚▄▄▖▐▙▄▄▖▐▌ ▐▌ ▝▚▞▘ ▐▙▄▄▖▐▙▄▄▄▖▐▌ ▐▌ 

INSERT INTO CERVEZA (nombre, descripcion, historia, fk_tipo_cerveza, fk_proveedor, fk_lugar) VALUES
('Golden Ale Sol', 'Cerveza dorada y refrescante con notas sutiles de malta y final limpio.', 'Inspirada en el sol de verano, creada para ser ligera y fácil de beber en cualquier ocasión.', 1, 1, 200), 
('Stout Nocturna', 'Cerveza oscura e intensa con sabores a café tostado y chocolate amargo.', 'Elaborada para las noches caraqueñas, buscando capturar la profundidad y el misterio.', 4, 2, 201), 
('IPA Tropical', 'India Pale Ale con perfil aromático intenso a frutas tropicales (mango, maracuyá) y amargor pronunciado.', 'Tributo a la riqueza frutal del trópico venezolano, una explosión de sabor.', 3, 3, 202), 
('Witbier de Trigo', 'Cerveza belga de trigo, ligera y turbia, con toques de cilantro y cáscara de naranja.', 'Con raíces belgas, adaptada al clima local para una opción ligera y especiada.', 6, 4, 203), 
('Lager Clásica', 'Lager pálida y crujiente de fermentación baja, sabor equilibrado y refrescante.', 'Busca replicar la pureza y sencillez de las cervezas tradicionales europeas.', 2, 5, 204),
('Porter Robusta', 'Cerveza oscura con notas de caramelo, toffee y ligero ahumado, de cuerpo medio a completo.', 'Reinventada para el paladar local, ofreciendo calidez y complejidad.', 5, 6, 205), 
('Saison Campestre', 'Cerveza rústica de granja, alta carbonatación, notas frutales y final seco.', 'Evoca los sabores del campo y la frescura de la naturaleza.', 9, 7, 206), 
('Scotch Ale Fuerte', 'Cerveza ámbar-rojiza, maltosa, con un dulzor inicial pronunciado y cuerpo robusto.', 'Inspirada en las cervezas escocesas, para amantes de sabores intensos.', 1, 8, 207), 
('Sour Frambuesa', 'Cerveza ácida y frutal, con intenso sabor a frambuesas frescas y final vibrante.', 'Innovación audaz, equilibrio entre acidez y dulzura, para paladares aventureros.', 8, 9, 208), 
('Imperial Stout Añeja', 'Stout de alto contenido alcohólico, compleja, con capas de sabor a licor y frutos secos.', 'Una joya que mejora con el tiempo, para una experiencia sensorial única.', 4, 10, 209);

--  ▗▄▄▖ ▗▄▖ ▗▖  ▗▖▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖▗▄▖ ▗▄▄▖ ▗▄▄▄▖ ▗▄▖ 
-- ▐▌   ▐▌ ▐▌▐▛▚▞▜▌▐▌   ▐▛▚▖▐▌  █ ▐▌ ▐▌▐▌ ▐▌  █  ▐▌ ▐▌  
-- ▐▌   ▐▌ ▐▌▐▌  ▐▌▐▛▀▀▘▐▌ ▝▜▌  █ ▐▛▀▜▌▐▛▀▚▖  █  ▐▌ ▐▌ 
-- ▝▚▄▄▖▝▚▄▞▘▐▌  ▐▌▐▙▄▄▖▐▌  ▐▌  █ ▐▌ ▐▌▐▌ ▐▌▗▄█▄▖▝▚▄▞▘  

INSERT INTO COMENTARIO (descripcion, fk_cerveza) VALUES
('Excelente sabor, muy refrescante y ligera.', 1),
('Un aroma a lúpulo increíble, perfecta para el verano.', 2),
('Demasiado amarga para mi gusto, pero tiene buen cuerpo.', 3),
('Ideal para acompañar con carnes asadas, muy robusta.', 4),
('Sorprendente, un toque cítrico que la hace única.', 5),
('No me terminó de convencer, le falta algo de carácter.', 6),
('Mi favorita sin duda, el equilibrio perfecto entre dulce y amargo.', 7),
('Buena opción para probar algo diferente, notas a café.', 8),
('Muy suave, podría ser más intensa para mi paladar.', 9),
('Maravillosa, se siente la calidad de los ingredientes artesanales.', 10);


--  ▗▄▄▖▗▄▄▄▖▗▄▄▖ ▗▖  ▗▖    ▗▄▄▖ ▗▄▄▖ ▗▄▄▄▖                                      
-- ▐▌   ▐▌   ▐▌ ▐▌▐▌  ▐▌    ▐▌ ▐▌▐▌ ▐▌▐▌   ▐▌   
-- ▐▌   ▐▛▀▀▘▐▛▀▚▖▐▌  ▐▌    ▐▛▀▘ ▐▛▀▚▖▐▛▀▀▘ ▝▀▚▖  
-- ▝▚▄▄▖▐▙▄▄▖▐▌ ▐▌ ▝▚▞▘     ▐▌   ▐▌ ▐▌▐▙▄▄▖▗▄▄▞▘  


INSERT INTO CERV_PRES (fk_cerveza, fk_presentacion, precio) VALUES
(1, 1, 3.50),
(1, 3, 3.75), 
(2, 2, 4.80), 
(2, 4, 5.20), 
(3, 1, 4.00),
(3, 7, 120.00), 
(4, 5, 8.50),
(5, 3, 2.99),
(6, 2, 4.50),
(7, 8, 18.00);

-- ▗▄▄▄  ▗▄▄▄▖ ▗▄▄▖ ▗▄▄▖     ▗▄▄▖▗▄▄▄▖▗▄▄▖ ▗▖  ▗▖    ▗▄▄▖ ▗▄▄▖ ▗▄▄▄▖ ▗▄▄▖  
-- ▐▌  █ ▐▌   ▐▌   ▐▌       ▐▌   ▐▌   ▐▌ ▐▌▐▌  ▐▌    ▐▌ ▐▌▐▌ ▐▌▐▌   ▐▌ 
-- ▐▌  █ ▐▛▀▀▘ ▝▀▚▖▐▌       ▐▌   ▐▛▀▀▘▐▛▀▚▖▐▌  ▐▌    ▐▛▀▘ ▐▛▀▚▖▐▛▀▀▘ ▝▀▚▖ 
-- ▐▙▄▄▀ ▐▙▄▄▖▗▄▄▞▘▝▚▄▄▖    ▝▚▄▄▖▐▙▄▄▖▐▌ ▐▌ ▝▚▞▘     ▐▌   ▐▌ ▐▌▐▙▄▄▖▗▄▄▞▘  


INSERT INTO DESC_CERV_PRES (fk_cerveza, fk_presentacion, fk_descuento, fecha_inicio, fecha_fin) VALUES
(1, 1, 1, '2025-07-01', '2025-07-15'),  
(2, 2, 2, '2025-07-05', '2025-07-20'),  
(3, 3, 3, '2025-07-10', '2025-07-25'),  
(4, 4, 4, '2025-07-15', '2025-07-30'),  
(5, 5, 5, '2025-08-01', '2025-08-15'),  
(6, 6, 1, '2025-08-05', '2025-08-20'),  
(7, 7, 2, '2025-08-10', '2025-08-25'),  
(8, 8, 3, '2025-08-15', '2025-08-30'),  
(9, 9, 4, '2025-09-01', '2025-09-15'),  
(10, 10, 5, '2025-09-05', '2025-09-20');

-- ▗▄▄▄▖▗▄▄▄▖▗▄▄▖  ▗▄▖     ▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖▗▄▖ 
--   █    █  ▐▌ ▐▌▐▌ ▐▌    ▐▌   ▐▌  ▐▌▐▌   ▐▛▚▖▐▌  █ ▐▌ ▐▌  
--   █    █  ▐▛▀▘ ▐▌ ▐▌    ▐▛▀▀▘▐▌  ▐▌▐▛▀▀▘▐▌ ▝▜▌  █ ▐▌ ▐▌ 
--   █  ▗▄█▄▖▐▌   ▝▚▄▞▘    ▐▙▄▄▖ ▝▚▞▘ ▐▙▄▄▖▐▌  ▐▌  █ ▝▚▄▞▘       

INSERT INTO TIPO_EVENTO (nombre, descripcion) 
VALUES ('Foro','Foro dado por un ponente invitado'),
('Cata','Degustacion de cervezas'), 
('Presentacion','Presentacion de algun tema'),
('Curso','Curso de algun tema'),
('Caridad','Evento para apoyar alguna caridad'),
('Privado','Evento con invitaciones'),
('Corporativo','Evento hecho para corporaciones'),
('Cultural','Evento en el que se celebra la cultura'),
('Exhibicion','Exhibicion de productos'),
('Exposicion','Exposicion de algun tema/producto');

-- ▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖▗▄▖  
-- ▐▌   ▐▌  ▐▌▐▌   ▐▛▚▖▐▌  █ ▐▌ ▐▌ 
-- ▐▛▀▀▘▐▌  ▐▌▐▛▀▀▘▐▌ ▝▜▌  █ ▐▌ ▐▌ 
-- ▐▙▄▄▖ ▝▚▞▘ ▐▙▄▄▖▐▌  ▐▌  █ ▝▚▄▞▘     

INSERT INTO EVENTO (nombre, descripcion, numero_entradas, fecha_inicio, fecha_fin, direccion, fk_evento, fk_tipo_evento, fk_lugar) 
VALUES ('UBirra','Degustacion de 30 birras', 100, '5-7-2024','6-7-2024', 'UCAB, Plaza Mickey', NULL, (SELECT eid FROM TIPO_EVENTO WHERE nombre = 'Cata'), (SELECT eid FROM LUGAR WHERE nombre = 'La Vega' AND tipo = 'PARROQUIA')),
('UBirra','Degustacion de 30 birras', 100, '12-7-2024','13-7-2024', 'UCAB, Plaza Mickey', NULL, (SELECT eid FROM TIPO_EVENTO WHERE nombre = 'Cata'), (SELECT eid FROM LUGAR WHERE nombre = 'La Vega' AND tipo = 'PARROQUIA')),
('UBirra','Degustacion de 30 birras', 100, '19-7-2024','20-7-2024', 'UCAB, Plaza Mickey', NULL, (SELECT eid FROM TIPO_EVENTO WHERE nombre = 'Cata'), (SELECT eid FROM LUGAR WHERE nombre = 'La Vega' AND tipo = 'PARROQUIA')),
('UBirra','Degustacion de 30 birras', 100, '26-7-2024','27-7-2024', 'UCAB, Plaza Mickey', NULL, (SELECT eid FROM TIPO_EVENTO WHERE nombre = 'Cata'), (SELECT eid FROM LUGAR WHERE nombre = 'La Vega' AND tipo = 'PARROQUIA')),
('Historia de la Cerveza en Venezuela','Charla dada por un experto', 1000, '1-1-2024','1-1-2024', 'UCAB, Aula Magna', NULL, (SELECT eid FROM TIPO_EVENTO WHERE nombre = 'Foro'), (SELECT eid FROM LUGAR WHERE nombre = 'La Vega' AND tipo = 'PARROQUIA')),
('UBirra','Degustacion de 30 birras', 100, '1-1-2024','1-1-2024', 'UCAB, Plaza Mickey', NULL, (SELECT eid FROM TIPO_EVENTO WHERE nombre = 'Cata'), (SELECT eid FROM LUGAR WHERE nombre = 'La Vega' AND tipo = 'PARROQUIA')),
('UBirra','Degustacion de 30 birras', 100, '1-1-2024','1-1-2024', 'UCAB, Plaza Mickey', NULL, (SELECT eid FROM TIPO_EVENTO WHERE nombre = 'Cata'), (SELECT eid FROM LUGAR WHERE nombre = 'La Vega' AND tipo = 'PARROQUIA')),
('UBirra','Degustacion de 30 birras', 100, '1-1-2024','1-1-2024', 'UCAB, Plaza Mickey', NULL, (SELECT eid FROM TIPO_EVENTO WHERE nombre = 'Cata'), (SELECT eid FROM LUGAR WHERE nombre = 'La Vega' AND tipo = 'PARROQUIA')),
('UBirra','Degustacion de 30 birras', 100, '1-1-2024','1-1-2024', 'UCAB, Plaza Mickey', NULL, (SELECT eid FROM TIPO_EVENTO WHERE nombre = 'Cata'), (SELECT eid FROM LUGAR WHERE nombre = 'La Vega' AND tipo = 'PARROQUIA')),
('UBirra','Degustacion de 30 birras', 100, '1-1-2024','1-1-2024', 'UCAB, Plaza Mickey', NULL, (SELECT eid FROM TIPO_EVENTO WHERE nombre = 'Cata'), (SELECT eid FROM LUGAR WHERE nombre = 'La Vega' AND tipo = 'PARROQUIA')),
;

-- ▗▖  ▗▖▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖▗▄▖  
-- ▐▌  ▐▌▐▌   ▐▛▚▖▐▌  █ ▐▌ ▐▌       
-- ▐▌  ▐▌▐▛▀▀▘▐▌ ▝▜▌  █ ▐▛▀▜▌ 
--  ▝▚▞▘ ▐▙▄▄▖▐▌  ▐▌  █ ▐▌ ▐▌ 


-- ▗▄▄▄▖ ▗▄▄▖▗▄▄▄▖▗▄▖     ▗▖  ▗▖▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖ 
-- ▐▌   ▐▌     █ ▐▌ ▐▌    ▐▌  ▐▌▐▌   ▐▛▚▖▐▌  █   
-- ▐▛▀▀▘ ▝▀▚▖  █ ▐▛▀▜▌    ▐▌  ▐▌▐▛▀▀▘▐▌ ▝▜▌  █  
-- ▐▙▄▄▖▗▄▄▞▘  █ ▐▌ ▐▌     ▝▚▞▘ ▐▙▄▄▖▐▌  ▐▌  █      


-- ▗▄▄▄▖ ▗▄▄▖▗▄▄▄▖▗▄▖     ▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖▗▖  ▗▖  
-- ▐▌   ▐▌     █ ▐▌ ▐▌    ▐▌   ▐▌  ▐▌▐▌   ▐▛▚▖▐▌  
-- ▐▛▀▀▘ ▝▀▚▖  █ ▐▛▀▜▌    ▐▛▀▀▘▐▌  ▐▌▐▛▀▀▘▐▌ ▝▜▌   
-- ▐▙▄▄▖▗▄▄▞▘  █ ▐▌ ▐▌    ▐▙▄▄▖ ▝▚▞▘ ▐▙▄▄▖▐▌  ▐▌   


--  ▗▄▄▖▗▄▄▄▖▗▄▄▖ ▗▖  ▗▖     ▗▄▄▖ ▗▄▖ ▗▄▄▖  ▗▄▖   
-- ▐▌   ▐▌   ▐▌ ▐▌▐▌  ▐▌    ▐▌   ▐▌ ▐▌▐▌ ▐▌▐▌ ▐▌  
-- ▐▌   ▐▛▀▀▘▐▛▀▚▖▐▌  ▐▌    ▐▌   ▐▛▀▜▌▐▛▀▚▖▐▛▀▜▌  
-- ▝▚▄▄▖▐▙▄▄▖▐▌ ▐▌ ▝▚▞▘     ▝▚▄▄▖▐▌ ▐▌▐▌ ▐▌▐▌ ▐▌  

INSERT INTO CERV_CARA (fk_caracteristica, fk_cerveza, descripcion) VALUES
(1, 1, 'Amargor bajo y refrescante, típico de una pilsen ligera.'),
(2, 5, 'Aroma intenso a lúpulos cítricos y tropicales, distintivo de una IPA.'),
(3, 7, 'Cuerpo robusto y cremoso, característico de una Porter.'),
(4, 4, 'Notas herbales y ligeramente afrutadas, sutiles en esta lager verde.'),
(5, 8, 'Final limpio y seco, que realza la potabilidad de la lager.'),
(6, 6, 'Color café oscuro con destellos rojizos, clásico de una Trakata.'),
(7, 2, 'Burbuja fina y efervescente, que aporta ligereza a la cerveza light.'),
(8, 3, 'Sabor balanceado entre el dulzor de la malta y un ligero amargor, propio de Zulia.'),
(9, 9, 'Carbonatación media que resalta los perfiles frutales de la Pale Ale.'),
(10, 10, 'Espuma persistente y cremosa, que corona perfectamente esta cerveza de maíz.');


-- ▗▄▄▄▖▗▖  ▗▖▗▖  ▗▖▗▄▄▄▖    ▗▄▄▄▖▗▄▄▄▖▗▄▄▄▖▗▖  ▗▖  
--   █  ▐▛▚▖▐▌▐▌  ▐▌▐▌         █    █  ▐▌   ▐▛▚▖▐▌  
--   █  ▐▌ ▝▜▌▐▌  ▐▌▐▛▀▀▘      █    █  ▐▛▀▀▘▐▌ ▝▜▌  
-- ▗▄█▄▖▐▌  ▐▌ ▝▚▞▘ ▐▙▄▄▖      █  ▗▄█▄▖▐▙▄▄▖▐▌  ▐▌    


-- ▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖▗▖  ▗▖    ▗▄▄▖ ▗▄▄▖  ▗▄▖ ▗▖  ▗▖ 
-- ▐▌   ▐▌  ▐▌▐▌   ▐▛▚▖▐▌    ▐▌ ▐▌▐▌ ▐▌▐▌ ▐▌▐▌  ▐▌ 
-- ▐▛▀▀▘▐▌  ▐▌▐▛▀▀▘▐▌ ▝▜▌    ▐▛▀▘ ▐▛▀▚▖▐▌ ▐▌▐▌  ▐▌  
-- ▐▙▄▄▖ ▝▚▞▘ ▐▙▄▄▖▐▌  ▐▌    ▐▌   ▐▌ ▐▌▝▚▄▞▘ ▝▚▞▘   


-- ▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖▗▖  ▗▖     ▗▄▄▖▗▖   ▗▄▄▄▖▗▄▄▄▖
-- ▐▌   ▐▌  ▐▌▐▌   ▐▛▚▖▐▌    ▐▌   ▐▌     █  ▐▌ 
-- ▐▛▀▀▘▐▌  ▐▌▐▛▀▀▘▐▌ ▝▜▌    ▐▌   ▐▌     █  ▐▛▀▀▘ 
-- ▐▙▄▄▖ ▝▚▞▘ ▐▙▄▄▖▐▌  ▐▌    ▝▚▄▄▖▐▙▄▄▖▗▄█▄▖▐▙▄▄▖       


--  ▗▄▄▖ ▗▄▖ ▗▄▄▖  ▗▄▄▖    ▗▄▄▄▖▗▖  ▗▖▗▄▄▖ ▗▖  
-- ▐▌   ▐▌ ▐▌▐▌ ▐▌▐▌       ▐▌   ▐▛▚▞▜▌▐▌ ▐▌▐▌ 
-- ▐▌   ▐▛▀▜▌▐▛▀▚▖▐▌▝▜▌    ▐▛▀▀▘▐▌  ▐▌▐▛▀▘ ▐▌ 
-- ▝▚▄▄▖▐▌ ▐▌▐▌ ▐▌▝▚▄▞▘    ▐▙▄▄▖▐▌  ▐▌▐▌   ▐▙▄▄▖ 

INSERT INTO CARG_EMPL (fk_empleado, fk_cargo, fecha_inicio, fecha_fin, salario_base) VALUES
(1, 1, '2020-03-01', NULL, 1500.00),
(2, 7, '2018-07-15', NULL, 650.00),
(3, 2, '2020-01-01', NULL, 1200.00),
(4, 4, '2020-09-01', NULL, 850.00),
(5, 6, '2017-06-10', NULL, 600.00),
(6, 9, '2019-02-20', NULL, 950.00),
(7, 8, '2016-11-05', NULL, 1100.00),
(8, 10, '2021-04-12', NULL, 400.00),
(9, 3, '2014-08-25', '2019-12-31', 750.00),
(9, 5, '2020-01-01', NULL, 1300.00);


-- ▗▄▄▄▖▗▖  ▗▖▗▄▄▖ ▗▖       ▗▄▄▖ ▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖
-- ▐▌   ▐▛▚▞▜▌▐▌ ▐▌▐▌       ▐▌ ▐▌▐▌   ▐▛▚▖▐▌▐▌ 
-- ▐▛▀▀▘▐▌  ▐▌▐▛▀▘ ▐▌       ▐▛▀▚▖▐▛▀▀▘▐▌ ▝▜▌▐▛▀▀▘
-- ▐▙▄▄▖▐▌  ▐▌▐▌   ▐▙▄▄▖    ▐▙▄▞▘▐▙▄▄▖▐▌  ▐▌▐▙▄▄▖  

INSERT INTO EMPL_BENE (fk_empleado, fk_cargo, fk_beneficio, monto_beneficio) VALUES
(1, 1, 1, 500.00),
(1, 1, 2, 200.00),
(2, 7, 3, 100.00),
(3, 2, 4, 300.00),
(4, 4, 2, 150.00),
(5, 6, 3, 80.00),
(6, 9, 1, 250.00),
(7, 8, 4, 200.00),
(8, 10, 3, 50.00),
(9, 5, 2, 180.00);


-- ▗▄▄▄▖▗▖  ▗▖▗▖  ▗▖▗▄▄▄▖    ▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖▗▖  ▗▖ 
--   █  ▐▛▚▖▐▌▐▌  ▐▌▐▌       ▐▌   ▐▌  ▐▌▐▌   ▐▛▚▖▐▌ 
--   █  ▐▌ ▝▜▌▐▌  ▐▌▐▛▀▀▘    ▐▛▀▀▘▐▌  ▐▌▐▛▀▀▘▐▌ ▝▜▌ 
-- ▗▄█▄▖▐▌  ▐▌ ▝▚▞▘ ▐▙▄▄▖    ▐▙▄▄▖ ▝▚▞▘ ▐▙▄▄▖▐▌  ▐▌  


-- ▗▄▄▖ ▗▖ ▗▖▗▖  ▗▖▗▄▄▄▖     ▗▄▄▖▗▖   ▗▄▄▄▖▗▄▄▄▖
-- ▐▌ ▐▌▐▌ ▐▌▐▛▚▖▐▌  █      ▐▌   ▐▌     █  ▐▌ 
-- ▐▛▀▘ ▐▌ ▐▌▐▌ ▝▜▌  █      ▐▌   ▐▌     █  ▐▛▀▀▘ 
-- ▐▌   ▝▚▄▞▘▐▌  ▐▌  █      ▝▚▄▄▖▐▙▄▄▖▗▄█▄▖▐▙▄▄▖

INSERT INTO PUNT_CLIE (fk_punto, fk_cliente, fk_tasa_cambio, cantidad_puntos) VALUES
(1, 1, 1, 100),  
(2, 2, 2, 150),   
(3, 3, 3, 200),   
(4, 4, 4, 50),    
(5, 5, 5, 250),   
(6, 6, 6, 120),   
(7, 7, 7, 180),  
(8, 8, 8, 75),    
(9, 9, 9, 300),   
(10, 10, 10, 90);


-- ▗▄▄▖  ▗▄▖  ▗▄▄▖ ▗▄▖  
-- ▐▌ ▐▌▐▌ ▐▌▐▌   ▐▌ ▐▌
-- ▐▛▀▘ ▐▛▀▜▌▐▌▝▜▌▐▌ ▐▌
-- ▐▌   ▐▌ ▐▌▝▚▄▞▘▝▚▄▞▘


--    ▗▖▗▖ ▗▖▗▄▄▄▖▗▄▄▄▄▖ 
--    ▐▌▐▌ ▐▌▐▌      ▗▞▘ 
--    ▐▌▐▌ ▐▌▐▛▀▀▘ ▗▞▘ 
-- ▗▄▄▞▘▝▚▄▞▘▐▙▄▄▖▐▙▄▄▄▖  

INSERT INTO JUEZ (nombre, apellido) VALUES
('Ana', 'García'),
('Roberto', 'López'),
('Sofía', 'Martínez'),
('Diego', 'Ramírez'),
('Laura', 'Hernández'),
('Carlos', 'Sánchez'),
('Elena', 'González'),
('Pedro', 'Díaz'),
('María', 'Torres'),
('Andrés', 'Ruiz');


--    ▗▖▗▖ ▗▖▗▄▄▄▖▗▄▄▄▄▖    ▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖ 
--    ▐▌▐▌ ▐▌▐▌      ▗▞▘    ▐▌   ▐▌  ▐▌▐▌   ▐▛▚▖▐▌  █  
--    ▐▌▐▌ ▐▌▐▛▀▀▘ ▗▞▘      ▐▛▀▀▘▐▌  ▐▌▐▛▀▀▘▐▌ ▝▜▌  █ 
-- ▗▄▄▞▘▝▚▄▞▘▐▙▄▄▖▐▙▄▄▄▖    ▐▙▄▄▖ ▝▚▞▘ ▐▙▄▄▖▐▌  ▐▌  █ 


-- ▗▄▄▄  ▗▄▄▄▖▗▄▄▄▖▗▄▖ ▗▖   ▗▖   ▗▄▄▄▖    ▗▄▄▄▖ ▗▄▖  ▗▄▄▖▗▄▄▄▖▗▖ ▗▖▗▄▄▖  ▗▄▖ 
-- ▐▌  █ ▐▌     █ ▐▌ ▐▌▐▌   ▐▌   ▐▌       ▐▌   ▐▌ ▐▌▐▌     █  ▐▌ ▐▌▐▌ ▐▌▐▌ ▐▌
-- ▐▌  █ ▐▛▀▀▘  █ ▐▛▀▜▌▐▌   ▐▌   ▐▛▀▀▘    ▐▛▀▀▘▐▛▀▜▌▐▌     █  ▐▌ ▐▌▐▛▀▚▖▐▛▀▜▌
-- ▐▙▄▄▀ ▐▙▄▄▖  █ ▐▌ ▐▌▐▙▄▄▖▐▙▄▄▖▐▙▄▄▖    ▐▌   ▐▌ ▐▌▝▚▄▄▖  █  ▝▚▄▞▘▐▌ ▐▌▐▌ ▐▌

INSERT INTO DETALLE_FACTURA (cantidad, precio_unitario, fk_venta, fk_cerveza, fk_presentacion) VALUES
(2, 50.00, 1, 1, 2),
(1, 100.50, 1, 2, 4),
(3, 40.00, 2, 3, 1),
(1, 180.00, 2, 4, 5),
(2, 60.00, 3, 5, 2),
(1, 200.00, 3, 6, 4),
(4, 30.00, 4, 7, 1),
(1, 150.00, 4, 8, 5),
(2, 70.00, 5, 9, 2),
(1, 90.00, 5, 10, 4);


-- ▗▄▄▖  ▗▄▖  ▗▄▄▖ ▗▄▖      ▗▄▖ ▗▄▄▄▖▗▄▄▄▖▗▖   ▗▄▄▄▖ ▗▄▖  ▗▄▄▖▗▄▄▄▖ ▗▄▖ ▗▖  ▗▖
-- ▐▌ ▐▌▐▌ ▐▌▐▌   ▐▌ ▐▌    ▐▌ ▐▌▐▌     █  ▐▌     █  ▐▌ ▐▌▐▌     █  ▐▌ ▐▌▐▛▚▖▐▌
-- ▐▛▀▘ ▐▛▀▜▌▐▌▝▜▌▐▌ ▐▌    ▐▛▀▜▌▐▛▀▀▘  █  ▐▌     █  ▐▛▀▜▌▐▌     █  ▐▌ ▐▌▐▌ ▝▜▌
-- ▐▌   ▐▌ ▐▌▝▚▄▞▘▝▚▄▞▘    ▐▌ ▐▌▐▌   ▗▄█▄▖▐▙▄▄▖▗▄█▄▖▐▌ ▐▌▝▚▄▄▖▗▄█▄▖▝▚▄▞▘▐▌  ▐▌ 

INSERT INTO PAGO_AFILIACION (fecha, total, mes_pagado, fk_afiliacion, fk_metodo_pago, fk_tasa_cambio) VALUES
('2024-01-01', 50.00, '2024-01-01', 1, 1, 1),
('2024-02-01', 50.00, '2024-02-01', 1, 1, 2),
('2024-03-01', 50.00, '2024-03-01', 1, 1, 3),
('2024-02-15', 30.00, '2024-02-01', 2, 3, 2),
('2024-03-15', 30.00, '2024-03-01', 2, 3, 3),
('2023-11-01', 50.00, '2023-11-01', 3, 1, 1),
('2023-12-01', 50.00, '2023-12-01', 3, 1, 1),
('2024-04-10', 50.00, '2024-04-01', 5, 1, 4),
('2024-05-01', 50.00, '2024-05-01', 7, 1, 5),
('2024-06-01', 30.00, '2024-06-01', 8, 3, 6);

-- ▗▖  ▗▖ ▗▄▖  ▗▄▄▖ ▗▄▖  ▗▄▄▖▗▄▄▄▖ ▗▄▖ ▗▖  ▗▖ 
-- ▐▌  ▐▌▐▌ ▐▌▐▌   ▐▌ ▐▌▐▌     █  ▐▌ ▐▌▐▛▚▖▐▌
-- ▐▌  ▐▌▐▛▀▜▌▐▌   ▐▛▀▜▌▐▌     █  ▐▌ ▐▌▐▌ ▝▜▌
--  ▝▚▞▘ ▐▌ ▐▌▝▚▄▄▖▐▌ ▐▌▝▚▄▄▖▗▄█▄▖▝▚▄▞▘▐▌  ▐▌ 

INSERT INTO VACACION (fecha_inicio, fecha_fin, fk_cargo, fk_empleado) VALUES
('2024-07-01', '2024-07-15', 1, 1),
('2024-08-01', '2024-08-10', 7, 2),
('2024-09-01', '2024-09-20', 2, 3),
('2024-10-01', '2024-10-07', 4, 4),
('2024-11-01', '2024-11-14', 6, 5),
('2024-12-01', '2024-12-05', 9, 6),
('2025-01-05', '2025-01-19', 8, 7),
('2025-02-01', '2025-02-07', 10, 8),
('2025-03-01', '2025-03-10', 3, 9),
('2025-04-01', '2025-04-15', 5, 10);