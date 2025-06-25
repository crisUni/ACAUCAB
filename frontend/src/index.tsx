import { serve, sql } from "bun";

import index from "./index.html";
import home from "./pages/home.html"
import users from "./pages/crud_user.html"
import ClienteService from "./backend/ClienteService";
import RolManagementService from "./backend/RolManagementService";
import VentaService from "./backend/VentaService";

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

    "/api/form/clientes": {
      async GET() {
        const natu = await ClienteService.getClienteNaturalForm();
        const juri = await ClienteService.getClienteJuridicoForm();
        return Response.json([...natu, ...juri], CORS_HEADERS);
      },
    },

    "/api/form/pnatural": {
      async GET() {
        const res = await ClienteService.getClienteNaturalForm();
        return Response.json(res, CORS_HEADERS);
      },
    },

    "/api/form/pjuridico": {
      async GET() {
        const res = await ClienteService.getClienteJuridicoForm();
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
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async GET() {
        return Response.json(await RolManagementService.getRolSQL(), CORS_HEADERS);
      },
    },

    "/api/form/providers": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async GET() {
        const res = await sql`
          SELECT eid AS "eid", denominacion_comercial ||' / '|| razon_social AS "displayName"
          FROM Proveedor`;
        return Response.json(res, CORS_HEADERS)
      },
    },

    "/api/form/inve_tien": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async GET(req, _) {
        const res = await sql`
          SELECT CAST(IT.fk_cerveza AS text)||','||CAST(IT.fk_presentacion AS Text)||','||CAST(IT.fk_tienda AS text)||','||CAST(IT.fk_lugar_tienda as text) AS "eid",
          C.nombre||': '||P.nombre AS "displayName"
          FROM INVE_TIEN as IT
          JOIN Cerveza as C on IT.fk_cerveza = C.eid
          JOIN Presentacion as P on IT.fk_presentacion = P.eid`;
        return Response.json(res, CORS_HEADERS)
      },
    },

    "/api/form/inve_tien/:proveedor": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async GET(req, _) {
        const proveedor = req.params.proveedor;
        const res = await sql`
          SELECT CAST(IT.fk_cerveza AS text)||','||CAST(IT.fk_presentacion AS Text)||','||CAST(IT.fk_tienda AS text)||','||CAST(IT.fk_lugar_tienda as text) AS "eid",
          C.nombre||': '||P.nombre AS "displayName"
          FROM INVE_TIEN as IT
          JOIN Cerveza as C on IT.fk_cerveza = C.eid
          JOIN Presentacion as P on IT.fk_presentacion = P.eid
          WHERE C.fk_proveedor = ${proveedor}
          ;`;
        return Response.json(res, CORS_HEADERS)
      },
    },

    "/api/form/metodo_pago": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async GET(req, _) {
        const res = await sql`
          SELECT M.eid AS "eid", 'Tarjeta: '||T.nombre_titular||', '||T.numero_tarjeta AS "displayName"
          FROM Metodo_pago AS M
          JOIN Tarjeta AS T on T.fk_metodo_pago = M.eid
          UNION
          SELECT M.eid AS "eid", 'Cheque: '||C.numero AS "displayName"
          FROM Metodo_pago AS M
          JOIN Cheque AS C on C.fk_metodo_pago = M.eid
          UNION
          SELECT M.eid AS "eid", E.tipo_moneda||': '||E.denominacion AS "displayName"
          FROM Metodo_pago AS M
          JOIN Efectivo AS E on E.fk_metodo_pago = M.eid
          UNION
          SELECT M.eid AS "eid", 'Canjeo de Puntos' AS "displayName"
          FROM Metodo_pago AS M
          JOIN Punto AS P on P.fk_metodo_pago = M.eid
        `
        return Response.json(res, CORS_HEADERS)
      }
    },

    "/api/roles": {
      async POST(req: Bun.BunRequest) {
        const body = await req.json();
        const res = await RolManagementService.postRolSQL(body.insert_data);
        return Response.json(res, CORS_HEADERS);
      },
      async DELETE(req, _) {
        const body = await req.json()
        const res = await RolManagementService.deleteRolSQL(body.insert_data)
        return Response.json(res, CORS_HEADERS);
      },

    },

    "/api/privilegios/:rol": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async GET(req) {
        const rol = req.params.rol;
        const missing = new URL(req.url).searchParams.get("missing");
        let res;
        if (missing === "true")
          res = await sql`
            SELECT eid as "eid", nombre||': '||descripcion as "displayName"
            FROM privilegio where eid NOT IN (SELECT fk_privilegio
            FROM Privilegio p, ROL_PRIV rp
            WHERE rp.fk_privilegio = p.eid AND rp.fk_rol = ${Number(rol)})`
        else
          res = await sql`
            SELECT eid as "eid", nombre||': '||descripcion as "displayName"
            FROM privilegio WHERE eid IN (SELECT fk_privilegio
            FROM Privilegio p, ROL_PRIV rp
            WHERE rp.fk_privilegio = p.eid AND rp.fk_rol = ${Number(rol)})`
        return Response.json(res, CORS_HEADERS);
      },
      async POST(req, _) {
        const body = await req.json()
        const rol_id = req.params.rol;
        const res = await RolManagementService.postRolPrivSQL({ fk_privilegio: body.insert_data.fk_priv, fk_rol: Number(rol_id) })
        return Response.json(res, CORS_HEADERS);
      },
      async DELETE(req, _) {
        const body = await req.json()
        const rol_id = req.params.rol;
        const res = await RolManagementService.deleteRolPrivSQL({ fk_privilegio: body.insert_data.fk_priv, fk_rol: Number(rol_id) })
        return Response.json(res, CORS_HEADERS);
      },
    },

    "/api/cliente_natural": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async GET() { return Response.json(await ClienteService.getNaturalesSQL(), CORS_HEADERS); },
      async POST(req: Bun.BunRequest) {
        const body = await req.json();
        const res = await ClienteService.insertClienteNatural(body.insert_data);
        return Response.json(res, CORS_HEADERS);
      }
    },

    "/api/cliente_juridico": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async GET() { return Response.json(await ClienteService.getJuridicoSQL(), CORS_HEADERS); },
      async POST(req: Bun.BunRequest) {
        const body = await req.json();
        const res = await ClienteService.insertClienteJuridico(body.insert_data);
        return Response.json(res, CORS_HEADERS);
      }
    },

    "/api/priv": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async GET() {
        console.log("hello")
        return Response.json(await RolManagementService.getPrivilegioSQL(), CORS_HEADERS);
      },
      async POST(req: Bun.BunRequest) {
        const body = await req.json();
        const res = RolManagementService.postPrivilegioSQL(body.insert_data);
        return Response.json(res, CORS_HEADERS);
      },
      async DELETE(req, _) {
        const body = await req.json()
        const res = await RolManagementService.deletePrivilegioSQL(Number(body.insert_data.eid))
        return Response.json(res, CORS_HEADERS);
      },
    },

    "/api/usuario": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async POST(req: Bun.BunRequest) {
        const body = await req.json();
        const res = await sql`INSERT INTO Usuario ${sql(body.insert_data)} RETURNING *`
        return Response.json(res, CORS_HEADERS);
      },
    },

    "/api/venta": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async GET() { return Response.json(await VentaService.getVentaSQL(), CORS_HEADERS); },
    },

    "/api/venta/detalle/:id": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async GET(req, _) {
        const id = req.params.id;
        return Response.json(await (sql`SELECT * FROM Detalle_factura WHERE fk_venta = ${id}`), CORS_HEADERS);
      },
    },

    "/api/venta/pagos/:id": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async GET(req, _) {
        const id = req.params.id;
        return Response.json(await (sql`SELECT * FROM Pago WHERE fk_venta = ${id}`), CORS_HEADERS);
      },
    },

    "/api/compra": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async GET() { return Response.json(await (sql`SELECT * FROM Compra`), CORS_HEADERS); },

    },

    "/api/compra/:id": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async GET(req, _) {
        const id = req.params.id;
        return Response.json(await (sql`SELECT * FROM Detalle_compra WHERE fk_compra = ${id}`), CORS_HEADERS);
      },

    },

    "/api/compra/nueva/:proveedorId": {
      async POST(req, _) {
        const body = await req.json()
        const compra = (await sql`insert into compra(fecha, monto_total, fk_proveedor) values (CURRENT_DATE, 0, ${req.params.proveedorId}) returning *`)[0]
        for (const idx in body.insert_data.cantidad) {
          const { precio } = (await sql`select precio from cerv_pres where fk_cerveza = ${body.insert_data.fk_cerveza[idx]} and fk_presentacion = ${body.insert_data.fk_presentacion[idx]}`)[0];
          const detalle_compra = {
            cantidad: Number(body.insert_data.cantidad[idx]),
            precio_unitario: precio,
            fk_compra: Number(compra.eid),
            fk_cerveza:  Number(body.insert_data.fk_cerveza[idx]),
            fk_presentacion: Number(body.insert_data.fk_presentacion[idx]),
          }
          await sql`INSERT INTO Detalle_Compra ${sql(detalle_compra)}`
        }
        return Response.json(compra, CORS_HEADERS)
      }
    }

  },
  development: process.env.NODE_ENV !== "production" && {
    // Enable browser hot reloading in development
    hmr: true,

    // Echo console logs from the browser to the server
    console: true,
  },
});

console.log(`🚀 Server running at ${server.url}`);
