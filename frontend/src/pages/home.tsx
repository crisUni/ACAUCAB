import { createRoot } from "react-dom/client";

import Cerveza from "../components/cerveza";
import Navbar from "../components/navbar";

export function home() {
    return (
      <div className="home">
        <div>
          <Navbar/>
        </div>
        <div className="diario-car">
          <div>
            i am going insane!!!!
          </div>
          <Cerveza/>
        </div>
        <div className="evento-car">
          <div>
            i am going insane!!!!
          </div>
          <Cerveza/>
        </div>
        <div className="cerveza-car">
          <div>
            i am going insane!!!!
          </div>
          <Cerveza/>
        </div>

      </div>
    );
  }
export default home;

const elem = document.getElementById("root")!

if (import.meta.hot) {
  // With hot module reloading, `import.meta.hot.data` is persisted.
  const root = (import.meta.hot.data.root ??= createRoot(elem));
  root.render(home());
} else {
  // The hot module reloading API is not available in production.
  createRoot(elem).render(home());
}