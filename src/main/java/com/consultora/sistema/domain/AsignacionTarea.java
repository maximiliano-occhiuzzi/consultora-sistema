package com.consultora.sistema.domain;

public class AsignacionTarea {

    private int id;
    private int idEmpleado;
    private int idTarea;
    private String nombreEmpleado;
    private String tituloTarea;
    private String estadoTarea;
    private int idProyecto;
    private String nombreProyecto;

    public AsignacionTarea() {
    }

    public AsignacionTarea(int id, int idEmpleado, int idTarea) {
        this.id = id;
        this.idEmpleado = idEmpleado;
        this.idTarea = idTarea;
    }

    public AsignacionTarea(int id, int idEmpleado, int idTarea, String nombreEmpleado,
                           String tituloTarea, String estadoTarea, int idProyecto, String nombreProyecto) {
        this.id = id;
        this.idEmpleado = idEmpleado;
        this.idTarea = idTarea;
        this.nombreEmpleado = nombreEmpleado;
        this.tituloTarea = tituloTarea;
        this.estadoTarea = estadoTarea;
        this.idProyecto = idProyecto;
        this.nombreProyecto = nombreProyecto;
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

    public String getNombreEmpleado() {
        return nombreEmpleado;
    }

    public void setNombreEmpleado(String nombreEmpleado) {
        this.nombreEmpleado = nombreEmpleado;
    }

    public String getTituloTarea() {
        return tituloTarea;
    }

    public void setTituloTarea(String tituloTarea) {
        this.tituloTarea = tituloTarea;
    }

    public String getEstadoTarea() {
        return estadoTarea;
    }

    public void setEstadoTarea(String estadoTarea) {
        this.estadoTarea = estadoTarea;
    }

    public int getIdProyecto() {
        return idProyecto;
    }

    public void setIdProyecto(int idProyecto) {
        this.idProyecto = idProyecto;
    }

    public String getNombreProyecto() {
        return nombreProyecto;
    }

    public void setNombreProyecto(String nombreProyecto) {
        this.nombreProyecto = nombreProyecto;
    }
}
