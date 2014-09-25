<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Core.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="msgPagina">
<button id="button" type="button">Agregar Nueva Actividad</button>
</div>
<div id="Flujos"></div>
<div id="winNewRequest">Espere Mientras se actualizan los datos</div>

<script>
    var ds = new kendo.data.DataSource({
        transport: {
            read: { url: strInterOpAs("clsActividad2", "lista", "Coordinador"), dataType: "json", type: "POST" },
            parameterMap: function (options, operation) {
                if (operation !== "read" && options.models) {
                    return { "txtidTree": options.models[0].idFlujo,
                        "txtFlujo": options.models[0].Flujo,
                        "txtGrupo": options.models[0].Grupo,
                        "txtDuracion": options.models[0].duracion,
                        "txtMedida": options.models[0].medida

                    }
                }
                else {
                    return options;
                };
            }
        },
        schema: {
            model: {
                id: "idTree",
                hasChildren: "Actividad"
            }
        }
    });



    $(document).ready(function () {
       

        $("#button").kendoButton({ icon: "plus", click: function (e) {
            $("#winNewRequest").data("kendoWindow").center().open();
        }
    });

         $("#Flujos").kendoTreeView({
                    dataSource: ds,
                    dataTextField: "Actividad"
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