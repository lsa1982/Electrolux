<%@ Page Title="" Language="vb" AutoEventWireup="false"  MasterPageFile="~/Core.Master" %>


<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="msgPagina">
	<button id="button" type="button">Agregar Nueva Marca</button>
</div>
<div id="grid" style="height: 380px"></div>

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
                        ultimaModificacion: { editable: true, nullable: true },
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
			{ field: "idMarca", title: "ID Marca", width: "105px" },
			{ field: "marca", title: "Marca", width: "170px" },
			{ field: "orden", title: "Orden", width: "100px" },
			{ field: "imagen", title: "Imagen", width: "180px" },
            { field: "ultimaModificacion", title: "Ultima Modificacion", width: "180px" },
			];


        $("#grid").kendoGrid({
            dataSource: ds,
            pageable: true,
            height: 550,
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

