package com.consultora.sistema.domain;

/**
 * Resumen de un proyecto para el dashboard: datos del proyecto, cantidad de
 * integrantes y avance calculado a partir de sus tareas.
 */
public class ProyectoResumen {

    private Proyecto proyecto;
    private int integrantes;
    private int totalTareas;
    private int tareasCompletadas;
    private int progreso;

    public ProyectoResumen() {
    }

    public ProyectoResumen(Proyecto proyecto, int integrantes, int totalTareas, int tareasCompletadas) {
        this.proyecto = proyecto;
        this.integrantes = integrantes;
        this.totalTareas = totalTareas;
        this.tareasCompletadas = tareasCompletadas;
        this.progreso = totalTareas == 0 ? 0 : (tareasCompletadas * 100) / totalTareas;
    }

    public Proyecto getProyecto() {
        return proyecto;
    }

    public void setProyecto(Proyecto proyecto) {
        this.proyecto = proyecto;
    }

    public int getIntegrantes() {
        return integrantes;
    }

    public void setIntegrantes(int integrantes) {
        this.integrantes = integrantes;
    }

    public int getTotalTareas() {
        return totalTareas;
    }

    public void setTotalTareas(int totalTareas) {
        this.totalTareas = totalTareas;
    }

    public int getTareasCompletadas() {
        return tareasCompletadas;
    }

    public void setTareasCompletadas(int tareasCompletadas) {
        this.tareasCompletadas = tareasCompletadas;
    }

    public int getProgreso() {
        return progreso;
    }

    public void setProgreso(int progreso) {
        this.progreso = progreso;
    }
}
