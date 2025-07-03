import GenerateForm from "@/components/FormGenerator";
import GenerateColumn from "@/components/GenerateColumn";
import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";

// /user/events/:eventID
function UserSpecificEvent() {
    let eventID = window.location.href.split('/').pop();
    const [eventData, setEventData] = useState<any[]>([]);
    const navigate = useNavigate();
    let userID = localStorage.getItem('eid');

    const entradasCreateForm = () => GenerateForm([
        { label: "cantidad de entradas", keyName: "cantidad_entradas", inputType: "number", required: true },
        { label: "Evento Perteneciente", keyName: "fk_evento", value: eventID }
      ], { url: `http://127.0.0.1:3000/api/evento/${eventID}/${userID}/join`, redirect: "/user/myEvent"})
      

    useEffect(() => {
        fetch(`http://127.0.0.1:3000/api/evento/${eventID}`)
            .then(async res => setEventData(await res.json()))
            .catch(err => console.error(err))
    }, [])

    // manage sign in to event and message if already in it


    return (
        <div>
            <h1>
                Evento {eventID}
            </h1>
            {entradasCreateForm()}

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