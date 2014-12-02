Imports Elx.CommonClass


Public Class Perfil
	Inherits clsEntidad

	Sub lista()
		Dim vFiltro As String = ""
		
		If Not prForm("idPerfil") = "" Then
			vFiltro = " and idPerfil = " & Me.prForm("idPerfil")
		End If

		listaSql("select * from elx_hr_perfil", vFiltro, False)
	End Sub

	Sub listaRegion()
		Dim vFiltro As String = ""

		If Not prForm("idPerfil") = "" Then
			vFiltro = " and idPerfil = " & Me.prForm("idPerfil")
		End If

		listaSql("select region from elx_core_region where region in (select distinct region from elx_hr_rol where 1=1 ", vFiltro, False, " ) order by nmroRegion")
	End Sub


End Class
