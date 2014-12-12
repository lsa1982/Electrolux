<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Tienda.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="layerTienda">
<table >
	<tr>
		<td colspan="2">
			<span style=" font-size: 24px;" style="float:right">Productos en Tienda</span>
		</td>
	</tr>
	<tr>
		<td style=" width:200px">Producto</td>
		<td ><div id="lblProducto"></div></td>

	</tr>
	<tr >
		<td>Marca:</td>
		<td>
			<div id="lblMarca"></div>
		</td>
	</tr>
	<tr >
		<td>Categoria:</td>
		<td>
			<div id="lblCategoria"></div>
		</td>
	</tr>
	<tr >
		<td>Assorment:</td>
		<td>
			<div id="lblAssorment"></div>
		</td>
	</tr>
	<tr >
		<td>Precio:</td>
		<td>
			<div id="lblPrecio"></div>
		</td>
	</tr>
	<tr >
		<td>facing:</td>
		<td>
			<div id="lblFacing"></div>
		</td>
	</tr>
	<tr >
		<td>Estado:</td>
		<td>
			<div id="lblEstado"></div>
		</td>
	</tr>
	
	<tr>
		<td >
			
		</td>
	</tr>
</table>
 <table >
	<tr>
		<td colspan="2">
			<span style=" font-size: 24px;" style="float:right">Solicitud de Flujo</span>
		</td>
	</tr>
	<tr>
		<td style=" width:180px">Seleccione Flujo</td>
		<td ><input id="cmbFlujo" style="width: 300px" /></td>

	</tr>
	<tr >
		<td>Comentario:</td>
		<td><textarea class="k-textbox" rows=3 style="width: 300px"></textarea></div>
		</td>
	</tr>
	<tr >
		<td>Imagen:</td>
		<td>
			<input id="imgNewImagen" type="file" name="imgNewImagen" validationMessage="Select movie" style="width: 300px" /></div>
		</td>
	</tr>
	<tr >
		<td>:</td>
		<td><button id="btnFlujo" type="button" class="k-button-red">Enviar</button></div>
		</td>
	</tr>
</table>

 <table >
	<tr>
		<td colspan="2">
			<span style=" font-size: 24px;" style="float:right">Solicitudes en Curso</span>
		</td>
	</tr>
	<tr>
		<td >El siguiente listado muestra las solicitudes pendientes que existen sobre este producto</td>
		<td ></td>

	</tr>

	<tr >
		<td></td>
		<td>
			
		</td>
	</tr>
</table>
 </div>
<script>
	$(document).ready(function () {
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

		$("#btnFlujo").kendoButton({ click: onImagenSend });
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

		$("#cmbFlujo").kendoComboBox({
			dataTextField: "flujo",
			dataValueField: "idFlujo",
			autoBind: false,
			placeholder: "Seleccione Flujo",
			dataSource: {
				transport: { read: { url: strInterOpAs("Flujo", "lista", "Workflow"), dataType: "json", type: "post" },
					parameterMap: function (options, operation) {
						var dataSend = {};
						dataSend["malla"] = 2;
						return dataSend;
					}
				},
				sort: { field: "marca", dir: "asc" },
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			}
		});

		// #region dsProducto
		function cargaDatos(data) {
			$("#lblProducto").html("<strong>" + data[0].nombre + "</strong>");
			$("#lblCategoria").html("<strong>" + data[0].categoria + "</strong>");
			$("#lblMarca").html("<strong>" + data[0].marca + "</strong>");
			$("#lblAssorment").html("<strong>" + data[0].assorment + "</strong>");
			$("#lblPrecio").html("<strong>" + data[0].precio + "</strong>");
			$("#lblFacing").html("<strong>" + data[0].facing + "</strong>");
			var strEstado = "";
			if (data[0].flagObsoleto == 1) {
				strEstado = "<div class='productoAlerta'>Obsoleto</div>";
			}
			if (data[0].flagQuiebre == 1) {
				strEstado = strEstado + "<div class='productoAlerta'>Quiebre</div>";
			}
			if (strEstado == "")
				$("#lblEstado").html("<strong>Este producto se encuentra activo</strong>");
			else
				$("#lblEstado").html(strEstado);
		}

		var dsProducto = new kendo.data.DataSource({
			transport: { read: { url: strInterOpAs("clsTienda", "listaProducto", "Core"), dataType: "json", type: "post"} },
			schema: { errors: "msgState", data: "args", total: "totalFila" },
			change: function (e) {
				var data = this.data();
				if (this._data.length > 0) {

					cargaDatos(data);
					//$("#layerNotFound").hide(0);
					//$("#layerProducto").show();
				}
				else {
					//$("#layerProducto").hide(0);
					//$("#layerNotFound").show();
				}
			}
		});
		// #endregion


		var idProducto = 0;
		var vGet = getVarsUrl();
		if (typeof vGet.idProducto != "undefined") {
			idProducto = vGet.idProducto;
			dsProducto.read({ "idTienda": idTienda, "idProducto": idProducto });
		}

	});
</script>

<style>
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
