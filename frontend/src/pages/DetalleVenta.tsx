import GenerateColumn from "@/components/GenerateColumn"
import { useEffect, useState } from "react"

// TODO: Mostrar mas informacion META de la venta, como total, cliente, etc

export default function DetalleVenta() {
    let ventaId = window.location.href.split('/').pop();
    const [ventaData, setVentaData] = useState<any[]>([])
    const [pagosData, setPagosData] = useState<any[]>([])

    useEffect(() => {
        fetch(`http://127.0.0.1:3000/api/venta/detalle/${ventaId}`)
            .then(async res => setVentaData(await res.json()))
            .catch(console.error)
    }, [])

    useEffect(() => {
        fetch(`http://127.0.0.1:3000/api/venta/pagos/${ventaId}`)
            .then(async res => setPagosData(await res.json()))
            .catch(console.error)
    }, [])

    return (
        <div>
            <a href="/venta">Back</a>
            <h1> Detalle de la venta </h1>
            <h2> Pagos </h2>
            {GenerateColumn([
                // TODO: this
                // Make it so the payment method is detailed
                // Make it so the tasa is detailed
                { title: "Metodo de Pago", keyName: "fk_metodo_pago" },
                { title: "Tasa de Cambio", keyName: "fk_tasa_cambio" },
                { title: "Monto", keyName: "monto" },
            ], pagosData)}
            <h2> Ventas </h2>
            {GenerateColumn([
                { title: "Identificador", keyName: "eid" },
                { title: "Cantidad", keyName: "cantidad" },
                { title: "Precio Unitario", keyName: "precio_unitario" },
                { title: "Cerveza", keyName: "fk_cerveza" },
                { title: "Presentacion", keyName: "fk_presentacion" },
            ], ventaData)}
        </div>
    )
}