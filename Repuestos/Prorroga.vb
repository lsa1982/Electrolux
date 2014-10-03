Imports Elx.CommonClass


Public Class Prorroga
	Inherits clsEntidad
	Sub lista()
		Dim vFiltro As String = ""
		If prForm("idRequerimiento") <> "" Then
			vFiltro = " and al1.idRequerimiento = " & prForm("idRequerimiento")
		End If
		listaSql("vProrroga", vFiltro)
	End Sub
	Sub insertar()

		Dim strCx As New StringConex
		Dim strSql As String
		strCx.iniciaTransaccion()
		strSql = "update ELX_REP_REQUERIMIENTO set fechaCompromiso = '$1' where idRequerimiento = $2 "
		strSql = Replace(strSql, "$1", Me.prForm("fechaNueva"))
		strSql = Replace(strSql, "$2", Me.prForm("idRequerimiento"))
		strCx.ejecutaSql(strSql)
		strSql = "update elx_rep_estados set fechaEsperada  = '$1' where idRequerimiento = $2 and activo = 1"
		strSql = Replace(strSql, "$1", Me.prForm("fechaNueva"))
		strSql = Replace(strSql, "$2", Me.prForm("idRequerimiento"))
		strCx.ejecutaSql(strSql)
		strSql = "INSERT INTO elx_rep_prorroga VALUES (null, '$1', '$2', '$3', '$4','$5','$6','$7') "
		strSql = Replace(strSql, "$1", Me.prForm("idRequerimiento")) 'idRequerimiento
		strSql = Replace(strSql, "$2", Me.prForm("idMotivo")) 'idMotivo
		strSql = Replace(strSql, "$3", Me.Rol.idUsuario)	' idUsuario
		strSql = Replace(strSql, "$4", Me.prForm("comentario"))	' comentario
		strSql = Replace(strSql, "$5", Me.prForm("fechaAntigua")) ' fechaAntigua
		strSql = Replace(strSql, "$6", Me.prForm("fechaNueva"))	'fechaNueva
		strSql = Replace(strSql, "$7", Format(Now(), "yyyy-MM-dd HH:mm:ss")) 'fechaModificacion
		strCx.ejecutaSql(strSql)
		
		If strCx.flagError Then
			rsp.estadoError(100, "Insertar: No se pudo acceder a la base", strCx.msgError)
		Else
			strCx.finTransaccion()
			rsp.args = "{ ""OK"": ""OK""}"
		End If
	End Sub
End Class
