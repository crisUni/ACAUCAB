import { useEffect, useState } from "react";
import GenerateForm from "@/components/FormGenerator";
import GenerateColumn from "@/components/GenerateColumn";

const NewCrudNatural = () => GenerateForm([
  { label: "RIF", keyName: "rif", inputType: "text", required: true },
  { label: "Direccion", keyName: "direccion", inputType: "text", required: true },
  { label: "Numero Registro", keyName: "numero_registro", inputType: "number", required: true },
  { label: "Cedula de Identidad", keyName: "ci", inputType: "number", required: true },
  { label: "Nombre", keyName: "nombre", inputType: "text", required: true },
  { label: "Apellido", keyName: "apellido", inputType: "text", required: true },
  { label: "Fecha de Nacimiento", keyName: "fecha_nacimiento", inputType: "date", required: true },
  { label: "Direccion 1", keyName: "fk_lugar_1", fetchFrom: 'http://127.0.0.1:3000/api/form/parroquias', required: true },
], { url: 'http://127.0.0.1:3000/api/cliente_natural' })

export default function CrudNatural() {
  const [naturalData, setNaturalData] = useState<Array<any>>([])

  useEffect(() => {
    fetch("http://127.0.0.1:3000/api/cliente_natural")
      .then(async res => setNaturalData(await res.json()))
      .catch(console.error)
  }, [])

  return (
    <div>
      <a href="/">Back</a>
      <a href="/clientes-juridicos">Juridico</a>
      <h1>Menu Clientes Naturales</h1>
      <h2>Crear Natural</h2>
      <NewCrudNatural />

      <h2>Eliminar Clientes</h2>
      
      <h2> Clientes Naturales </h2>
      <ul>
        { /* TODO: Hacer que lugar 1, 2 no sea el numero sino el lugar*/}
        {GenerateColumn([
          { title: "RIF", keyName: "rif" },
          { title: "Direccion", keyName: "direccion" },
          { title: "Numero Registro", keyName: "numero_registro" },
          { title: "Lugar 1", keyName: "fk_lugar_1" },
          { title: "Cedula", keyName: "cedula" },
          { title: "Nombre", keyName: "nombre" },
          { title: "Apellido", keyName: "apellido" },
          { title: "Fecha de Nacimiento", keyName: "fecha_nacimiento" },
          { title: "Puntos", keyName: "cantidad_puntos" },
        ], naturalData)}
      </ul>
      
    </div>
  )
}
