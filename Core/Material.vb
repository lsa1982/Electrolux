Imports Elx.CommonClass

Public Class Material
	Inherits clsEntidad
	Sub lista()
		Dim strSql As String
		Dim vFiltro As String
		strSql = "SELECT SQL_CALC_FOUND_ROWS  * FROM elx_mat_material where 1=1"
		vFiltro = ""
		If Not prForm("idMaterial") = "" Then
			vFiltro = " and al1.idMaterial= " & prForm("idMaterial")
		End If
		If Not prForm("idCategoria") = "" Then
			vFiltro = " and idCategoria= " & prForm("idCategoria")
		End If

		listaSql(strSql, vFiltro, False)
	End Sub
End Class
