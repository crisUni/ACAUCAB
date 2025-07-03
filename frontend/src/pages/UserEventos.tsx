import GenerateColumn from "@/components/GenerateColumn";
import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";

function UserEventos() {
    const [eventData, setEventData] = useState<any[]>([]);
    const navigate = useNavigate();

    useEffect(() => {
        fetch('http://127.0.0.1:3000/api/evento')
            .then(async res => setEventData(await res.json()))
            .catch(err => console.error(err))
    }, [])

    return (
        <div>
            <h1>
                Eventos
            </h1>

            <h2>
                Listado de Eventos
            </h2>
            {
                GenerateColumn([
                    { title: "Nombre", keyName: "nombre" }
                ], eventData, [
                    { title: "Detalles", action: (data) => navigate(`/user/events/${data.eid}`) }
                ])
            }
        </div>
    )
}

export default UserEventos;