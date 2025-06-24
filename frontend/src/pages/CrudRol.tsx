import GenerateForm from "@/components/FormGenerator";
import { useState } from "react";

const RolCreateForm = () => GenerateForm([
  { label: "Nombre del Rol", keyName: "nombre", inputType: "text", required: true },
  { label: "Descripcion", keyName: "descripcion", inputType: "text", required: false }
], { url: "http://127.0.0.1:3000/api/form/roles" })

const RolDeleteForm = () => GenerateForm([
    { label: "Rol", keyName: "eid", fetchFrom: "http://127.0.0.1:3000/api/form/roles", required: true },
], { url: `http://127.0.0.1:3000/api/roles`, method: "DELETE" })

export default function CrudRol() {
    return (
        <div>
            <a href="/">Back</a>
            <h1>Menu Roles</h1>
            <h2>Agregar Rol</h2>
            { RolCreateForm() }

            <h2>Eliminar Roles</h2>
            { RolDeleteForm() }
        </div>
    )
}