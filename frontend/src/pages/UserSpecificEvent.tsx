import GenerateColumn from "@/components/GenerateColumn";
import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";

// /user/events/:eventID
function UserSpecificEvent() {
    let eventID = window.location.href.split('/').pop();
    const [eventData, setEventData] = useState<any[]>([]);
    const navigate = useNavigate();

    useEffect(() => {
        fetch(`http://127.0.0.1:3000/api/evento/${eventID}`)
            .then(async res => setEventData(await res.json()))
            .catch(err => console.error(err))
    }, [])

    // manage sign in to event and message if already in it

    function unirseEvento(){}

    return (
        <div>
            <h1>
                Evento {eventID}
            </h1>
            <button >  
                Unirse Evento
            </button>

            <form onSubmit={unirseEvento}>
            <button type="submit">Submit</button>
            </form>
            <h2>
                Listado de Actividades
            </h2>
            {
                GenerateColumn([
                    { title: "Nombre", keyName: "nombre" }
                ], eventData, [
                    { title: "Detalles", action: (data) => navigate(`/api/evento/${data.eid}`) }
                ])
            }
        </div>
    )
}

export default UserSpecificEvent;