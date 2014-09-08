Imports Elx.CommonClass

Imports System.IO.Compression
Imports System.Text
Imports System.IO

Public Class Linea
	Inherits clsEntidad
	Sub lista()
		Dim strCx As New StringConex
		Dim dt As DataTable
		Dim strSql As String
		strSql = "SELECT SQL_CALC_FOUND_ROWS  * FROM ELX_CORE_Linea"

		If Not prGet("skip") = "" Then
			strSql = strSql & " limit " & prGet("skip") & ", " & prGet("take")
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
End Class
