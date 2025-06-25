import { useEffect, useState } from "react";
import GenerateForm from "@/components/FormGenerator";
import GenerateColumn from "@/components/GenerateColumn";
import SmartLink from "@/components/SmartLink";

const RolCreateForm = () => GenerateForm([
  { label: "Nombre del Rol", keyName: "nombre", inputType: "text", required: true },
  { label: "Descripcion", keyName: "descripcion", inputType: "text", required: false }
], { url: "http://127.0.0.1:3000/api/roles", callback: () => (window.location.href = `/roles`)})

const RolDeleteForm = () => GenerateForm([
    { label: "Rol", keyName: "eid", fetchFrom: "http://127.0.0.1:3000/api/form/roles", required: true },
], { url: `http://127.0.0.1:3000/api/roles`, method: "DELETE" })

export default function CrudRol() {
    const [roleData, setRoleData] = useState<Array<any>>([])

    useEffect(() => {
    fetch("http://127.0.0.1:3000/api/roles")
        .then(async res => setRoleData(await res.json()))
        .catch(console.error)
    }, [])
    return (
        <div>
            <SmartLink href="/">Back</SmartLink>
            <h1>Menu Roles</h1>
            <h2>Agregar Rol</h2>
            { RolCreateForm() }


            <h2>Ver Roles</h2>
            {GenerateColumn([
            { title: "eid", keyName: "eid" },
            { title: "Nombre", keyName: "nombre" },
            { title: "Descripcion", keyName: "descripcion" },
            ], roleData)}
        </div>
    )
}