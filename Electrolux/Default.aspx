<%@ Page Title="Página principal" Language="vb" %>

<script runat="server">
	Sub page_load()
		If Not HttpContext.Current.User.Identity.IsAuthenticated Then
			Response.Redirect("~/Login.aspx")
		Else
			Response.Redirect("~/Modulos/Repuestos/Default.aspx")
		End If
	End Sub
</script>