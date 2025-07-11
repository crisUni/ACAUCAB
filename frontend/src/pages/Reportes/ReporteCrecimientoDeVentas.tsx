import { BarChart, Gauge } from "@mui/x-charts"
import { useEffect, useState } from "react"

function ReporteCrecimientoDeVentas() {
    const [data, setData] = useState<any[]>([])
    const [p11, setP11] = useState("2025-01-01")
    const [p12, setP12] = useState("2025-06-01")
    const [p21, setP21] = useState("2025-06-01")
    const [p22, setP22] = useState("2026-01-01")

    useEffect(() => {
        fetch(`http://127.0.0.1:3000/api/reporte/crecimiento_ventas/${p11}/${p12}/${p21}/${p22}`)
            .then(async res => {
                const jsonData = (await res.json())
                const newData = []
                newData.push({
                    data: [ jsonData[0].ventas, jsonData[1].ventas ]
                })
                newData.push({
                    data: [ jsonData[0].ingresos, jsonData[1].ingresos ]
                })
                newData.push({
                    data: [ jsonData[0]["porcentaje total de todas las ventas"], jsonData[1]["porcentaje total de todas las ventas"] ]
                })
                setData(newData)
            })
            .catch(err => console.error(err))
    }, [p11, p12, p21, p22])

    return (
        <div>
            <h1> Tasa de Retencion de Clientes </h1>
            <div>
                <h2> Periodo 1 </h2>
                <input onChange={e => setP11(e.target.value)} value={p11} type="date" />
                - hasta -
                <input onChange={e => setP12(e.target.value)} value={p12} type="date" />
                <br />
                <h2> Periodo 2 </h2>
                <input onChange={e => setP21(e.target.value)} value={p21} type="date" />
                - hasta -
                <input onChange={e => setP22(e.target.value)} value={p22} type="date" />
            </div>

            <BarChart series={data} xAxis={[{ data: ['Ventas, Ingresos, Porcentaje Total']}]} />
        </div>
    )
}

export default ReporteCrecimientoDeVentas