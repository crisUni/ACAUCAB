import { useState } from "react";
import ReporteClientesNuevosVsRecurrentes from "../Reportes/ReporteClientesNuevosVsRecurrentes";
import ReporteTasaDeRetencion from "../Reportes/ReporteTasaDeRetencion";
import SmartLink from "@/components/SmartLink";

function IndicadoresVenta() {
    return (
        <div>
            <SmartLink href="/dashboard">Regresar</SmartLink>
            <div>
                <ReporteClientesNuevosVsRecurrentes />
                <ReporteTasaDeRetencion />
            </div>
        </div>
    )
}

export default IndicadoresVenta;