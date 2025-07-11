import { Gauge } from '@mui/x-charts/Gauge';
import { useEffect, useState } from 'react';

function ReporteTicketPromedio() {
    const [data, setData] = useState<{ min: number, max: number, value: number }>({ min: 0, max: 0, value: 0 })
    useEffect(() => {
        fetch("http://127.0.0.1:3000/api/reporte/valor_promedio_venta")
            .then(async res => {
                const jsonData = (await res.json())[0]
                const newData = {
                    min: jsonData.min,
                    max: jsonData.max,
                    value: jsonData.avg,
                }
                setData(newData)
            })
            .catch(err => console.error(err))
    }, [])

    return (
        <div>
            <h1> Ticket Promedio (VMP): </h1>
            {data.value ? <Gauge value={data?.value} valueMin={data.min} valueMax={data.max} height={300} width={300} /> : <></>}
        </div>
    )
}

export default ReporteTicketPromedio;