import { sql } from "bun";

type Rol = {
  nombre: String,
  descripcion: String,
}

type Privilegio = {
  nombre: String,
  desccripcion: String,
}

type ROL_PRIV = {
  fk_rol: Number,
  fk_privilegio: Number,
};


const RolManagementService = {
  postRolSQL: async function(rol: Rol) {
    return await sql`INSERT INTO Usuario ${sql(rol)} RETURNING *`
  },


  postPrivilegioSQL: async function(priv: Privilegio) {
    await sql`INSERT INTO PRIVILEGIO ${sql(priv)} RETURNING *`
  },
  
  postRolPrivSQL: async function(rol_priv: ROL_PRIV) {
    return await sql`INSERT INTO ROL_PRIV ${sql(rol_priv)} RETURNING *`
  },

  deleteRolPrivSQL: async function(rol_priv: ROL_PRIV) {
    return await sql`DELETE FROM ROL_PRIV WHERE fk_rol = ${rol_priv.fk_rol} AND fk_privilegio = ${rol_priv.fk_privilegio} RETURNING *`
  }
}

export default RolManagementService;