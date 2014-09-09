

Public Class Sincronizacion
	Inherits clsEntidad
	

	Sub Actualizar()
		Dim strCx As New StringConex
		Dim dt As DataTable
		Dim strSql As String
		strSql = "SELECT  * FROM " & prForm("tabla") & " where ultimaModificacion > '" & prForm("fecha") & "'"
		For i = 0 To 1000000000

		Next
		dt = strCx.retornaDataTable(strSql)
		Dim strResult As String = """"
		If dt.Rows.Count > 0 Then
			For Each dr As DataRow In dt.Rows
				For Each dc As DataColumn In dt.Columns
					strResult = strResult & dr(dc.ColumnName) & """" & IIf(dc.Ordinal < dt.Columns.Count - 1, ",", "")
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
			rsp.args = strResult
		End If

	End Sub
	

End Class

