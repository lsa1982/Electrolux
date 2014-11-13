Imports Elx.CommonClass


Public Class clsSeccion
	Inherits clsEntidad

	Sub lista()
		Dim strSql As String

		Dim vFiltro As String = ""
		If Not prGet("idSeccion") = "" Then
			vFiltro = vFiltro & " and idCadena = " & Me.prGet("txtidCadena")

		End If

		strSql = "SELECT idSeccion, seccion, descripcion FROM elx_core_seccion where 1=1 "
		listaSql(strSql, vFiltro, False)

		
		
	End Sub
	Sub insertar()
		Dim strCx As New StringConex
		Dim strSql As String
		strSql = "INSERT INTO elx_core_seccion (cadena, razonSocial, rut, estado, imagen) VALUES ('$1', '$2', '$3', '$4', '$5')"
		strSql = Replace(strSql, "$1", Me.prForm("txtCadena"))
		strSql = Replace(strSql, "$2", Me.prForm("txtRazonSocial"))
		strSql = Replace(strSql, "$3", Me.prForm("txtRut"))
		strSql = Replace(strSql, "$4", Me.prForm("txtEstado"))
		strSql = Replace(strSql, "$5", Me.prForm("txtImagen"))
		strCx.ejecutaSql(strSql)
		If strCx.flagError Then
			rsp.estadoError(100, strCx.msgError)
		Else
			rsp.args = "{ ""idCadena"": " & strCx.retornaDato("SELECT max(idCadena) FROM elx_core_seccion") & "}"
		End If

	End Sub
	Sub editar()
		Dim strCx As New StringConex
		Dim strSql As String
		strSql = "UPDATE elx_core_seccion SET  cadena = '$1', razonSocial = '$2', rut = '$3', estado ='$4', imagen='$5' WHERE idCadena= $6"
		strSql = Replace(strSql, "$6", Me.prForm("txtidCadena"))
		strSql = Replace(strSql, "$1", Me.prForm("txtCadena"))
		strSql = Replace(strSql, "$2", Me.prForm("txtRazonSocial"))
		strSql = Replace(strSql, "$3", Me.prForm("txtRut"))
		strSql = Replace(strSql, "$4", Me.prForm("txtEstado"))
		strSql = Replace(strSql, "$5", Me.prForm("txtImagen"))
		strCx.ejecutaSql(strSql)
		If strCx.flagError Then
			rsp.estadoError(100, "Editar: No se pudo acceder a la base")
		End If
	End Sub

	Sub eliminar()
		Dim strCx As New StringConex
		Dim strSql As String
		strSql = "DELETE FROM  elx_core_seccion WHERE idCadena =  $1"
		strSql = Replace(strSql, "$1", Me.prGet("txtidCadena"))
		strCx.ejecutaSql(strSql)
		If strCx.flagError Then
			rsp.estadoError(100, "Eliminar: No se pudo acceder a la base")
		End If
	End Sub
End Class

