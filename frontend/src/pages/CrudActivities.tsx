import GenerateForm from "@/components/FormGenerator";
import GenerateColumn from "@/components/GenerateColumn";
import SmartLink, { goto } from "@/components/SmartLink";
import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";

function CrudActivities() {
    let eventID = window.location.href.split('/').pop();
    const [eventData, setEventData] = useState<any[]>([]);
    const [participantsData, setParticipantsData] = useState<any[]>([]);
    const [inventoryData, setInventoryData] = useState<any[]>([]);
    const [salesData, setSalesData] = useState<any[]>([]);
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
        fetch(`http://127.0.0.1:3000/api/evento/${eventID}/participants`)
            .then(async res => setParticipantsData(await res.json()))
            .catch(err => console.error(err))
        fetch(`http://127.0.0.1:3000/api/evento/${eventID}/inventario`)
            .then(async res => setInventoryData(await res.json()))
            .catch(err => console.error(err))
        fetch(`http://127.0.0.1:3000/api/evento/${eventID}/sales`)
            .then(async res => setSalesData(await res.json()))
            .catch(err => console.error(err))
    }, [])

    const itemForm = () => GenerateForm([
        { label: "Item a Agregar", keyName: "fk_cerveza,fk_presentacion", fetchFrom: "http://127.0.0.1:3000/api/form/cerv_pres", required: true },
        { label: "Evento", value: eventID, keyName: "fk_evento" }
    ], { url: `http://127.0.0.1:3000/api/evento/${eventID}/inventario`, fetchCallback: (data) => (window.location.href = window.location.href) })

    const clientForm = () => GenerateForm([
        { label: "Cliente a Invitar", keyName: "fk_cliente,fk_otheer", fetchFrom: "http://127.0.0.1:3000/api/form/clientes", required: true },
        { label: "Cantidad de Entradas", keyName: "cantidad", inputType: "number", required: true },
        { label: "Evento", value: eventID, keyName: "fk_evento" }
    ], { url: `http://127.0.0.1:3000/api/evento/${eventID}/invite`, fetchCallback: (data) => (window.location.href = window.location.href) })

    function updateStock(data: any) {
        data.cantidad = Number(prompt("Seleccione la nueva cantidad para la cerveza"))
        fetch(`http://127.0.0.1:3000/api/evento/${eventID}/inventario`,
            { method: "PUT", body: JSON.stringify(data) })
            .then(res => window.location.href = window.location.href)
    }

    return (
        <div>
            <h1>
                Evento {eventID}
            </h1>

            <h2>
                Crear Actividad
            </h2>
            {
                eventoForm()
            }

            <h2>
                Participantes
            </h2>
            {
                GenerateColumn([
                    { title: "RIF", keyName: "rif" },
                    { title: "Nombre", keyName: "nombre" },
                    { title: "Entradas Compradas", keyName: "cantidad_entradas" },
                ], participantsData, [])
            }

            <h2>
                Registrar Participante
            </h2>

            { clientForm() }

            <h2>
                Registrar Venta
            </h2>

            <SmartLink href={`/events/venta/${eventID}`}> Registrar </SmartLink>

            <h2>
                Gestion de Inventario
            </h2>

            {
                GenerateColumn([
                    { title: "Cerveza", keyName: "nombre_cerveza" },
                    { title: "Presentacion", keyName: "nombre_presentacion" },
                    { title: "Disponible", keyName: "cantidad" },
                ], inventoryData, [{ title: "Editar Stock", action: (data) => updateStock(data) }])
            }

            <h2> Nuevo Item </h2>

            {itemForm()}

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

            <h2>
                Listado de Ventas en el Evento
            </h2>
            {
                GenerateColumn([
                    { title: "Total", keyName: "monto_total" },
                    { title: "Fecha", keyName: "fecha" },
                    { title: "Nombre", keyName: "nombre" },
                    { title: "Apellido", keyName: "apellido" },
                ], salesData, [{ title: "Detalle", action: data => { window.location.href = (`/events/sale/${data.eid}`) } }])
            }
        </div>
    )
}

export default CrudActivities;