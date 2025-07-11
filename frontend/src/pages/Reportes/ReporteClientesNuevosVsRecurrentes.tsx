import { Gauge } from "@mui/x-charts"
import { useEffect, useState } from "react"

function ReporteClientesNuevosVsRecurrentes() {
    const [newdata, setNewData] = useState<{ min: number, max: number, value: number }>({ min: 0, max: 0, value: 0 })
    const [olddata, setOldData] = useState<{ min: number, max: number, value: number }>({ min: 0, max: 0, value: 0 })
    useEffect(() => {
        fetch("http://127.0.0.1:3000/api/reporte/nuevos_vs_recurrentes")
            .then(async res => {
                const jsonData = (await res.json())
                const m = Math.max(jsonData[0], jsonData[1])
                const newData = {
                    min: 0,
                    max: m,
                    value: jsonData[0].count,
                }
                const oldData = {
                    min: 0,
                    max: m,
                    value: jsonData[1].count,
                }
                setNewData(newData)
                setOldData(oldData)
            })
            .catch(err => console.error(err))
    }, [])

    return (
        <div>
            <h1> Indicador Cliente (Ultimo Cuatrimestre) </h1>
            {newdata.value ? <Gauge text={({ value}) => `Nuevos: ${value}`} value={newdata?.value} valueMin={newdata.min} valueMax={newdata.max} height={300} width={300} /> : <></>}
            {olddata.value ? <Gauge text={({ value}) => `Recurrentes: ${value}`} value={olddata?.value} valueMin={olddata.min} valueMax={olddata.max} height={300} width={300} /> : <></>}
        </div>
    )
}

export default ReporteClientesNuevosVsRecurrentes;