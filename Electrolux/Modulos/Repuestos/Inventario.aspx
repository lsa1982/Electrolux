<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Repuestos.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="trabajo">
<span style=" font-size: 24px;">Movimientos</span><br/>
<table style= "padding-top: 15px; width: 100%" id="layerSeguimiento">
	<tr>
		<td colspan="2">
			<span style=" font-size: 11px;">Ingreso de Documento de Movimiento:</span>
			<div style="float: right;margin-right: 10px">
				<button id="btnMensaje" type="button" class="k-button">Nuevo Repuesto</button>
				<button id="btnProrroga" type="button" class="k-button">Nuevo Tipo Documento</button>
			</div> 
		</td>
	</tr>
	<tr>
		<td style=" width: 150px" >Fecha Ingreso</td>
		<td ><div id="lblFecha"></div>  </td>
	</tr>
	<tr>
		<td >Tipo Documento</td>
		<td ><div id="Div1"></div>  </td>
	</tr>
	<tr>
		<td style="vertical-align: baseline">Descripcion</td>
		<td ><textarea id="txtDescripcion" class="k-textbox" style="width:350px; height:50px" ></textarea>  </td>
	</tr>
	<!-- Capa de Repuestos -->
	<tr>
		<td colspan="2"><div id="layerRepuestos" style=" font-size: 24px;float:left">Repuestos</div><button id="btnVolver2" type="button" class="k-button" style="float:right">Volver </button></td>
	</tr>
	<tr>
		<td >Código</td>
		<td > <input id="txtCodigo" style="width: 400px" /> </td>
	</tr>
	<tr>
		<td >Repuesto</td>
		<td ><div id="lblRepuesto"></div><input id="txtIdRepuesto" type="hidden" />  </td>
	</tr>
		<tr>
		<td >Grupo</td>
		<td ><div id="lblGrupo"></div>  </td>
	</tr>
	<tr>
		<td >Tipo Movimiento</td>
		<td ><input id="cmbTipoMovimiento" /> </td>
	</tr>
	<tr>
		<td >Cantidad</td>
		<td ><input id="txtCantidad" type="number" value="1" min="1" max="1000" />  </td>
	</tr>
	<tr>
		<td >Valor</td>
		<td ><input id="txtValor" type="number" value="0" min="0" max="1000000" step="1000" />  </td>
	</tr>
	<tr>
		<td > </td>
		<td>
			<button id="btnNewRepuesto" type="button" class="k-button-red">Nuevo Repuesto</button>
			<button id="btnAdd" type="button" class="k-button-red">Agregar Repuesto</button>
			<button id="btnSend" type="button" class="k-button-red">Guardar</button>
		</td>
	</tr>
	<!-- Capa de Detalle -->
	<tr>
		<td colspan="2"><div id="Div5" style=" font-size: 24px;float:left">Detalle</div><button id="Button1" type="button" class="k-button" style="float:right">Volver </button></td>
	</tr>
	<tr>
		<td colspan="2"><div id="gridDetalle"></div></td>
	</tr>
</table>
 </div>
<script>
	var dsCarrito = new kendo.data.DataSource({
		data: [],
		schema: {
			model: {
				id: "idRepuesto",
				fields: {
					idRepuesto: { editable: false, nullable: true },
					codigo: { },
					repuesto: {},
					cantidad: { type: "number" },
					valor: { type: "number" }
				}
			}
		}
	});

	function onLimpiar() {
		$("#lblRepuesto").html("");
		$("#lblGrupo").html("");
		$("#txtCantidad").html("");
		$("#txtValor").html("");
	}

	function onAdd(e) {
		if (txtIdRepuesto.value != "") {
			var dataItem = dsCarrito.get(txtIdRepuesto.value);
			if (typeof dataItem == "undefined") {
				dsCarrito.add({
					"idRepuesto": txtIdRepuesto.value,
					"repuesto": $("#lblRepuesto").text(),
					"grupo": $("#lblGrupo").text(),
					"cantidad": txtCantidad.value,
					"valor": txtValor.value
				});
				onLimpiar();
			}
		}
	}

	$(document).ready(function () {

		$("#btnNewRepuesto").kendoButton({ icon: "arrow-u" });
		$("#txtValor").kendoNumericTextBox({ format: "c0" });
		$("#txtCantidad").kendoNumericTextBox({ format: "#,###" });
		$("#lblFecha").html("<strong>" + kendo.toString(new Date(), "F") + "</strong>");

		function onSelect(e) {
			var dataItem = this.dataItem(e.item.index());
			$("#lblRepuesto").html("<strong>" + dataItem.repuesto + "</strong>");
			$("#lblGrupo").html("<strong>" + dataItem.grupo + "</strong>");
			txtIdRepuesto.value = dataItem.idRepuesto;
		}

		$("#cmbTipoDocumento").kendoDropDownList({
			dataTextField: "text",
			dataValueField: "value",
			dataSource: dsTipoMovimiento,
			index: 0
		});

		var dsTipoMovimiento = [
			{ text: "Ingreso", value: "I" },
			{ text: "salida", value: "S" }
		];

		$("#cmbTipoMovimiento").kendoDropDownList({
			dataTextField: "text",
			dataValueField: "value",
			dataSource: dsTipoMovimiento,
			index: 0
		});

		$("#txtCodigo").kendoAutoComplete({
			dataTextField: "codigo",
			filter: "contains",
			select: onSelect,
			minLength: 3,
			error: errorGrid,
			dataSource: {
				serverFiltering: true,
				transport: {read: { url: strInterOp("Repuesto", "lista"), dataType: "json", type: "POST" }},
				schema: {errors: "msgState",data: "args",total: "totalFila"}
			}
		});

		$("#btnAdd").kendoButton({ icon: "arrow-u", click: onAdd });
		$("#gridDetalle").kendoGrid({
			dataSource: dsCarrito,
			autoBind: false,
			editable: { confirmation: false, destroy: true, update: false },
			columns: [
				{ command: [{ text: "Eliminar", name: "destroy"}], title: " ", width: "80px" },
				{ field: "idRepuesto", title: "id", width: "30px" },
				{ field: "repuesto", title: "Repuesto", width: "300px" },
				{ field: "grupo", title: "Grupo", width: "250px" },
				{ field: "cantidad", title: "Cantidad", width: "80px" },
				{ field: "valor", title: "Valor", width: "80px" },
				{ field: "", title: "" }
			]
		});

	});
</script>
<style>
	

 </style>
</asp:Content>
