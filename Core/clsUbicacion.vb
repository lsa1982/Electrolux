Imports Elx.CommonClass


Public Class clsLinea
    Inherits clsEntidad

    Sub lista()
        Dim strCx As New StringConex
        Dim dt As DataTable
        Dim strSql As String


        strSql = "SELECT * FROM elx_core_ubicacion"
        If Not prForm("txtid_ubicacion") = "" Then
            strSql = strSql & " WHERE id_ubicacion = " & Me.prGet("txtid_ubicacion")
            strCx.ejecutaSql(strSql)
        End If

        If Not prGet("txtid_ubicacion") = "" Then
            strSql = strSql & " WHERE id_ubicacion = " & Me.prGet("txtid_ubicacion")
            strCx.ejecutaSql(strSql)
        End If

        If Not prForm("filter[filters][0][field]") = "" Then
            strSql = strSql & " WHERE id_ubicacion = " & Me.prForm("filter[filters][0][value]")
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
        strSql = "INSERT INTO elx_core_ubicacion (usuario, geo_x, geo_y,fecha_hora ) VALUES ('$1','$2','$4','$4')"
        strSql = Replace(strSql, "$1", Me.prForm("txtUsuario"))
        strSql = Replace(strSql, "$2", Me.prForm("txtGeo_x"))
        strSql = Replace(strSql, "$3", Me.prForm("txtGeo_y"))
        strSql = Replace(strSql, "$4", Me.prForm("txtFecha_hora"))
        strCx.ejecutaSql(strSql)
        If strCx.flagError Then
            rsp.estadoError(100, strCx.msgError)
        Else
            rsp.args = "{ ""id_ubicacion"": " & strCx.retornaDato("SELECT max(id_ubicacion) FROM elx_core_ubicacion") & "}"
        End If

    End Sub

End Class

