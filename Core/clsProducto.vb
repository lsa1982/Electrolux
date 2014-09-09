Imports Elx.CommonClass


Public Class clsProducto
    Inherits clsEntidad

    Sub lista()
        Dim vFiltro As String = ""

        If Not prForm("txtidProducto") = "" Then
            vFiltro = " and al1.idProducto = " & prForm("idProducto")
        End If

        If Not prGet("txtidProducto") = "" Then
            vFiltro = " and al1.idProducto = " & prForm("idProducto")
        End If

        If Not prForm("value") = "" Then
            vFiltro = " and nombre like '%" & Me.prForm("value") & "%'"

		End If
		If Not prForm("idMarca") = "" Then vFiltro = vFiltro & "and  al1.idMarca = " & Me.prForm("idMarca")
		If Not prForm("idCategoria") = "" Then vFiltro = vFiltro & " and  al1.idCategoria = " & Me.prForm("idCategoria")
		vFiltro = vFiltro & " limit 0 , 30"

		listaSql("vProductos", vFiltro)
	End Sub

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

End Class
