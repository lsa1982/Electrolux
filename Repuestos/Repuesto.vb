Imports Elx.CommonClass

Imports System.IO.Compression
Imports System.Text
Imports System.IO


Public Class Repuesto
	Inherits clsEntidad

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
