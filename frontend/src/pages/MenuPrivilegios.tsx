import { useEffect, useState } from "react";
import GenerateForm from "@/components/FormGenerator";
import GenerateColumn from "@/components/GenerateColumn";
import SmartLink, { goto } from "@/components/SmartLink";
import { useNavigate } from "react-router-dom";

export default function NoRolDetected() {
    const possibleRols = () => GenerateForm([
        { label: "Rol", keyName: "fk_rol", fetchFrom: "http://127.0.0.1:3000/api/form/roles", required: true },
    ], { redirect: (`/privilegios/control/`), redirect_var: 'fk_rol' })
    
    const [roleData, setRoleData] = useState<Array<any>>([])

    useEffect(() => {
    fetch("http://127.0.0.1:3000/api/priv")
        .then(async res => setRoleData(await res.json()))
        .catch(console.error)
    }, [])

    return (
        <div>
            <SmartLink href="/">Back</SmartLink>
            <h1>Menu Privilegios</h1>
            <h2>Agregar privilegios a un rol</h2>
            Menu para seleccionar rol
            {possibleRols()}

            <h2>Ver Privilegios</h2>
            {GenerateColumn([
            { title: "eid", keyName: "eid" },
            { title: "Nombre", keyName: "nombre" },
            { title: "Descripcion", keyName: "descripcion" },
            ], roleData)}
        </div>
    )
}
