/* ============================================================
   TechConsult - JavaScript global
   ============================================================ */

function showToast(message, type) {
    const old = document.querySelector(".toast");
    if (old) old.remove();

    const toast = document.createElement("div");
    toast.className = "toast";
    if (type === "error") toast.style.borderLeftColor = "var(--danger)";
    if (type === "success") toast.style.borderLeftColor = "var(--success)";
    toast.textContent = message;
    document.body.appendChild(toast);

    window.setTimeout(() => toast.remove(), 2600);
}

function normalizar(texto) {
    return (texto || "").toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "");
}

function aplicarBusqueda(input, selector) {
    const query = normalizar(input.value);
    document.querySelectorAll(selector).forEach((fila) => {
        const texto = normalizar(fila.textContent);
        fila.style.display = texto.includes(query) ? "" : "none";
    });
}

function inicializarBusquedas() {
    const employeeSearch = document.getElementById("employeeSearch");
    if (employeeSearch) {
        employeeSearch.addEventListener("input", () => {
            aplicarBusqueda(employeeSearch, "#employeesTable tbody tr");
        });
    }

    const taskSearch = document.getElementById("taskSearch");
    if (taskSearch) {
        taskSearch.addEventListener("input", () => {
            const query = normalizar(taskSearch.value);
            document.querySelectorAll("#tasksTable tbody tr").forEach((fila) => {
                const coincideTexto = normalizar(fila.textContent).includes(query);
                const proyecto = document.getElementById("taskProjectFilter")?.value || "";
                const coincideProyecto = !proyecto || fila.dataset.project === proyecto;
                fila.style.display = coincideTexto && coincideProyecto ? "" : "none";
            });
        });
    }

    const taskProjectFilter = document.getElementById("taskProjectFilter");
    if (taskProjectFilter) {
        taskProjectFilter.addEventListener("change", () => {
            const proyecto = taskProjectFilter.value;
            document.querySelectorAll("#tasksTable tbody tr").forEach((fila) => {
                fila.style.display = !proyecto || fila.dataset.project === proyecto ? "" : "none";
            });
        });
    }

    const projectSearch = document.getElementById("projectSearch");
    if (projectSearch) {
        projectSearch.addEventListener("input", () => {
            aplicarBusqueda(projectSearch, ".project-card");
        });
    }
}

function inicializarFiltroTareasAsignacion() {
    const proyectoSelect = document.getElementById("assignTaskProject");
    const tareaSelect = document.getElementById("idTarea");
    if (!proyectoSelect || !tareaSelect) return;

    const opciones = Array.from(tareaSelect.options);

    const actualizarTareas = () => {
        const proyecto = proyectoSelect.value;
        tareaSelect.innerHTML = "";

        const placeholder = document.createElement("option");
        placeholder.value = "";
        placeholder.textContent = proyecto
            ? "-- Seleccionar tarea del proyecto --"
            : "-- Seleccionar proyecto primero --";
        tareaSelect.appendChild(placeholder);

        opciones.forEach((opcion) => {
            if (opcion.value === "") return;
            if (!proyecto || opcion.dataset.project === proyecto) {
                tareaSelect.appendChild(opcion.cloneNode(true));
            }
        });
    };

    proyectoSelect.addEventListener("change", actualizarTareas);
    actualizarTareas();
}

function inicializarConfirmaciones() {
    document.querySelectorAll("[data-confirm]").forEach((elemento) => {
        elemento.addEventListener("click", (event) => {
            if (!window.confirm(elemento.dataset.confirm || "¿Confirma la acción?")) {
                event.preventDefault();
            }
        });
    });
}

function inicializarChat() {
    const form = document.getElementById("chatForm");
    if (!form) return;

    const input = document.getElementById("messageInput");
    const messages = document.getElementById("messages");
    const username = form.dataset.username || "Admin";
    const iniciales = form.dataset.avatar || "AD";

    form.addEventListener("submit", (event) => {
        event.preventDefault();
        const text = input.value.trim();
        if (!text) return;

        const now = new Date();
        const hora = String(now.getHours()).padStart(2, "0") + ":" + String(now.getMinutes()).padStart(2, "0");

        const message = document.createElement("div");
        message.className = "message own";

        const body = document.createElement("div");
        const strong = document.createElement("strong");
        strong.textContent = username + " ";
        const small = document.createElement("small");
        small.textContent = hora;
        strong.appendChild(small);

        const p = document.createElement("p");
        p.textContent = text;

        body.appendChild(strong);
        body.appendChild(p);

        const avatar = document.createElement("div");
        avatar.className = "avatar";
        avatar.textContent = iniciales;

        message.appendChild(body);
        message.appendChild(avatar);
        messages.appendChild(message);
        messages.scrollTop = messages.scrollHeight;

        input.value = "";
        input.focus();
    });
}

document.addEventListener("DOMContentLoaded", () => {
    inicializarBusquedas();
    inicializarFiltroTareasAsignacion();
    inicializarConfirmaciones();
    inicializarChat();
});
