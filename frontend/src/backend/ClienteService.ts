import { sql } from "bun";

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

const ClienteService = {
    getNaturalesSQL: async function(): Promise<Array<any>> {
        return await sql`
        SELECT c.*, pn.*
        FROM cliente AS c
        JOIN pnatural AS pn ON c.eid = pn.fk_cliente 
        `;
    },

    getJuridicoSQL: async function(): Promise<Array<any>> {
        return await sql`
        SELECT c.*, pj.*
        FROM cliente AS c
        JOIN pjuridico AS pj ON c.eid = pj.fk_cliente 
        `;
    },

    postClienteSQL: async function(cliente: Cliente): Promise<Array<object & { eid: Number }>> {
        return await sql`INSERT INTO Cliente ${sql(cliente)} RETURNING *`;
    },

    postNaturalSQL: async function(cliente: Cliente, natural: Natural): Promise<any> {
        const eid = await this.postClienteSQL(cliente);
        natural.fk_cliente = eid[0].eid;
        return await sql`INSERT INTO pnatural ${sql(natural)} RETURNING *`
    },

    postJuridicoSQL: async function(cliente: Cliente, juridico: Juridico): Promise<any> {
        const eid = await this.postClienteSQL(cliente);
        juridico.fk_cliente = eid[0].eid;
        return await sql`INSERT INTO pjuridico ${sql(juridico)} RETURNING *`
    },

    insertClienteNatural: async function(data: Cliente & Natural) {
        const res = await ClienteService.postNaturalSQL({
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
    },

    insertClienteJuridico: async function(data: Cliente & Juridico) {
        const res = await ClienteService.postJuridicoSQL({
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
    },

    getClienteNaturalForm: async function() {
        const res = await sql`
          SELECT c.eid||','||n.eid AS "eid", c.rif||': '||n.nombre||' '||n.cedula AS "displayName"
          FROM cliente as c
          JOIN pnatural as n on c.eid = n.fk_cliente`
        return res;
    },

    getClienteJuridicoForm: async function() {
        const res = await sql`
          SELECT c.eid||','||j.eid AS "eid", c.rif||': '||j.denominacion_comercial AS "displayName"
          FROM cliente as c
          JOIN pjuridico as j on c.eid = j.fk_cliente`
        return res;
    }
}

export default ClienteService;