Imports Elx.Seguridad
Public Class Site
	Inherits System.Web.UI.MasterPage

	Public pathAssem As String = ""
	Public usuariosConectados As String = ""
	Public mItem As String = ""
	Public mItemMain As String = ""
	Public mRol As String = ""
	Public mUsuario As String = ""
	Public rolUsuario As New Rol
	Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
		If Not HttpContext.Current.User.Identity.IsAuthenticated Then
			Response.Redirect("Login.aspx")
		Else
			Dim pAssem() As String = Request.Path.Split("/")
			If pAssem.Length > 3 Then
				pathAssem = pAssem(3)
			Else
				Response.Redirect("~/About.aspx?msg=Pagina no encontrada")
			End If
		End If


		Dim m As Modulo
		rolUsuario.SetRol(Request.Cookies("rol").Value, Request.Cookies("usuario").Value)

		m = rolUsuario.Modulos(pathAssem)
		If Not IsNothing(m) Then
			For Each mdo As Modulo In rolUsuario.Modulos.Values
				mItemMain = mItemMain & "{ 'text' : '" & mdo.Name & "', 'value' :'" & mdo.PageDefault & "'}"
			Next
			mItemMain = Replace(mItemMain, "}{", "},{")
			If m.Name = pathAssem Then
				rolUsuario.ActiveModulo = m
				rolUsuario.ActiveMenu = m.Menu(Request.Url.Segments(Request.Url.Segments.Length - 1))

				If m.Menu.Count = 0 Then
					Response.Redirect("~/About.aspx?msg=no tiene menu disponibles")
				Else

					For Each i As Menu In m.Menu.Values
						mItem = mItem & "{ 'text' : '" & i.Name & "', 'value' :'" & i.Page & "'}"
					Next
					mItem = Replace(mItem, "}{", "},{")
					mRol = rolUsuario.Name
					mUsuario = Request.Cookies("nombre").Value

				End If
			Else
				Response.Redirect("~/About.aspx")
			End If
		Else
			Response.Redirect("~/About.aspx")
		End If

		
	End Sub
End Class