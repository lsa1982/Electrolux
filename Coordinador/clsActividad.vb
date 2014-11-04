Imports Elx.CommonClass


Public Class clsActividad
    Inherits clsEntidad

    Sub lista()
        Dim vFiltro As String = ""
        If Not prForm("txtidFlujo") = "" Then
            vFiltro = " and al1.idFlujo = " & Me.prForm("txtidFlujo")
        End If

        If Not prForm("txtidFlujo") = "" Then
            vFiltro = " and al1.idFlujo = " & Me.prForm("txtidFlujo")
        End If

        If Not prForm("filter[filters][0][field]") = "" Then
            vFiltro = " and al1.idFlujo= " & Me.prForm("filter[filters][0][value]")
        End If
        listaSql("vActividad", vFiltro)
    End Sub

    Sub listaActividad()
        Dim vFiltro As String = ""
        If Not prForm("txtidActividad") = "" Then
            vFiltro = " and al1.idActividad = " & Me.prForm("txtidActividad")
        End If

        If Not prForm("txtidActividad") = "" Then
            vFiltro = " and al1.idActividad = " & Me.prForm("txtidActividad")
        End If

        If Not prForm("filter[filters][0][field]") = "" Then
            vFiltro = " and al1.idActividad= " & Me.prForm("filter[filters][0][value]")
        End If
        listaSql("vActividad", vFiltro)
    End Sub

    Sub insertar()
        Dim strCx As New StringConex
        Dim strSql As String
        strSql = "INSERT INTO elx_wf_actividad (idRol, idFlujo, actividad, duracion, medida, orden) VALUES ($1, $2, '$3', $4, '$5', $6)"
        strSql = Replace(strSql, "$1", Me.prForm("txtidRol"))
        strSql = Replace(strSql, "$2", Me.prForm("txtidFlujo"))
        strSql = Replace(strSql, "$3", Me.prForm("txtActividad"))
        strSql = Replace(strSql, "$4", Me.prForm("txtDuracion"))
        strSql = Replace(strSql, "$5", Me.prForm("txtMedida"))
        strSql = Replace(strSql, "$6", Me.prForm("txtOrden"))
        strCx.ejecutaSql(strSql)
        If strCx.flagError Then
            rsp.estadoError(100, strCx.msgError)
        Else
            rsp.args = "{ ""idActividad"": " & strCx.retornaDato("SELECT max(idActividad) FROM elx_wf_actividad") & "}"
        End If

    End Sub

    Sub editar()
        Dim strCx As New StringConex
        Dim strSql As String
        strSql = "UPDATE elx_wf_actividad SET   actividad = '$3', duracion = '$4', medida = '$5', orden = '$6' WHERE idActividad = '$7'"
        strSql = Replace(strSql, "$7", Me.prForm("txtidActividad"))
        strSql = Replace(strSql, "$3", Me.prForm("txtActividad"))
        strSql = Replace(strSql, "$4", Me.prForm("txtDuracion"))
        strSql = Replace(strSql, "$5", Me.prForm("txtMedida"))
        strSql = Replace(strSql, "$6", Me.prForm("txtOrden"))
        strCx.ejecutaSql(strSql)
        If strCx.flagError Then
            rsp.estadoError(100, "Editar: No se pudo acceder a la base")
        End If
    End Sub

    Sub eliminar()
        Dim strCx As New StringConex
        Dim strSql As String
        strSql = "DELETE FROM elx_wf_actividad WHERE idActividad = '$1'"
        strSql = Replace(strSql, "$1", Me.prForm("txtidActividad"))
        strCx.ejecutaSql(strSql)
        If strCx.flagError Then
            rsp.estadoError(100, "Eliminar: No se pudo acceder a la base")
        End If
    End Sub
End Class
