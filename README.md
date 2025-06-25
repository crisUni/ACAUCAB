# Requisitos
- [docker](https://docs.docker.com/desktop/setup/install/windows-install/)
- [docker compose](https://docs.docker.com/compose/install/)

# Instalacion
1. clona el proyecto
2. entra a la carpeta y abre una terminal alli
3. escribe ```docker compose up```
4. en localhost:3000 se abrira la pagina web
5. en localhost:3001 se abrira la pagina web en modo de desarollador
6. en localhost:5050 se abrira pgadmin


# TODO
## INSERT
Hacer minimo 10 insert en cada uno (exepto en los que solo son 1)

- [ ] CAMBIAR CONTRASEN~A EN USUARIO A CONTRASENA!!!

- [x] Lugar
- [x] Receta
- [x] Instruccion
- [x] Rece_Inst
- [x] Presentacion
- [x] Descuento
- [x] Tienda Virtual
- [x] Caracteristicas
- [x] Horario
- [x] Beneficio
- [x] Privilegio
- [x] Ingrediente
- [x] Rol
- [x] Banco
- [x] Tipo Tarjeta
- [x] Estatus
- [x] Tasa Cambio
- [x] Lugar Tienda
- [x] Metodo Pago
- [x] Ingr_Rece
- [x] Rol_Priv
- [x] Proveedor
- [x] Cliente
- [x] Tienda_Fisica
- [x] Empleado
- [x] Tarjeta
- [x] Cheque
- [x] Efectivo
- [x] Punto
- [x] Afiliacion
- [x] Compra
- [x] PNatural (Persona Natural)
- [x] PJurudico (Persona Juridico)
- [x] Departamento
- [x] Empl_Hora
- [x] Usuario
- [x] Telefono
- [x] Correo
- [x] Esta_Comp
- [x] Detalle_Compra
- [x] Cargo
- [x] Personal_Contacto
- [x] Tipo_Cerveza
- [x] Cerveza
- [x] Comentario
- [x] Cerv_Pres
- [x] Desc_Cerv_Pres
- [x] Tipo Evento
- [x] Evento
- [x] Venta
- [x] Esta_Vent
- [x] Esta_Even
- [x] Cerv_Cara
- [x] Inve_Tien
- [x] Even_Prov
- [x] Even_Clie
- [x] Carg_Empl
- [x] Empl_Bene
- [x] Inve_Even
- [x] Punt_Clie
- [x] Pago
- [x] Juez
- [x] Juez_Event
- [x] Detalle Factura
- [x] Pago Afiliacion
- [x] Vacacion

```sql
SELECT con.*
    FROM pg_catalog.pg_constraint con
        INNER JOIN pg_catalog.pg_class rel ON rel.oid = con.conrelid
        INNER JOIN pg_catalog.pg_namespace nsp ON nsp.oid = connamespace
        WHERE rel.relname = '{table name}'; --table name en full minusculas


ALTER TABLE TARJETA ALTER COLUMN "numero_tarjeta" TYPE BIGINT;


CREATE OR REPLACE PROCEDURE pipu (INT, INT)
AS
$$
DECLARE
  cliente_id INT;
  monto FLOAT;
  puntos INT;
  punto_id INT;
BEGIN
  RAISE NOTICE 'Corriendo puntos pagar';

  IF $2 = 3 THEN
    SELECT fk_cliente, monto_total INTO cliente_id, monto
    FROM VENTA
    WHERE eid = $1;

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

END
$$ LANGUAGE plpgsql;    
```