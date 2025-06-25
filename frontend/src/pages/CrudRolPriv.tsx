import GenerateForm from "@/components/FormGenerator"
import GenerateColumn from "@/components/GenerateColumn"
import SmartLink from "@/components/SmartLink"
import { useEffect, useState } from "react"

// THIS IS FOR WHEN ROL IS SET
export default function CrudRolPriv() {
    let rol = window.location.href.split('/').pop();
    const [missingPrivileges, setMissingPrivileges] = useState<any[]>([])
    const [rolPrivileges, setRolPrivileges] = useState<any[]>([])

    // TABLE
    useEffect(() => {
        fetch(`/api/privilegios/${String(rol)}?missing=true`)
            .then(async res => setMissingPrivileges(await res.json()))
            .catch(console.error)
    }, [])

    useEffect(() => {
        fetch(`/api/privilegios/${String(rol)}?missing=false`)
            .then(async res => setRolPrivileges(await res.json()))
            .catch(console.error)
    }, [])

    const possiblePrivilegios = () => GenerateForm([
    { label: "Eliminar privilegio", keyName: "fk_priv", fetchFrom: `/api/form/privilegios/${String(rol)}?missing=false`, required: true },
    ], { url: `http://127.0.0.1:3000/api/privilegios/${String(rol)}`, method: "DELETE" , callback: () => (window.location.href = `/privilegios/control/${rol}`) })

    const missingPrivilegios = () => GenerateForm([
        { label: "Agregar privilegio", keyName: "fk_priv", fetchFrom: `/api/form/privilegios/${String(rol)}?missing=true`, required: true },
    ], { url: `http://127.0.0.1:3000/api/privilegios/${String(rol)}` , callback: () => (window.location.href = `/privilegios/control/${rol}`) })

    return (
        <div>
            <SmartLink href="/privilegios">Back</SmartLink>

            <h1>Privilegios for Rol Nr {rol}</h1>
            <h2>Privilegios que TIENE</h2>
            <div>
                {GenerateColumn([
                { title: "eid", keyName: "eid" },
                { title: "Nombre", keyName: "nombre" },
                { title: "Descripcion", keyName: "descripcion" },
                ], rolPrivileges)}
            </div>
            <div>{possiblePrivilegios()}</div>
            <h2>Privilegios que NO TIENE</h2>
            <div>
                {GenerateColumn([
                { title: "eid", keyName: "eid" },
                { title: "Nombre", keyName: "nombre" },
                { title: "Descripcion", keyName: "descripcion" },
                ], missingPrivileges)}
            </div>
            <div>{missingPrivilegios()}</div>


        </div>
    )
}
