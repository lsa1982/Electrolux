Imports Elx.CommonClass


Public Class clsProducto
    Inherits clsEntidad

	Sub lista()
		Dim strCx As New StringConex
		Dim dt As DataTable
		Dim strSql As String


		strSql = "SELECT SQL_CALC_FOUND_ROWS  *, CONCAT(   idProducto ,' - ', nombre ) fullNombre FROM ELX_CORE_Producto"
		If Not prForm("txtidProducto") = "" Then
			strSql = strSql & " WHERE idProducto = " & Me.prGet("txtidProducto")
			strCx.ejecutaSql(strSql)
		End If

		If Not prGet("txtidProducto") = "" Then
			strSql = strSql & " WHERE idProducto = " & Me.prGet("txtidProducto")
			strCx.ejecutaSql(strSql)
		End If

		If Not prForm("value") = "" Then
			strSql = strSql & " WHERE nombre like '%" & Me.prForm("value") & "%'"
			If Not prForm("idMarca") = "" Then strSql = strSql & " idMarca = " & Me.prForm("idMarca")
			If Not prForm("idCategoria") = "" Then strSql = strSql & " idCategoria = " & Me.prForm("idCategoria")
			strCx.ejecutaSql(strSql & " limit 0 , 30")
		End If

		dt = strCx.retornaDataTable(strSql)

		If strCx.flagError Then
			rsp.estadoError(100, "Lista: No se pudo acceder a la base")
		Else
			rsp.totalFila = dt.Rows.Count
			rsp.args = Me.retornaTablaSerializada(dt)
		End If
	End Sub

    Sub insertar()
        Dim strCx As New StringConex
        Dim strSql As String
        strSql = "INSERT INTO elx_core_producto (idCategoria, idLinea, nombre, descripcion, modelo, codigo, codigoBarra, resumen) VALUES ('$1', '$2', '$3', '$4', '$5', '$6', '$7', '$8')"
        strSql = Replace(strSql, "$1", Me.prForm("txtidCategoria"))
        strSql = Replace(strSql, "$2", Me.prForm("txtidLinea"))
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
		strSql = "UPDATE elx_core_producto SET  idCategoria = '$1', idLinea = '$2', nombre = '$3', descripcion = '$4', modelo = '$5', codigo = '$6', codigoBarra '$7', resumen = '$8' WHERE idProducto= '$9'"
		strSql = Replace(strSql, "$9", Me.prGet("txtidProducto"))
		strSql = Replace(strSql, "$1", Me.prGet("txtidCategoria"))
		strSql = Replace(strSql, "$2", Me.prGet("txtidLinea"))
		strSql = Replace(strSql, "$3", Me.prGet("txtNombre"))
		strSql = Replace(strSql, "$3", Me.prGet("txtDescripcio"))
		strSql = Replace(strSql, "$3", Me.prGet("txtModelo"))
		strSql = Replace(strSql, "$3", Me.prGet("txtCodigo"))
		strSql = Replace(strSql, "$3", Me.prGet("txtCodigoBarra"))
		strSql = Replace(strSql, "$3", Me.prGet("txtResumen"))
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

End Class
