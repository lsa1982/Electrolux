<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Repuestos.master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div id="grid"></div>
<script>
	$(document).ready(function () {
		var dsRepuestos = new kendo.data.DataSource({
			transport: {
				read: { url: strInterOp("Repuesto", "lista"), dataType: "json" , type:"POST"}
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

		$("#grid").kendoGrid({
			pageable: { pageable: true, pageSizes: [5, 10, 25, 50] },
			dataSource: dsRepuestos,
			sortable: true,
  			filterable: filtroGrid,
  			selectable: "multiple",
  			resizable: true,
  			//autoBind: false,

  			columns: [
				{ command: { text: "Productos", click: onView }, title: " ", width: "90px" },
				{ field: "idRepuesto", title: "id", width: "1px" },
				{ field: "codigo", title: "Repuesto", width: "150px" },
				{ field: "repuesto", title: "Repuesto", width: "300px" },
				{ field: "imagen", title: "Imagen", width: "100px" },
				{ field: "", title: "" }
			]
  		});

  		function onView(e) {
  			e.preventDefault();
  			var dataItem = this.dataItem($(e.currentTarget).closest("tr"));
  			window.location = 'RepuestoProducto.aspx?idRepuesto=' + dataItem.idRepuesto;

  		}
	});
	
</script>

</asp:Content>
