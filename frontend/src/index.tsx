import { serve, sql } from "bun";

import index from "./index.html";
import home from "./pages/home.html"
import users from "./pages/crud_user.html"
import ClienteService from "./backend/ClienteService";
import RolManagementService from "./backend/RolManagementService";
import VentaService from "./backend/VentaService";
import CarritoService from "./backend/CarritoService";
import EventoService from "./backend/EventoService";

import { reporteIngresosEventos, reporteProductosPromocion, reportePuntualidadPorCargo, reporteRankingProveedores, reporteValorPuntosCanjeados } from "./backend/reportes";

function generateUserToken(length: number = 32): string {
  const characters = '0123456789abcdef';
  let token = '';
  for (let i = 0; i < length; i++) {
    const randomIndex = Math.floor(Math.random() * characters.length);
    token += characters[randomIndex];
  }
  return token;
}

const user_tokens: { [key: string]: number } = {}

const CORS_HEADERS = {
  headers: {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, OPTIONS, POST, DELETE, PUT',
    'Access-Control-Allow-Headers': '*',
  },
};

console.log("Running Bun Backend in port 3000!!!")

const server = serve({
  routes: {
    // Serve index.html for all unmatched routes.
    "/*": index,

    "/api/getUser/:token": {
      GET: (req) => {
        const user = user_tokens[req.params.token]
        return Response.json(user, CORS_HEADERS)
      }
    },

    ...CarritoService.routes,
    ...EventoService.routes,

    //    ███████  ██████  ██████  ███    ███ 
    //    ██      ██    ██ ██   ██ ████  ████ 
    //    █████   ██    ██ ██████  ██ ████ ██ 
    //    ██      ██    ██ ██   ██ ██  ██  ██ 
    //    ██       ██████  ██   ██ ██      ██

    "/api/form/tipo_evento": {
      GET: async () => {
        const res = await sql`select eid, nombre AS "displayName" from tipo_evento;`;
        return Response.json(res, CORS_HEADERS);
      }
    },

    "/api/form/usuarios": {
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
        const res = await sql`
          SELECT c.eid AS "eid", c.rif||': '||n.nombre||' '||n.cedula AS "displayName"
          FROM cliente as c
          JOIN pnatural as n on c.eid = n.fk_cliente
          UNION
          SELECT c.eid AS "eid", c.rif||': '||j.denominacion_comercial AS "displayName"
          FROM cliente as c
          JOIN pjuridico as j on c.eid = j.fk_cliente`;
        return Response.json(res, CORS_HEADERS);
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

    "/api/form/privilegios": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async GET() {
        return Response.json(await RolManagementService.getPrivilegioSQL(), CORS_HEADERS);
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
          (SELECT M.eid AS "eid", 'Canjeo de Puntos' AS "displayName"
          FROM Metodo_pago AS M
          JOIN Punto AS P on P.fk_metodo_pago = M.eid
          LIMIT 1)
          UNION
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
          JOIN Efectivo AS E on E.fk_metodo_pago = M.eid`;
        return Response.json(res, CORS_HEADERS)
      }
    },

    "/api/form/privilegios/:rol": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async GET(req) {
        const rol = req.params.rol;
        const missing = new URL(req.url).searchParams.get("missing");
        let res;
        if (missing === "true")
          res = await sql`
            SELECT eid as "eid", eid ||' '|| nombre ||': '|| descripcion as "displayName"
            FROM privilegio where eid NOT IN (SELECT fk_privilegio
            FROM Privilegio p, ROL_PRIV rp
            WHERE rp.fk_privilegio = p.eid AND rp.fk_rol = ${Number(rol)})`
        else
          res = await sql`
            SELECT eid as "eid", eid ||' '|| nombre ||': '|| descripcion as "displayName"
            FROM privilegio WHERE eid IN (SELECT fk_privilegio
            FROM Privilegio p, ROL_PRIV rp
            WHERE rp.fk_privilegio = p.eid AND rp.fk_rol = ${Number(rol)})`
        return Response.json(res, CORS_HEADERS);
      },
    },

    // ████████ ██   ██ ███████     ██████  ███████ ███████ ████████        ██████  
    //    ██    ██   ██ ██          ██   ██ ██      ██         ██        ██ ██   ██ 
    //    ██    ███████ █████       ██████  █████   ███████    ██           ██████  
    //    ██    ██   ██ ██          ██   ██ ██           ██    ██        ██ ██      
    //    ██    ██   ██ ███████     ██   ██ ███████ ███████    ██           ██     


    "/api/login": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async POST(req: Bun.BunRequest) {
        const body = await req.json();
        const res = await sql`SELECT * FROM Usuario WHERE nombre = ${body.insert_data.nombre} AND contraseña = ${body.insert_data.contrasena} LIMIT 1`
        if (res.length > 0) {
          const token = generateUserToken()
          user_tokens[token] = res[0]
          res[0].token = token
          return Response.json(res, CORS_HEADERS);
        }

        return Response.json(res, CORS_HEADERS);
      },
    },

    "/api/roles": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async GET() {
        return Response.json(await RolManagementService.getAllRolSQL(), CORS_HEADERS);
      },
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
            SELECT eid, nombre, descripcion
            FROM privilegio where eid NOT IN (SELECT fk_privilegio
            FROM Privilegio p, ROL_PRIV rp
            WHERE rp.fk_privilegio = p.eid AND rp.fk_rol = ${Number(rol)})`
        else
          res = await sql`
            SELECT eid, nombre, descripcion
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
      async GET() {
        const res = await ClienteService.getNaturalesSQL()
        console.log(res)
        for (const cliente of res) {
          const puntos = (await sql`SELECT * FROM punt_clie WHERE fk_cliente = ${cliente.eid} order by eid limit 1`)[0];
          cliente.cantidad_puntos = puntos?.cantidad_puntos || 0;
        }
        return Response.json(res, CORS_HEADERS);
      },
      async POST(req: Bun.BunRequest) {
        const body = await req.json();
        const res = await ClienteService.insertClienteNatural(body.insert_data);
        return Response.json(res, CORS_HEADERS);
      }
    },

    "/api/cliente_juridico": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async GET() {
        const res = await ClienteService.getJuridicoSQL()
        for (const cliente of res) {
          const puntos = (await sql`SELECT * FROM punt_clie WHERE fk_cliente = ${cliente.eid} order by eid desc limit 1`)[0];
          cliente.cantidad_puntos = puntos?.cantidad_puntos || 0;
        }
        return Response.json(res, CORS_HEADERS);
      },
      async POST(req: Bun.BunRequest) {
        const body = await req.json();
        const res = await ClienteService.insertClienteJuridico(body.insert_data);
        return Response.json(res, CORS_HEADERS);
      },
    },

    "/api/priv": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async GET() {
        console.log("hello")
        return Response.json(await RolManagementService.getAllPrivilegioSQL(), CORS_HEADERS);
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
      async GET() {
        const res = await VentaService.getVentaSQL()
        return Response.json(res, CORS_HEADERS);
      },
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
      async GET() {
        const res = await sql`
          SELECT C.eid, C.fecha, C.monto_total, p.denominacion_comercial AS "fk_proveedor"
          FROM Compra as C
          JOIN Proveedor as P ON P.eid = C.fk_proveedor

        `;
        return Response.json(res, CORS_HEADERS);
      },

    },

    "/api/compra/:id": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async GET(req, _) {
        const id = req.params.id;
        const res = await sql`
        SELECT DC.eid, DC.cantidad, DC.precio_unitario, C.nombre AS "fk_cerveza", P.nombre AS "fk_presentacion"
        FROM Detalle_compra AS DC
        JOIN Cerveza AS C ON DC.fk_cerveza = C.eid
        JOIN Presentacion AS P ON DC.fk_presentacion = P.eid
        WHERE fk_compra = ${id}
        `
        return Response.json(res, CORS_HEADERS);
      },
    },

    "/api/venta/nueva/:clienteId": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async POST(req, _) {
        const body = await req.json()
        const venta = (await sql`insert into venta(fecha, monto_total, fk_tienda_fisica, fk_cliente) values (CURRENT_DATE, 0, 1, ${req.params.clienteId}) returning *`)[0]

        for (const idx in body.insert_data.cantidad) {
          const { precio } = (await sql`select precio from cerv_pres where fk_cerveza = ${body.insert_data.fk_cerveza[idx]} and fk_presentacion = ${body.insert_data.fk_presentacion[idx]}`)[0];
          const detalle_factura = {
            cantidad: Number(body.insert_data.cantidad[idx]),
            precio_unitario: precio,
            fk_venta: Number(venta.eid),
            fk_cerveza: Number(body.insert_data.fk_cerveza[idx]),
            fk_presentacion: Number(body.insert_data.fk_presentacion[idx]),
          }
          await sql`INSERT INTO Detalle_Factura ${sql(detalle_factura)}`
        }

        const tasa = (await sql`SELECT * FROM tasa_cambio WHERE fecha_fin IS NULL LIMIT 1`)[0];
        for (const idx in body.insert_data.monto) {
          const pago = {
            fk_metodo_pago: body.insert_data.fk_metodo_pago[idx],
            fk_venta: Number(venta.eid),
            fk_tasa_cambio: Number(tasa.eid),
            monto: body.insert_data.monto[idx]
          }
          await sql`INSERT INTO Pago ${sql(pago)}`;
        }

        return Response.json(venta, CORS_HEADERS)
      }
    },

    "/api/compra/set_pagada/:idCompra": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async GET(req, _) {
        const res = await sql`
        INSERT INTO ESTA_COMP (fk_estatus, fk_compra, fecha_inicio, fecha_fin)
          VALUES(3, ${req.params.idCompra}, CURRENT_DATE, NULL)`
        return Response.json({}, CORS_HEADERS)
      }
    },

    "/api/compra/nueva/:proveedorId": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async POST(req, _) {
        const body = await req.json()
        const compra = (await sql`insert into compra(fecha, monto_total, fk_proveedor) values (CURRENT_DATE, 0, ${req.params.proveedorId}) returning *`)[0]
        for (const idx in body.insert_data.cantidad) {
          const { precio } = (await sql`select precio from cerv_pres where fk_cerveza = ${body.insert_data.fk_cerveza[idx]} and fk_presentacion = ${body.insert_data.fk_presentacion[idx]}`)[0];
          const detalle_compra = {
            cantidad: Number(body.insert_data.cantidad[idx]),
            precio_unitario: precio,
            fk_compra: Number(compra.eid),
            fk_cerveza: Number(body.insert_data.fk_cerveza[idx]),
            fk_presentacion: Number(body.insert_data.fk_presentacion[idx]),
          }
          await sql`INSERT INTO Detalle_Compra ${sql(detalle_compra)}`
        }
        return Response.json(compra, CORS_HEADERS)
      }
    },

    "/api/puntos/:clienteID": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async GET(req, _) {
        const id = req.params.clienteID;
        const res = (await sql`SELECT * FROM punt_clie WHERE fk_cliente = ${id} order by eid limit 1`)[0]
        return Response.json(res, CORS_HEADERS);
      },
    },

    "/api/inventario_tienda": {
      OPTIONS() { return new Response('Departed', CORS_HEADERS) },
      async GET() {
        const res = await sql`
        SELECT c.nombre AS "fk_cerveza_display", c.eid AS "fk_cerveza",
        p.nombre AS "fk_presentacion_display", p.eid AS "fk_presentacion",
        lt.nombre AS "fk_lugar_tienda_display", lt.eid AS "fk_lugar_tienda",
        it.cantidad
        FROM inve_tien as it
        JOIN Cerveza as c on c.eid = it.fk_cerveza
        JOIN Presentacion as p on p.eid = it.fk_presentacion
        JOIN Lugar_Tienda as lt on lt.eid = it.fk_lugar_tienda
        ORDER BY it.cantidad DESC
        `;
        return Response.json(res, CORS_HEADERS);
      },
      async PUT(req, _) {
        const body = await req.json();
        const res = await sql`
          UPDATE INVE_TIEN
          SET cantidad = ${body.cantidad}
          WHERE fk_cerveza = ${body.fk_cerveza}
          AND fk_presentacion = ${body.fk_presentacion}
          
          AND fk_lugar_tienda = ${body.fk_lugar_tienda}
          RETURNING *`;
        // AND fk_tienda = ${body.fk_tienda}
        return Response.json(res, CORS_HEADERS);
      }
    },

    "/api/inventario_online": {
      GET: async () => {
        // Todos los items de CERV_PRES que tengan una cantidad en ALGUN inve_tien mayor a 100
        const res = await sql`SELECT CP.*, C.nombre AS "cerveza", P.nombre AS "presentacion"
        FROM CERV_PRES CP
        JOIN INVE_TIEN IT ON IT.fk_cerveza = CP.fk_cerveza AND IT.fk_presentacion = CP.fk_presentacion
        JOIN Cerveza C ON C.eid = CP.fk_cerveza
        JOIN Presentacion P ON P.eid = CP.fk_presentacion
        WHERE IT.cantidad > 100`
        return Response.json(res, CORS_HEADERS)
      }
    },

    "/api/item/:itemID": {
      GET: async (req: any) => {
        const [cerveza, presentacion] = req.params.itemID.split('_')
        const res = (await sql`SELECT C.nombre AS "nombre_cerveza", P.nombre AS "nombre_presentacion", *
          FROM CERV_PRES CP
          JOIN Cerveza C ON C.eid = CP.fk_cerveza
          JOIN Presentacion P ON P.eid = CP.fk_presentacion
          WHERE CP.fk_cerveza = ${cerveza}
          AND CP.fk_presentacion = ${presentacion} LIMIT 1`)
        return Response.json(res.length === 0 ? {} : res[0], CORS_HEADERS)
      }
    },


    //    ██████  ███████ ██████   ██████  ██████  ████████ ███████ ███████ 
    //    ██   ██ ██      ██   ██ ██    ██ ██   ██    ██    ██      ██      
    //    ██████  █████   ██████  ██    ██ ██████     ██    █████   ███████ 
    //    ██   ██ ██      ██      ██    ██ ██   ██    ██    ██           ██ 
    //    ██   ██ ███████ ██       ██████  ██   ██    ██    ███████ ███████

    "/api/reporte_1": {
      async GET() {
        const res = await reporteProductosPromocion();
        return new Response(res, { ...CORS_HEADERS, ...{ headers: { "Content-Type": "application/pdf" } } });
      }
    },

    "/api/reporte_2": {
      async GET() {
        const res = await reporteIngresosEventos();
        return new Response(res, { ...CORS_HEADERS, ...{ headers: { "Content-Type": "application/pdf" } } });
      }
    },

    "/api/reporte_3": {
      async GET() {
        const res = await reportePuntualidadPorCargo();
        return new Response(res, { ...CORS_HEADERS, ...{ headers: { "Content-Type": "application/pdf" } } });
      }
    },

    "/api/reporte_4": {
      async GET() {
        const res = await reporteRankingProveedores();
        return new Response(res, { ...CORS_HEADERS, ...{ headers: { "Content-Type": "application/pdf" } } });
      }
    },

    "/api/reporte_5": {
      async GET() {
        const res = await reporteValorPuntosCanjeados()
        return new Response(res, { ...CORS_HEADERS, ...{ headers: { "Content-Type": "application/pdf" } } });
      }
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

export { CORS_HEADERS }