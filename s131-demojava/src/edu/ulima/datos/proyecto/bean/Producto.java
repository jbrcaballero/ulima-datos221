/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.ulima.datos.proyecto.bean;

/**
 *
 * @author JC
 */
public class Producto {
    private int codigo;
    private String nombre;
    private float precioUnitario;
    public Producto(int codigo, String nombre, float precio){
        this.codigo = codigo;
        this.nombre = nombre;
        this.precioUnitario = precio;
    }

    public int getCodigo() {
        return codigo;
    }

    public String getNombre() {
        return nombre;
    }

    public float getPrecioUnitario() {
        return precioUnitario;
    }
    
}
