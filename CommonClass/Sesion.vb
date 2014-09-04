Imports System
Imports System.Web
Imports System.Security.Principal
Imports System.Web.Security
Imports System.Security.Cryptography
Imports System.Text
Imports Elx.CommonClass

Public Class Sesion
	Inherits clsEntidad


	Dim strCx As StringConex
	Public Sub New()
		strCx = New StringConex
	End Sub

	Public Sub SesionOut()
		FormsAuthentication.SignOut()
		rsp.pagina = HttpContext.Current.Request.ApplicationPath & "/Login.aspx"
		rsp.args = "{ ""SesionOut"": ""OK""}"

	End Sub

	Public Sub SesionIn()
		Dim tkt As FormsAuthenticationTicket
		Dim ck As HttpCookie
		Dim cookiestr As String
		Dim strRedirect As String

		Dim strCx As New StringConex
		Dim dt As DataTable

		dt = strCx.retornaDataTable("select idUsuario, password, idRol, nombre, apellido, cargo from elx_hr_personal where usuario  = '" & prForm("txtUser") & "'")

		If dt.Rows.Count > 0 Then
			If validaUsuario(prForm("txtUser"), prForm("txtPass"), dt.Rows(0).Item("password")) Then
				If dt.Rows(0).Item("idRol") > 0 Then
					tkt = New FormsAuthenticationTicket(1, "User", DateTime.Now, DateTime.Now.AddMinutes(30), True, "your custom data")

					cookiestr = FormsAuthentication.Encrypt(tkt)
					ck = New HttpCookie(FormsAuthentication.FormsCookieName, cookiestr)
					'If chkPersistCookie.Checked Then
					'ck.Expires = tkt.Expiration
					ck.Path = FormsAuthentication.FormsCookiePath
					HttpContext.Current.Response.Cookies.Add(ck)

					ck = New HttpCookie("rol", dt.Rows(0).Item("idRol"))
					HttpContext.Current.Response.Cookies.Add(ck)

					ck = New HttpCookie("usuario", dt.Rows(0).Item("idUsuario"))
					HttpContext.Current.Response.Cookies.Add(ck)

					ck = New HttpCookie("nombre", dt.Rows(0).Item("nombre") & " " & dt.Rows(0).Item("apellido"))
					HttpContext.Current.Response.Cookies.Add(ck)

					strRedirect = prGet("ReturnUrl")
					If strRedirect = "" Then
						strRedirect = "Modulos/Repuestos/default.aspx"
					End If
					rsp.pagina = strRedirect
					rsp.args = "{ ""Sesion"": ""OK""}"
				Else
					rsp.estadoError(200, "Seguridad: Usuario sin Rol")
				End If

			Else
				rsp.estadoError(100, "Seguridad: Usuario no valido")
			End If
		Else
			rsp.estadoError(300, "Seguridad: Usuario no existe")
		End If
		

	End Sub

	
	Function validaUsuario(ByVal user As String, ByVal passUrl As String, ByVal passDb As String) As Boolean
		Dim strCx As New StringConex
		Dim md5Hash As MD5 = MD5.Create()
		Dim hash As String = GetMd5Hash(md5Hash, passUrl)
		validaUsuario = False
		If passDb = hash Then validaUsuario = True

	End Function

	

	Shared Function GetMd5Hash(ByVal md5Hash As MD5, ByVal input As String) As String

		Dim data As Byte() = md5Hash.ComputeHash(Encoding.UTF8.GetBytes(input))
		Dim sBuilder As New StringBuilder()

		Dim i As Integer
		For i = 0 To data.Length - 1
			sBuilder.Append(data(i).ToString("x2"))
		Next i

		Return sBuilder.ToString()

	End Function

End Class
