Imports System.Data.Odbc
Imports System.Data
Imports System.IO
Imports System.Configuration

Public Class StringConex
	Private flagTransaccion As Boolean = False
	Public flagError As Boolean = False
	Public msgError As String
	Public sqlcmd As New OdbcCommand
	Private tx As OdbcTransaction
	Private sqlcon As New OdbcConnection
	Private strConex As String = "dsn=" & ConfigurationSettings.AppSettings("dsn")
	Public filasAfectadas As Integer
	Public Sub New()
		Me.sqlcon.ConnectionString = Me.strConex
		Me.sqlcmd.Connection = sqlcon
	End Sub
	Public Sub openConex()
		If Me.sqlcon.State = ConnectionState.Closed Then
			Me.sqlcon.Open()
		End If
	End Sub
	Public Sub closeConex()
		If Not flagTransaccion Then
			If Me.sqlcon.State <> ConnectionState.Closed Then
				Try
					Me.sqlcon.Close()
				Catch ex As Exception
					Me.flagError = True
					Me.msgError = ex.Message
				End Try
			End If
		End If
	End Sub

	Function retornaDataRow(ByVal strSql As String) As DataRow
		Dim dt As New DataTable
		Dim dr As OdbcDataReader
		sqlcmd.CommandText = strSql
		Debug.Print(strSql)
		Try
			openConex()
			escribeLog("SQL", "OK Sql: " & strSql)
			dr = sqlcmd.ExecuteReader()
			dt.Load(dr)
			retornaDataRow = dt.Rows(0)
			If Not Me.flagTransaccion Then Me.closeConex()
		Catch ex As Exception
			Me.flagError = True
			Me.msgError = ex.Message
			retornaDataRow = Nothing
			Me.closeConex()
		End Try
	End Function

	Function retornaDataTable(ByVal strSql As String) As DataTable
		Dim dt As New DataTable
		Dim dr As OdbcDataReader
		sqlcmd.CommandText = strSql
		Debug.Print(strSql)
		Try
			openConex()
			escribeLog("SQL", "OK Sql: " & strSql)
			dr = sqlcmd.ExecuteReader()
			dt.Load(dr)
			retornaDataTable = dt
			If Not Me.flagTransaccion Then Me.closeConex()
		Catch ex As Exception
			Me.flagError = True
			Me.msgError = ex.Message
			retornaDataTable = Nothing
			Me.closeConex()
		End Try
	End Function
	Function retornaDato(ByVal strSql As String) As Integer
		Debug.Print(strSql)
		If flagTransaccion And flagError Then
			retornaDato = -1
			Exit Function
		End If
		Try
			openConex()
			escribeLog("SQL", "OK Sql: " & strSql)
			Me.sqlcmd.CommandText = strSql
			retornaDato = Me.sqlcmd.ExecuteScalar()
		Catch ex As Exception
			retornaDato = -1
			Me.flagError = True
			Me.msgError = ex.Message
		End Try
		Me.closeConex()
	End Function
	Function retornaDatoStr(ByVal strSql As String) As String
		Debug.Print(strSql)
		If flagTransaccion And flagError Then
			retornaDatoStr = ""
			Exit Function
		End If
		Try
			openConex()
			escribeLog("SQL", "OK Sql: " & strSql)
			Me.sqlcmd.CommandText = strSql
			retornaDatoStr = Me.sqlcmd.ExecuteScalar
		Catch ex As Exception
			retornaDatoStr = ""
			Me.flagError = True
			Me.msgError = ex.Message
		End Try
		Me.closeConex()
	End Function
	Sub ejecutaSql(ByVal strSql As String)

		If flagTransaccion And flagError Then
			escribeLog("SQL", "Fallo Tx: " & strSql)
		Else
			openConex()

			Me.sqlcmd.CommandText = strSql
			Try
				filasAfectadas = Me.sqlcmd.ExecuteNonQuery
				escribeLog("SQL", "OK Sql: " & strSql)
				'  If Not Me.flagTransaccion Then Me.closeConex()
			Catch ex As Exception
				Me.flagError = True
				Me.msgError = ex.Message
				escribeLog("ERROR SQL", strSql)
			End Try
			Me.closeConex()
		End If
	End Sub
	Sub iniciaTransaccion()
		escribeLog("SQL", "INICIO TX")
		openConex()
		tx = Me.sqlcon.BeginTransaction()
		flagTransaccion = True
		flagError = False
		Me.sqlcmd.Transaction = tx

	End Sub
	Sub finTransaccion()
		If flagError And flagTransaccion Then
			escribeLog("SQL", "ROLLBACK TX")
			tx.Rollback()
		Else
			escribeLog("SQL", "COMMIT TX")
			tx.Commit()
		End If
		Me.sqlcmd.Transaction = Nothing
		flagTransaccion = False
	End Sub

	Protected Overrides Sub Finalize()
		closeConex()
		MyBase.Finalize()
	End Sub

	Public Shared Sub escribeLog(ByVal strOperacion As String, ByVal strSql As String)

		Dim strWr As New StreamWriter(AppDomain.CurrentDomain.BaseDirectory & "\Log\LogDb.txt", True)
		Dim strLog As String
		Debug.Print(strSql)
		strLog = "'fecha' : '$1', 'Operacion':'$2', 'SQL': '$3' "
		strLog = Replace(strLog, "'", """")
		strLog = Replace(strLog, "$1", Now())
		strLog = Replace(strLog, "$2", "")
		strLog = Replace(strLog, "$3", strSql)
		strWr.WriteLine(strLog)
		strWr.Close()

	End Sub
End Class


