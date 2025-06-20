import GenerateForm from "@/components/FormGenerator";
import { useEffect, useState } from "react";



// THIS IS FOR WHEN NO ROL IS SET
function NoRolDetected() {
    const possibleUsers = () => GenerateForm([
        { label: "Rol", keyName: "fk_rol", fetchFrom: "http://127.0.0.1:3000/api/form/roles", required: true },
    ], { callback: (data) => window.location.href = `/privilegios/${data.insert_data.fk_rol}` })

    return (
        <div>
            <a href="/">Back</a>
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
        fetch(`/api/privilegios/${rol}?missing=true`)
            .then(async res => setMissingPrivileges(await res.json()))
            .catch(console.error)
    }, [])

    useEffect(() => {
        fetch(`/api/privilegios/${rol}?missing=false`)
            .then(async res => setRolPrivileges(await res.json()))
            .catch(console.error)
    }, [])

    return (
        <div>
          <a href="/privilegios">Back</a>
          <h1>Privileges for Rol Nr {rol}</h1>
          <h2>Privileges [HAVE]</h2>
          <ul>
            {rolPrivileges.map(x => <li key={x.eid}> {JSON.stringify(x)}  </li>)}
          </ul>
          <h2>Privileges [DONT HAVE]</h2>
          <ul>
            {missingPrivileges.map(x => <li key={x.eid}> {JSON.stringify(x)} </li>)}
          </ul>
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