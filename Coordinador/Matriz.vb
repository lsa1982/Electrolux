Imports Elx.CommonClass


Public Class Matriz
	Inherits clsEntidad

	Sub listaTienda()
		Dim strCx As New StringConex
		Dim dt As DataTable
		Dim dr As DataRow
		Dim strSql As String
		strSql = "select tabla, columnaId, columnaText, tipo from elx_cdt_variable where variable = 'tienda'"
		dr = strCx.retornaDataRow(strSql)
		If IsNothing(dr) Then
			If dr("tipo") = "I" Then
				strSql = "select $1, $2 from $3 where $4 in (select valorInt from elx_cdt_matrizResponsabilidad where idRol = $5 and idVariable = $6)"
			Else
				strSql = "select $1, $2 from $3 where $4 in (select valorChar from elx_cdt_matrizResponsabilidad where idRol = $5 and idVariable = $6)"
			End If
			strSql = Replace(strSql, "$1", dr("columnaId"))
			strSql = Replace(strSql, "$1", dr("columnaText"))

		Else
			rsp.estadoError(100, "No se encuentra la variable seleccionada", strCx.msgError)
		End If
		strCx.iniciaTransaccion()
		dt = strCx.retornaDataTable(strSql)
		If strCx.flagError Then
			rsp.estadoError(100, "Lista: No se pudo acceder a la base", strCx.msgError)
		Else
			respuesta.totalFila = strCx.retornaDato("SELECT FOUND_ROWS()")
			rsp.args = Me.retornaTablaSerializada(dt)
			Debug.Print(rsp.args)
		End If


	End Sub

End Class
