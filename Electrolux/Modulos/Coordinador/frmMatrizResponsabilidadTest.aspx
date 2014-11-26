<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Repuestos.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="trabajo">
	<span style=" font-size: 24px;">Matriz de Responsabilidad</span><br/>
	<table style= "padding-top: 15px; width: 100%" id="layerSeguimiento">
		<tr>
			<td colspan="2" >
				<span style=" font-size: 11px;">Prfiles Actuales</span>
			</td>
		</tr>
		<tr>
			<td style="width:250px;vertical-align: top" > <div id="treeview"></div></td>
			<td style=" vertical-align: top; border-left: 1px dashed #EEEEEE"> 
				<table width="100%" id="tabLebel">
					<td colspan="2">
						 <span id ="lbltitulo" style=" font-size: 14px; font-weight: bold">Información del Usuario Asignado</span>
					</td>
					<tr>
						<td style="width:150px">Usuario Asignado : </td>
						<td><div id="lblUsuario"></div></td>
					</tr>
					<tr>
						<td style="width:150px">Fecha Asignación : </td>
						<td><div id="lblAsignacion"></div></td>
					</tr>
					<tr>
						<td style="width:150px">eMail : </td>
						<td><div id="lblEmail"></div></td>
					</tr>
					<tr>
						<td style="width:150px">Fono : </td>
						<td><div id="lblFono"></div></td>
					</tr>
					<tr>
						<td colspan="2">
							<div id="tabView">
                                <ul>
			                      	<li class="k-state-active">
			                    		Tienda
			                    	</li>
			                    	<li>
			                    		Marca
			                    	</li>
			                    	<li>
			                    		Linea
			                    	</li>
			                    </ul>
                                
                                <div class="variable1">
                                Seleccione: <input id='cmb1'  name='cmb1'   validationMessage='Debe ingresar un tipo' required />
					                <!-- Grilla 1 -->
					                <div id="grid1" style="height: 380px"></div>
				                </div>
                                <div class="variable2">
					                Seleccione: <input id='cmb2'  name='cmb2'   validationMessage='Debe ingresar un tipo' required />
                                    <!-- Grilla 2 -->
					                <div id="grid2" style="height: 380px"></div>
				                </div>
                                <div class="variable3">
                                Seleccione : <input id='cmb3'  name='cmb3'   validationMessage='Debe ingresar un tipo' required />
					                <!-- Grilla 3 -->
					            <div id="grid3" style="height: 380px"></div>
				                </div>
                            </div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>


<script>
	$(document).ready(function () {
		// ############################################################
		// ###	Variables                							###
		// ############################################################

		var rol = new Array();
		var matriz = new Array();
		var rols

		// ############################################################
		// ###	Funciones     							            ###
		// ############################################################

		// ###	Funcion encargada de cargar label del perfil selecionado ###

		function cargaDatos(data) {
			document.getElementById("tabLebel").style.display = 'block';
			$("#lblUsuario").html("<strong>" + data[0].usuario + "</strong>");
			$("#lblAsignacion").html("<strong>" + data[0].asignacion + "</strong>");
			$("#lblEmail").html("<strong>" + data[0].eMail + "</strong>");
			$("#lblFono").html("<strong>" + data[0].fono + "</strong>");
		}

		// ###	Funcion encargada de cargar treeview con  los perfiles ###

		function onChargerPerfil(e) {
			rol = e;
			inline = new kendo.data.HierarchicalDataSource({
				data: rol,
				schema: {
					model: {
						children: "subNombre"
					}
				}
			});

			$("#treeview").kendoTreeView({
				dataSource: inline,
				dataTextField: ["ROL", "NOMBRE"],
				select: onSelect
			});
		}

		// ###	Funcion al selecionar un perfil ###

		function onSelect(e) {
			rols = this.text(e.node);
			callScript(strInterOp('clsMatrizResponsabilidad', 'ListarMatriz'), 'txtTipo=' + rols, cargaDatos);
			dscmbVariable1.read({ "idvariable": 1, "idRol": rols });
			dscmbVariable2.read({ "idvariable": 2, "idRol": rols });
			dscmbVariable3.read({ "idvariable": 3, "idRol": rols });
		}

		// ###	Funcions encargada de cargar combobox  al agregar ###


		function nombreTienda(container, options) {
			$('<input data-bind="value:' + options.field + '", value:"' + options.field + '"/>')
			.appendTo(container)
			.kendoDropDownList({
				autoBind: false,
				optionLabel: "Seleccione Tienda",
				dataTextField: "tienda",
				dataValueField: "variable",
				filter: "contains",
				change: function onChange(e) {
					$("#datosConcesion").hide();
					var dtCombo = e.sender;
					var idxCombo = dtCombo.selectedIndex;
				},
				dataSource: {
					type: "json",
					serverFiltering: true,
					transport: { read: { url: strInterOp('clsMatrizResponsabilidad', 'listacmbTiendas')} },
					schema: { data: "args" }
				}
			})
		};


		function nombreMarca(container, options) {
			$('<input data-bind="value:' + options.field + '", value:"' + options.field + '"/>')
			.appendTo(container)
			.kendoDropDownList({
				autoBind: false,
				optionLabel: "Seleccione marca...",
				dataTextField: "marca",
				dataValueField: "variable",
				filter: "contains",
				change: function onChange(e) {
					$("#datosConcesion").hide();
					var dtCombo = e.sender;
					var idxCombo = dtCombo.selectedIndex;
				},
				dataSource: {
					type: "json",
					serverFiltering: true,
					transport: { read: { url: strInterOp('clsMatrizResponsabilidad', 'listacmbMarcas')} },
					schema: { data: "args" }
				}
			})
		};


		function nombreLinea(container, options) {
			$('<input data-bind="value:' + options.field + '", value:"' + options.field + '"/>')
			.appendTo(container)
			.kendoDropDownList({
				autoBind: false,
				optionLabel: "Seleccione una Tienda...",
				dataTextField: "linea",
				dataValueField: "variable",
				filter: "contains",
				change: function onChange(e) {
					$("#datosConcesion").hide();
					var dtCombo = e.sender;
					var idxCombo = dtCombo.selectedIndex;
				},
				dataSource: {
					type: "json",
					serverFiltering: true,
					transport: { read: { url: strInterOp('clsMatrizResponsabilidad', 'listacmbLineas')} },
					schema: { data: "args" }
				}
			})
		};

		function nombreEstado(container, options) {
			$('<input   data-bind="value:' + options.field + '"/>')
				.appendTo(container)
				.kendoDropDownList({
					optionLabel: "Seleccione un estado...",
					dataTextField: "text",
					dataValueField: "value",
					dataSource: [
						{ text: "En Espera", value: "0" },
						{ text: "Ejecutada", value: "1" }
					]
				});
		};

		// ############################################################
		// ###	DataSource              					        ###
		// ############################################################

		var dsVariable1 = new kendo.data.DataSource({
			transport: {
				read: { url: strInterOpAs("clsMatrizResponsabilidad", "ListarVariable", "Coordinador"), dataType: "json", type: "POST" },
				destroy: { url: strInterOpAs("clsMatrizResponsabilidad", "eliminar", "Coordinador"), dataType: "json", type: "POST" },
				create: { url: strInterOpAs("clsMatrizResponsabilidad", "insertar", "Coordinador"), dataType: "json", type: "POST" },
				parameterMap: function (options, operation) {
					if (operation !== "read" && options.models) {
						return {
							"txtidresponsabilidad": options.models[0].idResponsabilidad,
							"txtidTabVariable": options.models[0].variable,
							"txtidRol": rols,
							"txtestado": options.models[0].estado,
							"txtvalorInt": options.models[0].valorInt,
							"txtvalorChar": options.models[0].valorChar,
							"txtidVariable": 1
						};
					}
					else {
						return options;
					}
				}
			},
			batch: true,
			resizable: true,
			error: errorGrid,
			serverPaging: true,
			pageSize: 50,
			schema: {
				errors: "msgState",
				data: "args",
				total: "totalFila",
				model: {
					id: "idResponsabilidad",
					fields: {
						idResponsabilidad: { editable: false, nullable: true },
						variable: { editable: true, nullable: false },
						Rol: { editable: false, validation: { required: true, message: "malo" }, nullable: false },
						estado: { editable: true, nullable: false, validation: { required: true, message: "malo"} },
						valorInt: { editable: true, nullable: true },
						valorChar: { editable: true, nullable: true }
					}
				}
			}
		});

		var dsVariable2 = new kendo.data.DataSource({
			transport: {
				read: { url: strInterOpAs("clsMatrizResponsabilidad", "ListarVariable", "Coordinador"), dataType: "json", type: "POST" },
				destroy: { url: strInterOpAs("clsMatrizResponsabilidad", "eliminar", "Coordinador"), dataType: "json", type: "POST" },
				create: { url: strInterOpAs("clsMatrizResponsabilidad", "insertar", "Coordinador"), dataType: "json", type: "POST" },
				parameterMap: function (options, operation) {
					if (operation !== "read" && options.models) {
						return {
							"txtidresponsabilidad": options.models[0].idResponsabilidad,
							"txtidTabVariable": options.models[0].variable,
							"txtidRol": rols,
							"txtestado": options.models[0].estado,
							"txtvalorInt": options.models[0].valorInt,
							"txtvalorChar": options.models[0].valorChar,
							"txtidVariable": 2
						};
					}
					else {
						return options;
					}
				}
			},
			batch: true,
			resizable: true,
			error: errorGrid,
			serverPaging: true,
			pageSize: 50,
			schema: {
				errors: "msgState",
				data: "args",
				total: "totalFila",
				model: {
					id: "idResponsabilidad",
					fields: {
						idResponsabilidad: { editable: false, nullable: true },
						variable: { editable: true, nullable: false },
						Rol: { editable: false, validation: { required: true, message: "malo" }, nullable: false },
						estado: { editable: true, nullable: false, validation: { required: true, message: "malo"} },
						valorInt: { editable: true, nullable: true },
						valorChar: { editable: true, nullable: true }
					}
				}
			}
		});


		var dsVariable3 = new kendo.data.DataSource({
			transport: {
				read: { url: strInterOpAs("clsMatrizResponsabilidad", "ListarVariable", "Coordinador"), dataType: "json", type: "POST" },
				destroy: { url: strInterOpAs("clsMatrizResponsabilidad", "eliminar", "Coordinador"), dataType: "json", type: "POST" },
				create: { url: strInterOpAs("clsMatrizResponsabilidad", "insertar", "Coordinador"), dataType: "json", type: "POST" },
				parameterMap: function (options, operation) {
					if (operation !== "read" && options.models) {
						return {
							"txtidresponsabilidad": options.models[0].idResponsabilidad,
							"txtidTabVariable": options.models[0].variable,
							"txtidRol": rols,
							"txtestado": options.models[0].estado,
							"txtvalorInt": options.models[0].valorInt,
							"txtvalorChar": options.models[0].valorChar,
							"txtidVariable": 3
						};
					}
					else {
						return options;
					}
				}
			},
			batch: true,
			resizable: true,
			error: errorGrid,
			serverPaging: true,
			pageSize: 50,
			schema: {
				errors: "msgState",
				data: "args",
				total: "totalFila",
				model: {
					id: "idResponsabilidad",
					fields: {
						idResponsabilidad: { editable: false, nullable: true },
						variable: { editable: true, nullable: false },
						Rol: { editable: false, validation: { required: true, message: "malo" }, nullable: false },
						estado: { editable: true, nullable: false, validation: { required: true, message: "malo"} },
						valorInt: { editable: true, nullable: true },
						valorChar: { editable: true, nullable: true }
					}
				}
			}
		});

		var dscmbVariable1 = new kendo.data.DataSource({
			serverFiltering: true,
			transport: {
				read: { url: strInterOpAs("clsMatrizResponsabilidad", "ListarcmbVariable", "Coordinador"), dataType: "json", type: "post" }
			},
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});

		var dscmbVariable2 = new kendo.data.DataSource({
			serverFiltering: true,
			transport: {
				read: { url: strInterOpAs("clsMatrizResponsabilidad", "ListarcmbVariable", "Coordinador"), dataType: "json", type: "post" }
			},
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});

		var dscmbVariable3 = new kendo.data.DataSource({
			serverFiltering: true,
			transport: {
				read: { url: strInterOpAs("clsMatrizResponsabilidad", "ListarcmbVariable", "Coordinador"), dataType: "json", type: "post" }
			},
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});

		// ############################################################
		// ###	OBJETOS KENDO             							###
		// ############################################################

		// TabStrit##

		var tabStrip = $("#tabView").kendoTabStrip().data("kendoTabStrip");

		// Grillas##

		var grid1 = $("#grid1").kendoGrid({
			dataSource: dsVariable1,
			height: 350,
			pageable: true,
			autoBind: false,
			filterable: filtroGrid,
			toolbar: [{ text: "Agregar", name: "create"}],
			editable: {
				mode: "inline",
				confirmation: "¿Está seguro que desea borrar el registro?"
			},
			resizable: true,
			columns: [
                        cmdGrid,
						{ field: "idResponsabilidad", title: "id", width: "20px" },
                        { field: "variable", title: "Tienda", width: "100px", editor: nombreTienda },
                        { field: "Rol", title: "Rol", width: "100px" },
                        { field: "estado", title: "Estado", width: "80px", editor: nombreEstado },
						{ field: "valorInt", title: "Valor Int", width: "20px" },
						{ field: "valorChar", title: "Valor Char", width: "100px" }
					]
		}).data("kendoGrid");

		var grid2 = $("#grid2").kendoGrid({
			dataSource: dsVariable2,
			height: 350,
			pageable: true,
			autoBind: false,
			filterable: filtroGrid,
			toolbar: [{ text: "Agregar", name: "create"}],
			editable: {
				mode: "inline",
				confirmation: "¿Está seguro que desea borrar el registro?"
			},
			resizable: true,
			columns: [
                        cmdGrid,
						{ field: "idResponsabilidad", title: "id", width: "20px" },
                        { field: "variable", title: "Marca", width: "100px", editor: nombreMarca },
                        { field: "Rol", title: "Rol", width: "100px" },
                        { field: "estado", title: "Estado", width: "80px", editor: nombreEstado },
						{ field: "valorInt", title: "Valor Int", width: "20px" },
						{ field: "valorChar", title: "Valor Char", width: "100px" }
					]
		}).data("kendoGrid");

		var grid3 = $("#grid3").kendoGrid({
			dataSource: dsVariable3,
			height: 350,
			pageable: true,
			autoBind: false,
			filterable: filtroGrid,
			toolbar: [{ text: "Agregar", name: "create"}],
			editable: {
				mode: "inline",
				confirmation: "¿Está seguro que desea borrar el registro?"
			},
			resizable: true,
			columns: [
                        cmdGrid,
						{ field: "idResponsabilidad", title: "id", width: "20px" },
                        { field: "variable", title: "Linea", width: "100px", editor: nombreLinea },
                        { field: "Rol", title: "Rol", width: "100px" },
                        { field: "estado", title: "Estado", width: "80px", editor: nombreEstado },
						{ field: "valorInt", title: "Valor Int", width: "20px" },
						{ field: "valorChar", title: "Valor Char", width: "100px" }
					]
		}).data("kendoGrid");

		// Combobox##

		$("#cmb1").kendoDropDownList({
			optionLabel: "Seleccione una Tienda...",
			dataSource: dscmbVariable1,
			dataTextField: "TIPO",
			dataValueField: "TIP",
			change: function (e) {
				if ($("#cmb1").val() == "")
					alert("Selecione Una Tienda");
				else {
					dsVariable1.read({ idVar: $("#cmb1").val(), idVariable: 1, idRol: rols });
				}
			},
			autoBind: false
		});

		$("#cmb2").kendoDropDownList({
			optionLabel: "Seleccione una marca...",
			dataSource: dscmbVariable2,
			dataTextField: "TIPO",
			dataValueField: "TIP",
			change: function (e) {
				if ($("#cmb2").val() == "")
					alert("Selecione Una Marca");
				else {
					dsVariable2.read({ idVariable: 2, idRol: rols, idVar: $("#cmb2").val() });
				}
			},
			autoBind: false
		});

		$("#cmb3").kendoDropDownList({
			optionLabel: "Seleccione una linea...",
			dataSource: dscmbVariable3,
			dataTextField: "TIPO",
			dataValueField: "TIP",
			change: function (e) {
				if ($("#cmb3").val() == "")
					alert("Selecione Una Linea");
				else {
					dsVariable3.read({ idVariable: 3, idRol: rols, idVar: $("#cmb3").val() });
				}
			},
			autoBind: false
		});

		// ############################################################
		// ###	Flujo Script             							###
		// ############################################################

		document.getElementById("tabLebel").style.display = 'none';
		callScript(strInterOp("clsMatrizResponsabilidad", "ListarPerfilRol"), '', onChargerPerfil);


	});
</script>
<style>
		.areaTrabajo table td{
 		font-size: 11px;
 		border-bottom: 1px dashed #EEEEEE;
 		padding-bottom:5px;
 		
 		}
 	
</style>
</asp:Content>
