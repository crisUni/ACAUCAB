import { useEffect, useState } from "react";
import GenerateForm from "@/components/FormGenerator";
import GenerateColumn from "@/components/GenerateColumn";
import SmartLink from "@/components/SmartLink";

const possibleUsers = () => GenerateForm([
  { label: "Nombre de Usuario", keyName: "nombre", inputType: "text", required: true },
  { label: "Contraseña", keyName: "contraseña", inputType: "password", required: true },
  { label: "Cliente | Empleado | Proveedor al que pertenece la cuenta",
    keyName: "fk_cliente,fk_empleado,fk_proveedor",
    fetchFrom: "http://127.0.0.1:3000/api/form/user_creation",
    required: true },
  { label: "Rol de la Cuenta", keyName: "fk_rol", fetchFrom: "http://127.0.0.1:3000/api/form/roles", required: true },
  ], {url:"http://127.0.0.1:3000/api/usuario" , callback: () => (window.location.href = `/usuario`)})


export default function CrudUsuario() {
  const [usuarioData, setUsuarioData] = useState<Array<any>>([])
  
  useEffect(() => {
    fetch("http://127.0.0.1:3000/api/form/usuarios")
      .then(async res => setUsuarioData(await res.json()))
      .catch(console.error)
  }, [])


    return (
        <div>
            <SmartLink href="/">Back</SmartLink>
            <h1>Menu Usuarios</h1>
            <h2>Crear Usuario</h2>
            { possibleUsers() }
            <h2>Ver Usuarios</h2>
            {GenerateColumn([
                { title: "Identificador", keyName: "eid" },
                { title: "Nombre", keyName: "nombre" },
                { title: "Contraseña", keyName: "contraseña" },
                { title: "fk_empleado", keyName: "fk_empleado" },
                { title: "fk_cliente", keyName: "fk_cliente" },
                { title: "fk_proveedor", keyName: "fk_proveedor" },
                { title: "fk_rol", keyName: "fk_rol" },
            ], usuarioData)}
        </div>
    )
}