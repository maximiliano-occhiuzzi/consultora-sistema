package com.consultora.sistema.domain;

public class AsignacionTarea {

    private int id;
    private int idEmpleado;
    private int idTarea;

    public AsignacionTarea() {
    }

    public AsignacionTarea(int id, int idEmpleado, int idTarea) {
        this.id = id;
        this.idEmpleado = idEmpleado;
        this.idTarea = idTarea;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdEmpleado() {
        return idEmpleado;
    }

    public void setIdEmpleado(int idEmpleado) {
        this.idEmpleado = idEmpleado;
    }

    public int getIdTarea() {
        return idTarea;
    }

    public void setIdTarea(int idTarea) {
        this.idTarea = idTarea;
    }
}