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
				<div id="lblRol" ></div>
			</td>
		</tr>
		<tr>
			<td style="width: 120px">
				Perfil
			</td>
			<td >
				<div id="lblPerfil" ></div>
			</td>
		</tr>
		<tr >
			<td>
				Descripcion: 
			</td>
			<td>
				<div id="lblDescripcion" ></div>
			</td>
		</tr>
		<tr >
			<td>
				Región: 
			</td>
			<td>
				<div id="lblRegion" ></div>
			</td>
		</tr>
		<tr>
			<td>
				Asignado a : 
			</td>
			<td><input id="lblIdUsuario" type="hidden"" />
				<div id="lblAsignado" ></div>
			</td>
		</tr>
		<tr>
			<td>
				Fono
			</td>
			<td>
				<div id="lblFono" ></div>
			</td>
		</tr>
		<tr>
			<td>
				eMail : 
			</td>
			<td>
				<div id="lblMail" ></div>
			</td>
		</tr>
		<tr>
			<td>
			</td>
			<td>
				<button id="btnAsignaUsuario" class="k-button-red" >Cambiar Usuario</button>
			</td>
		</tr>
		
	</table>
</div>
<div class="areaTrabajo" id="findResponsabilidad"> 
	<table style= "padding-bottom: 10px; width:100%">
		<tr>
			<td colspan="2" >
				<span style=" font-size: 24px;">Responsabilidad</span>
			</td>
		</tr>
		<tr>
			<td colspan="2" >
				<div id="tabView" style=" min-height: 350px">
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
								<td>
									<table>
										<tr>
											<td style=" width: 300px"  >Seleccione Cliente: </td>
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
								</td>
								<td>
									<div id="gridTienda" ></div>
								</td>
							</tr>
						</table>
					</div>
					<div >
						<table>
							<tr>
								<td>
									<table>
										<tr>
											<td style=" width: 300px"  >Seleccione Marca: </td>
										</tr>
										<tr>
											<td><input id='cmbMarca'  /></td>
										</tr>
										<tr>
											<td><button id='btnMarcaAgregar' class="k-button-red" >Agregar</button></td>
										</tr>
									</table>
								</td>
								<td><div id="gridMarca" ></div></td>
							</tr>
						</table>
					</div>
					<div >
						<table>
							<tr>
								<td>
									<table>
										<tr>
											<td style=" width: 300px"  >Seleccione Categoria: </td>
											<td rowspan="7"></td>
										</tr>
										<tr>
											<td><input id='cmbCategoria'  /></td>
										</tr>
										<tr>
											<td><button id='btnCategoriaAgregar' class="k-button-red" >Agregar</button></td>
										</tr>
									</table>
								</td>
								<td><div id="gridCategoria" ></div></td>
							</tr>
						</table>
					</div>
					<div >
						<table>
							<tr>
								<td>
								<table>
									<tr>
										<td style=" width: 300px"  >Seleccione Cadena: </td>
									</tr>
									<tr>
										<td><input id='cmbCadena'  /></td>
									</tr>
									<tr>
										<td><button id='btnCadenaAgregar' class="k-button-red" >Agregar</button></td>
									</tr>
								</table>
								</td>
								<td><div id="gridCadena" ></div></td>
							</tr>
						</table>
					</div>
				</div>
			</td>
		</tr>

	</table>
</div>

<div id="winUsuario">
	
	 <table>
		<tr>
			<td>Rol</td>
			<td><input id="txtRol" style="width: 250px" class="k-textbox" /></td>
		 </tr>
		 <tr>
			<td>Región</td>
			<td><input id="cmbRolRegion" style="width: 250px" /></td>
		 </tr>
		 <tr>
			<td>Perfil</td>
			<td><textarea id="txtRolDescripcion" class="k-textbox" style="width:100%; height:50px" rows="2" ></textarea></td>
		</tr>
		<tr>
			<td colspan="2"><span style=" font-size: 14px; font-weight: bold">Datos de Asignación </span> </td>
		</tr>
		<tr>
			<td>Usuario Asignado actualmente</td>
			<td><div id="lblUsuarioAsignado"></td>
		 </tr>
		<tr>
			<td>Usuario</td>
			<td>
				<input id="txtUsuario" style="width: 250px" />
				<input id="txtIdUsuario" type="hidden" />
			</td>
		 </tr>
		 <tr>
			<td></td>
			<td>
				<button id="btnActualizarRol" class="k-button-red" >Actualizar</button>
			</td>
		 </tr>
	 </table>

</div>

<script>
	$(document).ready(function () {
		var botonEliminarGrid = { command: { text: "Eliminar", click: eliminarDeMatriz }, title: " ", width: "90px" };
		var idRol = 0;

		// #region Windows Usuario
		$("#winUsuario").kendoWindow({
			width: "400px",
			title: "Asignación de Usuario",
			actions: ["Close"],
			visible: false,
			modal: true
		});

		$("#btnAsignaUsuario").kendoButton({ icon: "arrow-n", click:
			function (e) {
				centrarWin("#winUsuario");
				$("#winUsuario").data("kendoWindow").open();
				txtRol.value = $("#lblRol").html();
				cmbRolRegion.value = $("#lblRegion").html();
				txtIdUsuario.value = lblIdUsuario.value;
				txtRolDescripcion.value = $("#lblDescripcion").html();
				$("#cmbRolRegion").data("kendoComboBox").text($("#lblRegion").html());
				$("#lblUsuarioAsignado").html($("#lblAsignado").html());
			}
		});

		$("#txtUsuario").kendoAutoComplete({
			dataTextField: "usuario",
			filter: "contains",
			minLength: 3,
			error: errorGrid,
			select: onSelect,
			template: '<strong>#:data.usuario#</strong> - #:data.nombre# #:data.apellido#',
			dataSource: {
				serverFiltering: true,
				transport: { read: { url: strInterOpAs("clsUsuario", "lista", "Core"), dataType: "json", type: "POST"} },
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			}
		});

		function onSelect(e) {
			var dataItem = this.dataItem(e.item.index());
			txtIdUsuario.value = dataItem.idUsuario;
		}


		$("#cmbRolRegion").kendoComboBox({
			dataTextField: "region",
			dataValueField: "region",
			autoBind: false,
			dataSource: {
				transport: { read: { url: strInterOpAs("Region", "lista", "Core"), dataType: "json", type: "post"} },
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			}
		});

		$("#btnActualizarRol").kendoButton({ icon: "arrow-s", click:
			function (e) {
				var pUrl = [];
				pUrl.push("idRol=" + idRol);
				pUrl.push("idUsuario=" + txtIdUsuario.value);
				pUrl.push("rol=" + txtRol.value);
				pUrl.push("region=" + cmbRolRegion.value);
				pUrl.push("descripcion=" + txtRolDescripcion.value);
				var x = pUrl.join("&");
				callScript(strInterOp("Rol", "actualizar"), '&' + x,
					function (e) {
						dsRolUsuario.read({ "idRol": idRol });
						$("#winUsuario").data("kendoWindow").close();
					})
			}
		});

		// #endregion

		//#region Buscador de Rol
		// ####################################

		$("#btnBuscar").kendoButton({ icon: "arrow-s", click:
			function (e) {
				if (cmbRol.value != "") {
					idRol = cmbRol.value;
					dehabilitarDiv("findPerfil");
					$("#findRol").show(500);
					$("#findResponsabilidad").show();
					dsRolUsuario.read({ "idRol": idRol })
					dsTienda.read({ "idRol": idRol, "variable": "tienda" })
					dsMarca.read({ "idRol": idRol, "variable": "marca" })
					dsCategoria.read({ "idRol": idRol, "variable": "categoria" })
					dsCadena.read({ "idRol": idRol, "variable": "cadena" })
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
					$("#lblRol").html(data.rol);
					$("#lblAsignado").html(data.nombre + ' ' + data.apellido);
					$("#lblFono").html(data.fono);
					$("#lblPerfil").html(data.perfil);
					$("#lblMail").html(data.email);
					$("#lblRegion").html(data.region);
					$("#lblDescripcion").html(data.descripcion);
					lblIdUsuario.value = data.idUsuario;
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
				botonEliminarGrid,
				{ field: "idResponsabilidad", hidden: true },
				{ field: "idTienda", hidden: true },
				{ field: "variable", hidden: true },
				{ field: "tienda", title: "Tienda", width: "200px" },
				{ field: "" }
			]
		}).data("kendoGrid");

		$("#btnTiendaAgregar").kendoButton({ icon: "arrow-s", click:
			function (e) {
				insertaEnMatriz(cmbTienda.value, "tienda", dsTienda);
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
				insertaEnMatriz(cmbMarca.value, "marca", dsMarca);
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
				botonEliminarGrid,
				{ field: "idResponsabilidad", hidden: true },
				{ field: "idMarca", hidden: true },
				{ field: "variable", hidden: true },
				{ field: "marca", title: "Marca", width: "200px" },
				{ field: "" }
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
				transport: { read: { url: strInterOpAs("clsCategoria", "lista", "Core"), dataType: "json", type: "post"} },
				sort: { field: "marca", dir: "asc" },
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			}
		});

		$("#btnCategoriaAgregar").kendoButton({ icon: "arrow-s", click:
			function (e) {
				insertaEnMatriz(cmbCategoria.value, "categoria", dsCategoria);
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
				botonEliminarGrid,
				{ field: "idResponsabilidad", hidden: true },
				{ field: "idCategoria", hidden: true },
				{ field: "variable", hidden: true },
				{ field: "categoria", title: "Categoria", width: "200px" },
				{ field: "" }
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
				insertaEnMatriz(cmbCadena.value, "cadena", dsCadena);
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
			variable: "cadena",
			columns: [
				botonEliminarGrid,
				{ field: "idResponsabilidad", hidden: true },
				{ field: "idCadena", hidden: true },
				{ field: "variable", hidden: true },
				{ field: "cadena", title: "Cadena", width: "200px" },
				{ field: "", title: "" }
			]
		}).data("kendoGrid");

		// #endregion

		// #region Funciones de la matriz
		function eliminarDeMatriz(e) {
			e.preventDefault();
			var dataItem = this.dataItem($(e.currentTarget).closest("tr"));
			var ds = this.dataSource;
			callScript(strInterOp("Matriz", "eliminar"), '&idResponsabilidad=' + dataItem.idResponsabilidad,
			function (e) {
				ds.read({ "idRol": idRol, "variable": dataItem.variable });
			})

		}

		function insertaEnMatriz(strId, strVariable, strDs) {
			var pUrl = [];
			pUrl.push("idRol=" + idRol);
			pUrl.push("id=" + strId);
			pUrl.push("variable=" + strVariable);
			var x = pUrl.join("&");
			callScript(strInterOp("Matriz", "insertar"), '&' + x,
			function (e) {
				strDs.read({ "idRol": idRol, "variable": strVariable });
			})
		}

		// #endregion
		
		// #region Inicio de la aplicacion

		$("#btnVolverPerfil").kendoButton({ icon: "arrow-n", click:
			function (e) {
				habilitarDiv("findPerfil");
				$("#findRol").hide();
				$("#findResponsabilidad").hide();
				$("body, html").animate({ scrollTop: 0 }, 600);
			}
		});
		
		$("#findRol").hide();
		$("#findResponsabilidad").hide();

		$("#tabView").kendoTabStrip({
			animation: {
				close: { duration: 0, effects: "fadeOut" },
				open: { duration: 0, effects: "fadeIn" }
			}

		});
		// #endregion
	});
	
</script>
</asp:Content>
