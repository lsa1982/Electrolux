<%@ Page Title="" Language="vb" AutoEventWireup="false"  MasterPageFile="~/Core.Master" %>


<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="trabajo">
<table>
	<tr>
    <td><button id="button" type="button">Agregar Nuevo Producto</button></td>
    </tr>
</table>
<div id="grid" style="width: 100%;position: absolute"></div>
</div>
<div id="winNewRequest">Espere Mientras se actualizan los datos</div>
<script>

    var ds = new kendo.data.DataSource({
        transport: {
            read: { url: strInterOp("clsProducto", "lista"), dataType: "json", type: "POST" }
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
            total: "totalFila"
        }
    });


    $(document).ready(function () {


        $("#button").kendoButton({ icon: "plus", click: function (e) {
            $("#winNewRequest").data("kendoWindow").center().open();
        }
        });

        var gridColumns = [
			{ command: { text: "Detalle", click: onView }, title: " ", width: "90px" },
			{ field: "idProducto", title: "ID", width: "40px" },
			{ field: "categoria", title: "Categoria", width: "120px" },
            { field: "marca", title: "Marca", width: "100px" },
            { field: "nombre", title: "Nombre", width: "170px" },
            { field: "descripcion", title: "Descripcion", width: "120px" },
			{ field: "modelo", title: "Modelo", width: "130px" },
            { field: "codigo", title: "Codigo", width: "100px" },
            { field: "codigoBarra", title: "Codigo Barra", width: "100px" },
			{ field: "resumen", title: "Resumen", width: "120px" },
            { field: "ultimaModificacion", title: "Ultima Modificacion", width: "150px" },
            { field: "", title: "" }
			];


        $("#grid").kendoGrid({
            pageable: { pageable: true, pageSizes: [5, 10, 25, 50] },
			dataSource: ds,
			sortable: true,
  			filterable: filtroGrid,
  			selectable: "multiple",
  			resizable: true,
            columns: gridColumns
        });

        function onView(e) {
            e.preventDefault();
            var dataItem = this.dataItem($(e.currentTarget).closest("tr"));
            window.location = '../Repuestos/frmProducto.aspx?idProducto=' + dataItem.idProducto;
        }


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
