import { useEffect, useState } from "react";
import GenerateForm from "@/components/FormGenerator";
import { AuthProvider, useAuth } from "@/components/AuthComp";
import { useNavigate } from "react-router-dom";

const Login = () => {
    const { login } = useAuth();
    const navigate = useNavigate();
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');

    function validateUserLogin(data: { token: string, nombre: string, eid: number }) {
        if (data.token) {
            login(data.token, data.nombre, String(data.eid));
            navigate('/');
        } else {
            alert("Login fallo!")
        }
    }

    const LoginForm = () => GenerateForm([
        { label: "Nombre de usuario", keyName: "nombre", inputType: "text", required: true },
        { label: "Contraseña", keyName: "contrasena", inputType: "password", required: false }
    ], { url: "http://127.0.0.1:3000/api/login", fetchCallback: data => validateUserLogin(data[0]) })

    return (
        LoginForm()
    );
};

export default Login;