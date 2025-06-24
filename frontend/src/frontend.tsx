import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';

import { App } from "./App";
import CrudCliente from "./pages/CrudCliente";
import CrudUsuario from "./pages/CrudUsuario";
import TempHome from "./pages/TempHome";
import CrudRol from "./pages/CrudRol";
import MenuPrivilegios from "./pages/MenuPrivilegios";
import CrudCompra from "./pages/CrudCompra";
import CompraProveedor from "./pages/CompraProveedor";

const elem = document.getElementById("root")!;
const app = (
  <StrictMode>
    <Router>
        <Routes>
          <Route path="/" element={<TempHome />} />
          <Route path="/clientes" element={<CrudCliente />} />
          <Route path="/usuario" element={<CrudUsuario />} />
          <Route path="/roles" element={<CrudRol />} />
          <Route path="/privilegios/*" element={<MenuPrivilegios />} />
          <Route path="/compra" element={<CrudCompra />} />
          <Route path="/compra/*" element={<CompraProveedor />} />
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
