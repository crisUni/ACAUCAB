import { useEffect, useState } from "react";
import GenerateForm from "@/components/FormGenerator";
import GenerateColumn from "@/components/GenerateColumn";
import SmartLink, { goto } from "@/components/SmartLink";

const NewCrudJuridico = () => GenerateForm([
  { label: "RIF", keyName: "rif", inputType: "text", required: true },
  { label: "Direccion", keyName: "direccion", inputType: "text", required: true },
  { label: "Numero Registro", keyName: "numero_registro", inputType: "number", required: true },
  { label: "Denominacion Comercial", keyName: "denominacion_comercial", inputType: "text", required: true },
  { label: "Razon Social", keyName: "razon_social", inputType: "text", required: true },
  { label: "Pagina Web", keyName: "pagina_web", inputType: "text", required: true },
  { label: "Fecha de Nacimiento", keyName: "fecha_nacimiento", inputType: "date", required: true },
  { label: "Capital Disponible", keyName: "capital_disponible", inputType: "number", required: true },
  { label: "Direccion Fisica Principal", keyName: "fk_lugar_1", fetchFrom: 'http://127.0.0.1:3000/api/form/parroquias', required: true },
  { label: "Direccion Fiscal", keyName: "fk_lugar_2", fetchFrom: 'http://127.0.0.1:3000/api/form/parroquias', required: true }
], { url: 'http://127.0.0.1:3000/api/cliente_juridico' , callback: () => (window.location.href = `/clientes-juridicos`) })

export default function CrudJuridico() {
  const [juridicoData, setJuridicoData] = useState<Array<any>>([])

  useEffect(() => {
    fetch("http://127.0.0.1:3000/api/cliente_juridico")
      .then(async res => setJuridicoData(await res.json()))
      .catch(console.error)
  }, [])

  return (
    <div>
      <SmartLink href="/">Back</SmartLink>
      <SmartLink href="/clientes-naturales">Natural</SmartLink>
      
      <h1>Menu Clientes Juridicos</h1>

      <h2>Crear Juridico</h2>
      {NewCrudJuridico()}

      <h2>Eliminar Juridico</h2>

      <h2> Clientes Juridicos </h2>
      <ul>
        { /* TODO: Hacer que lugar 1, 2 no sea el numero sino el lugar*/}
        {GenerateColumn([
          { title: "RIF", keyName: "rif" },
          { title: "Direccion", keyName: "direccion" },
          { title: "Numero Registro", keyName: "numero_registro" },
          { title: "Lugar 1", keyName: "fk_lugar_1" },
          { title: "Lugar 2", keyName: "fk_lugar_2" },
          { title: "Denominacion Comercial", keyName: "denominacion_comercial" },
          { title: "Razon Social", keyName: "razon_social" },
          { title: "Pegina Web", keyName: "pagina_web" },
          { title: "Capital Disponible", keyName: "capital_disponible" },
          { title: "Puntos", keyName: "cantidad_puntos" },
        ], juridicoData)}
      </ul>
    </div>
  )
}
