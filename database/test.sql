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
      