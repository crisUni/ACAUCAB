import GenerateColumn from "@/components/GenerateColumn"
import SmartLink from "@/components/SmartLink";
import { useEffect, useState } from "react"

export default function DetalleCompra() {
    let compraId = window.location.href.split('/').pop();
    const [compraData, setNaturalData] = useState<Array<any>>([])

    useEffect(() => {
        fetch(`http://127.0.0.1:3000/api/compra/${compraId}`)
            .then(async res => setNaturalData(await res.json()))
            .catch(console.error)
    }, [])

    return (
        <div>
            <SmartLink href="/compra">Back</SmartLink>
            <h1> Detalle de la compra </h1>
            {GenerateColumn([
                { title: "Identificador", keyName: "eid" },
                { title: "Cantidad", keyName: "cantidad" },
                { title: "Precio Unitario", keyName: "precio_unitario" },
                { title: "Cerveza", keyName: "fk_cerveza" },
                { title: "Presentacion", keyName: "fk_presentacion" },
            ], compraData)}
        </div>
    )
}