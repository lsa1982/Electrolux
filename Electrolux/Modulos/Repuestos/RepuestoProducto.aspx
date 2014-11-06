<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Repuestos.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
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
						<td style=" height: 140px; width: 240px; text-align: center">
							<div id="imgCenter" style="width: 100%; padding-bottom: 15px; height: 128px; width: 128px; cursor:hand " >
								<img src="../../Styles/images/Core.png"/>
							</div>
							<div style=" height: 30px; width: 30px;margin-left: 15px; float: left; border: 1px solid #CCC" >
								<img src="../../Styles/images/Core.png" height="16px" width="16px"/>
							</div>
							<div style=" height: 30px; width: 30px;margin-left: 15px;float: left; border: 1px solid #CCC" >
								<img src="../../Styles/images/Core.png" height="16px" width="16px"/>
							</div>
							<div style=" height: 30px; width: 30px;margin-left: 15px; float: left; border: 1px solid #CCC" >
								<img src="../../Styles/images/Core.png" height="16px" width="16px"/>
							</div>
							
						</td>
						<td>
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
								<td>Respuesto</td>
								<td><div id="lblRepuesto"></div> </td>
							</tr>
							<tr>
								<td>Categoria</td>
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
				<div id="layerProducto" style=" font-size: 24px;">Productos Compatibles</div>
				<button id="btnVolver1" type="button" class="k-button" style="float:right">Volver </button>
			</td>
		</tr>
		<tr>
			<td colspan="2">Lista de producto que utilizan este repuesto:<br>&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2"><div id="grid"></div></td>
		</tr>
		<!-- Capa de Inventario -->
		<tr>
			<td colspan="2">
				<div id="layerInventario" style=" font-size: 24px;">Inventario</div>
				<button id="btnVolver2" type="button" class="k-button" style="float:right">Volver </button>
			</td>
		</tr>
		<tr>
			<td colspan="2">Lista de producto que utilizan este repuesto:<br>&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2"><div id="Div2"></div></td>
		</tr>
	</table>
</div>
<div id="winImagen">
	<div id="imgImagenCentral"></div>
	<a href="#">Eliminar</a>
	<a href="#">Marcar como principal</a>
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

<script>
	$(document).ready(function () {
		// ########################################
		// ### Windows Cargar Imagen			###
		// ########################################
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
				}
			);
		}

		$("#btnImagenCancel").kendoButton({ click: onImagenCancel });
		function onImagenCancel(e) {
			$("#layerInfoImagen").hide(200);
			$(".k-widget.k-upload").find("ul").remove();
			$("#imgNewImagen").data("kendoUpload").enable();
		}
		// ########################################
		// ### Windows Imagen					###
		// ########################################
		$("#winImagen").kendoWindow({
			width: "450px",
			title: "Imagen de Repuesto",
			actions: ["Close"],
			visible: false,
			modal: true
		});

		$('#imgCenter').click(function () {
			$("#winImagen").data("kendoWindow").center();
			$("#winImagen").data("kendoWindow").open();
			$("#imgImagenCentral").html("<img src='../../Styles/images/Core.png'/>");
		});

		// ########################################
		// ### Botones Operacion				###
		// ########################################
		$("#btnModificar").kendoButton({ click: onImagen });
		$("#btnEliminar").kendoButton({ click: onImagen });
		$("#btnImagen").kendoButton({ click: onImagen });
		function onImagen(e) {
			$("#winCargaImagen").data("kendoWindow").center();
			$("#winCargaImagen").data("kendoWindow").open();
		}

		// ########################################
		// ### Botones Movimiento				###
		// ########################################
		$("#btnVolver1").kendoButton({ click: onVolver, icon: "arrow-n" });
		$("#btnVolver2").kendoButton({ click: onVolver, icon: "arrow-n" });
		function onVolver(e) {
			$("body, html").animate({ scrollTop: 0 }, 600);
		}


		$("#btnProducto").kendoButton({ click: onMensaje, icon: "arrow-s" });
		function onMensaje(e) {
			$("body, html").animate({ scrollTop: $("#layerProducto").offset().top }, 600);
		}

		$("#btnInventario").kendoButton({ click: onMensaje, icon: "arrow-s" });
		function onMensaje(e) {
			$("body, html").animate({ scrollTop: $("#layerInventario").offset().top }, 600);
		}

		// ########################################
		// ### Grid Producto					###
		// ########################################
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

		// ########################################
		// ### Datasource Imagenes				###
		// ########################################

		var dsImagen = new kendo.data.DataSource({
			transport: { read: { url: strInterOp("Repuesto", "listaImagen"), dataType: "json", type: 'POST'} },
			batch: true,
			resizable: true,
			error: errorGrid,
			schema: { errors: "msgState", data: "args", total: "totalFila" },
			change: function (e) {
				var strDivImagen = "";
				if (this._data.length > 0) {
					var data = this.data();
					//					var strDiv = "<div class='divProrroga'><span style='font-weight: bold; color: #0B90A7 '> Ingresado el $1 <br>Por $2";
					//					strDiv = strDiv + "</span><br><hr/>Motivo:<strong> $3</strong><br>Fecha Anterior:<strong> $4</strong><br>";
					//					strDiv = strDiv + "Fecha Nueva: <strong>$5</strong><br>Comentario: <strong>$6</strong></div>";

					//					for (i = 0; i < this._data.length; i++) {
					//						strDivData = strDiv;
					//						strDivData = strDivData.replace("$1", data[i].fechaModificacion);
					//						strDivData = strDivData.replace("$2", data[i].usuario);
					//						strDivData = strDivData.replace("$3", data[i].motivo);
					//						strDivData = strDivData.replace("$4", data[i].fechaAntigua);
					//						strDivData = strDivData.replace("$5", data[i].fechaNueva);
					//						strDivData = strDivData.replace("$6", data[i].comentario);
					//						strDivImagen = strDivImagen + strDivData;
					//					}
				}
				else {
					strDivImagen = "<strong>No existen Imagenes</strong>";
				}
				$("#imgCenter").html(strDivImagen);
			}
		});
		// ########################################
		// ### Carga de Formulario				###
		// ########################################
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
		}

		var dsRepuesto = new kendo.data.DataSource({
			transport: { read: { url: strInterOp("Repuesto", "lista"), dataType: "json", type: 'POST'} },
			change: function (e) {
				var data = this.data();
				if (this._data.length > 0) {
					var data = this.data();
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

		// ########################################
		// ### Boton Buscar						###
		// ########################################
		$("#btnBuscar").kendoButton({ click: onFind, icon: "search" });
		function onFind(e) {
			dsRepuesto.read({ "codigo": txtFindCodigo.value });
		}
		// ########################################
		// ### Proceso Inicial					###
		// ########################################
		var idRepuesto = 0;
		var vGet = getVarsUrl();
		if (typeof vGet.idRepuesto != "undefined") {
			idRepuesto = vGet.idRepuesto;
			dsRepuesto.read({ "idRepuesto": idRepuesto });
		}


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
