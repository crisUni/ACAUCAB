import GenerateColumn from "@/components/GenerateColumn";
import SmartLink from "@/components/SmartLink";
import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";

function UserShop() {
    const [cervezasData, setCervezasData] = useState<any[]>([])
    const navigate = useNavigate();

    useEffect(() => {
        fetch("http://127.0.0.1:3000/api/inventario_online")
            .then(async res => setCervezasData(await res.json()))
            .catch(err => console.error(err))
    }, [])

    return (<div>
        <SmartLink href={"/user/carrito"} > Ver Carrito </SmartLink>
        <h1>
            Shop
        </h1>
            {
                GenerateColumn([
                    { title: "Nombre", keyName: "cerveza" },
                    { title: "Presentacion", keyName: "presentacion" },
                ], cervezasData, [ { title: "Ver Detalles", action: (data) => (navigate(`/user/shop/item/${data.fk_cerveza}_${data.fk_presentacion}`)) }])
            }
    </div>)
}

export default UserShop;