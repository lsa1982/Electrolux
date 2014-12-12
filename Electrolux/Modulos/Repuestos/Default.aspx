<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Repuestos.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="trabajo">
<table >
	<tr>
		<td>
			<span style=" font-size: 24px;" style="float:right">Mis Requerimientos</span>
			<button id="btnNuevo" type="button" class="k-button" style="float:right">Nuevo Requerimiento </button>
		</td>
	</tr>
	<tr style="border-bottom-width: 1px; ">
		<td>
			Seleccione Estado de Solicitudes a Filtrar: <input id="cmbEstado" value="0" />
		</td>
	</tr>
	<tr>
		<td style="width: 100%;position: absolute">
			<div id="grid" ></div>
		</td>
	</tr>
</table>

 
 </div>
<script>
	$(document).ready(function () {

		$("#btnNuevo").kendoButton({ click: onClick, icon: 'plus' });

		function onClick(e) {
			window.location.href = 'Ingreso.aspx';
		}

		function onChange(e) {
			if (cmbEstado.value != 0) {
				dsRequerimiento.filter({ field: "estado", operator: "eq", value: cmbEstado.value });
			}
			else {
				dsRequerimiento.filter({});
			}

		}

		

		$("#cmbEstado").kendoDropDownList({
			dataTextField: "estado",
			dataValueField: "idEstado",
			dataSource: dsEstado,
			change: onChange
		});

		var dsRequerimiento = new kendo.data.DataSource({
			transport: {
				read: { url: strInterOpAs("Requerimiento", "lista", "Workflow"), dataType: "json" }
			},
			batch: true,
			resizable: true,
			error: errorGrid,
			schema: {
				errors: "msgState",
				data: "args",
				total: "totalFila"
			}
		});

		$("#grid").kendoGrid({
			dataSource: dsRequerimiento,
			pageable: { pageable: true, pageSizes: [5, 10, 25, 50] },
			height: 400,
			sortable: true,
			filterable: filtroGrid,
			selectable: "multiple",
			resizable: true,
			//autoBind: false,
			groupable: { messages: { empty: "Arrastre las columnas que desee para agrupar"} },
			columns: [
				{ command: { text: "Ver", click: onView }, title: " ", width: "60px" },
				{ field: "idRequerimiento", hidden: true },
				{ field: "subflujo", title: "Flujo", width: "150px"},
				{ field: "tienda", title: "Tienda", width: "150px" },
				{ field: "fechaInicio", title: "Fecha Inicio", width: "210px", template: '<span class="claseEstado claseEstado5">#: fechaInicio #</span>' },
				{ field: "fechaCompromiso", title: "Fecha Plazo", width: "210px", template: '<span class="claseEstado claseEstado#: estado #">#: fechaCompromiso #</span>' },
				{ field: "observacion", title: "", width: "200px" },
				{ field: "cantidad", title: "Cantidad", width: "80px" },
				{ field: "", title: "" }
			]
  		});

  		function onView(e) {
  			e.preventDefault();
  			var dataItem = this.dataItem($(e.currentTarget).closest("tr"));
  			window.location = 'Seguimiento.aspx?idRequerimiento=' + dataItem.idRequerimiento;
  		}
  	});
 </script>
 <style>
 	.claseEstado {
 		padding: 5px;
 		font-weight: bold;
 		color: White;
 		border-radius: 6px;
 		}
 	.claseEstado3 {
 		background-color: Red;
 		}
 	.claseEstado1 {
 		background-color: yellow;
 		color: #666;
 		}
 	.claseEstado2 {
 		background-color: green;
 		}
 	.claseEstado4 {
 		background-color: Orange;
 		}
 	
 	.claseEstado5 {
 		background-color: #00a2e8;
 		}
 	
 	#btnNuevo{
 		font-size: 10px;
 		background-color: #1ed02a;
			border-color: #1ed02a;
			color: white;
 		}
 	#btnNuevo:active{
 		 -webkit-box-shadow: none;
 		}

 </style>
</asp:Content>
