

Public Class Sincronizacion
	Inherits clsEntidad
	

	Sub Actualizar()
		Dim strCx As New StringConex
		Dim dt As DataTable
		Dim strSql As String
		strSql = "SELECT  * FROM " & prForm("tabla")
		If prForm("fecha") <> "null" Then
			strSql = strSql & " where ultimaModificacion > '" & prForm("fecha") & "'"
		End If
		dt = strCx.retornaDataTable(strSql)
		Dim strResult As String = ""
		If dt.Rows.Count > 0 Then
			For Each dr As DataRow In dt.Rows
				For Each dc As DataColumn In dt.Columns
					If dc.DataType.Name = "DateTime" Then
						strResult = strResult & Format(dr(dc.ColumnName), "yyyyMMddHHmmss") & "" & IIf(dc.Ordinal < dt.Columns.Count - 1, ",", "")
					Else
						strResult = strResult & dr(dc.ColumnName) & "" & IIf(dc.Ordinal < dt.Columns.Count - 1, ",", "")
					End If

				Next
				strResult = strResult & "|"
			Next
			strResult = strResult.Substring(0, strResult.Length - 1)
		Else
			strResult = """"""
		End If

		If strCx.flagError Then
			rsp.estadoError(100, "Lista: No se pudo acceder a la base", strCx.msgError)
		Else
			rsp.args = """" & dt.Columns.Count & "&" & prForm("tabla") & "&" & strResult & """"
		End If

	End Sub
	

End Class

