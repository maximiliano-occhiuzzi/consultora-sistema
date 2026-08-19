// ALTA
$(document).ready(function() {

    $('#formPersona').on('submit', function(e) {

        e.preventDefault();

        const formData = new FormData(this);

        $.ajax({

            url: $(this).attr('action'),
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            dataType: 'json',

            success: function(data) {

                alert(data.mensaje);

                $('#formPersona')[0].reset();
            },

            error: function(xhr) {

                console.error("Error en la petición:", xhr);

                if (xhr.responseJSON && xhr.responseJSON.errores) {

                    alert(xhr.responseJSON.errores.join("\n"));

                } else {

                    alert("Error en el envío del formulario. Estado: " + xhr.status);
                }
            }
        });
    });
});

// LECTURA

$(document).ready(function() {

	function cargarPadron() {
		$("#alerta-estado").html('<span>⏳</span> Sincronizando...').show();
		$("#contenedor-tabla").addClass("d-none");

		$.ajax({
			url: ctx + "/Listar",
			type: "GET",
			dataType: "json",

			success: function(data) {
				$("#tabla-padron-body").empty();

				let total = data.length;
				let habilitados = 0;
				let inhabilitados = 0;

				if (total === 0) {
					$("#alerta-estado").html(
						'<span>📭</span> No hay ciudadanos registrados.'
					).show();
					$("#dash-total, #dash-habilitados, #dash-inhabilitados").text("0");
					return;
				}

				$.each(data, function(i, p) {
					let esHab = p.habilitadoVotar;
					let badgeClass = esHab ? "bhab on" : "bhab off";
					let texto = esHab ? "Habilitado" : "Inhabilitado";

					if (esHab) { habilitados++; } else { inhabilitados++; }

					let fila = `
					<tr id="fila-${p.nroDocumento}">
					    <td class="text-center" style="width: 60px; vertical-align: middle;">
					        <img src="../Imagen?id=${p.id}" 
					             alt="Foto DNI" 
					             class="img-miniatura-dni"
					             onerror="this.onerror=null; this.src='data:image/svg+xml;utf8,<svg xmlns=\'http://w3.org\' viewBox=\'0 0 24 24\' fill=\'%239ca3af\'><path d=\'M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5-4-8-4z\'/></svg>';">
					    </td>
					    <td class="td-dni" style="vertical-align: middle;">${p.nroDocumento}</td>
					    <td class="td-nombre" style="vertical-align: middle;">${p.apellido}</td>
					    <td style="vertical-align: middle;">${p.nombre}</td>
					    <td class="text-center" style="vertical-align: middle;">
					        <div style="display:flex; flex-direction:column; align-items:center; gap:4px;">
					            <label class="form-switch" style="margin:0;">
					                <input type="checkbox"
					                       class="form-check-input toggle-habilitar"
					                       data-dni="${p.nroDocumento}"
					                       data-id="${p.id}"
					                       ${esHab ? "checked" : ""}>
					            </label>
					            <span class="${badgeClass} badge-estado">
					                <span class="badge-dot"></span>
					                ${texto}
					            </span>
					        </div>
					    </td>
					    <td class="text-center acciones-td" style="vertical-align: middle;">
					        <button class="btn-accion btn-ver" style="background:#eef2f7; color:#1a2f5e; border:1.5px solid #cbd5e0; border-radius:8px; padding:0.35rem 0.75rem; font-size:0.82rem; font-weight:600; cursor:pointer; transition:all 0.2s;"
					                data-id="${p.id}"
					                data-dni="${p.nroDocumento}"
					                data-apellido="${p.apellido}"
					                data-nombre="${p.nombre}"
					                data-domicilio="${p.domicilio || ''}"
					                data-fecha="${p.fechaNacimiento || ''}"
					                data-sexo="${p.sexo || ''}"
					                data-habilitado="${p.habilitadoVotar}"
					                title="Ver detalle">
					            👁️ Ver
					        </button>
					        <button class="btn-accion btn-modificar"
					                data-dni="${p.nroDocumento}"
					                data-apellido="${p.apellido}"
					                data-nombre="${p.nombre}"
					                data-domicilio="${p.domicilio || ''}"
					                data-fecha="${p.fechaNacimiento || ''}"
					                data-sexo="${p.sexo || ''}"
					                data-habilitado="${p.habilitadoVotar}"
					                title="Modificar ciudadano">
					            ✏️ Modificar
					        </button>
					        <button class="btn-accion btn-eliminar"
					                data-dni="${p.nroDocumento}"
					                title="Eliminar ciudadano">
					            🗑️ Eliminar
					        </button>
					    </td>
					</tr>`;

					$("#tabla-padron-body").append(fila);
				});

				$("#dash-total").text(total);
				$("#dash-habilitados").text(habilitados);
				$("#dash-inhabilitados").text(inhabilitados);

				$("#alerta-estado").hide();
				$("#contenedor-tabla").removeClass("d-none");
			},

			error: function(xhr) {
				if (xhr.status === 401) {
					window.location.href = "login.jsp";
					return;
				}
				$("#alerta-estado").html(
					'<span>❌</span> Error al conectar con el servidor.'
				).show();
			}
		});
	}

	cargarPadron();
	window.recargarTablaCompleta = cargarPadron;

	$("#btn-refrescar").on("click", function(e) {
		e.preventDefault();
		cargarPadron();
	});

	$('#input-buscar-tabla').on('input', function() {
		var q = $(this).val().toLowerCase();
		$('#tabla-padron-body tr').each(function() {
			$(this).toggle($(this).text().toLowerCase().includes(q));
		});
	});

});

// ELIMINAR

$(document).ready(function() {

	function recalcularContadores() {
		let total = 0;
		let habilitados = 0;
		let inhabilitados = 0;

		$("#tabla-padron-body tr:visible").each(function() {
			total++;
			if ($(this).find(".bhab").hasClass("on")) {
				habilitados++;
			} else {
				inhabilitados++;
			}
		});

		$("#dash-total").text(total);
		$("#dash-habilitados").text(habilitados);
		$("#dash-inhabilitados").text(inhabilitados);

		if (total === 0) {
			window.recargarTablaCompleta();
		}
	}

	$("#tabla-padron-body").on("click", ".btn-eliminar", function() {
		const dni = $(this).data("dni");
		const fila = $(this).closest("tr");
		const boton = $(this);

		if (!confirm(`¿Eliminar al ciudadano con DNI ${dni}?\nEsta acción no se puede deshacer.`)) {
			return;
		}

		boton.prop("disabled", true).html("⏳");

		$.ajax({
			url: ctx + "/Eliminar",
			type: "POST",
			data: { nroDocumento: dni },

			success: function() {
				fila.fadeOut(400, function() {
					$(this).remove();
					recalcularContadores();
				});
			},

			error: function(xhr) {
				boton.prop("disabled", false).html("🗑️ Eliminar");
				if (xhr.status === 500) {
					alert("Error del servidor: no se pudo eliminar el registro.");
				} else if (xhr.status === 401) {
					window.location.href = "login.jsp";
				} else {
					alert("Error inesperado al comunicarse con el servidor.");
				}
			}
		});
	});
});

/* ─── VER DETALLE ─────────────────────────────────────────── */

$(document).ready(function() {

	$("#tabla-padron-body").on("click", ".btn-ver", function() {

		const id        = $(this).data("id");
		const dni       = $(this).data("dni");
		const apellido  = $(this).data("apellido");
		const nombre    = $(this).data("nombre");
		const domicilio = $(this).data("domicilio") || "—";
		const fecha     = $(this).data("fecha")     || "—";
		const sexo      = $(this).data("sexo")      || "—";
		const habilitado= $(this).data("habilitado");

		const estadoHtml = habilitado === true || habilitado === "true"
			? '<span style="color:#16a34a;font-weight:700;">✅ Habilitado para votar</span>'
			: '<span style="color:#dc2626;font-weight:700;">🚫 Inhabilitado</span>';

		const sexoTexto = sexo === "M" ? "Masculino" : sexo === "F" ? "Femenino" : "No binario";

		// Foto grande
		$("#detalle-foto").attr("src", ctx + "/Imagen?id=" + id)
		                  .on("error", function() {
		                      $(this).attr("src", "data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%239ca3af'><path d='M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5-4-8-4z'/></svg>");
		                  });

		$("#detalle-nombre").text(apellido + ", " + nombre);
		$("#detalle-dni").text("DNI: " + dni);
		$("#detalle-domicilio").text(domicilio);
		$("#detalle-fecha").text(fecha);
		$("#detalle-sexo").text(sexoTexto);
		$("#detalle-estado").html(estadoHtml);

		const modal = new bootstrap.Modal(document.getElementById("modalDetalle"));
		modal.show();
	});
});

/* ─── MODIFICAR ─────────────────────────────────────────── */

$(document).ready(function() {

    $("#tabla-padron-body").on("click", ".btn-modificar", function() {

        const dni       = $(this).data("dni");
        const apellido  = $(this).data("apellido");
        const nombre    = $(this).data("nombre");
        const domicilio = $(this).data("domicilio");
        const fecha     = $(this).data("fecha");
        const sexo      = $(this).data("sexo");

        $("#modal-mod-dni").val(dni);
        $("#modal-mod-apellido").val(apellido);
        $("#modal-mod-nombre").val(nombre);
        $("#modal-mod-domicilio").val(domicilio);
        $("#modal-mod-fecha").val(fecha);
        $("#modal-mod-sexo").val(sexo);

        const modal = new bootstrap.Modal(document.getElementById("modalModificar"));
        modal.show();
    });

    $("#btn-confirmar-modificar").on("click", function() {

        const boton = $(this);
        boton.prop("disabled", true).html("⏳ Guardando...");

        $.ajax({
            url:  ctx + "/Modificar",
            type: "POST",
            data: {
                nroDocumento:    $("#modal-mod-dni").val(),
                apellido:        $("#modal-mod-apellido").val(),
                nombre:          $("#modal-mod-nombre").val(),
                domicilio:       $("#modal-mod-domicilio").val(),
                fechaNacimiento: $("#modal-mod-fecha").val(),
                sexo:            $("#modal-mod-sexo").val()
            },
            success: function() {
                bootstrap.Modal.getInstance(document.getElementById("modalModificar")).hide();
                boton.prop("disabled", false).html("💾 Guardar cambios");
                window.recargarTablaCompleta();
            },
            error: function(xhr) {
                boton.prop("disabled", false).html("💾 Guardar cambios");
                alert("Error " + xhr.status + ": No se pudo guardar.");
            }
        });
    });

});

/* ─── HABILITAR / INHABILITAR ────────────────────────────── */

$(document).ready(function() {

    $("#tabla-padron-body").on("change", ".toggle-habilitar", function() {

        const id     = $(this).data("id");
        const estado = $(this).is(":checked");
        const fila   = $(this).closest("tr");
        const badge  = fila.find(".badge-estado");
        const toggle = $(this);

        toggle.prop("disabled", true);

        $.ajax({
            url:  ctx + "/Habilitar",
            type: "POST",
            data: {
                nroDocumento:    id,
                habilitadoVotar: estado
            },
			success: function(response) {
			    if (response.habilitado) {
			        badge.text("Habilitado").removeClass("bhab off").addClass("bhab on");
			    } else {
			        badge.text("Inhabilitado").removeClass("bhab on").addClass("bhab off");
			    }
			    // ← Actualizar el data-habilitado del botón Ver en la misma fila
			    fila.find(".btn-ver").data("habilitado", response.habilitado);
			    toggle.prop("disabled", false);
			},
            error: function(xhr) {
                toggle.prop("checked", !estado);
                toggle.prop("disabled", false);
                alert("Error " + xhr.status + ": No se pudo cambiar el estado.");
            }
        });
    });

});