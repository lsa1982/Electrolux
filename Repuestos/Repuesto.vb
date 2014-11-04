Imports Elx.CommonClass

Imports System.IO.Compression
Imports System.Text
Imports System.IO


Public Class Repuesto
	Inherits clsEntidad

	Sub insertar()

	End Sub
	Sub lista()

		Dim vFiltro As String = ""
		If Not prForm("idRepuesto") = "" Then
			vFiltro = vFiltro & "  and al1.idRepuesto =" & prForm("idRepuesto")
		End If

		If prForm("filter[filters][0][field]") = "repuesto" Then
			vFiltro = vFiltro & " and al1.repuesto like '%" & prForm("filter[filters][0][value]") & "%' "
		End If
		If prForm("filter[filters][0][field]") = "codigo" Then
			vFiltro = vFiltro & " and al1.codigo like '%" & prForm("filter[filters][0][value]") & "%' "
		End If


		If Not prForm("skip") = "" Then
			vFiltro = vFiltro & " limit " & prForm("skip") & ", " & prForm("take")
		End If
		listaSql("vRepuesto", vFiltro)
	End Sub

	Sub listaProductoRepuesto()
		If prForm("idProducto") <> "" Then
			listaSql("vProductoRepuesto", " and al1.idProducto = " & prForm("idProducto"))
		ElseIf prForm("filter[filters][0][value]") <> "" Then
			listaSql("vProductoRepuesto", " and al1.idProducto = " & prForm("filter[filters][0][value]") & " limit 0,30")
		Else
			listaSql("vProductoRepuesto", " limit 0,100")
		End If
	End Sub

	Sub listaRepuestoProducto()
		If prForm("idRepuesto") <> "" Then
			listaSql("vRepuestoProducto", " and al1.idRepuesto = " & prForm("idRepuesto"))
		ElseIf prForm("filter[filters][0][value]") <> "" Then
			listaSql("vRepuestoProducto", " and al1.idRepuesto = " & prForm("filter[filters][0][value]") & " limit 0,30")
		Else
			listaSql("vRepuestoProducto", " limit 0,100")
		End If
	End Sub


End Class
