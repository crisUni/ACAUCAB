import { createRoot } from "react-dom/client";
import { useEffect, useState } from "react";
import Navbar from "../components/navbar";

export default function CrudUser() {
    const [data, setData] = useState<string>("");

    useEffect(() => {
        fetch('http://localhost:3000/api/get_users')
            .then(async res => console.log(await res.json()))
            .catch(err => console.error)
    }, []);

    return (
        <div> { data ?? "not ok" } </div>
    );
}