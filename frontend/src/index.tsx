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

    "/api/cliente_natural": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async GET() { return Response.json(await ClienteService.getNaturalesSQL(), CORS_HEADERS); },
      async POST(req: Bun.BunRequest) {
        const body = await req.json()
        const res = ClienteService.postNaturalSQL({
          rif: body.insert_data.rif,
          direccion: body.insert_data.direccion,
          numero_registro: body.insert_data.numero_registro,
          fk_lugar_1: 1562,
          fk_lugar_2: 1562,
        }, {
          cedula: body.insert_data.cedula,
          nombre: body.insert_data.nombre,
          apellido: body.insert_data.apellido,
          fecha_nacimiento: body.insert_data.fecha_nacimiento,
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
          fk_lugar_1: 1562,
          fk_lugar_2: 1562,
        }, {
          denominacion_comercial: body.insert_data.denominacion_comercial,
          razon_social: body.insert_data.razon_social,
          pagina_web: body.insert_data.pagina_web,
          capital_disponible: body.insert_data.capital_disponible
        })
        return Response.json(res, CORS_HEADERS);
      }
    },

    "/api/get_parroquias": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async GET() {
        const res = await sql`
          SELECT p.eid as eid, e.nombre || ', ' || m.nombre || ', ' || p.nombre as lugar
          FROM Lugar AS e
          JOIN Lugar AS m ON e.eid = m.fk_lugar
          JOIN Lugar AS p ON m.eid = p.fk_lugar
        `;
        return Response.json(res, CORS_HEADERS);
      }
    },

    "/api/hello": {
      async GET(req) {
        return Response.json({
          message: "Hello, world!",
          method: "GET",
        });
      },
      async PUT(req) {
        return Response.json({
          message: "Hello, world!",
          method: "PUT",
        });
      },
    },

    "/api/hello/:name": async req => {
      const name = req.params.name;
      return Response.json({
        message: `Hello, ${name}!`,
      });
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
