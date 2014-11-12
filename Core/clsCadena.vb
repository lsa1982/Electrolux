Imports Elx.CommonClass


Imports System.Text
Imports System.IO

Public Class clsCadena
    Inherits clsEntidad

    Sub lista()
        Dim strCx As New StringConex
        Dim dt As DataTable
        Dim strSql As String



        strSql = "SELECT * FROM elx_core_cadena"
        If Not prForm("txtidCadena") = "" Then
            strSql = strSql & " WHERE idCadena = " & Me.prGet("txtidCadena")
            strCx.ejecutaSql(strSql)
        End If

        If Not prGet("txtidCadena") = "" Then
            strSql = strSql & " WHERE idCadena = " & Me.prGet("txtidCadena")
            strCx.ejecutaSql(strSql)
        End If

		dt = strCx.retornaDataTable(strSql)


        If strCx.flagError Then
            rsp.estadoError(100, "Lista: No se pudo acceder a la base")
        Else
            rsp.totalFila = dt.Rows.Count
            rsp.args = Me.retornaTablaSerializada(dt)
            Debug.Print(rsp.args)
        End If
    End Sub
    Sub insertar()
        Dim strCx As New StringConex
        Dim strSql As String
        strSql = "INSERT INTO elx_core_cadena (cadena, razonSocial, rut, estado, imagen) VALUES ('$1', '$2', '$3', '$4', '$5')"
        strSql = Replace(strSql, "$1", Me.prForm("txtCadena"))
        strSql = Replace(strSql, "$2", Me.prForm("txtRazonSocial"))
        strSql = Replace(strSql, "$3", Me.prForm("txtRut"))
        strSql = Replace(strSql, "$4", Me.prForm("txtEstado"))
        strSql = Replace(strSql, "$5", Me.prForm("txtUpload"))
        strCx.ejecutaSql(strSql)
        If strCx.flagError Then
            rsp.estadoError(100, strCx.msgError)
        Else
            File.Move(AppDomain.CurrentDomain.BaseDirectory & "Modulos\Core\images\Temp\" & Me.prForm("txtUpload"),
                AppDomain.CurrentDomain.BaseDirectory & "Modulos\Core\images\cadena\" & Me.prForm("txtUpload"))
            rsp.args = "{ ""idCadena"": " & strCx.retornaDato("SELECT max(idCadena) FROM elx_core_cadena") & "}"
        End If

    End Sub
    Sub editar()
        Dim strCx As New StringConex
        Dim strSql As String
        strSql = "UPDATE elx_core_cadena SET  cadena = '$1', razonSocial = '$2', rut = '$3', estado ='$4', imagen='$5' WHERE idCadena= $6"
        strSql = Replace(strSql, "$6", Me.prForm("txtidCadena"))
        strSql = Replace(strSql, "$1", Me.prForm("txtCadena"))
        strSql = Replace(strSql, "$2", Me.prForm("txtRazonSocial"))
        strSql = Replace(strSql, "$3", Me.prForm("txtRut"))
        strSql = Replace(strSql, "$4", Me.prForm("txtEstado"))
        strSql = Replace(strSql, "$5", Me.prForm("txtimagen"))
        strCx.ejecutaSql(strSql)
        If strCx.flagError Then
            rsp.estadoError(100, "Editar: No se pudo acceder a la base")
        End If
    End Sub

    Sub eliminar()
        Dim strCx As New StringConex
        Dim strSql As String
        strSql = "DELETE FROM  elx_core_cadena WHERE idCadena =  $1"
        strSql = Replace(strSql, "$1", Me.prGet("txtidCadena"))
        strCx.ejecutaSql(strSql)
        If strCx.flagError Then
            rsp.estadoError(100, "Eliminar: No se pudo acceder a la base")
        End If
    End Sub

    Sub subirImagen()
        If (prFile.Count = 0) Then
            rsp.estadoError(100, "No se pudo subir archivo")
        Else

            If Right(prFile.Item(0).FileName, 3) <> "jpg" And Right(prFile.Item(0).FileName, 3) <> "png" Then
                rsp.estadoError(200, "Extension Incorrecta")
            Else
                Try
                    prFile.Item(0).SaveAs(AppDomain.CurrentDomain.BaseDirectory & "Modulos\Core\images\Temp\" & prFile.Item(0).FileName)
                    rsp.pagina = prFile.Item(0).FileName
                Catch ex As Exception
                    rsp.estadoError(201, ex.Message)
                End Try

            End If
        End If
    End Sub

    Sub guardarImagen()
       
    End Sub

End Class

