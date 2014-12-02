Imports Elx.CommonClass


Public Class Rol
	Inherits clsEntidad

	Sub lista()
		Dim vFiltro As String = ""

		If Not prForm("idPerfil") = "" Then
			vFiltro = " and al1.idPerfil = " & Me.prForm("idPerfil")
		End If

		If Not prForm("rol") = "" Then
			vFiltro = " and al1.rol like '%" & Me.prForm("idPerfil") & "%'"
		End If

		If Not prForm("region") = "" Then
			vFiltro = " and al1.region = " & Me.prForm("region")
		End If

		listaSql("vRoles", vFiltro, True, " limit 0,30")
	End Sub

	Sub listaRegion()
		Dim vFiltro As String = ""

		If Not prForm("idPerfil") = "" Then
			vFiltro = " and idPerfil = " & Me.prForm("idPerfil")
		End If

		listaSql("select region from elx_core_region where region in (select distinct region from elx_hr_perfil where 1=1 ", vFiltro, False, " ) order by nmroRegion")
	End Sub

	Sub listaUsuario()
		Dim vFiltro As String = ""

		If Not prForm("idRol") = "" Then
			vFiltro = " and al1.idRol = " & Me.prForm("idRol")
		End If

		listaSql("vRolUsuario", vFiltro)
	End Sub


End Class
