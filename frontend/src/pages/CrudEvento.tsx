import { useEffect, useState } from "react";
import GenerateForm from "@/components/FormGenerator";
import GenerateColumn from "@/components/GenerateColumn";
import SmartLink from "@/components/SmartLink";

const EventCreateForm = () => GenerateForm([
  { label: "Nombre del Evento", keyName: "nombre", inputType: "text", required: true },
  { label: "Descripcion", keyName: "descripcion", inputType: "text", required: false }
], { url: "http://127.0.0.1:3000/api/evento", callback: () => (window.location.href = `/roles`)})

export default function CrudRol() {
    const [eventData, setEventData] = useState<Array<any>>([])

    useEffect(() => {
    fetch("http://127.0.0.1:3000/api/roles")
        .then(async res => setEventData(await res.json()))
        .catch(console.error)
    }, [])
    return (
        <div>
            <SmartLink href="/">Back</SmartLink>
            <h1>Menu Roles</h1>
            <h2>Agregar Rol</h2>
            { EventCreateForm() }


            <h2>Ver Roles</h2>
            {GenerateColumn([
            { title: "eid", keyName: "eid" },
            { title: "Nombre", keyName: "nombre" },
            { title: "Descripcion", keyName: "descripcion" },
            ], eventData)}
        </div>
    )
}