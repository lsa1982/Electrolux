<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Repuestos.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<script src="../../Kendo/jquery.Jcrop.js" type="text/javascript"></script>
<link href="../../Styles/jquery.Jcrop.min.css" rel="stylesheet" type="text/css" />
<div class="areaTrabajo" id="trabajo">
	<span style=" font-size: 24px;">Detalle de Producto</span><br/>
	<table>
		<tr>
			<td style=" width:220px">Ingrese codigo de prodcuto a buscar</td>
			<td style=" width:180px"><input id="txtBuscar" type="text" /><input id="txtBuscarId" type="hidden" /></td>
			<td><button id="btnBuscar" type="button" class="k-button">Buscar </button></td>
		</tr>
	</table>
	<table style= "padding-top: 15px;display: none" id="layerNotFound">
		<tr>
			<td colspan="2">
				<span style=" font-size: 11px;">No se encuentran requerimientos con identificador ingresado.</span>
			</td>
		</tr>
	</table>
	<table style= "padding-top: 15px;display: none" id="layerProducto">
		<tr>
			<td colspan="2" style="font-size: 16px; border: 0">
				<strong>Información General del Repuesto</strong>
				<div style="float: right;margin-right: 10px;font-size: 11px">
					<button id="btnMoveSeccion" type="button" class="k-button">Secciones</button>
					<button id="btnMoveRepuesto" type="button" class="k-button">Repuestos</button>
				</div> 
			</td>
		</tr>
		<tr>
			<td colspan="2">

						<table style= "width: 100%">
							<tr>
								<td colspan="2" style=" font-size: 14px;"><strong> </strong></td>
							</tr>
							<tr>
								<td style=" width: 120px" >Codigo<input type="hidden" id="ldlId" /></td>
								<td style="vertical-align:  middle"> 
									<div id="lblCodigo" style="float: left" ></div>  
								</td>
							</tr>
							<tr>
								<td>Producto</td>
								<td><div id="lblProducto"></div> </td>
							</tr>
							<tr>
								<td>Categoria</td>
								<td><div id="lblCategoria"></div></td>
							</tr>

							<tr>
								<td>Marca</td>
								<td><div id="lblMarca"></div></td>
							</tr>
							<tr>
								<td>codigoBarra</td>
								<td><div id="lblCodigoBarra"></div></td>
							</tr>
							<tr>
								<td>Descripción</td>
								<td><div id="lblDescripcion"></div></td>
							</tr>
							<tr>
								<td ></td>
								<td >
									<button id="btnImagen" type="button" class="k-button-red">Añadir Imagen</button>
									<button id="btnModificar" type="button" class="k-button-red">Modificar</button>
									<button id="btnEliminar" type="button" class="k-button-red">Eliminar</button>
								</td>
							</tr>
						</table>

			</td>
		</tr>
		<!-- Capa de Productos -->
		<tr>
			<td colspan="2">
				<div id="layerRepuestos" style=" font-size: 24px; float:left">
					Vista del Producto
				</div>
				<button id="btnVolver1" type="button" class="k-button" style="float:right">Volver </button>
			</td>
		</tr>

		<tr>
			<td style=" width: 200px; vertical-align: middle" > Vistas Disponibles del producto:</td>
			<td></td>
		</tr>
		<tr>
			<td colspan="2" style="background-color: #DDD;  width: 100%" id="carruselProducto">
				
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<button id="btnNewView" type="button" class="k-button-red">Nueva Vista</button></td>
			
		</tr>
		<tr>
			<td colspan="2">
				<div id="Div1" style=" font-size: 24px; float:left; margin-bottom: 5px">
					Vista de Secciones
				</div>
				<button id="Button1" type="button" class="k-button" style="float:right">Volver </button>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<table>
					<tr>
						<td>
							
							<button id="cropNew" class="k-button">Nueva Sección</button>
							<button id="cropRelease" class="k-button" style="display: none">Guardar</button>
							<button id="cropCancel" class="k-button" style="display: none">Cancelar</button>
							
						</td>
					</tr>
					<tr id="layerNuevaSeccion" style="display: none; vertical-align: middle">
						<td>
							Debe seleccionar una sección: &nbsp<input id="cmbSeccion" />
						</td>
					</tr>
					<tr>
						<td style="position: relative; width: 500px">
							<div id="foto" style="position: relative;"></div>
						</td>
						<td>
							<table>
								<tr>
									<td> <span style="font-size: 16px; font-weight:bold">Repuestos encontrados</span></td>
								</tr>
								<tr>
									<td><div id="frmRepuesto"> </div></td>
									
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<div id="Div2" style=" font-size: 24px; float:left; margin-bottom: 5px">
					Repuestos
				</div>
				<button id="btnVolverRepuesto" type="button" class="k-button" style="float:right">Volver </button>
			</td>
			
		</tr>
		<tr>
			<td colspan="2">
				listado de todos los repuestos de este producto
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<button id="btnNewRepuesto" class="k-button-red">Nueva Repuesto</button>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<div id="gridRepuesto"></div>
			</td>
		</tr>
	</table>
</div>
<div id="winImagen" style="font-size:11px; text-align:center">
	<table style=" width: 100%">
		<tr>
			<td><div id="imgImagenCentral"></div></td>
		</tr>
		<tr>
			<td><div id="imgImagenTitle"></div></td>
		</tr>
		<tr>
			<td><hr /></td>
		</tr>
		<tr>
			<td>
				<input id="imgImagenId" type="hidden" />
				<button id="btnImgEliminar" type="button" class="k-button" >Eliminar Imagen </button>
				<button id="btnImgMarca" type="button" class="k-button">Marcar como principal </button>
			</td>
		</tr>
	</table>
</div>
<div id="winCargaImagen" style="font-size: 11px">
	<table>
		<tr>
			<td>Seleccione la imagenes que desea subir: </td>
		</tr>
		<tr>
			<td><input id="imgNewImagen" type="file" name="imgNewImagen" validationMessage="Select movie" /></td>
		</tr>
		<tr>
			<td><div id="uploadMsg"></div></td>
		</tr>
	</table>
	<table id="layerInfoImagen" style="display:none">
		<tr>
			<td colspan="2" >Ingrese información adicional sobre la imagen:</td>
		</tr>
		<tr>
			<td>Información</td>
			<td>
				<input id="txtInformacion" type="text" class="k-textbox" /> 
				<input id="txtUpload" type="hidden"/>
			</td>
		</tr>
		<tr>
			<td>Imagen Principal</td>
			<td>
				<select id="txtImagenPrincipal">
					<option value="0">No</option>
					<option value="1">Si</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>
				<button id="btnImagenSend" type="button" class="k-button-red">Subir </button>
				<button id="btnImagenCancel" type="button" class="k-button-red">Cancelar </button>
			</td>
		</tr>
	</table>
</div>
<div id="winNewRepuesto" style="font-size:11px">
		<table >
		<tr >
			<td style="width: 120px">Código: </td>
			<td >
				<input id="txtCodigo" style="width: 300px" /> 
				<input id="lblId" type="hidden" />
			</td>
		</tr>
		<tr >
			<td>Repuesto: </td>
			<td><div id="lblRepuesto" ></div></td>
		</tr>
		<tr >
			<td>Grupo: </td>
			<td><div id="lblGrupo" ></div></td>
		</tr>
		<tr>
			<td>Sección: </td>
			<td><input id="cmbSeccionRepuesto" style="width: 300px"  /></td>
		</tr>
		<tr style="font-size: 10px; border-bottom-width: 1px; ">
			<td></td>
			<td>
				<button id="btnAgregarRepuesto" type="button" class="k-button-red">Agregar</button>
			</td>
		</tr>
	</table>
</div>
<div id="winCambioSeccion" style="font-size:11px">
		<table >
		<tr >
			<td style="width: 120px">Código: </td>
			<td >
				<div id="lblCodigoCS" ></div> 
				<input id="lblIdCS" type="hidden" />
			</td>
		</tr>
		<tr >
			<td>Repuesto: </td>
			<td><div id="lblRepuestoCS" ></div></td>
		</tr>
		<tr >
			<td>Grupo: </td>
			<td><div id="lblTipoCS" ></div></td>
		</tr>
		<tr>
			<td>Sección: </td>
			<td><input id="cmbSeccionCS" style="width: 300px"  /></td>
		</tr>
		<tr style="font-size: 10px; border-bottom-width: 1px; ">
			<td></td>
			<td>
				<button id="btnGuardarCS" type="button" class="k-button-red">Guardar</button>
			</td>
		</tr>
	</table>
</div>

<script>
	$(document).ready(function () {

		//#region Imagen Crop
		//################################################

		var jcrop_api;
		var vCoor = [0, 0, 0, 0, 0, 0];

		function initJcrop() {
			$('#target').Jcrop({
				onChange: function (c) {
					vCoor = [c.x, c.y, c.x2, c.y2, c.w, c.h];
				},
				allowSelect: false
			},
			function () {
				jcrop_api = this;
			});
			jcrop_api.divSelect = undefined;
			jcrop_api.seccion = undefined;
		};

		$('#cropRelease').click(function (e) {
			var pUrl = [];
			var x;
			pUrl.push("idProducto=" + idProducto);
			pUrl.push("idImagen=" + idImagen);
			pUrl.push("idSeccion=" + cmbSeccion.value);
			pUrl.push("x=" + vCoor[1]);
			pUrl.push("y=" + vCoor[0]);
			pUrl.push("w=" + vCoor[4]);
			pUrl.push("h=" + vCoor[5]);
			if (jcrop_api.divSelect !== undefined) {
				pUrl.push("idSeccionImagen=" + jcrop_api.divSelect.dataset.id);
				x = pUrl.join("&");
				callScript(strInterOpAs("clsProducto", "actualizaSeccionImagen", "Core"), '&' + x, finalizaRelease);
			} else {
				jcrop_api.seccion = $("#cmbSeccion").data("kendoDropDownList").text();
				x = pUrl.join("&");
				callScript(strInterOpAs("clsProducto", "insertarSeccionImagen", "Core"), '&' + x, finalizaRelease);
			}
		});

		function finalizaRelease(vResult) {
			var dataItem = dsSeccion.get(vResult.idSeccionImagen);
			if (dataItem !== undefined)
				dsSeccion.remove(dataItem);
			var newItem = {
				idSeccionImagen: vResult.idSeccionImagen,
				idProducto: idProducto,
				idImagen: idImagen,
				idSeccion: cmbSeccion.value,
				x: vCoor[1],
				y: vCoor[0],
				w: vCoor[4],
				h: vCoor[5],
				seccion: jcrop_api.seccion
			};
			dsSeccion.add(newItem);
			dsSeccion.filter({ field: "idImagen", operator: "eq", value: idImagen });
			var view = dsSeccion.view();
			iniciarSeccion(view);
			jcrop_api.destroy();
			$('#cropRelease').hide();
			$('#cropCancel').hide();
			$('#cropNew').show();
			$('#layerNuevaSeccion').hide();
		}

		$('#cropNew').click(function (e) {
			initJcrop();
			jcrop_api.setSelect([0, 0, 100, 100]);
			$('#cropRelease').show();
			$('#cropCancel').show();
			$('#cropNew').hide();
			$('#layerNuevaSeccion').show();
		});

		$('#cropCancel').click(function (e) {
			$('#cropRelease').hide();
			$('#cropCancel').hide();
			$('#cropNew').show();
			$('#layerNuevaSeccion').hide();
			jcrop_api.destroy();

		});

		$("#cmbSeccion").kendoDropDownList({
			dataTextField: "seccion",
			dataValueField: "idSeccion",
			autoBind: false,
			dataSource: {
				type: "json",
				transport: { read: { url: strInterOpAs("clsSeccion", "lista", "Core"), dataType: "json", type: "post"} },
				sort: { field: "seccion", dir: "asc" },
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			}
		});


		function iniciarSeccion(vArreglo) {
			$("#layerSeccion").empty();
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

				$("#foto .seccionLayer").dblclick(function () {
					initJcrop();
					jcrop_api.divSelect = this;
					jcrop_api.seccion = this.children[0].innerText;
					jcrop_api.setSelect([this.offsetLeft, this.offsetTop, this.offsetLeft + this.offsetWidth, this.offsetTop + this.offsetHeight]);
					$('#cropRelease').show();
					$('#cropCancel').show();
					$('#cropNew').hide();
				});

				$("#foto .seccionLayer").click(function () {
					mostrarRepuestos(this.dataset.seccion);
				});
			});
		}

		//#endregion

		//#region Windows modificar sección
		//################################################
		$("#winCambioSeccion").kendoWindow({
			width: "450px",
			title: "Modificar Sección",
			actions: ["Close"],
			visible: false,
			modal: true
		});

		$("#btnGuardarCS").kendoButton({ click: onGuardarCS });
		function onGuardarCS(e) {

			var pUrl = [];
			pUrl.push("idProductoRepuesto=" + lblIdCS.value);
			pUrl.push("idSeccion=" + cmbSeccionCS.value);

			var x = pUrl.join("&");
			callScript(strInterOp("Repuesto", "modificarSeccion"), '&' + x,
				function (e) {
					$("#winCambioSeccion").data("kendoWindow").close();
					dsRepuestoGrid.read({ "idProducto": idProducto });
				}
			);
		}

		$("#cmbSeccionCS").kendoComboBox({
			dataTextField: "seccion",
			dataValueField: "idSeccion",
			autoBind: false,
			placeholder: "Seleccione Sección",
			dataSource: {
				type: "json",
				transport: {
					read: { url: strInterOpAs("clsSeccion", "lista", "Core"), dataType: "json", type: "POST" }
				},
				sort: { field: "seccion", dir: "asc" },
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			}
		});

		//#endregion

		//#region Windows Nuevo Repuesto
		//################################################
		$("#winNewRepuesto").kendoWindow({
			width: "450px",
			title: "Agregar Repuesto",
			actions: ["Close"],
			visible: false,
			modal: true
		});

		$("#btnAgregarRepuesto").kendoButton({ click: onAgregarRepuesto });
		function onAgregarRepuesto(e) {

			var pUrl = [];
			pUrl.push("idRepuesto=" + lblId.value);
			pUrl.push("idProducto=" + idProducto);
			pUrl.push("idSeccion=" + cmbSeccionRepuesto.value);

			var x = pUrl.join("&");
			callScript(strInterOp("Repuesto", "insertarProducto"), '&' + x,
				function (e) {
					$("#winNewRepuesto").data("kendoWindow").close();
					dsRepuestoGrid.read({ "idProducto": idProducto });
				}
			);
		}

		$("#cmbSeccionRepuesto").kendoComboBox({
			dataTextField: "seccion",
			dataValueField: "idSeccion",
			autoBind: false,
			placeholder: "Seleccione Sección",
			dataSource: {
				type: "json",
				transport: {
					read: { url: strInterOpAs("clsSeccion", "lista", "Core"), dataType: "json", type: "POST" }
				},
				sort: { field: "seccion", dir: "asc" },
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			}
		});

		$("#txtCodigo").kendoAutoComplete({
			dataTextField: "codigo",
			filter: "contains",
			select: onSelect,
			minLength: 3,
			error: errorGrid,
			dataSource: {
				serverFiltering: true,
				transport: { read: { url: strInterOp("Repuesto", "lista"), dataType: "json", type: "POST"} },
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			}
		});
		function onSelect(e) {
			var dataItem = this.dataItem(e.item.index());
			$("#lblRepuesto").html("<strong>" + dataItem.repuesto + "</strong>");
			$("#lblGrupo").html("<strong>" + dataItem.grupo + "</strong>");
			lblId.value = dataItem.idRepuesto;
		}

		//#endregion

		//#region Windows Cargar Imagen
		//################################################
		$("#winCargaImagen").kendoWindow({
			width: "450px",
			title: "Vista de Producto",
			actions: ["Close"],
			visible: false,
			modal: true
		});
		$("#txtImagenPrincipal").kendoDropDownList();

		$("#imgNewImagen").kendoUpload({
			localization: {
				select: "Seleccione Imagen a subir",
				uploadSelectedFiles: "Subir Archivos",
				remove: "Eliminar",
				retry: "Reintentar",
				headerStatusUploaded: "Hecho",
				headerStatusUploading: "Subiendo",
				statusFailed: "customStatusFailed"
			},
			async: {
				saveUrl: strInterOpAs("clsProducto", "subirImagen", "Core"),
				autoUpload: true
			},
			multiple: false,
			success: onSuccess,
			error: onError
		});

		function onError(e) {
			var rspUpload = JSON.parse(e.XMLHttpRequest.responseText);
			$("#uploadMsg").html("Se ha producido un problema en la carga: <strong>" + rspUpload.msgState + "</strong>");
		}

		function onSuccess(e) {
			var files = e.files;
			if (e.operation == "upload") {
				$("#imgNewImagen").data("kendoUpload").disable();
				$("#layerInfoImagen").show(0);
				$("#uploadMsg").html("");
				txtUpload.value = files[0].name;
			}
		}

		$("#btnImagenSend").kendoButton({ click: onImagenSend });
		function onImagenSend(e) {
			var pUrl = [];
			pUrl.push("idProducto=" + idProducto);
			pUrl.push("informacion=" + txtInformacion.value);
			pUrl.push("flagPrincipal=" + txtImagenPrincipal.value);
			pUrl.push("fileUpload=" + txtUpload.value);

			var x = pUrl.join("&");
			callScript(strInterOpAs("clsProducto", "guardarImagen", "Core"), '&' + x,
				function (e) {
					$("#winCargaImagen").data("kendoWindow").close();
					dsImagen.read({ "idProducto": idProducto });
					onImagenCancel(e);
				}
			);
		}

		$("#btnImagenCancel").kendoButton({ click: onImagenCancel });
		function onImagenCancel(e) {
			$("#layerInfoImagen").hide(200);
			$(".k-widget.k-upload").find("ul").remove();
			$("#imgNewImagen").data("kendoUpload").enable();
		}

		//#endregion

		//#region Windows Imagen
		//################################################

		$("#winImagen").kendoWindow({
			width: "450px",
			title: "Imagen de Repuesto",
			actions: ["Close"],
			visible: false,
			modal: true
		});

		$("#btnImgEliminar").kendoButton({ click: onImgEliminar });
		function onImgEliminar(e) {
			var pUrl = [];
			pUrl.push("idImagen=" + imgImagenId.value);
			var x = pUrl.join("&");
			callScript(strInterOp("Repuesto", "eliminarImagen"), '&' + x,
				function (e) {
					$("#winImagen").data("kendoWindow").close();
					$('#banner-fade').empty();
					dsImagen.read({ "idRepuesto": idRepuesto });
				}
			);
		}

		$("#btnImgMarca").kendoButton({ click: onImgMarca });
		function onImgMarca(e) {
			var pUrl = [];
			pUrl.push("idImagen=" + imgImagenId.value);
			pUrl.push("idRepuesto=" + idRepuesto);
			var x = pUrl.join("&");
			callScript(strInterOp("Repuesto", "marcaImagen"), '&' + x,
			function (e) {
				$("#winImagen").data("kendoWindow").close();
				$('#banner-fade').empty();
				dsImagen.read({ "idRepuesto": idRepuesto });
			}
			);
		}

		//#endregion

		//#region Botones Operacion
		//################################################

		$("#btnModificar").kendoButton({ click:
			function (e) {
				window.location.href = 'frmNewProducto.aspx?idProducto=' + idProducto;
			}
		});

		$("#btnEliminar").kendoButton({ click: onDelete });
		$("#btnNewView").kendoButton({ click: onImagen });
		$("#btnImagen").kendoButton({ click: onImagen });
		function onImagen(e) {
			centrarWin("#winCargaImagen");
			$("#winCargaImagen").data("kendoWindow").open();
		}

		function onDelete(e) {
			vex.defaultOptions.className = 'vex-theme-os';
			vex.dialog.confirm({ message: 'Esta seguro de eliminar este repuesto?',
				callback: function (e) {
					if (e) {
						var pUrl = [];
						pUrl.push("idRepuesto=" + idRepuesto);
						var x = pUrl.join("&");
						callScript(strInterOp("Repuesto", "eliminar"), '&' + x,
							function (ex) {
								window.location.href = 'frmGridRepuestos.aspx';
							}
						);
					}
				}
			});
		}


		$("#btnNewRepuesto").kendoButton({ click: function (e) {
			centrarWin("#winNewRepuesto");
			$("#winNewRepuesto").data("kendoWindow").open();
		}

		});
		//#endregion

		//#region Botones Movimiento
		//################################################

		$("#btnVolver1").kendoButton({ click: onVolver, icon: "arrow-n" });
		$("#btnVolver2").kendoButton({ click: onVolver, icon: "arrow-n" });
		function onVolver(e) {
			$("body, html").animate({ scrollTop: 0 }, 600);
		}

		$("#btnProducto").kendoButton({ click: onMoveProducto, icon: "arrow-s" });
		function onMoveProducto(e) {
			$("body, html").animate({ scrollTop: $("#layerProducto").offset().top }, 600);
		}

		$("#btnInventario").kendoButton({ click: onMoveInventario, icon: "arrow-s" });
		function onMoveInventario(e) {
			$("body, html").animate({ scrollTop: $("#layerInventario").offset().top }, 600);
		}

		//#endregion

		//#region DataSource Repuesto
		//################################################
		var dsRepuesto = new kendo.data.DataSource({
			transport: {
				read: { url: strInterOp("Repuesto", "listaProductoRepuesto"), dataType: "json", type: 'POST' }
			},
			batch: true,
			resizable: true,
			error: errorGrid,
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});

		$("#btnNewProducto").kendoButton({ click: onNewProducto });
		function onNewProducto(e) {
			$("#winNewProducto").data("kendoWindow").center();
			$("#winNewProducto").data("kendoWindow").open();
		}

		function mostrarRepuestos(idSeccion) {

			dsRepuesto.filter({ field: "idSeccion", operator: "eq", value: idSeccion });
			var view = dsRepuesto.view();
			var strDivProducto = "";
			var strDiv = "<span name='spanTitle' data-id='$8' style='font-weight: bold; color: #0B90A7 '>  $1 - $2";
			strDiv = strDiv + "<img name='imgDelete' data-id='$7' src='../../Styles/images/circle_delete.png' style='float:right; width:16px; height:16px' />";
			strDiv = strDiv + "</span><br><hr/>Tipo:<strong> $3</strong><br>Categoria:<strong> $4</strong><br>";
			strDiv = strDiv + "<img src='../../Styles/Repuestos/$5' style='max-width:180px; max-height:180px; ' />";
			for (i = 0; i < view.length; i++) {
				var strDivData = strDiv;
				strDivData = strDivData.replace("$1", view[i].codigo);
				strDivData = strDivData.replace("$2", view[i].repuesto);
				strDivData = strDivData.replace("$3", view[i].tipo);
				strDivData = strDivData.replace("$4", view[i].categoria);
				strDivData = strDivData.replace("$6", view[i].idRepuesto);
				strDivData = strDivData.replace("$7", view[i].idProductoRepuesto);
				strDivData = strDivData.replace("$8", view[i].idRepuesto);
				if (view[i].imagen != "")
					strDivData = strDivData.replace("$5", view[i].imagen);
				else
					strDivData = strDivData.replace("$5", "../../Styles/Productos/noImage.png");
				strDivProducto = strDivProducto + "<div class='divRepuesto'>" + strDivData + "</div>";
			}
			$("#frmRepuesto").html(strDivProducto);
		}
		//#endregion

		//#region DataSource Seccion
		//######################################
		var dsSeccion = new kendo.data.DataSource({
			transport: { read: { url: strInterOpAs("clsProducto", "listaImagenSeccion", "Core"), dataType: "json", type: 'POST'} },
			batch: true,
			resizable: true,
			error: errorGrid,
			schema: { errors: "msgState", data: "args", total: "totalFila", model: { id: "idSeccionImagen"} }
		});

		//#endregion

		//#region Datasource Imagenes
		//################################################
		var dsImagen = new kendo.data.DataSource({
			transport: { read: { url: strInterOpAs("clsProducto", "listaImagen", "Core"), dataType: "json", type: 'POST'} },
			batch: true,
			resizable: true,
			error: errorGrid,
			schema: { errors: "msgState", data: "args", total: "totalFila" },
			change: function (e) {
				$("#carruselProducto").empty();
				if (this._data.length > 0) {
					var data = this.data();
					var strDiv = "<div class='carrusel' name='carruselImagen' data-id='$1'>";
					strDiv = strDiv + "<img src='../../Styles/Productos/$2' style=' max-width: 128px; max-height: 128px' />";
					strDiv = strDiv + "<span class='carruselLabel'>$3</span></div>";

					for (i = 0; i < this._data.length; i++) {
						var strDivData = strDiv;
						strDivData = strDivData.replace("$1", data[i].idImagen);
						strDivData = strDivData.replace("$2", data[i].imagen);
						strDivData = strDivData.replace("$3", data[i].descripcion);
						$("#carruselProducto").append(strDivData);
					}
					$('#carruselProducto').find('div').click(function (e) {
						$("#foto").empty();
						$("#foto").html("<img src='" + this.children[0].src + "' style='max-width: 500px; max-height: 500px' id='target'  /><div id='layerSeccion'></div> ");
						dsSeccion.filter({ field: "idImagen", operator: "eq", value: this.dataset.id });
						var view = dsSeccion.view();
						iniciarSeccion(view);
						idImagen = this.dataset.id;
					});
				}
			}
		});
		//#endregion

		//#region Carga de Formulario y dsProducto
		//################################################
		function cargaDatos(data) {
			idRepuesto = data[0].idRepuesto;
			$("#lblId").html(data[0].id);
			$("#lblCodigo").html("<strong>" + data[0].codigo + "</strong>");
			$("#lblProducto").html("<strong>" + data[0].nombre + "</strong>");
			$("#lblCategoria").html("<strong>" + data[0].categoria + "</strong>");
			$("#lblMarca").html("<strong>" + data[0].marca + "</strong>");
			$("#lblCodigoBarra").html("<strong>" + data[0].codigoBarra + "</strong>");
			$("#lblDescripcion").html("<strong>" + data[0].descripcion + "</strong>");
			dsSeccion.read({ "idProducto": idProducto });
			dsImagen.read({ "idProducto": idProducto });
			dsRepuesto.read({ "idProducto": idProducto });
			dsRepuestoGrid.read({ "idProducto": idProducto });
		}

		var dsProducto = new kendo.data.DataSource({
			transport: { read: { url: strInterOpAs("clsProducto", "lista", "Core"), dataType: "json", type: 'POST'} },
			change: function (e) {
				var data = this.data();
				if (this._data.length > 0) {

					cargaDatos(data);
					$("#layerNotFound").hide(0);
					$("#layerProducto").show();
				}
				else {
					$("#layerProducto").hide(0);
					$("#layerNotFound").show();
				}
			},
			batch: true,
			resizable: true,
			error: errorGrid,
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});
		//#endregion

		//#region Boton Buscar
		//################################################
		
		//#endregion

		// #region Grid Repuestos
		// ########################################

		var dsRepuestoGrid = new kendo.data.DataSource({
			transport: {
				read: { url: strInterOp("Repuesto", "listaProductoRepuesto"), dataType: "json", type: 'POST' }
			},
			batch: true,
			resizable: true,
			error: errorGrid,
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});

		$("#gridRepuesto").kendoGrid({
			pageable: { pageable: true, pageSizes: [5, 10, 25, 50] },
			dataSource: dsRepuestoGrid,
			sortable: true,
			autoBind: false,
			filterable: filtroGrid,
			resizable: true,
			columns: [
				{ command: [{ text: "Sección", click: onCambiarSeccion }, { text: "Eliminar", click: onEliminarRepuesto}], title: " ", width: "180px" },
				{ field: "idProductoRepuesto", title: "", width: "1px" },
				{ field: "idRepuesto", title: "id", width: "1px" },
				{ field: "idSeccion", title: "", width: "1px" },
				{ field: "codigo", title: "Código", width: "150px" },
				{ field: "repuesto", title: "Repuesto", width: "300px" },
				{ field: "seccion", title: "Sección", width: "200px" },
				{ field: "tipo", title: "Tipo", width: "200px" },
				{ field: "", title: "" }
			]
		});

		function onCambiarSeccion(e) {
			e.preventDefault();
			var dataItem = this.dataItem($(e.currentTarget).closest("tr"));
			centrarWin("#winCambioSeccion");
			$("#winCambioSeccion").data("kendoWindow").open();
			$("#lblCodigoCS").html("<strong>" + dataItem.codigo + "</strong>");
			$("#lblRepuestoCS").html("<strong>" + dataItem.repuesto + "</strong>");
			$("#lblTipoCS").html("<strong>" + dataItem.tipo + "</strong>");
			lblIdCS.value = dataItem.idProductoRepuesto;
			$("#cmbSeccionCS").data("kendoComboBox").value(dataItem.idSeccion);

		}
		function onEliminarRepuesto(e) {
		}

		// #endregion

		//#region Proceso Inicial
		//################################################
		var idProducto = 0;
		var idImagen = 0;
		var vGet = getVarsUrl();
		if (typeof vGet.idProducto != "undefined") {
			idProducto = vGet.idProducto;
			dsProducto.read({ "idProducto": idProducto });
		}

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
		//#endregion

	});
</script>
<style type="text/css">
	.divRepuesto{
		 border: 1px solid #AAA; 
		 width: 260px; 
		 float: left;
		 margin-right:15px;
		 margin-bottom:15px;
		 -webkit-border-radius: 5px;
		 padding: 5px;
		 box-shadow: 0 0 4px #999;
		 min-height: 240px;
		 max-width: 250px;
		 
		 
		 cursor: pointer
		}
	.seccionLayer{ 
		border: 0px solid #CCC;
		position: absolute; 
		-webkit-border-radius: 5px;
		overflow: auto;
		}
	.seccionLayer:hover{ 
		border: 1px solid #CCC
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
		z-index: 900;
	}

 	
</style>
</asp:Content>
