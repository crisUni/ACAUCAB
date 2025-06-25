import { sql } from "bun";

const jsreportUrl = "http://localhost:5488/api/report";

// 1. Productos mas seleccionados en promociones para "DiarioDeUnaCerveza"
export async function reporteProductosPromocion() {
    const productos = await sql`
    SELECT 
      c.nombre AS producto,
      COUNT(dcp.fk_cerveza) AS veces_en_promocion
    FROM DESC_CERV_PRES dcp
    JOIN CERVEZA c ON dcp.fk_cerveza = c.eid
    GROUP BY c.nombre
    ORDER BY veces_en_promocion DESC
  `;

    const reportTemplate = {
        template: {
            content: `
            <html>
            <head>
                <meta charset="utf-8">
                <title>Productos más seleccionados en promociones</title>
                <style>
                    body { font-family: 'Segoe UI', Arial, sans-serif; background: #f7f7fa; margin: 0; }
                    .container { max-width: 700px; margin: 40px auto; background: #fff; border-radius: 12px; box-shadow: 0 4px 24px rgba(0,0,0,0.08); padding: 40px 32px 32px 32px; }
                    h1 { color: #2a4365; text-align: center; margin-bottom: 24px; font-size: 2rem; }
                    table { width: 100%; border-collapse: collapse; margin-top: 24px; }
                    th, td { padding: 12px 10px; border-bottom: 1px solid #e2e8f0; text-align: left; }
                    th { background: #4299e1; color: #fff; }
                    tr:nth-child(even) { background: #f1f5f9; }
                    tr:hover { background: #bee3f8; }
                </style>
                </head>
                <body>
                <div class="container">
                    <h1>Productos más seleccionados en promociones</h1>
                    <table>
                    <thead>
                        <tr>
                        <th>Producto</th>
                        <th>Veces en Promoción</th>
                        </tr>
                    </thead>
                    <tbody>
                        {{#each productos}}
                        <tr>
                        <td>{{producto}}</td>
                        <td>{{veces_en_promocion}}</td>
                        </tr>
                        {{/each}}
                    </tbody>
                    </table>
                </div>
                </body>
                </html>
                `,
            engine: "handlebars",
            recipe: "chrome-pdf"
        },
        data: { productos }
    };

    const res = await fetch(jsreportUrl, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(reportTemplate)
    });

    if (!res.ok) {
        const errorText = await res.text();
        throw new Error(`jsreport error: ${res.statusText}\n${errorText}`);
    }

    const buffer = Buffer.from(await res.arrayBuffer());
    await Bun.write("productos_promocion_report.pdf", buffer);
    console.log("Reporte generado: productos_promocion_report.pdf");
}

// 2. Ingresos por Venta de Entradas a Eventos por periodo
export async function reporteIngresosEventos() {
    const ingresos = await sql`
    SELECT 
      e.nombre AS evento,
      SUM(evcl.cantidad_entradas * e.precio_entrada) AS ingresos,
      DATE_TRUNC('month', e.fecha_inicio) AS periodo
    FROM EVENTO e
    JOIN EVEN_CLIE evcl ON e.eid = evcl.fk_evento
    GROUP BY e.nombre, periodo
    ORDER BY periodo DESC, ingresos DESC
  `;

    const reportTemplate = {
        template: {
        content: `
        <html>
        <head>
            <meta charset="utf-8">
            <title>Ingresos por Venta de Entradas a Eventos</title>
            <style>
                body { font-family: 'Segoe UI', Arial, sans-serif; background: #f7f7fa; margin: 0; }
                .container { max-width: 700px; margin: 40px auto; background: #fff; border-radius: 12px; box-shadow: 0 4px 24px rgba(0,0,0,0.08); padding: 40px 32px 32px 32px; }
                h1 { color: #2a4365; text-align: center; margin-bottom: 24px; font-size: 2rem; }
                table { width: 100%; border-collapse: collapse; margin-top: 24px; }
                th, td { padding: 12px 10px; border-bottom: 1px solid #e2e8f0; text-align: left; }
                th { background: #4299e1; color: #fff; }
                tr:nth-child(even) { background: #f1f5f9; }
                tr:hover { background: #bee3f8; }
            </style>
        </head>
        <body>
            <div class="container">
            <h1>Ingresos por Venta de Entradas a Eventos</h1>
            <table>
            <thead>
                <tr>
                <th>Evento</th>
                <th>Ingresos (Bs)</th>
                <th>Periodo</th>
                </tr>
            </thead>
            <tbody>
                {{#each ingresos}}
                <tr>
                <td>{{evento}}</td>
                <td>{{ingresos}}</td>
                <td>{{periodo}}</td>
                </tr>
                {{/each}}
            </tbody>
            </table>
            </div>
        </body>
        </html>
        `,
            engine: "handlebars",
            recipe: "chrome-pdf"
        },
        data: { ingresos }
    };

    const res = await fetch(jsreportUrl, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(reportTemplate)
    });

    if (!res.ok) {
        const errorText = await res.text();
        throw new Error(`jsreport error: ${res.statusText}\n${errorText}`);
    }

    const buffer = Buffer.from(await res.arrayBuffer());
    await Bun.write("ingresos_eventos_report.pdf", buffer);
    console.log("Reporte generado: ingresos_eventos_report.pdf");
}

// 3. Analisis de Puntualidad por Cargo
export async function reportePuntualidadPorCargo() {
    const puntualidad = await sql`
    SELECT 
      c.nombre AS cargo,
      ROUND(AVG(EXTRACT(EPOCH FROM (eh.hora_entrada - h.hora_entrada)) / 60), 2) AS promedio_minutos_retraso
    FROM CARGO c
    JOIN CARG_EMPL ce ON c.eid = ce.fk_cargo
    JOIN EMPL_HORA eh ON ce.fk_empleado = eh.fk_empleado
      AND eh.fecha BETWEEN ce.fecha_inicio AND COALESCE(ce.fecha_fin, CURRENT_DATE)
    JOIN HORARIO h ON eh.fk_horario = h.eid
    GROUP BY c.nombre
    ORDER BY promedio_minutos_retraso ASC
  `;

    const reportTemplate = {
        template: {
        content: `
        <html>
        <head>
            <meta charset="utf-8">
            <title>Puntualidad promedio por cargo</title>
            <style>
                body { font-family: 'Segoe UI', Arial, sans-serif; background: #f7f7fa; margin: 0; }
                .container { max-width: 700px; margin: 40px auto; background: #fff; border-radius: 12px; box-shadow: 0 4px 24px rgba(0,0,0,0.08); padding: 40px 32px 32px 32px; }
                h1 { color: #2a4365; text-align: center; margin-bottom: 24px; font-size: 2rem; }
                table { width: 100%; border-collapse: collapse; margin-top: 24px; }
                th, td { padding: 12px 10px; border-bottom: 1px solid #e2e8f0; text-align: left; }
                th { background: #4299e1; color: #fff; }
                tr:nth-child(even) { background: #f1f5f9; }
                tr:hover { background: #bee3f8; }
            </style>
        </head>
        <body>
            <div class="container">
                <h1>Puntualidad promedio por cargo (minutos de retraso)</h1>
                <table>
                <thead>
                    <tr>
                    <th>Cargo</th>
                    <th>Promedio minutos de retraso</th>
                    </tr>
                </thead>
                <tbody>
                    {{#each puntualidad}}
                    <tr>
                    <td>{{cargo}}</td>
                    <td>{{promedio_minutos_retraso}}</td>
                    </tr>
                    {{/each}}
                </tbody>
                </table>
            </div>
        </body>
        </html>
        `,
            engine: "handlebars",
            recipe: "chrome-pdf"
        },
        data: { puntualidad }
    };

    const res = await fetch(jsreportUrl, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(reportTemplate)
    });

    if (!res.ok) {
        const errorText = await res.text();
        throw new Error(`jsreport error: ${res.statusText}\n${errorText}`);
    }

    const buffer = Buffer.from(await res.arrayBuffer());
    await Bun.write("puntualidad_cargo_report.pdf", buffer);
    console.log("Reporte generado: puntualidad_cargo_report.pdf");
}
// 4. Ranking de Miembros Proveedores por Tipo de Cerveza
export async function reporteRankingProveedores() {
    const ranking = await sql`
    SELECT 
      p.denominacion_comercial AS proveedor,
      COUNT(DISTINCT tc.eid) AS tipos_cerveza
    FROM PROVEEDOR p
    JOIN CERVEZA c ON p.eid = c.fk_proveedor
    JOIN TIPO_CERVEZA tc ON c.fk_tipo_cerveza = tc.eid
    GROUP BY p.denominacion_comercial
    ORDER BY tipos_cerveza DESC
  `;

    const reportTemplate = {
        template: {
        content: `
        <html>
        <head>
            <meta charset="utf-8">
            <title>Ranking de Proveedores por Tipo de Cerveza</title>
            <style>
                body { font-family: 'Segoe UI', Arial, sans-serif; background: #f7f7fa; margin: 0; }
                .container { max-width: 700px; margin: 40px auto; background: #fff; border-radius: 12px; box-shadow: 0 4px 24px rgba(0,0,0,0.08); padding: 40px 32px 32px 32px; }
                h1 { color: #2a4365; text-align: center; margin-bottom: 24px; font-size: 2rem; }
                table { width: 100%; border-collapse: collapse; margin-top: 24px; }
                th, td { padding: 12px 10px; border-bottom: 1px solid #e2e8f0; text-align: left; }
                th { background: #4299e1; color: #fff; }
                tr:nth-child(even) { background: #f1f5f9; }
                tr:hover { background: #bee3f8; }
            </style>
        </head>
        <body>
            <div class="container">
                <h1>Ranking de Proveedores por Tipo de Cerveza</h1>
                <table>
                <thead>
                    <tr>
                    <th>Proveedor</th>
                    <th>Tipos de Cerveza</th>
                    </tr>
                </thead>
                <tbody>
                    {{#each ranking}}
                    <tr>
                    <td>{{proveedor}}</td>
                    <td>{{tipos_cerveza}}</td>
                    </tr>
                    {{/each}}
                </tbody>
                </table>
            </div>
        </body>
        </html>
        `,
            engine: "handlebars",
            recipe: "chrome-pdf"
        },
        data: { ranking }
    };

    const res = await fetch(jsreportUrl, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(reportTemplate)
    });

    if (!res.ok) {
        const errorText = await res.text();
        throw new Error(`jsreport error: ${res.statusText}\n${errorText}`);
    }

    const buffer = Buffer.from(await res.arrayBuffer());
    await Bun.write("ranking_proveedores_report.pdf", buffer);
    console.log("Reporte generado: ranking_proveedores_report.pdf");
}

// 5. Valor monetario total de puntos canjeados por clientes en los ultimos 6 meses
export async function reporteValorPuntosCanjeados() {
    const resultado = await sql`
    SELECT 
      SUM(mp.monto * tc.tasa_bs_punto) AS valor_total_bs
    FROM PAGO p
    JOIN METODO_PAGO mp ON p.fk_metodo_pago = mp.eid
    JOIN TASA_CAMBIO tc ON p.fk_tasa_cambio = tc.eid
    JOIN PUNTO pt ON p.fk_metodo_pago = pt.fk_metodo_pago
    WHERE tc.fecha_inicio >= (CURRENT_DATE - INTERVAL '6 months')
  `;

    const valor_total_bs = resultado[0]?.valor_total_bs ?? 0;

    const reportTemplate = {
        template: {
            content: `
        <html>
        <head>
          <meta charset="utf-8">
          <title>Reporte de Puntos Canjeados</title>
          <style>
            body {
              font-family: 'Segoe UI', Arial, sans-serif;
              background: #f7f7fa;
              margin: 0;
              padding: 0;
            }
            .container {
              max-width: 600px;
              margin: 40px auto;
              background: #fff;
              border-radius: 12px;
              box-shadow: 0 4px 24px rgba(0,0,0,0.08);
              padding: 40px 32px 32px 32px;
            }
            h1 {
              color: #2a4365;
              text-align: center;
              margin-bottom: 24px;
              font-size: 2rem;
              letter-spacing: 1px;
            }
            .valor-box {
              background: linear-gradient(90deg, #4299e1 0%, #90cdf4 100%);
              color: #fff;
              border-radius: 10px;
              padding: 32px 0;
              text-align: center;
              margin: 32px 0;
              box-shadow: 0 2px 12px rgba(66,153,225,0.08);
            }
            .valor-label {
              font-size: 1.2rem;
              letter-spacing: 1px;
              margin-bottom: 8px;
              opacity: 0.85;
            }
            .valor-numero {
              font-size: 2.8rem;
              font-weight: bold;
              letter-spacing: 2px;
              margin-top: 0;
            }
            .footer {
              text-align: center;
              color: #888;
              font-size: 0.95rem;
              margin-top: 32px;
            }
          </style>
        </head>
        <body>
          <div class="container">
            <h1>Valor Monetario Total de Puntos Canjeados</h1>
            <div class="valor-box">
              <div class="valor-label">Total canjeado en los últimos 6 meses</div>
              <div class="valor-numero">Bs {{valor_total_bs}}</div>
            </div>
            <div class="footer">
              ACAUCAB &mdash; Reporte generado el {{now}}
            </div>
          </div>
        </body>
        </html>
      `,
            engine: "handlebars",
            recipe: "chrome-pdf"
        },
        data: {
            valor_total_bs: valor_total_bs.toLocaleString('es-VE', { minimumFractionDigits: 2, maximumFractionDigits: 2 }),
            now: new Date().toLocaleDateString('es-VE')
        }
    };

    const res = await fetch(jsreportUrl, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(reportTemplate)
    });

    if (!res.ok) {
        const errorText = await res.text();
        throw new Error(`jsreport error: ${res.statusText}\n${errorText}`);
    }

    const buffer = Buffer.from(await res.arrayBuffer());
    await Bun.write("valor_puntos_canjeados_report.pdf", buffer);
    console.log("Reporte generado: valor_puntos_canjeados_report.pdf");
}

// Ejecucion directa
if (import.meta.main) {
    await reporteProductosPromocion();
    await reporteIngresosEventos();
    await reportePuntualidadPorCargo();
    await reporteRankingProveedores();
    await reporteValorPuntosCanjeados();
}