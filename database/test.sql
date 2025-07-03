SELECT c.eid, c.rif, ec.cantidad_entradas
FROM CLIENTE c, EVEN_CLIE ec
WHERE c.eid = ec.fk_cliente 
AND ec.fk_evento = ${eventoID}