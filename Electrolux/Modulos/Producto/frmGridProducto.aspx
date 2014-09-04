<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
	<style type="text/css">
		.style1 {
			width: 219px;
		}
	</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<button id="button" type="button">Agregar Requerimiento</button>
<div id="grid" style="height: 380px"></div>

<script>
	$(document).ready(function () {
		$("#button").kendoButton({
			icon: "plus",
			click: function (e) {
				location.href = 'frmNewMarca.aspx'
			}
		});
		var ds = new kendo.data.DataSource({
			transport: {
				read: { url: strInterOp("clsMarca", "lista"), dataType: "json" },
				destroy: { url: strInterOp("clsEventos", "eliminar"), dataType: "json" },
				update: { url: strInterOp("clsEventos", "editar"), dataType: "json" },
				parameterMap: function (options, operation) {
					if (operation !== "read" && options.models) {
						return { txtCodiEvento: options.models[0].CODI_EVENTO, "txtTipoEvento": options.models[0].TIPO_EVENTO, "txtCodiExtEvento": options.models[0].CODIGO_EXT_EVENTO, "txtDescEvento": options.models[0].DESCRIPCION_EVENTO, "txtCodiServicio": options.models[0].CODI_SERVICIO, "txtDireccion": options.models[0].DIRECCION, "txtTipoRed": options.models[0].TIPO_RED };
					}
				}
			},
			batch: true,
			resizable: true,
			error: errorGrid,
			schema: {
				errors: "msgState",
				data: "args",
				total: "totalFila",
				model: {
					id: "idMarca",
					fields: {
						idMarca: { editable: false, nullable: true },
						marca: {},
						ultimaModificacion: { validation: { required: true} },
						orden: { validation: { required: true} },
						imagen: {}
					}
				}
			}
		});

		$("#grid").kendoGrid({
			dataSource: ds,
			pageable: { pageable: true, pageSizes: [5, 10, 25, 50] },
			height: 450,
			sortable: true,
			filterable: filtroGrid,
			selectable: "multiple",
			resizable: true,
			columns: [
				cmdGrid,
				{ field: "idMarca", title: "Código", width: "90px" },
				{ field: "marca", title: "Tipo Evento", width: "100px" },
				{ field: "ultimaModificacion", title: "Código Extendido", width: "130px" },
				{ field: "orden", title: "Descripción Evento", width: "200px" },
				{ field: "imagen", title: "Dirección", width: "100px" },
				{ field: "", title: "" }
			],
			editable: {
				mode: "popup",
				confirmation: "Esta seguro de eliminar este registro?",
				window: { title: "Formulario" }
			}
		});

	});
</script>

</asp:Content>
