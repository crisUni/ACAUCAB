import { useEffect, useState } from "react";
import GenerateForm from "@/components/FormGenerator";
import GenerateColumn from "@/components/GenerateColumn";
import SmartLink, { goto } from "@/components/SmartLink";

const possibleClients = () => GenerateForm([
  { label: "Cliente: ", keyName: "eid", fetchFrom: "http://127.0.0.1:3000/api/form/clientes", required: true },
], { redirect: `/venta/`, redirect_var: `eid` })

export default function CrudVenta() {
  const [ventaData, setVentaData] = useState<Array<any>>([])

  useEffect(() => {
    fetch("http://127.0.0.1:3000/api/venta")
      .then(async res => setVentaData(await res.json()))
      .catch(console.error)
  }, [])

  return (
    <div>
      <SmartLink href="/">Back</SmartLink>
      <h1>Menu Ventas</h1>
      <h2> Seleccionar a quien se le haremos la compra </h2>
      {possibleClients()}
      <h2>Visualizador</h2>
      {GenerateColumn([
        { title: "Id", keyName: "eid" },
        { title: "Fecha", keyName: "fecha" },
        { title: "Monto Total", keyName: "monto_total" },
        { title: "Tienda Fisica", keyName: "fk_tienda_fisica" },
        { title: "Tienda Virtual", keyName: "fk_tienda?_virtual" },
        { title: "Evento", keyName: "fk_evento" },
        { title: "Cliente", keyName: "fk_cliente" },
      ], ventaData, [{ title: "Detalle", action: data => { window.location.href = (`/venta/detalle/${data.eid}`) } }])}
    </div>
  )
}