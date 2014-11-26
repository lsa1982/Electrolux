<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Repuestos.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="findPerfil">
	<table style= "padding-bottom: 10px">
		<tr>
			<td colspan="4">
				<span style=" font-size: 24px;">Selecci&oacute;n de Rol</span>
			</td>
		</tr>
		<tr>
			<td style="width: 120px">
				Seleccione Perfil: 
			</td>
			<td>
				<input id="cmbPerfil" style="width: 300px" />
			</td>
			<td>
				Seleccione Rol: 
			</td>
			<td>
				<input id="cmbRol" style="width: 300px" />
			</td>
			<td><button id="btnBuscar" type="button" class="k-button">Buscar...</button></td>
		</tr>
		<tr>
			<td>
				Seleccione Región: 
			</td>
			<td colspan="3"><input id="cmbRegion" style="width: 300px" /></td>
		</tr>
	</table>
</div>
<div class="areaTrabajo" id="findRol"> 
	<table style= "padding-bottom: 10px; font-size : 10px; width:100%">
		<tr >
			<td colspan="2" >
				<span style=" font-size: 24px;">Datos del Rol</span>
					<button id="btnVolverPerfil" type="button" class="k-button" style="float:right">Volver</button>
			</td>
		</tr>
		<tr>
			<td style="width: 120px">
				Rol
			</td>
			<td >
				<div id="txtRol" ></div>
			</td>
		</tr>
		<tr >
			<td>
				estado: 
			</td>
			<td>
				<div id="txtEstado" ></div>
			</td>
		</tr>
		<tr>
			<td>
				Asignado a : 
			</td>
			<td>
				<div id="txtUsuario" ></div>
			</td>
		</tr>
		
	</table>
</div>
<script>
	$(document).ready(function () {
		//#region Paso 1 Busca Rol
		// ####################################

		$("#btnBuscar").kendoButton({ icon: "arrow-s", click:
				function (e) {
					if (cmbRol.value != "") {
						$("#findRol").show(500);
					}
				}
		});

		$("#cmbPerfil").kendoComboBox({
			dataTextField: "perfil",
			dataValueField: "idPerfil",
			placeholder: "Seleccione Perfil",
			dataSource: {
				type: "json",
				transport: {
					read: { url: strInterOp("Perfil", "lista"), dataType: "json", type: "post" }
				},
				sort: { field: "perfil", dir: "asc" },
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			},
			cascade: function (e) {
				$("#cmbRol").data("kendoComboBox").text("");
				$("#cmbRol").data("kendoComboBox").value("");
			}
		});

		var dsRol= new kendo.data.DataSource({
			serverFiltering: true,
			type: "json",
			transport: {
				read: { url: strInterOp("Rol", "lista"), dataType: "json", type: "post" },
				parameterMap: function (options, operation) {
					var dataSend = {};
					if (cmbPerfil.value != "") {
						dataSend["idPerfil"] = cmbPerfil.value;
					}
					if (cmbRegion.value != "") {
						dataSend["region"] = cmbRegion.value;
					}
					if (options.filter != undefined) {
						dataSend["rol"] = $("#cmbRol").data("kendoComboBox")._prev;
					}
					return dataSend;
				}
			},
			sort: { field: "tienda", dir: "asc" },
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});

		$("#cmbRol").kendoComboBox({
			dataTextField: "rol",
			dataValueField: "idRol",
			autoBind: false,
			placeholder: "Seleccione Rol",
			filter: "contains",
			minLength: 4,
			autoBind: false,
			dataSource: dsRol,
			open: function (e) {
				dsRol.read();
			}
		});


		var dsRegion = new kendo.data.DataSource({
			type: "json",
			transport: {
				read: { url: strInterOp("Perfil", "listaRegion"), dataType: "json", type: "post" },
				parameterMap: function (options, operation) {
					var dataSend = {};
					if (cmbPerfil.value != "") {
						dataSend["idPerfil"] = cmbPerfil.value;
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

		$("#findRol").hide();
	});
	
</script>
</asp:Content>
