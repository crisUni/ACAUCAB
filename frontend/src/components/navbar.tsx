import { createRoot } from "react-dom/client";
import "./navbar.css"
import react from "../react.svg";

export function Navbar() {
    return (
      <div className="navbar">
        <div className="nav-left">
          <img src={react} alt="Bun Logo" className="logo bun-logo" />
          <h1>ACAUCAB</h1>
        </div>
        <div className="nav-right">
          <h1>Carrito</h1>
          <h1>Cuenta</h1>
        </div>
      </div>
    );
  }
export default Navbar;

const elem = document.getElementById("root")!

if (import.meta.hot) {
  // With hot module reloading, `import.meta.hot.data` is persisted.
  const root = (import.meta.hot.data.root ??= createRoot(elem));
  root.render(Navbar());
} else {
  // The hot module reloading API is not available in production.
  createRoot(elem).render(Navbar());
}