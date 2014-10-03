Imports System.IO
Imports System.IO.IsolatedStorage
Imports System.Collections.Specialized
Imports Elx.Seguridad

Public MustInherit Class clsEntidad
	Public rsp As xhrResponse
	Private usuarioRemotoValue As String
	Private rolValue As Rol
	Private prFormValue As NameValueCollection
	Private prGetValue As NameValueCollection
	Private prFileValue As System.Web.HttpFileCollection

	Sub New()
		rsp = New xhrResponse()
		rsp.errorCode = 0
		rolValue = New Rol
	End Sub
	Public ReadOnly Property respuesta As xhrResponse
		Get
			Return rsp
		End Get
	End Property
	Public Property Rol() As Rol
		Get
			Return rolValue
		End Get
		Set(ByVal value As Rol)
			rolValue = value
		End Set
	End Property
	Public Property prForm() As NameValueCollection
		Get
			Return prFormValue
		End Get
		Set(ByVal value As NameValueCollection)
			prFormValue = value
		End Set
	End Property
	Public Property prGet() As NameValueCollection
		Get
			Return prGetValue
		End Get
		Set(ByVal value As NameValueCollection)
			prGetValue = value
		End Set
	End Property
	Public Property usuarioRemoto() As String
		Get
			Return usuarioRemotoValue
		End Get
		Set(ByVal value As String)
			usuarioRemotoValue = value
		End Set
	End Property
	Public Property prFile() As System.Web.HttpFileCollection
		Get
			Return prFileValue
		End Get
		Set(ByVal value As System.Web.HttpFileCollection)
			prFileValue = value
		End Set
	End Property
	Function retornaTablaSerializada(ByVal dt As DataTable) As String
		Dim strResult As String = """"
		If dt.Rows.Count > 0 Then
			strResult = "["
			For Each dr As DataRow In dt.Rows
				strResult = strResult & "{"
				For Each dc As DataColumn In dt.Columns
					If dc.DataType.Name = "Byte[]" Then
						strResult = strResult & """" & dc.ColumnName & """: """ & System.Text.Encoding.UTF8.GetString(dr(dc.ColumnName)) & """" & IIf(dc.Ordinal < dt.Columns.Count - 1, ",", "")
					Else
						strResult = strResult & """" & dc.ColumnName & """: """ & dr(dc.ColumnName) & """" & IIf(dc.Ordinal < dt.Columns.Count - 1, ",", "")
					End If

				Next
				strResult = strResult & "},"
			Next
			strResult = strResult.Substring(0, strResult.Length - 1) & "]"
		Else
			strResult = """"""
		End If

		retornaTablaSerializada = strResult
	End Function
	Function sqlText(ByVal fileSql As String) As String
		fileSql = AppDomain.CurrentDomain.BaseDirectory & "bin\SQL\" & fileSql & ".sqlx"
		If File.Exists(fileSql) Then
			sqlText = File.ReadAllText(fileSql)
		Else
			sqlText = ""
		End If
	End Function
	Sub listaSql(ByVal vistaSql As String, Optional ByVal vistaParam As String = "", Optional ByVal archivoSql As Boolean = True)
		Dim strCx As New StringConex
		Dim dt As DataTable
		Dim strSql As String
		If archivoSql Then
			strSql = sqlText(vistaSql) & vistaParam
		Else
			strSql = vistaSql & vistaParam
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



	Function DataTableSql(ByVal vistaSql As String, Optional ByVal vistaParam As String = "") As DataTable
		Dim strCx As New StringConex
		Dim strSql As String
		strSql = sqlText(vistaSql) & vistaParam
		DataTableSql = strCx.retornaDataTable(strSql)
	End Function

End Class

