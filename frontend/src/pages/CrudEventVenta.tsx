import GenerateForm from "@/components/FormGenerator"

function CrudEventVenta() {
    let eventID = window.location.href.split('/').pop();

    const form = () => GenerateForm([
        { label: "Cliente", fetchFrom: `http://127.0.0.1:3000/api/form/pnatural`, keyName: "fk_cliente,fk_pnatural", required: true },
        { label: "Productos", fetchFrom: `http://127.0.0.1:3000/api/evento/${eventID}/inventario/form`, keyName: "fk_cerveza,fk_presentacion,fk_evento,cantidad", multiple: true, required: true },
        { label: "Metodos De Pago", fetchFrom: `http://127.0.0.1:3000/api/form/metodo_pago`, keyName: "fk_metodo_pago,monto", multiple: true, required: true }
    ], { url: `http://127.0.0.1:3000/api/evento/${eventID}/buyItem`, redirect: `/events/details/${eventID}` } )

    return (
        <div>
            { form() }
        </div>
    )
}

export default CrudEventVenta