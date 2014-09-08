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
	<table style= "padding-bottom: 10px; font-size : 10px">
		<tr >
			<td colspan="2" >
				<span style=" font-size: 24px;">Productos</span>
			</td>
		</tr>
		<tr style="font-size: 10px; ">
			<td style="width: 120px">
				Categoria: 
			</td>
			<td>
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
				<button id="btnAgregar" type="button" class="k-button">Agregar</button>
				<button id="btnVolver" type="button" class="k-button">Volver</button>
				<button id="btnLimpiar" type="button" class="k-button">Limpiar</button>
				<button id="btnEnviar" type="button" class="k-button">Enviar</button>
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
		window.location.href = appDir + 'Modulos/Repuestos/Default.aspx';
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
		$("#btnEnviar").kendoButton({ click: onSend, icon: "plus" });
		function onSend(e) {
  			e.preventDefault();
			$("#winNewRequest").data("kendoWindow").center().open();
			$("#txtRepTienda").html("<strong>" + $("#cmbTienda").data("kendoDropDownList").text() + "</strong>");
			
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
						"repuesto": $("#cmbRepuesto").data("kendoDropDownList").text(),
						"producto": $("#txtProducto").data("kendoComboBox").text(),
						"cantidad" : txtCantidad.value })
				}else{
					dataItem.set("cantidad", parseInt(txtCantidad.value) + parseInt( dataItem.cantidad));
				}
			}
		}

		$("#btnLimpiar").kendoButton({ click: onClear, icon: "plus" });
		function onClear(e) {
			dsCarrito.data([]);
		}

		$("#btnBuscar").kendoButton({ click: onClick, icon: "arrow-s" });
		function onClick(e) {
			if (cmbTienda.value != ""){
				$("#findProducto").show(500);
				$("#cmbCliente").data("kendoComboBox").enable(false);
				$("#cmbTienda").data("kendoDropDownList").enable(false);
				$("#btnBuscar").data("kendoButton").enable(false);
			}
		}

		$("#btnVolver").kendoButton({ click: onClickVolver, icon: "arrow-u" });
		function onClickVolver(e) {
			$("#findProducto").hide(500);
			
			$("#cmbCliente").data("kendoComboBox").enable(true);
			$("#cmbTienda").data("kendoDropDownList").enable(true);
			$("#btnBuscar").data("kendoButton").enable(true);
		}
		
		// ####################################
		// ### Combos						###
		// ####################################

  		var cmbCliente = $("#cmbCliente").kendoComboBox({
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

  		$("#cmbTienda").kendoDropDownList({
  			dataTextField: "tienda",
  			dataValueField: "idTienda",
  			autoBind: false,
  			cascadeFrom: "cmbCliente",
  			placeholder: "Seleccione Tienda",
  			dataSource: {
         			serverFiltering: true,
         			type: "json",
         			transport: {
         				read: { url: strInterOpAs("clsTienda", "lista", "Core"), dataType: "json", type: "post" }
         			},
					sort: { field: "tienda", dir: "asc"},
         			schema: {
         				errors: "msgState",
         				data: "args",
         				total: "totalFila"
         			}
         		}
  		});

  		$("#cmbCategoria").kendoComboBox({
  			dataTextField: "categoria",
  			dataValueField: "idCategoria",
  			autoBind: false,
  			placeholder: "Seleccione Categoria",
  			dataSource: {
         			type: "json",
         			transport: {
         				read: { url: strInterOpAs("clsCategoria", "lista", "Core"), dataType: "json", type: "post" }
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

  		$("#txtProducto").kendoComboBox({
  			dataTextField: "nombre",
			dataValueField: "idProducto",
  			filter: "contains",
			minLength: 4,
			autoBind: false,
  			dataSource: {
  				type: "json",
  				serverFiltering: true,
  				transport: {
  					read: { url: strInterOpAs("clsProducto", "lista", "Core"), dataType: "json", type: "post" },
  					parameterMap: function (options, operation) {
  						if ((operation == "read")&&(options.filter != undefined)) {
  							var dataSend = {};
  							dataSend["value"] = options.filter.filters[0].value;
  							if (cmbMarca.value != "") {
  								dataSend["idMarca"] = cmbMarca.value;
  							}
  							if (cmbCategoria.value != "") {
  								dataSend["idCategoria"] = cmbCategoria.value;
  							}
  							return dataSend;
  						}
						
  					}
  				},
  				schema: {
  					errors: "msgState",
  					data: "args",
  					total: "totalFila"
  				}
  			}
  		});

		$("#cmbRepuesto").kendoDropDownList({
  			dataTextField: "repuesto",
			dataValueField: "idRepuesto",
  			autoBind: false,
			cascadeFrom: "txtProducto",
  			dataSource: dsRead("Repuesto", "listaProductoRepuesto", "Repuestos") 
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

</div>
</asp:Content>
