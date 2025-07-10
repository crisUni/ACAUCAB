import { sql } from "bun";

type Venta = {
  eid?: Number,
  fecha: string,
  monto_total: Number,
  fk_tienda_virtual?: Number,
  fk_tienda_fisica?: Number,
  fk_evento?: Number,
  fk_cliente: Number
}

type Pago = {
  fk_metodo_pago: number,
  fk_venta: number,
  fk_tasa_cambio?: number,
  monto: number
}


class VentaService {
  // ROL
  async getVentaSQL(): Promise<Array<any>> {
    return await sql`
    SELECT V.eid, V.fecha, V.monto_total, V.fk_tienda_fisica AS "fk_tienda_fisica", V.fk_tienda_virtual, E.nombre AS "fk_evento", C.rif AS "fk_cliente"
    FROM Venta AS V
    JOIN Cliente AS C ON C.eid = V.fk_cliente
    LEFT JOIN Evento AS E ON E.eid = V.fk_evento`;
  }

  async getTasaActual() {
    return (await sql`SELECT * FROM tasa_cambio WHERE fecha_fin IS NULL LIMIT 1`)[0].eid;
  }

  async createAndGetNewVenta(venta: Venta): Promise<number> {
    return (await sql`INSERT INTO Venta ${sql(venta)} RETURNING eid`)[0].eid
  }

  async registrarPagoAVenta(pago: Pago): Promise<Pago> {
    pago.fk_tasa_cambio = await this.getTasaActual()
    return (await sql`INSERT INTO Pago ${sql(pago)} RETURNING *`)[0]
  }
}

export default new VentaService();