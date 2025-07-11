import SmartLink from "@/components/SmartLink"

function UserHome() {
    const username = localStorage.getItem("nombre")
    return (
        <div>
            <h1>
                Hola, {username}!
            </h1>
            <ul>
                <li key="shop">
                    <SmartLink href="/user/shop"> Buscar Items en la Tienda </SmartLink>
                </li>
                <li key="events">
                    <SmartLink href="/user/events"> Buscar Eventos Disponibles </SmartLink>
                </li>
                <li key="events">
                    <SmartLink href="/user/myevents"> Ver los eventos en los que estoy registrado </SmartLink>
                </li>
            </ul>
        </div>
    )
}

export default UserHome