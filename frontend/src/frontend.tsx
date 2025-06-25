import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';

import { App } from "./App";
import CrudCliente from "./pages/Clientes/CrudCliente";
import CrudNatural from "./pages/Clientes/CrudNatural";
import CrudJuridico from "./pages/Clientes/CrudJuridico";

import CrudUsuario from "./pages/CrudUsuario";
import TempHome from "./pages/TempHome";
import CrudRol from "./pages/CrudRol";
import MenuPrivilegios from "./pages/MenuPrivilegios";
import CrudCompra from "./pages/CrudCompra";
import CompraProveedor from "./pages/CompraProveedor";
import CrudVenta from "./pages/CrudVenta";
import DetalleCompra from "./pages/DetalleCompra";
import DetalleVenta from "./pages/DetalleVenta";

const elem = document.getElementById("root")!;
const app = (
  <StrictMode>
    <Router>
        <Routes>
          <Route path="/" element={<TempHome />} />
          <Route path="/clientes" element={<CrudCliente />} />
          <Route path="/clientes-naturales" element={<CrudNatural />} />
          <Route path="/clientes-juridicos" element={<CrudJuridico />} />

          <Route path="/usuario" element={<CrudUsuario />} />
          <Route path="/roles" element={<CrudRol />} />
          <Route path="/privilegios/*" element={<MenuPrivilegios />} />
          <Route path="/compra" element={<CrudCompra />} />
          <Route path="/compra/detalle/*" element={<DetalleCompra />} />
          <Route path="/compra/*" element={<CompraProveedor />} />
          <Route path="/venta" element={<CrudVenta />} />
          <Route path="/venta/detalle/*" element={<DetalleVenta />} />
        </Routes>
    </Router>
  </StrictMode>
);

if (import.meta.hot) {
  // With hot module reloading, `import.meta.hot.data` is persisted.
  const root = (import.meta.hot.data.root ??= createRoot(elem));
  root.render(app);
} else {
  // The hot module reloading API is not available in production.
  createRoot(elem).render(app);
}
