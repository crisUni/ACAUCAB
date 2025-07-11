import { Gauge } from "@mui/x-charts"
import { useEffect, useState } from "react"

function ReporteTasaDeRetencion() {
    const [newdata, setNewData] = useState<{ min: number, max: number, value: number }>({ min: 0, max: 0, value: 0 })
    const [olddata, setOldData] = useState<{ min: number, max: number, value: number }>({ min: 0, max: 0, value: 0 })
    const [p11, setP11] = useState("2025-01-01")
    const [p12, setP12] = useState("2026-01-01")

    useEffect(() => {
        fetch(`http://127.0.0.1:3000/api/reporte/tasa_retencion_clientes/${p11}/${p12}`)
            .then(async res => {
                const jsonData = (await res.json())[0]
                const newData = {
                    min: 0,
                    max: 100,
                    value: jsonData.repeat,
                }
                const oldData = {
                    min: 0,
                    max: 100,
                    value: jsonData.nonrepeat,
                }
                setNewData(newData)
                setOldData(oldData)
            })
            .catch(err => console.error(err))
    }, [p11, p12])

    return (
        <div>
            <h1> Tasa de Retencion de Clientes </h1>
            <input onChange={e => setP11(e.target.value)} value={p11} type="date" />
            <input onChange={e => setP12(e.target.value)} value={p12} type="date" />
            {newdata.value ? <Gauge text={({ value }) => `Nuevos: ${value}`} value={newdata?.value} valueMin={newdata.min} valueMax={newdata.max} height={300} width={300} /> : <></>}
            {olddata.value ? <Gauge text={({ value }) => `Recurrentes: ${value}`} value={olddata?.value} valueMin={olddata.min} valueMax={olddata.max} height={300} width={300} /> : <></>}
        </div>
    )
}

export default ReporteTasaDeRetencion