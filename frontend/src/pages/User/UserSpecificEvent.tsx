import GenerateForm from "@/components/FormGenerator";
import GenerateColumn from "@/components/GenerateColumn";
import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";

function BuyTicketForm({ eventID, userID, price }: { eventID: string, userID: string, price: number }) {
    const payForm = () => GenerateForm([
        { label: "Cantidad de Entradas", keyName: "numero_entradas", inputType: "number", required: true },
        { label: "Evento Perteneciente", keyName: "fk_evento", value: eventID },
        { label: "Evento Perteneciente", keyName: "precio_entrada", value: price },
        { label: "Numero de Tarjeta", keyName: "numero_tarjeta", inputType: "number", required: true },
        { label: "Fecha de Vencimiento", keyName: "fecha_vence", inputType: "date", required: true },
        { label: "Nombre del Titular", keyName: "nombre_titular", inputType: "text", required: true },
        { label: "CVV", keyName: "cvv", inputType: "number", required: true },
        { label: "Banco", keyName: "fk_banco", fetchFrom: "/api/form/banco", required: true },
        { label: "Tipo de Tarjeta", keyName: "fk_tipo_tarjeta", fetchFrom: "/api/form/tipo_tarjeta", required: true },
        { label: "Monto Final", value_1: "numero_entradas", value_2: "precio_entrada", action: "multiply" }
    ], { url: `http://127.0.0.1:3000/api/evento/${eventID}/${userID}/join` })

    const freeForm = () => GenerateForm([
        { label: "Cantidad de Entradas", keyName: "numero_entradas", inputType: "number", required: true },
        { label: "Evento Perteneciente", keyName: "fk_evento", value: eventID }
    ], { url: `http://127.0.0.1:3000/api/evento/${eventID}/${userID}/join` })

    return (price > 0) ? payForm() : freeForm()
}

// /user/events/:eventID
function UserSpecificEvent() {
    let eventID = window.location.href.split('/').pop();
    const [eventData, setEventData] = useState({
        nombre: '',
        precio_entrada: null
    });
    const [activities, setActivities] = useState<any[]>([]);
    const navigate = useNavigate();
    let userID = localStorage.getItem('eid');

    useEffect(() => {
        fetch(`http://127.0.0.1:3000/api/evento/${eventID}`)
            .then(async res => setActivities(await res.json()))
            .catch(err => console.error(err))

        fetch(`http://127.0.0.1:3000/api/evento/${eventID}/data`)
            .then(async res => setEventData((await res.json())[0]))
            .catch(err => console.error(err))
    }, [])

    // manage sign in to event and message if already in it


    return (
        <div>
            <h1>
                Evento {eventData.nombre === '' ? "Loading..." : String(eventData.nombre)}
            </h1>
            {eventData.precio_entrada === null
                ? "Loading..."
                : <BuyTicketForm eventID={eventID ?? ""} userID={userID ?? ""} price={eventData.precio_entrada} />}

            <h2>
                Listado de Actividades
            </h2>
            {
                GenerateColumn([
                    { title: "Nombre", keyName: "nombre" }
                ], activities, [
                    { title: "Detalles", action: (data) => navigate(`/api/evento/${data.eid}`) }
                ])
            }
        </div>
    )
}

export default UserSpecificEvent;