Imports Elx.CommonClass

Imports System.IO.Compression
Imports System.Text
Imports System.IO
Imports System.Net.Mail

Public Class Repuesto
	Inherits clsEntidad
	Sub enviarMail()

		'create the mail message
		Dim mail As New MailMessage()

		'set the addresses
		mail.From = New MailAddress("levi.sanchez@vanda.cl", "Levi Sanchez")
		mail.To.Add("lsa1982@gmail.com")

		'set the content
		mail.Subject = "This is an email"

		'first we create the Plain Text part
		Dim plainView As AlternateView = AlternateView.CreateAlternateViewFromString("This is my plain text content, viewable by those clients that don't support html", Nothing, "text/plain")
		'then we create the Html part
		Dim htmlView As AlternateView = AlternateView.CreateAlternateViewFromString("<b>this is bold text, and viewable by those mail clients that support html</b>", Nothing, "text/html")
		mail.AlternateViews.Add(plainView)
		mail.AlternateViews.Add(htmlView)


		'send the message
		Dim smtp As New SmtpClient("mail.vanda.cl", 26)	'specify the mail server address
		smtp.Credentials = New System.Net.NetworkCredential("levi.sanchez@vanda.cl", "levi.sanchez")
		smtp.Send(mail)

		'If Then
		'	respuesta.args = "'msg': 'ok'"
		'Else
		'	respuesta.args = "'msg': 'ERROR'"
		'End If

	End Sub

	Sub insertar()

	End Sub
	Sub lista()
		Dim strCx As New StringConex
		Dim dt As DataTable
		Dim strSql As String
		strSql = "SELECT SQL_CALC_FOUND_ROWS  * FROM ELX_rep_Repuesto"

		If Not prForm("idRepuesto") = "" Then
			strSql = strSql & " where idRepuesto =" & prForm("idRepuesto")
		End If

		If Not prForm("filter[filters][0][field]") = "" Then
			strSql = strSql & " where repuesto like '%" & prForm("filter[filters][0][value]") & "%' "
		End If

		If Not prForm("skip") = "" Then
			strSql = strSql & " limit " & prForm("skip") & ", " & prForm("take")
		End If

		Me.respuesta.totalFila = 1000
		strCx.iniciaTransaccion()
		dt = strCx.retornaDataTable(strSql)
		Me.respuesta.totalFila = strCx.retornaDato("SELECT FOUND_ROWS()")
		strCx.closeConex()
		If strCx.flagError Then
			rsp.estadoError(100, "Lista: No se pudo acceder a la base")
		Else
			rsp.args = Me.retornaTablaSerializada(dt)
		End If
	End Sub

	Sub listaProductoRepuesto()
		If prForm("idProducto") <> "" Then
			listaSql("vProductoRepuesto", " and al1.idProducto = " & prForm("idProducto"))
		Else
			listaSql("vProductoRepuesto")
		End If
	End Sub

	Sub Sincronizacion()
		escribeLog(prForm("envio"))

	End Sub
	Public Shared Sub escribeLog(ByVal strOperacion As String)

		Dim strWr As New StreamWriter(AppDomain.CurrentDomain.BaseDirectory & "\Log\LogSync.txt", True)
		Dim strLog As String
		strLog = "$1: $2"
		strLog = Replace(strLog, "$1", Now())
		strLog = Replace(strLog, "$2", strOperacion)
		strWr.WriteLine(strLog)
		strWr.Close()

	End Sub

End Class
