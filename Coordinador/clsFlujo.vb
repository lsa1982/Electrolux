Imports Elx.CommonClass


Public Class clsFlujo
    Inherits clsEntidad

    Sub lista2()
        Dim strCx As New StringConex
        Dim dt As DataTable
        Dim strSql As String


        If Not prForm("idFlujo") = "" Then
            strSql = "SELECT * FROM elx_wf_flujo  WHERE idFlujo = " & Me.prForm("idFlujo")
        Else
            strSql = "SELECT * FROM elx_wf_flujo"
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
        strSql = "INSERT INTO elx_wf_flujo (Flujo, Grupo, duracion, medida) VALUES ('$1', '$2', '3', '$4')"
        strSql = Replace(strSql, "$1", Me.prForm("txtFlujo"))
        strSql = Replace(strSql, "$2", Me.prForm("txtGrupo"))
        strSql = Replace(strSql, "$3", Me.prForm("txtduracion"))
        strSql = Replace(strSql, "$4", Me.prForm("txtmedida"))
        strCx.ejecutaSql(strSql)
        If strCx.flagError Then
            rsp.estadoError(100, strCx.msgError)
        Else
            rsp.args = "{ ""idFlujo"": " & strCx.retornaDato("SELECT max(idFlujo) FROM elx_wf_flujo") & "}"
        End If

    End Sub
End Class