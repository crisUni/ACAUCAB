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
    SELECT *
    FROM Venta`,
}

export default VentaService;