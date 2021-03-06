﻿<%@ Page Title="" Language="vb" AutoEventWireup="false"  MasterPageFile="~/Core.Master" %>


<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="trabajo">
<table>
	<tr>
    <td><button id="button" type="button">Agregar Nueva Marca</button></td>
    </tr>
</table>
<div id="grid" style="width: 100%;position: absolute"></div>
</div>
<div id="winNewRequest">Espere Mientras se actualizan los datos</div>

<script>
 var ds = new kendo.data.DataSource({
            transport: {
                read: { url: strInterOpAs("clsMarca", "lista", "Core"), dataType: "json", type: "POST" },
                destroy: { url: strInterOpAs("clsMarca", "eliminar", "Core"), dataType: "json" },
                update: { url: strInterOpAs("clsMarca", "editar", "Core"), dataType: "json", type: "POST" },
                create: { url: strInterOpAs("clsMarca", "insertar", "Core"), dataType: "json", type:"POST" },
                parameterMap: function (options, operation) {
                    if (operation !== "read" && options.models) {
                        return { txtidMarca: options.models[0].idMarca,
                            "txtMarca": options.models[0].marca,
                            "txtOrden": options.models[0].orden,
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
                    id: "idMarca",
                    fields: {
                        idMarca: { editable: false, nullable: true },
                        Marca: { validation: { required: true, pattern: "[a-zA-Z \s]{1,}"} },
                        orden: { validation: { required: false} },
                        ultimaModificacion: { editable: false, nullable: true },
                        imagen: { editable: true, nullable: true }

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
			{ field: "idMarca", title: "ID", width: "40px" },
			{ field: "marca", title: "Marca", width: "120px" },
			{ field: "orden", title: "Orden", width: "50px" },
			{ field: "imagen", title: "Imagen", width: "120px" },
            { field: "ultimaModificacion", title: "Ultima Modificacion", width: "150px" },
			];


        $("#grid").kendoGrid({
            dataSource: ds,
            pageable: true,
            height: 550,
            filterable: filtroGrid,
            columns: gridColumns,
            editable: {
                mode: "inline",
                confirmation: "¿Está seguro que desea borrar el registro?"
            }

        });

        $("#winNewRequest").kendoWindow({
			width: "400px",
			title: "Ingreso Nueva Marca",
			actions: ["Close"],
			visible: false,
			modal: true,
			content: "frmMarca.html"
		});

    });
</script>

</asp:Content>

