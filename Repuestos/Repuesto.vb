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
		strSql = "SELECT SQL_CALC_FOUND_ROWS  idRepuesto, idCategoria ,codigo ,repuesto, imagen, cantidad FROM ELX_rep_Repuesto"

		If Not prForm("idRepuesto") = "" Then
			strSql = strSql & " where idRepuesto =" & prForm("idRepuesto")
		End If

		If Not prForm("filter[filters][0][field]") = "" Then
			strSql = strSql & " where repuesto like '%" & prForm("filter[filters][0][value]") & "%' "
		End If

		If Not prForm("skip") = "" Then
			strSql = strSql & " limit " & prForm("skip") & ", " & prForm("take")
		End If

		strCx.iniciaTransaccion()
		dt = strCx.retornaDataTable(strSql)
		Me.respuesta.totalFila = strCx.retornaDato("SELECT FOUND_ROWS()")
		strCx.closeConex()
		If strCx.flagError Then
			rsp.estadoError(100, "Lista: No se pudo acceder a la base", strCx.msgError)
		Else
			rsp.args = Me.retornaTablaSerializada(dt)
		End If
	End Sub

	Sub listaProductoRepuesto()
		If prForm("idProducto") <> "" Then
			listaSql("vProductoRepuesto", " and al1.idProducto = " & prForm("idProducto"))
		ElseIf prForm("filter[filters][0][value]") <> "" Then
			listaSql("vProductoRepuesto", " and al1.idProducto = " & prForm("filter[filters][0][value]") & " limit 0,30")
		Else
			listaSql("vProductoRepuesto", " limit 0,30")
		End If
	End Sub

	Sub listaRepuestoProducto()
		If prForm("idRepuesto") <> "" Then
			listaSql("vRepuestoProducto", " and al1.idRepuesto = " & prForm("idRepuesto"))
		ElseIf prForm("filter[filters][0][value]") <> "" Then
			listaSql("vRepuestoProducto", " and al1.idRepuesto = " & prForm("filter[filters][0][value]") & " limit 0,30")
		Else
			listaSql("vRepuestoProducto", " limit 0,30")
		End If
	End Sub


End Class
