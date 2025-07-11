import { Gauge } from '@mui/x-charts/Gauge';
import { useEffect, useState } from 'react';

function ReporteRotacionDeInventario() {
    const [data, setData] = useState<{ min: number, max: number, value: number }>({ min: 0, max: 0, value: 0 })
    useEffect(() => {
        fetch("http://127.0.0.1:3000/api/reporte/rotacion_inventario")
            .then(async res => {
                const jsonData = (await res.json())[0]
                const newData = {
                    min: 0,
                    max: jsonData["rotacion de inventario"] * (1 + Math.random()),
                    value: jsonData["rotacion de inventario"],
                }
                setData(newData)
            })
            .catch(err => console.error(err))
    }, [])

    return (
        <div>
            <h1> Rotacion de Inventario: </h1>
            {data.value ? <Gauge value={data?.value} valueMin={data.min} valueMax={data.max} height={300} width={300} /> : <></>}
        </div>
    )
}

export default ReporteRotacionDeInventario;