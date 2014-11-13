Imports System.Web
Imports System.Web.Services
Imports System.Reflection
Imports System.Runtime.Remoting
Imports System.Net
Imports System.IO
Imports Elx.CommonClass


Public Class InterOpX
	Implements IHttpHandler

	Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
		Dim o As Object
		Dim assem As String
		Dim handle As ObjectHandle
		Dim rsp As xhrResponse
		Dim operacionAssem As String
		Dim ipAssem As String

		assem = [Assembly].GetExecutingAssembly().GetName().Name
		context.Response.ContentType = "application/json"
		context.Response.AddHeader("Access-Control-Allow-Origin", "*")
		context.Response.AddHeader("HTTP_ACCEPT_ENCODING", "gzip")
		operacionAssem = "Elx." & context.Request.QueryString("assem") & "." & context.Request.QueryString("clase") & "." & context.Request.QueryString("operacion")
		ipAssem = context.Request.ServerVariables("REMOTE_ADDR").ToString()

		Try

			escribeLog(ipAssem, operacionAssem, "Inicio")
			handle = Activator.CreateInstance("Elx." & context.Request.QueryString("assem"), "Elx." & context.Request.QueryString("assem") & "." & context.Request.QueryString("clase"))
			o = handle.Unwrap()
			o.prForm = context.Request.Form
			o.prGet = context.Request.QueryString
			o.prFile = context.Request.Files
			If HttpContext.Current.User.Identity.IsAuthenticated Then
				If IsNothing(context.Request.Cookies("rol")) Or IsNothing(context.Request.Cookies("email")) Or IsNothing(context.Request.Cookies("nombre")) Or IsNothing(context.Request.Cookies("usuario")) Then
					FormsAuthentication.SignOut()
					context.Response.Write(HttpContext.Current.Request.ApplicationPath & "/Login.aspx")
				Else
					o.Rol.SetRol(context.Request.Cookies("rol").Value, context.Request.Cookies("usuario").Value)
					o.Rol.email = context.Request.Cookies("email").Value
					o.Rol.Nombre = context.Request.Cookies("nombre").Value
					escribeLog(context.Request.ServerVariables("REMOTE_ADDR").ToString(), operacionAssem, "Autentificado :" & context.Request.Cookies("usuario").Value)
				End If

				
			End If
			'o.usuarioRemoto = System.Net.Dns.GetHostEntry(context.Request.UserHostAddress).HostName
			CallByName(o, context.Request.QueryString("operacion"), Microsoft.VisualBasic.CallType.Method, Nothing)
			escribeLog(ipAssem, operacionAssem, "Ejecucion")
			rsp = CType(o.respuesta, xhrResponse)
			escribeLog(ipAssem, operacionAssem, "Respuesta: " & rsp.serializarXhr())
			context.Response.Write(rsp.serializarXhr())
			If rsp.errorState Then context.Response.StatusCode = 550

		Catch ex As Exception
			escribeLog(ipAssem, operacionAssem, "ERROR:" & ex.Message)
			rsp = New xhrResponse("", "")
			rsp.estadoError(100, ex.Message)
			context.Response.StatusCode = 550
			context.Response.Write(rsp.serializarXhr())
		End Try

	End Sub

	ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
		Get
			Return False
		End Get
	End Property

	Sub escribeLog(ByVal vIpAdress As String, ByVal vParam As String, ByVal vOperacion As String)
		Try
			Dim strWr As New StreamWriter(AppDomain.CurrentDomain.BaseDirectory & "\Log\LogInterOp.txt", True)
			Dim strLog As String
			strLog = "[$1][$2][$3] $4 }"
			strLog = Replace(strLog, "'", """")
			strLog = Replace(strLog, "$1", Now())
			strLog = Replace(strLog, "$2", vIpAdress)
			strLog = Replace(strLog, "$3", vParam)
			strLog = Replace(strLog, "$4", vOperacion)
			strWr.WriteLine(strLog)
			strWr.Close()
		Catch ex As Exception

		End Try
		
	End Sub

End Class