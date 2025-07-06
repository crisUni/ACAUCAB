import { sql } from "bun";

type Tarjeta = {
    fk_metodo_pago?: number
    fk_banco: number
    fk_tipo_tarjeta: number
    numero_tarjeta: number
    fecha_vence: number
    nombre_titular: number
    cvv: number
}

class MetodoPagoService {
    async createAndGetMetodoPagoSupetype(): Promise<number> {
        return (await sql`INSERT INTO METODO_PAGO DEFAULT VALUES RETURNING eid`)[0].eid
    }

    async insertTarjeta(tarjeta: Tarjeta): Promise<number> {
        tarjeta.fk_metodo_pago = await this.createAndGetMetodoPagoSupetype();
        return (await sql`INSERT INTO Tarjeta ${sql(tarjeta)} RETURNING fk_metodo_pago`)[0].fk_metodo_pago;
    }
}

export default new MetodoPagoService()