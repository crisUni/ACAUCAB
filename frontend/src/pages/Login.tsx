import { useEffect, useState } from "react";
import GenerateForm from "@/components/FormGenerator";

function validateUserLogin(data: any) {
    console.log(data.token)
}

const LoginForm = () => GenerateForm([
  { label: "Nombre de usuario", keyName: "nombre", inputType: "text", required: true },
  { label: "Contraseña", keyName: "contrasena", inputType: "password", required: false }
], { url: "http://127.0.0.1:3000/api/login", fetchCallback: data => validateUserLogin(data[0]) })

export default function CrudRol() {

    return (
        <div>
            <h1>ACAUCAB</h1>
            <h2>Iniciar Secion</h2>
            { LoginForm() }
        </div>
    )
}