Imports Elx.CommonClass


Public Class Rol
	Inherits clsEntidad

	Sub lista()
		Dim vFiltro As String = ""

		If Not prForm("idPerfil") = "" Then
			vFiltro = vFiltro & " and al1.idPerfil = " & Me.prForm("idPerfil")
		End If

		If Not prForm("rol") = "" Then
			vFiltro = vFiltro & " and al1.rol like '%" & Me.prForm("idPerfil") & "%'"
		End If

		If Not prForm("region") = "" Then
			vFiltro = vFiltro & " and al1.region = '" & Me.prForm("region") & "'"
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

	Sub actualizar()
		Dim strCx As New StringConex
		Dim strSql As String
		strSql = "update elx_hr_rol set rol ='$1', descripcion ='$2', idUsuario = $3, region = '$4' where idRol = $5"
		strSql = Replace(strSql, "$1", prForm("Rol"))
		strSql = Replace(strSql, "$2", prForm("Descripcion"))
		strSql = Replace(strSql, "$3", prForm("idUsuario"))
		strSql = Replace(strSql, "$4", prForm("region"))
		strSql = Replace(strSql, "$5", prForm("idRol"))

		strCx.ejecutaSql(strSql)
		If strCx.flagError Then
			rsp.estadoError(100, "Actualizar: No se pudo acceder a la base", strCx.msgError)
		Else
			rsp.args = "{ ""OK"" : ""OK""}"
		End If
	End Sub

End Class
