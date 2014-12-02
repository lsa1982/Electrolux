Imports Elx.CommonClass

Public Class Mensaje
	Inherits clsEntidad

	Sub lista()

		Dim vFiltro As String = ""
		If prForm("idRequerimiento") <> "" Then
			vFiltro = " and al1.idRequerimiento = " & prForm("idRequerimiento")
		End If
		If prForm("idMensaje") <> "" Then
			vFiltro = " and al1.idMensaje = " & prForm("idMensaje")
		End If
		listaSql("vMensaje", vFiltro)
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
