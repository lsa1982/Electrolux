<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Core.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="trabajo">
	<span style=" font-size: 24px;">Diagrama de Flujos de Trabajo</span><br/>
	<table style= "padding-top: 15px; width: 100%" id="layerSeguimiento">
		<tr>
			<td colspan="2">
				<span style=" font-size: 11px;">Detalle del requerimiento solicitado:</span>
			</td>
		</tr>
		<tr>
			
		</tr>
	</table>
	<canvas id="gitGraph"></canvas>
</div>

<script src="<% = resolveClientUrl("~/Kendo/gitgraph.js") %>" type="text/javascript"></script>
<script>
	$(document).ready(function () {
		function onClick(c) {
			if (c instanceof Object) {
				alert(c.message);
			}
		}

		var gitGraph = new GitGraph({ click: onClick });
		var wfMatriz =
			[
				{ "idActividadFinalizacion": "1", "idActividad": "1", "actividad": "Recepcion SD", "idFinalizacion": "1", "finalizacion": "Automatico", "idActividadSiguiente": "2" },
				{ "idActividadFinalizacion": "2", "idActividad": "2", "actividad": "Consulta Stock", "idFinalizacion": "2", "finalizacion": "Recepcionado", "idActividadSiguiente": "3" },
				{ "idActividadFinalizacion": "3", "idActividad": "3", "actividad": "Despacho", "idFinalizacion": "3", "finalizacion": "En Stock", "idActividadSiguiente": "4" },
				{ "idActividadFinalizacion": "6", "idActividad": "3", "actividad": "Solicitud a SPV", "idFinalizacion": "6", "finalizacion": "Sin Stock", "idActividadSiguiente": "6" },
				{ "idActividadFinalizacion": "6", "idActividad": "6", "actividad": "XXX", "idFinalizacion": "6", "finalizacion": "XXX", "idActividadSiguiente": "4" },
				{ "idActividadFinalizacion": "4", "idActividad": "4", "actividad": "YYYY", "idFinalizacion": "4", "finalizacion": "Despachado", "idActividadSiguiente": "5" },
				{ "idActividadFinalizacion": "4", "idActividad": "6", "actividad": "YYYY", "idFinalizacion": "4", "finalizacion": "Despachado", "idActividadSiguiente": "3" },
				{ "idActividadFinalizacion": "4", "idActividad": "3", "actividad": "YYYY", "idFinalizacion": "4", "finalizacion": "Despachado", "idActividadSiguiente": "1" },
				{ "idActividadFinalizacion": "4", "idActividad": "6", "actividad": "YYYY", "idFinalizacion": "4", "finalizacion": "Despachado", "idActividadSiguiente": "2" }
			];
		var index;
		for (index = 0; index < wfMatriz.length; ++index) {
			gitGraph.creaNodo(wfMatriz[index]);
		}
		gitGraph.render();

		

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
