<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Core.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="msgPagina">
<button id="button" type="button">Agregar Nueva Actividad</button>
</div>
<div id="grid" style="height: 380px"></div>
<div id="winNewRequest">Espere Mientras se actualizan los datos</div>
<script>
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
                id: "idActividad",
                fields: {
                    idRol: { editable: false, nullable: true },
                    ROL: { editable: false, nullable: true },
                    Flujo: { editable: false, nullable: true },
                    idFlujo: { editable: false, nullable: true },
                    actividad: { validation: { required: false} },
                    duracion: { validation: { required: false} },
                    medida: { validation: { required: false} },
                    oreden: { validation: { required: false} }

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
                { field: "idActividad", title: "ID", width: "40px" },
                { field: "ROL", title: "Rol", width: "120px" },
                { field: "Flujo", title: "Flujo", width: "120px" },
                { field: "actividad", title: "Actividad", width: "100px" },
                { field: "duracion", title: "Duracion", width: "80px" },
                { field: "medida", title: "Medida", width: "100px" },
                { field: "orden", title: "Orden", width: "150px" }
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
            title: "Ingreso Nueva Actividad",
            actions: ["Close"],
            visible: false,
            modal: true,
            content: "frmActividad.html"
        });
    });
</script>
</asp:Content>