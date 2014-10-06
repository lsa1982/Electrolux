Imports Elx.CommonClass


Public Class clsRol
    Inherits clsEntidad

    Sub lista()
        Dim strCx As New StringConex
        Dim dt As DataTable
        Dim strSql As String


        strSql = "SELECT * FROM elx_hr_rol"
        If Not prForm("txtidRol") = "" Then
            strSql = strSql & " WHERE IDROL = " & Me.prGet("txtidROl")
            strCx.ejecutaSql(strSql)
        End If

        If Not prGet("txtidRol") = "" Then
            strSql = strSql & " WHERE IDROL = " & Me.prGet("txtidMarca")
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

End Class
