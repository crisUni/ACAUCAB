import GenerateColumn from "@/components/GenerateColumn";
import SmartLink from "@/components/SmartLink";
import { useEffect, useState } from "react";

function UserMyEvents() {
    const [username, setUsername] = useState(localStorage.getItem('nombre'))
    const clienteID = localStorage.getItem('eid')
    const [eventos, setEventos] = useState([]);
    useEffect(() => {
        fetch(`http://127.0.0.1:3000/api/cliente/${clienteID}/events`)
            .then(async res => setEventos(await res.json()))
            .catch(err => console.error(err))
    }, [])

    return (
        <div>
            <SmartLink href="/user"> Menu Principal</SmartLink>
            <SmartLink href="/user/events"> Eventos</SmartLink>
            <h1>
                Eventos en los que estoy registrado
            </h1>
            {
                GenerateColumn([
                    { title: "Entradas Disponibles", keyName: "cantidad_entradas" },
                    { title: "Nombre", keyName: "nombre" },
                    { title: "Descripcion", keyName: "descripcion" },
                    { title: "Inicio", keyName: "fecha_inicio" },
                    { title: "Fin", keyName: "fecha_fin" },
                    { title: "Direccion", keyName: "direccion" },
                ], eventos, [])
            }
        </div>
    )
}

export default UserMyEvents;