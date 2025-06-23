
type InveTien = {
  fk_cerveza: Number,
  fk_presentacion: Number,
  cantidad: Number,
}

type CervPres = {
  fk_cerveza: String,
  fk_presentacion: String,
  precio: Number,
};

type Cerveza = {
  nombre: String,
  descripcion: String,
  historia: String,
  fk_tipo_cerveza: Number,
  fk_proveedor: Number,
  fk_lugar: Number,
}

type Item = {
  item: CervPres,
  cantidad: Number,
}

type Carrito = {
  items: Array<CervPres>,
  monto: Number,
};