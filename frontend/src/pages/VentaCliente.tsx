import DynamicOptionInputs from "../components/DynamicOptions";
import GenerateForm from "@/components/FormGenerator";
import SmartLink, { goto } from "@/components/SmartLink";
import { useState } from "react";

export default function VentaCliente() {
    let clienteId = window.location.href.split('/').pop();
    
    const form = () => GenerateForm([
        { label: "Productos", fetchFrom: `http://127.0.0.1:3000/api/form/inve_tien`, keyName: "fk_cerveza,fk_presentacion,fk_tienda,fk_lugar_tienda,cantidad", multiple: true, required: true },
        { label: "Metodos De Pago", fetchFrom: `http://127.0.0.1:3000/api/form/metodo_pago`, keyName: "fk_metodo_pago,monto", multiple: true, required: true }
    ], { url: `http://127.0.0.1:3000/api/venta/nueva/${clienteId}` , redirect: `/venta` })

    return (
        <div>
            <SmartLink href="/venta">Back</SmartLink>
            <h1> Hello to {clienteId} </h1>
            { form() }
        </div>
    )
}