import GenerateForm from "@/components/FormGenerator";
import { useState } from "react";

const possibleUsers = () => GenerateForm([
  { label: "Nombre de Usuario", keyName: "nombre", inputType: "text", required: true },
  { label: "Contraseña", keyName: "contraseña", inputType: "password", required: true },
  { label: "Cliente | Empleado | Proveedor al que pertenece la cuenta",
    keyName: "fk_cliente,fk_empleado,fk_proveedor", fetchFrom: "http://127.0.0.1:3000/api/form/user_creation", required: true },
  { label: "Rol de la Cuenta", keyName: "fk_rol", fetchFrom: "http://127.0.0.1:3000/api/form/roles", required: true },
  ], "http://127.0.0.1:3000/api/usuario")

export default function CrudUsuario() {
    return (
        <div>
            <a href="/">Back</a>
            <h1>"Crear Usuario"</h1>
            { possibleUsers() }
        </div>
    )
}