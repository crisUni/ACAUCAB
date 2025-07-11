import SmartLink from "@/components/SmartLink";
import ReporteTicketPromedio from "../Reportes/ReporteTicketPromedio";
import ReporteVentasPorEstiloDeCerveza from "../Reportes/ReporteVentasPorEstiloDeCerveza";
import ReporteVentasTotales from "../Reportes/ReporteVentasTotales";
import ReporteVolumenDeUnidadesVendidas from "../Reportes/ReporteVolumenDeUnidadesVendidas";
import { useState } from "react";
import ReporteCrecimientoDeVentas from "../Reportes/ReporteCrecimientoDeVentas";

function IndicadoresVenta() {   
    return (
        <div>
            <SmartLink href="/dashboard">Regresar</SmartLink>
            <div>
                <ReporteVentasTotales />
                <ReporteCrecimientoDeVentas />
                <ReporteTicketPromedio />
                <ReporteVolumenDeUnidadesVendidas />
                <ReporteVentasPorEstiloDeCerveza />
            </div>
        </div>
    )
}

export default IndicadoresVenta;