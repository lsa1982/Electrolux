Imports Elx.CommonClass


Public Class clsFlujo
    Inherits clsEntidad

    Sub lista()
        Dim strCx As New StringConex
        Dim dt As DataTable
        Dim strSql As String


        strSql = "SELECT * FROM elx_wf_flujo"
        If Not prForm("txtidFlujo") = "" Then
            strSql = strSql & " WHERE idFlujo = " & Me.prGet("txtidFlujo")
            strCx.ejecutaSql(strSql)
        End If

        If Not prGet("txtidFlujo") = "" Then
            strSql = strSql & " WHERE idFlujo = " & Me.prGet("txtidFlujo")
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
        strSql = "INSERT INTO elx_wf_flujo (Flujo, Grupo, duracion, medida) VALUES ('$1', '$2',$3 ,'$4')"
        strSql = Replace(strSql, "$1", Me.prForm("txtFlujo"))
        strSql = Replace(strSql, "$2", Me.prForm("txtGrupo"))
        strSql = Replace(strSql, "$3", Me.prForm("txtDuracion"))
        strSql = Replace(strSql, "$4", Me.prForm("txtMedida"))
        strCx.ejecutaSql(strSql)
        If strCx.flagError Then
            rsp.estadoError(100, strCx.msgError)
        Else
            rsp.args = "{ ""idFlujo"": " & strCx.retornaDato("SELECT max(idFlujo) FROM elx_wf_flujo") & "}"
        End If

    End Sub
    Sub editar()
        Dim strCx As New StringConex
        Dim strSql As String
        strSql = "UPDATE elx_wf_flujo SET  Flujo = '$1', Grupo = $2, duracion = '$3' WHERE idFlujo= $4"
        strSql = Replace(strSql, "$4", Me.prForm("txtidFlujo"))
        strSql = Replace(strSql, "$1", Me.prForm("txtFlujo"))
        strSql = Replace(strSql, "$2", Me.prForm("txtGrupo"))
        strSql = Replace(strSql, "$3", Me.prForm("txtDuracion"))
        strCx.ejecutaSql(strSql)
        If strCx.flagError Then
            rsp.estadoError(100, "Editar: No se pudo acceder a la base")
        End If
    End Sub

    Sub eliminar()
        Dim strCx As New StringConex
        Dim strSql As String
        strSql = "DELETE FROM  elx_wf_flujo WHERE idFlujo =  $1"
        strSql = Replace(strSql, "$1", Me.prGet("txtidFlujo"))
        strCx.ejecutaSql(strSql)
        If strCx.flagError Then
            rsp.estadoError(100, "Eliminar: No se pudo acceder a la base")
        End If
    End Sub
End Class

