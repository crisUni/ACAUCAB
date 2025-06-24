import DynamicOptionInputs from "../components/DynamicOptions";
import GenerateForm from "@/components/FormGenerator";
import { useState } from "react";

export default function CompraProveedor() {
    let proveedorId = window.location.href.split('/').pop();
    
    const form = () => GenerateForm([
        { label: "Productos", fetchFrom: "http://127.0.0.1:3000/api/form/inve_tien", keyName: "fk_cerveza,fk_presentacion,fk_tienda,fk_lugar_tienda", multiple: true, required: true }
    ], { callback: data => console.log(data) })

    return (
        <div>
            Hello to {proveedorId}
            { form() }
        </div>
    )
}