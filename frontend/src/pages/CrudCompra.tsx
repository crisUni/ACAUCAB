import GenerateForm from "@/components/FormGenerator"
import GenerateColumn from "@/components/GenerateColumn"
import { useEffect, useState } from "react"

const possibleProviders = () => GenerateForm([
    { label: "Proveedor: ", keyName: "eid", fetchFrom: "http://127.0.0.1:3000/api/form/providers", required: true },
], { callback: (data) => window.location.href = `/compra/${data.insert_data.eid}` })

export default function CrudCompra() {
    const [compraData, setNaturalData] = useState<Array<any>>([])

    useEffect(() => {
        fetch("http://127.0.0.1:3000/api/compra")
            .then(async res => setNaturalData(await res.json()))
            .catch(console.error)
    }, [])

    return (
        <div>
            <a href="/">Back</a>
            <h2> Seleccionar a quien se le haremos la compra </h2>
            {possibleProviders()}
            <h2> Lista de Compras </h2>
            {GenerateColumn([
                { title: "Identificador", keyName: "eid" },
                { title: "Fecha", keyName: "fecha" },
                { title: "Monto", keyName: "monto_total" },
                { title: "Proveedor", keyName: "fk_proveedor" },
            ], compraData, [{ title: "Pagar", action: data => fetch(`http://127.0.0.1:3000/api/compra/set_pagada/${data.eid}`) }, { title: "Detalle", action: data => { window.location.href = `/compra/detalle/${data.eid}`}}])}
        </div>
    )
}