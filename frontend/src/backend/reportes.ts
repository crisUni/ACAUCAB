import { sql } from "bun";
import { ChartJSNodeCanvas } from 'chartjs-node-canvas';
import * as fs from "fs";


const jsreportUrl = "http://jsreport:5488/api/report";

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

    console.log("Reporte generado: productos_promocion_report.pdf");
    return Buffer.from(await res.arrayBuffer());
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

    console.log("Reporte generado: ingresos_eventos_report.pdf");
    return Buffer.from(await res.arrayBuffer());
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

    console.log("Reporte generado: puntualidad_cargo_report.pdf");
    return Buffer.from(await res.arrayBuffer());
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

    console.log("Reporte generado: ranking_proveedores_report.pdf");
    return Buffer.from(await res.arrayBuffer());
}

// 5. Valor monetario total de puntos canjeados por clientes en los ultimos 6 meses
export async function reporteValorPuntosCanjeados() {
    const resultado = await sql`
    SELECT SUM(P.monto * Tc.tasa_bs_punto) AS valor_total_bs
    FROM Pago AS P
    JOIN PUNTO AS Pu ON P.fk_metodo_pago = Pu.fk_metodo_pago
    JOIN TASA_CAMBIO AS Tc ON P.fk_tasa_cambio = Tc.eid
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

    console.log("Reporte generado: valor_puntos_canjeados_report.pdf");
    return Buffer.from(await res.arrayBuffer());
}

// 6. Gráfico de Tendencia de Ventas a lo largo del tiempo
export async function reporteGraficoTendenciaVentas() {
    // Obtener los últimos 8 meses (incluyendo meses sin ventas)
    const mesesQuery = await sql`
        SELECT TO_CHAR(date_trunc('month', CURRENT_DATE) - INTERVAL '1 month' * gs.n, 'YYYY-MM') AS periodo
        FROM generate_series(0, 7) AS gs(n)
        ORDER BY periodo
    `;

    // Traer las ventas agrupadas por mes
    const ventasQuery = await sql`
        SELECT 
            TO_CHAR(fecha, 'YYYY-MM') AS periodo,
            SUM(monto_total) AS total_ventas
        FROM VENTA
        WHERE fecha >= (date_trunc('month', CURRENT_DATE) - INTERVAL '7 months')
        GROUP BY TO_CHAR(fecha, 'YYYY-MM')
        ORDER BY periodo
    `;

    // Mapear ventas a objeto {periodo: total_ventas}
    const ventasMap = new Map<string, number>();
    for (const v of ventasQuery) {
        ventasMap.set(v.periodo, Number(v.total_ventas));
    }
    console.log(ventasMap)
    // Construir arrays de labels y data, asegurando que todos los meses estén presentes
    const labels = mesesQuery.map((m: any) => m.periodo);
    const data = labels.map((periodo: string) => ventasMap.get(periodo) ?? 0);

    // Generar imagen del gráfico
    const width = 700;
    const height = 350;
    const chartJSNodeCanvas = new ChartJSNodeCanvas({ width, height });
    const configuration = {
        type: 'line' as const,
        data: {
            labels,
            datasets: [{
                label: 'Total Ventas (Bs)',
                data,
                borderColor: '#4299e1',
                backgroundColor: 'rgba(66,153,225,0.15)',
                fill: true,
                tension: 0.2,
                pointRadius: 4,
                pointBackgroundColor: '#2a4365'
            }]
        },
        options: {
            plugins: { legend: { display: true } },
            scales: { y: { beginAtZero: true } }
        }
    };
    const image = await chartJSNodeCanvas.renderToDataURL(configuration);

    const reportTemplate = {
        template: {
            content: `
            <html>
            <head>
                <meta charset="utf-8">
                <title>Gráfico de Tendencia de Ventas</title>
                <style>
                    body { font-family: 'Segoe UI', Arial, sans-serif; background: #f7f7fa; margin: 0; }
                    .container { max-width: 800px; margin: 40px auto; background: #fff; border-radius: 12px; box-shadow: 0 4px 24px rgba(0,0,0,0.08); padding: 40px 32px 32px 32px; }
                    h1 { color: #2a4365; text-align: center; margin-bottom: 24px; font-size: 2rem; }
                </style>
            </head>
            <body>
                <div class="container">
                    <h1>Gráfico de Tendencia de Ventas Mensuales (Últimos 8 meses)</h1>
                    <img src="{{image}}" width="700" height="350" />
                </div>
            </body>
            </html>
            `,
            engine: "handlebars",
            recipe: "chrome-pdf"
        },
        data: {
            image
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

    console.log("Reporte generado: grafico tendencia.pdf");
    return Buffer.from(await res.arrayBuffer());
}

// 7. Gráfico de Ventas por Canal de Distribución (Física vs Virtual)
export async function reporteGraficoVentasPorCanal() {
    const ventas = await sql`
        SELECT 'Tienda Física' AS canal, COALESCE(SUM(monto_total),0) AS total
        FROM VENTA WHERE fk_tienda_fisica IS NOT NULL
        UNION ALL
        SELECT 'Tienda Virtual' AS canal, COALESCE(SUM(monto_total),0) AS total
        FROM VENTA WHERE fk_tienda_virtual IS NOT NULL
    `;

    const labels = ventas.map((v: any) => v.canal);
    const data = ventas.map((v: any) => Number(v.total));

    const width = 600;
    const height = 350;
    const chartJSNodeCanvas = new ChartJSNodeCanvas({ width, height });
    const configuration = {
        type: 'bar' as const,
        data: {
            labels,
            datasets: [{
                label: 'Total Ventas (Bs)',
                data,
                backgroundColor: ['#4299e1', '#48bb78']
            }]
        },
        options: {
            plugins: { legend: { display: false } },
            scales: { y: { beginAtZero: true } }
        }
    };
    const image = await chartJSNodeCanvas.renderToDataURL(configuration);

    const reportTemplate = {
        template: {
            content: `
            <html>
            <head>
                <meta charset="utf-8">
                <title>Ventas por Canal de Distribución</title>
                <style>
                    body { font-family: 'Segoe UI', Arial, sans-serif; background: #f7f7fa; margin: 0; }
                    .container { max-width: 700px; margin: 40px auto; background: #fff; border-radius: 12px; box-shadow: 0 4px 24px rgba(0,0,0,0.08); padding: 40px 32px 32px 32px; }
                    h1 { color: #2a4365; text-align: center; margin-bottom: 24px; font-size: 2rem; }
                </style>
            </head>
            <body>
                <div class="container">
                    <h1>Ventas por Canal de Distribución</h1>
                    <img src="{{image}}" width="600" height="350" />
                </div>
            </body>
            </html>
            `,
            engine: "handlebars",
            recipe: "chrome-pdf"
        },
        data: { image }
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

    console.log("Reporte generado: 9.pdf");
    return Buffer.from(await res.arrayBuffer());
}

// 8. Tabla de Productos top 10 más vendidos
export async function reporteTopProductosVendidos() {
    const productos = await sql`
        SELECT c.nombre AS producto, SUM(df.cantidad) AS total_vendido
        FROM DETALLE_FACTURA df
        JOIN CERVEZA c ON df.fk_cerveza = c.eid
        GROUP BY c.nombre
        ORDER BY total_vendido DESC
        LIMIT 10
    `;

    const reportTemplate = {
        template: {
            content: `
            <html>
            <head>
                <meta charset="utf-8">
                <title>Top 10 Productos Más Vendidos</title>
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
                    <h1>Top 10 Productos Más Vendidos</h1>
                    <table>
                        <thead>
                            <tr>
                                <th>Producto</th>
                                <th>Total Vendido</th>
                            </tr>
                        </thead>
                        <tbody>
                            {{#each productos}}
                            <tr>
                                <td>{{producto}}</td>
                                <td>{{total_vendido}}</td>
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

    console.log("Reporte generado: 9.pdf");
    return Buffer.from(await res.arrayBuffer());
}

// 9. Reporte de Inventario Actual 
export async function reporteInventarioActual() {
    const inventario = await sql`
        SELECT 
            c.nombre AS producto,
            p.nombre AS presentacion,
            it.cantidad
        FROM INVE_TIEN it
        JOIN CERVEZA c ON it.fk_cerveza = c.eid
        JOIN PRESENTACION p ON it.fk_presentacion = p.eid
        ORDER BY producto, presentacion
    `;

    const reportTemplate = {
        template: {
            content: `
            <html>
            <head>
                <meta charset="utf-8">
                <title>Reporte de Inventario Actual</title>
                <style>
                    body { font-family: 'Segoe UI', Arial, sans-serif; background: #f7f7fa; margin: 0; }
                    .container { max-width: 800px; margin: 40px auto; background: #fff; border-radius: 12px; box-shadow: 0 4px 24px rgba(0,0,0,0.08); padding: 40px 32px 32px 32px; }
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
                    <h1>Reporte de Inventario Actual</h1>
                    <table>
                        <thead>
                            <tr>
                                <th>Producto</th>
                                <th>Presentación</th>
                                <th>Cantidad en Stock</th>
                            </tr>
                        </thead>
                        <tbody>
                            {{#each inventario}}
                            <tr>
                                <td>{{producto}}</td>
                                <td>{{presentacion}}</td>
                                <td>{{cantidad}}</td>
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
        data: { inventario }
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

    console.log("Reporte generado: 9.pdf");
    return Buffer.from(await res.arrayBuffer());
}

// Ejecucion directa
if (import.meta.main) {
    await reporteProductosPromocion();
    await reporteIngresosEventos();
    await reportePuntualidadPorCargo();
    await reporteRankingProveedores();
    await reporteValorPuntosCanjeados();

    await reporteInventarioActual();
    await reporteTopProductosVendidos();
    await reporteGraficoVentasPorCanal();
    await reporteGraficoTendenciaVentas();
}


