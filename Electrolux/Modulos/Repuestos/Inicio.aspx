<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Repuestos.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="areaTrabajo" id="trabajo">


	<div id="pages">
		<div id="pages-title"><span>Seleccione Sección a ingresar</span></div>
		<div id="sortable-handlers">
			<div class="item">
				<span class="handler">&nbsp;</span>
				<span>Nuevo Requerimiento</span>
			</div>
			<div class="item">
				<span class="handler">&nbsp;</span>
				<span>Repuestos</span>
			</div>
			<div class="item">
				<span class="handler">&nbsp;</span>
				<span>Inventario</span>
			</div>
			<div class="item">
				<span class="handler">&nbsp;</span>
				<span>Seguimiento</span>
			</div>
			<div class="item">
				<span class="handler">&nbsp;</span>
				<span>Mis Requerimientos</span>
			</div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function () {

	});
</script>
<style>
	

	#pages {
		margin: 30px auto;
		width: 100%;
		background-color: #f3f5f7;
		border-radius: 4px;
		border: 1px solid rgba(0,0,0,.1);
		overflow: auto;
	}

	#pages-title {
		height: 60px;
	}

	.item {
		margin: 15px;
		padding: 0 10px 0 0;
		min-width: 150px;
		background-color: #0B90A7;
		border: 1px solid rgba(0,0,0,.1);
		border-radius: 3px;
		font-size: 1.3em;
		line-height: 2.5em;
		height: 100px;
		width: 300px;
		float: left;
		color: White
	}
	.item:hover {
		background-color: #000;
		cursor: pointer;
		border: 1px solid #777
	}

	.handler {
		display: inline-block;
		width: 30px;
		height: 100%;
		margin-right: 10px;
		border-radius: 3px 0 0 3px;
		background: url('../../Styles/images/handle.png') no-repeat 50% 50% #ccc;
		vertical-align: middle
	}
	
	.placeholder {
		width: 100px;
		height: 80px;		
		border: 1px solid #2db245;
	}

	.hint {
		border: 2px solid #2db245;
		border-radius: 6px;
	}

	.hint .handler {
		background-color: #2db245;
	}

</style>
</asp:Content>
