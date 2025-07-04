import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import { AuthProvider } from "@/components/AuthComp";

import Login from "./pages/Login";
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
import VentaCliente from "./pages/VentaCliente";
import CrudInventario from "./pages/CrudInventario";
import ProtectedRoute from "./components/ProtectedRoute";
import CrudRolPriv from "./pages/CrudRolPriv";

const elem = document.getElementById("root")!;
const app = (
  <StrictMode>
    <AuthProvider>
      <Router>
        <Routes>
          <Route path="/login" element={<Login />} />

          <Route path="/" element={<ProtectedRoute element={<TempHome />} />} />
          <Route path="/clientes" element={<ProtectedRoute element={<CrudCliente />} />} />
          <Route path="/clientes-naturales" element={<ProtectedRoute element={<CrudNatural />} />} />
          <Route path="/clientes-juridicos" element={<ProtectedRoute element={<CrudJuridico />} />} />
          <Route path="/usuario" element={<ProtectedRoute element={<CrudUsuario />} />} />
          <Route path="/roles" element={<ProtectedRoute element={<CrudRol />} />} />
          <Route path="/privilegios/*" element={<ProtectedRoute element={<MenuPrivilegios />} />} />
          <Route path="/privilegios/control/*" element={<ProtectedRoute element={<CrudRolPriv />} />} />
          <Route path="/compra" element={<ProtectedRoute element={<CrudCompra />} />} />
          <Route path="/compra/detalle/*" element={<ProtectedRoute element={<DetalleCompra />} />} />
          <Route path="/compra/*" element={<ProtectedRoute element={<CompraProveedor />} />} />
          <Route path="/venta" element={<ProtectedRoute element={<CrudVenta />} />} />
          <Route path="/venta/detalle/*" element={<ProtectedRoute element={<DetalleVenta />} />} />
          <Route path="/venta/*" element={<ProtectedRoute element={<VentaCliente />} />} />
          <Route path="/inventario" element={<ProtectedRoute element={<CrudInventario />} />} />
          
        </Routes>
      </Router>
    </AuthProvider>
  </StrictMode>);

if (import.meta.hot) {
  // With hot module reloading, `import.meta.hot.data` is persisted.
  const root = (import.meta.hot.data.root ??= createRoot(elem));
  root.render(app);
} else {
  // The hot module reloading API is not available in production.
  createRoot(elem).render(app);
}
