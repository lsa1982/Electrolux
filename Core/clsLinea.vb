Imports Elx.CommonClass


Public Class clsLinea
    Inherits clsEntidad

    Sub lista()
        Dim strCx As New StringConex
        Dim dt As DataTable
        Dim strSql As String


        strSql = "SELECT * FROM elx_core_linea"
        If Not prForm("txtidLinea") = "" Then
            strSql = strSql & " WHERE idLinea = " & Me.prGet("txtidLinea")
            strCx.ejecutaSql(strSql)
        End If

        If Not prGet("txtidLinea") = "" Then
            strSql = strSql & " WHERE idLinea = " & Me.prGet("txtidLinea")
            strCx.ejecutaSql(strSql)
        End If

        If Not prForm("filter[filters][0][field]") = "" Then
            strSql = strSql & " WHERE idLinea = " & Me.prForm("filter[filters][0][value]")
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
End Class

