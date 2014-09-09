Imports Elx.CommonClass


Public Class clsUsuario
    Inherits clsEntidad

    Sub lista()
        Dim vFiltro As String = ""
        If Not prForm("txtidUsuario") = "" Then
            vFiltro = " and al1.idUsuario = " & Me.prGet("txtidUsuario")
        End If

        If Not prGet("txtidUsuario") = "" Then
            vFiltro = " and al1.idUsuario = " & Me.prGet("txtidUsuario")
        End If

        If Not prForm("filter[filters][0][field]") = "" Then
            vFiltro = " and al1.idUsuario= " & Me.prForm("filter[filters][0][value]")
        End If
        listaSql("vUsuarios", vFiltro)
    End Sub

    Sub insertar()
        Dim strCx As New StringConex
        Dim strSql As String
        strSql = "INSERT INTO elx_hr_personal (idRol,nombre,apellido,cargo,antiguedad,fechaNacimiento,fono,email,usuario,password) VALUES ('$1','$2','$3','$4', '$5', '$6', '$7','$8','$9',MD5('$10'))"
        strSql = Replace(strSql, "$1", Me.prForm("txtidRol"))
        strSql = Replace(strSql, "$2", Me.prForm("txtNombre"))
        strSql = Replace(strSql, "$3", Me.prForm("txtApellido"))
        strSql = Replace(strSql, "$4", Me.prForm("txtCargo"))
        strSql = Replace(strSql, "$5", Me.prForm("txtAntiguedad"))
        strSql = Replace(strSql, "$6", Me.prForm("txtFechaNacimiento"))
        strSql = Replace(strSql, "$7", Me.prForm("txtFono"))
        strSql = Replace(strSql, "$8", Me.prForm("txtEmail"))
        strSql = Replace(strSql, "$9", Me.prForm("txtUsuario"))
        strSql = Replace(strSql, "$10", Me.prForm("txtPassword"))
        strCx.ejecutaSql(strSql)
        If strCx.flagError Then
            rsp.estadoError(100, strCx.msgError)
        Else
            rsp.args = "{ ""idUsuario"": " & strCx.retornaDato("SELECT max(idUsuario) FROM elx_hr_personal") & "}"
        End If

    End Sub

    Sub editar()
        Dim strCx As New StringConex
        Dim strSql As String
        strSql = "UPDATE elx_hr_personal SET  idRol = $1, nombre = '$2', apellido = '$3', cargo = '$4', antiguedad = '$5', fechaNacimiento = '$6',fono = '$7', email = '$8', usuario ='$9', password = MD5('$10')  WHERE idUsuario= $11"
        strSql = Replace(strSql, "$11", Me.prForm("txtidUsuario"))
        strSql = Replace(strSql, "$1", Me.prForm("txtidRol"))
        strSql = Replace(strSql, "$2", Me.prForm("txtNombre"))
        strSql = Replace(strSql, "$3", Me.prForm("txtApellido"))
        strSql = Replace(strSql, "$4", Me.prForm("txtCargo"))
        strSql = Replace(strSql, "$5", Me.prForm("txtAntiguedad"))
        strSql = Replace(strSql, "$5", Me.prForm("txtFechaNacimiento"))
        strSql = Replace(strSql, "$5", Me.prForm("txtFono"))
        strSql = Replace(strSql, "$5", Me.prForm("txtEmail"))
        strSql = Replace(strSql, "$5", Me.prForm("txtUsuario"))
        strSql = Replace(strSql, "$5", Me.prForm("txtPassword"))
        strCx.ejecutaSql(strSql)
        If strCx.flagError Then
            rsp.estadoError(100, "Editar: No se pudo acceder a la base")
        End If
    End Sub

    Sub eliminar()
        Dim strCx As New StringConex
        Dim strSql As String
        strSql = "DELETE FROM  elx_hr_personal WHERE idUsuario =  $1"
        strSql = Replace(strSql, "$1", Me.prGet("txtidUsuario"))
        strCx.ejecutaSql(strSql)
        If strCx.flagError Then
            rsp.estadoError(100, "Eliminar: No se pudo acceder a la base")
        End If
    End Sub
End Class
