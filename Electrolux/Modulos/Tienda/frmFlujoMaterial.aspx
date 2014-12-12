<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Tienda.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="layerTienda">
<table >
	<tr>
		<td colspan="2">
			<span style=" font-size: 24px;" style="float:right">Materiales Disponibles</span>
		</td>
	</tr>
	<tr >
		<td>Categoria:</td>
		<td>
			<input id="cmbCategoria"/>
		</td>
	</tr> 
	<tr>
		<td style=" width:200px">Material</td>
		<td ><input id="cmbMaterial"/></td>
	</tr>
		<td>Comentario:</td>
		<td><textarea class="k-textbox" rows=3 style="width: 300px"></textarea>
		</td>
	</tr>
	<tr >
		<td></td>
		<td><button id="btnFlujo" type="button" class="k-button-red">Enviar</button>
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
		<td>El siguiente listado muestra las solicitudes pendientes que existen</td>
		<td></td>
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
		$("#cmbMaterial").kendoComboBox({
			dataTextField: "material",
			dataValueField: "idMaterial",
			autoBind: false,
			placeholder: "Seleccione Material",
			dataSource: {
				transport: { read: { url: strInterOpAs("Material", "lista", "Core"), dataType: "json", type: "post" },
					parameterMap: function (options, operation) {
						var dataSend = {};
						if (cmbCategoria.value) {
							dataSend["idCategoria"] = cmbCategoria.value
						}
						return dataSend;
					}
				},
				sort: { field: "material", dir: "asc" },
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			}
		});


		$("#cmbCategoria").kendoComboBox({
			dataTextField: "categoria",
			dataValueField: "idCategoria",
			autoBind: false,
			placeholder: "Seleccione Categoria",
			dataSource: {
				transport: { read: { url: strInterOpAs("clsCategoria", "lista", "Core"), dataType: "json", type: "post" },
					parameterMap: function (options, operation) {
						return { "clase": "Material" };
					}
				},
				sort: { field: "categoria", dir: "asc" },
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			},
			change: function (e) {
				$("#cmbMaterial").data("kendoComboBox").dataSource.read();
				
			}
		});



		// #endregion

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
