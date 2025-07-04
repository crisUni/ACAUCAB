import { sql } from "bun";
import { CORS_HEADERS } from "..";
import UsuarioService from "./UsuarioService";

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

type EvenClie ={
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
  async postEvenClieSQL(even_clie: EvenClie): Promise<Array<object>> {
    return await sql`INSERT INTO EVEN_CLIE ${sql(even_clie)} RETURNING *`;
  };

  // get clients in event
  async isClienteInEvento(clienteID: Number, eventoID: Number): Promise<Boolean> {
    const evenClie = await sql`
    SELECT * 
    FROM EVEN_CLIE 
    WHERE fk_cliente = ${clienteID} AND fk_evento = ${eventoID}`;
    if (evenClie.length == 0) { return false;}
    else {return true;}
  }

  async getEventoParticipantsSQL(eventoID: Number) {
    return await sql`
      SELECT c.eid, c.rif, ec.cantidad_entradas
      FROM CLIENTE c, EVEN_CLIE ec
      WHERE c.eid = ec.fk_cliente 
      AND ec.fk_evento = ${eventoID}
      `;
  }

  async getClienteEventosSQL(clienteID: Number) {
    return await sql`
      select e.* 
      from evento e, even_clie ec
      WHERE ec.fk_cliente = ${clienteID} 
      AND ec.fk_evento = e.eid;
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
        const id = await UsuarioService.getClientIDfromUserID(req.params.userID)
        if (id.length === 0)
            return new Response('', { ...CORS_HEADERS, status: 204 })
        console.log("HELLO WORLD")

        const body = await req.json();
        const even_clie = {
          fk_evento: req.params.eventoID,
          fk_cliente: id[0].eid,
          cantidad_entradas: body.insert_data.numero_entradas,
        }
        const res = this.postEvenClieSQL(even_clie);
        return Response.json(res, CORS_HEADERS);
      },
    },
  }
}

export default new EventoService();