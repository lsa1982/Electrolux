<%@ Page Title="" Language="vb" AutoEventWireup="false"  MasterPageFile="~/Core.Master" %>


<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="msgPagina">
	<button id="button" type="button">Agregar Nueva Tienda</button>
</div>
<div id="grid" style="height: 380px"></div>
<div id="winNewRequest">Espere Mientras se actualizan los datos</div>
<script>

 var ds = new kendo.data.DataSource({
        transport: {
            read: { url: strInterOpAs("clsTienda", "lista", "Core"), dataType: "json", type: "POST" },
            destroy: { url: strInterOpAs("clsTienda", "eliminar", "Core"), dataType: "json" },
            update: { url: strInterOpAs("clsTienda", "editar", "Core"), dataType: "json", type: "POST" },
            create: { url: strInterOpAs("clsTienda", "insertar", "Core"), dataType: "json", type: "POST" },
            parameterMap: function (options, operation) {
                if (operation !== "read" && options.models) {
                    return { txtidTienda: options.models[0].idTienda,
                        "txtidCadena": options.models[0].idCadena,
                        "txtTienda": options.models[0].tienda,
                        "txtStatus": options.models[0].status,
                        "txtGeo_x": options.models[0].geo_x,
                        "txtGeo_y": options.models[0].geo_y,
                        "txtCategoria": options.models[0].categoria,
                        "txtultimaModificacion": options.models[0].ultimaModificacion,
                        "txtidCategoria": options.models[0].idCategoria,
                        "txtCadena": options.models[0].cadena,

                    };
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
                id: "idTienda",
                fields: {
                    idTienda: { editable: false, nullable: true },
                    idCadena: { editable: false, nullable: true },
                    cadena:   { editable: false, nullable: true },
                    categoria:{ editable: false, nullable: true },
                    tienda:   { validation: { required: true, pattern: "[a-zA-Z \s]{1,}"} },
                    status:   { validation: { required: false} },
                    geo_x:    { validation: { required: false} },
                    geo_y:    { validation: { required: false} },
                    ultimaModificacion: { editable: false, nullable: true }

                }
            }
        }
    });


    $(document).ready(function () {

       


        $("#button").kendoButton({ icon: "plus", click: function (e) {
            $("#winNewRequest").data("kendoWindow").center().open();
        }
        });




        var gridColumns = [
			cmdGrid,
			{ field: "idTienda", title: "ID", width: "40px" },
            { field: "cadena", title: "Cadena", width: "120px" },
            { field: "categoria", title: "Categoria", width: "120px" },
			{ field: "tienda", title: "Tienda", width: "180px" },
			{ field: "status", title: "Status", width: "80px" },
			{ field: "geo_x", title: "Geo_x", width: "100px" },
            { field: "geo_y", title: "Geo_y", width: "100px" },
			{ field: "ultimaModificacion", title: "Ultima Modificacion", width: "180px" }
			];


        $("#grid").kendoGrid({
            pageable: { pageable: true, pageSizes: [5, 10, 25, 50] },
            dataSource: ds,
            sortable: true,
            filterable: filtroGrid,
            selectable: "multiple",
            resizable: true,
            height: 450,
            columns: gridColumns,
            editable: {
                mode: "inline",
                confirmation: "¿Está seguro que desea borrar el registro?"
            }

        });
        $("#winNewRequest").kendoWindow({
            width: "400px",
            title: "Ingreso Nueva Tienda",
            actions: ["Close"],
            visible: false,
            modal: true,
            content: "frmTienda.html"
        });
    });
</script>

</asp:Content>