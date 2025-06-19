import GenerateForm from "@/components/FormGenerator";
import { useState } from "react";

const RolCreateForm = () => GenerateForm([
  { label: "Nombre del Rol", keyName: "nombre", inputType: "text", required: true },
  { label: "Descripcion", keyName: "descripcion", inputType: "text", required: false }
], "http://127.0.0.1:3000/api/roles")

export default function CrudRol() {
    return (
        <div>
            <a href="/">Back</a>
            <h1>"Crear Roles"</h1>
            { RolCreateForm() }
        </div>
    )
}