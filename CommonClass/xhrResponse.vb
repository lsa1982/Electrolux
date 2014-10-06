

Public Class xhrResponse
	Public pagina As String
	Public errorState As Boolean = False
	Public msgState As String
	Public errorCode As Integer = 0
	Public args As String
	Public totalFila As Integer = 0


	Sub New()

	End Sub

	Sub New(ByVal pPagina As String, ByVal pArgs As String)
		pagina = pPagina
		args = pArgs
	End Sub

	Function serializarXhr() As String
		Dim strXhr As String
		strXhr = "{ ""errorCode"" :  " & Me.errorCode & ","
		strXhr = strXhr & """errorState"" :  """ & Me.errorState & ""","
		strXhr = strXhr & """msgState"" :  """ & Me.msgState & ""","
		strXhr = strXhr & """pagina"" :  """ & Me.pagina & ""","
		strXhr = strXhr & """totalFila"" :  " & Me.totalFila & ""

		If Me.args <> "" Then
			strXhr = strXhr & ", ""args"" :  " & Me.args
		End If
		strXhr = strXhr & " }"
		serializarXhr = strXhr
	End Function

	Sub estadoError(ByVal codigoError As Integer, ByVal msgError As String, Optional ByVal argsError As String = "")
		Me.errorCode = codigoError
		Me.errorState = True
		Me.msgState = msgError
		argsError = Replace(argsError, vbCr, " ")
		argsError = Replace(argsError, vbLf, " ")
		argsError = Replace(argsError, vbTab, " ")
		argsError = Replace(argsError, """", "°")
		Me.args = "{ ""techError"": """ & argsError & """ }"
	End Sub

End Class
