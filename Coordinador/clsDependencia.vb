﻿Imports Elx.CommonClass


Public Class clsDependencia
    Inherits clsEntidad

    Sub lista()
        Dim vFiltro As String = ""
        If Not prForm("txtidFinalizacion") = "" Then
            vFiltro = " and al1.idFinalizacion = " & Me.prForm("txtidFinalizacion")
        End If

        If Not prGet("txtidFinalizacion") = "" Then
            vFiltro = " and al1.idFinalizacion = " & Me.prGet("txtidFinalizacion")
        End If

        If Not prForm("filter[filters][0][field]") = "" Then
            vFiltro = " and al1.idFinalizacion= " & Me.prForm("filter[filters][0][value]")
        End If
        listaSql("vDependencia", vFiltro)
    End Sub

    Sub listaActividad()
        Dim vFiltro As String = ""
        If Not prForm("txtidActividad") = "" Then
            vFiltro = " and al1.idActividad = " & Me.prForm("txtidActividad")
        End If

        If Not prGet("txtidActividad") = "" Then
            vFiltro = " and al1.idActividad = " & Me.prGet("txtidActividad")
        End If

        If Not prForm("filter[filters][0][field]") = "" Then
            vFiltro = " and al1.idActividad= " & Me.prForm("filter[filters][0][value]")
        End If
        listaSql("vDependencia", vFiltro)
    End Sub
End Class
