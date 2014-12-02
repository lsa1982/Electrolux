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
	<table style= "padding-bottom: 10px; width:100%">
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
				Región: 
			</td>
			<td>
				<div id="txtRegion" ></div>
			</td>
		</tr>
		<tr>
			<td>
				Asignado a : 
			</td>
			<td>
				<div id="txtAsignado" ></div>
			</td>
		</tr>
		<tr>
			<td>
				Fono
			</td>
			<td>
				<div id="txtFono" ></div>
			</td>
		</tr>
		<tr>
			<td>
				eMail : 
			</td>
			<td>
				<div id="txtMail" ></div>
			</td>
		</tr>
		
	</table>
</div>
<div class="areaTrabajo" id="findResponsabilidad"> 
	<table style= "padding-bottom: 10px; width:100%">
		<tr>
			<td colspan="2" >
				<span style=" font-size: 24px;">Responsabilidad</span>
					<button id="Button1" type="button" class="k-button" style="float:right">Volver</button>
			</td>
		</tr>
		<tr>
			<td colspan="2" >
				<div id="tabView">
					<ul>
						<li class="k-state-active">
							Tienda
						</li>
						<li>
							Marca
						</li>
						<li>
							Categoria
						</li>
						<li>
							Cliente
						</li>
						
					</ul>
					<div >
						<table style="border: 1px solid #CCC; width: 300px" >
							<tr>
								<td  >Seleccione Cliente: </td>
							</tr>
							<tr>
								<td><input id='cmbTiendaCliente'  /></td>
							</tr>
							<tr>
								<td>Seleccione Región</td>
							</tr>
							<tr>
								<td><input id='cmbTiendaRegion' /></td>
							</tr>
							<tr>
								<td>Seleccion Tienda</td>
							</tr>
							<tr>
								<td><input id='cmbTienda'  /></td>
							</tr>
							<tr>
								<td><button id='btnTiendaAgregar' class="k-button-red" >Agregar</button></td>
							</tr>
						</table>
						<div id="gridTienda" style="height: 380px; float: right"></div>
						
						
					</div>
					<div >
						Seleccione: <input id='cmb2'  name='cmb2'   validationMessage='Debe ingresar un tipo' required />
						<!-- Grilla 2 -->
						<div id="grid2" style="height: 380px"></div>
					</div>
					<div >
					Seleccione : <input id='cmb3'  name='cmb3'   validationMessage='Debe ingresar un tipo' required />
						<!-- Grilla 3 -->
					<div id="grid3" style="height: 380px"></div>
					</div>
				</div>
			</td>
		</tr>

	</table>
</div>

<script>
	$(document).ready(function () {

		//#region Buscador de Rol
		// ####################################

		$("#btnBuscar").kendoButton({ icon: "arrow-s", click:
				function (e) {
					if (cmbRol.value != "") {
						dehabilitarDiv("findPerfil");
						$("#findRol").show(500);
						$("#findResponsabilidad").show();
						dsRolUsuario.read({ "idRol": cmbRol.value })
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

		var dsRol = new kendo.data.DataSource({
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

		// #region Rol

		var dsRolUsuario = new kendo.data.DataSource({
			type: "json",
			transport: {
				read: { url: strInterOp("Rol", "listaUsuario"), dataType: "json", type: "post" }
			},
			schema: { errors: "msgState", data: "args", total: "totalFila" },
			change: function (e) {
				if (this._data.length > 0) {
					var data = this._data[0];
					$("#txtRol").html(data.rol);
					$("#txtAsignado").html(data.nombre + ' ' + data.apellido);
					$("#txtFono").html(data.fono);
					$("#txtMail").html(data.email);
				}
			}
		});

		

		var dsCadena = new kendo.data.DataSource({
			transport: { read: { url: strInterOp("Matriz", "cadena"), dataType: "json", type: "post"} },
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});

		var dsCategoria = new kendo.data.DataSource({
			transport: { read: { url: strInterOp("Matriz", "categoria"), dataType: "json", type: "post"} },
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});

		var dsMarca = new kendo.data.DataSource({
			transport: { read: { url: strInterOp("Matriz", "marca"), dataType: "json", type: "post"} },
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});

		var dsRegion = new kendo.data.DataSource({
			transport: { read: { url: strInterOp("Matriz", "region"), dataType: "json", type: "post"} },
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});


		// #endregion

		// #region Matriz Tienda

		var dsTienda = new kendo.data.DataSource({
			transport: { read: { url: strInterOp("Matriz", "listaTienda"), dataType: "json", type: "post"} },
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});

		$("#gridTienda").kendoGrid({
			dataSource: dsVariable1,
			height: 350,
			pageable: true,
			autoBind: false,
			filterable: filtroGrid,
			resizable: true,
			columns: [
				cmdGrid,
				{ field: "idResponsabilidad",  hidden: true },
				{ field: "idTienda",   hidden: true },
				{ field: "Tienda", title: "Tienda", width: "200px" }
			]
		}).data("kendoGrid");
		
		// #endregion

		//$("#findRol").hide();
		//$("#findResponsabilidad").hide();
		var tabStrip = $("#tabView").kendoTabStrip().data("kendoTabStrip");
	});
	
</script>
</asp:Content>
