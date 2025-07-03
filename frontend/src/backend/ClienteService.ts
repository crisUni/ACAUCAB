import { sql } from "bun";
import { CORS_HEADERS } from "..";
import UsuarioService from "./UsuarioService";
import EventoService from "./EventoService";

type DateString = `${number}${number}${number}${number}-${number}${number}-${number}${number}`;

type Cliente = {
    rif: String,
    direccion: String,
    numero_registro: Number,
    fk_lugar_1: Number
};

type Natural = {
    fk_cliente?: Number,
    cedula: Number,
    nombre: String,
    apellido: String,
    fecha_nacimiento: DateString,
};

type Juridico = {
    fk_cliente?: Number, 
    denominacion_comercial: String,
    razon_social: String,
    pagina_web: String,
    capital_disponible: Number,
    fk_lugar_2: Number,
}

class ClienteService {
    async getNaturalesSQL(): Promise<Array<any>> {
        return await sql`
        SELECT c.rif, c.direccion, c.numero_registro, COALESCE(p.nombre, m.nombre, e.nombre) AS "fk_lugar_1", pn.*
        FROM cliente AS c
        JOIN pnatural AS pn ON c.eid = pn.fk_cliente 
        JOIN Lugar AS p ON p.eid = c.fk_lugar_1
        JOIN Lugar AS m ON m.eid = c.fk_lugar_1
        JOIN Lugar AS e ON e.eid = c.fk_lugar_1`;
    }

    async getJuridicoSQL(): Promise<Array<any>> {
        return await sql`
        SELECT c.rif, c.direccion, c.numero_registro, COALESCE(p.nombre, m.nombre, e.nombre) AS "fk_lugar_1", pj.*, COALESCE(pp.nombre, mm.nombre, ee.nombre) AS "fk_lugar_2"
        FROM cliente AS c
        JOIN pjuridico AS pj ON c.eid = pj.fk_cliente 
        JOIN Lugar AS p ON p.eid = c.fk_lugar_1
        JOIN Lugar AS m ON m.eid = c.fk_lugar_1
        JOIN Lugar AS e ON e.eid = c.fk_lugar_1
        JOIN Lugar AS pp ON pp.eid = pj.fk_lugar_2
        JOIN Lugar AS mm ON mm.eid = pj.fk_lugar_2
        JOIN Lugar AS ee ON ee.eid = pj.fk_lugar_2`;
    }

    async postClienteSQL(cliente: Cliente): Promise<Array<object & { eid: Number }>> {
        return await sql`INSERT INTO Cliente ${sql(cliente)} RETURNING *`;
    }

    async postNaturalSQL(cliente: Cliente, natural: Natural): Promise<any> {
        const eid = await this.postClienteSQL(cliente);
        natural.fk_cliente = eid[0].eid;
        return await sql`INSERT INTO pnatural ${sql(natural)} RETURNING *`
    }

    async postJuridicoSQL(cliente: Cliente, juridico: Juridico): Promise<any> {
        const eid = await this.postClienteSQL(cliente);
        juridico.fk_cliente = eid[0].eid;
        return await sql`INSERT INTO pjuridico ${sql(juridico)} RETURNING *`
    }

    async insertClienteNatural(data: Cliente & Natural) {
        const res = await this.postNaturalSQL({
          rif: data.rif,
          direccion: data.direccion,
          numero_registro: data.numero_registro,
          fk_lugar_1: data.fk_lugar_1,
          
        }, {
          cedula: data.cedula,
          nombre: data.nombre,
          apellido: data.apellido,
          fecha_nacimiento: data.fecha_nacimiento
        })
        return res;
    }

    async insertClienteJuridico(data: Cliente & Juridico) {
        const res = await this.postJuridicoSQL({
          rif: data.rif,
          direccion: data.direccion,
          numero_registro: data.numero_registro,
          fk_lugar_1: data.fk_lugar_1
        }, {
          denominacion_comercial: data.denominacion_comercial,
          razon_social: data.razon_social,
          pagina_web: data.pagina_web,
          capital_disponible: data.capital_disponible,
          fk_lugar_2: data.fk_lugar_2
        })
        return res;
    }

    async getClienteNaturalForm() {
        const res = await sql`
          SELECT c.eid||','||n.eid AS "eid", c.rif||': '||n.nombre||' '||n.cedula AS "displayName"
          FROM cliente as c
          JOIN pnatural as n on c.eid = n.fk_cliente`
        return res;
    }

    async getClienteJuridicoForm() {
        const res = await sql`
          SELECT c.eid||','||j.eid AS "eid", c.rif||': '||j.denominacion_comercial AS "displayName"
          FROM cliente as c
          JOIN pjuridico as j on c.eid = j.fk_cliente`
        return res;
    }

    routes = {
        "/api/cliente/:clienteID/events": {
            GET: async (req: any) => {
                const id = await UsuarioService.getClientIDfromUserID(req.params.clienteID)
                if (id.length === 0)
                    return new Response('', { ...CORS_HEADERS, status: 204 })
                const res = await EventoService.getClienteEventosSQL(Number(id[0].eid))
                return Response.json(res, CORS_HEADERS)
            }
        }
    }
}

export default new ClienteService();