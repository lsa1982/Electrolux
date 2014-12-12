<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Repuestos.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="trabajo">
	ok
</div>
<script>
	$(document).ready(function () {
		var detalle = "";
		detalle = '1|1|5;';
		var pUrl = [];
		pUrl.push("idTienda=1");
		pUrl.push("comentario=prueba");
		pUrl.push("detalle=" + detalle);
		var x = pUrl.join("&");
		callScript(strInterOp("Requerimiento", "Insertar"), '&' + x);
	});
</script>
</asp:Content>
