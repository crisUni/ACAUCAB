import { sql } from "bun";

type Rol = {
  eid?: Number,
  nombre: String,
  descripcion: String,
}

type Privilegio = {
  fk_privilegio?: Number,
  nombre: String,
  descripcion: String,
}

type ROL_PRIV = {
  fk_rol: Number,
  fk_privilegio: Number,
};

const RolManagementService = {
  // ROL
  postRolSQL: async (rol: Rol) =>
    await sql`
    INSERT INTO Rol ${sql(rol)}
    RETURNING *`,

  getRolSQL: async (): Promise<Array<any>> =>
    await sql`
    SELECT eid, nombre ||': '|| descripcion as "displayName"
    FROM Rol`,

  // ROL PRIVILEGIO

  postRolPrivSQL: async (rol_priv: ROL_PRIV) =>
    await sql`
    INSERT INTO ROL_PRIV ${sql(rol_priv)}
    RETURNING *`,

  deleteRolPrivSQL: async (rol_priv: ROL_PRIV) =>
    await sql`
    DELETE FROM ROL_PRIV
    WHERE fk_rol = ${rol_priv.fk_rol}
    AND fk_privilegio = ${rol_priv.fk_privilegio}
    RETURNING *`,

  // PRIVILEGIO

  getPrivilegioSQL: async () =>
    await sql`
    SELECT p.eid as "eid", p.nombre ||': '|| p.descripcion as "displayName"
    FROM Privilegio p`,

  postPrivilegioSQL: async (priv: Privilegio) =>
    await sql`
    INSERT INTO PRIVILEGIO ${sql(priv)}
    RETURNING *`,

  deletePrivilegioSQL: async (priv_eid: Number) =>
    await sql`
    DELETE FROM PRIVILEGIO
    WHERE eid = ${priv_eid}
    RETURNING *`,

  deleteRolSQL: async (rol_eid: Number) =>
    await sql`
    DELETE FROM ROL
    WHERE eid = ${rol_eid}
    RETURNING *`
}

export default RolManagementService;