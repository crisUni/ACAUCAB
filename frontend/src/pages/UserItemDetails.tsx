import GenerateForm from "@/components/FormGenerator";
import { useEffect, useState } from "react";

function UserItemDetails() {
    let [cerveza, presentacion] = window.location.href.split('/').pop()!.split('_');
    const [info, setInfo] = useState({
        nombre_cerveza: 'Cargando Producto...',
        nombre_presentacion: '',
        precio: 'loading...',
        descripcion: 'loading...',
    });
    const [form, setForm] = useState(null); // State to hold the generated form

    const buyNow = () => {
        return GenerateForm([
            { label: "Cantidad", inputType: "number", keyName: "cantidad", required: true },
            { label: "Cerveza", keyName: "fk_cerveza", value: cerveza },
            { label: "Presentacion", keyName: "fk_presentacion", value: presentacion },
            { label: "Precio por Unidad", keyName: "precio_unitario", value: info.precio },
        ], {});
    };

    useEffect(() => {
        fetch(`http://127.0.0.1:3000/api/item/${cerveza}_${presentacion}`)
            .then(async res => {
                const data = await res.json();
                setInfo(data);
                // Generate the form after data is loaded
                setForm(buyNow());
            })
            .catch(err => console.error(err));
    }, [cerveza, presentacion]);

    return (
        <div>
            <h1>
                {info.nombre_presentacion} {info?.nombre_cerveza}
            </h1>
            <h2>
                Detalles
            </h2>
            <ul>
                <li key="precio">
                    <label>Precio: </label> {info.precio}
                </li>
                <li key="descripcion">
                    <label>Descripción: </label> {info.descripcion}
                </li>
            </ul>
            {/* Render the form only if it has been generated */}
            {form}
        </div>
    );
}

export default UserItemDetails;
