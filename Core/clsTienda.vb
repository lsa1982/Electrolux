Imports Elx.CommonClass


Public Class clsTienda
    Inherits clsEntidad

	Sub lista()
		Dim vFiltro As String = ""
		If Not prForm("txtidCadena") = "" Then
			vFiltro = " and al1.idCadena = " & Me.prForm("txtidCadena")
		End If

		If Not prGet("txtidCadena") = "" Then
			vFiltro = " and al1.idCadena = " & Me.prGet("txtidCadena")
		End If

		If Not prForm("filter[filters][0][field]") = "" Then
			vFiltro = vFiltro & " and al1.idCadena = " & Me.prForm("filter[filters][0][value]")
		End If

		If Not prForm("region") = "" Then
			vFiltro = vFiltro & " and al1.region = '" & Me.prForm("region") & "'"
		End If

		If Not prForm("nombre") = "" Then
			vFiltro = vFiltro & " and al1.tienda like '%" & Me.prForm("nombre") & "%'"
		End If

		If Not prForm("skip") = "" Then
			vFiltro = vFiltro & " limit " & prForm("skip") & ", " & prForm("take")
		Else
			vFiltro = vFiltro & " limit 0 , 50"
		End If

		listaSql("vTiendas", vFiltro)
	End Sub
	Sub listaRegion()
		Dim vFiltro As String = ""
		If Not prForm("idCadena") = "" Then
			vFiltro = " and idCadena = " & Me.prForm("idCadena")
		End If
		listaSql("select region from elx_core_region where region in (select distinct region from elx_core_tienda where 1=1 ", vFiltro, False, " ) order by nmroRegion")
	End Sub

    Sub insertar()
        Dim strCx As New StringConex
        Dim strSql As String
		strSql = "INSERT INTO elx_core_tienda (idCadena, tienda, status, geo_x, geo_y, idCategoria, region, codigoTienda) VALUES ('$1','$3','$4', '$5', '$6', '$7', '$8', '$9')"
        strSql = Replace(strSql, "$1", Me.prForm("txtidCadena"))
        strSql = Replace(strSql, "$3", Me.prForm("txtTienda"))
        strSql = Replace(strSql, "$4", Me.prForm("txtStatus"))
        strSql = Replace(strSql, "$5", Me.prForm("txtGeo_x"))
        strSql = Replace(strSql, "$6", Me.prForm("txtGeo_y"))
		strSql = Replace(strSql, "$7", Me.prForm("txtidCategoria"))
		strSql = Replace(strSql, "$7", Me.prForm("txtRegion"))
		strSql = Replace(strSql, "$7", Me.prForm("txtCodigoTienda"))
        strCx.ejecutaSql(strSql)
        If strCx.flagError Then
            rsp.estadoError(100, strCx.msgError)
        Else
            rsp.args = "{ ""idTienda"": " & strCx.retornaDato("SELECT max(idTienda) FROM elx_core_tienda") & "}"
        End If

    End Sub

    Sub editar()
        Dim strCx As New StringConex
        Dim strSql As String
		strSql = "UPDATE elx_core_tienda SET  idCadena = $1, tienda = '$3', status = '$4', geo_x = '$5', geo_y = '$6', region = '$9', codigoTienda = '$A'  WHERE idTienda= $8"
        strSql = Replace(strSql, "$8", Me.prForm("txtidTienda"))
        strSql = Replace(strSql, "$1", Me.prForm("txtidCadena"))
        strSql = Replace(strSql, "$3", Me.prForm("txtTienda"))
        strSql = Replace(strSql, "$4", Me.prForm("txtStatus"))
        strSql = Replace(strSql, "$5", Me.prForm("txtGeo_x"))
		strSql = Replace(strSql, "$6", Me.prForm("txtGeo_y"))
		strSql = Replace(strSql, "$9", Me.prForm("txtRegion"))
		strSql = Replace(strSql, "$A", Me.prForm("txtCodigoTienda"))
        strCx.ejecutaSql(strSql)
        If strCx.flagError Then
            rsp.estadoError(100, "Editar: No se pudo acceder a la base")
        End If
    End Sub

    Sub eliminar()
        Dim strCx As New StringConex
        Dim strSql As String
        strSql = "DELETE FROM  elx_core_tienda WHERE idTienda =  $1"
        strSql = Replace(strSql, "$1", Me.prGet("txtidTienda"))
        strCx.ejecutaSql(strSql)
        If strCx.flagError Then
            rsp.estadoError(100, "Eliminar: No se pudo acceder a la base")
        End If
    End Sub
End Class
