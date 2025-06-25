import { sql } from "bun";

type Venta = {
  eid?: Number,
  fecha: Date,
  monto_total: Number,
  fk_tienda_virtual?: Number,
  fk_tienda_fisica?: Number,
  fk_evento?: Number,
  fk_cliente: Number
}


const VentaService = {
  // ROL
  getVentaSQL: async (): Promise<Array<any>> =>
    await sql`
    SELECT V.eid, V.fecha, V.monto_total, V.fk_tienda_fisica AS "fk_tienda_fisica", V.fk_tienda_virtual, E.nombre AS "fk_evento", C.rif AS "fk_cliente"
    FROM Venta AS V
    JOIN Cliente AS C ON C.eid = V.fk_cliente
    LEFT JOIN Evento AS E ON E.eid = V.fk_evento
    `,
}

export default VentaService;