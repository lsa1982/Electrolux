Imports Elx.CommonClass
Imports Elx.seguridad

Public Class Notificacion
	Inherits clsEntidad

	Sub lista()
		Dim vFiltro As String = ""

		vFiltro = vFiltro & " and al1.idRol = " & Me.Rol.idRol


		If Not prForm("estado") = "" Then
			vFiltro = vFiltro & " and al1.estado = " & Me.prForm("estado")
		End If

		listaSql("vNotificacion", vFiltro, True, " limit 0,30")
	End Sub

	Sub leerNotificacion()
		Dim strCx As New StringConex
		Dim strSql As String
		strSql = "update elx_hr_notificacion set estado = 1 where idRol = $1"
		strSql = Replace(strSql, "$1", Me.Rol.idRol)

		strCx.ejecutaSql(strSql)
		If strCx.flagError Then
			rsp.estadoError(200, "Actualizar: No se pudo acceder a la base", strCx.msgError)
		Else
			rsp.args = "{ ""operation"" : ""update""}"
		End If
	End Sub
	
	

End Class
