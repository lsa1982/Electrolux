Imports System.Web
Imports System.Web.Services
Imports System.Reflection
Imports System.Runtime.Remoting
Imports System.Net
Imports System.IO
Imports Elx.CommonClass
Imports Elx.Repuestos

Public Class InterOpX
	Implements IHttpHandler

	Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
		Dim o As Object
		Dim assem As String
		Dim handle As ObjectHandle
		Dim rsp As xhrResponse


		assem = [Assembly].GetExecutingAssembly().GetName().Name
		context.Response.ContentType = "application/json"
		context.Response.AddHeader("Access-Control-Allow-Origin", "*")
		context.Response.AddHeader("HTTP_ACCEPT_ENCODING", "gzip")

		Try

			handle = Activator.CreateInstance("Elx." & context.Request.QueryString("assem"), "Elx." & context.Request.QueryString("assem") & "." & context.Request.QueryString("clase"))
			o = handle.Unwrap()
			o.prForm = context.Request.Form
			o.prGet = context.Request.QueryString
			o.prFile = context.Request.Files
			If HttpContext.Current.User.Identity.IsAuthenticated Then
				o.Rol.SetRol(context.Request.Cookies("rol").Value, context.Request.Cookies("usuario").Value)
				o.Rol.email = context.Request.Cookies("email").Value
				o.Rol.Nombre = context.Request.Cookies("nombre").Value
			End If
			'o.usuarioRemoto = System.Net.Dns.GetHostEntry(context.Request.UserHostAddress).HostName
			CallByName(o, context.Request.QueryString("operacion"), Microsoft.VisualBasic.CallType.Method, Nothing)
			rsp = CType(o.respuesta, xhrResponse)
			context.Response.Write(rsp.serializarXhr())

		Catch ex As Exception
			rsp = New xhrResponse("", "")
			rsp.estadoError(100, ex.Message)
			context.Response.Write(rsp.serializarXhr())

		End Try

	End Sub

	ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
		Get
			Return False
		End Get
	End Property

End Class