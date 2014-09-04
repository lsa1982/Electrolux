<%@ Page Title="" Language="vb" AutoEventWireup="false"  MasterPageFile="~/Core.Master" %>


<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="msgPagina">
	<button id="button" type="button">Agregar Nueva Cadena</button>
</div>
<div id="grid" style="height: 380px"></div>
<div id="winNewRequest">Espere Mientras se actualizan los datos</div>
<script>
    var ds = new kendo.data.DataSource({
        transport: {
            read: { url: strInterOpAs("clsCadena", "lista", "Core"), dataType: "json", type: "POST" },
            destroy: { url: strInterOpAs("clsCadena", "eliminar", "Core"), dataType: "json" },
            update: { url: strInterOpAs("clsCadena", "editar", "Core"), dataType: "json", type: "POST" },
            create: { url: strInterOpAs("clsCadena", "insertar", "Core"), dataType: "json", type: "POST" },
            parameterMap: function (options, operation) {
                if (operation !== "read" && options.models) {
                    return { txtidCadena: options.models[0].idCadena,
                        "txtCadena": options.models[0].cadena,
                        "txtRazonSocial": options.models[0].razonSocial,
                        "txtRut": options.models[0].rut,
                        "txtEstado": options.models[0].estado,
                        txtultimaModificacion: options.models[0].ultimaModificacion,
                        "txtImagen": options.models[0].imagen
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
                id: "idCadena",
                fields: {
                    idCadena: { editable: false, nullable: true },
                    cadena: { validation: { required: true, pattern: "[a-zA-Z \s]{1,}"}}
                },
                razonSocial: { validation: { required: true, pattern: "[a-zA-Z \s]{1,}"} },
                rut: { validation: { required: false} },
                estado: { validation: { required: false} },
                ultimaModificacion: { editable: false, nullable: true },
                imagen: { editable: false, nullable: true }

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
			{ field: "idCadena", title: "ID Cadena", width: "105px" },
			{ field: "cadena", title: "Cadena", width: "170px" },
			{ field: "razonSocial", title: "Razón Social", width: "130px" },
			{ field: "rut", title: "Rut", width: "180px" },
			{ field: "estado", title: "Estado", width: "180px" },
			{ field: "imagen", title: "Imagen", width: "120px" },
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
            title: "Ingreso Nueva Categoria",
            actions: ["Close"],
            visible: false,
            modal: true,
            content: "frmCadena.html"
        });
    });
</script>

</asp:Content>