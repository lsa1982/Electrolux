Imports Elx.CommonClass

Public Class TipoDocumento
	Inherits clsEntidad

	Sub lista()
		Dim vFiltro As String = ""
		If prForm("idTipoDocumento") <> "" Then
			vFiltro = " and idTipoDocumento = " & prForm("idTipoDocumento")
		End If
		listaSql("SELECT SQL_CALC_FOUND_ROWS idTipoDocumento, tipoDocumento from elx_wf_tipoDocumento where 1 = 1  ", vFiltro, False)
	End Sub

	Sub listaInventario()
		Dim vFiltro As String = ""
		If prForm("idTipoDocumento") <> "" Then
			vFiltro = " and idTipoDocumento = " & prForm("idTipoDocumento")
		End If
		listaSql("SELECT SQL_CALC_FOUND_ROWS idTipoDocumento, tipoDocumento, descripcion from elx_rep_tipoDocumento where 1 = 1  ", vFiltro, False)
	End Sub
End Class
