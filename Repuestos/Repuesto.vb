Imports Elx.CommonClass


Imports System.IO


Public Class Repuesto
	Inherits clsEntidad
#Region "CRUD"

	Sub insertar()
		Dim strCx As New StringConex
		Dim strSql As String
		Dim idRepuesto As Integer
		strCx.iniciaTransaccion()
		strSql = "INSERT INTO elx_rep_repuesto (idCategoria, idGrupo, codigo , repuesto, valor, cantidad) VALUES ($1, $2, '$3', '$4', 0,0) "
		strSql = Replace(strSql, "$1", Me.prForm("txtCategoria"))
		strSql = Replace(strSql, "$2", Me.prForm("txtGrupo"))
		strSql = Replace(strSql, "$3", Me.prForm("txtCodigo"))
		strSql = Replace(strSql, "$4", Me.prForm("txtRepuesto"))
		strCx.ejecutaSql(strSql)
		idRepuesto = strCx.retornaDato("select LAST_INSERT_ID()")

		If strCx.flagError Then
			rsp.estadoError(100, "Insertar: No se pudo acceder a la base", strCx.msgError)
		Else
			strCx.finTransaccion()
			rsp.args = "{ ""idRepuesto"": """ & idRepuesto & """}"
		End If
	End Sub
	Sub actualizar()
		Dim strCx As New StringConex
		Dim strSql As String

		strSql = "update elx_rep_repuesto set idCategoria = $1, idGrupo = $2, codigo = '$3' , repuesto = '$4' where idRepuesto = $5"
		strSql = Replace(strSql, "$1", Me.prForm("txtCategoria"))
		strSql = Replace(strSql, "$2", Me.prForm("txtGrupo"))
		strSql = Replace(strSql, "$3", Me.prForm("txtCodigo"))
		strSql = Replace(strSql, "$4", Me.prForm("txtRepuesto"))
		strSql = Replace(strSql, "$5", Me.prForm("idRepuesto"))
		strCx.ejecutaSql(strSql)

		If strCx.flagError Then
			rsp.estadoError(200, "Actualiza: No se pudo acceder a la base", strCx.msgError)
		Else
			rsp.args = "{ ""idRepuesto"": """ & Me.prForm("idRepuesto") & """}"
		End If
	End Sub
	Sub eliminar()
		Dim strCx As New StringConex
		Dim strSql As String

		strSql = "DELETE FROM elx_rep_repuesto WHERE idRepuesto = $1"
		strSql = Replace(strSql, "$1", Me.prForm("idRepuesto"))
		strCx.ejecutaSql(strSql)

		If strCx.flagError Then
			rsp.estadoError(100, "Eliminar: No se pudo acceder a la base", strCx.msgError)
		Else
			rsp.args = "{ ""OK"": ""OK""}"
		End If
	End Sub
	Sub eliminarProducto()
		Dim strCx As New StringConex
		Dim strSql As String

		strSql = "DELETE FROM elx_rep_productoRepuesto WHERE idProductoRepuesto = $1"
		strSql = Replace(strSql, "$1", Me.prForm("idProductoRepuesto"))
		strCx.ejecutaSql(strSql)

		If strCx.flagError Then
			rsp.estadoError(100, "Eliminar: No se pudo acceder a la base", strCx.msgError)
		Else
			rsp.args = "{ ""OK"": ""OK""}"
		End If
	End Sub
	Sub insertarProducto()
		Dim strCx As New StringConex
		Dim strSql As String
		strSql = "INSERT INTO elx_rep_productorepuesto  (idProducto, idRepuesto, idSeccion) VALUES ($1, $2, $3) "
		strSql = Replace(strSql, "$1", Me.prForm("idProducto"))
		strSql = Replace(strSql, "$2", Me.prForm("idRepuesto"))
		strSql = Replace(strSql, "$3", Me.prForm("idSeccion"))
		strCx.ejecutaSql(strSql)

		If strCx.flagError Then
			rsp.estadoError(100, "Insertar: No se pudo acceder a la base", strCx.msgError)
		Else
			rsp.args = "{ ""idRepuesto"": """ & Me.prForm("idRepuesto") & """}"
		End If
	End Sub

	Sub modificarSeccion()
		Dim strCx As New StringConex
		Dim strSql As String
		strSql = "UPDATE elx_rep_productorepuesto SET idSeccion = $1 WHERE idProductoRepuesto = $2"
		strSql = Replace(strSql, "$1", Me.prForm("idSeccion"))
		strSql = Replace(strSql, "$2", Me.prForm("idProductoRepuesto"))
		strCx.ejecutaSql(strSql)

		If strCx.flagError Then
			rsp.estadoError(200, "Actualizar: No se pudo acceder a la base", strCx.msgError)
		Else
			rsp.args = "{ ""idProductoRepuesto"": """ & Me.prForm("idProductoRepuesto") & """}"
		End If
	End Sub
#End Region
#Region "Vistas de Repuestos"
	Sub lista()

		Dim vFiltro As String = ""
		If Not prForm("idProducto") = "" Then
			vFiltro = vFiltro & "  and al1.idRepuesto in ( select idRepuesto from elx_rep_productorepuesto where idProducto =" & prForm("idProducto") & ")"
		End If
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
	Sub listaNatural()

		Dim vFiltro As String = ""
		If Not prForm("idRepuesto") = "" Then
			vFiltro = vFiltro & " and idRepuesto =" & prForm("idRepuesto")
		End If

		listaSql("select * from elx_rep_repuesto where 1=1 ", vFiltro, False)
	End Sub
	Sub listaProductoRepuesto()
		If prForm("idProducto") <> "" Then
			listaSql("vProductoRepuesto", " and al1.idProducto = " & prForm("idProducto"))
		ElseIf prForm("filter[filters][0][value]") <> "" Then
			listaSql("vProductoRepuesto", " and al1.idProducto = " & prForm("filter[filters][0][value]") & " limit 0,30")
		ElseIf prForm("idSeccion") <> "" Then
			listaSql("vProductoRepuesto", " and al1.idSeccion = " & prForm("idSeccion"))
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
	Sub listaInventario()
		If prForm("idRepuesto") <> "" Then
			listaSql("vInventarioRepuesto", " and al3.idRepuesto = " & prForm("idRepuesto"))
		End If
	End Sub
#End Region
#Region "Imagen"
	'Sub subirImagen()
	'	If (prFile.Count = 0) Then
	'		rsp.estadoError(100, "No se pudo subir archivo")
	'	Else
	'		If Right(prFile.Item(0).FileName, 3) <> "jpg" And Right(prFile.Item(0).FileName, 3) <> "png" Then
	'			rsp.estadoError(200, "Extension Incorrecta")
	'		Else
	'			Try
	'				prFile.Item(0).SaveAs(AppDomain.CurrentDomain.BaseDirectory & "Styles\Repuestos\Temp\" & prFile.Item(0).FileName)
	'				rsp.pagina = prFile.Item(0).FileName
	'			Catch ex As Exception
	'				rsp.estadoError(201, ex.Message)
	'			End Try

	'		End If
	'	End If
	'End Sub
	Sub guardarImagen()
		Dim strCx As New StringConex
		Dim strSql As String
		strCx.iniciaTransaccion()
		If Me.prForm("flagPrincipal") = 1 Then
			strSql = "update elx_rep_repuestoImagen set principal = 0 where idRepuesto = $1"
			strSql = Replace(strSql, "$1", Me.prForm("idRepuesto"))
			strCx.ejecutaSql(strSql)
			strSql = "update elx_rep_repuesto set imagen = '$1' where idRepuesto = $2 "
			strSql = Replace(strSql, "$1", Me.prForm("fileUpload"))
			strSql = Replace(strSql, "$2", Me.prForm("idRepuesto"))
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
			Dim archivoDestino As String = AppDomain.CurrentDomain.BaseDirectory & "Styles\Repuestos\" & Me.prForm("fileUpload")
			Dim archivoOrigen As String = AppDomain.CurrentDomain.BaseDirectory & "Styles\Temp\" & Me.prForm("fileUpload")
			If File.Exists(archivoDestino) Then
				File.Delete(archivoDestino)
			End If
			If Not File.Exists(archivoOrigen) Then
				rsp.estadoError(100, "Insertar: No se pudo acceder a la base", strCx.msgError)
			Else
				File.Move(archivoOrigen, archivoDestino)
				strCx.finTransaccion()
				rsp.args = "{ ""OK"": ""OK""}"
			End If


		End If
	End Sub
	Sub eliminarImagen()
		Dim strCx As New StringConex
		Dim strSql As String

		strSql = "DELETE FROM elx_rep_repuestoImagen  WHERE idImagen = $1"
		strSql = Replace(strSql, "$1", Me.prForm("idImagen"))
		strCx.ejecutaSql(strSql)

		If strCx.flagError Then
			rsp.estadoError(100, "Eliminar: No se pudo acceder a la base", strCx.msgError)
		Else
			rsp.args = "{ ""OK"": ""OK""}"
		End If
	End Sub
	Sub marcaImagen()
		Dim strCx As New StringConex
		Dim strSql As String
		strCx.iniciaTransaccion()
		strSql = "update elx_rep_repuestoImagen set principal = 0 WHERE idRepuesto = $1"
		strSql = Replace(strSql, "$1", Me.prForm("idRepuesto"))
		strCx.ejecutaSql(strSql)

		strSql = "update elx_rep_repuestoImagen set principal = 1 WHERE idImagen = $1"
		strSql = Replace(strSql, "$1", Me.prForm("idImagen"))
		strCx.ejecutaSql(strSql)

		If strCx.flagError Then
			rsp.estadoError(100, "Eliminar: No se pudo acceder a la base", strCx.msgError)
		Else
			strCx.finTransaccion()
			rsp.args = "{ ""OK"": ""OK""}"
		End If
	End Sub

#End Region
#Region "Inventario"
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
#End Region



End Class
