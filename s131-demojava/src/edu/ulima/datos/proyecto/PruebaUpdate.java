/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.ulima.datos.proyecto;

import edu.ulima.datos.util.JdbcUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author JC
 */
public class PruebaUpdate {   
    public static void actualizarPrecio(int codigoProducto, float precio) throws Exception{
        //Obtener el objeto conexion
        Connection conn = JdbcUtil.getConnection();
        //Definir la sentencia (como cadena)
        String sql = "UPDATE PRODUCTO1 SET PRECIO_UNITARIO = ? WHERE CODIGO = ?";
        //Crear objeto Statement (PreparedStatement -> con parametros)
        PreparedStatement pst = conn.prepareStatement(sql);
        //Asignar valores a los parametros (indices a partir de 1)
        //Asignar el primer parametro (numerico con decimales)
        pst.setFloat(1, precio);
        //Asignar el segundo parametro(entero)
        pst.setInt(2, codigoProducto);
        //Ejecutar la consulta
        pst.executeUpdate();
        //Liberar recursos
        pst.close();        
        conn.close();
    }
    
    public static void main(String[] args) throws Exception{
        int codigoProducto = 400;
        float precio = 21.55f;
        actualizarPrecio(codigoProducto, precio);
        System.out.println("Precio actualizado correctamente");
    }
}
