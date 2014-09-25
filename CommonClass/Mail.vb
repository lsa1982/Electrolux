Imports EASendMail
Imports System.IO
Imports System.Configuration

Public Class Mail
	Private oMail As SmtpMail
	Private oSmtp As SmtpClient
	Private _body As String
	Private _to As String
	Private _subject As String
	Private _html As Boolean = False
	Private _titulo As String
	Private _subTitulo As String
	Private _httpServer As String = ConfigurationSettings.AppSettings("httpServer")

	Public Sub New()
		oMail = New SmtpMail("TryIt")
		oSmtp = New SmtpClient()
	End Sub

#Region "Propiedades"

	Public ReadOnly Property HttpServer As String
		Get
			Return _httpServer
		End Get

	End Property
	Public Property Body As String
		Get
			Return Me._body
		End Get
		Set(ByVal value As String)
			_body = value
		End Set
	End Property
	Public Property [To] As String
		Get
			Return Me._to
		End Get
		Set(ByVal value As String)
			_to = value
		End Set
	End Property
	Public Property Subject As String
		Get
			Return Me._subject
		End Get
		Set(ByVal value As String)
			_subject = value
		End Set
	End Property
	Public Property Html As Boolean
		Get
			Return Me._html
		End Get
		Set(ByVal value As Boolean)
			_html = value
		End Set
	End Property

#End Region
	Public Function Send() As Boolean
		Dim oServer As New SmtpServer("ch1flweb06.chileadmin.com")
		oServer.User = "levi.sanchez@vanda.cl"
		oServer.Password = "levi.sanchez"
		oServer.Port = 465
		oServer.HeloDomain = "vanda.cl"

		oServer.ConnectType = SmtpConnectType.ConnectDirectSSL
		' CONFIGURACION DEL MENSAJE
		oMail.To = _to	'Cuenta de Correo al que se le quiere enviar el e-mail
		oMail.From = "noreply@vanda.cl"
		oMail.Subject = _subject	'Sujeto del e-mail
		oMail.HtmlBody = _body 'contenido del mail
		oMail.ReturnPath = "levi.sanchez@vanda.cl"
		'ENVIO
		Try
			oSmtp.SendMail(oServer, oMail)
			Return True
		Catch ex As System.Net.Mail.SmtpException
			Return False
		End Try

	End Function
	Public Sub Template(ByVal vTemplate As String, ByVal vTitulo As String, ByVal vSubTitulo As String, ByVal vBody As String)

		Dim cidLogo As String
		Dim cidHead As String
		Dim cidFooter As String

		cidLogo = "logoImg" & Format(Now(), "yyyyMMddHHmmssff")
		cidHead = "headImg" & Format(Now(), "yyyyMMddHHmmssff")
		cidFooter = "footImg" & Format(Now(), "yyyyMMddHHmmssff")
		AgregarImagen(AppDomain.CurrentDomain.BaseDirectory & "bin\Mail\Images\logoSoloWhite.png", cidLogo)
		AgregarImagen(AppDomain.CurrentDomain.BaseDirectory & "bin\Mail\Images\headMail.png", cidHead)
		AgregarImagen(AppDomain.CurrentDomain.BaseDirectory & "bin\Mail\Images\footerMail.png", cidFooter)

		vTemplate = AppDomain.CurrentDomain.BaseDirectory & "bin\Mail\" & vTemplate & ".html"
		If File.Exists(vTemplate) Then
			_body = File.ReadAllText(vTemplate)
			_body = Replace(_body, "$IMGLOGO", cidLogo)
			_body = Replace(_body, "$IMGHEAD", cidHead)
			_body = Replace(_body, "$IMGFOOT", cidFooter)
			_body = Replace(_body, "$TITULO", vTitulo)
			_body = Replace(_body, "$SUBTITULO", vSubTitulo)
			_body = Replace(_body, "$BODY", vBody)
		Else
			_body = ""
		End If
	End Sub
	Public Sub AgregarImagen(ByVal vImagen As String, ByVal cid As String)
		Dim oAttachment As Attachment
		oAttachment = oMail.AddAttachment(vImagen)
		oAttachment.ContentID = cid
	End Sub

	

End Class
