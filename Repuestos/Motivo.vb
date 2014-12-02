Imports Elx.CommonClass

Public Class Motivo
	Inherits clsEntidad

	Sub lista()
	
		Dim vFiltro As String = ""
		If prForm("idMotivo") <> "" Then
			vFiltro = " and idMotivo = " & prForm("idMotivo")
		End If
		listaSql("SELECT SQL_CALC_FOUND_ROWS  idMotivo, motivo,clasificacion FROM elx_rep_prorroga_motivo where 1 = 1  ", vFiltro, False)
	End Sub
End Class
