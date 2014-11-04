<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Core.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="trabajo">

   <span style=" font-size: 24px;">Seguimiento</span><br/>
   <table>
		<tr >
			<td>Ingrese número de flujo a buscar</td>
			<td><input id="txtIdFlujo" type="text" /></td>
			<td><button id="btnBuscar" type="button" class="k-button">Buscar </button></td>
		</tr>
	</table>
	<table style= "padding-top: 15px; width: 100%" id="layerNotFound">
		<tr>
			<td colspan="2">
				<span style=" font-size: 11px;">No se encuentran requerimientos con identificador ingresado.</span>
			</td>
		</tr>
	</table>

    <span style=" font-size: 24px;">Diagrama de Flujos de Trabajo</span><br/>
    <table style= "padding-top: 15px; width: 100%" id="layerFlujo">
        <tr width= "50%">
            <tr>
            <td colspan="2">
                <span style=" font-size: 11px;">Detalle del flujo solicitado:</span>
            </td>
            </tr>
        
        <tr>
         <td style="width: 150px;float: right;margin-right: 50px" >Id FLujo</td>
         <td ><div id="lblidFlujo"></div> </td>
        </tr>

         <tr>
            <td style="width: 150px;float: right;margin-right: 50px" >FLujo</td>
            <td ><div id="lblFlujo"></div>  </td>
        </tr>
          <tr>
            <td style="width: 150px;float: right;margin-right: 50px" >Grupo</td>
            <td ><div id="lblGrupo"></div>  </td>
        </tr>
         <tr>
            <td style="width: 150px;float: right;margin-right: 50px" >Duracion</td>
            <td ><div id="lblDuracion"></div>  </td>
        </tr>
         <tr>
            <td style="width: 150px;float: right;margin-right: 50px" >Medida</td>
            <td ><div id="lblMedida"></div>  </td>
        </tr>

        <tr>
        <td><div id="grid" style= "float: right ;height: 200px"></div></td>
        </tr>
        </tr>

        <tr width= "50%" align="center">
        <canvas id="gitGraph"></canvas>
        </tr>
       

       

    </table>
 </div>   


<script src="<% = resolveClientUrl("~/Kendo/gitgraph.js") %>" type="text/javascript"></script>


<script>
    $(document).ready(function () {

     var idFlujo = 0;
     var gitGraph = new GitGraph({ click: onClick });

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

        };

        function onRefresh(e) {
            wfMatriz = e
            var index;
            for (index = 0; index < wfMatriz.length; ++index) {
                gitGraph.creaNodo(wfMatriz[index]);
            };

   
        };

       

// ####################################################
// ## Datasource	Flujo   						###
// ####################################################     

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

                        cargaDatos(data, data[0].idFlujo);

                        cargaDatos(data, data[0].idRequerimiento);

                    }
                }
            },
            batch: true,
            resizable: true,
            error: errorGrid,


            schema: { errors: "msgState", data: "args", total: "totalFila", model: { id: "idFlujo"} }
        });

// ####################################################
// ## Datasource + grid       						###
// ####################################################   

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


    $("#btnBuscar").kendoButton({ click: onFind, icon: "search" });
		function onFind(e) {
			idFlujo = txtIdFlujo.value;
            dsFlujos.read({ "idFlujo": vGet.idFlujo });
             callScript(strInterOp("clsGrafo", "lista"), 'idFlujo', onRefresh);
			$("#layerFlujo").show(500);
		}


        function cargaDatos(data, idFlujo) {
           
            $("#lblidFlujo").html("<strong>" + data[0].idFlujo + "</strong>");
            $("#lblFlujo").html("<strong>" + data[0].Flujo + "</strong>");
            $("#lblGrupo").html("<strong>" + data[0].Grupo + "</strong>");
            $("#lblDuracion").html("<strong>" + data[0].duracion + "</strong>");
            $("#lblMedida").html("<strong>" + data[0].medida + "</strong>");
            //dsFlujos.read({ "idFlujo": idFlujo });
           
         };


    $("#layerFlujo").hide();
    $("#layerNotFound").hide();

    var vGet = getVarsUrl();

    if (typeof vGet.idFlujo != "undefined") {
        idFlujo = vGet.idFlujo;
        //dsFlujos.read({ "idFlujo": vGet.idFlujo });
        }; 

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

