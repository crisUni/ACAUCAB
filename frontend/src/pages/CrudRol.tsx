import GenerateForm from "@/components/FormGenerator";
import { useState } from "react";

const RolCreateForm = () => GenerateForm([
  { label: "Nombre del Rol", keyName: "nombre", inputType: "text", required: true },
  { label: "Descripcion", keyName: "descripcion", inputType: "text", required: false }
], {url: "http://127.0.0.1:3000/api/roles"})

const possiblerol = () => GenerateForm([
    { label: "Rol", keyName: "fk_rol", fetchFrom: "http://127.0.0.1:3000/api/form/roles", required: true },
], { callback: (data) => window.location.href = `/privilegios/${data.insert_data.fk_rol}` })

export default function CrudRol() {
    return (
        <div>
            <a href="/">Back</a>
            <h1>Menu Roles</h1>
            <h2>Agregar Rol</h2>
            { RolCreateForm() }

            <h2>Eliminar Roles</h2>
            {possiblerol()}



        </div>
    )
}