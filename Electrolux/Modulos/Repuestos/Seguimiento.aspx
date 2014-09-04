<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Repuestos.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="trabajo">
	<span style=" font-size: 24px;">Seguimiento</span><br/>
	<span style=" font-size: 11px;">Detalle del requerimiento solicitado:</span>
	<table style= "padding-top: 15px; width: 100%">
		<tr>
			<td style=" width: 150px" >Producto</td>
			<td ><div id="lblProducto"></div>  </td>
		</tr>
		<tr>
			<td >Respuesto</td>
			<td ><div id="lblRepuesto"></div></td>
		</tr>
		<tr>
			<td >Tienda</td>
			<td ><div id="lblTienda"></div></td>
		</tr>
		<tr>
			<td >Fecha Ingreso</td>
			<td ><div id="lblIngreso"></div></td>
		</tr>
		<tr>
			<td >Fecha Compromiso</td>
			<td ><div id="lblCompromiso"></div></td>
		</tr>
		<tr>
			<td >Cantidad</td>
			<td ><div id="lblCantidad"></div></td>
		</tr>
		<tr>
			<td >Estado</td>
			<td ><div id="lblEstado"></div></td>
		</tr>
		<tr>
			<td>Actividad Actual</td>
			<td><div id="lblActividad"></div></td>
		</tr>
		<tr>
			<td>Finalizacion</td>
			<td>	<input id="cmbFinalizacion" style="width: 300px" /></td>
		</tr>
		<tr>
			<td></td>
			<td>	<button id="btnAvanzar" type="button" class="k-button">Avanzar </button></td>
		</tr>

	</table>
</div>
<div id="grid"></div>

</div>
<script>
	$(document).ready(function () {


		$("#btnAvanzar").kendoButton({ click: onClick, icon: "arrow-u" });

		function onRefresh(e) {
			dsRepuestos.read({ "idRequerimiento": vGet.idRequerimiento });
		}
		function onClick(e) {
			var pUrl = [];
			pUrl.push("idRequerimiento=" + vGet.idRequerimiento);
			pUrl.push("idFinalizacion=" + cmbFinalizacion.value);
			var x = pUrl.join("&");
			callScript(strInterOp("Requerimiento", "avanzarActividad"), '&' + x, onRefresh);
			
		}

		function cargaDatos(data) {
			$("#lblProducto").html("<strong>" + data[0].nombre + "</strong>");
			$("#lblRepuesto").html("<strong>" + data[0].codigo + ' - ' + data[0].repuesto + "</strong>");
			$("#lblTienda").html("<strong>" + data[0].tienda + "</strong>");
			$("#lblIngreso").html("<strong>" + data[0].fechaInicio + "</strong>");
			$("#lblCompromiso").html("<strong>" + data[0].fechaCompromiso + "</strong>");
			$("#lblCantidad").html("<strong>" + data[0].cantidad + "</strong>");
			$("#lblEstado").html("<strong>" + data[0].estado + "</strong>");
			$("#lblActividad").html("<strong>" + data[0].actividad + "</strong>");
			dsRequerimiento.read({ "idRequerimiento": vGet.idRequerimiento });
			var cmbFin = $("#cmbFinalizacion").data("kendoDropDownList");
			if (data[0].estado == 2) {
				$("#btnAvanzar").hide();
				cmbFin.enable(false);
			}
			else {

				cmbFin.dataSource.read({ "idRequerimiento": vGet.idRequerimiento });
			}

		}


		$("#cmbFinalizacion").kendoDropDownList({
			dataTextField: "finalizacion",
			dataValueField: "idFinalizacion",
			autoBind: false,
			dataSource: {
				type: "json",
				transport: {
					read: { url: strInterOp("Requerimiento", "listaFinalizacion"), type: "post" }
				},
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			}
		});


		var dsRepuestos = new kendo.data.DataSource({
			transport: {
				read: { url: strInterOp("Requerimiento", "lista"), dataType: "json", type: 'POST' }
			},
			change: function (e) {
				var data = this.data();
				cargaDatos(data);
			},
			batch: true,
			resizable: true,
			error: errorGrid,
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});
		var vGet = getVarsUrl();

		dsRepuestos.read({ "idRequerimiento": vGet.idRequerimiento });

		var dsRequerimiento = new kendo.data.DataSource({
			transport: {
				read: { url: strInterOp("Requerimiento", "listaEstado"), dataType: "json", type: 'POST' }
			},
			batch: true,
			resizable: true,
			error: errorGrid,
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});

		$("#grid").kendoGrid({
			dataSource: dsRequerimiento,
			pageable: { pageable: true, pageSizes: [5, 10, 25, 50] },
			height: 450,
			sortable: true,
			filterable: filtroGrid,
			resizable: true,
			autoBind: false,
			columns: [
				{ field: "idRequerimiento", title: "id", width: "40px" },
				{ field: "estado", title: "E", template: '<span class="claseEstado claseEstado#: estado #">#: estado #</span>', width: "40px" },
				{ field: "actividad", title: "actividad", width: "200px" },
				{ field: "fechaInicio", title: "Inicio", width: "200px" },
				{ field: "fechaFin", title: "Fin", width: "200px" },
				{ field: "rol", title: "rol", width: "200px" },
				{ field: "", title: "" }
			]
		});


	});
</script>

</div>
<style>
	.claseEstado {
 		padding: 5px;
 		font-weight: bold;
 		color: White;
 		border-radius: 6px;
 		}
 	.claseEstado0 {
 		background-color: Red;
 		}
 	.claseEstado1 {
 		background-color: yellow;
 		}
 	.claseEstado2 {
 		background-color: green;
 		}
 	
 	.areaTrabajo table td{
 		font-size: 11px;
 		border-bottom: 1px dashed #EEEEEE;
 		padding-bottom:5px;
 		
 		}
 	
</style>
</asp:Content>
