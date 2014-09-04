<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Repuestos.master" %>
<%@ Register src="../../controlSeguridad.ascx" tagname="controlSeguridad" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
	<form id="form1" runat="server">
<div class="areaTrabajo" id="trabajo">
<table style= "padding-bottom: 10px; width: 100%">
	<tr>
		<td colspan="2">
			<span style=" font-size: 24px;">Mis Requerimientos</span>
			<uc1:controlSeguridad ID="controlSeguridad1" runat="server" >
				<SectorSeguridad>
					asldfasldfhals
				</SectorSeguridad>
			</uc1:controlSeguridad>
			
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
  			window.location = 'Ingreso.aspx';
  		}

  		function onChange(e) {
  			if (cmbEstado.value != 0) {
  				dsRepuestos.filter({ field: "estado", operator: "eq", value: cmbEstado.value });
  			}
  			else {
  				dsRepuestos.filter({});
  			}
			
  		}

  		var dsEstado = [
			{ "idEstado": 0, "estado": "Todos" },
			{ "idEstado": 1, "estado": "Pendientes" },
			{ "idEstado": 2, "estado": "Finalizados" },
			{ "idEstado": 3, "estado": "Atrasados" }
		];

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
  			height: 450,
  			sortable: true,
  			filterable: filtroGrid,
  			selectable: "multiple",
  			resizable: true,
  			//autoBind: false,
  			groupable: { messages: { empty: "Arrastre las columnas que desee para agrupar"} },
  			scrollable: true,
  			columns: [
				 
				{ command: { text: "Ver", click: onView }, title: " ", width: "60px" },
				{ field: "idRequerimiento", title: "id", width: "40px" },
				{ field: "estado", title: "E", template: '<span class="claseEstado claseEstado#: estado #">#: estado #</span>', width: "40px" },
				{ field: "nombre", title: "Producto", width: "250px" },
				{ field: "repuesto", title: "Repuesto", width: "200px" },
				{ field: "tienda", title: "Tienda", width: "150px" },
				{ field: "cantidad", title: "Cantidad", width: "80px" },
				{ field: "fechaInicio", title: "Inicio", width: "80px" },
				{ field: "fechaCompromiso", title: "Compromiso", width: "80px" },
				{ field: "actividad", title: "Actividad", width: "120px" },
				{ field: "usuario", title: "emisor", width: "80px" },
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
 		}
 	.claseEstado2 {
 		background-color: green;
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
	</form>
</asp:Content>
