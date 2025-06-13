import { createRoot } from "react-dom/client";

export function home() {
    return (
      <div className="home">
        <div className="cervezas-car">
          <div>
            i am going insane!!!!
          </div>
        </div>

      </div>
    );
  }
export default home;

createRoot(document.getElementById("root")!).render(home())