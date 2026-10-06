package com.consultora.sistema.domain;

public class AsignacionProyecto {
    private int id;
    private int idEmpleado;
    private int idProyecto;
    private String nombreEmpleado;
    private String nombreProyecto;

    public AsignacionProyecto() {}

    public AsignacionProyecto(int id, int idEmpleado, int idProyecto) {
        this.id = id;
        this.idEmpleado = idEmpleado;
        this.idProyecto = idProyecto;
    }

    public AsignacionProyecto(int id, int idEmpleado, int idProyecto, String nombreEmpleado, String nombreProyecto) {
        this.id = id;
        this.idEmpleado = idEmpleado;
        this.idProyecto = idProyecto;
        this.nombreEmpleado = nombreEmpleado;
        this.nombreProyecto = nombreProyecto;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getIdEmpleado() { return idEmpleado; }
    public void setIdEmpleado(int idEmpleado) { this.idEmpleado = idEmpleado; }
    public int getIdProyecto() { return idProyecto; }
    public void setIdProyecto(int idProyecto) { this.idProyecto = idProyecto; }
    public String getNombreEmpleado() { return nombreEmpleado; }
    public void setNombreEmpleado(String nombreEmpleado) { this.nombreEmpleado = nombreEmpleado; }
    public String getNombreProyecto() { return nombreProyecto; }
    public void setNombreProyecto(String nombreProyecto) { this.nombreProyecto = nombreProyecto; }
}