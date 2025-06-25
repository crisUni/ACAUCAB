import { useEffect, useState } from "react";
import GenerateForm from "@/components/FormGenerator";
import GenerateColumn from "@/components/GenerateColumn";
import SmartLink from "@/components/SmartLink";

export default function CrudCliente() {
  return (
    <div>
      <h1>Menu Clientes</h1>
      <SmartLink href="/">Back</SmartLink>
      <h2>Menu Naturales</h2>
      <SmartLink href="/clientes-naturales">Natural</SmartLink>
      <h2>Menu Juridicos</h2>
      <SmartLink href="/clientes-juridicos">Juridico</SmartLink>
    </div>
  )
}
