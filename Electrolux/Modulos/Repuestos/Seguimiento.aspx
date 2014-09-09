<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Repuestos.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="trabajo">
	<span style=" font-size: 24px;">Seguimiento</span><br/>
	<table>
		<tr>
			<td>Ingrese número de requerimiento a buscar</td>
			<td><input id="txtIdRequerimiento" type="text" /></td>
			<td><button id="btnBuscar" type="button" class="k-button">Buscar </button></td>
		</tr>
	</table>

	
	<table style= "padding-top: 15px; width: 100%" id="layerSeguimiento">
		<tr>
			<td colspan="2"><span style=" font-size: 11px;">Detalle del requerimiento solicitado:</span></td>
		</tr>
		<tr>
			<td style=" width: 150px" >Emisor</td>
			<td ><div id="lblEmisor"></div>  </td>
		</tr>
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

		<tr>
			<td colspan="2"><div id="grid"></div></td>
		</tr>
	</table>
</div>




<script>
	$(document).ready(function () {

		$("#btnBuscar").kendoButton({ click: onFind, icon: "arrow-u" });
		function onFind(e) {
			dsRepuestos.read({ "idRequerimiento": txtIdRequerimiento.value });
			$("#layerSeguimiento").show(500);
		}

		function onRefresh(e) {
			dsRepuestos.read({ "idRequerimiento": vGet.idRequerimiento });
		}

		$("#btnAvanzar").kendoButton({ click: onClick, icon: "arrow-u" });
		function onClick(e) {
			var pUrl = [];
			pUrl.push("idRequerimiento=" + vGet.idRequerimiento);
			pUrl.push("idFinalizacion=" + cmbFinalizacion.value);
			var x = pUrl.join("&");
			callScript(strInterOp("Requerimiento", "avanzarActividad"), '&' + x, onRefresh);
		}

		function cargaDatos(data, idRequerimiento) {
			var vEstado = $.map(dsEstado, function (val) {
				return val.idEstado == data[0].estado ? val : null;
			});
			$("#lblEmisor").html("<strong>" + data[0].usuario + "</strong>");
			$("#lblProducto").html("<strong>" + data[0].nombre + "</strong>");
			$("#lblRepuesto").html("<strong>" + data[0].codigo + ' - ' + data[0].repuesto + "</strong>");
			$("#lblTienda").html("<strong>" + data[0].tienda + "</strong>");
			$("#lblIngreso").html("<strong>" + data[0].fechaInicio + "</strong>");
			$("#lblCompromiso").html("<strong>" + data[0].fechaCompromiso + "</strong>");
			$("#lblCantidad").html("<strong>" + data[0].cantidad + "</strong>");
			$("#lblEstado").html("<strong>" + vEstado[0].estado + "</strong>");
			$("#lblActividad").html("<strong>" + data[0].actividad + "</strong>");
			dsRequerimiento.read({ "idRequerimiento": idRequerimiento });
			var cmbFin = $("#cmbFinalizacion").data("kendoDropDownList");
			if (data[0].estado == 2) {
				$("#btnAvanzar").hide();
				cmbFin.enable(false);
			}
			else {

				cmbFin.dataSource.read({ "idRequerimiento": idRequerimiento });
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
				cargaDatos(data, data[0].idRequerimiento);
			},
			batch: true,
			resizable: true,
			error: errorGrid,
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});


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
				{ field: "estado", title: "E", template: '<span class="claseEstado claseEstado#: estado #">&nbsp;</span>', width: "40px" },
				{ field: "actividad", title: "actividad", width: "200px" },
				{ field: "fechaInicio", title: "Inicio", width: "200px" },
				{ field: "fechaEsperada", title: "Compromiso", width: "200px" },
				{ field: "fechaFin", title: "Fin", width: "200px" },
				{ field: "rol", title: "rol", width: "200px" },
				{ field: "", title: "" }
			]
		});
		// ############################################
		// ### Ejecución inicial					###
		// ############################################
		$("#layerSeguimiento").hide();
		var vGet = getVarsUrl();

		if (typeof vGet.idRequerimiento != "undefined") {
			dsRepuestos.read({ "idRequerimiento": vGet.idRequerimiento });
			$("#layerSeguimiento").show(500);
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
 	.claseEstado0 {
 		background-color: Red;
 		}
 	.claseEstado1 {
 		background-color: yellow;
 		}
 	.claseEstado2 {
 		background-color: green;
 		}
 	.claseEstado3 {
 		background-color: Red;
 		}
 	.areaTrabajo table td{
 		font-size: 11px;
 		border-bottom: 1px dashed #EEEEEE;
 		padding-bottom:5px;
 		
 		}
 	
</style>
</asp:Content>
