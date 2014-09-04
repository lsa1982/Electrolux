﻿Imports Elx.CommonClass


Public Class clsCategoria
    Inherits clsEntidad

    Sub lista()
        Dim strCx As New StringConex
        Dim dt As DataTable
        Dim strSql As String


        strSql = "SELECT * FROM elx_core_categoria"
        If Not prForm("txtidCategoria") = "" Then
            strSql = strSql & " WHERE idCategoria = " & Me.prGet("txtidCategoria")
            strCx.ejecutaSql(strSql)
        End If

        If Not prGet("txtidCategoria") = "" Then
            strSql = strSql & " WHERE idCategoria = " & Me.prGet("txtidCategoria")
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
        strSql = "INSERT INTO elx_core_categoria (categoria, padre, activo, orden, tipo, imagen) VALUES ('$1', '$2', '$3', '$4','$5','$6')"
        strSql = Replace(strSql, "$1", Me.prForm("txtCategoria"))
        strSql = Replace(strSql, "$2", Me.prForm("txtPadre"))
        strSql = Replace(strSql, "$3", Me.prForm("txtActivo"))
        strSql = Replace(strSql, "$4", Me.prForm("txtOrden"))
        strSql = Replace(strSql, "$5", Me.prForm("txtTipo"))
        strSql = Replace(strSql, "$6", Me.prForm("txtImagen"))
        strCx.ejecutaSql(strSql)
        If strCx.flagError Then
            rsp.estadoError(100, strCx.msgError)
        Else
            rsp.args = "{ ""idCategoria"": " & strCx.retornaDato("SELECT max(idCategoria) FROM elx_core_categoria") & "}"
        End If

    End Sub

    Sub editar()
        Dim strCx As New StringConex
        Dim strSql As String
        strSql = "UPDATE elx_core_categoria SET  categoria = '$1', padre = '$2' , activo = '$3', orden = '$4', tipo = '$5', imagen = '$6' WHERE idCategoria= '$7'"
        strSql = Replace(strSql, "$7", Me.prGet("txtidCategoria"))
        strSql = Replace(strSql, "$1", Me.prGet("txtCategoria"))
        strSql = Replace(strSql, "$2", Me.prGet("txtPadre"))
        strSql = Replace(strSql, "$3", Me.prGet("txtActivo"))
        strSql = Replace(strSql, "$4", Me.prGet("txtOrden"))
        strSql = Replace(strSql, "$5", Me.prGet("txtTipo"))
        strSql = Replace(strSql, "$6", Me.prGet("txtImagen"))
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
End Class
