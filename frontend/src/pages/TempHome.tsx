export default function TempHome() {
    return (
        <ul>
            <li key="clientes">
                <a href="/clientes">Clientes</a>
            </li>
            <li key="usuarios">
                <a href="/usuario">Usuarios</a>
            </li>
            <li key="roles">
                <a href="/roles">Roles</a>
            </li>
            <li key="privilegios">
                <a href="/privilegios">Privilegios</a>
            </li>
            <li key="Compra">
                <a href="/compra">Compra</a>
            </li>
            <li key="Venta">
                <a href="/venta">Venta</a>
            </li>
            <li key="inventario">
                <a href="/inventario">Inventario</a>
            </li>
            <li key="reporte_1">
                <a href="/api/reporte_1">Reporte: Productos en Promocion</a>
            </li>
            <li key="reporte_2">
                <a href="/api/reporte_2">Reporte: Ingresos por Evento</a>
            </li>
            <li key="reporte_3">
                <a href="/api/reporte_3">Reporte: Puntualidad por Cargo</a>
            </li>
            <li key="reporte_4">
                <a href="/api/reporte_4">Reporte: Ranking de Proveedores</a>
            </li>
            <li key="reporte_5">
                <a href="/api/reporte_5">Reporte: Valor de los Puntos canjeados</a>
            </li>
        </ul>
    )
}