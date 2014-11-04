<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Repuestos.master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="trabajo">
<table style= "padding-bottom: 10px; width: 100%">
	<tr>
		<td colspan="2">
			<span style=" font-size: 24px;">Inventario</span>
		</td>
		<td  style=" text-align:right; vertical-align: top;font-size: 10px;">
			
			<button id="btnNuevo" type="button" class="k-button">Nuevo Movimiento</button>
			
		</td>
	</tr>
	<tr style="font-size: 10px; border-bottom-width: 1px; ">
		<td>
			Seleccione Estado de Solicitudes a Filtrar: <input id="cmbEstado" value="0" />
		</td>
		<td>&nbsp
		</td>
		<td style=" text-align:right; vertical-align: top;font-size: 10px;">
			
		</td>
	</tr>
</table>
<div id="grid"></div>
</div>
<script>
	$(document).ready(function () {
		$("#btnNuevo").kendoButton({ click: onClick, icon: 'plus' });
		function onClick(e) {
			window.location.href = 'Inventario.aspx';
		}

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
			schema: {
				errors: "msgState",
				data: "args",
				total: "totalFila"
			}
		});

		// ########################################################
		// ### Grid												###
		// ########################################################

		$("#grid").kendoGrid({
			pageable: { pageable: true, pageSizes: [5, 10, 25, 50] },
			dataSource: dsRepuestos,
			sortable: true,
  			filterable: filtroGrid,
  			selectable: "multiple",
  			resizable: true,
  			//autoBind: false,

  			columns: [
				{ command: { text: "Productos", click: onView }, title: " ", width: "90px" },
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
