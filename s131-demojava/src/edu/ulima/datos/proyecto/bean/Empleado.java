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
public class Empleado {
    private String nombre;
    private String apellido;
    public Float salario;
    public Empleado(String nombre, String apellido, Float salario){
        this.nombre = nombre;
        this.apellido = apellido;
        this.salario = salario;
    }
    public String toString(){
        return nombre + " " + apellido + "($" + salario + ")";
    }
}
