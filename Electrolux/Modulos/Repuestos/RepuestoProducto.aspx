<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Repuestos.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<script src="../../Kendo/bjqs-1.3.js" type="text/javascript"></script>
<link href="../../Styles/bjqs.css" rel="stylesheet" type="text/css" />
<script src="../../Kendo/vex.combined.min.js" type="text/javascript"></script>
<link href="../../Styles/vex.css" rel="stylesheet" type="text/css" />
<link href="../../Styles/vex-theme-os.css" rel="stylesheet" type="text/css" />

<div class="areaTrabajo" id="trabajo">
	<span style=" font-size: 24px;">Detalle de Repuesto</span><br/>
	<table>
		<tr>
			<td style=" width:220px">Ingrese codigo de repuesto a buscar</td>
			<td style=" width:180px"><input id="txtFindCodigo" type="text" /></td>
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
	<table style= "padding-top: 15px;display: none" id="layerRepuesto">
		<tr>
			<td colspan="2" style="font-size: 16px; border: 0">
				<strong>Información General del Repuesto</strong>
				<div style="float: right;margin-right: 10px;font-size: 11px">
					<button id="btnProducto" type="button" class="k-button">Productos</button>
					<button id="btnInventario" type="button" class="k-button">Inventario</button>
				</div> 
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<table >
					<tr>
						<td style=" height: 300px; width: 250px; text-align: center" >
							<div id="banner-fade" ></div>
						</td>
						<td>
						<table style= "width: 100%">
							<tr>
								<td colspan="2" style=" font-size: 14px;"><strong> </strong></td>
							</tr>
							<tr>
								<td style=" width: 120px" >C&oacute;digo<input type="hidden" id="ldlId" /></td>
								<td style="vertical-align:  middle"> 
									<div id="lblCodigo" style="float: left" ></div>  
								</td>
							</tr>
							<tr>
								<td>Respuesto</td>
								<td><div id="lblRepuesto"></div> </td>
							</tr>
							<tr>
								<td>Categor&iacute;a</td>
								<td><div id="lblCategoria"></div></td>
							</tr>
							<tr>
								<td>Grupo</td>
								<td><div id="lblGrupo"></div></td>
							</tr>
							<tr>
								<td>Tipo</td>
								<td><div id="lblTipo"></div></td>
							</tr>
							<tr>
								<td>Cantidad</td>
								<td><div id="lblCantidad"></div></td>
							</tr>
							<tr>
								<td>Valor</td>
								<td><div id="lblValor"></div></td>
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
				</table>
			</td>
		</tr>
		<!-- Capa de Productos -->
		<tr>
			<td colspan="2">
				<div id="layerProducto" style=" font-size: 24px; float:left">
					Productos Compatibles
				</div>
				<button id="btnVolver1" type="button" class="k-button" style="float:right">Volver </button>
			</td>
		</tr>

		<tr>
			<td style=" width: 300px; vertical-align: middle" > Para agregar un nuevo producto presione aqui:</td>
			<td><button id="btnNewProducto" type="button" class="k-button-red">Nueva Producto</button></td>
		</tr>
		<tr>
			<td colspan="2"><div id="frmProducto"></div></td>
		</tr>

		<!-- Capa de Inventario -->
		<tr>
			<td colspan="2">
			
				<div id="layerInventario" style=" font-size: 24px; float:left">Inventario</div>
				<button id="btnVolver2" type="button" class="k-button" style="float:right">Volver </button>
			</td>
		</tr>
		<tr>
			<td colspan="2">Lista de movimientos asociados a este repuesto:<br>&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2"><div id="grid"></div></td>
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
			<td>Seleccione la imagen que desea subir: </td>
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
<div id="winNewProducto" style="font-size:11px">
		<table >
		<tr >
			<td style="width: 120px">Categoria: </td>
			<td ><input id="cmbCategoria" style="width: 200px" /></td>
		</tr>
		<tr >
			<td>Marca: </td>
			<td><input id="cmbMarca" style="width: 200px" /></td>
		</tr>
		<tr>
			<td>Producto: </td>
			<td><input id="txtProducto" style="width: 200px"  /></td>
		</tr>
		<tr>
			<td>Seccion: </td>
			<td><input id="cmbSeccion" style="width: 200px" /></td>
		</tr>
		<tr style="font-size: 10px; border-bottom-width: 1px; ">
			<td></td>
			<td>
				<button id="btnProductoAgregar" type="button" class="k-button-red">Agregar</button>
			</td>
		</tr>
	</table>
</div>

<script>
	$(document).ready(function () {

		//#region Windows Nuevo Producto
		//################################################
		$("#winNewProducto").kendoWindow({
			width: "450px",
			title: "Agregar Producto",
			actions: ["Close"],
			visible: false,
			modal: true
		});

		$("#btnProductoAgregar").kendoButton({ click: onProductoAgregar });
		function onProductoAgregar(e) {

			var pUrl = [];
			pUrl.push("idRepuesto=" + idRepuesto);
			pUrl.push("idProducto=" + txtProducto.value);
			pUrl.push("idSeccion=" + cmbSeccion.value);

			var x = pUrl.join("&");
			callScript(strInterOp("Repuesto", "insertarProducto"), '&' + x,
				function (e) {
					$("#winNewProducto").data("kendoWindow").close();
					dsProducto.read({ "idRepuesto": idRepuesto });
					$("#txtProducto").data("kendoComboBox").text("");
					$("#cmbCategoria").data("kendoComboBox").text("");
					$("#cmbMarca").data("kendoComboBox").text("");
					$("#cmbSeccion").data("kendoComboBox").text("");
				}
			);
		}

		$("#cmbCategoria").kendoComboBox({
			dataTextField: "categoria",
			dataValueField: "idCategoria",
			autoBind: false,
			placeholder: "Seleccione Categoria",
			change: function (e) {
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
				transport: { read: { url: strInterOpAs("clsMarca", "lista", "Core"), dataType: "json", type: "post"} },
				sort: { field: "marca", dir: "asc" },
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
				transport: { read: { url: strInterOpAs("clsMarca", "lista", "Core"), dataType: "json", type: "post"} },
				sort: { field: "marca", dir: "asc" },
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			}
		});

		var dsProductoAdd = new kendo.data.DataSource({
			serverFiltering: true,
			transport: {
				read: { url: strInterOpAs("clsProducto", "lista", "Core"), dataType: "json", type: "post" },
				parameterMap: function (options, operation) {
					var dataSend = {};
					if (cmbMarca.value != "")
						dataSend["idMarca"] = cmbMarca.value;
					if (cmbCategoria.value != "")
						dataSend["idCategoria"] = cmbCategoria.value;
					if (options.filter != undefined)
						dataSend["value"] = $("#txtProducto").data("kendoComboBox")._prev;
					return dataSend;

				}
			},
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});
		function onOpen(e) {
			console.log("event: open");
			dsProductoAdd.read();
		};

		$("#txtProducto").kendoComboBox({
			dataTextField: "nombre",
			dataValueField: "idProducto",
			filter: "contains",
			minLength: 4,
			autoBind: false,
			dataSource: dsProductoAdd,
			open: onOpen
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

		//#endregion

		//#region Windows Cargar Imagen
		//################################################
		$("#winCargaImagen").kendoWindow({
			width: "450px",
			title: "Imagen de Repuesto",
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
				saveUrl: strInterOp("Repuesto", "subirImagen"),
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
			pUrl.push("idRepuesto=" + idRepuesto);
			pUrl.push("informacion=" + txtInformacion.value);
			pUrl.push("flagPrincipal=" + txtImagenPrincipal.value);
			pUrl.push("fileUpload=" + txtUpload.value);

			var x = pUrl.join("&");
			callScript(strInterOp("Repuesto", "guardarImagen"), '&' + x,
				function (e) {
					$("#winCargaImagen").data("kendoWindow").close();
					dsImagen.read({ "idRepuesto": idRepuesto });
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

		$("#btnModificar").kendoButton({ click: onModificar });
		function onModificar(e) {
			window.location.href = 'frmNewRepuesto.aspx?idRepuesto=' + idRepuesto;
		}


		$("#btnEliminar").kendoButton({ click: onDelete });
		$("#btnImagen").kendoButton({ click: onImagen });
		function onImagen(e) {
			$("#winCargaImagen").data("kendoWindow").center();
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

		//#region Grid Inventario
		//################################################
		var dsInventario = new kendo.data.DataSource({
			transport: {
				read: { url: strInterOp("Repuesto", "listaInventario"), dataType: "json", type: 'POST' }
			},
			batch: true,
			resizable: true,
			error: errorGrid,
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});

		$("#grid").kendoGrid({
			dataSource: dsInventario,
			pageable: { pageable: true, pageSizes: [5, 10, 25, 50] },
			height: 450,
			sortable: true,
			filterable: filtroGrid,
			resizable: true,
			autoBind: false,
			columns: [
				{ command: { text: "Detalle", click: onView }, title: " ", width: "90px" },
				{ field: "idInventario", title: "id", width: "40px" },
				{ field: "fechaMovimiento", title: "Código", width: "180px" },
				{ field: "tipoDocumento", title: "Documento", width: "160px" },
				{ field: "referencia", title: "Referencia", width: "150px" },
				{ field: "valor", title: "Valor", width: "100px" },
				{ field: "cantidad", title: "Cantidad", width: "100px" },
				{ field: "", title: "" }
			]
		});

		function onView(e) {
			e.preventDefault();
			var dataItem = this.dataItem($(e.currentTarget).closest("tr"));
			window.location = 'RepuestoProducto.aspx?idRepuesto=' + dataItem.idRepuesto;
		}
		//#endregion

		//#region Datasource Imagenes
		//################################################
		var dsImagen = new kendo.data.DataSource({
			transport: { read: { url: strInterOp("Repuesto", "listaImagen"), dataType: "json", type: 'POST'} },
			batch: true,
			resizable: true,
			error: errorGrid,
			schema: { errors: "msgState", data: "args", total: "totalFila" },
			change: function (e) {
				$('#banner-fade').empty();
				if (this._data.length > 0) {
					var data = this.data();
					$('#banner-fade').bjqs({ data: data, path: '../../Styles/Repuestos/', responsive: true });
				}
				else {
					$("#imgCenter").html("<strong>No existen Imagenes</strong>");
				}
				$('#banner-fade .bjqs-slide').click(function () {
					$("#winImagen").data("kendoWindow").center();
					$("#winImagen").data("kendoWindow").open();
					var strImg = "<img src='$1' title='$2' data-id='$4'/>";
					strImg = strImg.replace("$1", this.firstChild.src);
					strImg = strImg.replace("$1", this.firstChild.title);
					strImg = strImg.replace("$4", this.firstChild.dataset.id);
					imgImagenId.value = this.firstChild.dataset.id;
					$("#imgImagenCentral").html(strImg);
					$("#imgImagenTitle").html(this.firstChild.title);

				});
			}
		});

		//#endregion

		//#region Carga de Formulario
		//################################################
		function cargaDatos(data) {
			idRepuesto = data[0].idRepuesto;
			$("#lblId").html(data[0].id);
			$("#lblCodigo").html("<strong>" + data[0].codigo + "</strong>");
			$("#lblRepuesto").html("<strong>" + data[0].repuesto + "</strong>");
			$("#lblImagen").html("<strong>" + data[0].imagen + "</strong>");
			$("#lblGrupo").html("<strong>" + data[0].grupo + "</strong>");
			$("#lblCategoria").html("<strong>" + data[0].categoria + "</strong>");
			$("#lblTipo").html("<strong>" + data[0].tipo + "</strong>");
			$("#lblCantidad").html("<strong>" + data[0].cantidad + "</strong>");
			$("#lblValor").html("<strong>" + data[0].valor + "</strong>");
			dsProducto.read({ "idRepuesto": idRepuesto });
			dsImagen.read({ "idRepuesto": idRepuesto });
			dsInventario.read({ "idRepuesto": idRepuesto });
		}

		var dsRepuesto = new kendo.data.DataSource({
			transport: { read: { url: strInterOp("Repuesto", "lista"), dataType: "json", type: 'POST'} },
			change: function (e) {
				var data = this.data();
				if (this._data.length > 0) {
					cargaDatos(data);
					$("#layerNotFound").hide(0);
					$("#layerRepuesto").show();
				}
				else {
					$("#layerRepuesto").hide(0);
					$("#layerNotFound").show();
				}
			},
			batch: true,
			resizable: true,
			error: errorGrid,
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});
		//#endregion

		//#region DataSource Producto
		//################################################
		var dsProducto = new kendo.data.DataSource({
			transport: {
				read: { url: strInterOp("Repuesto", "listaRepuestoProducto"), dataType: "json", type: 'POST' }
			},
			batch: true,
			resizable: true,
			error: errorGrid,
			schema: { errors: "msgState", data: "args", total: "totalFila" },
			change: function (e) {
				var strDivProducto = "";
				if (this._data.length > 0) {
					var data = this.data();
					var strDiv = "<span name='spanTitle' data-id='$8' style='font-weight: bold; color: #0B90A7 '>  $1 - $2";
					strDiv = strDiv + "<img name='imgDelete' data-id='$7' src='../../Styles/images/circle_delete.png' style='float:right; width:16px; height:16px' />";

					strDiv = strDiv + "</span><br><hr/>Tipo:<strong> $3</strong><br>Categoria:<strong> $4</strong><br>";
					strDiv = strDiv + "<img src='$5' style='max-width:200px; max-height:200px; ' />";

					for (i = 0; i < this._data.length; i++) {
						var strDivData = strDiv;
						strDivData = strDivData.replace("$1", data[i].codigo);
						strDivData = strDivData.replace("$2", data[i].nombre);
						strDivData = strDivData.replace("$3", data[i].tipo);
						strDivData = strDivData.replace("$4", data[i].categoria);
						strDivData = strDivData.replace("$6", data[i].idProducto);
						strDivData = strDivData.replace("$7", data[i].idProductoRepuesto);
						strDivData = strDivData.replace("$8", data[i].idProducto);
						if (data[i].imagen != "")
							strDivData = strDivData.replace("$5", "../../Styles/Productos/" + data[i].imagen);
						else
							strDivData = strDivData.replace("$5", "../../Styles/Productos/noImage.png");
						strDivProducto = strDivProducto + "<div class='divProducto'>" + strDivData + "</div>";
					}
				}
				else {
					strDivProducto = "<strong>No existen productos asociados a este repuesto.</strong>";
				}
				$("#frmProducto").html(strDivProducto);
				$(".divProducto").find("span[name='spanTitle']").click(function (e) {
					window.location.href = 'frmProducto.aspx?idProducto=' + this.dataset.id;
				});

				$(".divProducto").find("img[name='imgDelete']").click(function (e) {
					var imgSel = this;
					vex.defaultOptions.className = 'vex-theme-os';
					vex.dialog.confirm({ message: 'Esta seguro de eliminar este Producto?',
						callback: function (e) {
							if (e) {
								var pUrl = [];
								pUrl.push("idProductoRepuesto=" + imgSel.dataset.id);
								var x = pUrl.join("&");
								callScript(strInterOp("Repuesto", "eliminarProducto"), '&' + x,
							function (ex) {
								dsProducto.read({ "idRepuesto": idRepuesto })
							}
						);
							}
						}
					});
				}
				);

			}
		});

		$("#btnNewProducto").kendoButton({ click: onNewProducto });
		function onNewProducto(e) {
			$("#winNewProducto").data("kendoWindow").center();
			$("#winNewProducto").data("kendoWindow").open();
		}
		//#endregion

		//#region Boton Buscar
		//################################################
		$("#btnBuscar").kendoButton({ click: onFind, icon: "search" });
		function onFind(e) {
			dsRepuesto.read({ "codigo": txtFindCodigo.value });
		}
		//#endregion

		//#region Proceso Inicial
		//################################################
		var idRepuesto = 0;
		var vGet = getVarsUrl();
		if (typeof vGet.idRepuesto != "undefined") {
			idRepuesto = vGet.idRepuesto;
			dsRepuesto.read({ "idRepuesto": idRepuesto });
		}
		//#endregion

	});
</script>
<style>
	
	.divProducto{
		 border: 1px solid #AAA; 
		 width: 260px; 
		 float: left;
		 margin-right:15px;
		 margin-bottom:15px;
		 -webkit-border-radius: 5px;
		 padding: 5px;
		 box-shadow: 0 0 4px #999;
		 min-height: 150px;
		 cursor: pointer
		}
 	
</style>
</asp:Content>
