import GenerateColumn from "@/components/GenerateColumn";
import SmartLink from "@/components/SmartLink";
import { useEffect, useState } from "react";

function UserCarrito() {
    const user = window.localStorage.getItem('eid')
    const [itemsCarrito, setItemsCarrito] = useState([]);

    useEffect(() => {
        fetch(`http://127.0.0.1:3000/api/carrito/${user}/items`)
            .then(async res => setItemsCarrito(await res.json()))
            .catch(err => console.error(err))
    }, [])

    return (
        <div>
            <SmartLink href={"/user/shop"} > Back to Shop </SmartLink>
            <h1>
                Carrito
            </h1>
            {
                GenerateColumn([
                    { title: "Cantidad", keyName: "cantidad" },
                    { title: "Item", keyName: "nombre_cerveza" },
                    { title: "Presentacion", keyName: "nombre_presentacion" },
                    { title: "Precio Por Unidad", keyName: "precio_unitario" },
                ], itemsCarrito, [
                    {
                        title: "-", action: data => fetch(`http://127.0.0.1:3000/api/carrito/${user}/items`,
                            { method: "DELETE", body: JSON.stringify([data]) })
                            .then(_ => window.location.reload())
                            .catch(err => console.error(err))
                    },
                    {
                        title: "Cantidad", action: data => {
                            const nueva_cantidad = prompt("Ingrese la nueva cantidad del producto")
                            data.cantidad = nueva_cantidad || ""

                            if (nueva_cantidad === "0" || nueva_cantidad === "")
                                return alert("Ingrese un valor valido o diferente a cero!")

                            delete data.nombre_cerveza
                            delete data.nombre_presentacion
                            delete data.eid
                            fetch(`http://127.0.0.1:3000/api/carrito/${user}/items`,
                                { method: "POST", body: JSON.stringify([data]) })
                                .then(_ => window.location.reload())
                                .catch(err => console.error(err))
                        }
                    }
                ])
            }
        <SmartLink href={"/user/carrito/pay"} > Pagar el Carrito </SmartLink>
        </div>
    )
}

export default UserCarrito