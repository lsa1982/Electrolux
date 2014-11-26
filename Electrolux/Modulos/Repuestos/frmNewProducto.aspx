<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Repuestos.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="trabajo">
	<span style=" font-size: 24px;">Información de  Producto</span><br/><br/>
	<span style=" font-size: 16px;">Detalle relevantes de los datos asociados a los productos:</span><br/><br/>
	<table style= "padding-top: 15px; width: 100%; display: none" id="layerNotFound">
		<tr>
			<td colspan="2">
				<span style=" font-size: 11px;">No se encuentran productos  con identificador ingresado.</span>
			</td>
		</tr>
	</table>
	<table style= "width: 100%" id="layerData">
		<tr>
			<td colspan="2" style=" font-size: 14px;"><strong> </strong></td>
		</tr>
		<tr>
			<td style=" width: 120px" >Codigo<input type="hidden" id="ldlId" /></td>
			<td> 
				<input id="txtCodigo" class="k-textbox"  />
			</td>
		</tr>
		<tr>
			<td>Producto</td>
			<td><input id="txtProducto" class="k-textbox"  /></td>
		</tr>
		<tr>
			<td>Categoria</td>
			<td><input id="cmbCategoria" style="width: 350px" /></td>
		</tr>
		<tr>
			<td>Grupo</td>
			<td><input id="cmbMarca" style="width: 350px" /></td>
		</tr>
		<tr>
			<td>CodigoBarra</td>
			<td><input id="txtCodigoBarra" style="width: 300px" class="k-textbox"  /></td>
		</tr>
		<tr>
			<td>Descripcion</td>
			<td><input id="txtDescripcion" style="width: 300px" class="k-textbox" /></td>
		</tr>

		<tr>
			<td ></td>
			<td >
				<button id="btnGuardar" type="button" class="k-button-red">Guardar</button>
				<button id="btnCancelar" type="button" class="k-button-red">Cancelar</button>
			</td>
		</tr>
	</table>

</div>
<script>
	$(document).ready(function () {

		$("#cmbCategoria").kendoDropDownList({
			dataTextField: "categoria",
			dataValueField: "idCategoria",
			optionLabel: "Seleccione Categoria",
			valueTemplate: '#if (data.categoria != "Seleccione Categoria") {# <span><strong>#:data.categoria#</strong> - #:data.tipo#</span> #} else { # Seleccione Categoria #}#  ',
			template: '#if (data.categoria != "Seleccione Categoria") {# <span><strong>#:data.categoria#</strong> - #:data.tipo#</span> #} else { # Seleccione Categoria #}#  ',
			dataSource: {
				transport: {
					read: { url: strInterOpAs("clsCategoria", "lista", "Core"), dataType: "json", type: 'POST' },
					parameterMap: function (options, operation) {
						var dataSend = {};
						dataSend["clase"] = "Producto";
						return dataSend;

					}
				},
				error: errorGrid,
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			}
		});

		$("#cmbMarca").kendoDropDownList({
			dataTextField: "marca",
			dataValueField: "idMarca",
			optionLabel: "Seleccione Marca",
			dataSource: {
				transport: {
					read: { url: strInterOpAs("clsMarca", "lista", "Core"), dataType: "json", type: 'POST' }
				},
				error: errorGrid,
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			}
		});

		// ########################################
		// ### Botones Operacion				###
		// ########################################
		$("#btnGuardar").kendoButton({ click: onGuardar });
		$("#btnCancelar").kendoButton({ click: onCancelar });
		function onGuardar(e) {
			var pUrl = [];
			var vOperacion = "Insertar";
			pUrl.push("txtCodigo=" + txtCodigo.value);
			pUrl.push("txtNombre=" + txtNombre.value);
			pUrl.push("txtCategoria=" + cmbCategoria.value);
			pUrl.push("txtMarca=" + cmbMarca.value);
			pUrl.push("txtCodigoBarra=" + txtCodigoBarra.value);
			pUrl.push("txtDescripcion=" + txtDescripcion.value);
			
			if (opUpdate) {
				pUrl.push("idProducto=" + ldlId.value);
				vOperacion = "Actualizar";
			}
			var x = pUrl.join("&");
			callScript(strInterOpAs("clsProducto", vOperacion), '&' + x, function (e) {
				window.location.href = 'frmProducto.aspx?idProducto=' + e.idProducto;
			});

		}

		function onCancelar(e) {
			window.location.href = 'frmProducto.aspx?idProducto=' + idProducto;
		}

		// ########################################
		// ### Carga de Formulario				###
		// ########################################
		function cargaDatos(data) {
			ldlId.value = idProducto;
			txtCodigo.value = data[0].codigo;
			txtProducto.value = data[0].nombre;
			txtCodigoBarra.value = data[0].codigoBarra;
			txtDescripcion.value = data[0].descripcion;
			$("#cmbMarca").data("kendoDropDownList").value(data[0].idMarca);
			$("#cmbCategoria").data("kendoDropDownList").value(data[0].idCategoria);

		}

		var dsProducto = new kendo.data.DataSource({
			transport: { read: { url: strInterOpAs("clsProducto", "lista", "Core"), dataType: "json", type: 'POST'} },
			change: function (e) {
				var data = this.data();
				if (data.length > 0) {
					cargaDatos(data);
					opUpdate = true;
				} else {
					$("#layerNotFound").show();
					$("#layerData").hide();
				}
			},
			batch: true,
			resizable: true,
			error: errorGrid,
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});

		// ########################################
		// ### Proceso Inicial					###
		// ########################################
		var idProducto = 0;
		var opUpdate = false;
		var vGet = getVarsUrl();
		if (typeof vGet.idProducto != "undefined") {
			idProducto = vGet.idProducto;
			dsProducto.read({ "idProducto": idProducto });
		}
	});
</script>
</asp:Content>
