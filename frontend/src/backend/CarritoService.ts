// - [x] /api/carrito/:clientID
//     - [x] GET: Gets el carrito del usuario
//     - [x] POST: Crea el carrito del usuario
//     - [x] DELETE: Borra el carrito del usuario
// - [x] /api/carrito/:clienteID/items
//     - [x] GET: Gets los items del carrito del usuario
//     - [x] POST: Agrega items al carrito del usuario (Si estan repetidos los actualiza)
//     - [x] DELETE: Borra items del carrito del usuario
// - [x] /api/carrito/:clienteID/pay
//     - [x] GET: Consigue los metodos de pago para pagar el carrito
//      TODO: Hacer que se pueda registrar una tarjeta (o reusar una) y canjear puntos
//     - [ ] POST: Registra un metodo de pago usado para pagar el carrito, con su monto
// - [x] /api/carrito/:clienteID/complete
//     - [x] GET: Marca el carrito del usuario como pagado

import { sql } from "bun";

type Item = {
    fk_cerveza: number
    fk_presentacion: number
    precio_unitario?: number
}

type DetalleFactura = {
    cantidad?: number
    fk_venta?: number,
} & Item

type Pago = {
    fk_metodo_pago: number
    fk_venta: number
    fk_tasa_cambio: number
    monto: number
}

const CORS_HEADERS = {
    headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, OPTIONS, POST, DELETE, PUT',
        'Access-Control-Allow-Headers': 'Content-Type',
    },
}; // TODO: Remove from here, make global

class CarritoService {
    async getCarritoObject(clienteID: string) {
        const carrito: any[] = await sql`SELECT V.*
            FROM Venta V, ESTA_VENT EV
            WHERE V.fk_cliente = ${clienteID}
            AND V.eid = EV.fk_venta
            AND EV.fk_estatus = 100 -- HACK: 100 es el estatus Carrito
            AND EV.fecha_fin IS NULL
            ORDER BY V.eid DESC
            LIMIT 1`;

        if (carrito.length === 0)
            return carrito

        const items = await sql`SELECT DF.*, C.nombre AS "nombre_cerveza", P.nombre AS "nombre_presentacion"
            FROM Detalle_Factura DF
            JOIN Cerveza C ON DF.fk_cerveza = C.eid
            JOIN Presentacion P ON DF.fk_presentacion = P.eid
            WHERE DF.fk_venta = ${carrito[0].eid}`;
        carrito[0].items = items;
        const payments = await sql`SELECT * FROM Pago WHERE fk_venta = ${carrito[0].eid}`;
        carrito[0].payments = payments;

        return carrito
    }

    async getOrCreateCarritoObject(clienteID: string) {
        const carrito = await this.getCarritoObject(clienteID);
        if (carrito.length > 0)
            return carrito;
        const newCarrito = await sql`INSERT INTO Venta (fecha, monto_total, fk_tienda_virtual, fk_cliente)
            VALUES(CURRENT_DATE, 0, 1, ${clienteID}) RETURNING *`;
        await sql`INSERT INTO ESTA_VENT (fk_venta, fk_estatus, fecha_inicio) VALUES (${newCarrito[0].eid}, 100, CURRENT_DATE)`;
        return newCarrito
    }

    async getCarrito(clienteID: string) {
        const carrito = await this.getCarritoObject(clienteID);
        if (carrito.length === 0)
            return new Response('', { status: 204, ...CORS_HEADERS })
        return Response.json(carrito, CORS_HEADERS)
    }

    async createCarrito(clienteID: string) {
        const existingCarrito = await this.getCarritoObject(clienteID);
        if (existingCarrito.length > 0)
            return Response.json(existingCarrito[0], CORS_HEADERS)
        const carrito = await this.getOrCreateCarritoObject(clienteID);
        return Response.json(carrito, { status: 201, ...CORS_HEADERS })
    }

    async deleteCarrito(clienteID: string) {
        const existingCarrito = await this.getCarritoObject(clienteID);
        if (existingCarrito.length === 0)
            return new Response('', { status: 204, ...CORS_HEADERS })
        await sql`DELETE FROM Venta WHERE eid = ${existingCarrito[0].eid}`;
        return Response.json(existingCarrito, CORS_HEADERS)
    }

    async getItemsFromCarrito(clienteID: string) {
        const carrito = (await this.getOrCreateCarritoObject(clienteID))[0];
        return Response.json(carrito.items, CORS_HEADERS)
    }

    async addItemsToCarrito(clienteID: string, items: DetalleFactura[]) {
        const carrito = (await this.getOrCreateCarritoObject(clienteID))[0];
        for (const item of items) {
            item.fk_venta = carrito.eid
            await sql`INSERT INTO Detalle_Factura ${sql(item)}
                ON CONFLICT (fk_venta, fk_cerveza, fk_presentacion)
                DO UPDATE SET
                cantidad = ${item.cantidad}`
        }
        return await this.getCarrito(clienteID);
    }

    async removeItemsFromCarrito(clienteID: string, items: DetalleFactura[]) {
        const maybeCarrito = await this.getCarritoObject(clienteID);
        if (maybeCarrito.length === 0)
            return new Response('', { status: 204, ...CORS_HEADERS })
        const carrito = maybeCarrito[0]
        for (const item of items) {
            item.fk_venta = carrito.eid
            await sql`DELETE FROM Detalle_Factura
                WHERE fk_venta = ${carrito.eid}
                AND fk_cerveza = ${item.fk_cerveza}
                AND fk_presentacion = ${item.fk_presentacion}`;
        }
        return await this.getCarrito(clienteID);
    }

    async getDailyTasa() {
        return await sql`SELECT eid FROM Tasa_Cambio WHERE fecha_fin IS NULL LIMIT 1`;
    }

    async getPaymentsFromCarrito(clienteID: string) {
        const carrito = (await this.getOrCreateCarritoObject(clienteID))[0];
        return Response.json(carrito.payments, CORS_HEADERS)
    }

    async registerPaymentForCarrito(clienteID: string, payments: Pago[]) {
        const carrito = (await this.getOrCreateCarritoObject(clienteID))[0];
        const tasa = (await this.getDailyTasa())[0]
        for (const pay of payments) {
            pay.fk_tasa_cambio = tasa.eid
            pay.fk_venta = carrito.eid;
            await sql`INSERT INTO Pago ${sql(pay)}`;
        }
        return await this.getCarrito(clienteID);
    }

    async markAsComplete(clienteID: string) {
        const res = await this.getCarritoObject(clienteID);
        if (res.length === 0)
            return new Response('', { status: 204, ...CORS_HEADERS })
        const carrito = res[0];
        await sql`UPDATE ESTA_VENT SET fecha_fin = CURRENT_DATE WHERE fk_venta = ${carrito.eid} AND fk_estatus = 100`;
        const estatus = await sql`INSERT INTO ESTA_VENT (fecha_inicio, fk_venta, fk_estatus)
            VALUES(CURRENT_DATE, ${carrito.eid}, 3) RETURNING *`; // HACK: 3 es Pagado
        return Response.json(estatus, { status: 200, ...CORS_HEADERS })
    }

    async handlePaymentInsertData(insert_data: any) {
        const metodo_id = await sql`INSERT INTO Metodo_Pago DEFAULT VALUES RETURNING eid`
        insert_data.fk_metodo_pago = metodo_id[0].eid
        await sql`INSERT INTO Tarjeta ${sql(insert_data)}`
        const payment: Pago = { fk_metodo_pago: metodo_id[0].eid, monto: 0, fk_venta: 0, fk_tasa_cambio: 0 }
        return payment
    }

    routes = {
        "/api/carrito/:clientID": {
            OPTIONS: () => new Response('Departed', CORS_HEADERS),
            GET: async (req: any, _: any) => await this.getCarrito(req.params.clientID),
            POST: async (req: any, _: any) => await this.createCarrito(req.params.clientID),
            DELETE: async (req: any, _: any) => await this.deleteCarrito(req.params.clientID),
        },
        "/api/carrito/:clientID/items": {
            OPTIONS: () => new Response('Departed', CORS_HEADERS),
            GET: async (req: any, _: any) => await this.getItemsFromCarrito(req.params.clientID),
            POST: async (req: any, _: any) => {
                const items = await req.json()

                if ('insert_data' in items)
                    return this.addItemsToCarrito(req.params.clientID, [items.insert_data])

                return this.addItemsToCarrito(req.params.clientID, items)
            },
            DELETE: async (req: any, _: any) => {
                const items = await req.json()
                return this.removeItemsFromCarrito(req.params.clientID, items)
            },
        },
        "/api/carrito/:clientID/pay": {
            OPTIONS: () => new Response('Departed', CORS_HEADERS),
            GET: async (req: any, _: any) => await this.getPaymentsFromCarrito(req.params.clientID),
            POST: async (req: any, _: any) => {
                const payments = await req.json()
                if ('insert_data' in payments) {
                    const payment = await this.handlePaymentInsertData(payments.insert_data)
                    return await this.registerPaymentForCarrito(req.params.clientID, [payment])
                }
                return this.registerPaymentForCarrito(req.params.clientID, payments)
            },
        },
        "/api/carrito/:clientID/complete": {
            OPTIONS: () => new Response('Departed', CORS_HEADERS),
            GET: async (req: any, _: any) => await this.markAsComplete(req.params.clientID),
        },
    }
}

export default new CarritoService();