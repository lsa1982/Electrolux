Imports System.IO
Imports System.Reflection


Public Class clsLog
	Inherits clsEntidad

	Sub lista()
		Dim strRr As New StreamReader(AppDomain.CurrentDomain.BaseDirectory & "\Excel\Log.txt")
		Dim strLog As String
		strLog = strRr.ReadToEnd()
		strLog = Replace(strLog, vbCr, ",")
		strLog = Mid(strLog, 1, Len(strLog) - 2)
		rsp.args = "[" & Replace(strLog, "\", "\\") & "]"
		strRr.Close()
		rsp.totalFila = File.ReadAllLines(AppDomain.CurrentDomain.BaseDirectory & "\Excel\Log.txt").Length
	End Sub

	Public Shared Sub escribeLog(ByVal strOperacion As String, ByVal strMantenedor As String, ByVal strActividad As String, ByVal strDetalle As String)

		Dim strWr As New StreamWriter(AppDomain.CurrentDomain.BaseDirectory & "\Excel\Log.txt", True)
		Dim strLog As String
		strLog = "{'fecha' : '$1', 'Usuario': '$2', 'Operacion':'$3', 'Mantenedor': '$4', 'Actividad' : '$5', 'Detalle':'$6' }"
		strLog = Replace(strLog, "'", """")
		strLog = Replace(strLog, "$1", Now())
		strLog = Replace(strLog, "$2", "")
		strLog = Replace(strLog, "$3", strOperacion)
		strLog = Replace(strLog, "$4", strMantenedor)
		strLog = Replace(strLog, "$5", strActividad)
		strLog = Replace(strLog, "$6", "")
		strWr.WriteLine(strLog)
		strWr.Close()

	End Sub

End Class
