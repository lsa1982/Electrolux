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
                        "txtidRol": options.models[0].idRol,
                        "txtTienda": options.models[0].tienda,
                        "txtStatus": options.models[0].status,
                        "txtGeo_x": options.models[0].geo_x,
                        "txtGeo_y": options.models[0].geo_y,
                        txtCategoria: options.models[0].categoria,
                        txtultimaModificacion: options.models[0].ultimaModificacion


                    };
                }
            }
        },
        batch: true,
        resizable: true,
        error: errorGrid,
        serverPaging: true,
        pageSize: 100,
        schema: {
            errors: "msgState",
            data: "args",
            total: "totalFila",
            model: {
                id: "idTienda",
                fields: {
                    idCadena: { editable: false, nullable: true },
                    idRol: { validation: { required: true, pattern: "[a-zA-Z \s]{1,}"}}},
                    tienda: { validation: { required: true, pattern: "[a-zA-Z \s]{1,}"} },
                    status: { validation: { required: false} },
                    geo_x: { validation: { required: false} },
                    geo_y: { validation: { required: false} },
                    categoria: { validation: { required: false} },
                    ultimaModificacion: { editable: false, nullable: true }
                    

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
			{ field: "idTienda", title: "ID Tienda", width: "80px" },
            { field: "idCadena", title: "ID Cadena", width: "80px" },
			{ field: "idRol", title: "ID Rol", width: "50px" },
			{ field: "tienda", title: "Tienda", width: "130px" },
			{ field: "status", title: "Status", width: "80px" },
			{ field: "geo_x", title: "geo_x", width: "100px" },
            { field: "geo_y", title: "geo_y", width: "100px" },
            { field: "categoria", title: "categoria", width: "120px" },
			{ field: "ultimaModificacion", title: "Ultima Modificacion", width: "180px" }
			];


        $("#grid").kendoGrid({
            dataSource: ds,
            pageable: true,
            selectable: "single",
            height: 550,
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