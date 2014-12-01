

Public Class Sincronizacion
	Inherits clsEntidad
	

	Sub ActualizarCampo()
		Dim strCx As New StringConex
		Dim dt As DataTable
		Dim strSql As String
		strSql = "SELECT " & prForm("campo") & " FROM " & prForm("tabla")
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
			rsp.args = """" & strResult & """"
		End If

	End Sub

	Sub Actualizar()
		Dim strCx As New StringConex
		Dim dt As DataTable
		Dim strSql As String
		strSql = "SELECT * FROM " & prForm("tabla")
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
	
	Sub InsertarLectura()

		Dim strCx As New StringConex
		Dim strSql As String
		Dim str
		Dim x
		Dim spli As String()
		Dim splits As String()


		spli = Split(prGet("dato"), "|")
		For i = 0 To spli.Length - 1 'recorre registros'
			str = spli(i)
			splits = Split(str, ",")

			strSql = "INSERT INTO elx_core_lectura (idTienda, idProducto, precio, distancia, fleje, pop, oferta,sincronizado,fechaIngreso,usuario) " & _
			"VALUES ($1, $2,$3, '$4',$5, $6,$7,$8,'$9','$10')"

			For x = 0 To splits.Length - 1 ' recorre por campos'

				strSql = Replace(strSql, "$" & (x + 1), splits(x))
			Next
			strCx.ejecutaSql(strSql)

		Next

		If strCx.flagError Then
			rsp.estadoError(100, strCx.msgError)
		Else
			rsp.args = "{ ""Registros"": " & spli.Length & "}"
		End If

	End Sub
End Class

