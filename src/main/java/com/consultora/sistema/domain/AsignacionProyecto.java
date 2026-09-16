package com.consultora.sistema.domain;

public class AsignacionProyecto {

    private int id;
    private int idEmpleado;
    private int idProyecto;

    public AsignacionProyecto() {
    }

    public AsignacionProyecto(int id, int idEmpleado, int idProyecto) {
        this.id = id;
        this.idEmpleado = idEmpleado;
        this.idProyecto = idProyecto;
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

    public int getIdProyecto() {
        return idProyecto;
    }

    public void setIdProyecto(int idProyecto) {
        this.idProyecto = idProyecto;
    }
}