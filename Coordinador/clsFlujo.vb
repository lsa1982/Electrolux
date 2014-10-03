Imports Elx.CommonClass


Public Class clsFlujo
    Inherits clsEntidad

    Sub lista()
        Dim vFiltro As String = ""
        If Not prForm("txtidFlujo") = "" Then
            vFiltro = " and al1.idFlujo = " & Me.prGet("txtidFlujo")
        End If

        If Not prGet("txtidFlujo") = "" Then
            vFiltro = " and al1.idFlujo = " & Me.prGet("txtidFlujo")
        End If

        If Not prForm("filter[filters][0][field]") = "" Then
            vFiltro = " and al1.idFlujo= " & Me.prForm("filter[filters][0][value]")
        End If
        listaSql("vFlujo", vFiltro)
    End Sub
End Class