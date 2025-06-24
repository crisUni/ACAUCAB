import GenerateForm from "@/components/FormGenerator"

const possibleProviders = () => GenerateForm([
    { label: "Rol", keyName: "eid", fetchFrom: "http://127.0.0.1:3000/api/form/providers", required: true },
], { callback: (data) => window.location.href = `/compra/${data.insert_data.eid}` })


export default function CrudCompra() {
    return (
    <div>
        <a href="/">Back</a>
        <h1> Seleccionar a quien se le haremos la compra </h1>
        { possibleProviders() }
    </div>
    )
}