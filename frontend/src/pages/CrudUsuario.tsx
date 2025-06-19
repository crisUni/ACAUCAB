import { useState } from "react";

const MyForm = () => {
  const [formData, setFormData] = useState({
    pass: '',
    nombre: ''
  });

  const handleChange = (e: any) => {
    const { name, value } = e.target;
    setFormData({
      ...formData,
      [name]: value,
    });
  };

  const handleSubmit = (e: any) => {
    e.preventDefault();
    const data = JSON.stringify({
        insert_data: formData
    });

    fetch('http://127.0.0.1:3000/api/usuario', {
        method: "POST",
        body: data
    })
    .then(async res => console.log(await res.json()))
    .catch(err => console.error)
  };

  return (
    <form onSubmit={handleSubmit}>
      <div>
        <label>
          Nombre:
          <input
            type="text"
            name="nombre"
            value={formData.nombre}
            onChange={handleChange}
            required
          />
        </label>
      </div>
      <div>
        <label>
          Contrasena:
          <input
            type="number"
            name="pass"
            value={formData.pass}
            onChange={handleChange}
            required
          />
        </label>
      </div>
      <button type="submit">Submit</button>
    </form>
  );
};

export default function CrudUsuario() {
    return (
        <div>
            <a href="/">Back</a>
            <h1>"Crear Usuario"</h1>
            <MyForm />
        </div>
    )
}