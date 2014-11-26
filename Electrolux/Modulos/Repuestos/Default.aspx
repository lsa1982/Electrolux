<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Repuestos.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="trabajo">
<table style= "padding-bottom: 10px; width: 100%">
	<tr>
		<td colspan="2">
			<span style=" font-size: 24px;">Mis Requerimientos</span>
		</td>
		<td  style=" text-align:right; vertical-align: top;font-size: 10px;">
			
			<button id="btnNuevo" type="button" class="k-button">Nuevo Requerimiento </button>
			
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
 <div id="grid" ></div>
 </div>
  <script>
  	$(document).ready(function () {

  		$("#btnNuevo").kendoButton({ click: onClick, icon: 'plus' });

  		function onClick(e) {
  			window.location.href = 'Ingreso.aspx';
  		}

  		function onChange(e) {
  			if (cmbEstado.value != 0) {
  				dsRepuestos.filter({ field: "estado", operator: "eq", value: cmbEstado.value });
  			}
  			else {
  				dsRepuestos.filter({});
  			}

  		}

  		

  		$("#cmbEstado").kendoDropDownList({
  			dataTextField: "estado",
  			dataValueField: "idEstado",
  			dataSource: dsEstado,
  			change: onChange
  		});

  		var dsRepuestos = new kendo.data.DataSource({
  			transport: {
  				read: { url: strInterOp("Requerimiento", "lista"), dataType: "json" }
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
  			dataSource: dsRepuestos,
  			pageable: { pageable: true, pageSizes: [5, 10, 25, 50] },
  			height: 400,
  			sortable: true,
  			filterable: filtroGrid,
  			selectable: "multiple",
  			resizable: true,
  			//autoBind: false,
  			groupable: { messages: { empty: "Arrastre las columnas que desee para agrupar"} },
  			scrollable: true,
  			columns: [
				 
				{ command: { text: "Ver", click: onView }, title: " ", width: "60px" },
				{ field: "idRequerimiento", title: "Id", width: "40px" },
				{ field: "tienda", title: "Tienda", width: "150px" },
				{ field: "nombre", title: "Producto", width: "200px", template: '#: marca # - #: nombre #' },
				{ field: "repuesto", title: "Repuesto", width: "200px" },
				{ field: "cantidad", title: "Cantidad", width: "80px" },
				{ field: "fechaInicio", title: "Fecha Inicio", width: "110px", template: '<span class="claseEstado claseEstado5">#: fechaInicio #</span>' },
				{ field: "fechaCompromiso", title: "Fecha Plazo", width: "110px", template: '<span class="claseEstado claseEstado#: estado #">#: fechaCompromiso #</span>' },
				{ field: "actividad", title: "Actividad", width: "120px" },
				{ field: "usuario", title: "Emisor", width: "80px" },
				{ field: "cadena", title: "Cadena", width: "80px" },
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
