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

	Public Function retornaRol(ByVal idUsuario As Integer) As Integer
		strCx = New StringConex
		Dim dt As DataTable

		dt = strCx.retornaDataTable("select  idRol from elx_hr_personal where idUsuario  = '" & idUsuario & "'")
		If Not IsNothing(dt) Then
			retornaRol = dt.Rows(0).Item("idRol")
		Else
			retornaRol = 0
		End If
	End Function

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

		Dim drUsuario As DataRow
		Dim drRol As DataRow
		drUsuario = strCx.retornaDataRow("select idUsuario, password, nombre, apellido, cargo, email from elx_hr_personal where usuario  = '" & prForm("txtUser") & "'")

		If Not IsNothing(drUsuario) Then
			If validaUsuario(prForm("txtUser"), prForm("txtPass"), drUsuario("password")) Then
				drRol = strCx.retornaDataRow("select idTipoUsuario, idRol from elx_hr_rol where idUsuario =  " & drUsuario("idUsuario"))
				If Not IsNothing(drRol) Then
					If prForm("txtConectado") = "on" Then
						tkt = New FormsAuthenticationTicket(1, "User", DateTime.Now, New Date(3000, 12, 31), True, "your custom data")
					Else
						tkt = New FormsAuthenticationTicket(1, "User", DateTime.Now, New Date(3000, 12, 31), False, "your custom data")
					End If

					cookiestr = FormsAuthentication.Encrypt(tkt)
					ck = New HttpCookie(FormsAuthentication.FormsCookieName, cookiestr)
					ck.Path = FormsAuthentication.FormsCookiePath
					HttpContext.Current.Response.Cookies.Add(ck)

					ck = New HttpCookie("rol", drRol("idTipoUsuario"))
					HttpContext.Current.Response.Cookies.Add(ck)

					ck = New HttpCookie("usuario", drUsuario("idUsuario"))
					HttpContext.Current.Response.Cookies.Add(ck)

					ck = New HttpCookie("nombre", drUsuario("nombre") & " " & drUsuario("apellido"))
					HttpContext.Current.Response.Cookies.Add(ck)

					HttpContext.Current.Response.Cookies.Add(ck)

					strRedirect = prForm("ReturnUrl")
					If strRedirect = "" Then
						strRedirect = "Modulos/Repuestos/default.aspx"
					End If

					rsp.pagina = Replace(HttpUtility.UrlDecode(strRedirect), "/Electrolux/", "")
					rsp.args = "{ 'Sesion': 'OK', 'idUsuario' : $1 , 'idTipoUsuario': $2, 'idRol' : $3}"
					rsp.args = Replace(rsp.args, "$1", drRol("idTipoUsuario"))
					rsp.args = Replace(rsp.args, "$2", drUsuario("idUsuario"))
					rsp.args = Replace(rsp.args, "$3", drRol("idRol"))
					rsp.args = Replace(rsp.args, "'", """")
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
