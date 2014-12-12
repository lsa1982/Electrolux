Imports Elx.CommonClass

Public Class Region
	Inherits clsEntidad
	Sub lista()
		Dim vFiltro As String = ""

		listaSql("SELECT SQL_CALC_FOUND_ROWS  region, nmroRegion FROM elx_core_region", vFiltro, False, " order by nmroRegion")
	End Sub
End Class
