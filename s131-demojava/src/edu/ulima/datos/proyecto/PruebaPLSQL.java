/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.ulima.datos.proyecto;

import edu.ulima.datos.proyecto.bean.Producto;
import edu.ulima.datos.util.JdbcUtil;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Types;


/**
 *
 * @author JC
 */
public class PruebaPLSQL {        
    //Llama a la funcion que realiza el calculo de IGV
    public static float obtenerIgv(float monto) throws Exception{
        float respuesta;
        Connection conn = JdbcUtil.getConnection();
        String llamado = "{call ? := CALCULAR_IGV(?)}";
        CallableStatement cst = conn.prepareCall(llamado);
        cst.setFloat(2, monto);
        cst.registerOutParameter(1, Types.FLOAT);
        cst.execute();
        respuesta = cst.getFloat(1);
        cst.close();
        conn.close();
        return respuesta;
    }    
    
    //Llama al procedure de registro de producto
    public static void registrarProducto(Producto producto) throws Exception{                
        Connection conn = JdbcUtil.getConnection();
        String llamado = "{call REGISTRAR_PRODUCTO(?, ?)}";
        CallableStatement cst = conn.prepareCall(llamado);
        cst.setString(1, producto.getNombre());
        cst.setFloat(2, producto.getPrecioUnitario());
        cst.execute();
        cst.close();
        conn.close();
    }    
    /*
        Datos los datos de un producto se realiza lo siguiente:
        1) Se obtiene el IGV (llamada a funcion) para obtener el precio total.
        2) Se crea un nuevo objeto producto con el monto modificado.
        3) Se invoca al procedure de registro de producto
        Ambos programas se encuentra en este proyecto: /sql/programas.sql
    */
    
    public static void main(String[] args) throws Exception{
        String producto = "Cargador generico XJD88";
        float precio = 25.50f;
        precio += obtenerIgv(precio);
        System.out.println("Nuevo precio calculado (incluido IGV): " + precio);
        //Creamos un nuevo producto (el codigo no es necesario - lo determina el procedure)
        Producto p1 = new Producto(0, producto, precio);        
        registrarProducto(p1);
        System.out.println("Producto registrado correctamente");
    }
    /*
        Referencia adicional: https://www.javatpoint.com/CallableStatement-interface
    */
}