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
		<td ><div id="cmbTipoDocumento"></div>  </td>
	</tr>
	<tr>
		<td >Nro Referencia</td>
		<td ><input id="txtReferencia" class="k-textbox"/>  </td>
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
			<button id="btnAdd" type="button" class="k-button-red">Agregar</button>
			<button id="btnSend" type="button" class="k-button-red">Enviar</button>
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
<div id="winSend">
	<table style="width:100% ; font-size: 12px;border:3px" >
		<tr style="width:100%">
			<td colspan="2" style="width:100%">
				<span style=" font-size: 24px; ">Confirmación de Envio</span><br/>
				<span style=" font-size: 11px;">Se ingresará un movimiento con los siguientes datos:</span>
			</td>
		</tr>
		<tr>
			<td colspan="2"><hr /> </td>
		</tr>
		<tr>
			<td>Tipo Documento: </td>
			<td><div id="txtSendTipoDocumento"></div></td>
		</tr>
		<tr>
			<td>Referencia: </td>
			<td><div id="txtSendReferencia" ></div></td>
		</tr>
		<tr>
			<td colspan="2"><hr /> </td>
		</tr>
		<tr>
			<td colspan="2">Detalle: </td>
		</tr>
		<tr>
			<td colspan="2">
				<span style=" font-weight: bold">
					<div id="tablaCarrito" name="tablaCarrito">&nbsp;</div><br/>
				</span>
			</td>
		<tr>
			<td colspan="2"><hr /> </td>
		</tr>
		<tr>
			<td>Total de Registros: <br/></td>
			<td><div id="lblMensaje"></div><br/></td>
		</tr>
		<tr>
			<td colspan ="2">Comentario</td>
		</tr>
		
		<tr>
			<td  colspan ="2"><textarea id="txtComentario" class="k-textbox" style="width:100%; height:50px" ></textarea>  </td>
		</tr>
		<tr style="width:100%">
			<td colspan="2" >
				<button id="btnWinSend" type="button" class="k-button-red">Enviar</button>&nbsp;
				<button id="btnWinClose" type="button" class="k-button-red">Cancelar</button>
			</td>
		</tr>
	</table>
</div>
<script>
	$(document).ready(function () {
		// ###############################
		// ## Definicion general		##
		// ###############################

		$("#txtValor").kendoNumericTextBox({ format: "c0" });
		$("#txtCantidad").kendoNumericTextBox({ format: "#,###" });
		$("#lblFecha").html("<strong>" + kendo.toString(new Date(), "F") + "</strong>");

		// ###############################
		// ## Windows		##
		// ###############################

		$("#winSend").kendoWindow({
			width: "450px",
			title: "Ingreso de movimiento",
			actions: ["Close"],
			visible: false,
			modal: true
		});

		$("#btnWinSend").kendoButton({ icon: "arrow-u", click: onWinSend });
		function onWinSend() {
			var v = dsCarrito.data();
			var detalle = "";
			for (i = 0; i < v.length; i++) {
				r = v[i];
				detalle = detalle + v[i].idRepuesto + '|' + v[i].cantidad + '|' + v[i].valor + ';'
			}

			var pUrl = [];

			pUrl.push("idTipoDocumento=" + $("#cmbTipoDocumento").data("kendoComboBox").value());
			pUrl.push("comentario=" + txtComentario.value);
			pUrl.push("referencia=" + txtReferencia.value);
			pUrl.push("detalle=" + detalle);
			var x = pUrl.join("&");
			callScript(strInterOp("Repuesto", "insertarMovimiento"), '&' + x, onEnd);
			$("#winSend").data("kendoWindow").close();
		}
		function onEnd() {
			window.location.href = "frmPostSend.aspx?idOrigen=0";
		}

		$("#btnWinClose").kendoButton({ icon: "plus", click: onWinClose });
		function onWinClose() {
			$("#winSend").data("kendoWindow").close();
		}

		// ###############################
		// ## Combo Tipo Documento		##
		// ###############################

		$("#cmbTipoDocumento").kendoComboBox({
			dataTextField: "tipoDocumento",
			dataValueField: "idTipoDocumento",
			placeholder: "Seleccione Documento",
			dataSource: {
				type: "json",
				transport: {
					read: { url: strInterOp("TipoDocumento", "listaInventario"), dataType: "json", type: "post" }
				},
				sort: { field: "tipoDocumento", dir: "asc" },
				schema: {
					errors: "msgState",
					data: "args",
					total: "totalFila"
				}
			}
		});

		// ###############################
		// ## Buscador de repuestos		##
		// ###############################

		$("#txtCodigo").kendoAutoComplete({
			dataTextField: "codigo",
			filter: "contains",
			select: onSelect,
			minLength: 3,
			error: errorGrid,
			dataSource: {
				serverFiltering: true,
				transport: { read: { url: strInterOp("Repuesto", "lista"), dataType: "json", type: "POST"} },
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			}
		});

		function onSelect(e) {
			var dataItem = this.dataItem(e.item.index());
			$("#lblRepuesto").html("<strong>" + dataItem.repuesto + "</strong>");
			$("#lblGrupo").html("<strong>" + dataItem.grupo + "</strong>");
			txtIdRepuesto.value = dataItem.idRepuesto;
		}
		// ###############################
		// ## Botones					##
		// ###############################

		$("#btnAdd").kendoButton({ icon: "arrow-u", click: onAdd });
		function onAdd(e) {
			if (txtIdRepuesto.value != "") {
				var dataItem = dsCarrito.get(txtIdRepuesto.value);
				if (typeof dataItem == "undefined") {
					dsCarrito.add({
						"idRepuesto": txtIdRepuesto.value,
						"codigo": txtCodigo.value,
						"repuesto": $("#lblRepuesto").text(),
						"grupo": $("#lblGrupo").text(),
						"cantidad": txtCantidad.value,
						"valor": txtValor.value
					});
					onLimpiar();
				}
			}
		}

		function onLimpiar() {
			txtCodigo.value = "";
			txtIdRepuesto.value = "";
			$("#lblGrupo").html("");
			$("#lblRepuesto").html("");
			$("#txtCantidad").data("kendoNumericTextBox").value(1);
			$("#txtValor").data("kendoNumericTextBox").value(0);
		}

		$("#btnSend").kendoButton({ icon: "arrow-u", click: onSend });
		function onSend() {
			$("#winSend").data("kendoWindow").center();
			$("#winSend").data("kendoWindow").open();

			$("#txtSendReferencia").html("<strong>" + txtReferencia.value + "</strong>");
			$("#txtSendTipoDocumento").html("<strong>" + $("#cmbTipoDocumento").data("kendoComboBox").text() + "</strong>");
			var template = kendo.template("#: codigo # #: repuesto # &emsp; X  #: cantidad # &emsp; $ #: valor # <br/>");
			var v = dsCarrito.data();
			var html = kendo.render(template, v);
			$("#tablaCarrito").html(html);
			$("#lblMensaje").html("<strong>" + v.length + "</strong>");
		}

		// ###############################
		// ## Grid						##
		// ###############################
		var dsCarrito = new kendo.data.DataSource({
			data: [],
			schema: {
				model: {
					id: "idRepuesto",
					fields: {
						idRepuesto: { editable: false, nullable: true },
						codigo: {},
						repuesto: {},
						cantidad: { type: "number" },
						valor: { type: "number" }
					}
				}
			}
		});

		$("#gridDetalle").kendoGrid({
			dataSource: dsCarrito,
			autoBind: false,
			editable: { confirmation: false, destroy: true, update: false },
			columns: [
				{ command: [{ text: "Eliminar", name: "destroy"}], title: " ", width: "100px" },
				{ field: "idRepuesto", title: "id", width: "30px" },
				{ field: "codigo", title: "Codigo", width: "100px" },
				{ field: "repuesto", title: "Repuesto", width: "300px" },
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
