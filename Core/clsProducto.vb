Imports Elx.CommonClass
Imports System.IO

Public Class clsProducto
	Inherits clsEntidad

#Region "CRUD"
	Sub insertar()
		Dim strCx As New StringConex
		Dim strSql As String
		strSql = "INSERT INTO elx_core_producto (idCategoria, idMarca, nombre, descripcion, modelo, codigo, codigoBarra, resumen) VALUES ('$1','$9', '$3', '$4', '$5', '$6', '$7', '$8')"
		strSql = Replace(strSql, "$1", Me.prForm("txtidCategoria"))
		strSql = Replace(strSql, "$9", Me.prForm("txtidMarca"))
		strSql = Replace(strSql, "$3", Me.prForm("txtNombre"))
		strSql = Replace(strSql, "$4", Me.prForm("txtDescripcion"))
		strSql = Replace(strSql, "$5", Me.prForm("txtModelo"))
		strSql = Replace(strSql, "$6", Me.prForm("txtCodigo"))
		strSql = Replace(strSql, "$7", Me.prForm("txtCodigoBarra"))
		strSql = Replace(strSql, "$8", Me.prForm("txtResumen"))
		strCx.ejecutaSql(strSql)
		If strCx.flagError Then
			rsp.estadoError(100, strCx.msgError)
		Else
			rsp.args = "{ ""idProducto"": " & strCx.retornaDato("SELECT max(idProducto) FROM elx_core_producto") & "}"
		End If

	End Sub
	Sub editar()
		Dim strCx As New StringConex
		Dim strSql As String
		strSql = "UPDATE elx_core_producto SET  nombre = '$1', descripcion = '$2', modelo = '$3', codigo = '$4', codigoBarra = '$5', resumen = '$6' WHERE idProducto= $9"
		strSql = Replace(strSql, "$9", Me.prForm("txtidProducto"))
		strSql = Replace(strSql, "$1", Me.prForm("txtNombre"))
		strSql = Replace(strSql, "$2", Me.prForm("txtDescripcion"))
		strSql = Replace(strSql, "$3", Me.prForm("txtModelo"))
		strSql = Replace(strSql, "$4", Me.prForm("txtCodigo"))
		strSql = Replace(strSql, "$5", Me.prForm("txtCodigoBarra"))
		strSql = Replace(strSql, "$6", Me.prForm("txtResumen"))
		strCx.ejecutaSql(strSql)
		If strCx.flagError Then
			rsp.estadoError(100, "Editar: No se pudo acceder a la base")
		End If
	End Sub
	Sub eliminar()
		Dim strCx As New StringConex
		Dim strSql As String
		strSql = "DELETE FROM  elx_core_producto WHERE idProducto =  $1"
		strSql = Replace(strSql, "$1", Me.prGet("txtidProducto"))
		strCx.ejecutaSql(strSql)
		If strCx.flagError Then
			rsp.estadoError(100, "Eliminar: No se pudo acceder a la base")
		End If
	End Sub
	Sub insertarSeccionImagen()
		Dim strCx As New StringConex
		Dim strSql As String
		Dim idSeccion As Integer = 0
		strCx.iniciaTransaccion()

		idSeccion = strCx.retornaDato("select count(*) from elx_core_productoSeccion where idSeccion = " & prForm("idSeccion"))
		If idSeccion = 0 Then
			strSql = "INSERT INTO elx_core_productoSeccion (idSeccion, idProducto) VALUES ($1,$2)"
			strSql = Replace(strSql, "$1", Me.prForm("idSeccion"))
			strSql = Replace(strSql, "$2", Me.prForm("idProducto"))
			strCx.ejecutaSql(strSql)
		End If


		strSql = "INSERT INTO elx_core_seccionImagen (idSeccion, idImagen,x,y,w,h) VALUES ($1,$2,$3, $4,$5,$6)"
		strSql = Replace(strSql, "$1", Me.prForm("idSeccion"))
		strSql = Replace(strSql, "$2", Me.prForm("idImagen"))
		strSql = Replace(strSql, "$3", Me.prForm("x"))
		strSql = Replace(strSql, "$4", Me.prForm("y"))
		strSql = Replace(strSql, "$5", Me.prForm("w"))
		strSql = Replace(strSql, "$6", Me.prForm("h"))
		strCx.ejecutaSql(strSql)
		idSeccion = strCx.retornaDato("select LAST_INSERT_ID()")

		If strCx.flagError Then
			rsp.estadoError(100, strCx.msgError)
		Else
			strCx.finTransaccion()
			rsp.args = "{ ""idSeccionImagen"": " & idSeccion & "}"
		End If

	End Sub

	Sub actualizaSeccionImagen()
		Dim strCx As New StringConex
		Dim strSql As String
		strSql = "UPDATE elx_core_seccionImagen set x = $1, y = $2, w = $3, h = $4 where idSeccionImagen = $5"
		strSql = Replace(strSql, "$1", Me.prForm("x"))
		strSql = Replace(strSql, "$2", Me.prForm("y"))
		strSql = Replace(strSql, "$3", Me.prForm("w"))
		strSql = Replace(strSql, "$4", Me.prForm("h"))
		strSql = Replace(strSql, "$5", Me.prForm("idSeccionImagen"))
		strCx.ejecutaSql(strSql)

		If strCx.flagError Then
			rsp.estadoError(200, strCx.msgError)
		Else
			rsp.args = "{ ""idSeccionImagen"": " & prForm("idSeccionImagen") & "}"
		End If

	End Sub
#End Region
#Region "Vistas de productos"
	Sub lista()
		Dim vFiltro As String = ""
		If Not prForm("txtidProducto") = "" Then
			vFiltro = " and al1.idProducto = " & prForm("idProducto")
		End If

		If Not prForm("idProducto") = "" Then
			vFiltro = " and al1.idProducto = " & prForm("idProducto")
		End If

		If Not prForm("value") = "" Then
			vFiltro = " and nombre like '%" & Me.prForm("value") & "%'"
		End If

		If Not prForm("idMarca") = "" Then vFiltro = vFiltro & "and al1.idMarca = " & Me.prForm("idMarca")
		If Not prForm("idCategoria") = "" Then vFiltro = vFiltro & " and al1.idCategoria = " & Me.prForm("idCategoria")

		If Not prForm("skip") = "" Then
			vFiltro = vFiltro & " limit " & prForm("skip") & ", " & prForm("take")
		Else
			vFiltro = vFiltro & " limit 0 , 30"
		End If

		listaSql("vProductos", vFiltro)
	End Sub
	Sub listaSeccion()
		Dim vFiltro As String = ""
		If Not prForm("idProducto") = "" Then
			vFiltro = " and idProducto = " & prForm("idProducto")
		End If
		listaSql("select * from elx_core_productoSeccion where 1=1 ", vFiltro, False)
	End Sub
	Sub listaImagenSeccion()
		Dim vFiltro As String = ""
		If Not prForm("idImagen") = "" Then
			vFiltro = " and al1.idImagen = " & prForm("idImagen")
		End If
		If Not prForm("idSeccion") = "" Then
			vFiltro = " and al1.idSeccion = " & prForm("idSeccion")
		End If
		If Not prForm("idProducto") = "" Then
			vFiltro = " and al1.idImagen in (select idImagen from elx_core_productoImagen where idProducto = " & prForm("idProducto") & ")"
		End If
		listaSql("vSeccionImagen", vFiltro)
	End Sub
	Sub listaImagen()
		Dim vFiltro As String = ""
		If Not prForm("idProducto") = "" Then
			vFiltro = " and idProducto = " & prForm("idProducto")
		End If
		listaSql("select * from elx_core_productoImagen where 1=1 ", vFiltro, False)
	End Sub

#End Region
#Region "Imagen"
	Sub guardarImagen()
		Dim strCx As New StringConex
		Dim strSql As String
		strCx.iniciaTransaccion()
		If Me.prForm("flagPrincipal") = 1 Then
			strSql = "update elx_core_productoImagen set principal = 0 where idProducto = $1"
			strSql = Replace(strSql, "$1", Me.prForm("idProducto"))
			strCx.ejecutaSql(strSql)
			strSql = "update elx_core_producto set imagen = '$1' where idProducto = $2 "
			strSql = Replace(strSql, "$1", Me.prForm("fileUpload"))
			strSql = Replace(strSql, "$2", Me.prForm("idProducto"))
			strCx.ejecutaSql(strSql)

		End If

		strSql = "INSERT INTO elx_core_productoImagen (idProducto , imagen, principal, descripcion) VALUES ($1, '$2', $3, '$4') "
		strSql = Replace(strSql, "$1", Me.prForm("idProducto"))
		strSql = Replace(strSql, "$2", Me.prForm("fileUpload"))
		strSql = Replace(strSql, "$3", Me.prForm("flagPrincipal"))
		strSql = Replace(strSql, "$4", Me.prForm("informacion"))
		strCx.ejecutaSql(strSql)

		If strCx.flagError Then
			rsp.estadoError(100, "Insertar: No se pudo acceder a la base", strCx.msgError)
		Else
			Dim archivoDestino As String = AppDomain.CurrentDomain.BaseDirectory & "Styles\Productos\" & Me.prForm("fileUpload")
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

#End Region
	
End Class
