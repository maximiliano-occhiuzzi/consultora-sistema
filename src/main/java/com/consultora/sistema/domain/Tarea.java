package com.consultora.sistema.domain;

public class Tarea {

    private int id;
    private String titulo;
    private String descripcion;
    private String estado;
    private int idProyecto;
    private String nombreProyecto;

    public Tarea() {
    }

    public Tarea(int id, String titulo, String descripcion, String estado) {
        this(id, titulo, descripcion, estado, 0);
    }

    public Tarea(int id, String titulo, String descripcion, String estado, int idProyecto) {
        this.id = id;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.estado = estado;
        this.idProyecto = idProyecto;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
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

    public boolean isCompletada() {
        return "Completada".equalsIgnoreCase(estado) || "Finalizada".equalsIgnoreCase(estado);
    }

    public boolean isEnProgreso() {
        return "En Progreso".equalsIgnoreCase(estado) || "En curso".equalsIgnoreCase(estado);
    }
}
