Imports Elx.CommonClass


Public Class clsMarca
    Inherits clsEntidad

    Sub lista()
        Dim strCx As New StringConex
        Dim dt As DataTable
        Dim strSql As String
       

        strSql = "SELECT * FROM elx_core_marca"
        If Not prForm("txtidMarca") = "" Then
            strSql = strSql & " WHERE idMarca = " & Me.prGet("txtidMarca")
            strCx.ejecutaSql(strSql)
        End If

        If Not prGet("txtidMarca") = "" Then
            strSql = strSql & " WHERE idMarca = " & Me.prGet("txtidMarca")
            strCx.ejecutaSql(strSql)
        End If

        dt = strCx.retornaDataTable(strSql)

        If strCx.flagError Then
            rsp.estadoError(100, "Lista: No se pudo acceder a la base")
        Else
            rsp.totalFila = dt.Rows.Count
            rsp.args = Me.retornaTablaSerializada(dt)
            Debug.Print(rsp.args)
        End If
    End Sub
    Sub insertar()
        Dim strCx As New StringConex
        Dim strSql As String
        strSql = "INSERT INTO elx_core_marca (marca, orden, imagen) VALUES ('$1', '$2', '$4')"
        strSql = Replace(strSql, "$1", Me.prForm("txtMarca"))
        strSql = Replace(strSql, "$2", Me.prForm("txtOrden"))
        strSql = Replace(strSql, "$4", Me.prForm("txtImagen"))
        strCx.ejecutaSql(strSql)
        If strCx.flagError Then
            rsp.estadoError(100, strCx.msgError)
        Else
            rsp.args = "{ ""idMarca"": " & strCx.retornaDato("SELECT max(idMarca) FROM elx_core_marca") & "}"
        End If

    End Sub
    Sub editar()
        Dim strCx As New StringConex
        Dim strSql As String
        strSql = "UPDATE elx_core_marca SET  marca = '$1', orden = '$2', imagen = '$3' WHERE idMarca= '$4'"
        strSql = Replace(strSql, "$4", Me.prGet("txtidMarca"))
        strSql = Replace(strSql, "$1", Me.prGet("txtMarca"))
        strSql = Replace(strSql, "$2", Me.prGet("txtOrden"))
        strSql = Replace(strSql, "$3", Me.prGet("txtImagen"))
        strCx.ejecutaSql(strSql)
        If strCx.flagError Then
            rsp.estadoError(100, "Editar: No se pudo acceder a la base")
        End If
    End Sub

    Sub eliminar()
        Dim strCx As New StringConex
        Dim strSql As String
        strSql = "DELETE FROM  elx_core_marca WHERE idMarca =  $1"
        strSql = Replace(strSql, "$1", Me.prGet("txtidMarca"))
        strCx.ejecutaSql(strSql)
        If strCx.flagError Then
            rsp.estadoError(100, "Eliminar: No se pudo acceder a la base")
        End If
    End Sub
End Class

