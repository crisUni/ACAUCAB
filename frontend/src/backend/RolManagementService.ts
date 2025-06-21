import { sql } from "bun";

type ROL_PRIV = {
  fk_rol: Number,
  fk_privilegio: Number,
};


const RolManagementService = {


  postRolPrivSQL: async function(rol_priv: ROL_PRIV) {
    return await sql`INSERT INTO ROL_PRIV ${sql(rol_priv)} RETURNING *`
  },

  deleteRolPrivSQL: async function(rol_priv: ROL_PRIV) {
    return await sql`DELETE FROM ROL_PRIV WHERE fk_rol = ${rol_priv.fk_rol} AND fk_privilegio = ${rol_priv.fk_privilegio} RETURNING *`
  }
}

export default RolManagementService;