<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Core.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="msgPagina">
<button id="button" type="button">Agregar Nuevo Flujo</button>
</div>
<div id="grid" style="height: 380px"></div>
<div id="winNewRequest">Espere Mientras se actualizan los datos</div>
<script>
    var ds = new kendo.data.DataSource({
        transport: {
            read: { url: strInterOpAs("clsFlujo", "lista", "Coordinador"), dataType: "json", type: "POST" },
            destroy: { url: strInterOpAs("clsFlujo", "eliminar", "Coordinador"), dataType: "json", type: "POST" },
            update: { url: strInterOpAs("clsFlujo", "editar", "Coordinador"), dataType: "json", type: "POST" },
            create: { url: strInterOpAs("clsFlujo", "insertar", "Coordinador"), dataType: "json", type: "POST" },
            parameterMap: function (options, operation) {
                if (operation !== "read" && options.models) {
                    return { "txtidFlujo": options.models[0].idFlujo,
                        "txtFlujo": options.models[0].Flujo,
                        "txtGrupo": options.models[0].Grupo,
                        "txtDuracion": options.models[0].duracion,
                        "txtMedida": options.models[0].medida
                        
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
                id: "idFlujo",
                fields: {
                    idFlujo: { editable: false, nullable: true },
                    Flujo: { validation: { required: false} },
                    Grupo: { validation: { required: false} },
                    duracion: { validation: { required: false} },
                    medida: { validation: { required: false} }
                   

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
                { field: "idFLujo", title: "ID", width: "40px" },
                { field: "Flujo", title: "Flujo", width: "120px" },
                { field: "Grupo", title: "Grupo", width: "120px" },
                { field: "duracion", title: "Duracion", width: "80px" },
                { field: "medida", title: "Medida", width: "100px" }
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
            title: "Ingreso Nuevo Flujo",
            actions: ["Close"],
            visible: false,
            modal: true,
            content: "frmActividad.html"
        });
    });
</script>
</asp:Content>