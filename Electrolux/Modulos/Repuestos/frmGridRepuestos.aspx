<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Repuestos.master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="trabajo">
<table style= "padding-bottom: 10px; width: 100%">
	<tr>
		<td colspan="2">
			<span style=" font-size: 24px;">Inventario</span>
		</td>
		<td  style=" text-align:right; vertical-align: top;font-size: 10px;">
			<button id="btnDetalleRepuesto" type="button" class="k-button">Detalle de Repuesto</button>
			<button id="btnNuevoRepuesto" type="button" class="k-button">Nuevo Repuesto</button>
			<button id="btnNuevoMovimiento" type="button" class="k-button">Nuevo Movimiento</button>
			
		</td>
	</tr>
	<tr style="font-size: 10px; border-bottom-width: 1px; ">
		
		<td>Listado de todos los repuestos ingresados al sistema:
		</td>
		<td style=" text-align:right; vertical-align: top;font-size: 10px;">
			
		</td>
	</tr>
</table>
<div id="gridProducto"></div>
</div>
<script>
	$(document).ready(function () {
		$("#btnNuevoMovimiento").kendoButton({ icon: 'plus', click:
			function (e) {
				window.location.href = 'Inventario.aspx';
			}
		});

		$("#btnNuevoRepuesto").kendoButton({ icon: 'plus', click:
			function (e) {
				window.location.href = 'frmNewProducto.aspx';
			}
		});

		$("#btnDetalleRepuesto").kendoButton({ icon: 'search', click:
			function (e) {
				window.location.href = 'RepuestoProducto.aspx';
			}
		});

		// ########################################################
		// ### Ds												###
		// ########################################################

		var dsRepuestos = new kendo.data.DataSource({
			transport: {
				read: { url: strInterOp("Repuesto", "lista"), dataType: "json" , type:"POST"}
			},
			batch: true,
			resizable: true,
			error: errorGrid,
			serverPaging: true,
			serverFiltering: true,
			pageSize: 30,
			schema: {errors: "msgState", data: "args", total: "totalFila"}
		});

		// ########################################################
		// ### Grid												###
		// ########################################################

		$("#gridProducto").kendoGrid({
			pageable: { pageable: true, pageSizes: [5, 10, 25, 50] },
			dataSource: dsRepuestos,
			sortable: true,
			filterable: filtroGrid,
			selectable: "multiple",
			resizable: true,
			columns: [
				{ command: { text: "Detalle", click: onView }, title: " ", width: "90px" },
				{ field: "idRepuesto", title: "id", width: "1px" },
				{ field: "codigo", title: "Repuesto", width: "150px" },
				{ field: "repuesto", title: "Repuesto", width: "300px" },
				{ field: "imagen", title: "Imagen", width: "100px" },
				{ field: "cantidad", title: "En Bodega", width: "100px" },
				{ field: "valor", title: "Valor", width: "100px" },
				{ field: "tipo", title: "Tipo", width: "100px" },
				{ field: "grupo", title: "Grupo", width: "100px" },
				{ field: "", title: "" }
			]
		});

		function onView(e) {
			e.preventDefault();
			var dataItem = this.dataItem($(e.currentTarget).closest("tr"));
			window.location = 'RepuestoProducto.aspx?idRepuesto=' + dataItem.idRepuesto;
		}
	});
	
</script>

</asp:Content>
