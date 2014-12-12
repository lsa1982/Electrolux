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
				strSql = "select al1.$1, al1.$2, '$7' as variable, al2.idResponsabilidad from $3 al1, elx_cdt_matrizResponsabilidad al2 where al1.$4 = al2.valorInt and al2.idRol = $5 and al2.idVariable = $6"
			Else
				strSql = "select $1, $2, '$7' as variable from $3 where $4 in (select valorChar from elx_cdt_matrizResponsabilidad where idRol = $5 and idVariable = $6)"
			End If
			strSql = Replace(strSql, "$1", dr("columnaId"))
			strSql = Replace(strSql, "$2", dr("columnaText"))
			strSql = Replace(strSql, "$3", dr("tabla"))
			strSql = Replace(strSql, "$4", dr("columnaId"))
			strSql = Replace(strSql, "$5", prForm("idRol"))
			strSql = Replace(strSql, "$6", dr("idVariable"))
			strSql = Replace(strSql, "$7", prForm("variable"))
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

	Sub insertar()
		Dim strCx As New StringConex
		Dim strSql As String
		Dim dr As DataRow
		strSql = "select idVariable, tipo from elx_cdt_variable where variable = '" & prForm("variable") & "'"
		dr = strCx.retornaDataRow(strSql)
		If Not IsNothing(dr) Then
			strSql = "insert into  elx_cdt_matrizresponsabilidad ( idRol, idVariable, $1) values ( $2, $3, '$4')"
			strSql = Replace(strSql, "$1", IIf(dr("tipo") = 0, "valorInt", "valorChar"))
			strSql = Replace(strSql, "$2", prForm("idRol"))
			strSql = Replace(strSql, "$3", dr("idVariable"))
			strSql = Replace(strSql, "$4", prForm("id"))

			strCx.ejecutaSql(strSql)
			If strCx.flagError Then
				rsp.estadoError(100, "Insertar: No se pudo acceder a la base", strCx.msgError)
			Else
				rsp.args = "{ ""OK"" : ""OK""}"
			End If
		Else
			rsp.estadoError(100, "No se encuentra la variable seleccionada", strCx.msgError)
		End If
		


	End Sub

	Sub eliminar()
		Dim strCx As New StringConex
		Dim strSql As String
		strSql = "delete from elx_cdt_matrizresponsabilidad where idResponsabilidad =$1"
		strSql = Replace(strSql, "$1", prForm("idResponsabilidad"))
		
		strCx.ejecutaSql(strSql)
		If strCx.flagError Then
			rsp.estadoError(100, "Eliminar: No se pudo acceder a la base", strCx.msgError)
		Else
			rsp.args = "{ ""OK"" : ""OK""}"
		End If
		
	End Sub

End Class
