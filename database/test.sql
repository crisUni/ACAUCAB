SELECT c.eid, c.rif, ec.cantidad_entradas
FROM CLIENTE c, EVEN_CLIE ec
WHERE c.eid = ec.fk_cliente 
AND ec.fk_evento = ${eventoID}

SELECT c.eid
FROM Cliente c, Usuario u
WHERE u.eid = ${userID} AND u.fk_cliente = c.eid

select e.* 
from evento e, even_clie ec
WHERE ec.fk_cliente = ${clienteID} AND ec.fk_evento = e.eid;


-- Muestra los niveles de stock de cada producto.

CREATE OR REPLACE FUNCTION niveles_stock_producto()
AS 
$$
BEGIN
  SELECT c.nombre ||', '|| p.nombre as "Producto", cp.precio, it.cantidad
  FROM PRESENTACION p, CERV_PRES cp, INVE_TIEN it, CERVEZA c
  WHERE it.fk_presentacion = cp.fk_presentacion 
    AND it.fk_cerveza = cp.fk_cerveza AND it.fk_cerveza = c.eid
  ORDER BY cantidad DESC
  ;
END;
$$ LANGUAGE plpgsql;


SELECT  df.* from venta v, detalle_factura df;