import { createRoot } from "react-dom/client";
import "./cerveza.css"
import react from "../react.svg";

export function Cerveza() {
    return (
      <div className="cerveza">
        <div className="cerveza-foto">
        <img src={react} alt="Bun Logo" className="logo bun-logo" />
          
        </div>
        <div className="cerveza-info">
          <div className="cerveza-nombre">
            Cerveza
          </div>
          <div className="cerveza-valores">
            <div className="cerveza-viejo">40</div>
            <div className="cerveza-actual">30</div>
          </div>
        </div>
      </div>
    );
  }
export default Cerveza;

createRoot(document.getElementById("root")!).render(Cerveza())