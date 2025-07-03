import GenerateForm from "@/components/FormGenerator"
import GenerateColumn from "@/components/GenerateColumn";
import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";

type Event = {
    eid: number;               // SERIAL PRIMARY KEY
    nombre: string;            // VARCHAR(100) NOT NULL
    descripcion: string;       // TEXT NOT NULL
    numero_entradas: number;   // INT NOT NULL
    fecha_inicio: Date;        // DATE NOT NULL // TODO: Change this from DATE to TIMESTAMP
    fecha_fin: Date;           // DATE NOT NULL // TODO: Change this from DATE to TIMESTAMP
    direccion: string;         // TEXT NOT NULL
    precio_entrada: number;    // FLOAT NOT NULL
    fk_evento?: number;        // INT (optional)
    fk_tipo_evento: number;    // INT NOT NULL
    fk_lugar: number;          // INT NOT NULL
};

function CrudEvents() {
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
    ], { url: 'http://127.0.0.1:3000/api/evento' })

    useEffect(() => {
        fetch('http://127.0.0.1:3000/api/evento')
            .then(async res => setEventData(await res.json()))
            .catch(err => console.error(err))
    }, [])

    return (
        <div>
            <h1>
                Events
            </h1>

            <h2>
                New Event
            </h2>
            {eventoForm()}

            <h2>
                Event Listing
            </h2>
                {GenerateColumn([
                    { title: "Nombre", keyName: "nombre" }
                ], eventData, [
                    { title: "Detalles", action: (data) => navigate(`/events/${data.eid}`) }
                ])}
        </div>
    )
}

export default CrudEvents