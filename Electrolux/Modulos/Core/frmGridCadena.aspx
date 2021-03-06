﻿<%@ Page Title="" Language="vb" AutoEventWireup="false"  MasterPageFile="~/Core.Master" %>


<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="trabajo">
<table>
	<tr>
    <td><button id="button" type="button">Agregar Nueva Cadena</button></td>
    </tr>
</table>
<div id="grid" style="width: 100%;position: absolute"></div>
</div>
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
                        "txtUpload": options.models[0].imagen
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
                cadena: { validation: { required: true, pattern: "[a-zA-Z \s]{1,}"}},
                razonSocial: { validation: { required: true, pattern: "[a-zA-Z \s]{1,}"} },
                rut: { validation: { required: false} },
                estado: { validation: { required: false} },
                ultimaModificacion: { editable: false, nullable: true },
                imagen: { editable: false, nullable: true }

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
			{ field: "idCadena", title: "ID", width: "40px" },
			{ field: "cadena", title: "Cadena", width: "130px" },
			{ field: "razonSocial", title: "Razón Social", width: "100px" },
			{ field: "rut", title: "Rut", width: "120px" },
			{ field: "estado", title: "Estado", width: "80px" },
			{ field: "imagen", title: "Imagen", template: "<img src='images/cadena/#= imagen #' height='50' width='80'/>", width: "80px" },
            { field: "ultimaModificacion", title: "Ultima Modificacion", width: "180px" },
            { field: "", title: "" }
			];


        $("#grid").kendoGrid({
            dataSource: ds,
            pageable: true,
            selectable: "single",
            filterable: filtroGrid,
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