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
					<div>
						<table>
							<tr>
								<td style=" width: 300px"  >Seleccione Cliente: </td>
								<td rowspan="7"><div id="gridTienda" ></div></td>
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
							
					</div>
					<div >
						<table>
							<tr>
								<td style=" width: 300px"  >Seleccione Marca: </td>
								<td rowspan="7"><div id="gridMarca" ></div></td>
							</tr>
							<tr>
								<td><input id='cmbMarca'  /></td>
							</tr>
							<tr>
								<td><button id='btnMarcaAgregar' class="k-button-red" >Agregar</button></td>
							</tr>
						</table>
					</div>
					<div >
						<table>
							<tr>
								<td style=" width: 300px"  >Seleccione Categoria: </td>
								<td rowspan="7"><div id="gridCategoria" ></div></td>
							</tr>
							<tr>
								<td><input id='cmbCategoria'  /></td>
							</tr>
							<tr>
								<td><button id='btnCategoriaAgregar' class="k-button-red" >Agregar</button></td>
							</tr>
						</table>
					</div>
					<div >
						<table>
							<tr>
								<td style=" width: 300px"  >Seleccione Cadena: </td>
								<td rowspan="7"><div id="gridCadena" ></div></td>
							</tr>
							<tr>
								<td><input id='cmbCadena'  /></td>
							</tr>
							<tr>
								<td><button id='btnCadenaAgregar' class="k-button-red" >Agregar</button></td>
							</tr>
						</table>
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
					dsTienda.read({ "idRol": cmbRol.value, "variable": "tienda" })
					dsMarca.read({ "idRol": cmbRol.value, "variable": "marca" })
					dsCategoria.read({ "idRol": cmbRol.value, "variable": "categoria" })
					dsCadena.read({ "idRol": cmbRol.value, "variable": "cadena" })
				}
			}
		});

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

		// #region Matriz Tienda

		$("#cmbTiendaCliente").kendoComboBox({
			dataTextField: "cadena",
			dataValueField: "idCadena",
			placeholder: "Seleccione Cadena",
			dataSource: {
				type: "json",
				transport: {
					read: { url: strInterOpAs("clsCadena", "lista", "Core"), dataType: "json", type: "post" }
				},
				sort: { field: "cadena", dir: "asc" },
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			},
			cascade: function (e) {
				$("#cmbTienda").data("kendoComboBox").text("");
				$("#cmbTienda").data("kendoComboBox").value("");
			}
		});

		var dsTiendaRegion = new kendo.data.DataSource({
			transport: {
				read: { url: strInterOpAs("clsTienda", "listaRegion", "Core"), dataType: "json", type: "post" },
				parameterMap: function (options, operation) {
					var dataSend = {};
					if (cmbTiendaCliente.value != "") 
						dataSend["idCadena"] = cmbTiendaCliente.value;
					if (cmbTiendaRegion.value != "")
						dataSend["region"] = cmbTiendaRegion.value;
					return dataSend;
				}
			},
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});

		$("#cmbTiendaRegion").kendoComboBox({
			dataTextField: "region",
			dataValueField: "region",
			autoBind: false,
			placeholder: "Seleccione Región",
			autoBind: false,
			dataSource: dsTiendaRegion,
			open: function (e) {
				dsRegion.read();
			}
		});

		var dsTiendaFiltro = new kendo.data.DataSource({
			serverFiltering: true,
			transport: {
				read: { url: strInterOpAs("clsTienda", "lista", "Core"), dataType: "json", type: "post" },
				parameterMap: function (options, operation) {
					var dataSend = {};
					if (cmbTiendaCliente.value != "")
						dataSend["txtidCadena"] = cmbTiendaCliente.value;
					if (cmbTiendaRegion.value != "")
						dataSend["region"] = cmbTiendaRegion.value;
					if (options.filter != undefined) 
						dataSend["nombre"] = $("#cmbTienda").data("kendoComboBox")._prev;
					return dataSend;
				}
			},
			sort: { field: "tienda", dir: "asc" },
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});

		$("#cmbTienda").kendoComboBox({
			dataTextField: "tienda",
			dataValueField: "idTienda",
			autoBind: false,
			placeholder: "Seleccione Tienda",
			filter: "contains",
			minLength: 4,
			autoBind: false,
			dataSource: dsTiendaFiltro,
			open: function (e) {
				dsTiendaFiltro.read();
			}
		});

		var dsTienda = new kendo.data.DataSource({
			transport: { read: { url: strInterOp("Matriz", "lista"), dataType: "json", type: "post"} },
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});
		$("#gridTienda").kendoGrid({
			dataSource: dsTienda,
			pageable: true,
			height: 300,
			autoBind: false,
			resizable: true,
			columns: [
				cmdGrid,
				{ field: "idResponsabilidad",  hidden: true },
				{ field: "idTienda",   hidden: true },
				{ field: "tienda", title: "Tienda", width: "200px" }
			]
		}).data("kendoGrid");

		$("#btnTiendaAgregar").kendoButton({ icon: "arrow-s", click:
			function (e) {
				
			}
		});

		// #endregion

		// #region Matriz Marca

		$("#cmbMarca").kendoComboBox({
			dataTextField: "marca",
			dataValueField: "idMarca",
			autoBind: false,
			placeholder: "Seleccione Marca",
			dataSource: {
				transport: {
					read: { url: strInterOpAs("clsMarca", "lista", "Core"), dataType: "json", type: "post" }
				},
				sort: { field: "marca", dir: "asc" },
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			}
		});

		$("#btnMarcaAgregar").kendoButton({ icon: "arrow-s", click:
			function (e) {

			}
		});


		var dsMarca = new kendo.data.DataSource({
			transport: { read: { url: strInterOp("Matriz", "lista"), dataType: "json", type: "post"} },
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});

		$("#gridMarca").kendoGrid({
			dataSource: dsMarca,
			pageable: true,
			height: 300,
			autoBind: false,
			resizable: true,
			columns: [
				cmdGrid,
				{ field: "idResponsabilidad", hidden: true },
				{ field: "idMarca", hidden: true },
				{ field: "marca", title: "Marca", width: "200px" }
			]
		}).data("kendoGrid");


		// #endregion

		// #region Matriz Categoria

		$("#cmbCategoria").kendoComboBox({
			dataTextField: "categoria",
			dataValueField: "idCategoria",
			autoBind: false,
			placeholder: "Seleccione Categoria",
			dataSource: {
				transport: {read: { url: strInterOpAs("clsCategoria", "lista", "Core"), dataType: "json", type: "post" }},
				sort: { field: "marca", dir: "asc" },
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			}
		});

		$("#btnCategoriaAgregar").kendoButton({ icon: "arrow-s", click:
			function (e) {

			}
		});

		var dsCategoria = new kendo.data.DataSource({
			transport: { read: { url: strInterOp("Matriz", "lista"), dataType: "json", type: "post"} },
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});

		$("#gridCategoria").kendoGrid({
			dataSource: dsCategoria,
			pageable: true,
			height: 300,
			autoBind: false,
			resizable: true,
			columns: [
				cmdGrid,
				{ field: "idResponsabilidad", hidden: true },
				{ field: "idCategoria", hidden: true },
				{ field: "categoria", title: "Categoria", width: "200px" }
			]
		}).data("kendoGrid");

		// #endregion

		// #region Matriz Cadena

		$("#cmbCadena").kendoComboBox({
			dataTextField: "cadena",
			dataValueField: "idCadena",
			autoBind: false,
			placeholder: "Seleccione Cadena",
			dataSource: {
				transport: { read: { url: strInterOpAs("clsCadena", "lista", "Core"), dataType: "json", type: "post"} },
				sort: { field: "cadena", dir: "asc" },
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			}
		});

		$("#btnCadenaAgregar").kendoButton({ icon: "arrow-s", click:
			function (e) {

			}
		});

		var dsCadena = new kendo.data.DataSource({
			transport: { read: { url: strInterOp("Matriz", "lista"), dataType: "json", type: "post"} },
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});

		$("#gridCadena").kendoGrid({
			dataSource: dsCadena,
			pageable: true,
			height: 300,
			autoBind: false,
			resizable: true,
			columns: [
				cmdGrid,
				{ field: "idResponsabilidad", hidden: true },
				{ field: "idCadena", hidden: true },
				{ field: "cadena", title: "Cadena", width: "200px" }
			]
		}).data("kendoGrid");

		// #endregion


		//$("#findRol").hide();
		//$("#findResponsabilidad").hide();
		
		
		$("#tabView").kendoTabStrip({
			animation: {
				close: {duration: 0,effects: "fadeOut"},
				open: {duration: 0,effects: "fadeIn"}
			}
			
		});
	});
	
</script>
</asp:Content>
