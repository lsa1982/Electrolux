Imports Elx.CommonClass


Public Class Matriz
	Inherits clsEntidad

	Sub lista()
		Dim strCx As New StringConex
		Dim dt As DataTable
		Dim dr As DataRow
		Dim strSql As String
		strSql = "select idVariable, tabla, columnaId, columnaText, tipo from elx_cdt_variable where variable = '" & prForm("variable") & "'"
		dr = strCx.retornaDataRow(strSql)
		If Not IsNothing(dr) Then
			If dr("tipo") = 0 Then
				strSql = "select $1, $2 from $3 where $4 in (select valorInt from elx_cdt_matrizResponsabilidad where idRol = $5 and idVariable = $6)"
			Else
				strSql = "select $1, $2 from $3 where $4 in (select valorChar from elx_cdt_matrizResponsabilidad where idRol = $5 and idVariable = $6)"
			End If
			strSql = Replace(strSql, "$1", dr("columnaId"))
			strSql = Replace(strSql, "$2", dr("columnaText"))
			strSql = Replace(strSql, "$3", dr("tabla"))
			strSql = Replace(strSql, "$4", dr("columnaId"))
			strSql = Replace(strSql, "$5", prForm("idRol"))
			strSql = Replace(strSql, "$6", dr("idVariable"))
			dt = strCx.retornaDataTable(strSql)
			If strCx.flagError Then
				rsp.estadoError(100, "Lista: No se pudo acceder a la base", strCx.msgError)
			Else
				respuesta.totalFila = strCx.retornaDato("SELECT FOUND_ROWS()")
				rsp.args = Me.retornaTablaSerializada(dt)
				Debug.Print(rsp.args)
			End If

		Else
			rsp.estadoError(100, "No se encuentra la variable seleccionada", strCx.msgError)
		End If



	End Sub
End Class
