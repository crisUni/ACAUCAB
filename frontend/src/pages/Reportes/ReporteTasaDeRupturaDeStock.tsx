import { Gauge } from '@mui/x-charts/Gauge';
import { useEffect, useState } from 'react';

function ReporteTasaDeRupturaDeStock() {
    const [data, setData] = useState<{ min: number, max: number, value: number }>({ min: 0, max: 0, value: 0 })
    const [p11, setP11] = useState("2025-01-01")
    const [p12, setP12] = useState("2026-01-01")
    useEffect(() => {
        fetch(`http://127.0.0.1:3000/api/reporte/stockout_rate/${p11}/${p12}`)
            .then(async res => {
                const jsonData = (await res.json())[0]
                const newData = {
                    min: 0,
                    max: 10,
                    value: jsonData["count"],
                }
                setData(newData)
            })
            .catch(err => console.error(err))
    }, [])

    return (
        <div>
            <h1> Rotacion de Inventario: </h1>
            <input onChange={e => setP11(e.target.value)} value={p11} type="date" />
            <input onChange={e => setP12(e.target.value)} value={p12} type="date" />
            {data.value ? <Gauge value={data?.value} valueMin={data.min} valueMax={data.max} height={300} width={300} /> : <></>}
        </div>
    )
}

export default ReporteTasaDeRupturaDeStock;