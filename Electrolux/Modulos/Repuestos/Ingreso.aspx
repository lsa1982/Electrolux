<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Repuestos.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="findTienda">
	<table style= "padding-bottom: 10px">
		<tr>
			<td colspan="4">
				<span style=" font-size: 24px;">Paso 1 - Selecci&oacute;n de Tienda</span>
			</td>
		</tr>
		<tr>
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
		<tr>
			<td>
				Seleccione Región: 
			</td>
			<td colspan="3"><input id="cmbRegion" style="width: 300px" /></td>
		</tr>
		
	</table>
</div>
<div class="areaTrabajo" id="findProducto"> 
	<table style= "padding-bottom: 10px; font-size : 10px; width:100%">
		<tr >
			<td colspan="2" >
				<span style=" font-size: 24px;">Paso 2 - Selecci&oacute;n de Producto</span>
					<button id="btnVolverProducto" type="button" class="k-button" style="float:right">Volver</button>
			</td>
		</tr>
		<tr style="font-size: 10px; ">
			<td style="width: 120px">
				Categor&iacute;a: 
			</td>
			<td >
				<input id="cmbCategoria" style="width: 300px" />
			</td>
		</tr>
		<tr >
			<td>
				Marca: 
			</td>
			<td>
				<input id="cmbMarca" style="width: 300px" />
			</td>
		</tr>
		<tr>
			<td>
				Producto: 
			</td>
			<td>
				<input id="txtProducto" style="width: 300px" />
			</td>
		</tr>
		<tr>
			<td colspan="2">
			<table id="layerImagen" style="display: none">
					<tr>
						<td>Vistas del Producto</td>
					</tr>
					<tr>
						<td colspan="2" style="background-color: #DDD;  width: 100%" id="carruselProducto"></td>
					</tr>
					<tr>
						<td style="position: relative; width: 50%">
							<div id="fotoProducto" style="position: relative;"></div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>
<div class="areaTrabajo" id="findRepuesto">
	<table style= "padding-bottom: 10px; font-size : 10px; width:100%">
		<tr >
			<td colspan="2" >
				<span style=" font-size: 24px;">Paso 3 - Selecci&oacute;n de Repuesto</span>
					<button id="btnVolverRepuesto" type="button" class="k-button" style="float:right">Volver</button>
			</td>
		</tr>
		<tr>
			<td >
				<table id="layerRepuesto" style="display: none">
					<tr>
						<td colspan="2">Vista de Repuesto</td>
					</tr>
					<tr>
						<td colspan="2" style="background-color: #DDD;  width: 100%" id="carruselRepuesto"></td>
					</tr>
					<tr>
						<td style="position: relative; width: 50%; height: 400px; max-height: 400px"  >
							<div id="fotoRepuesto" style="position: relative;"></div>
						</td>
						<td style=" text-align: center; vertical-align: middle" >
							<div style= "display: none; border: 1px solid #ccc; border-radius: 5px; padding: 15px; margin: 0 auto" id="layerSend" >
								Repuesto seleccionado <div id="lblRepuesto"></div>
								<button id="btnEnviar" type="button" class="k-button-red">Solicitar</button>
								
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>

<div id="winNewConfirmacion">
	<table style="width:100% ; font-size: 12px;border:3px" id="layerConfirmacion">
		<tr>
			<td><span style=" font-size: 24px; ">Confirmación de Requerimiento</span></td>
		</tr>
		<tr>
			<td><span style=" font-size: 11px;">Se ingresará un requerimiento con los siguientes datos:</span></td>
		</tr>
		<tr>
			<td colspan="2" style="border-top-style: dashed ; border-top-color: #CCCCCC; border-top-width: 1px; padding-top: 10px"></td>
		</tr>
		<tr>
			<td><span style=" font-size: 11px;">Tienda: </span><div id="txtRepTienda" name="txtRepTienda">&nbsp;</div></td>
		</tr>
		<tr>
			<td>
				<span style=" font-size: 11px;">Detalle: </span>
				<div id="tablaCarrito" name="tablaCarrito">&nbsp;</div>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="border-top-style: dashed ; border-top-color: #CCCCCC; border-top-width: 1px; padding-top: 10px"></td>
		</tr>
		<tr>
			<td>Cantidad</td>
		</tr>
		<tr>
			<td><input id="txtCantidad" type="number" value="1" min="1" max="20" step="1" style="width: 200px"  /></td>
		</tr>
		<tr>
			<td>Comentario</td>
		</tr>
		<tr>
			<td><textarea id="txtComentario" name="txtComentario" class="k-textbox" value="(Defecto)" style="width:100%;" ></textarea></td>
		</tr>
		<tr>
			<td colspan="2" style="border-top-style: dashed ; border-top-color: #CCCCCC; border-top-width: 1px; padding-top: 10px"></td>
		</tr>
		<tr>
			<td>	<button id="btnSolicitar" type="button" class="k-button-red">Enviar</button>&nbsp;
				<button id="btnCancelar" type="button" class="k-button-red">Cancelar</button></td>
		</tr>
	</table>
	<table id="layerSiguiente" style=" text-align: center; display: none">
		<tr>
			<td><span style=" font-size: 24px; ">Confirmación de Requerimiento</span></td>
		</tr>
		<tr>
			<td><img src="../../Styles/images/ok.png" style=" margin: 0 auto" /></td>
		</tr>
		<tr>
			<td>Su requerimiento ha sido ingresado correctamente Que desea hacer ahora?</td>
		</tr>
		<tr>
			<td>
				<input id="txtTiendaCheck" type="radio" checked   name="checkNext" > Seguir en la Tienda</input> <br />
				<input id="txtProductoCheck"  type="radio"  name="checkNext"> Seguir en la Producto</input><br />
				<input id="txtSeguimientoCheck" type="radio"   name="checkNext"> Ir al Inicio</input>
			</td>
		</tr>
		<tr>
			<td><button id="btnNext" type="button" class="k-button-red">Ir</button></td>
		</tr>
	</table>
</div>
<script>
	$(document).ready(function () {

		//#region Paso 1 Busca Tienda
		// ####################################

		$("#btnBuscar").kendoButton({ icon: "arrow-s", click:
			function (e) {
				if (cmbTienda.value != "") {
					$("#findProducto").show(500);
					dehabilitarDiv("findTienda");
					$('#layerImagen').hide();
					$("#txtProducto").data("kendoComboBox").text("");
					$("#txtProducto").data("kendoComboBox").value("");
				}
			}
		});

		$("#cmbCliente").kendoComboBox({
			dataTextField: "cadena",
			dataValueField: "idCadena",
			placeholder: "Seleccione Cadena",
			dataSource: {
				type: "json",
				transport: {
					read: { url: strInterOpAs("clsCadena", "lista", "Core"), dataType: "json", type: "post" }
				},
				sort: { field: "cadena", dir: "asc" },
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			},
			cascade: function (e) {
				$("#cmbTienda").data("kendoComboBox").text("");
				$("#cmbTienda").data("kendoComboBox").value("");
			}
		});

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
					if (cmbRegion.value != "") {
						dataSend["region"] = cmbRegion.value;
					}
					if (options.filter != undefined) {
						dataSend["nombre"] = $("#cmbTienda").data("kendoComboBox")._prev;
					}
					return dataSend;
				}
			},
			sort: { field: "tienda", dir: "asc" },
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});

		$("#cmbTienda").kendoComboBox({
			dataTextField: "tienda",
			dataValueField: "idTienda",
			autoBind: false,
			placeholder: "Seleccione Tienda",
			filter: "contains",
			minLength: 4,
			autoBind: false,
			dataSource: dsTienda,
			open: function (e) {
				dsTienda.read();
			}
		});


		var dsRegion = new kendo.data.DataSource({
			type: "json",
			transport: {
				read: { url: strInterOpAs("clsTienda", "listaRegion", "Core"), dataType: "json", type: "post" },
				parameterMap: function (options, operation) {
					var dataSend = {};
					if (cmbCliente.value != "") {
						dataSend["idCadena"] = cmbCliente.value;
					}
					if (cmbRegion.value != "") {
						dataSend["region"] = cmbRegion.value;
					}
					return dataSend;
				}
			},
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});

		$("#cmbRegion").kendoComboBox({
			dataTextField: "region",
			dataValueField: "region",
			autoBind: false,
			placeholder: "Seleccione Región",
			autoBind: false,
			dataSource: dsRegion,
			open: function (e) {
				dsRegion.read();
			}
		});

		//#endregion

		//#region Operaciones Carrito
		// ####################################

		$("#btnVolverProducto").kendoButton({ icon: "arrow-u", click:
			function (e) {
				$("#findProducto").hide(250);
				habilitarDiv("findTienda");
			}
		});

		$("#btnVolverRepuesto").kendoButton({ icon: "arrow-u", click:
			function (e) {
				habilitarDiv("findProducto");
				$("#findRepuesto").hide(250);
			}
		});

		//#endregion

		//#region Paso 2 Busca Producto
		// ####################################

		function iniciarSeccion(vArreglo) {
			$("#layerSeccion").empty();
			$("#layerRepuesto").hide();
			$.each(vArreglo, function (i, item) {
				var vDiv = "<div id='x$1' class='seccionLayer' style='width: $4px;height: $5px;top: $2px; left: $3px;' data-id=$7 data-seccion=$8 ><span class='tag'> $6</span></div>";
				vDiv = vDiv.replace('$1', vArreglo[i].idSeccionImagen);
				vDiv = vDiv.replace('$2', vArreglo[i].x);
				vDiv = vDiv.replace('$3', vArreglo[i].y);
				vDiv = vDiv.replace('$4', vArreglo[i].w);
				vDiv = vDiv.replace('$5', vArreglo[i].h);
				vDiv = vDiv.replace('$6', vArreglo[i].seccion);
				vDiv = vDiv.replace('$7', vArreglo[i].idSeccionImagen);
				vDiv = vDiv.replace('$8', vArreglo[i].idSeccion);
				$("#layerSeccion").append(vDiv);
			});
			$("#fotoProducto .seccionLayer").click(function () {
				mostrarRepuestos(this.dataset.seccion);
			});
		}

		$("#cmbCategoria").kendoComboBox({
			dataTextField: "categoria",
			dataValueField: "idCategoria",
			autoBind: false,
			placeholder: "Seleccione Categoria",
			cascade: function (e) {
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
				sort: { field: "categoria", dir: "asc" },
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			}
		});
		$("#cmbMarca").kendoComboBox({
			dataTextField: "marca",
			dataValueField: "idMarca",
			autoBind: false,
			placeholder: "Seleccione Marca",
			change: function (e) {
				$("#txtProducto").data("kendoComboBox").text("");
			},
			dataSource: {
				type: "json",
				transport: {
					read: { url: strInterOpAs("clsMarca", "lista", "Core"), dataType: "json", type: "post" }
				},
				sort: { field: "marca", dir: "asc" },
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			}
		});

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
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});
		var dsProductoImagen = new kendo.data.DataSource({
			transport: { read: { url: strInterOpAs("clsProducto", "listaImagen", "Core"), dataType: "json", type: "post"} },
			schema: { errors: "msgState", data: "args", total: "totalFila" },
			change: function (e) {
				if (this._data.length > 0) {
					var data = this.data();
					var strDiv = "<div class='carrusel' name='carruselImagen' data-id='$1'>";
					strDiv = strDiv + "<img src='../../Styles/Productos/$2' style=' max-width: 128px; max-height: 128px' />";
					strDiv = strDiv + "<span class='carruselLabel'>$3</span></div>";
					$("#carruselProducto").empty();
					for (i = 0; i < this._data.length; i++) {
						var strDivData = strDiv;
						strDivData = strDivData.replace("$1", data[i].idImagen);
						strDivData = strDivData.replace("$2", data[i].imagen);
						strDivData = strDivData.replace("$3", data[i].descripcion);
						$("#carruselProducto").append(strDivData);
					}
					$('#carruselProducto').find('div').click(function (e) {
						$("#fotoProducto").empty();
						$("#fotoProducto").html("<img src='" + this.children[0].src + "' style='max-width: 500px; max-height: 500px' id='target'  /><div id='layerSeccion'></div> ");
						dsProductoSeccion.filter({ field: "idImagen", operator: "eq", value: this.dataset.id });
						var view = dsProductoSeccion.view();
						iniciarSeccion(view);
						$("body, html").animate({ scrollTop: $("#carruselProducto").offset().top }, 600);

					});
				}
				else {
					dehabilitarDiv("findProducto");
					$("#layerRepuesto").show();
					$("#layerSend").hide();
					$("#carruselRepuesto").empty();
					$("#fotoRepuesto").empty();
					$("#findRepuesto").show(500);
					$("body, html").animate({ scrollTop: $("#findRepuesto").offset().top }, 600);
					dsRepuesto.read({ idProducto: idProducto });
				}
			}
		});
		var dsProductoSeccion = new kendo.data.DataSource({
			transport: { read: { url: strInterOpAs("clsProducto", "listaImagenSeccion", "Core"), dataType: "json", type: "post"} },
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});

		function onChange() {
			if (txtProducto.value != "") {
				idProducto = txtProducto.value;
				$("#layerImagen").show(500);
				$("#carruselProducto").empty();
				$("#fotoProducto").empty();
				dsProductoImagen.read({ idProducto: txtProducto.value });
				dsProductoSeccion.read({ idProducto: txtProducto.value });
			}

		}

		$("#txtProducto").kendoComboBox({
			dataTextField: "nombre",
			dataValueField: "idProducto",
			filter: "contains",
			minLength: 4,
			autoBind: false,
			open: function (e) {
				dsProducto.read();
			},
			cascade: onChange,
			dataSource: dsProducto
		});

		//#endregion

		//#region Paso 3 Busca Repuestos
		// ####################################

		function mostrarRepuestos(vSeccion) {
			dehabilitarDiv("findProducto");
			$("#layerRepuesto").show();
			$("#layerSend").hide();
			$("#carruselRepuesto").empty();
			$("#fotoRepuesto").empty();
			$("#findRepuesto").show(500);
			$("body, html").animate({ scrollTop: $("#findRepuesto").offset().top }, 600);
			dsRepuesto.read({ idSeccion: vSeccion });
		}

		var dsRepuesto = new kendo.data.DataSource({
			transport: { read: { url: strInterOpAs("Repuesto", "listaProductoRepuesto", "Repuestos"), dataType: "json", type: "post"} },
			schema: { errors: "msgState", data: "args", total: "totalFila" },
			batch: true,
			change: function (e) {
				$("#carruselRepuesto").empty();
				if (this._data.length > 0) {
					var data = this.data();
					var strDiv = "<div class='carrusel' name='carruselImagen' data-id='$1' data-tipo='$4' data-codigo='$5' data-repuesto='$6'>";
					strDiv = strDiv + "<img src='../../Styles/Repuestos/$2' style=' width: 128px; height: 128px'  />";
					strDiv = strDiv + "<span class='carruselLabel'>$3</span></div>";

					for (i = 0; i < this._data.length; i++) {
						var strDivData = strDiv;
						strDivData = strDivData.replace("$1", data[i].idRepuesto);
						strDivData = strDivData.replace("$2", data[i].imagen);
						strDivData = strDivData.replace("$3", data[i].repuesto);
						strDivData = strDivData.replace("$4", data[i].tipo);
						strDivData = strDivData.replace("$5", data[i].codigo);
						strDivData = strDivData.replace("$6", data[i].repuesto);
						$("#carruselRepuesto").append(strDivData);
					}
					$('#carruselRepuesto').find('div').click(function (e) {
						$("#fotoRepuesto").empty();
						idRepuesto = this.dataset.id;

						$("#fotoRepuesto").html("<img src='" + this.children[0].src + "' style='max-width: 500px; max-height: 500px' id='target'  />");
						$("body, html").animate({ scrollTop: $("#findRepuesto").offset().top }, 600);
						$("#layerSend").show();
						$("#lblRepuesto").html(this.dataset.codigo + "<br/>" + this.dataset.repuesto + '<br/>' + this.dataset.tipo + '<br/>');
					});
				}
			}
		});

		$("#txtCantidad").kendoNumericTextBox({ format: "#" });
		$("#btnEnviar").kendoButton({ click: onSend, icon: "tick" });
		function onSend(e) {
			e.preventDefault();
			var h = window.scrollY + (window.innerHeight / 2) - 160;
			var w = window.scrollX + (window.innerWidth / 2) - 225;
			$('#winNewConfirmacion').closest(".k-window").css({ top: h, left: w });
			$("#winNewConfirmacion").data("kendoWindow").open();
			$("#layerConfirmacion").show();
			$("#layerSiguiente").hide();
			$("#txtRepTienda").html("<strong>" + $("#cmbTienda").data("kendoComboBox").text() + "</strong>");
			$("#tablaCarrito").html("<strong>" + $("#lblRepuesto").text() + "</strong>");
		}

		//#endregion

		//#region Ventana Ingreso
		// ####################################

		$("#winNewConfirmacion").kendoWindow({
			width: "450px",
			visible: false,
			modal: true
		});

		$("#btnSolicitar").kendoButton({ icon: "plus", click:
			function (e) {
				var detalle = "";
				detalle = idRepuesto + '|' + idProducto + '|' + txtCantidad.value + ';';
				var pUrl = [];

				pUrl.push("idTienda=" + cmbTienda.value);
				pUrl.push("comentario=" + txtComentario.value);
				pUrl.push("detalle=" + detalle);
				var x = pUrl.join("&");
				callScript(strInterOp("Requerimiento", "Insertar"), '&' + x,
					function (e) {
						idRequerimiento = e.idRequerimiento;
						$("#layerConfirmacion").hide();
						$("#layerSiguiente").show(500);
					}
				);

			}
		});

		$("#btnCancelar").kendoButton({ click:
			function () {
				$("#winNewConfirmacion").data("kendoWindow").close();
			}
		});

		$("#btnNext").kendoButton({ click:
			function () {
				$("#winNewConfirmacion").data("kendoWindow").close();
				if (txtTiendaCheck.checked) {
					habilitarDiv("findProducto");
					$("#findRepuesto").hide();
					$("body, html").animate({ scrollTop: $("#findProducto").offset().top }, 600);
				}
				if (txtSeguimientoCheck.checked) {
					habilitarDiv("findProducto");
					$("#findRepuesto").hide();
					habilitarDiv("findTienda");
					$("#findProducto").hide();
				}
			}
		});

		//#endregion

		$("#findProducto").hide();
		$("#findRepuesto").hide();
		$("#findEnviar").hide();
		var idRepuesto, idProducto, idRequerimiento;
		$("#txtProducto").data("kendoComboBox").value("");
		$("#cmbTienda").data("kendoComboBox").value("");
		$("#cmbMarca").data("kendoComboBox").value("");
		$("#cmbCategoria").data("kendoComboBox").value("");
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

.seccionLayer{ 
		border: 0px solid #CCC;
		position: absolute; 
		-webkit-border-radius: 5px;
		overflow: auto;
		z-index: 20;
		}
	.seccionLayer:hover{ 
		border: 1px solid #CCC;
		z-index: 20;
		}

	.tag{ 
		position: absolute;
		padding: 5px;
		text-align: right; 
		font-size: 11px;
		background-color: rgba(100,100,100,0.7);
		color: #fff;
		-webkit-border-radius: 5px;
	}

	.carrusel{
		float: left;margin: 3px; position: relative
		}
	.carruselLabel{
		background-color: rgba(0,0,0,0.7);bottom: 1px;position: absolute;width: 100%;padding: 3px 0px 3px 0px;text-align: center;color: #fff;
		left: 0px;
		z-index: 20;
	}
</style>

</asp:Content>
