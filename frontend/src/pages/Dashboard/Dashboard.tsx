import SmartLink from "@/components/SmartLink"

function Dashboard() {
  const username = localStorage.getItem("nombre")
  return (
    <div>

      <SmartLink href="/"> Regresar </SmartLink>

      <h1>Menu Dasboard</h1>
      <ul>
        <li>
          <SmartLink href="/indicadores/venta">Indicadores Venta</SmartLink>
        </li>
        <li>
          <SmartLink href="/indicadores/cliente">Indicadores Cliente</SmartLink>
        </li>
        <li>
          <SmartLink href="/indicadores/inventario">Indicadores Inventario</SmartLink>
        </li>
      </ul>
    </div>
  )
}

export default Dashboard