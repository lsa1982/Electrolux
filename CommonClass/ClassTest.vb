
Public Class ClassTest
    Inherits clsEntidad
    Sub Insertar()

        Dim strCx As New StringConex
        Dim strSql As String
        Dim rows As Integer
        Dim str
        Dim x
        rows = prForm("jObject[0]")
        Dim splits As String()
        Dim splits2 As String()
        Dim tmp() As String

        For i = 0 To rows - 1 'recorre registros'
            str = prForm("jObject[" & i + 1 & "]")
            splits = Split(str, ",")

            strSql = "INSERT INTO elx_db_test.test2 VALUES ($1, '$2')"

            For x = 0 To splits.Length - 1 ' recorre por campos'
                splits2 = Split(splits(x), "=")
                If (x = 0) Then
                    strSql = Replace(strSql, "$1", splits2(1))
                End If
                If (x = 1) Then
                    strSql = Replace(strSql, "$2", splits2(1))
                End If

                splits2 = tmp
            Next
            strCx.ejecutaSql(strSql)
            splits = tmp

        Next

        If strCx.flagError Then
            rsp.estadoError(100, strCx.msgError)
        Else
            rsp.args = "{ ""id_test"": " & rows & "}"
        End If
    End Sub
End Class
