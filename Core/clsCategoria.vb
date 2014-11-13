Imports Elx.CommonClass
Imports System.IO


Public Class clsCategoria
    Inherits clsEntidad

    Sub lista()
        Dim strCx As New StringConex
        Dim dt As DataTable
        Dim strSql As String


        strSql = "SELECT * FROM elx_core_categoria WHERE 1 "
        If Not prForm("txtidCategoria") = "" Then
            strSql = strSql & " and idCategoria = " & Me.prForm("txtidCategoria")
        End If

        If Not prGet("txtidCategoria") = "" Then
            strSql = strSql & " and idCategoria = " & Me.prGet("txtidCategoria")
        End If

        If Not prForm("tipo") = "" Then
            strSql = strSql & " and tipo = '" & Me.prForm("tipo") & "'"
        End If

        strCx.ejecutaSql(strSql)
        dt = strCx.retornaDataTable(strSql)

        If strCx.flagError Then
            rsp.estadoError(100, "Lista: No se pudo acceder a la base", strCx.msgError)
        Else
            rsp.totalFila = dt.Rows.Count
            rsp.args = Me.retornaTablaSerializada(dt)
            Debug.Print(rsp.args)
        End If
    End Sub



    Sub insertar()
        Dim strCx As New StringConex
        Dim strSql As String
        strSql = "INSERT INTO elx_core_categoria (categoria, subcategoria, padre, activo, orden, tipo, clase, imagen) VALUES ('$1','$7', '$2', '$3', '$4','$5', '$8','$6')"
        strSql = Replace(strSql, "$1", Me.prForm("txtCategoria"))
        strSql = Replace(strSql, "$7", Me.prForm("txtSubCategoria"))
        strSql = Replace(strSql, "$2", Me.prForm("txtPadre"))
        strSql = Replace(strSql, "$3", Me.prForm("txtActivo"))
        strSql = Replace(strSql, "$4", Me.prForm("txtOrden"))
        strSql = Replace(strSql, "$5", Me.prForm("txtTipo"))
        strSql = Replace(strSql, "$8", Me.prForm("txtClase"))
        strSql = Replace(strSql, "$6", Me.prForm("txtUpload"))
        strCx.ejecutaSql(strSql)
        If strCx.flagError Then
            rsp.estadoError(100, strCx.msgError)
        Else
            File.Move(AppDomain.CurrentDomain.BaseDirectory & "Modulos\Core\images\Temp\" & Me.prForm("txtUpload"),
                AppDomain.CurrentDomain.BaseDirectory & "Modulos\Core\images\categoria\" & Me.prForm("txtUpload"))
            rsp.args = "{ ""idCategoria"": " & strCx.retornaDato("SELECT max(idCategoria) FROM elx_core_categoria") & "}"
        End If

    End Sub

    Sub editar()
        Dim strCx As New StringConex
        Dim strSql As String
        strSql = "UPDATE elx_core_categoria SET  categoria = '$1', subcategoria = $8 , padre = $2 , activo = '$3', orden = $4, tipo = '$5', clase = '$9' , imagen = '$6' WHERE idCategoria= $7"
        strSql = Replace(strSql, "$7", Me.prForm("txtidCategoria"))
        strSql = Replace(strSql, "$1", Me.prForm("txtCategoria"))
        strSql = Replace(strSql, "$8", Me.prForm("txtSubCategoria"))
        strSql = Replace(strSql, "$2", Me.prForm("txtPadre"))
        strSql = Replace(strSql, "$3", Me.prForm("txtActivo"))
        strSql = Replace(strSql, "$4", Me.prForm("txtOrden"))
        strSql = Replace(strSql, "$5", Me.prForm("txtTipo"))
        strSql = Replace(strSql, "$9", Me.prForm("txtClase"))
        strSql = Replace(strSql, "$6", Me.prForm("txtImagen"))
        strCx.ejecutaSql(strSql)
        If strCx.flagError Then
            rsp.estadoError(100, "Editar: No se pudo acceder a la base")
        End If
    End Sub

    Sub eliminar()
        Dim strCx As New StringConex
        Dim strSql As String
        strSql = "DELETE FROM  elx_core_categoria WHERE idCategoria =  $1"
        strSql = Replace(strSql, "$1", Me.prGet("txtidCategoria"))
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


End Class
