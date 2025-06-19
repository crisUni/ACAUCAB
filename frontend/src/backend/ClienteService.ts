import { sql } from "bun";

type DateString = `${number}${number}${number}${number}-${number}${number}-${number}${number}`;

type Cliente = {
    rif: String,
    direccion: String,
    numero_registro: Number,
    fk_lugar_1: Number,
    fk_lugar_2: Number,
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
    capital_disponible: Number
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
    }
}

export default ClienteService;