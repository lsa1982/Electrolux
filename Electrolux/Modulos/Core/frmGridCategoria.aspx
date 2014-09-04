<%@ Page Title="" Language="vb" AutoEventWireup="false"  MasterPageFile="~/Core.Master" %>


<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="msgPagina">
	<button id="button" type="button">Agregar Nueva Categoria</button>
</div>
<div id="grid" style="height: 380px"></div>
<div id="winNewRequest">Espere Mientras se actualizan los datos</div>
<script>
  var ds = new kendo.data.DataSource({
            transport: {
                read: { url: strInterOpAs("clsCategoria", "lista", "Core"), dataType: "json", type: "POST" },
                destroy: { url: strInterOpAs("clsCategoria", "eliminar", "Core"), dataType: "json" },
                update: { url: strInterOpAs("clsCategoria", "editar", "Core"), dataType: "json", type: "POST" },
                create: { url: strInterOpAs("clsCategoria", "insertar", "Core"), dataType: "json", type: "POST" },
                parameterMap: function (options, operation) {
                    if (operation !== "read" && options.models) {
                        return { txtidCategoria: options.models[0].idCategoria,
                            "txtCategoria": options.models[0].categoria,
                            "txtPadre": options.models[0].padre,
                            "txtActivo": options.models[0].activo,
                            "txtOrden": options.models[0].orden,
                            "txtTipo": options.models[0].tipo,
                            txtImagen: options.models[0].imagen,
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
                    id: "idCategoria",
                    fields: {
                        idCategoria: { editable: false, nullable: true },
                        categoria: { validation: { required: true, pattern: "[a-zA-Z \s]{1,}"}}},
                        activo: { validation: { required: true, pattern: "[a-zA-Z \s]{1,}"} },
                        orden: { validation: { required: false} },
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
			{ field: "idCategoria", title: "ID Categoria", width: "105px" },
			{ field: "categoria", title: "Categoria", width: "170px" },
			{ field: "padre", title: "Padre", width: "60px" },
			{ field: "activo", title: "Activo", width: "60px" },
			{ field: "orden", title: "Orden", width: "60px" },
            { field: "tipo", title: "Tipo", width: "120px" },
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
			content: "frmCategoria.html"
		});
    });
</script>

</asp:Content>