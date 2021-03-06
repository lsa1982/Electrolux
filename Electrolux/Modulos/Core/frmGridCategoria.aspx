﻿<%@ Page Title="" Language="vb" AutoEventWireup="false"  MasterPageFile="~/Core.Master" %>


<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="trabajo">
<table>
	<tr>
    <td><button id="button" type="button">Agregar Nueva Categoría</button></td>
    </tr>
</table>
<div id="grid" style="width: 100%;position: absolute"></div>
</div>
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
                        "txtSubCategoria": options.models[0].subcategoria,
                        "txtPadre": options.models[0].padre,
                        "txtActivo": options.models[0].activo,
                        "txtOrden": options.models[0].orden,
                        "txtTipo": options.models[0].tipo,
                        "txtClase": options.models[0].clase,
                        "txtUpload": options.models[0].imagen,
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
                    categoria: { validation: { required: true, pattern: "[a-zA-Z \s]{1,}"} },
                    subcategoria: { validation: { required: true, pattern: "[a-zA-Z \s]{1,}"} },
                    padre: { validation: { required: false} },
                    activo: { validation: { required: true, pattern: "[a-zA-Z \s]{1,}"} },
                    orden: { validation: { required: false} },
                    tipo: { validation: { required: false} },
                    clase: { validation: { required: true, pattern: "[a-zA-Z \s]{1,}"} },
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
			{ field: "idCategoria", title: "ID", width: "40px" },
			{ field: "categoria", title: "Categoria", width: "110px" },
            { field: "subcategoria", title: "SubCategoria", width: "110px" },
			{ field: "padre", title: "Padre", width: "60px" },
			{ field: "activo", title: "Activo", width: "60px" },
			{ field: "orden", title: "Orden", width: "60px" },
            { field: "tipo", title: "Tipo", width: "100px" },
            { field: "clase", title: "Clase", width: "100px" },
            { field: "imagen", title: "Imagen", template: "<img src='images/categoria/#= imagen #' height='50' width='80'/>", width: "90px" },
			{ field: "ultimaModificacion", title: "Ultima Modificacion", width: "180px" }
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
			content: "frmCategoria.html"
		});
    });
</script>

</asp:Content>