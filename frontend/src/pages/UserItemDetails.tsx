import GenerateForm from "@/components/FormGenerator";
import SmartLink from "@/components/SmartLink";
import { useEffect, useState } from "react";

function BuyNowButton({ cerveza, presentacion, precio }: { cerveza: number, presentacion: number, precio: number }) {
    const cliente = window.localStorage.getItem('eid')
    const buyNow = () => GenerateForm([
        { label: "Cantidad", inputType: "number", keyName: "cantidad", required: true },
        { label: "Cerveza", keyName: "fk_cerveza", value: cerveza },
        { label: "Presentacion", keyName: "fk_presentacion", value: presentacion },
        { label: "Precio por Unidad", keyName: "precio_unitario", value: precio },
    ], { url: `http://127.0.0.1:3000/api/carrito/${cliente}/items`, redirect: "/user/carrito" })
    return buyNow()
}

function UserItemDetails() {
    let [cerveza, presentacion] = window.location.href.split('/').pop()!.split('_');
    const [info, setInfo] = useState({
        nombre_cerveza: 'Cargando Producto...',
        nombre_presentacion: '',
        precio: 'loading...',
        descripcion: 'loading...',
    });

    useEffect(() => {
        fetch(`http://127.0.0.1:3000/api/item/${cerveza}_${presentacion}`)
            .then(async res => setInfo(await res.json()))
            .catch(err => console.error(err))
    }, [])

    return (
        <div>
            <SmartLink href={"/user/shop"} > Back to Shop </SmartLink>
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
                    <label>Precio: </label> {info.descripcion}
                </li>
            </ul>
            {info.nombre_presentacion === ''
                ? <></>
                : <BuyNowButton cerveza={Number(cerveza)} presentacion={Number(presentacion)} precio={Number(info.precio)} />}
        </div>
    )
}

export default UserItemDetails