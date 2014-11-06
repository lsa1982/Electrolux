Imports Elx.CommonClass

Imports System.IO.Compression
Imports System.Text
Imports System.IO


Public Class Repuesto
	Inherits clsEntidad

	Sub insertar()

	End Sub
	Sub insertarMovimiento()
		Dim strCx As New StringConex
		Dim strSql As String
		strCx.iniciaTransaccion()
		Dim detalle() As String
		Dim idMovimiento As Integer

		strSql = "INSERT INTO ELX_REP_inventario VALUES (null, $1, '$2', '$3', '$4', $5) "
		strSql = Replace(strSql, "$1", Me.prForm("idTipoDocumento"))
		strSql = Replace(strSql, "$2", Format(Now(), "yyyy-MM-dd HH:mm:ss"))
		strSql = Replace(strSql, "$3", Me.prForm("referencia"))	' Repuesto
		strSql = Replace(strSql, "$4", Me.prForm("comentario"))	' Producto

		strSql = Replace(strSql, "$5", Me.Rol.idUsuario)
		strCx.ejecutaSql(strSql)

		idMovimiento = strCx.retornaDato("select LAST_INSERT_ID()")
		If idMovimiento < 1 Then
			rsp.estadoError(100, "Insertar: No se pudo acceder a la base", strCx.msgError)
			Exit Sub
		End If

		detalle = Me.prForm("detalle").Split(";")
		For Each d As String In detalle
			If d <> "" Then
				Dim registro() As String = d.Split("|")
				strSql = "INSERT INTO ELX_REP_inventarioDetalle VALUES (null, $1, $2, $3, $4)"
				strSql = Replace(strSql, "$1", idMovimiento)
				strSql = Replace(strSql, "$2", registro(0))	' idRepuesto
				strSql = Replace(strSql, "$3", registro(1))	' cantidad 
				strSql = Replace(strSql, "$4", registro(2))	' valor
				strCx.ejecutaSql(strSql)
				strSql = "update elx_rep_repuesto set cantidad = cantidad + $1 where idRepuesto = $2"
				strSql = Replace(strSql, "$1", registro(1))	' cantidad 
				strSql = Replace(strSql, "$2", registro(0))	' idRepuesto
				strCx.ejecutaSql(strSql)
			End If
		Next
		If strCx.flagError Then
			rsp.estadoError(100, "Insertar: No se pudo acceder a la base", strCx.msgError)
		Else
			strCx.finTransaccion()
			rsp.args = "{ ""OK"": ""OK""}"
		End If
	End Sub
	Sub lista()

		Dim vFiltro As String = ""
		If Not prForm("idRepuesto") = "" Then
			vFiltro = vFiltro & "  and al1.idRepuesto =" & prForm("idRepuesto")
		End If

		If Not prForm("codigo") = "" Then
			vFiltro = vFiltro & "  and al1.codigo = '" & prForm("codigo") & "'"
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

	Sub listaImagen()
		If prForm("idRepuesto") <> "" Then
			listaSql("select * from elx_rep_repuestoimagen where 1=1 ", "and idRepuesto = " & prForm("idRepuesto"), False)
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
	Sub subirImagen()
		If (prFile.Count = 0) Then
			rsp.estadoError(100, "No se pudo subir archivo")
		Else
			If Right(prFile.Item(0).FileName, 3) <> "jpg" And Right(prFile.Item(0).FileName, 3) <> "png" Then
				rsp.estadoError(200, "Extension Incorrecta")
			Else
				Try
					prFile.Item(0).SaveAs(AppDomain.CurrentDomain.BaseDirectory & "Styles\Repuestos\Temp\" & prFile.Item(0).FileName)
					rsp.pagina = prFile.Item(0).FileName
				Catch ex As Exception
					rsp.estadoError(201, ex.Message)
				End Try

			End If
		End If
	End Sub
	Sub guardarImagen()
		Dim strCx As New StringConex
		Dim strSql As String
		strCx.iniciaTransaccion()
		If Me.prForm("flagPrincipal") = 1 Then
			strSql = "update elx_rep_repuestoImagen set principal = 0 where idRepuesto = $1; "
			strSql = Replace(strSql, "$1", Me.prForm("idRepuesto"))
			strCx.ejecutaSql(strSql)
		End If

		strSql = "INSERT INTO elx_rep_repuestoImagen (idRepuesto , imagen, principal, informacion) VALUES ($1, '$2', $3, '$4') "
		strSql = Replace(strSql, "$1", Me.prForm("idRepuesto"))
		strSql = Replace(strSql, "$2", Me.prForm("fileUpload"))
		strSql = Replace(strSql, "$3", Me.prForm("flagPrincipal"))
		strSql = Replace(strSql, "$4", Me.prForm("informacion"))
		strCx.ejecutaSql(strSql)

		If strCx.flagError Then
			rsp.estadoError(100, "Insertar: No se pudo acceder a la base", strCx.msgError)
		Else
			File.Move(AppDomain.CurrentDomain.BaseDirectory & "Styles\Repuestos\Temp\" & Me.prForm("fileUpload"),
			  AppDomain.CurrentDomain.BaseDirectory & "Styles\Repuestos\" & Me.prForm("fileUpload"))
			rsp.args = "{ ""OK"": ""OK""}"
		End If
	End Sub



End Class
