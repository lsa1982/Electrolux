<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Tienda.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="layerTienda">
<table >
	<tr>
		<td colspan="3">
			<span style=" font-size: 24px;" style="float:right">Productos en Tienda</span>
		</td>
	</tr>
	<tr>
		<td style=" width:180px">Ingrese producto a buscar</td>
		<td style=" width:300px"><input id="txtBuscar" type="text" /><input id="txtBuscarId" type="hidden" /></td>
		<td><button id="btnBuscar" type="button" class="k-button">Buscar </button></td>
	</tr>
	<tr >
		<td>Marca:</td>
		<td>
			<input id="cmbMarca" style="width: 300px" />
		</td>
		<td></td>
	</tr>
	<tr >
		<td>Categoria:</td>
		<td>
			<input id="cmbCategoria" style="width: 300px" />
		</td>
		<td></td>
	</tr>
	<tr>
		<td style="width: 100%;position: absolute">
			<div id="gridProducto"></div>
		</td>
	</tr>
</table>
 
 </div>
<script>
	$(document).ready(function () {

		// #region Buscar Producto
		$("#txtBuscar").kendoAutoComplete({
			dataTextField: "nombre",
			filter: "contains",
			select: onSelectProducto,
			minLength: 3,
			error: errorGrid,
			dataSource: {
				serverFiltering: true,
				transport: { read: { url: strInterOpAs("clsProducto", "lista", "Core"), dataType: "json", type: "POST" },
					parameterMap: function (options, operation) {
						var dataSend = {};
						if (options.filter != undefined) {
							dataSend["value"] = $("#txtBuscar").data("kendoAutoComplete")._prev;
							dataSend["idTienda"] = idTienda;
						}
						return dataSend;
					}
				},
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			}
		});
		function onSelectProducto(e) {
			var dataItem = this.dataItem(e.item.index());
			txtBuscarId.value = dataItem.idProducto;
		}

		$("#btnBuscar").kendoButton({ click: onFind, icon: "search" });
		function onFind(e) {
			idProducto = txtBuscarId.value;
			dsProducto.read({ "idProducto": idProducto });
		}

		// #endregion

		
		// #region combos de Producto
		$("#cmbCategoria").kendoComboBox({
			dataTextField: "categoria",
			dataValueField: "idCategoria",
			autoBind: false,
			placeholder: "Seleccione Categoria",
			dataSource: {
				transport: {
					read: { url: strInterOpAs("clsCategoria", "lista", "Core"), dataType: "json", type: "POST" },
					parameterMap: function (options, operation) {
						var dataSend = {};
						dataSend["tipo"] = "Linea Blanca";
						dataSend["clase"] = "Producto";
						return dataSend;
					}
				},
				sort: { field: "categoria", dir: "asc" },
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			}
		});
		$("#cmbMarca").kendoComboBox({
			dataTextField: "marca",
			dataValueField: "idMarca",
			autoBind: false,
			placeholder: "Seleccione Marca",
			dataSource: {
				transport: {read: { url: strInterOpAs("clsMarca", "lista", "Core"), dataType: "json", type: "post" }},
				sort: { field: "marca", dir: "asc" },
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			}
		});
		// #endregion

		// #region dsProducto
		var dsProducto = new kendo.data.DataSource({
			serverFiltering: true,
			transport: {
				read: { url: strInterOpAs("clsTienda", "listaProducto", "Core"), dataType: "json", type: "post" },
				parameterMap: function (options, operation) {
					var dataSend = {};
					if (options.filter != undefined) {
						dataSend["idTienda"] = idTienda;
					}
					return dataSend;
				}
			},
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});
		// #endregion

		// #region Grid Productos
		$("#gridProducto").kendoGrid({
			dataSource: dsProducto,
			pageable: { pageable: true, pageSizes: [5, 10, 25, 50] },
			height: 400,
			sortable: true,
			filterable: filtroGrid,
			resizable: true,
			//autoBind: false,
			columns: [
				{ field: "", title: "", width: "200px", template: kendo.template($("#grid-template").html()) },
				{ field: "idProducto", hidden: true },
				{ field: "idTienda", hidden: true },
				{ field: "producto", title: "Producto", width: "200px", template: "<strong> #:marca# -#:nombre#</strong> <br/> #:categoria #" },
				{ field: "ultimaLectura ", title: "ultimaLectura", width: "200px" },
				{ field: "precio", title: "precio", width: "80px" },
				{ field: "facing", title: "facing", width: "80px" },
				{ field: "assorment", title: "assorment", width: "80px" },
				{ field: "", title: "estado", width: "80px", template: "# if (flagQuiebre==1) {#<a class='productoAlerta'>Quiebre</a>#}#" },
				{ field: "", title: "" }
			]
		});

		function onView(e) {
			e.preventDefault();
			var dataItem = this.dataItem($(e.currentTarget).closest("tr"));
			window.location = 'Seguimiento.aspx?idRequerimiento=' + dataItem.idRequerimiento;
		}
		// #endregion

	});
</script>
<script id="grid-template" type="text/x-kendo-template">
	<a class="productoInactivo" data-id=#:idProducto# href="../../Modulos/Repuestos/frmProducto.aspx?idProducto=#:idProducto#">Info</a>
	<a class="productoInactivo" data-id=#:idProducto# href="frmFlujoProducto.aspx?idProducto=#:idProducto#">Alarma</a>
	<a class="productoInactivo" data-id=#:idProducto#>Repuesto</a>
</script>
<style>
	.productoInactivo{
		border-radius: 5px;
		background-color: #0B90A7;
		color: #fff;
		padding: 5px;
		font-weight:bold;
		float: left;
		margin-right: 5px;
		text-decoration: none
	}
	.productoInactivo:hover{
		background-color: #bbb;
		cursor: pointer;
	}
	
	.productoActivo{
		border-radius: 5px;
		background-color: #e00;
		color: #fff;
		padding: 5px;
		font-weight:bold;
		float: left;
		margin-right: 5px;
	}
	
	.productoAlerta{
		border-radius: 5px;
		background-color: #f00;
		color: #fff;
		padding: 5px;
		font-weight:bold;
		float: left;
		margin-right: 5px;
		text-decoration: none
	}
	
 </style>
</asp:Content>
