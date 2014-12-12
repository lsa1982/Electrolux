<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Repuestos.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="trabajo">
	<span style=" font-size: 24px;">Información de  Repuesto</span><br/><br/>
	<span style=" font-size: 16px;">Detalle relevantes de los datos asociados a los repuestos:</span><br/><br/>
	<table style= "padding-top: 15px; width: 100%; display: none" id="layerNotFound">
		<tr>
			<td colspan="2">
				<span style=" font-size: 11px;">No se encuentran repuesto  con identificador ingresado.</span>
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
			<td>Respuesto</td>
			<td><input id="txtRepuesto" class="k-textbox"  /></td>
		</tr>
		<tr>
			<td>Categoria</td>
			<td><input id="cmbCategoria" style="width: 300px" /></td>
		</tr>
		<tr>
			<td>Grupo</td>
			<td><input id="cmbGrupo" style="width: 300px" /></td>
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
						dataSend["clase"] = "Repuesto";
						return dataSend;

					}
				},
				error: errorGrid,
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			}
		});

		$("#cmbGrupo").kendoDropDownList({
			dataTextField: "grupo",
			dataValueField: "idGrupo",
			optionLabel: "Seleccione Grupo",
			valueTemplate: '#if (data.grupo != "Seleccione Grupo") {# <span><strong>#:data.grupo#</strong> - #:data.tipo#</span> #} else { # Seleccione Grupo #}#  ',
			template: '#if (data.grupo != "Seleccione Grupo") {# <span><strong>#:data.grupo#</strong> - #:data.tipo#</span> #} else { # Seleccione Grupo #}#  ',
			dataSource: {
				transport: {
					read: { url: strInterOp("Grupo", "lista"), dataType: "json", type: 'POST' }
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
			pUrl.push("txtRepuesto=" + txtRepuesto.value);
			pUrl.push("txtCategoria=" + cmbCategoria.value);
			pUrl.push("txtGrupo=" + cmbGrupo.value);

			if (opUpdate) {
				pUrl.push("idRepuesto=" + ldlId.value);
				vOperacion = "Actualizar";
			}
			var x = pUrl.join("&");
			callScript(strInterOp("Repuesto", vOperacion), '&' + x, function (e) {
				window.location.href = 'RepuestoProducto.aspx?idRepuesto=' + e.idRepuesto;
			});

		}

		function onCancelar(e) {
			vex.defaultOptions.className = 'vex-theme-os';
			vex.dialog.confirm({ message: 'Enter your username and password:', callback: function (e) { console.log(e) } });
		}

		// ########################################
		// ### Carga de Formulario				###
		// ########################################
		function cargaDatos(data) {
			idRepuesto = data[0].idRepuesto;
			ldlId.value = idRepuesto;
			txtCodigo.value = data[0].codigo;
			txtRepuesto.value = data[0].repuesto;
			$("#cmbGrupo").data("kendoDropDownList").value(data[0].idGrupo);
			$("#cmbCategoria").data("kendoDropDownList").value(data[0].idCategoria);

		}

		var dsRepuesto = new kendo.data.DataSource({
			transport: { read: { url: strInterOp("Repuesto", "listaNatural"), dataType: "json", type: 'POST'} },
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
		var idRepuesto = 0;
		var opUpdate = false;
		var vGet = getVarsUrl();
		if (typeof vGet.idRepuesto != "undefined") {
			idRepuesto = vGet.idRepuesto;
			dsRepuesto.read({ "idRepuesto": idRepuesto });
		}
	});
</script>
</asp:Content>
