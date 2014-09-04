Imports Elx.CommonClass


Public Class clsTienda
    Inherits clsEntidad

    Sub lista()
        Dim strCx As New StringConex
        Dim dt As DataTable
        Dim strSql As String
      

        strSql = "SELECT * FROM elx_core_tienda"
        If Not prForm("txtidCadena") = "" Then
            strSql = strSql & " WHERE idCadena = " & Me.prGet("txtidCadena")
            strCx.ejecutaSql(strSql)
        End If

        If Not prGet("txtidCadena") = "" Then
            strSql = strSql & " WHERE idCadena = " & Me.prGet("txtidCadena")
            strCx.ejecutaSql(strSql)
		End If

		If Not prForm("filter[filters][0][field]") = "" Then
			strSql = strSql & " WHERE idCadena = " & Me.prForm("filter[filters][0][value]")
			strCx.ejecutaSql(strSql)
		End If

        dt = strCx.retornaDataTable(strSql)

        If strCx.flagError Then
            rsp.estadoError(100, strSql)
        Else
            rsp.totalFila = dt.Rows.Count
            rsp.args = Me.retornaTablaSerializada(dt)
            Debug.Print(rsp.args)
        End If
    End Sub

    Sub insertar()
        Dim strCx As New StringConex
        Dim strSql As String
        strSql = "INSERT INTO elx_core_tienda (idCadena, idRol, tienda, status, geo_x, geo_y, categoria) VALUES ('$1', '$2', '$3','$4', '$5', '$6', '$7')"
        strSql = Replace(strSql, "$1", Me.prForm("txtidCadena"))
        strSql = Replace(strSql, "$2", Me.prForm("txtidRol"))
        strSql = Replace(strSql, "$3", Me.prForm("txtTienda"))
        strSql = Replace(strSql, "$4", Me.prForm("txtStatus"))
        strSql = Replace(strSql, "$5", Me.prForm("txtGeo_x"))
        strSql = Replace(strSql, "$6", Me.prForm("txtGeo_y"))
        strSql = Replace(strSql, "$7", Me.prForm("txtcategoria"))
        strCx.ejecutaSql(strSql)
        If strCx.flagError Then
            rsp.estadoError(100, strCx.msgError)
        Else
            rsp.args = "{ ""idTienda"": " & strCx.retornaDato("SELECT max(idTienda) FROM elx_core_tienda") & "}"
        End If

    End Sub

    Sub editar()
        Dim strCx As New StringConex
        Dim strSql As String
        strSql = "UPDATE elx_core_tienda SET  idCadena = '$1', idRol = '$2', tienda = '$3', status = '$4', geo_x = '$5', geo_y = '$6', categoria = '$7' WHERE idTienda= '$8'"
        strSql = Replace(strSql, "$4", Me.prGet("txtidTienda"))
        strSql = Replace(strSql, "$1", Me.prGet("txtidCadena"))
        strSql = Replace(strSql, "$2", Me.prGet("txtidRol"))
        strSql = Replace(strSql, "$3", Me.prGet("txtTienda"))
        strSql = Replace(strSql, "$4", Me.prGet("txtStatus"))
        strSql = Replace(strSql, "$3", Me.prGet("txtGeo_x"))
        strSql = Replace(strSql, "$3", Me.prGet("txtGeo_y"))
        strSql = Replace(strSql, "$3", Me.prGet("txtCategoria"))
        strCx.ejecutaSql(strSql)
        If strCx.flagError Then
            rsp.estadoError(100, "Editar: No se pudo acceder a la base")
        End If
    End Sub

    Sub eliminar()
        Dim strCx As New StringConex
        Dim strSql As String
        strSql = "DELETE FROM  elx_core_tienda WHERE idTienda =  $1"
        strSql = Replace(strSql, "$1", Me.prGet("txtidTienda"))
        strCx.ejecutaSql(strSql)
        If strCx.flagError Then
            rsp.estadoError(100, "Eliminar: No se pudo acceder a la base")
        End If
    End Sub
End Class
