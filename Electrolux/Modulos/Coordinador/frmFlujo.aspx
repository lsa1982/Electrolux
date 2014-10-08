<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Core.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="trabajo">
	<span style=" font-size: 24px;">Diagrama de Flujos de Trabajo</span><br/>
	<table style= "padding-top: 15px; width: 100%" id="layerSeguimiento">
		<tr>
			<td colspan="2">
				<span style=" font-size: 11px;">Detalle del requerimiento solicitado:</span>

            </td>
		</tr>
	</table>
    
</div>
<canvas id="gitGraph"></canvas>

<div id="grid" style="height: 200px"></div>

<script src="<% = resolveClientUrl("~/Kendo/gitgraph.js") %>" type="text/javascript"></script>

<script>
    $(document).ready(function () {
        var wfMatriz = [];
        function onClick(c) {
            if (c instanceof Object) {
                alert(c.message);
            }
        }
        function onRefresh(e) {
            wfMatriz = e
            var index;
            for (index = 0; index < wfMatriz.length; ++index) {
                gitGraph.creaNodo(wfMatriz[index]);
            };
        };

        callScript(strInterOp("clsGrafo", "lista"), '', onRefresh);

        var gitGraph = new GitGraph({ click: onClick });



        var dsFlujos = new kendo.data.DataSource({
            transport: {
                read: { url: strInterOp("", "lista"), dataType: "json", type: 'POST' },
                destroy: { url: strInterOp("Requerimiento", "eliminar"), dataType: "json", type: 'POST' },
                parameterMap: function (data, type) {
                    if (type == "destroy") {
                        return { idRequerimiento: data.models[0].idRequerimiento }
                    }
                    if (type == "read") {
                        return { idRequerimiento: data.idRequerimiento }
                    }
                }
            },
            change: function (e) {
                if (e.action != "remove") {
                    if (this._data.length > 0) {
                        var data = this.data();
                        cargaDatos(data, data[0].idRequerimiento);
                    }
                }
            },
            batch: true,
            resizable: true,
            error: errorGrid,

            schema: { errors: "msgState", data: "args", total: "totalFila", model: { id: "idRequerimiento"} }
        });

    });


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
                    idActividad: { type:"number" },
                    idRol: { type:"number" },
                    ROL: { type:"string" },
                    Flujo: { type:"string" },
                    idFlujo: { type:"number" },
                    actividad: { type:"string" },
                    duracion: { type:"number" },
                    medida: { type:"string" },
                    orden: { type:"number" },

                }
            }
        }
    });

var gridColumns = [
                { field: "idActividad", title: "ID", width: "40px" },
                { field: "ROL", title: "Rol", width: "110px" },
                { field: "Flujo", title: "Flujo", width: "120px" },
                { field: "actividad", title: "Actividad", width: "100px" },
                { field: "duracion", title: "Duracion", width: "80px" },
                { field: "medida", title: "Medida", width: "80px" },
                { field: "orden", title: "Orden", width: "80px" }
                ];

        $("#grid").kendoGrid({
            dataSource: ds,
            sortable: true,
            resizable: true,
            height: 220,
            columns: gridColumns,
        
        });












</script>

<style>
	
 	.areaTrabajo table td{
 		overflow:hidden;
 		font-size: 11px;
 		border-bottom: 1px dashed #EEEEEE;
 		padding-bottom:5px;
 		
 		}
 		
 		#grid{
 		width:62%;
 		float:right;
 		}
 		
 	
</style>
</asp:Content>
