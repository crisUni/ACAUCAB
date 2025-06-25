import DynamicOptionInputs from "../components/DynamicOptions";
import GenerateForm from "@/components/FormGenerator";
import { useState } from "react";

export default function VentaCliente() {
    let clienteId = window.location.href.split('/').pop();
    
    const form = () => GenerateForm([
        { label: "Productos", fetchFrom: `http://127.0.0.1:3000/api/form/inve_tien`, keyName: "fk_cerveza,fk_presentacion,fk_tienda,fk_lugar_tienda,cantidad", multiple: true, required: true },
        { label: "Productos", fetchFrom: `http://127.0.0.1:3000/api/form/metodo_pago`, keyName: "fk_metodo_pago,monto", multiple: true, required: true }
    ], { url: `http://127.0.0.1:3000/api/venta/nueva/${clienteId}` })

    return (
        <div>
            <a href="/venta">Back</a>
            <h1> Hello to {clienteId} </h1>
            { form() }
        </div>
    )
}