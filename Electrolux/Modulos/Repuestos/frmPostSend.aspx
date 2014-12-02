<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Repuestos.master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="trabajo">
	<table style= "padding-bottom: 10px; width: 100%">
		<tr>
			<td colspan="2">
				<span style=" font-size: 24px;"><div id=lblTitulo></div></span>
			</td>
		</tr>
		<tr style="font-size: 10px; border-bottom-width: 1px; ">
			<td>
				<div id=lblMensaje></div>
			</td>
			
		</tr>
	</table>
</div>
<script>
	$(document).ready(function () {
		var vGet = getVarsUrl();

		var vTexto = [
			{
				"titulo": "Ingreso Exitoso",
				"mensaje": "Se ha ingresado un movimiento de inventario correctamente, si desea ingresar otro movimiento pulse <a href='Inventario.aspx' >aqui</a>"
			},
			{
				"titulo": "Ingreso Exitoso",
				"mensaje": "Se ha ingresado un requerimiento correctamente, para realizar seguimiento de su solicitud pulse <a href='seguimiento.aspx?idRequerimiento'" + vGet.idRequerimiento + " >aqui</a>"
			}
		];

		

		if (typeof vGet.idOrigen != "undefined") {
			$("#lblTitulo").html("<strong>" + vTexto[vGet.idOrigen].titulo + "</strong>");
			$("#lblMensaje").html(vTexto[vGet.idOrigen].mensaje);	
		}


	});
	
</script>

</asp:Content>
