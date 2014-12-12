<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Tienda.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="layerTienda">
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
		<td >El siguiente listado muestra las solicitudes pendientes que existen</td>
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
						dataSend["malla"] = 4;
						return dataSend;
					}
				},
				sort: { field: "marca", dir: "asc" },
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			}
		});

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
