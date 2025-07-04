import GenerateForm from "@/components/FormGenerator"
import { useNavigate } from "react-router-dom"

function UserCarritoPay() {
    const clienteID = localStorage.getItem('eid')
    const navigate = useNavigate()

    function handleCorrectPayment() {
        navigate("/user/carrito");
    }

    const form = () => GenerateForm([
        { label: "Numero de Tarjeta", keyName: "numero_tarjeta", inputType: "number", required: true },
        { label: "Fecha de Vencimiento", keyName: "fecha_vence", inputType: "date", required: true },
        { label: "Nombre del Titular", keyName: "nombre_titular", inputType: "text", required: true },
        { label: "CVV", keyName: "cvv", inputType: "number", required: true },
        { label: "Banco", keyName: "fk_banco", fetchFrom: "/api/form/banco", required: true },
        { label: "Tipo de Tarjeta", keyName: "fk_tipo_tarjeta", fetchFrom: "/api/form/tipo_tarjeta", required: true }
    ], { url: `http://127.0.0.1:3000/api/carrito/${clienteID}/pay`, fetchCallback: () => {
        fetch(`http://127.0.0.1:3000/api/carrito/${clienteID}/complete`)
            .then(res => handleCorrectPayment())
            .catch(err => console.error(err))
    } })

    return (
        <div>
            <h1>
                Pagando el Carrito...
            </h1>
            {form()}
        </div>
    )
}

export default UserCarritoPay