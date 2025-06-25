import { useEffect, useState } from "react";
import GenerateForm from "@/components/FormGenerator";
import GenerateColumn from "@/components/GenerateColumn";

export default function CrudCliente() {
  return (
    <div>
      <h1>Menu Clientes</h1>
      <a href="/">Back</a>
      <h2>Menu Naturales</h2>
      <a href="/clientes-naturales">Natural</a>
      <h2>Menu Juridicos</h2>
      <a href="/clientes-juridicos">Juridico</a>
    </div>
  )
}
