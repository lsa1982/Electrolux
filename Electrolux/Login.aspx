<%@ Page Language="vb" AutoEventWireup="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Coordinador de Tareas</title>
    <link href="~/Kendo/Site.css" rel="stylesheet" type="text/css" />
    <link href="~/Kendo/styles/kendo.common.min.css" rel="stylesheet" type="text/css" />
    <link href="~/Kendo/styles/kendo.silver.min.css" rel="stylesheet" type="text/css" />
    <script src="<% = resolveClientUrl("Kendo/js/jquery.min.js") %>" type="text/javascript"></script>
    <script src="<% = resolveClientUrl("Kendo/js/kendo.web.min.js") %>" type="text/javascript"></script>
    <script src="<% = resolveClientUrl("Kendo/XHR.js")%>" type="text/javascript"></script>  

</head>
<body>
<div id="mensaje" class="msgLogin">
aloooooooo
</div>
<div id="app" class="formLogin">
	<form id="frmInicio">
		<table style=" width:100%">
			<tr>
				<td>
					<img src="Styles/images/logoMain.png" height="45px" width="230px" />
				</td>
			</tr>
			<tr>
				<td>
					<span style=" font-size: 16px; font-weight: bold; font-family: Verdana">Inicio de Sesión</span>
				</td>
			</tr>
			<tr>
				<td>
					<input type="hidden" id="ReturnUrl" />
					<input type="text" class="k-textbox" name="txtUser" id="txtUser" 
					 placeholder="Usuario" required="required" validationMessage="Ingrese Usuario"/>
				</td>
			</tr>
			<tr>
				<td>
					<input type="password" class="k-textbox" name="txtPass" id="txtPass" 
						placeholder="Password" required="required" validationMessage="Ingrese Password"/>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" id="txtConectado" /> Mantenerme Conectado
				</td>
			</tr>
			<tr>
				<td>
					<button id="btnBuscar" type="button" class="k-button">Iniciar Sesion</button>
				</td>
			</tr>
		</table>
	</form>
	 <div id="window">Espere Mientras se actualizan los datos</div>
</div>

<script>
	var assem = 'CommonClass';
	$(document).ready(function () {
		$("#btnBuscar").kendoButton({ click: onClick });
		function onClick(e) {
			var validator = $("#frmInicio").kendoValidator().data("kendoValidator"), status = $(".status");
			enviaForm(validator, 'frmInicio', 'Sesion', 'SesionIn');
		}
		$("#window").kendoWindow({
			width: "600px",
			position: {
				top: "300px",
				left: "400px"
			},
			title: "Esperando",
			actions: ["Close"],
			visible: false,
			modal: true
		});
		$("#mensaje").hide();
		$("#mensaje").click(function (e) {
			$("#mensaje").hide(500);
		});

		var vGet = getVarsUrl();
		if (typeof vGet.ReturnUrl != "undefined") 
			ReturnUrl.value = vGet.ReturnUrl;

	});

</script>

<style scoped>
	body {
		background-color: #FFFFFF;
		width: 100%;
		height: 100%;
	}

	html {
		width: 100%;
		height: 100%;
	}
	
	td{
		padding: 5px;
	}
	
	.formLogin {
		width: 340px;
		height: 320px;
		background-color: #EEEEEE;
		border-radius: 8px;
		 position: absolute;
		left: 50%;
		top: 50%;
		margin-top: -160px;
		margin-left: -170px;
		overflow: auto;
		border: 1px solid #DDDDDD;
		text-align: center;
		}
	
	.msgLogin {
		width: 340px;
		height: 30px;
		background-color: #FF0000;
		border-radius: 8px;
		position: absolute;
		left: 50%;
		top: 50%;
		margin-top: -200px;
		margin-left: -170px;
		overflow: auto;
		border: 0px solid #DDDDDD;
		text-align: center;
		color: White;
		padding-top: 5px
		}
		
		
	.k-textbox {
		font-size: 18px;
		padding: 3px;
		
		}
	.k-button{
		width: 86%;
		padding: 3px;
		font-size: 18px;
		background-color: Blue ;
		color: White;
		border: 0px;
	}
	
</style>
</body>
</html>
