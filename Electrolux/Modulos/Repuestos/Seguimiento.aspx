<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Repuestos.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="trabajo">
	<span style=" font-size: 24px;">Seguimiento</span><br/>
	<table>
		<tr>
			<td style="width: 250px">Ingrese número de requerimiento a buscar</td>
			<td style="width: 150px"><input id="txtIdRequerimiento" type="text" class="k-textbox" /></td>
			<td><button id="btnBuscar" type="button" class="k-button">Buscar </button></td>
		</tr>
	</table>
	<table style= "padding-top: 15px; width: 100%" id="layerNotFound">
		<tr>
			<td colspan="2">
				<span style=" font-size: 11px;">No se encuentran requerimientos con identificador ingresado.</span>
			</td>
		</tr>
	</table>

	
	<table style= "padding-top: 15px; width: 100%" id="layerSeguimiento">
		<tr>
			<td colspan="2">
				<span style=" font-size: 11px;">Detalle del requerimiento solicitado:</span>
				<div style="float: right;margin-right: 10px">
					<button id="btnMensaje" type="button" class="k-button">Mensajes</button>
					<button id="btnProrroga" type="button" class="k-button">Prorroga</button>
				</div> 
			</td>
		</tr>
		<tr>
			<td style=" width: 150px" >Emisor</td>
			<td ><div id="lblEmisor"></div>  </td>
		</tr>
		<tr>
			<td style=" width: 150px" >Producto</td>
			<td style=" text-decoration: underline; color: #00F; cursor: pointer"> <div id="lblProducto"></div>  </td>
		</tr>
		<tr>
			<td >Respuesto</td>
			<td style=" text-decoration: underline; color: #00F; cursor: pointer"><div id="lblRepuesto"></div></td>
		</tr>
		<tr>
			<td >Tienda</td>
			<td ><div id="lblTienda"></div></td>
		</tr>
		<tr>
			<td >Fecha Ingreso</td>
			<td ><div id="lblIngreso"></div></td>
		</tr>
		<tr>
			<td >Fecha Compromiso</td>
			<td ><div id="lblCompromiso"></div> </td>
		</tr>
		<tr>
			<td >Cantidad</td>
			<td ><div id="lblCantidad"></div></td>
		</tr>
		<tr>
			<td >Estado</td>
			<td ><div id="lblEstado"></div></td>
		</tr>
		<tr>
			<td ></td>
			<td >
				<button id="btnDelete" type="button" class="k-button-red">Eliminar</button>
				<button id="btnAnular" type="button" class="k-button-red">Anular</button>
			</td>
		</tr>
		
		<!-- Capa de Actividades -->
		<tr>
			<td colspan="2"><div id="layerActividad" style=" font-size: 24px;">Actividades</div></td>
		</tr>
		<tr>
			<td>Actividad Actual</td>
			<td><div id="lblActividad"></div></td>
		</tr>
		
		<tr>
			<td></td>
			<td>	<button id="btnAvanzar" type="button" class="k-button-red">Finalizar</button></td>
		</tr>

		<tr>
			<td colspan="2"><div id="grid"></div></td>
		</tr>
		<!-- Capa de Prorroga -->
		<tr>
			<td colspan="2"><div id="layerProrroga" style=" font-size: 24px; float:left">Prorrogas</div> <button id="btnVolver1" type="button" class="k-button" style="float:right">Volver </button></td>
		</tr>
		<tr>
			<td colspan="2">Historial de las modificaciones de las fechas de compromiso.<br>&nbsp;</td>
		</tr>
		<tr>
			<td style="vertical-align: baseline">Detalles de prorrogas: </td>
			<td><div id="frmProrroga"></div></td>
		</tr>
		<tr>
			<td > </td>
			<td><button id="btnNewProrroga" type="button" class="k-button-red">Nueva Prorroga</button></td>
		</tr>
		<!-- Capa de Mensajes -->
		<tr>
			<td colspan="2"><div id="layerMensaje" style=" font-size: 24px;float:left">Mensajes</div><button id="btnVolver2" type="button" class="k-button" style="float:right">Volver </button></td>
		</tr>
		<tr>
			<td colspan="2">Mensaje enviados a este seguimiento.<br>&nbsp;</td>
		</tr>
		<tr>
			<td > </td>
			<td><button id="btnNewMensaje" type="button" class="k-button-red">Nueva Mensaje</button></td>
		</tr>
		<tr>
			<td style="vertical-align: baseline">Detalles de Mensajes: </td>
			<td><div id="frmMensaje"></div></td>
		</tr>
		
	</table>
</div>

<div id="winProrroga" class="winSeguimiento">
	 <table>
		 <tr>
			<td colspan="2">Ingrese Motivo y nuevo plazo de requerimiento</td>
		 </tr>
		 <tr>
			<td style="width:100px">Motivo</td>
			<td><input id="cmbMotivo" style="width: 300px" value="" /></td>
		 </tr>
		 <tr>
			<td>Nueva Fecha</td>
			<td><input id="lblFechaNueva" style="width: 300px" value="" /></td>
		 </tr>
		 <tr>
			<td style="vertical-align: baseline">Comentario</td>
			<td><textarea id="txtComentario" name="txtComentario" class="k-textbox" style="width:100%;" ></textarea></td>
		 </tr>
		 <tr>
			<td></td>
			<td><button id="btnSendPostegar" type="button" class="k-button">Postegar </button></td>
		 </tr>
	 </table>
</div>
<div id="winFinalizacion" class="winSeguimiento">
	 <table>
		 <tr>
			<td colspan="2">Ingrese la finalizacion de la actividad</td>
		 </tr>
		<tr>
			<td style="width:100px">Finalizacion</td>
			<td><input id="cmbFinalizacion" style="width: 300px" /></td>
		</tr>
		<tr>
			<td></td>
			<td><input type="checkbox" id="chkDocumento" class="k-checkbox" /> Agregar Documento </td>
		</tr>
		<tr id="lblDoc1" style="display:none">
			<td>Documento</td>
			<td><input id="cmbTipoDocumento" style="width: 300px"/></td>
		</tr>
		<tr id="lblDoc2" style="display:none">
			<td>Nro Referencia</td>
			<td><input id="txtNroDocumento" style="width: 300px" class="k-textbox"  /></td>
		</tr>
		<tr id="lblDoc3" style="display:none">
			<td>Valor</td>
			<td><input id="txtValor" style="width: 300px" /></td>
			</tr>
		
		<tr>
			<td style="vertical-align: baseline">Comentario</td>
			<td><textarea id="txtComentarioDoc" name="txtComentario" class="k-textbox" style="width:100%;" ></textarea></td>
		 </tr>
		 <tr>
			<td></td>
			<td><button id="btnSendFinalizar" type="button" class="k-button">Finalizar </button></td>
		 </tr>
	 </table>
</div>
<div id="winMensaje" class="winSeguimiento">
	 <table>
		 <tr>
			<td>Ingrese mensaje para el seguimiento</td>
		 </tr>
		<tr>
			<td><textarea id="txtMensaje" name="txtMensaje" class="k-textbox" style="width:350px; height:100px" ></textarea></td>
		 </tr>
		 <tr>
			<td><button id="btnSendMensaje" type="button" class="k-button">Enviar</button></td>
		 </tr>
	 </table>
</div>


<script>
	$(document).ready(function () {

		
		// #region  Windows Mensajes
		// ####################################################
		$("#btnSendMensaje").kendoButton({ click: onSendMensaje, icon: "close" });
		function onSendMensaje(e) {
			var pUrl = [];
			pUrl.push("idRequerimiento=" + idRequerimiento);
			pUrl.push("mensaje=" + txtMensaje.value);

			var x = pUrl.join("&");
			callScript(strInterOp("Mensaje", "insertar"), '&' + x,
				function (e) {
					dsRepuestos.read({ "idRequerimiento": idRequerimiento });
					$("#winMensaje").data("kendoWindow").close();
					$("body, html").animate({ scrollTop: $("#layerMensaje").offset().top }, 600);
				}
			);
		}

		$("#winMensaje").kendoWindow({
			width: "400px",
			title: "Mensaje",
			actions: ["Close"],
			visible: false,
			modal: true
		});

		//#endregion

		// #region Windows Finalizacion
		// ####################################################
		$('#chkDocumento').change(function () {
			if ($(this).is(":checked"))
				$("#lblDoc1, #lblDoc2, #lblDoc3").show();
			else
				$("#lblDoc1, #lblDoc2, #lblDoc3").hide();
		});

		$("#txtValor").kendoNumericTextBox({ step: 1000, min: 0 });
		$("#winFinalizacion").kendoWindow({
			width: "430px",
			title: "Finalizar Actividad",
			actions: ["Close"],
			visible: false,
			modal: true
		});

		$("#cmbFinalizacion").kendoDropDownList({
			dataTextField: "finalizacion",
			dataValueField: "idFinalizacion",
			autoBind: false,
			dataSource: {
				type: "json",
				transport: { read: { url: strInterOp("Requerimiento", "listaFinalizacion"), type: "post"} },
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			}
		});

		$("#cmbTipoDocumento").kendoComboBox({
			dataTextField: "tipoDocumento",
			dataValueField: "idTipoDocumento",
			autoBind: false,
			placeholder: "Seleccione Documento",
			dataSource: {
				type: "json",
				transport: { read: { url: strInterOp("TipoDocumento", "lista"), type: "post"} },
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			}
		});

		$("#btnSendFinalizar").kendoButton({ click: onSendFinalizar, icon: "plus" });
		function onSendFinalizar(e) {
			var pUrl = [];
			pUrl.push("idRequerimiento=" + idRequerimiento);
			pUrl.push("idFinalizacion=" + cmbFinalizacion.value);
			if ($('#chkDocumento').is(":checked")) {
				pUrl.push("id=0");
				pUrl.push("idDocumento=" + txtNroDocumento.value);
				pUrl.push("idTipoDocumento=" + $("#cmbTipoDocumento").data("kendoComboBox").value());
				pUrl.push("TipoDocumento=" + $("#cmbTipoDocumento").data("kendoComboBox").text());
				pUrl.push("valor=" + txtValor.value);
			}
			else {
				pUrl.push("id=1");
				pUrl.push("idDocumento=1");
				pUrl.push("idTipoDocumento=1");
				pUrl.push("valor=0");
			}

			var x = pUrl.join("&");
			callScript(strInterOp("Requerimiento", "avanzarActividad"), '&' + x,
				function (e) {
					dsRepuestos.read({ "idRequerimiento": idRequerimiento });
					$("#winFinalizacion").data("kendoWindow").close();
				});
			}

		// #endregion

		// #region Windows Prorroga
		// ####################################################
		$("#btnSendPostegar").kendoButton({ click: onSendPostegar, icon: "close" });
		function onSendPostegar(e) {
			var pUrl = [];
			pUrl.push("idRequerimiento=" + idRequerimiento);
			pUrl.push("idMotivo=" + cmbMotivo.value);
			pUrl.push("fechaNueva=" + lblFechaNueva.value);
			pUrl.push("fechaAntigua=" + $("#lblCompromiso").text());
			pUrl.push("comentario=" + txtComentario.value);

			var x = pUrl.join("&");
			callScript(strInterOp("Prorroga", "insertar"), '&' + x,
				function (e) {
					dsRepuestos.read({ "idRequerimiento": idRequerimiento });
					$("#winProrroga").data("kendoWindow").close();
					$("body, html").animate({ scrollTop: $("#layerProrroga").offset().top }, 600);
				}
			);
		}

		$("#lblFechaNueva").kendoDatePicker({ format: "yyyy-MM-dd" }).data("kendoDatePicker");

		$("#cmbMotivo").kendoComboBox({
			dataTextField: "motivo",
			dataValueField: "idMotivo",
			autoBind: false,
			placeholder: "Seleccion un motivo...",
			dataSource: {
				type: "json",
				transport: {
					read: { url: strInterOp("Motivo", "lista"), type: "post" }
				},
				schema: { errors: "msgState", data: "args", total: "totalFila" }
			}
		});

		$("#winProrroga").kendoWindow({
			width: "450px",
			title: "Postegar plazo",
			actions: ["Close"],
			visible: false,
			modal: true
		});

		// #endregion

		// #region Botones
		// ####################################################
		$("#btnVolver1").kendoButton({ click: onVolver, icon: "arrow-n" });
		$("#btnVolver2").kendoButton({ click: onVolver, icon: "arrow-n" });
		function onVolver(e) {
			$("body, html").animate({ scrollTop: 0 }, 600);
		}

		$("#btnMensaje").kendoButton({ click: onMensaje, icon: "arrow-s" });
		function onMensaje(e) {
			$("body, html").animate({ scrollTop: $("#layerMensaje").offset().top }, 600);
		}

		$("#btnNewMensaje").kendoButton({ click: onNewMensaje });
		function onNewMensaje(e) {
			centrarWin("#winMensaje");
			$("#winMensaje").data("kendoWindow").open();
		}

		$("#btnNewProrroga").kendoButton({ click: onNewProrroga, icon: "tick" });
		function onNewProrroga(e) {
			centrarWin("#winProrroga");
			$("#winProrroga").data("kendoWindow").open();
		}

		$("#btnProrroga").kendoButton({ click: onPostegar, icon: "arrow-s" });
		function onPostegar(e) {
			$("body, html").animate({ scrollTop: $("#layerProrroga").offset().top }, 600);
		}

		$("#btnAnular").kendoButton({ click: onAnular });
		function onAnular(e) {
			var r = confirm("Esta seguro de anular este requerimiento");
			if (r == true) {
				var req = dsRepuestos.at(0);
				callScript(strInterOp("Requerimiento", "anular"), '&idRequerimiento=' + req.id,
				function (e) {
					dsRepuestos.read({ "idRequerimiento": idRequerimiento });
				}
			);
			}
		}

		$("#btnDelete").kendoButton({ click: onDelete });
		function onDelete(e) {
			var r = confirm("Esta seguro de eliminar este requerimiento");
			if (r == true) {
				var req = dsRepuestos.at(0);
				callScript(strInterOp("Requerimiento", "eliminar"), '&idRequerimiento=' + req.id,
				function (e) {
					window.location.href = "Default.aspx";
				});
			}
		}

		$("#btnBuscar").kendoButton({ click: onFind, icon: "search" });
		function onFind(e) {
			idRequerimiento = txtIdRequerimiento.value;
			dsRepuestos.read({ "idRequerimiento": idRequerimiento });
		}

		function onRefresh(e) {
			dsRepuestos.read({ "idRequerimiento": idRequerimiento });
		}

		$("#btnAvanzar").kendoButton({ click: onClick, icon: "arrow-u" });
		function onClick(e) {
			centrarWin("#winFinalizacion");
			$("#winFinalizacion").data("kendoWindow").open();
		}

		// #endregion

		// #region Carga Datos
		// ####################################################
		function cargaDatos(data, idRequerimiento) {
			var vEstado = $.map(dsEstado, function (val) {
				return val.idEstado == data[0].estado ? val : null;
			});
			$("#lblEmisor").html("<strong>" + data[0].usuario + "</strong>");
			$("#lblProducto").html("<strong>" + data[0].marca + ' - ' + data[0].nombre + "</strong>");
			$("#lblRepuesto").html("<strong>" + data[0].codigo + ' - ' + data[0].repuesto + "</strong>");
			$("#lblTienda").html("<strong>" + data[0].tienda + "</strong>");
			$("#lblIngreso").html("<strong>" + data[0].fechaInicio + "</strong>");
			$("#lblCompromiso").html("<strong>" + data[0].fechaCompromiso + "</strong>");
			$("#lblCantidad").html("<strong>" + data[0].cantidad + "</strong>");
			$("#lblEstado").html("<strong>" + vEstado[0].estado + "</strong>");
			$("#lblActividad").html("<strong>" + data[0].actividad + "</strong>");
			dsRequerimiento.read({ "idRequerimiento": idRequerimiento });
			dsProrroga.read({ "idRequerimiento": idRequerimiento });
			dsMensaje.read({ "idRequerimiento": idRequerimiento });
			if (data[0].estado == 2) {
				$("#btnAvanzar").hide();
				$("#cmbFinalizacion").data("kendoDropDownList").enable(false);
			}
			else {
				$("#cmbFinalizacion").data("kendoDropDownList").dataSource.read({ "idRequerimiento": idRequerimiento });
				$("#cmbTipoDocumento").data("kendoComboBox").dataSource.read();
			}
			$("#lblRepuesto").click(function () {
				window.location.href = 'RepuestoProducto.aspx?idRepuesto=' + data[0].idRepuesto;
			});
			$("#lblProducto").click(function () {
				window.location.href = 'frmProducto.aspx?idProducto=' + data[0].idProducto;
			})

		}

		// #endregion

		// #region Datasource Repuesto
		// ####################################################
		var dsRepuestos = new kendo.data.DataSource({
			transport: {
				read: { url: strInterOp("Requerimiento", "lista"), dataType: "json", type: 'POST' },
				destroy: { url: strInterOp("Requerimiento", "eliminar"), dataType: "json", type: 'POST' },
				parameterMap: function (data, type) {
					if (type == "destroy") {
						return { idRequerimiento: data.models[0].idRequerimiento }
					}
					if (type == "read") {
						return { idRequerimiento: data.idRequerimiento }
					}
				}
			},
			change: function (e) {
				if (e.action != "remove") {
					if (this._data.length > 0) {
						var data = this.data();

						cargaDatos(data, data[0].idRequerimiento);
						$("#layerNotFound").hide();
						$("#layerSeguimiento").show();
					}
					else {
						$("#layerSeguimiento").hide();
						$("#layerNotFound").show();
					}
				}
			},
			batch: true,
			resizable: true,
			error: errorGrid,
			schema: { errors: "msgState", data: "args", total: "totalFila", model: { id: "idRequerimiento"} }
		});

		//#endregion

		// #region Datasource Prorroga
		// ###############################

		var dsProrroga = new kendo.data.DataSource({
			transport: { read: { url: strInterOp("Prorroga", "lista"), dataType: "json", type: 'POST'} },
			batch: true,
			resizable: true,
			error: errorGrid,
			schema: { errors: "msgState", data: "args", total: "totalFila" },
			change: function (e) {
				var strDivProrroga = "";
				if (this._data.length > 0) {
					var data = this.data();
					var strDiv = "<div class='divProrroga'><span style='font-weight: bold; color: #0B90A7 '> Ingresado el $1 <br>Por $2";
					strDiv = strDiv + "</span><br><hr/>Motivo:<strong> $3</strong><br>Fecha Anterior:<strong> $4</strong><br>";
					strDiv = strDiv + "Fecha Nueva: <strong>$5</strong><br>Comentario: <strong>$6</strong></div>";

					for (i = 0; i < this._data.length; i++) {
						strDivData = strDiv;
						strDivData = strDivData.replace("$1", data[i].fechaModificacion);
						strDivData = strDivData.replace("$2", data[i].usuario);
						strDivData = strDivData.replace("$3", data[i].motivo);
						strDivData = strDivData.replace("$4", data[i].fechaAntigua);
						strDivData = strDivData.replace("$5", data[i].fechaNueva);
						strDivData = strDivData.replace("$6", data[i].comentario);
						strDivProrroga = strDivProrroga + strDivData;
					}
				}
				else {
					strDivProrroga = "<strong>No existen prorrogas para este requerimiento</strong>";
				}
				$("#frmProrroga").html(strDivProrroga);
			}
		});

		// #endregion

		// #region Datasource Mensaje
		// ###############################
		
		var dsMensaje = new kendo.data.DataSource({
			transport: { read: { url: strInterOp("Mensaje", "lista"), dataType: "json", type: 'POST'} },
			batch: true,
			resizable: true,
			error: errorGrid,
			schema: { errors: "msgState", data: "args", total: "totalFila" },
			change: function (e) {
				var strDivMensaje = "";
				if (this._data.length > 0) {
					var data = this.data();
					var strDiv = "<div class='divProrroga'><span style='font-weight: bold; color: #0B90A7 '> Ingresado el $1 <br>Por $2</span><hr/>";
					strDiv = strDiv + "Mensaje: <strong>$3</strong></div>";

					for (i = 0; i < this._data.length; i++) {
						strDivData = strDiv;
						strDivData = strDivData.replace("$1", data[i].fechaIngreso);
						strDivData = strDivData.replace("$2", data[i].usuario);
						strDivData = strDivData.replace("$3", data[i].mensaje);
						strDivMensaje = strDivMensaje + strDivData;
					}
				}
				else {
					strDivMensaje = "<strong>No existen Mensajes para este requerimiento</strong>";
				}
				$("#frmMensaje").html(strDivMensaje);
			}
		});

		// #endregion

		// #region Grid Actividades
		// ############################################
		var dsRequerimiento = new kendo.data.DataSource({
			transport: {
				read: { url: strInterOp("Requerimiento", "listaEstado"), dataType: "json", type: 'POST' }
			},
			batch: true,
			resizable: true,
			error: errorGrid,
			schema: { errors: "msgState", data: "args", total: "totalFila" }
		});

		$("#grid").kendoGrid({
			dataSource: dsRequerimiento,
			pageable: { pageable: true, pageSizes: [5, 10, 25, 50] },
			height: 250,
			sortable: true,
			filterable: filtroGrid,
			resizable: true,
			autoBind: false,
			scrollable: true,
			columns: [
				{ field: "idRequerimiento", title: "id", width: "40px" },
				{ field: "estado", title: "E", template: '<span class="claseEstado claseEstado#: estado #">&nbsp;</span>', width: "35px" },
				{ field: "actividad", title: "actividad", width: "180px" },
				{ field: "fechaInicio", title: "Inicio", width: "170px" },
				{ field: "fechaEsperada", title: "Compromiso", width: "170px" },
				{ field: "fechaFin", title: "Fin", width: "170px" },
				{ field: "rol", title: "rol", width: "120px" },
				{ field: "", title: "" }
			]
		});
		
		// #endregion

		// #region Inicio del flujo
		// ############################################
		var idRequerimiento = 0;
		$("#layerSeguimiento").hide();
		$("#layerNotFound").hide();

		var vGet = getVarsUrl();

		if (typeof vGet.idRequerimiento != "undefined") {
			idRequerimiento = vGet.idRequerimiento;
			dsRepuestos.read({ "idRequerimiento": vGet.idRequerimiento });
		}

		// #endregion
	});
</script>
<style>
	.claseEstado {
		padding: 5px;
		font-weight: bold;
		color: White;
		border-radius: 6px;
		}
	.claseEstado0 {
		background-color: Red;
		}
	.claseEstado1 {
		background-color: yellow;
		}
	.claseEstado2 {
		background-color: green;
		}
	.claseEstado3 {
		background-color: Red;
		}
		
	.claseEstado4 {
		background-color: Orange;
		}
	
	

		
	.winSeguimiento{
		font-size: 11px;
		border-bottom: 1px dashed #EEEEEE;
		padding-bottom:5px;
	}
	
	.divProrroga{
		 border: 1px solid #AAA; 
		 width: 260px; 
		 float: left;
		 margin-right:15px;
		 margin-bottom:15px;
		 -webkit-border-radius: 3px;
		 padding: 5px;
		 box-shadow: 0 0 3px #DDD;
		 min-height: 150px;
		}
	
	.divMensaje{
		 border: 1px solid #AAA; 
		 width: 95%; 
		 background-color: #EEE;
		 -webkit-border-radius: 3px;
		 padding: 15px;
		 box-shadow: 0 0 3px #DDD
		}

</style>
</asp:Content>
