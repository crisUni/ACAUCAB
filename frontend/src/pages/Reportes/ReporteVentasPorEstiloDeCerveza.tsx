import { BarChart } from '@mui/x-charts/BarChart';
import { useEffect, useState } from 'react';

function ReporteVentasTotales() {
    const [data, setData] = useState<{ label: string, data: number[] }[]>([])
    useEffect(() => {
        fetch("http://127.0.0.1:3000/api/reporte/ventas_por_estilo")
            .then(async res => {
                const jsonData = await res.json()
                const newData: { label: string, data: number[] }[] = []
                for (const d of jsonData)
                    newData.push({ label: d.nombre,  data: [d.cantidad] })
                setData(newData)
            })
            .catch(err => console.error(err))
    }, [])

    return (
        <div>
            <h1> Reporte de Ventas Totales </h1>
            <BarChart series={data} xAxis={[{ data: ['Ingresos']}]} height={300} width={600}  />
        </div>
    )
}

export default ReporteVentasTotales;