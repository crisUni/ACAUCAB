import { serve, sql } from "bun";

import index from "./index.html";
import home from "./pages/home.html"
import users from "./pages/crud_user.html"
import ClienteService from "./backend/ClienteService";

const CORS_HEADERS = {
  headers: {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, OPTIONS, POST, DELETE, PUT',
    'Access-Control-Allow-Headers': 'Content-Type',
  },
};
const server = serve({
  routes: {
    // Serve index.html for all unmatched routes.
    "/*": index,

    "/api/get_users": {
      OPTIONS: () => new Response('Departed', CORS_HEADERS),
      async GET(req) {
        const res = await sql`SELECT * FROM Usuario`;
        return Response.json(res, CORS_HEADERS);
      }
    },

    "/api/form/user_creation": {
      async GET() {
        const res = await sql`
          SELECT c.eid||',null,null' AS "eid", 'Cliente Natural: '||c.rif||': '||n.nombre||' '||n.cedula AS "displayName"
          FROM cliente as c
          JOIN pnatural as n on c.eid = n.fk_cliente
          UNION
          SELECT c.eid||',null,null' AS "eid", 'Cliente Juridico: '||c.rif||': '||d.razon_social AS "displayName"
          FROM cliente as c
          JOIN pjuridico as d on c.eid = d.fk_cliente
          UNION
          SELECT 'null,'||e.eid||',null' AS "eid", 'Empleado: '||e.primer_nombre AS "displayName"
          FROM empleado as e
          UNION 
          SELECT 'null,null,'||p.eid AS "eid",'Proveedor: '|| p.denominacion_comercial AS "displayName"
          FROM proveedor as p
        `
        return Response.json(res, CORS_HEADERS);
      },
    },

        "/api/cervezas": {
      async GET() {
        const res = await sql`SELECT * FROM Cerveza`;
        return Response.json(res, CORS_HEADERS);
      }
    },

    "/api/form/pnatural": {
      async GET() {
        const res = await sql`
          SELECT c.eid||','||n.eid AS "eid", c.rif||': '||n.nombre||' '||n.cedula AS "displayName"
          FROM cliente as c
          JOIN pnatural as n on c.eid = n.fk_cliente
        `
        return Response.json(res, CORS_HEADERS);
      },
    },

    "/api/form/parroquias": {
      async GET() {
        const res = await sql`
          SELECT p.eid as eid, e.nombre || ', ' || m.nombre || ', ' || p.nombre as "displayName"
          FROM Lugar AS e
          JOIN Lugar AS m ON e.eid = m.fk_lugar
          JOIN Lugar AS p ON m.eid = p.fk_lugar
        `
        return Response.json(res, CORS_HEADERS);
      },
    },

    "/api/form/roles": {
      async GET() {
        const res = await sql`
          SELECT eid AS "eid", nombre AS "displayName"
          FROM Rol
        `
        return Response.json(res, CORS_HEADERS);
      },
    },

    "/api/cliente_natural": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async GET() { return Response.json(await ClienteService.getNaturalesSQL(), CORS_HEADERS); },
      async POST(req: Bun.BunRequest) {
        const body = await req.json()
        const res = ClienteService.postNaturalSQL({
          rif: body.insert_data.rif,
          direccion: body.insert_data.direccion,
          numero_registro: body.insert_data.numero_registro,
          fk_lugar_1: body.insert_data.fk_lugar_1,
          fk_lugar_2: body.insert_data.fk_lugar_2
        }, {
          cedula: body.insert_data.cedula,
          nombre: body.insert_data.nombre,
          apellido: body.insert_data.apellido,
          fecha_nacimiento: body.insert_data.fecha_nacimiento
        })
        return Response.json(res, CORS_HEADERS);
      }
    },

    "/api/cliente_juridico": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async GET() { return Response.json(await ClienteService.getJuridicoSQL(), CORS_HEADERS); },
      async POST(req: Bun.BunRequest) {
        const body = await req.json()
        const res = ClienteService.postJuridicoSQL({
          rif: body.insert_data.rif,
          direccion: body.insert_data.direccion,
          numero_registro: body.insert_data.numero_registro,
          fk_lugar_1: body.insert_data.fk_lugar_1,
          fk_lugar_2: body.insert_data.fk_lugar_2
        }, {
          denominacion_comercial: body.insert_data.denominacion_comercial,
          razon_social: body.insert_data.razon_social,
          pagina_web: body.insert_data.pagina_web,
          capital_disponible: body.insert_data.capital_disponible
        })
        return Response.json(res, CORS_HEADERS);
      }
    },

    "/api/roles": {
      async POST(req: Bun.BunRequest) {
        const body = await req.json();
        const res = await sql`INSERT INTO Rol ${sql(body.insert_data)} RETURNING *`;
        return Response.json(res, CORS_HEADERS);
      }
    },

    "/api/usuario": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async POST(req: Bun.BunRequest) {
        const body = await req.json();
        const res = await sql`INSERT INTO Usuario ${sql(body.insert_data)} RETURNING *`
        return Response.json(res, CORS_HEADERS);
      },
    },
  },
  development: process.env.NODE_ENV !== "production" && {
    // Enable browser hot reloading in development
    hmr: true,

    // Echo console logs from the browser to the server
    console: true,
  },
});

console.log(`🚀 Server running at ${server.url}`);
