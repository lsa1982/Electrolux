Imports Elx.CommonClass


Public Class clsGrafo
    Inherits clsEntidad

    Sub lista()
        Dim vFiltro As String = ""
        If Not prForm("txtidActividadFinalizacion") = "" Then
            vFiltro = " and al1.idActividadFinalizacion = " & Me.prGet("txtidActividadFinalizacion")
        End If

        If Not prGet("txtidActividadFinalizacion") = "" Then
            vFiltro = " and al1.idActividadFinalizacion = " & Me.prGet("txtidActividadFinalizacion")
        End If

        If Not prForm("filter[filters][0][field]") = "" Then
            vFiltro = " and al1.idActividadFinalizacion= " & Me.prForm("filter[filters][0][value]")
        End If
        listaSql("vGrafo", vFiltro)
    End Sub
End Class

