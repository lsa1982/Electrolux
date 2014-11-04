<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Core.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="trabajo">
	<span style=" font-size: 24px;">Diagrama de Flujos de Trabajo</span><br/>
    <table>
     <tr>
			<td>Ingrese número de requerimiento a buscar</td>
			<td><input id="txtIdFlujo" type="text" /></td>
			<td><button id="btnBuscar" type="button" class="k-button">Buscar </button></td>
            <td><button id="btnNactividad" type="button"  class="k-button">Agregar Nueva Actividad</button></td>
            <td><button id="btnNdependencia" type="button"  class="k-button">Agregar Nueva Dependencia</button></td>
            <td><button id="btnNflujo" type="button"  class="k-button">Agregar Nuevo Flujo</button></td>
	</tr>
    </table>
    <table style= "padding-top: 15px; width: 100%" id="layerNotFound">
		<tr>
			<td colspan="2">
				<span style=" font-size: 11px;">No se encuentran flujo con identificador ingresado.</span>
			</td>
		</tr>
	</table>

	<table style= "padding-top: 15px; width: 100%" id="layerFlujo">
        <tr colspan="2">
				<span style=" font-size: 15px;">Detalle del Flujo solicitado:</span>
        </tr>

       <tr>
       
          <td style="width:50% ; vertical-align: baseline">
            <canvas id="gitGraph"></canvas>
          </td>

         <td>
                     <table style="width:100%">
                <tr>
			        <td style=" width: 150px" >Id FLujo</td>
			        <td ><div id="lblidFlujo"></div>  </td>
		        </tr>
                <tr>
			        <td>FLujo</td>
			        <td ><div id="lblFlujo"></div>  </td>
		        </tr>
                <tr>
			         <td>Grupo</td>
			        <td ><div id="lblGrupo"></div>  </td>
		        </tr>
                 <tr>
			           <td>Duracion</td>
			           <td ><div id="lblDuracion"></div>  </td>
		        </tr>
                <tr>
			          <td>Medida</td>
			            <td ><div id="lblMedida"></div>  </td>
		        </tr>                
               <tr>
                <td colspan="2">
                    <div  id="grid"></div>
                </td>
                </tr>
               <tr>
                    <td>
                   <div id="tabstrip">
                        <ul>
                            <li class="k-state-active">
                            Dependencias
                            </li>
                            <li>
                            Padres
                            </li>
                        </ul>
                        <div>
                            <div id = "gridDependencia"></div>
                        </div>
                        <div>
						    <div  id="gridPadre"></div>
                        </div>
                    </div>
                   </td>
               </tr>
            
           
            </table>


         </td>
       
       </tr>

    </table>
</div>

<script src="<% = resolveClientUrl("~/Kendo/gitgraph.js") %>" type="text/javascript"></script>
<div id="winNewRequest">Espere Mientras se actualizan los datos</div>
<div id="Ndependencia">Espere Mientras se actualizan los datos</div>
<div id="Nflujo">Espere Mientras se actualizan los datos</div>
<script>
	$(document).ready(function () {

		var idFlujo = 0;
		var gitGraph = new GitGraph({ click: onClick });

		var dMatriz = [];
		var wfMatriz = [];

		function onClick(c) {
			if (c instanceof Object) {
				dsD.read({ "txtidActividad": c.idActividad });
				$("#gridDependencia").show();
				$("#gridPadre").show();
			}
		};

		function onRefresh(e) {
			wfMatriz = e
			var index;
			for (index = 0; index < wfMatriz.length; ++index) {
				gitGraph.creaNodo(wfMatriz[index]);
			}
			gitGraph.render();
		};


		$("#btnBuscar").kendoButton({ click: onFind, icon: "search" });

		function onFind(e) {

			idFlujo = txtIdFlujo.value;
			ds.read({ "txtidFlujo": idFlujo });
			callScript(strInterOp("clsGrafo", "lista"), 'idFlujo=' + idFlujo, onRefresh);
			callScript(strInterOp("clsFlujo", "lista2"), 'idFlujo=' + idFlujo, cargaDatos);
			//$("#grid").show(500);
			$("#layerFlujo").show(500);
		}




		var dsFlujos = new kendo.data.DataSource({
			transport: {
				read: { url: strInterOp("clsFlujo", "lista"), dataType: "json", type: 'POST' },
				destroy: { url: strInterOp("clsFlujo", "eliminar"), dataType: "json", type: 'POST' },
				parameterMap: function (data, type) {
					if (type == "destroy") {
						return { idFlujo: data.models[0].idFlujo }
					}
					if (type == "read") {
						return { idFlujo: data.idFlujo }
					}
				}
			},
			change: function (e) {
				if (e.action != "remove") {
					if (this._data.length > 0) {
						var data = this.data();
						cargaDatos(data, data[0].idFlujo);
					}
				}
			},
			batch: true,
			resizable: true,
			error: errorGrid,

			schema: { errors: "msgState", data: "args", total: "totalFila", model: { id: "idFlujo"} }
		});

	});
	// ############################################################
	// ###	Grid Actividades        							###
	// ############################################################

	var ds = new kendo.data.DataSource({
		transport: {
			read: { url: strInterOpAs("clsActividad", "lista", "Coordinador"), dataType: "json", type: "POST" },
			destroy: { url: strInterOpAs("clsActividad", "eliminar", "Coordinador"), dataType: "json", type: "POST" },
			update: { url: strInterOpAs("clsActividad", "editar", "Coordinador"), dataType: "json", type: "POST" },
			create: { url: strInterOpAs("clsActividad", "insertar", "Coordinador"), dataType: "json", type: "POST" },
			parameterMap: function (options, operation) {
				if (operation !== "read" && options.models) {
					return { "txtidActividad": options.models[0].idActividad,
						"txtidRol": options.models[0].idRol,
						"txtidFlujo": options.models[0].idFlujo,
						"txtActividad": options.models[0].actividad,
						"txtDuracion": options.models[0].duracion,
						"txtMedida": options.models[0].medida,
						"txtOrden": options.models[0].orden
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
		serverFiltering: true,
		pageSize: 30,
		schema: {
			errors: "msgState",
			data: "args",
			total: "totalFila",
			model: {
				fields: {
					idActividad: { type: "number" },
					idRol: { type: "number" },
					ROL: { type: "string" },
					Flujo: { type: "string" },
					idFlujo: { type: "number" },
					actividad: { type: "string" },
					duracion: { type: "number" },
					medida: { type: "string" },
					orden: { type: "number" }

				}
			}
		}
	});

	var gridColumns = [
                { field: "ROL", title: "Rol", width: "80px" },
                { field: "actividad", title: "Actividad", width: "200px" },
                { field: "duracion", title: "Duracion", width: "80px" },
                { field: "medida", title: "Medida", width: "80px" },
				{ field: "", title: "" }
                ];

	$("#grid").kendoGrid({
		dataSource: ds,
		sortable: true,
		resizable: true,
		height: 220,
		width: 200,
		columns: gridColumns,
		scrollable: true
	});


	// ############################################################
	// ###	Grid Dependencia        							###
	// ############################################################

	var dsD = new kendo.data.DataSource({
		transport: {
			read: { url: strInterOpAs("clsDependencia", "listaActividad", "Coordinador"), dataType: "json", type: "POST" },
			parameterMap: function (options, operation) {
				if (operation !== "read" && options.models) {
					return { "txtidActividad": options.models[0].idActividad,
						"txtActividad": options.models[0].idRol,
						"txtFinalizacion": options.models[0].idFlujo,
						"txtActividadSiguiente": options.models[0].actividadSiguiente
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
		serverFiltering: true,
		pageSize: 30,
		schema: {
			errors: "msgState",
			data: "args",
			total: "totalFila",
			model: {
				fields: {
					idActividad: { type: "number" },
					actividad: { type: "string" },
					Finalizacion: { type: "string" },
					actividadSiguiente: { type: "string" }
				}
			}
		}
	});

	var gridColumnsD = [
                { field: "actividad", title: "Actividad", width: "80px" },
                { field: "Finalizacion", title: "Finalizacion", width: "80px" },
                { field: "actividadSiguiente", title: "AS", width: "80px" },
				{ field: "", title: "" }
                ];

	$("#gridDependencia").kendoGrid({
		dataSource: dsD,
		sortable: true,
		resizable: true,
		height: 220,
		width: 200,
		columns: gridColumnsD,
		scrollable: true
	});


	var gridColumnsP = [
                { field: "actividad", title: "Actividad", width: "80px" },
                { field: "Finalizacion", title: "Finalizacion", width: "80px" },
                { field: "actividadSiguiente", title: "AS", width: "80px" },
				{ field: "", title: "" }
                ];

	$("#gridPadre").kendoGrid({
		dataSource: dsD,
		sortable: true,
		resizable: true,
		height: 220,
		width: 200,
		columns: gridColumnsP,
		scrollable: true
	});







	function cargaDatos(data) {

		$("#lblidFlujo").html("<strong>" + data[0].idFlujo + "</strong>");
		$("#lblFlujo").html("<strong>" + data[0].Flujo + "</strong>");
		$("#lblGrupo").html("<strong>" + data[0].Grupo + "</strong>");
		$("#lblDuracion").html("<strong>" + data[0].duracion + "</strong>");
		$("#lblMedida").html("<strong>" + data[0].medida + "</strong>");
		//dsFlujo.read({ "idFlujo": idFlujo });
	};

	$("#layerFlujo").hide();
	$("#layerNotFound").hide();

	var vGet = getVarsUrl();


	$("#tabstrip").kendoTabStrip({
		animation: {
			open: {
				effects: "fadeIn"
			}
		}
	});

	$("#btnNactividad").kendoButton({ icon: "plus", click: function (e) {
		$("#winNewRequest").data("kendoWindow").center().open();
	}
	});

	$("#winNewRequest").kendoWindow({
		width: "400px",
		title: "Ingreso Nueva Actividad",
		actions: ["Close"],
		visible: false,
		modal: true,
		content: "frmActividad.html"
	});


	$("#btnNdependencia").kendoButton({ icon: "plus", click: function (e) {
		$("#Ndependencia").data("kendoWindow").center().open();
	}
	});

	$("#Ndependencia").kendoWindow({
		width: "400px",
		title: "Ingreso Nueva Dependencia",
		actions: ["Close"],
		visible: false,
		modal: true,
		content: "frmDependencia.html"
	});



	$("#btnNflujo").kendoButton({ icon: "plus", click: function (e) {
		$("#Nflujo").data("kendoWindow").center().open();
	}
	});

	$("#Nflujo").kendoWindow({
		width: "400px",
		title: "Ingreso Nuevo Flujo",
		actions: ["Close"],
		visible: false,
		modal: true,
		content: "frmIFlujo.html"
	});

	//if (typeof vGet.idFlujo != "undefined") {
	//idFlujo = vGet.idFlujo;
	//dsFlujos.read({ "idFlujo": vGet.idFlujo });
	// }; 

	// var tabStrip = $("#tabView").kendoTabStrip().data("kendoTabStrip");
	//tabStrip.append({ text: "Item 2", content: "holaaa2" });


</script>



<style>
	
 	.areaTrabajo table td{
 		font-size: 11px;
 		border-bottom: 1px dashed #EEEEEE;
 		padding-bottom:5px;
 		
 		}
 		
 	
 	
</style>
</asp:Content>