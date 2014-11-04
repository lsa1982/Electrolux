<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Repuestos.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="trabajo">
	<table style= "padding-bottom: 10px">
		<tr>
			<td colspan="4">
				<span style=" font-size: 24px;">Ingresos</span>
			</td>
		</tr>
		<tr style="font-size: 10px; border-bottom-width: 1px; ">
			<td style="width: 120px">
				Seleccione Cliente: 
			</td>
			<td>
					<input id="cmbCliente" style="width: 300px" />
			</td>
			<td>
				Seleccione Tienda: 
			</td>
			<td>
				<input id="cmbTienda" style="width: 300px" />
			</td>
			<td><button id="btnBuscar" type="button" class="k-button">Continuar...</button></td>
		</tr>
	</table>
</div>
<div class="areaTrabajo" id="findProducto">
	<table style= "padding-bottom: 10px; font-size : 10px; width:100%">
		<tr >
			<td colspan="2" >
				<span style=" font-size: 24px;">Productos</span>
					<button id="btnVolver" type="button" class="k-button" style="float:right">Volver</button>
			</td>
		</tr>
		<tr style="font-size: 10px; ">
			<td style="width: 120px">
				Categoria: 
			</td>
			<td >
				<input id="cmbCategoria" style="width: 200px" />
			</td>
		</tr>
		<tr >
			<td>
				Marca: 
			</td>
			<td>
				<input id="cmbMarca" style="width: 200px" />
			</td>
		</tr>
		<tr>
			<td>
				Producto: 
			</td>
			<td>
				<input id="txtProducto" style="width: 200px" />
			</td>
		</tr>
		<tr >
			<td>
				Respuestos :
			</td>
			<td><input id="cmbRepuesto" style="width: 200px" /></td>
			
		</tr>
		<tr style="font-size: 10px; border-bottom-width: 1px; ">
			<td>Cantidad:</td>
			<td><input id="txtCantidad" type="number" value="1" min="1" max="20" step="1" style="width: 200px"  /></td>
		</tr>
		<tr style="font-size: 10px; border-bottom-width: 1px; ">
			<td></td>
			<td>
				<button id="btnAgregar" type="button" class="k-button-red">Agregar</button>
				<button id="btnLimpiar" type="button" class="k-button-red">Limpiar</button>
				<button id="btnEnviar" type="button" class="k-button-red">Enviar</button>
			</td>
		</tr>
	</table>
	
	<div id="grid"></div>


	
	<div id="winNewRequest">Espere Mientras se actualizan los datos</div>
</div>
  <script>
	
	var dsCarrito = new kendo.data.DataSource({
  			data : [],
			schema: {
				model: {
					id: "idRepuesto",
					fields: {
						idRepuesto: { editable: false, nullable: true},
						idProducto: {},
						producto: {},
						repuesto: {validation: { required: true }},
						cantidad: {type: "number",defaultValue: 42,validation: { required: true, min: 1 }}
					}
				}
			  }
		});
	function onEnd(e){
		window.location.href = 'frmPostSend.aspx?idOrigen=1&idRequerimiento=' + e.idRequerimiento;
	}

	function onRequest(e) {
  			var v =dsCarrito.data();
			var detalle = "";
			for (i = 0; i < v.length; i++) {
				r= v[i];
				detalle= detalle + v[i].idRepuesto + '|' + v[i].idProducto + '|' + v[i].cantidad +';'
			}

			var pUrl = [];
			
			pUrl.push("idTienda=" + cmbTienda.value);
			pUrl.push("comentario=" + txtComentario.value);
			pUrl.push("detalle=" + detalle);
			var x = pUrl.join("&");
			callScript(strInterOp("Requerimiento", "Insertar"), '&' + x, onEnd);
			$("#winNewRequest").data("kendoWindow").close();
	}

	$(document).ready(function () {

		  $("#txtCantidad").kendoNumericTextBox({format: "#"});
		// ####################################
		// ### Botones						###
		// ####################################
		$("#btnEnviar").kendoButton({ click: onSend, icon: "tick" });
		function onSend(e) {
			e.preventDefault();
			$("#winNewRequest").data("kendoWindow").center().open();
			$("#txtRepTienda").html("<strong>" + $("#cmbTienda").data("kendoComboBox").text() + "</strong>");
			
			var template = kendo.template("#: cantidad # #: producto # - #: repuesto # <br/>");
			var v =dsCarrito.data();
			var html = kendo.render(template, v);
			$("#tablaCarrito").html(html);
		}


		$("#btnAgregar").kendoButton({ click: onAdd, icon: "plus" });
		function onAdd(e) {
			if (cmbRepuesto.value != ""){
				var dataItem = dsCarrito.get(cmbRepuesto.value);
				if (typeof dataItem == "undefined"){
					dsCarrito.add({
						"idRepuesto" : cmbRepuesto.value , 
						"idProducto": txtProducto.value,
						"repuesto": $("#cmbRepuesto").data("kendoComboBox").text(),
						"producto": $("#txtProducto").data("kendoComboBox").text(),
						"cantidad" : txtCantidad.value });
					onLimpiar();
				}
				//else{
				//	dataItem.set("cantidad", parseInt(txtCantidad.value) + parseInt( dataItem.cantidad));
				//}
			}
		}

		$("#btnLimpiar").kendoButton({ click: onClear, icon: "refresh" });
		function onClear(e) {
			onLimpiar();
		}
		
		function onLimpiar() {
			$("#cmbRepuesto").data("kendoComboBox").text("");
			$("#txtProducto").data("kendoComboBox").text("");
			$("#cmbCategoria").data("kendoComboBox").text("");
			$("#cmbMarca").data("kendoComboBox").text("");
		}

		$("#btnBuscar").kendoButton({ click: onClick, icon: "arrow-s" });
		function onClick(e) {
			if (cmbTienda.value != ""){
				$("#findProducto").show(500);
				$("#cmbCliente").data("kendoComboBox").enable(false);
				$("#cmbTienda").data("kendoComboBox").enable(false);
				$("#btnBuscar").data("kendoButton").enable(false);
			}
		}

		$("#btnVolver").kendoButton({ click: onClickVolver, icon: "arrow-u" });
		function onClickVolver(e) {
			$("#findProducto").hide(500);
			$("#cmbCliente").data("kendoComboBox").enable(true);
			$("#cmbTienda").data("kendoComboBox").enable(true);
			$("#btnBuscar").data("kendoButton").enable(true);
		}
		
		// ####################################
		// ### Combos						###
		// ####################################

		$("#cmbCliente").kendoComboBox({
			dataTextField: "cadena",
			dataValueField: "idCadena",
			placeholder: "Seleccione Cadena",
			dataSource: {
				type: "json",
				transport: {
					read: { url: strInterOpAs("clsCadena", "lista", "Core"), dataType: "json", type: "post" }
				},
				sort: { field: "cadena", dir: "asc"},
				schema: {
					errors: "msgState",
					data: "args",
					total: "totalFila"
				}
			}
		});

		function onOpenTienda(e) {
			console.log("event: open");
			dsTienda.read();
		};

		var dsTienda = new kendo.data.DataSource({
				serverFiltering: true,
				type: "json",
				transport: {
					read: { url: strInterOpAs("clsTienda", "lista", "Core"), dataType: "json", type: "post" },
					parameterMap: function (options, operation) {
						var dataSend = {};
						if (cmbCliente.value != "") {
							dataSend["txtidCadena"] = cmbCliente.value;
						}
						if (options.filter != undefined) {
							dataSend["nombre"] = $("#cmbTienda").data("kendoComboBox")._prev;
						}
						return dataSend;
						
					}
				},
				sort: { field: "tienda", dir: "asc"},
				schema: {errors: "msgState",data: "args",total: "totalFila"}
			});

		$("#cmbTienda").kendoComboBox({
			dataTextField: "tienda",
			dataValueField: "idTienda",
			autoBind: false,
			placeholder: "Seleccione Tienda",
			filter: "contains",
			minLength: 4,
			autoBind: false,
			open: onOpenTienda,
			dataSource: dsTienda
		});

		$("#cmbCategoria").kendoComboBox({
			dataTextField: "categoria",
			dataValueField: "idCategoria",
			autoBind: false,
			placeholder: "Seleccione Categoria",
			change: function(e) {
				$("#txtProducto").data("kendoComboBox").text("");
			},

			dataSource: {
					type: "json",
					transport: {
						read: { url: strInterOpAs("clsCategoria", "lista", "Core"), dataType: "json", type: "POST" },
						parameterMap: function (options, operation) {
							var dataSend = {};
							dataSend["tipo"] = "Linea Blanca";
							dataSend["clase"] = "Producto";
							return dataSend;
						}
					},
					sort: { field: "categoria", dir: "asc"},
					schema: {
						errors: "msgState",
						data: "args",
						total: "totalFila"
					}
				} 
		});

		$("#cmbMarca").kendoComboBox({
			dataTextField: "marca",
			dataValueField: "idMarca",
			autoBind: false,
			placeholder: "Seleccione Marca",
			change: function(e) {
				$("#txtProducto").data("kendoComboBox").text("");
			},
			dataSource: {
				type: "json",
				transport: {
					read: { url: strInterOpAs("clsMarca", "lista", "Core"), dataType: "json", type: "post" }
				},
				sort: { field: "marca", dir: "asc"},
				schema: {
					errors: "msgState",
					data: "args",
					total: "totalFila"
				}
			}
		});

		
		// ####################################
		// ### Busca Producto				###
		// ####################################
		function onOpen(e) {
			console.log("event: open");
			dsProducto.read();
		};

		var dsProducto = new kendo.data.DataSource({
				serverFiltering: true,
				transport: {
					read: { url: strInterOpAs("clsProducto", "lista", "Core"), dataType: "json", type: "post" },
					parameterMap: function (options, operation) {
						var dataSend = {};
						if (cmbMarca.value != "") {
							dataSend["idMarca"] = cmbMarca.value;
						}
						if (cmbCategoria.value != "") {
							dataSend["idCategoria"] = cmbCategoria.value;
						}
						if (options.filter != undefined) {
							dataSend["value"] = $("#txtProducto").data("kendoComboBox")._prev;
						}
						return dataSend;
						
					}
				},
				schema: {
					errors: "msgState",
					data: "args",
					total: "totalFila"
				}
			});

		var dsRepuesto = new kendo.data.DataSource({
				transport: {read: { url: strInterOpAs("Repuesto", "listaProductoRepuesto", "Repuestos"), dataType: "json", type: "post" }},
				schema: {errors: "msgState",data: "args",total: "totalFila" }
			});

		$("#txtProducto").kendoComboBox({
			dataTextField: "nombre",
			dataValueField: "idProducto",
			filter: "contains",
			minLength: 4,
			autoBind: false,
			open: onOpen,
			dataSource: dsProducto
		});

		$("#cmbRepuesto").kendoComboBox({
			dataTextField: "repuesto",
			dataValueField: "idRepuesto",
			autoBind: false,
			cascadeFrom: "txtProducto",
			filter: "contains",
			dataSource: dsRepuesto
		});

		// ####################################
		// ### Grid de repuestos			###
		// ####################################

		$("#grid").kendoGrid({
			dataSource: dsCarrito,
			autoBind: false,
			editable: {  confirmation: false, destroy: true, update: false},
			columns: [
				{ command: ["destroy"], title: " ", width: "80px" },
				{ field: "idRepuesto", title: "id", width: "30px" },
				{ field: "idProducto", title: "id" , width: "1px"},
				{ field: "producto", title: "Producto", width: "300px"},
				{ field: "repuesto", title: "Repuesto", width: "300px"},
				{ field: "cantidad", title: "Cantidad" , width: "80px"},
				{ field: "", title: "" }
			]
		});

		// ####################################
		// ### Ventana Ingreso				###
		// ####################################


		$("#winNewRequest").kendoWindow({
			width: "450px",
			title: "Ingreso de requerimiento",
			actions: ["Close"],
			visible: false,
			modal: true,
			content: "frmNewRepuesto.html",
		});

		$("#findProducto").hide();
		

	});
</script>
<style>
.k-button-red{
		padding: 3px;
		font-size: 14px;
		background-color: #0B90A7 ;
		color: White;
		border: 0px;
		min-width: 100px
	}
</style>
</div>
</asp:Content>
