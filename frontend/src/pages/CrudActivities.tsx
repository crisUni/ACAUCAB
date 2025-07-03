import GenerateForm from "@/components/FormGenerator";
import GenerateColumn from "@/components/GenerateColumn";
import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";

function CrudActivities() {
    let eventID = window.location.href.split('/').pop();
    const [eventData, setEventData] = useState<any[]>([]);
    const navigate = useNavigate();
    const eventoForm = () => GenerateForm([
        { label: "Nombre", keyName: "nombre", inputType: "text", required: true },
        { label: "Descripcion", keyName: "descripcion", inputType: "text", required: false },
        { label: "Numero de Entradas", keyName: "numero_entradas", inputType: "number", required: true },
        { label: "Fecha y Hora de Inicio", keyName: "fecha_inicio", inputType: "datetime-local", required: true },
        { label: "Fecha y Hora de Culminacion", keyName: "fecha_fin", inputType: "datetime-local", required: true },
        { label: "Direccion Escrita", keyName: "direccion", inputType: "text", required: true },
        { label: "Precio de Entrada", keyName: "precio_entrada", inputType: "number", required: true },
        { label: "Tipo de Evento", keyName: "fk_tipo_evento", fetchFrom: 'http://127.0.0.1:3000/api/form/tipo_evento', required: true },
        { label: "Ubicacion", keyName: "fk_lugar", fetchFrom: 'http://127.0.0.1:3000/api/form/parroquias', required: true },
        { label: "Evento Perteneciente", keyName: "fk_evento", value: eventID },
    ], { url: 'http://127.0.0.1:3000/api/evento' })

    useEffect(() => {
        fetch(`http://127.0.0.1:3000/api/evento/${eventID}`)
            .then(async res => setEventData(await res.json()))
            .catch(err => console.error(err))
    }, [])

    return (
        <div>
            <h1>
                Evento {eventID}
            </h1>

            <h2>
                Create Activity
            </h2>
            {
                eventoForm()
            }


            <h2>
                Listado de Actividades
            </h2>
            {
                GenerateColumn([
                    { title: "Nombre", keyName: "nombre" },
                    { title: "Descripcion", keyName: "descripcion" },
                    { title: "Entradas Total", keyName: "numero_entradas" },
                    { title: "Inicio", keyName: "fecha_inicio" },
                    { title: "Fin", keyName: "fecha_fin" },
                    { title: "Direccion", keyName: "direccion" },
                    { title: "Precio", keyName: "precio_entrada" }
                ], eventData, [])
            }
        </div>
    )
}

export default CrudActivities;