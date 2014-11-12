Imports Elx.CommonClass

Public Class Grupo
	Inherits clsEntidad

	Sub lista()
		listaSql("SELECT * FROM elx_rep_grupo", "", False)
	End Sub

	Sub insertar()

		Dim strCx As New StringConex
		Dim strSql As String
		strCx.iniciaTransaccion()
		strSql = "INSERT INTO elx_rep_mensaje VALUES (null, '$1', '$2', '$3', '$4') "
		strSql = Replace(strSql, "$1", Me.prForm("idRequerimiento")) 'idRequerimiento
		strSql = Replace(strSql, "$2", Me.Rol.idUsuario) 'idUsuario
		strSql = Replace(strSql, "$3", Me.prForm("mensaje"))	' mensaje
		strSql = Replace(strSql, "$4", Format(Now(), "yyyy-MM-dd HH:mm:ss")) 'fechaIngreso
		strCx.ejecutaSql(strSql)

		If strCx.flagError Then
			rsp.estadoError(100, "Insertar: No se pudo acceder a la base", strCx.msgError)
		Else
			strCx.finTransaccion()
			rsp.args = "{ ""OK"": ""OK""}"
		End If
	End Sub
End Class
