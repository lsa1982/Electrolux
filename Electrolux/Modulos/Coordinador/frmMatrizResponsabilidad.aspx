<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Repuestos.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="trabajo">
	<span style=" font-size: 24px;">Matriz de Responsabilidad</span><br/>
	<table style= "padding-top: 15px; width: 100%" id="layerSeguimiento">
		<tr>
			<td colspan="2">
				<span style=" font-size: 11px;">Detalle del requerimiento solicitado:</span>
			</td>
		</tr>
		<tr>
			<td style="width:250px;vertical-align: top" > <div id="treeview"></div></td>
			<td style=" vertical-align: top; border-left: 1px dashed #EEEEEE"> 
				<table width="100%">
					<td colspan="2">
						<span style=" font-size: 14px; font-weight: bold">Información del Usuario Asignado</span>
					</td>
					<tr>
						<td style="width:150px">Usuario Asignado : </td>
						<td><div id="lblUsuario"></div></td>
					</tr>
					<tr>
						<td style="width:150px">Fecha Asignación : </td>
						<td><div id="lblAsignacion"></div></td>
					</tr>
					<tr>
						<td style="width:150px">eMail : </td>
						<td><div id="lblEmail"></div></td>
					</tr>
					<tr>
						<td style="width:150px">Fono : </td>
						<td><div id="lblFono"></div></td>
					</tr>
					<tr>
						<td colspan="2">
							<div id="tabView"></div>
						</td>
						
					</tr>
				</table>
				
			</td>
		</tr>
	</table>
</div>



<script>
	$(document).ready(function () {

		function templateMatriz(vVariable, vRol) {
			this.Nombre = vVariable;
			this.htmlTemplate = "<table> " +
				"<tr><td>Seleccione $1</td><td>InputBox</td><td>Button</td></tr><tr><td colspan='3'><div id='grid$1'></div></td></tr>" +
			"</table>";
			this.htmlTemplate = this.htmlTemplate.replace(/\$1/g, vVariable);
			this.source = new kendo.data.DataSource({
				serverFiltering: true,
				transport: {
					read: { url: strInterOpAs("clsMatrizResponsabilidad", "lista", "Coordinador"), dataType: "json", type: "post", data: {idVariable: vVariable, idRol: vRol} }
				},
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			});
			this.creaGrid = function () {
				$("#grid" + vVariable).kendoGrid({
					dataSource: this.source,
					height: 350,
					sortable: true,
					filterable: filtroGrid,
					resizable: true,
					columns: [
						{ field: "idResponsabilidad", title: "id", width: "40px" },
						{ field: "valorInt", title: "actividad", width: "180px" },
						{ field: "valorChar", title: "Inicio", width: "170px" },
						{ field: "", title: "" }
					]
				});
			};

		}



		var inline = new kendo.data.HierarchicalDataSource({
			data: [
				{ categoryName: "Supervisor",
					subCategories: [
						{ subCategoryName: "Supervisor Stgo Oriente" },
						{ subCategoryName: "Supervisor Stgo Centro" },
						{ subCategoryName: "Supervisor I-II Region" },
						{ subCategoryName: "Supervisor III-IV Region" },
						{ subCategoryName: "Supervisor V Region Interior" },
						{ subCategoryName: "Supervisor Sur" }
					]
				},
				{ categoryName: "KAM", subCategories: [
						{ subCategoryName: "KAM Cencosud" },
						{ subCategoryName: "KAM Ripley" },
						{ subCategoryName: "KAM Falabella" },
						{ subCategoryName: "KAM Otros" }
					]
				},
				{ categoryName: "PM", subCategories: [
						{ subCategoryName: "PM Fensa" },
						{ subCategoryName: "PM Mademsa" },
						{ subCategoryName: "PM Electrolux" },
						{ subCategoryName: "PM Somela" }
					]
				}
			],
			schema: {
				model: {
					children: "subCategories"
				}
			}
		});

		$("#treeview").kendoTreeView({
			dataSource: inline,
			dataTextField: ["categoryName", "subCategoryName"]
		});


		var data = [
				{
					usuario: "Levi Sanchez",
					asignacion: "2014-01-01",
					eMail: "levi.sanchez@gmail.com",
					fono: "99999999"
				}
			];
		$("#lblUsuario").html("<strong>" + data[0].usuario + "</strong>");
		$("#lblAsignacion").html("<strong>" + data[0].asignacion + "</strong>");
		$("#lblEmail").html("<strong>" + data[0].eMail + "</strong>");
		$("#lblFono").html("<strong>" + data[0].fono + "</strong>");

		// ############################################################
		// ###	Data Source Responsables							###
		// ############################################################

		var tabStrip = $("#tabView").kendoTabStrip().data("kendoTabStrip");
		var x = new templateMatriz("Tienda", "1");
		tabStrip.append({ text: x.Nombre, content: x.htmlTemplate });
		x.creaGrid();
		tabStrip.append({ text: "Item 2", content: "holaaa2" });

	});
</script>

<style>
	
 	.areaTrabajo table td{
 		font-size: 11px;
 		border-bottom: 1px dashed #EEEEEE;
 		padding-bottom:5px;
 		
 		}
 	
</style>
</asp:Content>
