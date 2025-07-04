import { sql } from "bun";
import { CORS_HEADERS } from "..";

type Cliente = {
  rif: String,
  direccion: String,
  numero_registro: Number,
  fk_lugar_1: Number
};

type Usuario = {
  rif: String,
  direccion: String,
  numero_registro: Number,
  fk_lugar_1: Number
};

class UsuarioService {

  async getClientIDfromUserID(userID: Number) {
    const res = await sql`SELECT c.eid FROM Cliente c, Usuario u WHERE u.eid = ${userID} AND u.fk_cliente = c.eid`;
    return res;
  }
};

export default new UsuarioService();