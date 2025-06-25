
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

-- BEGIN TRIGGER --

CREATE OR REPLACE FUNCTION set_status_compra_to_default()
    RETURNS TRIGGER
    AS $$
BEGIN
    INSERT INTO ESTA_COMP (fk_compra, fk_estatus, fecha_inicio)
        VALUES(NEW.eid, 1, CURRENT_DATE);
    RETURN NEW;
END
$$
LANGUAGE plpgsql;

-- END TRIGGER --

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
('Receta de Belgian Specialty ale', 'Cerveza belga con especias y sabores únicos.'),
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
(10, 10, 1);

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

-- TODO:
INSERT INTO ROL (nombre, descripcion) VALUES
('Administrador del Sistema', 'Acceso completo a la configuración del sistema, gestión de usuarios, productos y reportes.'),
('Cliente Registrado', 'Usuario con cuenta que puede realizar pedidos, ver historial de compras y gestionar su perfil.');
('Gerente de Ventas', 'Supervisa el equipo de ventas, analiza el rendimiento y establece estrategias comerciales.'),
('Soporte Técnico', 'Proporciona asistencia a los usuarios con problemas técnicos, dudas sobre el funcionamiento y resolución de incidencias.'),
('Almacenista', 'Gestiona el inventario, realiza el seguimiento de entradas y salidas de productos, y prepara pedidos para envío.'),
('Marketing Digital', 'Desarrolla y ejecuta estrategias de marketing online, incluyendo campañas de email, SEO y redes sociales.'),
('Desarrollador', 'Mantiene y mejora la plataforma tecnológica, implementa nuevas funcionalidades y corrige errores.'),
('Diseñador Gráfico', 'Crea elementos visuales para el sitio web, materiales de marketing y branding del producto.'),
('Analista de Datos', 'Recopila, procesa y analiza datos para identificar tendencias, generar informes y apoyar la toma de decisiones.'),
('Control de Calidad', 'Revisa productos y procesos para asegurar que cumplan con los estándares de calidad establecidos.');

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
('Pagado'),
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
('2025-01-01', '2025-01-15', 55.00, 55.00), 
('2025-01-16', '2025-01-31', 56.20, 56.20), 
('2025-02-01', '2025-02-15', 57.50, 57.50), 
('2025-02-16', '2025-02-28', 58.80, 58.80), 
('2025-03-01', '2025-03-15', 60.10, 60.10), 
('2025-03-16', '2025-03-31', 61.40, 61.40), 
('2025-04-01', '2025-04-15', 62.70, 62.70), 
('2025-04-16', '2025-04-30', 64.00, 64.00), 
('2025-05-01', '2025-05-15', 65.30, 65.30), 
('2025-05-16', '2025-05-31', 66.60, 66.60), 
('2025-06-01', '2025-06-15', 67.90, 67.90),
('2025-06-16', '2025-06-30', 69.20, 69.20);

-- ▗▖   ▗▖ ▗▖ ▗▄▄▖ ▗▄▖ ▗▄▄▖     ▗▄▄▄▖▗▄▄▄▖▗▄▄▄▖▗▖  ▗▖▗▄▄▄   ▗▄▖ 
-- ▐▌   ▐▌ ▐▌▐▌   ▐▌ ▐▌▐▌ ▐▌      █    █  ▐▌   ▐▛▚▖▐▌▐▌  █ ▐▌ ▐▌
-- ▐▌   ▐▌ ▐▌▐▌▝▜▌▐▛▀▜▌▐▛▀▚▖      █    █  ▐▛▀▀▘▐▌ ▝▜▌▐▌  █ ▐▛▀▜▌
-- ▐▙▄▄▖▝▚▄▞▘▝▚▄▞▘▐▌ ▐▌▐▌ ▐▌      █  ▗▄█▄▖▐▙▄▄▖▐▌  ▐▌▐▙▄▄▀ ▐▌ ▐▌

INSERT INTO LUGAR_TIENDA (eid, nombre, tipo, fk_lugar_tienda) VALUES
(1, 'Tienda', 'ALMACEN', NULL),
(2, 'Pasillo A', 'PASILLO', 1),
(3, 'Pasillo B', 'PASILLO', 1),
(4, 'Pasillo C', 'PASILLO', 1),
(5, 'Anaquel A1', 'ANAQUEL', 2),
(6, 'Anaquel A2', 'ANAQUEL', 2), 
(7, 'Anaquel B1', 'ANAQUEL', 3), 
(8, 'Anaquel B2', 'ANAQUEL', 3), 
(9, 'Anaquel C1', 'ANAQUEL', 4), 
(10, 'Anaquel C2', 'ANAQUEL', 4);

-- ▗▖  ▗▖▗▄▄▄▖▗▄▄▄▖▗▄▖ ▗▄▄▄   ▗▄▖     ▗▄▄▖  ▗▄▖  ▗▄▄▖ ▗▄▖       
-- ▐▛▚▞▜▌▐▌     █ ▐▌ ▐▌▐▌  █ ▐▌ ▐▌    ▐▌ ▐▌▐▌ ▐▌▐▌   ▐▌ ▐▌      
-- ▐▌  ▐▌▐▛▀▀▘  █ ▐▌ ▐▌▐▌  █ ▐▌ ▐▌    ▐▛▀▘ ▐▛▀▜▌▐▌▝▜▌▐▌ ▐▌      
-- ▐▌  ▐▌▐▙▄▄▖  █ ▝▚▄▞▘▐▙▄▄▀ ▝▚▄▞▘    ▐▌   ▐▌ ▐▌▝▚▄▞▘▝▚▄▞▘ 

INSERT INTO METODO_PAGO (eid) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20),
(21),
(22),
(23),
(24),
(25),
(26),
(27),
(28),
(29),
(30),
(31),
(32),
(33),
(34),
(35),
(36),
(37),
(38),
(39),
(40);

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

INSERT INTO CLIENTE (rif, direccion, numero_registro, fk_lugar_1) VALUES
('V-10203040-5', 'Av. Principal, Res. Los Apamates, Apto 5B, Caracas', 1001, 1),
('E-20304050-6', 'Calle La Paz, Casa 8, Maracaibo', 1002, 24),
('J-30405060-7', 'Urb. Las Mercedes, Torre C, Piso 10, Valencia', 1003, 7),
('G-40506070-8', 'Carrera 20, Edif. Blanco, Local 3, Barquisimeto', 1004, 14),
('V-50607080-9', 'Zona Industrial, Galpón 10, Puerto Ordaz', 1005, 10),
('E-60708090-0', 'Calle Real, Quinta Los Girasoles, Mérida', 1006, 15),
('J-70809010-1', 'Av. Atlántico, CC. El Faro, Local 20, Porlamar', 1800, 18),
('G-80901020-2', 'Sector El Carmen, Calle 5, Maturín', 1008, 17),
('V-90102030-3', 'Plaza Bolívar, Edif. Azul, Oficina 7, San Felipe', 1009, 23),
('E-01020304-4', 'Av. Las Delicias, Local 15, Ciudad Ojeda', 1010, 24),
('J-11223344-5', 'Av. Rómulo Gallegos, Edif. Este, Piso 3, Caracas', 1011, 1),
('G-22334455-6', 'Calle Miranda, Local 7, Puerto La Cruz', 1012, 2),
('J-33445566-7', 'Zona Industrial Sur, Galpón 5, Valencia', 1013, 7),
('G-44556677-8', 'Carrera 23, Esquina Calle 30, Barquisimeto', 1014, 14),
('J-55667788-9', 'Av. Las Américas, CC. El Dorado, Local 12, Mérida', 1015, 15),
('G-66778899-0', 'Calle Bolívar, Sector Centro, San Cristóbal', 1016, 21),
('J-77889900-1', 'Av. Principal, Urb. La Granja, Maracay', 1017, 4),
('G-88990011-2', 'Vía La Costa, Urb. Las Aves, La Guaira', 1018, 13),
('J-99001122-3', 'Calle Comercio, Centro, Maturín', 1019, 17),
('G-00112233-4', 'Av. 22, Sector Belloso, Maracaibo', 1020, 24),
('V-00112233-4', 'Calle 5, Urb. Los Robles, Apto 1A, Caracas', 1021, 1),
('E-00223344-5', 'Av. 2, Sector Milagro Norte, Maracaibo', 1022, 24),
('J-00334455-6', 'Urb. Guaparo, Res. El Lago, Piso 8, Valencia', 1023, 7),
('G-00445566-7', 'Calle 30, Carrera 25, Local 10, Barquisimeto', 1024, 14),
('V-00556677-8', 'Sector Castillito, Casa 30, Puerto Ordaz', 1025, 10),
('E-00667788-9', 'Av. 3, Urb. Los Sauces, Mérida', 1026, 15),
('J-00778899-0', 'Calle Las Flores, CC. La Casona, Local 5, Porlamar', 1027, 18),
('G-00889900-1', 'Urb. La Viña, Calle Principal, Maturín', 1028, 17),
('V-00990011-2', 'Calle Real, Edif. Centro, Oficina 4, San Felipe', 1029, 23),
('E-01011223-3', 'Av. Venezuela, Urb. Los Olivos, Apto 2B, Caracas', 1030, 1),
('J-01122334-4', 'Carrera 18, Res. El Bosque, Maracay', 1031, 4),
('G-01233445-5', 'Calle Junín, Local 1, Barquisimeto', 1032, 14),
('J-01344556-6', 'Urb. Agua Viva, Casa 7, Cabudare', 1033, 14),
('G-01455667-7', 'Av. Urdaneta, Edif. El Faro, Piso 2, Coro', 1034, 9),
('J-01566778-8', 'Sector El Dique, Calle 1, Cumaná', 1035, 20),
('G-01677889-9', 'Av. Los Próceres, Urb. Don Bosco, San Cristóbal', 1036, 21),
('J-01788990-0', 'Calle Miranda, Edif. Central, Oficina 9, Valera', 1037, 22),
('G-01899001-1', 'Zona Industrial, Galpón 20, Puerto La Cruz', 1038, 2),
('J-01900112-2', 'Av. Intercomunal, CC. Las Naves, Punto Fijo', 1039, 11),
('G-02011223-3', 'Sector Las Garzas, Casa 10, Barinas', 1040, 5);

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
(1, 1, 1, 1111222233334444, '2027-12-31', 'Ana Garcia', 123),
(2, 2, 2, 5555666677778888, '2026-11-30', 'Luis Rodriguez', 456),
(3, 3, 1, 9999888877776666, '2028-06-30', 'Sofia Martinez', 789),
(4, 4, 2, 1234123412341234, '2025-05-31', 'Diego Ramirez', 101),
(5, 5, 1, 4321432143214321, '2029-04-30', 'Laura Hernandez', 202),
(6, 6, 2, 8765876587658765, '2027-03-31', 'Carlos Sanchez', 303),
(7, 7, 1, 1010202030304040, '2026-02-28', 'Elena Gonzalez', 404),
(8, 8, 2, 5050606070708080, '2028-01-31', 'Pedro Diaz', 505),
(9, 9, 1, 9090808070706060, '2025-10-31', 'Maria Torres', 606),
(10, 10, 2, 1122334455667788, '2029-09-30', 'Andres Ruiz', 707);

--  ▗▄▄▖▗▖ ▗▖▗▄▄▄▖▗▄▄▄▖ ▗▖ ▗▖▗▄▄▄▖ 
-- ▐▌   ▐▌ ▐▌▐▌   ▐▌ ▐▌ ▐▌ ▐▌▐▌
-- ▐▌   ▐▛▀▜▌▐▛▀▀▘▐▌ ▐▌ ▐▌ ▐▌▐▛▀▀▘
-- ▝▚▄▄▖▐▌ ▐▌▐▙▄▄▖▐▙▄▟▙▖▝▚▄▞▘▐▙▄▄▖ 

INSERT INTO CHEQUE (fk_metodo_pago, numero, fk_banco, memo) VALUES
(11, 1001, 1, 'Pago a proveedor de malta'),
(12, 1002, 2, 'Alquiler de local comercial'),
(13, 1003, 3, 'Servicios de publicidad'),
(14, 1004, 4, 'Compra de equipos de producción'),
(15, 1005, 5, 'Reembolso a cliente por devolución'),
(16, 1006, 6, 'Pago de nómina semanal'),
(17, 1007, 7, 'Mantenimiento de infraestructura'),
(18, 1008, 8, 'Adquisición de lúpulo especial'),
(19, 1009, 9, 'Bonificación a empleados'),
(20, 1010, 10, 'Factura de servicios básicos');


-- ▗▄▄▄▖▗▄▄▄▖▗▄▄▄▖ ▗▄▄▖▗▄▄▄▖▗▄▄▄▖▗▖  ▗▖ ▗▄▖
-- ▐▌   ▐▌   ▐▌   ▐▌     █    █  ▐▌  ▐▌▐▌ ▐▌
-- ▐▛▀▀▘▐▛▀▀▘▐▛▀▀▘▐▌     █    █  ▐▌  ▐▌▐▌ ▐▌
-- ▐▙▄▄▖▐▌   ▐▙▄▄▖▝▚▄▄▖  █  ▗▄█▄▖ ▝▚▞▘ ▝▚▄▞▘

INSERT INTO EFECTIVO (fk_metodo_pago, denominacion, tipo_moneda) VALUES
(21, 100, 'Bolívares'),
(22, 50, 'Dólares'),
(23, 1, 'Bolívares'),
(24, 20, 'Dólares'),
(25, 5, 'Bolívares'),
(26, 10, 'Dólares'),
(27, 2, 'Bolívares'),
(28, 100, 'Dólares'),
(29, 500, 'Bolívares'),
(30, 5, 'Dólares');

-- ▗▄▄▖ ▗▖ ▗▖▗▖  ▗▖▗▄▄▄▖▗▄▖
-- ▐▌ ▐▌▐▌ ▐▌▐▛▚▖▐▌  █ ▐▌ ▐▌ 
-- ▐▛▀▘ ▐▌ ▐▌▐▌ ▝▜▌  █ ▐▌ ▐▌ 
-- ▐▌   ▝▚▄▞▘▐▌  ▐▌  █ ▝▚▄▞▘

INSERT INTO PUNTO (fk_metodo_pago) VALUES
(31),
(32),
(33),
(34),
(35),
(36),
(37),
(38),
(39),
(40);

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

INSERT INTO COMPRA (fecha, monto_total, fk_proveedor) VALUES
('2024-01-10', 1500.00, 1),
('2024-01-15', 750.50, 2),
('2024-01-20', 2300.75, 3),
('2024-01-25', 500.00, 4),
('2024-02-01', 1200.00, 5),
('2024-02-05', 900.25, 6),
('2024-02-10', 3100.00, 7),
('2024-02-15', 620.50, 8),
('2024-02-20', 1800.00, 9),
('2024-02-25', 450.75, 10);


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
(11, 'V-10112233', 'Roberto', 'Vargas', '1979-08-01'),
(12, 'V-10223344', 'Camila', 'Silva', '1991-04-19'),
(13, 'V-10334455', 'Fernando', 'Peña', '1984-11-05'),
(14, 'V-10445566', 'Valeria', 'Reyes', '1996-02-14'),
(15, 'V-10556677', 'Gabriel', 'Castro', '1982-07-28'),
(16, 'V-10667788', 'Victoria', 'Medina', '1994-09-03'),
(17, 'V-10778899', 'Ricardo', 'Navas', '1989-01-11'),
(18, 'V-10889900', 'Paula', 'Moreno', '1997-05-20'),
(19, 'V-10990011', 'Jorge', 'Herrera', '1981-12-07'),
(20, 'V-11001122', 'Daniela', 'Soto', '1993-06-25');


-- ▗▄▄▖ ▗▖▗▖ ▗▖▗▄▄▖ ▗▖ ▗▖▗▄▄▄  ▗▄▄▄▖ ▗▄▄▖ ▗▄▖    
-- ▐▌ ▐▌▐▌▐▌ ▐▌▐▌ ▐▌▐▌ ▐▌▐▌  █   █  ▐▌   ▐▌ ▐▌   
-- ▐▛▀▘ ▐▌▐▌ ▐▌▐▛▀▚▖▐▌ ▐▌▐▌  █   █  ▐▌   ▐▌ ▐▌   
-- ▐▌▗▄▄▞▘▝▚▄▞▘▐▌ ▐▌▝▚▄▞▘▐▙▄▄▀ ▗▄█▄▖▝▚▄▄▖▝▚▄▞▘   

INSERT INTO PJURIDICO (fk_cliente, denominacion_comercial, razon_social, pagina_web, capital_disponible, fk_lugar_2) VALUES
(21, 'Cervecería Artesanal El Morro', 'Cervezas Artesanales El Morro C.A.', 'http://www.elmorrococuy.com', 500000.00, 2),
(22, 'Distribuidora Oriental de Bebidas', 'Distribuidora Oriental de Bebidas S.A.', NULL, 750000.00, 2),
(23, 'Embotelladora del Centro', 'Embotelladora del Centro C.A.', 'http://www.embocentro.com.ve', 1200000.00, 2),
(24, 'Grupo Cervecero Lara', 'Grupo Cervecero Lara S.R.L.', NULL, 300000.00, 2),
(25, 'Andina de Cervezas', 'Andina de Cervezas G.P.', 'http://www.andinacervezas.com', 800000.00, 2),
(26, 'Empresas Cerveceras del Táchira', 'Empresas Cerveceras del Táchira C.A.', NULL, 600000.00, 2),
(27, 'Fábrica de Malta Aragua', 'Fábrica de Malta Aragua S.A.', 'http://www.maltaragua.com', 900000.00, 2),
(28, 'Importadora La Guaira Bebidas', 'Importadora La Guaira Bebidas C.A.', NULL, 400000.00, 2),
(29, 'Corporación Cervecera Monagas', 'Corporación Cervecera Monagas S.R.L.', 'http://www.cervezasmonagas.net', 1100000.00, 2),
(30, 'Almacenes Zulia Cervezas', 'Almacenes Zulia Cervezas S.A.', NULL, 1500000.00, 2),
(31, 'Importadora del Centro C.A.', 'Importaciones del Centro S.A.', NULL, 650000.00, 2),
(32, 'Servicios Logísticos Barquisimeto', 'Servicios Logísticos Barquisimeto R.L.', 'http://www.logisticabqto.com', 400000.00, 2),
(33, 'Cervezas Artesanales Cabudare', 'Cervezas Artesanales Cabudare C.A.', 'http://www.cabudarebrew.com', 950000.00, 2),
(34, 'Envases y Embalajes Coro', 'Envases y Embalajes Coro S.A.', NULL, 280000.00, 2),
(35, 'Distribuidores Cumaná Global', 'Distribuidores Cumaná Global C.A.', 'http://www.distribuidorascumana.com', 720000.00, 2),
(36, 'Productos Gourmet Táchira', 'Productos Gourmet Táchira S.R.L.', NULL, 550000.00, 2),
(37, 'Tecnología Cervecera Valera', 'Tecnología Cervecera Valera S.A.', 'http://www.tecvalera.com', 1000000.00, 2),
(38, 'Insumos Industriales Anzoátegui', 'Insumos Industriales Anzoátegui C.A.', NULL, 480000.00, 2),
(39, 'Suministros Costa Oriental', 'Suministros Costa Oriental S.A.', 'http://www.suministroscosta.net', 880000.00, 2),
(40, 'Agroindustrias Barinas', 'Agroindustrias Barinas C.A.', NULL, 700000.00, 2);

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


INSERT INTO EMPL_HORA (fk_empleado, fk_horario, asistencia, fecha, hora_entrada, hora_salida) VALUES
(1, 1, 1, '2025-06-24', '09:03:00', '17:10:00'),
(2, 2, 1, '2025-06-24', '09:15:00', '17:05:00'),
(3, 3, 0, '2025-06-24', NULL, NULL),
(4, 4, 1, '2025-06-24', '08:55:00', '17:20:00'),
(5, 5, 1, '2025-06-24', '09:10:00', '17:30:00'),
(6, 6, 1, '2025-06-24', '10:05:00', '14:10:00'),
(7, 7, 0, '2025-06-24', NULL, NULL),
(8, 8, 1, '2025-06-24', '08:50:00', '16:15:00'),
(9, 9, 1, '2025-06-24', '10:00:00', '18:05:00'),
(10, 10, 1, '2025-06-24', '12:10:00', '20:00:00'),
(7, 3, 1, '2025-06-25', '08:30:00', '16:45:00'),
(1, 9, 0, '2025-06-25', NULL, NULL),
(10, 5, 1, '2025-06-25', '09:00:00', '17:00:00'),
(4, 2, 1, '2025-06-25', '09:10:00', '17:30:00'),
(8, 7, 0, '2025-06-25', NULL, NULL),
(2, 6, 1, '2025-06-25', '08:55:00', '16:50:00'),
(9, 4, 1, '2025-06-25', '10:00:00', '18:00:00'),
(5, 1, 0, '2025-06-25', NULL, NULL),
(3, 8, 1, '2025-06-25', '07:45:00', '15:50:00'),
(6, 10, 1, '2025-06-25', '11:20:00', '19:15:00'),
(1, 3, 1, '2025-06-25', '09:05:00', '17:10:00'),
(7, 2, 0, '2025-06-25', NULL, NULL);




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
('Juan', 'Martínez',   2,    NULL, 1), 
('María', 'Fernández', NULL, 1,    2), 
('Pedro', 'González',  2,    NULL, 3), 
('Ana', 'Díaz',        NULL, 2,    4), 
('Luis', 'Ramírez',    3,    NULL, 5), 
('Sofía', 'Castro',    NULL, 3,    6), 
('José', 'Torres',     4,    NULL, 7), 
('Laura', 'Vargas',    NULL, 4,    8), 
('Carlos', 'Sánchez',  5,    NULL, 9), 
('Elena', 'Ruiz',      NULL, 5,    10);


-- ▗▄▄▄▖▗▄▄▄▖▗▄▄▖  ▗▄▖      ▗▄▄▖▗▄▄▄▖▗▄▄▖ ▗▖  ▗▖▗▄▄▄▖▗▄▄▄▄▖ ▗▄▖  
--   █    █  ▐▌ ▐▌▐▌ ▐▌    ▐▌   ▐▌   ▐▌ ▐▌▐▌  ▐▌▐▌      ▗▞▘▐▌ ▐▌   
--   █    █  ▐▛▀▘ ▐▌ ▐▌    ▐▌   ▐▛▀▀▘▐▛▀▚▖▐▌  ▐▌▐▛▀▀▘ ▗▞▘  ▐▛▀▜▌ 
--   █  ▗▄█▄▖▐▌   ▝▚▄▞▘    ▝▚▄▄▖▐▙▄▄▖▐▌ ▐▌ ▝▚▞▘ ▐▙▄▄▖▐▙▄▄▄▖▐▌ ▐▌  

INSERT INTO TIPO_CERVEZA (eid, nombre, fk_tipo_cerveza, fk_receta) VALUES
(1, 'Ale', NULL, 1),
(2, 'Lager', NULL, 2),
(3, 'Cervezas de trigo', NULL, 3),
(4, 'Sour', NULL, 4),
(5, 'Witbier', NULL, 5),
(6, 'Spice, Herb o Vegetable Beer', NULL, 6);

INSERT INTO TIPO_CERVEZA (eid, nombre, fk_tipo_cerveza, fk_receta) VALUES
(7, 'Pale', 1, 7),
(8, 'Brown', 1, 8),
(9, 'Red', 1, 9),
(10, 'Amber', 1, 10),
(11, 'Pumpkin', 1, 11),
(12, 'Golden', 1, 12),
(13, 'Blond', 1, 13),
(14, 'Stout', 1, 14),
(15, 'IPA', 1, 15),
(16, 'ESB', 1, 16),
(17, 'Porter', 1, 17),
(18, 'Barley Wine', 1, 18),
(19, 'English Bitter', 1, 19),
(20, 'American Amber Ale', 1, 20),
(21, 'American Pale Ale', 1, 21),
(22, 'American IPA', 1, 22),
(23, 'Belgian Specialty Ale', 1, 23),
(24, 'Cerveza de Abadía', 1, 24),
(25, 'Trapense', 1, 25),
(26, 'Ámbar', 1, 26),
(27, 'Flamenca', 1, 27),
(28, 'Belgian Barleywine', 1, 28),
(29, 'Trappist Quadrupel', 1, 29),
(30, 'Belgian Spiced Christmas Beer', 1, 30),
(31, 'Belgian Stout', 1, 31),
(32, 'Belgian IPA', 1, 32),
(33, 'Blond Trappist Table Beer', 1, 33),
(34, 'Artisanal Blond', 1, 34),
(35, 'Artisanal Amber', 1, 35),
(36, 'Artisanal Brown', 1, 36),
(37, 'Flanders Red/Brown con frutas', 1, 37),
(38, 'Pilsner', 2, 38),
(39, 'Spezial', 2, 39),
(40, 'Dortmunster', 2, 40),
(41, 'Schwarzbier', 2, 41),
(42, 'Vienna', 2, 42),
(43, 'Bock', 2, 43),
(44, 'Hefeweizen', 3, 44),
(45, 'Weisse Beer', 3, 45),
(46, 'Weizen-Weissbier', 3, 46);

INSERT INTO TIPO_CERVEZA (eid, nombre, fk_tipo_cerveza, fk_receta) VALUES
(47, 'Imperial Stout', 14, 47),
(48, 'Chocolate', 14, 48),
(49, 'Coffee', 14, 49),
(50, 'Milk Stout', 14, 50),
(51, 'Sweet Stout', 14, 51),
(52, 'Eisbock', 43, 52),
(53, 'Strong Saison', 23, 53),
(54, 'Dark Saison', 23, 54);


--  ▗▄▄▖▗▄▄▄▖▗▄▄▖ ▗▖  ▗▖▗▄▄▄▖▗▄▄▄▄▖ ▗▄▖  
-- ▐▌   ▐▌   ▐▌ ▐▌▐▌  ▐▌▐▌      ▗▞▘▐▌ ▐▌   
-- ▐▌   ▐▛▀▀▘▐▛▀▚▖▐▌  ▐▌▐▛▀▀▘ ▗▞▘  ▐▛▀▜▌   
-- ▝▚▄▄▖▐▙▄▄▖▐▌ ▐▌ ▝▚▞▘ ▐▙▄▄▖▐▙▄▄▄▖▐▌ ▐▌ 

INSERT INTO CERVEZA (nombre, descripcion, historia, fk_tipo_cerveza, fk_proveedor, fk_lugar) VALUES
('Golden Ale Sol', 'Cerveza dorada y refrescante con notas sutiles de malta y final limpio.', 'Inspirada en el sol de verano, creada para ser ligera y fácil de beber en cualquier ocasión.', 1, 1, 200), 
('Stout Nocturna', 'Cerveza oscura e intensa con sabores a café tostado y chocolate amargo.', 'Elaborada para las noches caraqueñas, buscando capturar la profundidad y el misterio.', 4, 2, 201), 
('IPA Tropical', 'India Pale Ale con perfil aromático intenso a frutas tropicales (mango, maracuyá) y amargor pronunciado.', 'Tributo a la riqueza frutal del trópico venezolano, una explosión de sabor.', 3, 3, 202), 
('Witbier de Trigo', 'Cerveza belga de trigo, ligera y turbia, con toques de cilantro y cáscara de naranja.', 'Con raíces belgas, adaptada al clima local para una opción ligera y especiada.', 6, 5, 203), 
('Lager Clásica', 'Lager pálida y crujiente de fermentación baja, sabor equilibrado y refrescante.', 'Busca replicar la pureza y sencillez de las cervezas tradicionales europeas.', 2, 5, 204),
('Porter Robusta', 'Cerveza oscura con notas de caramelo, toffee y ligero ahumado, de cuerpo medio a completo.', 'Reinventada para el paladar local, ofreciendo calidez y complejidad.', 5, 6, 205), 
('Saison Campestre', 'Cerveza rústica de granja, alta carbonatación, notas frutales y final seco.', 'Evoca los sabores del campo y la frescura de la naturaleza.', 9, 2, 206), 
('Scotch Ale Fuerte', 'Cerveza ámbar-rojiza, maltosa, con un dulzor inicial pronunciado y cuerpo robusto.', 'Inspirada en las cervezas escocesas, para amantes de sabores intensos.', 1, 8, 207), 
('Sour Frambuesa', 'Cerveza ácida y frutal, con intenso sabor a frambuesas frescas y final vibrante.', 'Innovación audaz, equilibrio entre acidez y dulzura, para paladares aventureros.', 8, 2, 208), 
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
(1, 2, 3.50),
(1, 3, 3.75), 
(1, 6, 3.75), 
(1, 7, 3.75), 
(2, 2, 4.80), 
(2, 3, 4.80), 
(2, 7, 4.80), 
(2, 4, 5.20), 
(2, 5, 5.20), 
(3, 1, 4.00),
(3, 3, 1.00), 
(3, 4, 1.00), 
(3, 7, 2.00), 
(4, 1, 8.50),
(4, 2, 8.50),
(4, 4, 8.50),
(4, 5, 8.50),
(5, 1, 2.99),
(5, 2, 2.99),
(5, 3, 2.99),
(5, 6, 2.99),
(6, 2, 4.50),
(6, 3, 4.50),
(6, 5, 4.50),
(6, 7, 4.50),
(7, 1, 18.00),
(7, 2, 18.00),
(7, 5, 18.00),
(7, 7, 18.00),
(7, 8, 18.00),
(8, 3, 18.00),
(8, 5, 18.00),
(8, 9, 18.00),
(8, 10, 18.00),
(9, 2, 9.00),
(9, 4, 9.00),
(9, 6, 9.00),
(9, 10, 9.00),
(10, 1, 20.00),
(10, 3, 20.00),
(10, 8, 20.00);

-- ▗▄▄▄  ▗▄▄▄▖▗▄▄▄▖▗▄▖ ▗▖   ▗▖   ▗▄▄▄▖     ▗▄▄▖ ▗▄▖ ▗▖  ▗▖▗▄▄▖ ▗▄▄▖  ▗▄▖               
-- ▐▌  █ ▐▌     █ ▐▌ ▐▌▐▌   ▐▌   ▐▌       ▐▌   ▐▌ ▐▌▐▛▚▞▜▌▐▌ ▐▌▐▌ ▐▌▐▌ ▐▌              
-- ▐▌  █ ▐▛▀▀▘  █ ▐▛▀▜▌▐▌   ▐▌   ▐▛▀▀▘    ▐▌   ▐▌ ▐▌▐▌  ▐▌▐▛▀▘ ▐▛▀▚▖▐▛▀▜▌              
-- ▐▙▄▄▀ ▐▙▄▄▖  █ ▐▌ ▐▌▐▙▄▄▖▐▙▄▄▖▐▙▄▄▖    ▝▚▄▄▖▝▚▄▞▘▐▌  ▐▌▐▌   ▐▌ ▐▌▐▌ ▐▌     

-- Para compra 1
INSERT INTO DETALLE_COMPRA (cantidad, precio_unitario, fk_compra, fk_cerveza, fk_presentacion) VALUES
(50, 1.50, 1,   1, 1),
(20, 30.00, 1,  1, 3),
(5, 150.00, 1,  2, 2),
(10, 50.00, 1,  2, 4),
(120, 10.00, 1, 3, 1),
(60, 5.00, 1,   3, 7),
(30, 100.00, 1, 4, 5),
(80, 7.50, 1,   5, 3),
(15, 120.00, 1, 6, 2),
(200, 8.00, 1,  7, 8);

-- Para compra 2
INSERT INTO DETALLE_COMPRA (cantidad, precio_unitario, fk_compra, fk_cerveza, fk_presentacion) VALUES
(50, 1.50,   2,   1, 1),
(20, 30.00,  2,  1, 3),
(5, 150.00,  2,  2, 2),
(10, 50.00,  2,  2, 4),
(120, 10.00, 2, 3, 1),
(60, 5.00,   2,   3, 7),
(30, 100.00, 2, 4, 5),
(80, 7.50,   2,   5, 3),
(15, 120.00, 2, 6, 2),
(200, 8.00,  2,  7, 8);

-- Para compras 3-10
INSERT INTO DETALLE_COMPRA (cantidad, precio_unitario, fk_compra, fk_cerveza, fk_presentacion) VALUES
(5, 150.00, 3, 1, 1),
(10, 50.00, 4, 1, 1),
(120, 10.00, 5, 1, 1),
(60, 5.00, 6, 1, 1),
(30, 100.00, 7, 1, 1),
(80, 7.50, 8, 1, 1),
(15, 120.00, 9, 1, 1),
(200, 8.00, 10, 1, 1);

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
(10, 10, 5, '2025-09-05', '2025-09-20'),
(7, 1, 3, '2025-09-10', '2025-09-25'),
(2, 2, 5, '2025-09-15', '2025-09-30'),
(9, 3, 1, '2025-10-01', '2025-10-15'),
(4, 4, 2, '2025-10-05', '2025-10-20'),
(1, 5, 1, '2025-10-10', '2025-10-25'),
(6, 6, 3, '2025-10-15', '2025-10-30'),
(3, 7, 5, '2025-11-01', '2025-11-15'),
(10, 8, 1, '2025-11-05', '2025-11-20'),
(5, 9, 2, '2025-11-10', '2025-11-25'),
(8, 10, 4, '2025-11-15', '2025-11-30'),
(2, 1, 3, '2025-12-01', '2025-12-15'),
(7, 2, 5, '2025-12-05', '2025-12-20'),
(4, 3, 1, '2025-12-10', '2025-12-25'),
(9, 4, 2, '2025-12-15', '2025-12-30'),
(1, 5, 4, '2026-01-01', '2026-01-15');

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

INSERT INTO EVENTO (nombre, descripcion, numero_entradas, fecha_inicio, fecha_fin, direccion, precio_entrada, fk_evento, fk_tipo_evento, fk_lugar) VALUES
('Festival Amazónico de Cervezas', 'Gran celebración de cervezas artesanales locales de la selva.', 500, '2025-07-10', '2025-07-12', 'Plaza Central de Puerto Ayacucho', 15.00, NULL, 1, 1),
('Cata Mística del Orinoco', 'Degustación de cervezas con ingredientes exóticos de la región.', 60, '2025-08-05', '2025-08-05', 'Lodge Ecológico Orinoco', 25.00, NULL, 2, 1),
('Lanzamiento "Espíritu de la Selva Ale"', 'Presentación de una nueva Pale Ale inspirada en la fauna local.', 100, '2025-09-01', '2025-09-01', 'Bar Temático Amazonas', 10.00, NULL, 3, 1),
('Taller de Cerveza Casera Nivel 1', 'Introducción a la elaboración artesanal de cerveza.', 20, '2025-10-20', '2025-10-21', 'Centro Comunitario Ayacucho', 75.00, NULL, 4, 1),
('Concurso "Mejor Lager Tropical"', 'Competición para encontrar la Lager más refrescante de la región.', 40, '2025-11-15', '2025-11-15', 'Salón de Eventos Ayacucho', 8.00, NULL, 5, 1),

('Expo Cerveza Oriental', 'Feria de exposición y venta de cervezas artesanales del oriente.', 800, '2025-07-15', '2025-07-17', 'Centro de Convenciones Lechería', 20.00, NULL, 9, 2),
('Cata y Maridaje Costero', 'Degustación de cervezas maridadas con sabores del Caribe.', 70, '2025-08-10', '2025-08-10', 'Restaurant Vista al Mar, Puerto La Cruz', 30.00, NULL, 2, 2),
('Presentación "Anzoátegui IPA"', 'Lanzamiento de una IPA con lúpulos intensos y notas frutales.', 120, '2025-09-05', '2025-09-05', 'Brewpub El Faro, Barcelona', 12.00, NULL, 3, 2),
('Curso Intensivo de Malteado', 'Profundiza en el proceso de malteado y su impacto en la cerveza.', 25, '2025-10-25', '2025-10-26', 'Campus Universitario UGMA, Anaco', 90.00, NULL, 4, 2),
('Competición de Maestros Cerveceros', 'Desafío de elaboración en vivo entre expertos.', 50, '2025-11-20', '2025-11-20', 'Club de Maestros Cerveceros, El Morro', 10.00, NULL, 5, 2),

('Festival Llanero Cervecero', 'Celebrando la cerveza artesanal con la cultura de los llanos.', 400, '2025-07-20', '2025-07-22', 'Parque Ferial San Fernando', 12.00, NULL, 1, 3),
('Cata de Cervezas Ahumadas', 'Degustación de cervezas con perfiles ahumados inspirados en el llano.', 50, '2025-08-15', '2025-08-15', 'Hacienda El Caney', 20.00, NULL, 2, 3),
('Presentación "Palma Real Lager"', 'Nueva Lager refrescante, perfecta para el clima llanero.', 90, '2025-09-10', '2025-09-10', 'Restaurant La Cabaña, San Fernando', 9.00, NULL, 3, 3),
('Taller de Agua para Cerveceros', 'La importancia del agua en la calidad de la cerveza.', 18, '2025-10-30', '2025-10-31', 'Casa de la Cultura Apure', 85.00, NULL, 4, 3),
('Concurso "Cerveza Tradicional Llanera"', 'Buscando la mejor cerveza que represente el sabor de Apure.', 35, '2025-11-25', '2025-11-25', 'Rancho La Victoria', 7.00, NULL, 5, 3),

('Aragua Beer Weekend', 'Un fin de semana dedicado a la cerveza artesanal en Maracay.', 900, '2025-07-25', '2025-07-27', 'Parque de Ferias de San Jacinto, Maracay', 18.00, NULL, 1, 4),
('Cata de Cervezas Belgas', 'Explorando los complejos estilos belgas y sus adaptaciones locales.', 80, '2025-08-20', '2025-08-20', 'Hotel Hesperia Maracay', 32.00, NULL, 2, 4),
('Lanzamiento "Samán Stout"', 'Presentación de una Stout con toques de café y cacao aragüeño.', 140, '2025-09-15', '2025-09-15', 'Brewpub La Maestranza, Maracay', 11.00, NULL, 3, 4),
('Curso Avanzado de Fermentación', 'Técnicas avanzadas para el control de la fermentación.', 30, '2025-11-05', '2025-11-06', 'Laboratorio Cervecero Aragua', 100.00, NULL, 4, 4),
('Batalla de Cerveceros Artesanales', 'Demostraciones y competencia entre los mejores cerveceros de Aragua.', 60, '2025-11-30', '2025-11-30', 'Espacio Cultural Girardot', 9.00, NULL, 5, 4),

('Festival Cerveza Barinesa', 'Encuentro con las mejores cervezas artesanales de Barinas.', 600, '2025-07-30', '2025-08-01', 'Complejo Ferial Barinas', 14.00, NULL, 1, 5),
('Cata de Cervezas Temporada Seca', 'Degustación de cervezas ligeras y refrescantes para el clima barinés.', 55, '2025-08-25', '2025-08-25', 'Restaurante El Estribo, Barinas', 23.00, NULL, 2, 5),
('Presentación "Cacique IPA Llanera"', 'Nueva IPA con lúpulos criollos y carácter del llano.', 110, '2025-09-20', '2025-09-20', 'Cervecería El Hato, Barinas', 10.00, NULL, 3, 5),
('Taller de Sanidad Cervecera', 'Prácticas de higiene y saneamiento en la producción de cerveza.', 22, '2025-11-10', '2025-11-11', 'Escuela de Agronomía ULL', 95.00, NULL, 4, 5),
('Reto Cervecero del Sur', 'Competición de estilos clásicos entre cerveceros barineses.', 45, '2025-12-05', '2025-12-05', 'Club Campestre Barinas', 8.50, NULL, 5, 5),

('Gran Expo Cervecera Guayana', 'El evento más grande de cerveza artesanal en el sur del país.', 1200, '2025-08-05', '2025-08-07', 'Palacio de Eventos de Guayana, Puerto Ordaz', 22.00, NULL, 9, 6),
('Cata de Cervezas Negras del Sur', 'Explorando las Stouts y Porters de la región minera.', 75, '2025-09-01', '2025-09-01', 'Salón VIP Hotel Venetur, Ciudad Bolívar', 35.00, NULL, 2, 6),
('Lanzamiento "Oro Negro Imperial Stout"', 'Una Stout densa y potente con toques de café local.', 150, '2025-09-25', '2025-09-25', 'Brewpub El Minero, Ciudad Guayana', 13.00, NULL, 3, 6),
('Seminario de Insumos Alternativos', 'Uso de ingredientes no tradicionales en la cerveza artesanal.', 32, '2025-11-15', '2025-11-16', 'Centro de Negocios Altavista, Puerto Ordaz', 110.00, NULL, 4, 6),
('Concurso "Copa Orinoco de Cerveza"', 'Juzgando la calidad y creatividad de las cervezas de Bolívar.', 60, '2025-12-10', '2025-12-10', 'Plaza del Agua, Puerto Ordaz', 10.00, NULL, 5, 6),

('Festival Artesanal Valencia', 'Celebración de la cerveza artesanal y gastronomía carabobeña.', 1000, '2025-08-10', '2025-08-12', 'Parque Fernando Peñalver, Valencia', 20.00, NULL, 1, 7),
('Cata de Cervezas con Frutas Tropicales', 'Degustación de cervezas infusionadas con frutas del estado.', 80, '2025-09-05', '2025-09-05', 'Hacienda La Esmeralda, Naguanagua', 28.00, NULL, 2, 7),
('Presentación "Flor de Naranjo Blonde Ale"', 'Lanzamiento de una Blonde Ale ligera con toques cítricos.', 130, '2025-09-30', '2025-09-30', 'Brewery Garden, San Diego', 10.00, NULL, 3, 7),
('Taller de Diseño de Recetas', 'Crea tus propias recetas de cerveza artesanal desde cero.', 35, '2025-11-20', '2025-11-21', 'Espacio Cultural Valencia', 95.00, NULL, 4, 7),
('Campeonato Regional Cervecero', 'Competencia que premia la excelencia en la elaboración de cerveza.', 70, '2025-12-15', '2025-12-15', 'Complejo Deportivo, San Joaquin', 9.00, NULL, 5, 7),

('Expo Cerveza Cojedeña', 'Muestra y venta de la producción cervecera artesanal local.', 300, '2025-08-15', '2025-08-17', 'Plaza La Fería, San Carlos', 10.00, NULL, 9, 8),
('Cata de Cervezas Refrescantes', 'Degustación de cervezas ideales para el clima de Cojedes.', 40, '2025-09-10', '2025-09-10', 'Hotel Pao, Tinaquillo', 18.00, NULL, 2, 8),
('Lanzamiento "Torbellino IPA"', 'Presentación de una IPA vibrante con carácter.', 80, '2025-10-05', '2025-10-05', 'Bar La Tinaja, San Carlos', 8.00, NULL, 3, 8),
('Taller de Carbonatación y Embotellado', 'Dominando las etapas finales de la elaboración de cerveza.', 15, '2025-11-25', '2025-11-26', 'Centro de Capacitación Agroindustrial', 70.00, NULL, 4, 8),
('Reto Cervecero del Llano Central', 'Concurso de cervezas artesanales del centro del país.', 30, '2025-12-20', '2025-12-20', 'Casa de la Cultura San Carlos', 6.00, NULL, 5, 8),

('Festival Cerveza Warao', 'Celebración de la cerveza artesanal con la cultura indígena local.', 350, '2025-08-20', '2025-08-22', 'Paseo Manamo, Tucupita', 12.00, NULL, 8, 9),
('Cata de Cervezas con Frutas Amazónicas', 'Degustación de cervezas con ingredientes exóticos del Delta.', 45, '2025-09-15', '2025-09-15', 'Hotel Gran Delta, Tucupita', 22.00, NULL, 2, 9),
('Presentación "Moriche Ale"', 'Lanzamiento de una Ale de color ámbar con toques de la región.', 95, '2025-10-10', '2025-10-10', 'Brewpub El Carite, Tucupita', 9.50, NULL, 3, 9),
('Curso de Gestión de Cervecerías Pequeñas', 'Aspectos administrativos y de negocio para cervecerías.', 17, '2025-11-30', '2025-12-01', 'Cámara de Comercio Tucupita', 105.00, NULL, 4, 9),
('Concurso "Sabor del Delta"', 'Buscando la cerveza más representativa del Delta Amacuro.', 30, '2025-12-25', '2025-12-25', 'Mirador del Delta', 7.50, NULL, 5, 9),

('Caracas Craft Beer Festival', 'El evento anual más esperado de cerveza artesanal en Caracas.', 1500, '2025-08-25', '2025-08-27', 'Parque Los Caobos, Caracas', 28.00, NULL, 1, 10),
('Cata Maestra de Imperial Stouts', 'Degustación de las Stouts más potentes y complejas.', 80, '2025-09-20', '2025-09-20', 'Salón Espejos, Hotel Tamanaco, Caracas', 40.00, NULL, 2, 10),
('Lanzamiento "Ávila IPA"', 'Presentación de una IPA audaz, inspirada en la montaña caraqueña.', 200, '2025-10-15', '2025-10-15', 'Terraza Lounge El Ávila, Caracas', 15.00, NULL, 3, 10),
('Seminario de QA en Cervecería', 'Control de calidad y buenas prácticas en la producción de cerveza.', 30, '2025-11-10', '2025-11-11', 'Campus UCAB, Caracas', 120.00, NULL, 4, 10),
('Concurso Nacional de Cerveza Artesanal', 'El certamen más prestigioso para cerveceros de Venezuela.', 100, '2025-12-05', '2025-12-07', 'Centro de Artes La Estancia, Caracas', 12.00, NULL, 5, 10),

('Festival Cerveza de Paraguaná', 'Evento cervecero en la península, con ambiente playero.', 700, '2025-09-01', '2025-09-03', 'Playa El Supí, Punto Fijo', 16.00, NULL, 1, 11),
('Cata de Cervezas con Cítricos', 'Degustación de cervezas con perfiles de naranja, limón y parchita.', 65, '2025-09-25', '2025-09-25', 'Restaurant Marino, Adícora', 26.00, NULL, 2, 11),
('Presentación "Viento de Sal Lager"', 'Nueva Lager refrescante con toques salinos.', 110, '2025-10-20', '2025-10-20', 'Brewpub La Vela, Coro', 10.50, NULL, 3, 11),
('Taller de Cervezas con Adjuntos Locales', 'Uso de ingredientes típicos de Falcón en la elaboración.', 25, '2025-12-10', '2025-12-11', 'Universidad Nacional Experimental Francisco de Miranda, Coro', 90.00, NULL, 4, 11),
('Concurso "Sabor Costero"', 'Competición de cervezas que evocan el ambiente playero.', 40, '2025-12-28', '2025-12-28', 'Club Náutico Punto Fijo', 8.00, NULL, 5, 11),

('Expo Cervecera Llanera', 'Muestra y venta de cervezas artesanales de Guárico y estados vecinos.', 450, '2025-09-05', '2025-09-07', 'Parque Ferial San Juan de los Morros', 12.00, NULL, 9, 12),
('Cata de Cervezas Campesinas', 'Degustación de cervezas con perfiles rústicos y terrosos.', 45, '2025-09-30', '2025-09-30', 'Hato La Esperanza, Valle de la Pascua', 20.00, NULL, 2, 12),
('Lanzamiento "El Morro Pale Ale"', 'Presentación de una Pale Ale balanceada y accesible.', 90, '2025-10-25', '2025-10-25', 'Cervecería Guárico, Ortiz', 9.00, NULL, 3, 12),
('Seminario de Lúpulos y su Uso', 'Explorando las variedades de lúpulo y sus aplicaciones.', 20, '2025-12-15', '2025-12-16', 'Centro de Estudios Llaneros, Calabozo', 80.00, NULL, 4, 12),
('Reto Cervecero "Corazón del Llano"', 'Concurso para la mejor cerveza que capture la esencia guariqueña.', 30, '2026-01-05', '2026-01-05', 'Club de Polo Las Mercedes', 7.00, NULL, 5, 12),

('Festival Sabor Litoral', 'Evento cervecero con vista al mar, lo mejor de La Guaira.', 800, '2025-09-10', '2025-09-12', 'Club Puerto Azul, Naiguatá', 18.00, NULL, 1, 13),
('Cata de Cervezas con Frutos del Mar', 'Maridaje de cervezas con productos marinos frescos.', 70, '2025-10-05', '2025-10-05', 'Restaurant El Canto del Mar, Macuto', 30.00, NULL, 2, 13),
('Presentación "Atardecer Caribeño Ale"', 'Lanzamiento de una Ale dorada y frutal, ideal para el atardecer.', 130, '2025-10-30', '2025-10-30', 'Brewpub La Guaira, Maiquetía', 11.00, NULL, 3, 13),
('Taller de Cervezas Estacionales', 'Elaboración de cervezas adaptadas a cada estación del año.', 28, '2025-12-20', '2025-12-21', 'Centro de Artes Vargas', 95.00, NULL, 4, 13),
('Concurso "Cerveza Costeña del Año"', 'Premiando la mejor cerveza artesanal de la Guaira.', 45, '2026-01-10', '2026-01-10', 'Hotel Marriot Playa Grande', 9.00, NULL, 5, 13),

('Festival Cerveza de los Crepúsculos', 'Celebración de la cerveza artesanal en la tierra del crepúsculo.', 1000, '2025-09-15', '2025-09-17', 'Obelisco de Barquisimeto', 20.00, NULL, 1, 14),
('Cata de Cervezas con Café Larense', 'Degustación de cervezas con adición de café de la región.', 70, '2025-10-10', '2025-10-10', 'Cafetería La Negra, Barquisimeto', 32.00, NULL, 2, 14),
('Lanzamiento "Tocuyo Porter"', 'Presentación de una Porter robusta con toques de chocolate.', 140, '2025-11-05', '2025-11-05', 'Cervecería Artesanal Tocuyo', 12.00, NULL, 3, 14),
('Seminario de Diseño de Etiquetas', 'Crea una identidad visual atractiva para tu cerveza.', 30, '2025-12-25', '2025-12-26', 'Ateneo de Barquisimeto', 105.00, NULL, 4, 14),
('Copa Regional de Cerveza Lara', 'Competición de cervezas artesanales de la región larense.', 50, '2026-01-15', '2026-01-15', 'Arena Ciudad Barquisimeto', 10.00, NULL, 5, 14),

('Festival Cumbres Cerveceras', 'Evento cervecero en el impresionante paisaje andino.', 850, '2025-09-20', '2025-09-22', 'Centro de Convenciones Mucumbarila, Mérida', 18.00, NULL, 1, 15),
('Cata de Cervezas de Altura', 'Degustación de cervezas elaboradas en las montañas de Mérida.', 60, '2025-10-15', '2025-10-15', 'Restaurante Casa Vieja, Mérida', 28.00, NULL, 2, 15),
('Presentación "Nevado Pale Ale"', 'Lanzamiento de una Pale Ale fresca y de cuerpo ligero.', 130, '2025-11-10', '2025-11-10', 'Cervecería Andina, Ejido', 11.00, NULL, 3, 15),
('Taller de Cervezas con Frutos Rojos', 'Uso de moras y fresas andinas en la elaboración de cerveza.', 25, '2026-01-01', '2026-01-02', 'Universidad de Los Andes, Mérida', 90.00, NULL, 4, 15),
('Reto Cervecero Andino', 'Concurso para la mejor cerveza inspirada en la Cordillera.', 45, '2026-01-20', '2026-01-20', 'Estación Barinitas, Teleférico Mukumbarí', 9.00, NULL, 5, 15),

('Miranda Beer Summit', 'Cumbre cervecera en la región mirandina.', 1500, '2025-09-25', '2025-09-27', 'Hacienda La Trinidad Parque Cultural, Caracas', 30.00, NULL, 1, 16),
('Cata de Sours y Lambics', 'Exploración de estilos ácidos y fermentaciones espontáneas.', 90, '2025-10-20', '2025-10-20', 'Salón de Eventos El Hatillo', 38.00, NULL, 2, 16),
('Lanzamiento "Chuao Chocolate Stout"', 'Stout con cacao de Chuao, un verdadero manjar.', 160, '2025-11-15', '2025-11-15', 'Brewpub El Cacao, Ocumare del Tuy', 14.00, NULL, 3, 16),
('Curso Intensivo de Recetas de Cerveza', 'Desde la teoría hasta la práctica en la creación de recetas.', 35, '2026-01-05', '2026-01-07', 'Universidad Simón Bolívar, Sartenejas', 120.00, NULL, 4, 16),
('Copa Cervecera Mirandina', 'Reconocimiento a las cervecerías artesanales de Miranda.', 70, '2026-01-25', '2026-01-25', 'Lagunita Country Club, El Hatillo', 11.00, NULL, 5, 16),

('Festival Maturín Cervecero', 'Celebrando la cerveza artesanal en la capital monaguense.', 600, '2025-10-01', '2025-10-03', 'Parque La Guaricha, Maturín', 15.00, NULL, 1, 17),
('Cata de Cervezas con Mango y Parchita', 'Degustación de cervezas infusionadas con frutas tropicales.', 55, '2025-10-25', '2025-10-25', 'Restaurante El Guacharín, Maturín', 24.00, NULL, 2, 17),
('Presentación "Sabana Grande Golden Ale"', 'Lanzamiento de una Golden Ale brillante y refrescante.', 110, '2025-11-20', '2025-11-20', 'Cervecería Monagas, Punta de Mata', 9.50, NULL, 3, 17),
('Taller de Filtración y Clarificación', 'Técnicas para obtener cervezas más claras y estables.', 20, '2026-01-10', '2026-01-11', 'Núcleo UDO Monagas', 85.00, NULL, 4, 17),
('Concurso "Sabor de Monagas"', 'Premiando la cerveza que mejor represente los sabores de Monagas.', 35, '2026-01-30', '2026-01-30', 'Plaza Piar, Maturín', 7.00, NULL, 5, 17),

('Margarita Beer & Beach', 'Festival de cerveza en la isla, con música y ambiente playero.', 1000, '2025-10-05', '2025-10-07', 'Playa El Agua, Isla Margarita', 25.00, NULL, 1, 18),
('Cata de Cervezas Tropicales', 'Degustación de cervezas con perfiles frutales y refrescantes.', 70, '2025-10-30', '2025-10-30', 'Hotel Hesperia Margarita, Pampatar', 35.00, NULL, 2, 18),
('Presentación "Perla del Caribe Lager"', 'Lanzamiento de una Lager cristalina, inspirada en las aguas de Margarita.', 140, '2025-11-25', '2025-11-25', 'Cervecería Isla, Porlamar', 12.00, NULL, 3, 18),
('Seminario de Maridaje con Mariscos', 'Cómo combinar cervezas con la gastronomía marina de la isla.', 30, '2026-01-15', '2026-01-16', 'Restaurant La Casa de la Vieja Margarita', 110.00, NULL, 4, 18),
('Campeonato Insular de Cerveza', 'Reconocimiento a la excelencia cervecera de Nueva Esparta.', 50, '2026-02-05', '2026-02-05', 'Centro Comercial Sambil Margarita', 10.00, NULL, 5, 18),

('Festival Cerveza del Llano', 'Celebrando la cerveza artesanal en la tierra del maíz.', 700, '2025-10-10', '2025-10-12', 'Parque Ferial Guanare', 16.00, NULL, 1, 19),
('Cata de Cervezas de Maíz', 'Explorando las cervezas elaboradas con maíz local.', 45, '2025-11-05', '2025-11-05', 'Restaurante El Fogón Llanero, Acarigua', 25.00, NULL, 2, 19),
('Lanzamiento "Portuguesa Golden Lager"', 'Una Lager clara y brillante para el clima llanero.', 90, '2025-11-30', '2025-11-30', 'Cervecería Portuguesa, Guanare', 10.00, NULL, 3, 19),
('Taller de Cervezas Envejecidas', 'Técnicas de maduración y añejamiento para cervezas especiales.', 18, '2026-01-20', '2026-01-21', 'Universidad Ezequiel Zamora, Guanare', 90.00, NULL, 4, 19),
('Concurso "Maíz y Malta"', 'Premiando la cerveza que mejor integre el maíz en su perfil.', 30, '2026-02-10', '2026-02-10', 'Casa de la Cultura Acarigua', 8.00, NULL, 5, 19),

('Expo Cerveza Oriental Sucre', 'Muestra de la diversidad cervecera artesanal sucrense.', 500, '2025-10-15', '2025-10-17', 'Paseo Miranda, Cumaná', 12.00, NULL, 9, 20),
('Cata de Cervezas con Coco y Mango', 'Degustación de estilos con sabores tropicales.', 40, '2025-11-10', '2025-11-10', 'Restaurant El Morro, Cumaná', 22.00, NULL, 2, 20),
('Presentación "Playa Grande Pale Ale"', 'Una Pale Ale con toques de frutas y aroma costero.', 85, '2025-12-05', '2025-12-05', 'Brewpub Cumaná, Carúpano', 9.00, NULL, 3, 20),
('Taller de Marcas y Diseño', 'Desarrollando la imagen y branding de tu cervecería.', 17, '2026-01-25', '2026-01-26', 'Casa Ramos Sucre, Cumaná', 95.00, NULL, 4, 20),
('Desafío Cervecero del Caribe', 'Concurso para la mejor cerveza que represente el Caribe.', 28, '2026-02-15', '2026-02-15', 'Castillo San Antonio, Cumaná', 7.00, NULL, 5, 20),

('Festival Cerveza Andina', 'Celebrando la tradición cervecera en los Andes tachirenses.', 800, '2025-10-20', '2025-10-22', 'Pabellones de la Feria, San Cristóbal', 18.00, NULL, 1, 21),
('Cata de Cervezas con Café Andino', 'Degustación de cervezas con el aromático café de la región.', 65, '2025-11-15', '2025-11-15', 'Restaurant Los Pinos, San Cristóbal', 28.00, NULL, 2, 21),
('Presentación "Páramo Stout"', 'Una Stout robusta y oscura, inspirada en la majestuosidad del páramo.', 120, '2025-12-10', '2025-12-10', 'Cervecería Andina, Rubio', 11.00, NULL, 3, 21),
('Seminario de Inoculación y Fermentación', 'Técnicas avanzadas para el control microbiológico en la cerveza.', 25, '2026-01-30', '2026-01-31', 'Universidad de Los Andes, San Cristóbal', 100.00, NULL, 4, 21),
('Copa Táchira de Cerveza Artesanal', 'Reconociendo la excelencia en la producción cervecera andina.', 40, '2026-02-20', '2026-02-20', 'Velódromo de San Cristóbal', 9.00, NULL, 5, 21),

('Expo Cerveza Trujillana', 'Muestra de la emergente escena cervecera del estado.', 400, '2025-10-25', '2025-10-27', 'Parque La Trujillanidad, Trujillo', 10.00, NULL, 9, 22),
('Cata de Cervezas con Dulce de Leche', 'Degustación de cervezas con el tradicional sabor trujillano.', 40, '2025-11-20', '2025-11-20', 'Restaurante Mi Viejo Trujillo, Valera', 20.00, NULL, 2, 22),
('Presentación "Trujillo Pale Lager"', 'Una Lager clara y refrescante, un homenaje al estado.', 80, '2025-12-15', '2025-12-15', 'Cervecería Los Andes, Valera', 8.50, NULL, 3, 22),
('Taller de Costos y Rentabilidad', 'Gestiona eficientemente los costos en tu cervecería artesanal.', 15, '2026-02-05', '2026-02-06', 'Centro de Negocios Trujillo', 90.00, NULL, 4, 22),
('Concurso "Sabor de Montaña"', 'Premiando la mejor cerveza que capture el espíritu andino.', 25, '2026-02-25', '2026-02-25', 'Monumento a la Paz, Trujillo', 6.00, NULL, 5, 22),

('Festival Cerveza y Encanto Yaracuyano', 'Evento que une la cerveza artesanal con la cultura y tradiciones de Yaracuy.', 500, '2025-10-30', '2025-11-01', 'Parque de la Exótica Flora Tropical, San Felipe', 14.00, NULL, 8, 23),
('Cata de Cervezas con Hierbas Aromáticas', 'Degustación de cervezas infusionadas con hierbas locales.', 50, '2025-11-25', '2025-11-25', 'Hacienda La Morita, San Felipe', 23.00, NULL, 2, 23),
('Lanzamiento "María Lionza Golden Ale"', 'Presentación de una Golden Ale mística, inspirada en la leyenda.', 100, '2025-12-20', '2025-12-20', 'Brewpub La Montaña, Chivacoa', 9.50, NULL, 3, 23),
('Seminario de Diseño de Cervecerías', 'Planificación y diseño de espacios para la producción artesanal.', 20, '2026-02-10', '2026-02-11', 'Universidad Politécnica Territorial de Yaracuy, San Felipe', 100.00, NULL, 4, 23),
('Concurso "Magia Cervecera Yaracuyana"', 'Competición de cervezas que capturan la esencia del estado.', 30, '2026-03-01', '2026-03-01', 'Cerro María Lionza, Chivacoa', 7.50, NULL, 5, 23),

('Zulia Craft Beer Festival', 'El festival de cerveza artesanal más grande del occidente venezolano.', 1500, '2025-11-05', '2025-11-07', 'Palacio de Eventos de Venezuela, Maracaibo', 28.00, NULL, 1, 24),
('Cata de Cervezas con Coco y Plátano', 'Degustación de cervezas con sabores caribeños y zulianos.', 90, '2025-11-30', '2025-11-30', 'Restaurant El Caimán, Maracaibo', 35.00, NULL, 2, 24),
('Presentación "Puente sobre el Lago Stout"', 'Stout profunda y misteriosa, inspirada en el icono zuliano.', 160, '2025-12-25', '2025-12-25', 'Brewpub El Puente, Cabimas', 13.00, NULL, 3, 24),
('Taller de Cervezas Especiales', 'Experimentando con ingredientes y procesos únicos en la cerveza.', 35, '2026-02-15', '2026-02-16', 'Universidad del Zulia, Maracaibo', 115.00, NULL, 4, 24),
('Copa Zuliana de Cerveza Artesanal', 'Premio a la cerveza artesanal más destacada del Zulia.', 60, '2026-03-05', '2026-03-05', 'Vereda del Lago, Maracaibo', 11.00, NULL, 5, 24);
-- ▗▖  ▗▖▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖▗▄▖  
-- ▐▌  ▐▌▐▌   ▐▛▚▖▐▌  █ ▐▌ ▐▌       
-- ▐▌  ▐▌▐▛▀▀▘▐▌ ▝▜▌  █ ▐▛▀▜▌ 
--  ▝▚▞▘ ▐▙▄▄▖▐▌  ▐▌  █ ▐▌ ▐▌ 

INSERT INTO VENTA (fecha, monto_total, fk_tienda_virtual, fk_tienda_fisica, fk_evento, fk_cliente) VALUES
('2025-01-10', 55.70, 1, NULL, NULL, 1),
('2025-01-15', 30.25, NULL, 1, NULL, 1),
('2025-01-12', 120.00, 2, NULL, NULL, 2),
('2025-01-18', 45.90, NULL, 2, NULL, 2),
('2025-01-14', 78.50, 3, NULL, NULL, 3),
('2025-01-20', 25.00, NULL, 3, NULL, 3),
('2025-01-16', 92.10, 4, NULL, NULL, 4),
('2025-01-22', 60.50, NULL, 4, NULL, 4),
('2025-01-18', 35.60, 5, NULL, NULL, 5),
('2025-01-24', 15.75, NULL, 5, NULL, 5),
('2025-01-20', 150.00, 6, NULL, NULL, 6),
('2025-01-26', 88.20, NULL, 1, NULL, 6),
('2025-01-22', 20.00, 7, NULL, NULL, 7),
('2025-01-28', 10.50, NULL, 2, NULL, 7),
('2025-01-24', 110.30, 8, NULL, NULL, 8),
('2025-01-30', 72.00, NULL, 3, NULL, 8),
('2025-01-26', 49.99, 9, NULL, NULL, 9),
('2025-02-01', 33.30, NULL, 4, NULL, 9),
('2025-01-28', 85.40, 10, NULL, NULL, 10),
('2025-02-03', 50.00, NULL, 5, NULL, 10),
('2025-02-01', 70.20, 1, NULL, NULL, 11),
('2025-02-05', 28.15, NULL, 1, NULL, 11),
('2025-02-03', 95.80, 2, NULL, NULL, 12),
('2025-02-07', 65.40, NULL, 2, NULL, 12),
('2025-02-05', 40.00, 3, NULL, NULL, 13),
('2025-02-09', 18.90, NULL, 3, NULL, 13),
('2025-02-07', 180.00, 4, NULL, NULL, 14),
('2025-02-11', 105.20, NULL, 4, NULL, 14),
('2025-02-09', 22.50, 5, NULL, NULL, 15),
('2025-02-13', 12.80, NULL, 5, NULL, 15),
('2025-02-11', 60.00, 6, NULL, NULL, 16),
('2025-02-15', 38.75, NULL, 1, NULL, 16),
('2025-02-13', 135.00, 7, NULL, NULL, 17),
('2025-02-17', 80.00, NULL, 2, NULL, 17),
('2025-02-15', 55.00, 8, NULL, NULL, 18),
('2025-02-19', 30.90, NULL, 3, NULL, 18),
('2025-02-17', 100.00, 9, NULL, NULL, 19),
('2025-02-21', 70.20, NULL, 4, NULL, 19),
('2025-02-19', 42.10, 10, NULL, NULL, 20),
('2025-02-23', 20.00, NULL, 5, NULL, 20),
('2025-02-21', 88.00, NULL, NULL, 1, 21), 
('2025-02-25', 65.00, 1, NULL, NULL, 21),
('2025-02-23', 30.00, NULL, NULL, 2, 22), 
('2025-02-27', 15.00, 2, NULL, NULL, 22),
('2025-02-25', 115.00, NULL, NULL, 6, 23), 
('2025-03-01', 75.00, 3, NULL, NULL, 23),
('2025-02-27', 48.00, NULL, NULL, 7, 24), 
('2025-03-03', 28.00, 4, NULL, NULL, 24),
('2025-03-01', 90.00, NULL, NULL, 11, 25), 
('2025-03-05', 50.00, 5, NULL, NULL, 25),
('2025-03-03', 33.00, NULL, NULL, 12, 26), 
('2025-03-07', 18.00, 6, NULL, NULL, 26),
('2025-03-05', 160.00, NULL, NULL, 16, 27), 
('2025-03-09', 95.00, 7, NULL, NULL, 27),
('2025-03-07', 62.00, NULL, NULL, 17, 28), 
('2025-03-11', 38.00, 8, NULL, NULL, 28),
('2025-03-09', 105.00, NULL, NULL, 21, 29), 
('2025-03-13', 70.00, 9, NULL, NULL, 29),
('2025-03-11', 40.00, NULL, NULL, 22, 30),
('2025-03-15', 22.00, 10, NULL, NULL, 30),
('2025-03-13', 140.00, NULL, NULL, 26, 31),
('2025-03-17', 85.00, 1, NULL, NULL, 31),
('2025-03-15', 50.00, NULL, NULL, 27, 32),
('2025-03-19', 30.00, 2, NULL, NULL, 32),
('2025-03-17', 120.00, NULL, NULL, 31, 33), 
('2025-03-21', 78.00, 3, NULL, NULL, 33),
('2025-03-19', 45.00, NULL, NULL, 32, 34),
('2025-03-23', 25.00, 4, NULL, NULL, 34),
('2025-03-21', 98.00, NULL, NULL, 36, 35), 
('2025-03-25', 60.00, 5, NULL, NULL, 35),
('2025-03-23', 38.00, NULL, NULL, 37, 36), 
('2025-03-27', 20.00, 6, NULL, NULL, 36),
('2025-03-25', 130.00, NULL, NULL, 41, 37), 
('2025-03-29', 80.00, 7, NULL, NULL, 37),
('2025-03-27', 52.00, NULL, NULL, 42, 38), 
('2525-03-31', 32.00, 8, NULL, NULL, 38),
('2025-03-29', 110.00, NULL, NULL, 46, 39),
('2025-04-02', 72.00, 9, NULL, NULL, 39),
('2025-03-31', 44.00, NULL, NULL, 47, 40), 
('2025-04-04', 24.00, 10, NULL, NULL, 40);


-- ▗▄▄▄▖ ▗▄▄▖▗▄▄▄▖▗▄▖     ▗▖  ▗▖▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖ 
-- ▐▌   ▐▌     █ ▐▌ ▐▌    ▐▌  ▐▌▐▌   ▐▛▚▖▐▌  █   
-- ▐▛▀▀▘ ▝▀▚▖  █ ▐▛▀▜▌    ▐▌  ▐▌▐▛▀▀▘▐▌ ▝▜▌  █  
-- ▐▙▄▄▖▗▄▄▞▘  █ ▐▌ ▐▌     ▝▚▞▘ ▐▙▄▄▖▐▌  ▐▌  █     

INSERT INTO ESTA_VENT (fk_venta, fk_estatus, fecha_inicio, fecha_fin) VALUES
(1, 1, '2025-01-10', '2025-01-11'),
(1, 2, '2025-01-11', '2025-01-12'),
(1, 3, '2025-01-12', NULL),
(2, 1, '2025-01-11', '2025-01-12'),
(2, 2, '2025-01-12', '2025-01-13'),
(2, 3, '2025-01-13', NULL),
(3, 1, '2025-01-12', '2025-01-13'),
(3, 2, '2025-01-13', NULL),
(4, 1, '2025-01-13', '2025-01-14'),
(4, 2, '2025-01-14', '2025-01-15'),
(4, 3, '2025-01-15', NULL),
(5, 1, '2025-01-14', '2025-01-15'),
(5, 2, '2025-01-15', '2025-01-16'),
(5, 3, '2025-01-16', NULL),
(6, 1, '2025-01-15', '2025-01-16'),
(6, 4, '2025-01-16', NULL),
(7, 1, '2025-01-16', '2025-01-17'),
(7, 2, '2025-01-17', '2025-01-18'),
(7, 3, '2025-01-18', NULL),
(8, 1, '2025-01-17', '2025-01-18'),
(8, 2, '2025-01-18', '2025-01-19'),
(8, 3, '2025-01-19', NULL),
(9, 1, '2025-01-18', NULL),
(10, 1, '2025-01-19', '2025-01-20'),
(10, 2, '2025-01-20', '2025-01-21'),
(10, 3, '2025-01-21', '2025-01-22'),
(10, 5, '2025-01-22', NULL),
(11, 1, '2025-01-20', '2025-01-21'),
(11, 2, '2025-01-21', '2025-01-22'),
(11, 3, '2025-01-22', NULL),
(12, 1, '2025-01-21', '2025-01-22'),
(12, 2, '2025-01-22', '2025-01-23'),
(12, 3, '2025-01-23', NULL),
(13, 1, '2025-01-22', '2025-01-23'),
(13, 2, '2025-01-23', NULL),
(14, 1, '2025-01-23', '2025-01-24'),
(14, 2, '2025-01-24', '2025-01-25'),
(14, 3, '2025-01-25', NULL),
(15, 1, '2025-01-24', '2025-01-25'),
(15, 2, '2025-01-25', '2025-01-26'),
(15, 3, '2025-01-26', NULL),
(16, 1, '2025-01-25', '2025-01-26'),
(16, 4, '2025-01-26', NULL),
(17, 1, '2025-01-26', '2025-01-27'),
(17, 2, '2025-01-27', '2025-01-28'),
(17, 3, '2025-01-28', NULL),
(18, 1, '2025-01-27', '2025-01-28'),
(18, 2, '2025-01-28', '2025-01-29'),
(18, 3, '2025-01-29', NULL),
(19, 1, '2025-01-28', NULL),
(20, 1, '2025-01-29', '2025-01-30'),
(20, 2, '2025-01-30', '2025-01-31'),
(20, 3, '2025-01-31', '2025-02-01'),
(20, 5, '2025-02-01', NULL),
(21, 1, '2025-01-30', '2025-01-31'),
(21, 2, '2025-01-31', '2025-02-01'),
(21, 3, '2025-02-01', NULL),
(22, 1, '2025-01-31', '2025-02-01'),
(22, 2, '2025-02-01', '2025-02-02'),
(22, 3, '2025-02-02', NULL),
(23, 1, '2025-02-01', '2025-02-02'),
(23, 2, '2025-02-02', NULL),
(24, 1, '2025-02-02', '2025-02-03'),
(24, 2, '2025-02-03', '2025-02-04'),
(24, 3, '2025-02-04', NULL),
(25, 1, '2025-02-03', '2025-02-04'),
(25, 2, '2025-02-04', '2025-02-05'),
(25, 3, '2025-02-05', NULL),
(26, 1, '2025-02-04', '2025-02-05'),
(26, 4, '2025-02-05', NULL),
(27, 1, '2025-02-05', '2025-02-06'),
(27, 2, '2025-02-06', '2025-02-07'),
(27, 3, '2025-02-07', NULL),
(28, 1, '2025-02-06', '2025-02-07'),
(28, 2, '2025-02-07', '2025-02-08'),
(28, 3, '2025-02-08', NULL),
(29, 1, '2025-02-07', NULL),
(30, 1, '2025-02-08', '2025-02-09'),
(30, 2, '2025-02-09', '2025-02-10'),
(30, 3, '2025-02-10', '2025-02-11'),
(30, 5, '2025-02-11', NULL),
(31, 1, '2025-02-09', '2025-02-10'),
(31, 2, '2025-02-10', '2025-02-11'),
(31, 3, '2025-02-11', NULL),
(32, 1, '2025-02-10', '2025-02-11'),
(32, 2, '2025-02-11', '2025-02-12'),
(32, 3, '2025-02-12', NULL),
(33, 1, '2025-02-11', '2025-02-12'),
(33, 2, '2025-02-12', NULL),
(34, 1, '2025-02-12', '2025-02-13'),
(34, 2, '2025-02-13', '2025-02-14'),
(34, 3, '2025-02-14', NULL),
(35, 1, '2025-02-13', '2025-02-14'),
(35, 2, '2025-02-14', '2025-02-15'),
(35, 3, '2025-02-15', NULL),
(36, 1, '2025-02-14', '2025-02-15'),
(36, 4, '2025-02-15', NULL),
(37, 1, '2025-02-15', '2025-02-16'),
(37, 2, '2025-02-16', '2025-02-17'),
(37, 3, '2025-02-17', NULL),
(38, 1, '2025-02-16', '2025-02-17'),
(38, 2, '2025-02-17', '2025-02-18'),
(38, 3, '2025-02-18', NULL),
(39, 1, '2025-02-17', NULL),
(40, 1, '2025-02-18', '2025-02-19'),
(40, 2, '2025-02-19', '2025-02-20'),
(40, 3, '2025-02-20', '2025-02-21'),
(40, 5, '2025-02-21', NULL),
(41, 1, '2025-02-19', '2025-02-20'),
(41, 2, '2025-02-20', '2025-02-21'),
(41, 3, '2025-02-21', NULL),
(42, 1, '2025-02-20', '2025-02-21'),
(42, 2, '2025-02-21', '2025-02-22'),
(42, 3, '2025-02-22', NULL),
(43, 1, '2025-02-21', '2025-02-22'),
(43, 2, '2025-02-22', NULL),
(44, 1, '2025-02-22', '2025-02-23'),
(44, 2, '2025-02-23', '2025-02-24'),
(44, 3, '2025-02-24', NULL),
(45, 1, '2025-02-23', '2025-02-24'),
(45, 2, '2025-02-24', '2025-02-25'),
(45, 3, '2025-02-25', NULL),
(46, 1, '2025-02-24', '2025-02-25'),
(46, 4, '2025-02-25', NULL),
(47, 1, '2025-02-25', '2025-02-26'),
(47, 2, '2025-02-26', '2025-02-27'),
(47, 3, '2025-02-27', NULL),
(48, 1, '2025-02-26', '2025-02-27'),
(48, 2, '2025-02-27', '2025-02-28'),
(48, 3, '2025-02-28', NULL),
(49, 1, '2025-02-27', NULL),
(50, 1, '2025-02-28', '2025-03-01'),
(50, 2, '2025-03-01', '2025-03-02'),
(50, 3, '2025-03-02', '2025-03-03'),
(50, 5, '2025-03-03', NULL),
(51, 1, '2025-03-01', '2025-03-02'),
(51, 2, '2025-03-02', '2025-03-03'),
(51, 3, '2025-03-03', NULL),
(52, 1, '2025-03-02', '2025-03-03'),
(52, 2, '2025-03-03', '2025-03-04'),
(52, 3, '2025-03-04', NULL),
(53, 1, '2025-03-03', '2025-03-04'),
(53, 2, '2025-03-04', NULL),
(54, 1, '2025-03-04', '2025-03-05'),
(54, 2, '2025-03-05', '2025-03-06'),
(54, 3, '2025-03-06', NULL),
(55, 1, '2025-03-05', '2025-03-06'),
(55, 2, '2025-03-06', '2025-03-07'),
(55, 3, '2025-03-07', NULL),
(56, 1, '2025-03-06', '2025-03-07'),
(56, 4, '2025-03-07', NULL),
(57, 1, '2025-03-07', '2025-03-08'),
(57, 2, '2025-03-08', '2025-03-09'),
(57, 3, '2025-03-09', NULL),
(58, 1, '2025-03-08', '2025-03-09'),
(58, 2, '2025-03-09', '2025-03-10'),
(58, 3, '2025-03-10', NULL),
(59, 1, '2025-03-09', NULL),
(60, 1, '2025-03-10', '2025-03-11'),
(60, 2, '2025-03-11', '2025-03-12'),
(60, 3, '2025-03-12', '2025-03-13'),
(60, 5, '2025-03-13', NULL),
(61, 1, '2025-03-11', '2025-03-12'),
(61, 2, '2025-03-12', '2025-03-13'),
(61, 3, '2025-03-13', NULL),
(62, 1, '2025-03-12', '2025-03-13'),
(62, 2, '2025-03-13', '2025-03-14'),
(62, 3, '2025-03-14', NULL),
(63, 1, '2025-03-13', '2025-03-14'),
(63, 2, '2025-03-14', NULL),
(64, 1, '2025-03-14', '2025-03-15'),
(64, 2, '2025-03-15', '2025-03-16'),
(64, 3, '2025-03-16', NULL),
(65, 1, '2025-03-15', '2025-03-16'),
(65, 2, '2025-03-16', '2025-03-17'),
(65, 3, '2025-03-17', NULL),
(66, 1, '2025-03-16', '2025-03-17'),
(66, 4, '2025-03-17', NULL),
(67, 1, '2025-03-17', '2025-03-18'),
(67, 2, '2025-03-18', '2025-03-19'),
(67, 3, '2025-03-19', NULL),
(68, 1, '2025-03-18', '2025-03-19'),
(68, 2, '2025-03-19', '2025-03-20'),
(68, 3, '2025-03-20', NULL),
(69, 1, '2025-03-19', NULL),
(70, 1, '2025-03-20', '2025-03-21'),
(70, 2, '2025-03-21', '2025-03-22'),
(70, 3, '2025-03-22', '2025-03-23'),
(70, 5, '2025-03-23', NULL),
(71, 1, '2025-03-21', '2025-03-22'),
(71, 2, '2025-03-22', '2025-03-23'),
(71, 3, '2025-03-23', NULL),
(72, 1, '2025-03-22', '2025-03-23'),
(72, 2, '2025-03-23', '2025-03-24'),
(72, 3, '2025-03-24', NULL),
(73, 1, '2025-03-23', '2025-03-24'),
(73, 2, '2025-03-24', NULL),
(74, 1, '2025-03-24', '2025-03-25'),
(74, 2, '2025-03-25', '2025-03-26'),
(74, 3, '2025-03-26', NULL),
(75, 1, '2025-03-25', '2025-03-26'),
(75, 2, '2025-03-26', '2025-03-27'),
(75, 3, '2025-03-27', NULL),
(76, 1, '2025-03-26', '2025-03-27'),
(76, 4, '2025-03-27', NULL),
(77, 1, '2025-03-27', '2025-03-28'),
(77, 2, '2025-03-28', '2025-03-29'),
(77, 3, '2025-03-29', NULL),
(78, 1, '2025-03-28', '2025-03-29'),
(78, 2, '2025-03-29', '2025-03-30'),
(78, 3, '2025-03-30', NULL),
(79, 1, '2025-03-29', NULL),
(80, 1, '2025-03-30', '2025-03-31'),
(80, 2, '2025-03-31', '2025-04-01'),
(80, 3, '2025-04-01', '2025-04-02'),
(80, 5, '2025-04-02', NULL);


-- ▗▄▄▄▖ ▗▄▄▖▗▄▄▄▖▗▄▖     ▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖▗▖  ▗▖  
-- ▐▌   ▐▌     █ ▐▌ ▐▌    ▐▌   ▐▌  ▐▌▐▌   ▐▛▚▖▐▌  
-- ▐▛▀▀▘ ▝▀▚▖  █ ▐▛▀▜▌    ▐▛▀▀▘▐▌  ▐▌▐▛▀▀▘▐▌ ▝▜▌   
-- ▐▙▄▄▖▗▄▄▞▘  █ ▐▌ ▐▌    ▐▙▄▄▖ ▝▚▞▘ ▐▙▄▄▖▐▌  ▐▌   

INSERT INTO ESTA_EVEN (fk_evento, fk_estatus, fecha_inicio, fecha_fin) VALUES
(1, 1, '2025-01-01', '2025-02-15'),  
(1, 2, '2025-02-16', '2025-07-12'),  
(1, 3, '2025-07-12', '2025-07-31'),  
(1, 10, '2025-08-01', NULL),      
(2, 2, '2025-03-01', '2025-08-05'), 
(2, 3, '2025-08-05', NULL),          
(3, 1, '2025-04-01', '2025-05-10'),  
(3, 6, '2025-05-11', '2025-06-01'),  
(3, 4, '2025-06-02', NULL),        
(4, 5, '2025-01-01', '2025-09-30'),  
(4, 2, '2025-10-01', '2025-10-21'), 
(4, 3, '2025-10-21', NULL),          
(5, 1, '2025-06-01', '2025-11-01'),  
(5, 2, '2025-11-02', NULL),          
(6, 1, '2025-02-01', '2025-03-15'),
(6, 2, '2025-03-16', '2025-06-30'),
(6, 7, '2025-07-01', '2025-07-17'),
(6, 3, '2025-07-17', NULL),
(7, 2, '2025-04-01', '2025-08-10'),
(7, 3, '2025-08-10', NULL),
(8, 1, '2025-05-01', '2025-09-01'),
(8, 4, '2025-09-02', NULL),
(11, 1, '2025-03-01', '2025-05-31'),
(11, 2, '2025-06-01', '2025-07-22'),
(11, 3, '2025-07-22', NULL),
(12, 2, '2025-06-01', '2025-08-15'),
(12, 3, '2025-08-15', NULL),
(16, 1, '2025-02-15', '2025-04-30'),
(16, 2, '2025-05-01', '2025-07-10'),
(16, 7, '2025-07-11', '2025-07-27'),
(16, 3, '2025-07-27', NULL),
(17, 2, '2025-05-01', '2025-08-20'),
(17, 3, '2025-08-20', NULL),
(21, 1, '2025-03-01', '2025-06-30'),
(21, 2, '2025-07-01', '2025-08-01'),
(21, 3, '2025-08-01', NULL),
(22, 2, '2025-07-01', '2025-08-25'),
(22, 3, '2025-08-25', NULL),
(26, 1, '2025-03-10', '2025-06-15'),
(26, 2, '2025-06-16', '2025-08-01'),
(26, 7, '2025-08-02', '2025-08-07'),
(26, 3, '2025-08-07', NULL),
(31, 1, '2025-03-20', '2025-06-30'),
(31, 2, '2025-07-01', '2025-08-09'),
(31, 7, '2025-08-10', '2025-08-12'),
(31, 3, '2025-08-12', NULL),
(36, 1, '2025-04-01', '2025-07-31'),
(36, 2, '2025-08-01', '2025-08-17'),
(36, 3, '2025-08-17', NULL),
(41, 1, '2025-05-01', '2025-07-31'),
(41, 2, '2025-08-01', '2025-08-22'),
(41, 3, '2025-08-22', NULL),
(46, 1, '2025-03-01', '2025-05-31'),
(46, 2, '2025-06-01', '2025-08-24'),
(46, 7, '2025-08-25', '2025-08-31'),
(46, 3, '2025-08-31', '2025-09-30'),
(46, 10, '2025-10-01', NULL)
;


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

INSERT INTO INVE_TIEN (fk_cerveza, fk_presentacion, fk_tienda, fk_lugar_tienda, cantidad) VALUES
(1,  1, 1, 6, 200),
(1,  3, 1, 6, 150),
(5,  2, 1, 7, 80),
(7,  8, 1, 8, 45),
(9,  10, 1, 9, 25),
(2,  2, 2, 6, 180),
(2,  4, 2, 6, 220),
(6,  7, 2, 7, 60),
(8,  9, 2, 8, 35),
(10, 1, 2, 9, 90),
(3,  1, 3, 6, 110),
(3,  3, 3, 6, 140),
(7,  5, 3, 7, 10),
(9,  6, 3, 8, 5),
(1,  7, 3, 9, 70),
(4,  2, 4, 6, 130),
(4,  4, 4, 6, 160),
(8,  10, 4, 7, 20),
(10, 8, 4, 8, 40),
(2,  5, 4, 9, 7),
(5,  1, 5, 6, 100),
(5,  3, 5, 6, 120),
(6,  2, 5, 7, 85),
(7,  1, 5, 8, 75),
(8,  3, 5, 9, 95);


-- ▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖▗▖  ▗▖    ▗▄▄▖ ▗▄▄▖  ▗▄▖ ▗▖  ▗▖ 
-- ▐▌   ▐▌  ▐▌▐▌   ▐▛▚▖▐▌    ▐▌ ▐▌▐▌ ▐▌▐▌ ▐▌▐▌  ▐▌ 
-- ▐▛▀▀▘▐▌  ▐▌▐▛▀▀▘▐▌ ▝▜▌    ▐▛▀▘ ▐▛▀▚▖▐▌ ▐▌▐▌  ▐▌  
-- ▐▙▄▄▖ ▝▚▞▘ ▐▙▄▄▖▐▌  ▐▌    ▐▌   ▐▌ ▐▌▝▚▄▞▘ ▝▚▞▘   

INSERT INTO EVEN_PROV (fk_evento, fk_proveedor) VALUES
(1, 1),
(1, 11),
(2, 2),
(3, 3),
(4, 12),
(5, 4),
(6, 1),
(6, 13),
(7, 2),
(8, 3),
(9, 14),
(10, 4),
(11, 5),
(11, 15),
(12, 6),
(13, 7),
(14, 16),
(16, 5),
(16, 17),
(17, 6),
(18, 7),
(19, 18),
(21, 8),
(21, 19),
(22, 9),
(23, 10),
(24, 20),
(26, 8),
(26, 11),
(27, 9),
(28, 10),
(29, 12),
(31, 13),
(31, 14),
(32, 15),
(33, 16),
(34, 17);


-- ▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖▗▖  ▗▖     ▗▄▄▖▗▖   ▗▄▄▄▖▗▄▄▄▖
-- ▐▌   ▐▌  ▐▌▐▌   ▐▛▚▖▐▌    ▐▌   ▐▌     █  ▐▌ 
-- ▐▛▀▀▘▐▌  ▐▌▐▛▀▀▘▐▌ ▝▜▌    ▐▌   ▐▌     █  ▐▛▀▀▘ 
-- ▐▙▄▄▖ ▝▚▞▘ ▐▙▄▄▖▐▌  ▐▌    ▝▚▄▄▖▐▙▄▄▖▗▄█▄▖▐▙▄▄▖      

INSERT INTO EVEN_CLIE (fk_evento, fk_cliente, cantidad_entradas) VALUES
(1, 1, 2),
(1, 11, 1),
(2, 2, 1),
(3, 12, 3),
(4, 3, 1),
(6, 4, 4),
(6, 14, 2),
(7, 5, 1),
(8, 15, 1),
(9, 6, 2),
(11, 7, 3),
(11, 17, 1),
(12, 8, 1),
(13, 18, 2),
(14, 9, 1),
(16, 10, 5),
(16, 20, 3),
(17, 1, 1),
(18, 21, 1),
(19, 2, 2),
(21, 3, 2),
(21, 23, 1),
(22, 4, 1),
(23, 24, 2),
(24, 5, 1),
(26, 6, 4),
(26, 26, 2),
(27, 7, 1),
(28, 27, 1),
(29, 8, 2),
(31, 9, 3),
(31, 29, 1),
(32, 10, 1),
(33, 30, 2),
(34, 11, 1);


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

INSERT INTO INVE_EVEN (fk_cerveza, fk_presentacion, fk_evento, cantidad) VALUES
(1,  1, 1, 300),
(5,  3, 1, 150),
(7,  7, 1, 50),
(9,  10, 1, 20),
(2,  2, 6, 250),
(4,  4, 6, 180),
(6,  5, 6, 5),
(8,  9, 6, 30),
(3,  1, 11, 200),
(10, 3, 11, 100),
(1,  6, 11, 2),
(5,  1, 16, 400),
(7,  2, 16, 200),
(9,  4, 16, 150),
(2,  7, 16, 60),
(4,  1, 21, 180),
(6,  3, 21, 90),
(8,  5, 21, 3),
(10, 1, 26, 220),
(1,  2, 26, 130),
(3,  4, 26, 100),
(5,  6, 31, 1),
(7,  1, 31, 280),
(9,  2, 31, 160),
(2,  3, 31, 120);


-- ▗▄▄▖ ▗▖ ▗▖▗▖  ▗▖▗▄▄▄▖     ▗▄▄▖▗▖   ▗▄▄▄▖▗▄▄▄▖
-- ▐▌ ▐▌▐▌ ▐▌▐▛▚▖▐▌  █      ▐▌   ▐▌     █  ▐▌ 
-- ▐▛▀▘ ▐▌ ▐▌▐▌ ▝▜▌  █      ▐▌   ▐▌     █  ▐▛▀▀▘ 
-- ▐▌   ▝▚▄▞▘▐▌  ▐▌  █      ▝▚▄▄▖▐▙▄▄▖▗▄█▄▖▐▙▄▄▖

INSERT INTO PUNT_CLIE (fk_punto, fk_cliente, cantidad_puntos) VALUES
(31, 1, 100),  
(32, 2, 150),   
(33, 3, 200),   
(34, 4, 50),    
(35, 5, 250),   
(36, 6, 120),   
(37, 7, 180),  
(38, 8, 75),    
(39, 9, 300),   
(40, 10, 90);



-- ▗▄▄▖  ▗▄▖  ▗▄▄▖ ▗▄▖  
-- ▐▌ ▐▌▐▌ ▐▌▐▌   ▐▌ ▐▌
-- ▐▛▀▘ ▐▛▀▜▌▐▌▝▜▌▐▌ ▐▌
-- ▐▌   ▐▌ ▐▌▝▚▄▞▘▝▚▄▞▘

INSERT INTO PAGO (fk_metodo_pago, fk_venta, fk_tasa_cambio) VALUES
(1, 1, 1), 
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1),
(6, 6, 1),
(7, 7, 2), 
(8, 8, 2),
(9, 9, 2),
(10, 10, 2),
(11, 11, 2),
(12, 12, 2),
(13, 13, 2),
(14, 14, 2),
(15, 15, 2),
(16, 16, 2),
(17, 17, 2),
(18, 18, 2),
(19, 19, 2),
(20, 20, 2),
(21, 21, 2),
(22, 22, 2),
(23, 23, 3), 
(24, 24, 3),
(25, 25, 3),
(26, 26, 3),
(27, 27, 3),
(28, 28, 3),
(29, 29, 3),
(30, 30, 3),
(31, 31, 3),
(32, 32, 3),
(33, 33, 3),
(34, 34, 3),
(35, 35, 3),
(36, 36, 4), 
(37, 37, 4),
(38, 38, 4),
(39, 39, 4),
(40, 40, 4),
(1, 41, 4),
(2, 42, 4),
(3, 43, 4),
(4, 44, 4),
(5, 45, 4),
(6, 46, 4),
(7, 47, 4),
(8, 48, 4),
(9, 49, 4),
(10, 50, 4),
(11, 51, 5),
(12, 52, 5),
(13, 53, 5),
(14, 54, 5),
(15, 55, 5),
(16, 56, 5),
(17, 57, 5),
(18, 58, 5),
(19, 59, 5),
(20, 60, 5),
(21, 61, 5),
(22, 62, 5),
(23, 63, 5),
(24, 64, 5),
(25, 65, 5),
(26, 66, 6), 
(27, 67, 6),
(28, 68, 6),
(29, 69, 6),
(30, 70, 6),
(31, 71, 6),
(32, 72, 6),
(33, 73, 6),
(34, 74, 6),
(35, 75, 6),
(36, 76, 6),
(37, 77, 6),
(38, 78, 6),
(39, 79, 6),
(40, 80, 6);

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

INSERT INTO JUEZ_EVENT (fk_juez, fk_evento) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 3),
(5, 4),
(6, 5),
(7, 6),
(8, 7),
(9, 11),
(10, 12),
(1, 16),
(2, 17),
(3, 21),
(4, 22),
(5, 26),
(6, 31),
(7, 36),
(8, 41),
(9, 46),
(10, 47),
(1, 51),
(2, 56),
(3, 61),
(4, 66),
(5, 71),
(6, 76),
(7, 81),
(8, 86),
(9, 91),
(10, 96),
(1, 101),
(2, 106),
(3, 111),
(4, 112),
(5, 113),
(6, 114),
(7, 115),
(8, 116),
(9, 117),
(10, 118);


-- ▗▄▄▄  ▗▄▄▄▖▗▄▄▄▖▗▄▖ ▗▖   ▗▖   ▗▄▄▄▖    ▗▄▄▄▖ ▗▄▖  ▗▄▄▖▗▄▄▄▖▗▖ ▗▖▗▄▄▖  ▗▄▖ 
-- ▐▌  █ ▐▌     █ ▐▌ ▐▌▐▌   ▐▌   ▐▌       ▐▌   ▐▌ ▐▌▐▌     █  ▐▌ ▐▌▐▌ ▐▌▐▌ ▐▌
-- ▐▌  █ ▐▛▀▀▘  █ ▐▛▀▜▌▐▌   ▐▌   ▐▛▀▀▘    ▐▛▀▀▘▐▛▀▜▌▐▌     █  ▐▌ ▐▌▐▛▀▚▖▐▛▀▜▌
-- ▐▙▄▄▀ ▐▙▄▄▖  █ ▐▌ ▐▌▐▙▄▄▖▐▙▄▄▖▐▙▄▄▖    ▐▌   ▐▌ ▐▌▝▚▄▄▖  █  ▝▚▄▞▘▐▌ ▐▌▐▌ ▐▌

INSERT INTO DETALLE_FACTURA (cantidad, precio_unitario, fk_venta, fk_cerveza, fk_presentacion) VALUES
(5, 150.00,  1, 1, 1),
(5, 150.00,  2, 1, 1),
(5, 150.00,  3, 1, 1),
(10, 50.00,  4, 1, 1),
(12, 10.00,  5, 1, 1),
(60, 5.00,   6, 1, 1),
(30, 100.00, 7, 1, 1),
(80, 7.50,   8, 1, 1),
(15, 120.00, 9, 1, 1),
(20, 8.00,   10, 1, 1);


-- ▗▄▄▖  ▗▄▖  ▗▄▄▖ ▗▄▖      ▗▄▖ ▗▄▄▄▖▗▄▄▄▖▗▖   ▗▄▄▄▖ ▗▄▖  ▗▄▄▖▗▄▄▄▖ ▗▄▖ ▗▖  ▗▖
-- ▐▌ ▐▌▐▌ ▐▌▐▌   ▐▌ ▐▌    ▐▌ ▐▌▐▌     █  ▐▌     █  ▐▌ ▐▌▐▌     █  ▐▌ ▐▌▐▛▚▖▐▌
-- ▐▛▀▘ ▐▛▀▜▌▐▌▝▜▌▐▌ ▐▌    ▐▛▀▜▌▐▛▀▀▘  █  ▐▌     █  ▐▛▀▜▌▐▌     █  ▐▌ ▐▌▐▌ ▝▜▌
-- ▐▌   ▐▌ ▐▌▝▚▄▞▘▝▚▄▞▘    ▐▌ ▐▌▐▌   ▗▄█▄▖▐▙▄▄▖▗▄█▄▖▐▌ ▐▌▝▚▄▄▖▗▄█▄▖▝▚▄▞▘▐▌  ▐▌ 

INSERT INTO PAGO_AFILIACION (fecha, total, mes_pagado, fk_afiliacion, fk_metodo_pago, fk_tasa_cambio) VALUES
('2024-01-01', 50.00, '2024-01-01', 1, 1, 1),
('2024-02-01', 50.00, '2024-02-01', 1, 3, 2),
('2024-03-01', 50.00, '2024-03-01', 1, 5, 3),
('2024-02-15', 30.00, '2024-02-01', 2, 6, 2),
('2024-03-15', 30.00, '2024-03-01', 2, 8, 3),
('2023-11-01', 50.00, '2023-11-01', 3, 15, 1),
('2023-12-01', 50.00, '2023-12-01', 3, 2, 1),
('2024-04-10', 50.00, '2024-04-01', 5, 24, 4),
('2024-05-01', 50.00, '2024-05-01', 7, 30, 5),
('2024-06-01', 30.00, '2024-06-01', 8, 14, 6);

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


CREATE OR REPLACE FUNCTION descontar_inventario_detalle_factura()
RETURNS TRIGGER AS $$
DECLARE
  tienda_id INT;
  lugar_tienda_id INT;
  filas_afectadas INT;
BEGIN
  SELECT fk_tienda_fisica INTO tienda_id FROM VENTA WHERE eid = NEW.fk_venta;

  IF tienda_id IS NULL THEN
    RAISE NOTICE 'Venta no asociada a tienda física, no se descuenta inventario.';
    RETURN NEW;
  END IF;

  SELECT fk_lugar_tienda INTO lugar_tienda_id
  FROM INVE_TIEN
  WHERE fk_cerveza = NEW.fk_cerveza
    AND fk_presentacion = NEW.fk_presentacion
    AND fk_tienda = tienda_id
    AND cantidad >= NEW.cantidad
  LIMIT 1;

  IF lugar_tienda_id IS NULL THEN
    RAISE NOTICE 'No hay inventario suficiente para descontar: tienda=%, cerveza=%, presentacion=%', tienda_id, NEW.fk_cerveza, NEW.fk_presentacion;
    RETURN NEW;
  END IF;

  UPDATE INVE_TIEN
  SET cantidad = cantidad - NEW.cantidad
  WHERE fk_cerveza = NEW.fk_cerveza
    AND fk_presentacion = NEW.fk_presentacion
    AND fk_tienda = tienda_id
    AND fk_lugar_tienda = lugar_tienda_id
  RETURNING 1 INTO filas_afectadas;

  RAISE NOTICE 'Trigger descontar_inventario_detalle_factura: tienda_id=%, lugar_tienda_id=%, filas_afectadas=%', tienda_id, lugar_tienda_id, filas_afectadas;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_descuento_inventario_detalle_factura
AFTER INSERT ON DETALLE_FACTURA
FOR EACH ROW
EXECUTE FUNCTION descontar_inventario_detalle_factura();


CREATE OR REPLACE FUNCTION sumar_inventario_al_pagar_compra()
RETURNS TRIGGER AS $$
DECLARE
  tienda_id INT;
  lugar_tienda_id INT;
  detalle RECORD;
BEGIN
  IF NEW.fk_estatus = 3 THEN

    SELECT fk_tienda_fisica INTO tienda_id
    FROM COMPRA
    WHERE eid = NEW.fk_compra;

    SELECT eid INTO lugar_tienda_id FROM LUGAR_TIENDA WHERE fk_lugar_tienda IS NULL LIMIT 1;

    FOR detalle IN
      SELECT * FROM DETALLE_COMPRA WHERE fk_compra = NEW.fk_compra
    LOOP
      INSERT INTO INVE_TIEN (fk_cerveza, fk_presentacion, fk_tienda, fk_lugar_tienda, cantidad)
      VALUES (detalle.fk_cerveza, detalle.fk_presentacion, tienda_id, lugar_tienda_id, detalle.cantidad)
      ON CONFLICT (fk_cerveza, fk_presentacion, fk_tienda, fk_lugar_tienda)
      DO UPDATE SET cantidad = INVE_TIEN.cantidad + detalle.cantidad;
    END LOOP;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_sumar_inventario_al_pagar_compra
AFTER INSERT OR UPDATE ON ESTA_COMP
FOR EACH ROW
EXECUTE FUNCTION sumar_inventario_al_pagar_compra();


CREATE OR REPLACE FUNCTION actualizar_monto_total_compra()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE COMPRA
    SET monto_total = monto_total + (NEW.cantidad * NEW.precio_unitario)
    WHERE eid = NEW.fk_compra;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_actualizar_monto_total_compra
AFTER INSERT ON DETALLE_COMPRA
FOR EACH ROW
EXECUTE FUNCTION actualizar_monto_total_compra();

CREATE OR REPLACE FUNCTION actualizar_monto_total_venta()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE VENTA
    SET monto_total = monto_total + (NEW.cantidad * NEW.precio_unitario)
    WHERE eid = NEW.fk_venta;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_actualizar_monto_total_venta
AFTER INSERT ON DETALLE_FACTURA
FOR EACH ROW
EXECUTE FUNCTION actualizar_monto_total_venta();

CREATE OR REPLACE FUNCTION sumar_puntos_al_pagar_venta()
RETURNS TRIGGER AS $$
DECLARE
  cliente_id INT;
  monto FLOAT;
  puntos INT;
  punto_id INT;
BEGIN

  IF NEW.fk_estatus = 3 THEN
    SELECT fk_cliente, monto_total INTO cliente_id, monto
    FROM VENTA
    WHERE eid = NEW.fk_venta;

    SELECT fk_punto INTO punto_id FROM PUNT_CLIE WHERE fk_cliente = cliente_id;

    puntos := FLOOR(monto * 0.05);

    IF punto_id IS NOT NULL THEN
      UPDATE PUNT_CLIE
      SET cantidad_puntos = cantidad_puntos + puntos
      WHERE fk_cliente = cliente_id;
    ELSE
      SELECT fk_metodo_pago INTO punto_id FROM PUNTO LIMIT 1;
      INSERT INTO PUNT_CLIE (fk_punto, fk_cliente, cantidad_puntos)
      VALUES (punto_id, cliente_id, puntos);
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_sumar_puntos_al_pagar_venta
AFTER INSERT OR UPDATE ON ESTA_VENT
FOR EACH ROW
EXECUTE FUNCTION sumar_puntos_al_pagar_venta();



CREATE OR REPLACE FUNCTION trigger_reponer_inventario()
RETURNS TRIGGER AS $$
DECLARE
    v_proveedor_id INT;
    v_precio_unitario FLOAT;
    v_compra_id INT;
    v_cerveza_nombre VARCHAR(100);
    v_orden_pendiente INT;
BEGIN
    IF NEW.cantidad < 100 THEN
        SELECT COUNT(*) INTO v_orden_pendiente
        FROM COMPRA c
        JOIN DETALLE_COMPRA d ON d.fk_compra = c.eid
        JOIN ESTA_COMP ec ON ec.fk_compra = c.eid
        WHERE d.fk_cerveza = NEW.fk_cerveza
          AND d.fk_presentacion = NEW.fk_presentacion
          AND c.fk_proveedor = (SELECT fk_proveedor FROM CERVEZA WHERE eid = NEW.fk_cerveza)
          AND ec.fk_estatus <> 3;

        IF v_orden_pendiente = 0 THEN
            SELECT fk_proveedor, nombre INTO v_proveedor_id, v_cerveza_nombre
            FROM CERVEZA
            WHERE eid = NEW.fk_cerveza;

            SELECT precio INTO v_precio_unitario
            FROM CERV_PRES
            WHERE fk_cerveza = NEW.fk_cerveza AND fk_presentacion = NEW.fk_presentacion
            LIMIT 1;

            INSERT INTO COMPRA (fecha, monto_total, fk_proveedor)
            VALUES (CURRENT_DATE, 500 * v_precio_unitario, v_proveedor_id)
            RETURNING eid INTO v_compra_id;

            INSERT INTO DETALLE_COMPRA (cantidad, precio_unitario, fk_compra, fk_cerveza, fk_presentacion)
            VALUES (500, v_precio_unitario, v_compra_id, NEW.fk_cerveza, NEW.fk_presentacion);


            RAISE NOTICE 'Orden de compra generada automáticamente para % (cerveza_id=%), presentación %, proveedor %, cantidad 500', v_cerveza_nombre, NEW.fk_cerveza, NEW.fk_presentacion, v_proveedor_id;
        ELSE
            RAISE NOTICE 'Ya existe una orden pendiente para este producto/presentación, no se genera otra.';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


DROP TRIGGER IF EXISTS trigger_reponer_inventario ON INVE_TIEN;

CREATE TRIGGER trigger_reponer_inventario
AFTER UPDATE ON INVE_TIEN
FOR EACH ROW
EXECUTE FUNCTION trigger_reponer_inventario();