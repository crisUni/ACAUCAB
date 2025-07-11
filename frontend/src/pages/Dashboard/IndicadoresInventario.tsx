import ReporteRotacionDeInventario from "../Reportes/ReporteRotacionDeInventario";
import ReporteTasaDeRupturaDeStock from "../Reportes/ReporteTasaDeRupturaDeStock";

function IndicadoresInventario() {
    return (
        <div>
            <ReporteRotacionDeInventario />
            <ReporteTasaDeRupturaDeStock />
        </div>
    )
}

export default IndicadoresInventario;