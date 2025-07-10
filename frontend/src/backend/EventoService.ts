import { sql } from "bun";
import { CORS_HEADERS } from "..";
import UsuarioService from "./UsuarioService";
import MetodoPagoService from "./MetodoPagoService";
import VentaService from "./VentaService";

function getCurrentDate(): string {
    const date = new Date();
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0'); // Months are zero-based
    const day = String(date.getDate()).padStart(2, '0');

    return `${year}-${month}-${day}`;
}

type Cliente = {
  rif: String,
  direccion: String,
  numero_registro: Number,
  fk_lugar_1: Number
};

type Evento = {
  nombre: String,
  descripcion: String,
  numero_entradas: Number,
  fecha_inicio: String,
  fecha_fin: String,
  direccion: String,
  precio_entradas: Number,
  fk_evento?: Number,
  fk_tipo_evento: Number,
  fk_lugar: Number
};

type EvenClie = {
  fk_evento: Number,
  fk_cliente: Number,
  cantidad_entradas: Number,

}

class EventoService {

  //  ███████ ██    ██ ███    ██  ██████ ████████ ██  ██████  ███    ██ ███████ 
  //  ██      ██    ██ ████   ██ ██         ██    ██ ██    ██ ████   ██ ██      
  //  █████   ██    ██ ██ ██  ██ ██         ██    ██ ██    ██ ██ ██  ██ ███████ 
  //  ██      ██    ██ ██  ██ ██ ██         ██    ██ ██    ██ ██  ██ ██      ██ 
  //  ██       ██████  ██   ████  ██████    ██    ██  ██████  ██   ████ ███████

  async getEventoSQL() {
    return await sql`
      SELECT *
      FROM Evento`;
  }

  async postEventoSQL(evento: Evento): Promise<Array<object & { eid: Number }>> {
    return await sql`INSERT INTO Evento ${sql(evento)} RETURNING *`;
  };

  // adds client to event
  async postEvenClieSQL(even_clie: EvenClie): Promise<any[]> {
    return await sql`INSERT INTO EVEN_CLIE ${sql(even_clie)}`;
  };

  // get clients in event
  async isClienteInEvento(clienteID: Number, eventoID: Number): Promise<Boolean> {
    const evenClie = await sql`
    SELECT * 
    FROM EVEN_CLIE 
    WHERE fk_cliente = ${clienteID} AND fk_evento = ${eventoID}`;
    if (evenClie.length == 0) { return false; }
    else { return true; }
  }

  async getEventoParticipantsSQL(eventoID: Number) {
    const res = await sql`
      SELECT c.eid, c.rif, COALESCE(pn.nombre||' '||pn.apellido, pj.denominacion_comercial) AS "nombre", ec.cantidad_entradas
      FROM CLIENTE AS c
      JOIN even_clie AS ec ON c.eid = ec.fk_cliente
      LEFT JOIN pnatural AS pn ON c.eid = pn.fk_cliente
      LEFT JOIN pjuridico AS pj ON c.eid = pj.fk_cliente
      WHERE ec.fk_evento = ${eventoID}`;
    return Response.json(res, CORS_HEADERS)
  }

  async getClienteEventosSQL(clienteID: Number) {
    return await sql`
      select e.*, ec.*
      from evento e
      JOIN even_clie ec ON ec.fk_evento = e.eid
      WHERE ec.fk_cliente = ${clienteID}
      `;
  }

  async getAllEvents() {
    const res = await this.getEventoSQL();
    return Response.json(res, CORS_HEADERS);
  }

  async getActivitiesInEvents(eventoID: string) {
    const res = await sql`SELECT * FROM Evento WHERE fk_evento = ${eventoID}`;
    return Response.json(res, CORS_HEADERS);
  }

  async getSpecificEvent(eventID: string) {
    const res = await sql`SELECT * FROM Evento WHERE eid = ${eventID} AND fk_evento IS NULL`
    return Response.json(res, CORS_HEADERS)
  }

  //  ██████   ██████  ██    ██ ████████ ███████ ███████ 
  //  ██   ██ ██    ██ ██    ██    ██    ██      ██      
  //  ██████  ██    ██ ██    ██    ██    █████   ███████ 
  //  ██   ██ ██    ██ ██    ██    ██    ██           ██ 
  //  ██   ██  ██████   ██████     ██    ███████ ███████

  routes = {
    "/api/evento": {
      OPTIONS: () => { return new Response('Departed', CORS_HEADERS) },
      GET: async (req: any) => await this.getAllEvents(),
      POST: async (req: any) => {
        const body = await req.json();
        const res = await this.postEventoSQL(body.insert_data);
        return Response.json(res, CORS_HEADERS);
      },
    },
    "/api/evento/:eventoID": {
      OPTIONS: () => { return new Response('Departed', CORS_HEADERS) },
      GET: async (req: any) => await this.getActivitiesInEvents(req.params.eventoID),
    },
    "/api/evento/:eventoID/data": {
      OPTIONS: () => { return new Response('Departed', CORS_HEADERS) },
      GET: async (req: any) => await this.getSpecificEvent(req.params.eventoID),
    },
    "/api/evento/:eventoID/participants": {
      OPTIONS: () => { return new Response('Departed', CORS_HEADERS) },
      GET: async (req: any) => await this.getEventoParticipantsSQL(req.params.eventoID),
    },
    "/api/evento/:eventoID/:userID": {
      OPTIONS: () => { return new Response('Departed', CORS_HEADERS) },
      GET: async (req: any) => {
        const res = await this.getAllEvents()
        return Response.json(res, CORS_HEADERS);
      },
      POST: async (req: any) => {
        const body = await req.json();
        body.insert_data.userID
        const res = this.postEvenClieSQL(body.insert_data);
        return Response.json(res, CORS_HEADERS);
      },
    },
    "/api/evento/:eventoID/:userID/join": {
      OPTIONS: () => { return new Response('Departed', CORS_HEADERS) },
      POST: async (req: any) => {
        const clientID = await UsuarioService.getClientIDfromUserID(req.params.userID)
        if (clientID === 0)
          return new Response('', { ...CORS_HEADERS, status: 204 })

        const body = await req.json();

        if ('precio_entrada' in body.insert_data) {
          const tarjeta_id = await MetodoPagoService.insertTarjeta({
            fk_banco: body.insert_data.fk_banco,
            fk_tipo_tarjeta: body.insert_data.fk_tipo_tarjeta,
            numero_tarjeta: body.insert_data.numero_tarjeta,
            fecha_vence: body.insert_data.fecha_vence,
            nombre_titular: body.insert_data.nombre_titular,
            cvv: body.insert_data.cvv,
          })

          const venta_id = await VentaService.createAndGetNewVenta({
            fecha: getCurrentDate(),
            monto_total: Number(body.insert_data.numero_entradas) * Number(body.insert_data.precio_entrada),
            fk_cliente: clientID
          })

          await VentaService.registrarPagoAVenta({
            fk_metodo_pago: tarjeta_id,
            fk_venta: venta_id,
            monto: Number(body.insert_data.numero_entradas) * Number(body.insert_data.precio_entrada)
          })
        }

        const even_clie = {
          fk_evento: req.params.eventoID,
          fk_cliente: clientID,
          cantidad_entradas: body.insert_data.numero_entradas,
        }

        const res = await this.postEvenClieSQL(even_clie);
        return Response.json(res, CORS_HEADERS);
      },
    },
  }
}

export default new EventoService();