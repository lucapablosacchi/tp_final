import config from '../dbconfig.js';
import sql from 'mssql';

class PersonajeService{
    getAll = async () =>{
        try{
            const pool = await sql.connect(config);
            const result = await pool.request()
                .query("SELECT * FROM Personajes");
            return result.recordset;
        }catch(error){
            console.log(error);
            
        }
    }

    getById = async (id) => {
        try{
            let pool = await sql.connect(config);
            let result = await pool.request()
                .input("id",sql.Int, id)
                .query('SELECT * FROM Personajes WHERE id=@id');
            return result.recordset;
        } catch(error){
            console.log(error);
        }
    }

    insert = async (personaje) => {
        try{
            let pool = await sql.connect(config);
            let result = await pool.request()
            .input("pNombre", sql.VarChar, personaje.nombre)
            .input("pLibreGluten", sql.Bit, personaje.libreGluten)
            .input("pImporte", sql.Decimal(10, 2), personaje.Importe)
            .input("pDescripcion", sql.VarChar, personaje.descripcion)
            .query("INSERT INTO Personajes (nombre,libreGluten,importe,descripcion) VALUES (@pNombre,@pLibreGluten,@pImporte,@pDescripcion)")
            return result.recordset;
        }catch(error){
            console.log(error);
        }
    }
}

export default PersonajeService;