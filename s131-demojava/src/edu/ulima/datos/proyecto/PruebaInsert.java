/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.ulima.datos.proyecto;

import edu.ulima.datos.proyecto.bean.Producto;
import edu.ulima.datos.util.JdbcUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;


/**
 *
 * @author JC
 */
public class PruebaInsert {
    //ORM
    public static void registrarProducto(Producto prod) throws Exception{
        Connection conn = JdbcUtil.getConnection();
        String sql = "INSERT INTO PRODUCTO1 VALUES(?, ?, ?)";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setInt(1, prod.getCodigo());
        pst.setString(2, prod.getNombre());
        pst.setFloat(3, prod.getPrecioUnitario());
        pst.executeUpdate();
        pst.close();
        conn.close();
    }     

    public static void main(String[] args) throws Exception{
        
        Producto p1 = new Producto(800, "Teclado Inalambrico u88", 60.75f);
        Producto p2 = new Producto(900, "Mouse Inalambrico X89", 34.75f);
        registrarProducto(p1);
        registrarProducto(p2);
        
        Producto p3 = new Producto(1200, "Laptop Kid XYZ V2", 999.11f);
        registrarProducto(p3);
        System.out.println("Productos registrados correctamente");
    }
}