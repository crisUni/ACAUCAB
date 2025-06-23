import GenerateForm from "@/components/FormGenerator";
import { useEffect, useState } from "react";



// THIS IS FOR WHEN NO ROL IS SET
function NoRolDetected() {
    const possibleUsers = () => GenerateForm([
        { label: "Rol", keyName: "fk_rol", fetchFrom: "http://127.0.0.1:3000/api/form/roles", required: true },
    ], { callback: (data) => window.location.href = `/privilegios/${data.insert_data.fk_rol}` })

    const PrivCreateForm = () => GenerateForm([
      { label: "Nombre del Privilegio", keyName: "nombre", inputType: "text", required: true },
      { label: "Descripcion", keyName: "descripcion", inputType: "text", required: false }
    ], {url: "http://127.0.0.1:3000/api/privilegio"})

    return (
        <div>
            <a href="/">Back</a>
            <h1>Menu Privilegios</h1>
            <h2>Agregar Privilegio</h2>
            { PrivCreateForm() }
            <h2>Agregar privilegios a un rol</h2>
            Menu para seleccionar rol { /*(deberia redirigir a /privilegios/:rol cuando termines) */}
            {possibleUsers()}
        </div>
    )
}




// THIS IS FOR WHEN ROL IS SET
function RolPrivileges({ rol }: { rol: string }) {
    const [missingPrivileges, setMissingPrivileges] = useState<Array<any>>([])
    const [rolPrivileges, setRolPrivileges] = useState<Array<any>>([])

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
        { label: "Eliminar privilegio", keyName: "fk_priv", fetchFrom: `/api/privilegios/${String(rol)}?missing=false`, required: true },
    ], { url: `http://127.0.0.1:3000/api/privilegios/${String(rol)}`, method: "DELETE", callback: (data) => window.location.href = `/privilegios/${rol}` })

    const missingPrivilegios = () => GenerateForm([
        { label: "Agregar privilegio", keyName: "fk_priv", fetchFrom: `/api/privilegios/${String(rol)}?missing=true`, required: true },
    ], { url: `http://127.0.0.1:3000/api/privilegios/${String(rol)}`, callback: (data) => window.location.href = `/privilegios/${rol}` })

    return (
        <div>
            <a href="/privilegios">Back</a>

            <h1>Privilegios for Rol Nr {rol}</h1>
            <h2>Privilegios que TIENE</h2>
            <ul>
                {rolPrivileges.map(x => <li key={x.eid}> {JSON.stringify(x)}  </li>)}
            </ul>
            <div>{possiblePrivilegios()}</div>
            <h2>Privilegios que NO TIENE</h2>
            <ul>
                {missingPrivileges.map(x => <li key={x.eid}> {JSON.stringify(x)} </li>)}
            </ul>
            <div>{missingPrivilegios()}</div>


        </div>
    )
}

export default function MenuPrivilegios() {
    let rol = window.location.href.split('/').pop();
    if (rol === "privilegios") rol = undefined;
    console.log(rol)

    if (rol === undefined)
        return <NoRolDetected />
    return <RolPrivileges rol={rol} />
}