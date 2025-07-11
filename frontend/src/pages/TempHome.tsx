import { AuthProvider, useAuth } from '@/components/AuthComp';
import SmartLink from '@/components/SmartLink';
import { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';

export default function TempHome() {
    const [nombre, setNombre] = useState('');
    const { logout } = useAuth();

    useEffect(() => {
        const nombreStorage = localStorage.getItem('nombre');
        setNombre(String(nombreStorage))
    }, [])

    return (
        <div>
            <h1> Hola, { nombre } </h1>
            <ul>
                <li key="clientes">
                    <SmartLink href="/clientes">Clientes</SmartLink>
                </li>
                <li key="usuarios">
                    <SmartLink href="/usuario">Usuarios</SmartLink>
                </li>
                <li key="roles">
                    <SmartLink href="/roles">Roles</SmartLink>
                </li>
                <li key="privilegios">
                    <SmartLink href="/privilegios">Privilegios</SmartLink>
                </li>
                <li key="Compra">
                    <SmartLink href="/compra">Compra</SmartLink>
                </li>
                <li key="Venta">
                    <SmartLink href="/venta">Venta</SmartLink>
                </li>
                <li key="inventario">
                    <SmartLink href="/inventario">Inventario</SmartLink>
                </li>
                <li key="events">
                    <SmartLink href="/events">Eventos</SmartLink>
                </li>
                <li key="dashboard">
                    <SmartLink href="/dashboard">Dashboard</SmartLink>
                </li>
                <li key="reporte_1">
                    <a href="/api/reporte_1" onClick={(e) => { e.preventDefault(); window.open("/api/reporte_1", '_self')} }>Reporte: Productos en Promocion</a>
                </li>
                <li key="reporte_2">
                    <a href="/api/reporte_2" onClick={(e) => { e.preventDefault(); window.open("/api/reporte_2", '_self')} }>Reporte: Ingresos por Evento</a>
                </li>
                <li key="reporte_3">
                    <a href="/api/reporte_3" onClick={(e) => { e.preventDefault(); window.open("/api/reporte_3", '_self')} }>Reporte: Puntualidad por Cargo</a>
                </li>
                <li key="reporte_4">
                    <a href="/api/reporte_4" onClick={(e) => { e.preventDefault(); window.open("/api/reporte_4", '_self')} }>Reporte: Ranking de Proveedores</a>
                </li>
                <li key="reporte_5">
                    <a href="/api/reporte_5" onClick={(e) => { e.preventDefault(); window.open("/api/reporte_5", '_self')} }>Reporte: Valor de los Puntos canjeados</a>
                </li>
                <li key="reporte_6">
                    <a href="/api/reporte_6" onClick={(e) => { e.preventDefault(); window.open("/api/reporte_6", '_self')} }>Reporte: Inventario actual</a>
                </li>
                <li key="reporte_7">
                    <a href="/api/reporte_7" onClick={(e) => { e.preventDefault(); window.open("/api/reporte_7", '_self')} }>Reporte: Productos con mejor rendimiento</a>
                </li>
                <li key="reporte_9">
                    <a href="/api/reporte_9" onClick={(e) => { e.preventDefault(); window.open("/api/reporte_9", '_self')} }>Reporte: Gradico Ventas </a>
                </li>
            </ul>
            <a onClick={e => { e.preventDefault(); logout() } } href="/login">Logout</a>
        </div>
    )
    
}