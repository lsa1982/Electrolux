<%@ Page Title="" Language="vb" AutoEventWireup="false"  MasterPageFile="~/Core.Master" %>


<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="msgPagina">
	<button id="button" type="button">Agregar Nuevo Producto</button>
</div>
<div id="grid" style="height: 380px"></div>
<div id="winNewRequest">Espere Mientras se actualizan los datos</div>
<script>

    var ds = new kendo.data.DataSource({
        transport: {
            read: { url: strInterOpAs("clsProducto", "lista", "Core"), dataType: "json", type: "POST" },
            destroy: { url: strInterOpAs("clsProducto", "eliminar", "Core"), dataType: "json" },
            update: { url: strInterOpAs("clsProducto", "editar", "Core"), dataType: "json", type: "POST" },
            create: { url: strInterOpAs("clsProducto", "insertar", "Core"), dataType: "json", type: "POST" },
            parameterMap: function (options, operation) {
                if (operation !== "read" && options.models) {
                    return { txtidProducto: options.models[0].idProducto,
                        "txtidCategoria": options.models[0].idCategoria,
                        "txtidLinea": options.models[0].idLinea,
                        "txtNombre": options.models[0].nombre,
                        "txtDescripcion": options.models[0].descripcion,
                        "txtModelo": options.models[0].modelo,
                        "txtCodigo": options.models[0].codigo,
                        "txtCodigoBarra": options.models[0].codigoBarra,
                        "txtResumen": options.models[0].resumen,
                        "txtUltimaModificacion": options.models[0].ultimaModificacion
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
                id: "idProducto",
                fields: {
                    idProdcuto: { editable: false, nullable: true },
                    idCategoria: { editable: true, nullable: true },
                    idLinea: { editable: true, nullable: true },
                    nombre: { validation: { required: true, pattern: "[a-zA-Z \s]{1,}"} },
                    descripcion: { validation: { required: false} },
                    modelo: { validation: { required: true, pattern: "[a-zA-Z \s]{1,}"} },
                    codigo: { validation: { required: true, pattern: "[a-zA-Z \s]{1,}"} },
                    codigoBarra: { validation: { required: false} },
                    resumen: { validation: { required: false} },
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
			{ field: "idProducto", title: "ID Producto", width: "105px" },
			{ field: "idCategoria", title: "ID Categoria", width: "170px" },
            { field: "idLinea", title: "ID Linea", width: "170px" },
            { field: "nombre", title: "Nombre", width: "170px" },
            { field: "descripcion", title: "Descripcion", width: "180px" },
			{ field: "modelo", title: "Modelo", width: "180px" },
            { field: "codigo", title: "Codigo", width: "180px" },
            { field: "codigoBarra", title: "Codigo Barra", width: "180px" },
			{ field: "resumen", title: "Resumen", width: "120px" },
            { field: "ultimaModificacion", title: "Ultima Modificacion", width: "280px" },
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
            title: "Ingreso Nuevo Producto",
            actions: ["Close"],
            visible: false,
            modal: true,
            content: "frmProducto.html"
        });
    });
</script>

</asp:Content>
