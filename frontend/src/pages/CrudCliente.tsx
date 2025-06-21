import { useEffect, useState } from "react";
import GenerateForm from "@/components/FormGenerator";

const JuridicoForm = () => {
  const [fkLugar1, setFkLugar1] = useState([]);
  const [fkLugar2, setFkLugar2] = useState([]);

  useState(() => {
    fetch('http://127.0.0.1:3000/api/get_parroquias')
      .then(async res => {
        const arr = await res.json();
        setFkLugar1(arr);
        setFkLugar2(arr);
      })
      .catch(err => console.error)
  })

  const [formData, setFormData] = useState({
    rif: '',
    direccion: '',
    numero_registro: '',
    denominacion_social: '',
    razon_social: '',
    pagina_web: '',
    capital_disponible: '',
    fk_lugar_1: '',
    fk_lugar_2: ''
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

    fetch('http://127.0.0.1:3000/api/cliente_juridico', {
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
          RIF:
          <input
            type="text"
            name="rif"
            value={formData.rif}
            onChange={handleChange}
            required
          />
        </label>
      </div>
      <div>
        <label>
          Dirección:
          <input
            type="text"
            name="direccion"
            value={formData.direccion}
            onChange={handleChange}
            required
          />
        </label>
      </div>
      <div>
        <label>
          Número de Registro:
          <input
            type="number"
            name="numero_registro"
            value={formData.numero_registro}
            onChange={handleChange}
            required
          />
        </label>
      </div>
      <div>
        <label>
          Denominación Social:
          <input
            type="text"
            name="denominacion_social"
            value={formData.denominacion_social}
            onChange={handleChange}
            required
          />
        </label>
      </div>
      <div>
        <label>
          Razón Social:
          <input
            type="text"
            name="razon_social"
            value={formData.razon_social}
            onChange={handleChange}
            required
          />
        </label>
      </div>
      <div>
        <label>
          Página Web:
          <input
            type="text"
            name="pagina_web"
            value={formData.pagina_web}
            onChange={handleChange}
            required
          />
        </label>
      </div>
      <div>
        <label>
          Capital Disponible:
          <input
            type="number"
            name="capital_disponible"
            value={formData.capital_disponible}
            onChange={handleChange}
            step="0.01"
            required
          />
        </label>
      </div>
      <div>
        <label>
          Lugar 1:
          <select name="fk_lugar_1" value={formData.fk_lugar_1} onChange={handleChange} required>
            <option value="" disabled>Select an option</option>
            {fkLugar1.map((option: any) => (
              <option key={option.eid} value={option.eid}>
                {option.lugar}
              </option>
            ))}
          </select>
        </label>
      </div>
      <div>
        <label>
          Lugar 2:
          <select name="fk_lugar_2" value={formData.fk_lugar_2} onChange={handleChange} required>
            <option value="" disabled>Select an option</option>
            {fkLugar1.map((option: any) => (
              <option key={option.eid} value={option.eid}>
                {option.lugar}
              </option>
            ))}
          </select>
        </label>
      </div>
      <button type="submit">Submit</button>
    </form>
  );
};

const NaturalForm = () => {
  const [formData, setFormData] = useState({
    rif: '',
    direccion: '',
    numero_registro: '',
    cedula: '',
    nombre: '',
    apellido: '',
    fecha_nacimiento: '',
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

    fetch('http://127.0.0.1:3000/api/cliente_natural', {
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
          RIF:
          <input
            type="text"
            name="rif"
            value={formData.rif}
            onChange={handleChange}
            required
          />
        </label>
      </div>
      <div>
        <label>
          Direccion:
          <input
            type="text"
            name="direccion"
            value={formData.direccion}
            onChange={handleChange}
            required
          />
        </label>
      </div>
      <div>
        <label>
          Numero Registro:
          <input
            type="number"
            name="numero_registro"
            value={formData.numero_registro}
            onChange={handleChange}
            required
          />
        </label>
      </div>
      <div>
        <label>
          Cedula:
          <input
            type="number"
            name="cedula"
            value={formData.cedula}
            onChange={handleChange}
            required
          />
        </label>
      </div>
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
          Apellido:
          <input
            type="text"
            name="apellido"
            value={formData.apellido}
            onChange={handleChange}
            required
          />
        </label>
      </div>
      <div>
        <label>
          Fecha de Nacimiento:
          <input
            type="date"
            name="fecha_nacimiento"
            value={formData.fecha_nacimiento}
            onChange={handleChange}
            required
          />
        </label>
      </div>
      <button type="submit">Submit</button>
    </form>
  );
};

const NewCrudNatural = () => GenerateForm([
  { label: "RIF", keyName: "rif", inputType: "text", required: true },
  { label: "Direccion", keyName: "direccion", inputType: "text", required: true },
  { label: "Numero Registro", keyName: "numero_registro", inputType: "number", required: true },
  { label: "Cedula de Identidad", keyName: "ci", inputType: "number", required: true },
  { label: "Nombre", keyName: "nombre", inputType: "text", required: true },
  { label: "Apellido", keyName: "apellido", inputType: "text", required: true },
  { label: "Fecha de Nacimiento", keyName: "fecha_nacimiento", inputType: "date", required: true },
  { label: "Direccion 1", keyName: "fk_lugar_1", fetchFrom:'http://127.0.0.1:3000/api/form/parroquias', required: true },
  { label: "Direccion 2", keyName: "fk_lugar_2", fetchFrom:'http://127.0.0.1:3000/api/form/parroquias', required: true }
], {url: 'http://127.0.0.1:3000/api/cliente_natural'})

export default function CrudCliente() {
    const [naturalData, setNaturalData] = useState<Array<any>>([])
    const [juridicoData, setJuridicoData] = useState<Array<any>>([])

    useEffect(() => {
      fetch("http://127.0.0.1:3000/api/cliente_natural")
        .then(async res => setNaturalData(await res.json()))
        .catch(console.error)
    }, [])

    useEffect(() => {
      fetch("http://127.0.0.1:3000/api/cliente_juridico")
        .then(async res => setJuridicoData(await res.json()))
        .catch(console.error)
    }, [])

    return (
        <div>
            <a href="/">Back</a>
            <h1>"Crear Clientes"</h1>
            <h2>Crear Natural</h2>
            <NewCrudNatural/>
            <h2>Crear Juridico</h2>
            {
              GenerateForm([
                {
                  keyName: "fk_cliente,fk_pnatural",
                  label: "Cliente Natural",
                  required: true,
                  fetchFrom: 'http://127.0.0.1:3000/api/form/pnatural'
                }
              ], { url: 'http://127.0.0.1:3000/api/cliente_juridico'})
            }
            <h2> Clientes Naturales </h2>
            <ul>
              { naturalData.map(x => <li key={x.eid}> { JSON.stringify(x) } </li>) }
            </ul>
            <h2> Clientes Juridicos </h2>
            <ul>
              { juridicoData.map(x => <li key={x.eid}> { JSON.stringify(x) } </li>) }
            </ul>
        </div>
    )
}
