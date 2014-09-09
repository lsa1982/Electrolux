<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Repuestos.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="trabajo">
	<span style=" font-size: 24px;">Detalle de Repuesto</span><br/>
	<span style=" font-size: 11px;">Detalle del requerimiento solicitado:</span>
	<table style= "padding-top: 15px; width: 100%">
		<tr>
			<td style=" width: 150px" >Codigo</td>
			<td ><div id="lblCodigo"></div>  </td>
		</tr>
		<tr>
			<td >Respuesto</td>
			<td ><div id="lblRepuesto"></div></td>
		</tr>
		<tr>
			<td >Imagen</td>
			<td ><div id="lblImagen"></div></td>
		</tr>
		<tr>
			<td >Cantidad</td>
			<td ><div id="lblCantidad"></div></td>
		</tr>
		<tr>
			<td></td>
			<td></td>
		</tr>

	</table>
	<span style=" font-size: 24px;">Productos Compatibles</span><br/>
	<span style=" font-size: 11px">Lista de producto que utilizan este repuesto:</span><br/><br/>
</div>
<div id="grid"></div>

</div>
<script>
	$(document).ready(function () {

		function onRefresh(e) {
			dsRequerimiento.read({ "idRequerimiento": vGet.idRequerimiento });
		}

		function cargaDatos(data) {
			$("#lblCodigo").html("<strong>" + data[0].codigo + "</strong>");
			$("#lblRepuesto").html("<strong>" + data[0].repuesto + "</strong>");
			$("#lblImagen").html("<strong>" + data[0].imagen + "</strong>");
			$("#lblCantidad").html("<strong>" + data[0].cantidad + "</strong>");
			dsProducto.read({ "idRepuesto": vGet.idRepuesto });
		}

		var dsRepuesto = new kendo.data.DataSource({
			transport: {
				read: { url: strInterOp("Repuesto", "lista"), dataType: "json", type: 'POST' }
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

		dsRepuesto.read({ "idRepuesto": vGet.idRepuesto });

		var dsProducto = new kendo.data.DataSource({
			transport: {
				read: { url: strInterOp("Repuesto", "listaRepuestoProducto"), dataType: "json", type: 'POST' }
			},
			batch: true,
			resizable: true,
			error: errorGrid,
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});

		$("#grid").kendoGrid({
			dataSource: dsProducto,
			pageable: { pageable: true, pageSizes: [5, 10, 25, 50] },
			height: 450,
			sortable: true,
			filterable: filtroGrid,
			resizable: true,
			autoBind: false,
			columns: [
				{ field: "idProducto", title: "id", width: "40px" },
				{ field: "codigo", title: "Codigo", width: "200px" },
				{ field: "nombre", title: "Producto", width: "200px" },
				{ field: "marca", title: "Marca", width: "200px" },
				{ field: "categoria", title: "Categoria", width: "200px" },
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
