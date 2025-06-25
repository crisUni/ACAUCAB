import GenerateColumn from "@/components/GenerateColumn";
import SmartLink, { goto } from "@/components/SmartLink";
import { useEffect, useState } from "react";

export default function CrudInventario() {
    const [inventarioData, setInventarioData] = useState<Array<any>>([])

    useEffect(() => {
        fetch("http://127.0.0.1:3000/api/inventario_tienda")
            .then(async res => setInventarioData(await res.json()))
            .catch(console.error)
    }, [])

    function updateStock(data: any) {
        data.cantidad = Number(prompt("Seleccione la nueva cantidad para la cerveza"))
        fetch("http://127.0.0.1:3000/api/inventario_tienda",
            { method: "PUT", body: JSON.stringify(data) })
            .then(res => goto(window.location.href))
    }

    return (
        <div>
            <SmartLink href="/">Back</SmartLink>
            <h1> Inventario </h1>
            <ul>
                { /* TODO: Hacer que lugar 1, 2 no sea el numero sino el lugar*/}
                {GenerateColumn([
                    { title: "Cerveza", keyName: "fk_cerveza_display" },
                    { title: "Presentacion", keyName: "fk_presentacion_display" },
                    { title: "Lugar En Tienda", keyName: "fk_lugar_tienda_display" },
                    { title: "Stock", keyName: "cantidad" },
                ], inventarioData, [{ title: "Editar Stock", action: (data) => updateStock(data) }])}
            </ul>
        </div>
    )
}