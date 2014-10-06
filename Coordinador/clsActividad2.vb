Imports Elx.CommonClass


Public Class clsActividad2
    Inherits clsEntidad

    Sub lista()
        Dim vFiltro As String = ""
        If Not prForm("txtidTree") = "" Then
            vFiltro = " and al1.txtidTree = " & Me.prGet("txtidTree")
        End If

        If Not prGet("txtidTree") = "" Then
            vFiltro = " and al1.idTree = " & Me.prGet("txtidTree")
        End If

        If Not prForm("filter[filters][0][field]") = "" Then
            vFiltro = " and al1.idTree= " & Me.prForm("filter[filters][0][value]")
        End If
        listaSql("vFlujo", vFiltro)
    End Sub
End Class