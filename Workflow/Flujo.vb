Imports Elx.CommonClass

Public Class Flujo
	Inherits clsEntidad

	Sub lista()

		Dim vFiltro As String = ""
		If prForm("idFlujo") <> "" Then
			vFiltro = " and idFlujo= " & prForm("idFlujo")
		End If
		If prForm("malla") <> "" Then
			vFiltro = " and malla= " & prForm("malla")
		End If

		listaSql("SELECT SQL_CALC_FOUND_ROWS  idFlujo, flujo FROM elx_wf_flujo where 1 = 1  ", vFiltro, False)
	End Sub
End Class
