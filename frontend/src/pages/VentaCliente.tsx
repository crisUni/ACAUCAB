import DynamicOptionInputs from "../components/DynamicOptions";
import GenerateForm from "@/components/FormGenerator";
import { useState } from "react";

export default function VentaCliente() {
    let proveedorId = window.location.href.split('/').pop();
    
    const form = () => GenerateForm([
        { label: "Productos", fetchFrom: `http://127.0.0.1:3000/api/form/inve_tien`, keyName: "fk_cerveza,fk_presentacion,fk_tienda,fk_lugar_tienda,cantidad", multiple: true, required: true },
        { label: "Productos", fetchFrom: `http://127.0.0.1:3000/api/form/metodo_pago`, keyName: "eid", multiple: true, required: true }
    ], { callback: data => console.log })

    return (
        <div>
            <a href="/compra">Back</a>
            <h1> Hello to {proveedorId} </h1>
            { form() }
        </div>
    )
}