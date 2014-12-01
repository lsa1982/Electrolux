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
		Dim respuesta As HttpResponse = context.Response
		Dim solicitud As HttpRequest = context.Request

		assem = [Assembly].GetExecutingAssembly().GetName().Name
		respuesta.ContentType = "application/json"
		respuesta.AddHeader("Access-Control-Allow-Origin", "*")
		respuesta.AddHeader("HTTP_ACCEPT_ENCODING", "gzip")
		operacionAssem = "Elx." & solicitud.QueryString("assem") & "." & solicitud.QueryString("clase") & "." & solicitud.QueryString("operacion")
		ipAssem = solicitud.ServerVariables("REMOTE_ADDR").ToString()

		Try

			escribeLog(ipAssem, operacionAssem, "Inicio")
			handle = Activator.CreateInstance("Elx." & solicitud.QueryString("assem"), "Elx." & solicitud.QueryString("assem") & "." & solicitud.QueryString("clase"))
			o = handle.Unwrap()
			o.prForm = solicitud.Form
			o.prGet = solicitud.QueryString
			o.prFile = solicitud.Files


			If HttpContext.Current.User.Identity.IsAuthenticated Then
				If IsNothing(solicitud.Cookies("rol")) Or IsNothing(solicitud.Cookies("email")) Or IsNothing(solicitud.Cookies("nombre")) Or IsNothing(solicitud.Cookies("usuario")) Then
					FormsAuthentication.SignOut()
					respuesta.Write(HttpContext.Current.Request.ApplicationPath & "/Login.aspx")
				Else
					o.Rol.SetRol(solicitud.Cookies("rol").Value, solicitud.Cookies("usuario").Value)
					o.Rol.email = solicitud.Cookies("email").Value
					o.Rol.Nombre = solicitud.Cookies("nombre").Value
					escribeLog(solicitud.ServerVariables("REMOTE_ADDR").ToString(), operacionAssem, "Autentificado :" & solicitud.Cookies("usuario").Value)
				End If
			Else
				If solicitud.QueryString("clase") <> "Sesion" Then
					Dim sRol As New Sesion
					o.Rol.SetRol(sRol.retornaRol(solicitud.Form("idUsuario")), solicitud.Form("idUsuario"))
				End If
				
			End If
			CallByName(o, solicitud.QueryString("operacion"), Microsoft.VisualBasic.CallType.Method, Nothing)
			escribeLog(ipAssem, operacionAssem, "Ejecucion")
			rsp = CType(o.respuesta, xhrResponse)
			escribeLog(ipAssem, operacionAssem, "Respuesta: " & rsp.serializarXhr())
			respuesta.Write(rsp.serializarXhr())
			'If rsp.errorState Then context.Response.StatusCode = 200


		Catch ex As Exception
			escribeLog(ipAssem, operacionAssem, "ERROR:" & ex.Message)

			rsp = New xhrResponse("", "")
			rsp.estadoError(900, "Excepcion no contralada", ex.Message)
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