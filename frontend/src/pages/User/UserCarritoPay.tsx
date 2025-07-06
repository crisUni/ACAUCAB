import GenerateForm from "@/components/FormGenerator"
import GenerateColumn from "@/components/GenerateColumn";
import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom"

function PaymentAmount({ monto }: { monto: number }) {
    const navigate = useNavigate()
    const clienteID = localStorage.getItem('eid')

    function handleCorrectPayment() {
        navigate("/user/carrito");
    }

    const form = () => GenerateForm([
        { label: "Numero de Tarjeta", keyName: "numero_tarjeta", inputType: "number", required: true },
        { label: "Fecha de Vencimiento", keyName: "fecha_vence", inputType: "date", required: true },
        { label: "Nombre del Titular", keyName: "nombre_titular", inputType: "text", required: true },
        { label: "CVV", keyName: "cvv", inputType: "number", required: true },
        { label: "Banco", keyName: "fk_banco", fetchFrom: "/api/form/banco", required: true },
        { label: "Tipo de Tarjeta", keyName: "fk_tipo_tarjeta", fetchFrom: "/api/form/tipo_tarjeta", required: true },
        { label: "Monto Total", value: monto, keyName: "monto_total" }
    ], {
        url: `http://127.0.0.1:3000/api/carrito/${clienteID}/pay`, fetchCallback: () => {
            fetch(`http://127.0.0.1:3000/api/carrito/${clienteID}/complete`)
                .then(res => handleCorrectPayment())
                .catch(err => console.error(err))
        }
    })

    return form()
}

function UserCarritoPay() {
    const user = window.localStorage.getItem('eid')
    const [total, setTotal] = useState(null);
    const [puntos, setPuntos] = useState(null);
    const [itemsCarrito, setItemsCarrito] = useState([]);

    useEffect(() => {
        fetch(`http://127.0.0.1:3000/api/carrito/${user}/items`)
            .then(async res => {
                const data = await res.json()
                setItemsCarrito(data)
                setTotal(data.map((x: { precio_total: number }) => x.precio_total).reduce((a: number, b: number) => a + b))
            })
            .catch(err => console.error(err))
    }, [])

    return (
        <div>
            <h1>
                Pagando el Carrito
            </h1>
            <h2>
                Items
            </h2>
            {
                GenerateColumn([
                    { title: "Cantidad", keyName: "cantidad" },
                    { title: "Item", keyName: "nombre_cerveza" },
                    { title: "Presentacion", keyName: "nombre_presentacion" },
                    { title: "Precio Por Unidad", keyName: "precio_unitario" },
                    { title: "Total", keyName: "precio_total" },
                ], itemsCarrito)
            }
            <h2>
                Pagando el Carrito...
            </h2>
            {
                total === null
                    ? "Loading..."
                    : <PaymentAmount monto={total} />
            }
        </div>
    )
}

export default UserCarritoPay