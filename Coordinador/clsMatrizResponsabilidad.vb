Imports Elx.CommonClass

Public Class clsMatrizResponsabilidad
	Inherits clsEntidad

	'' ############################################################
	'' ###	carga de cargar perfiles                            ###
	'' ############################################################

	Sub ListarPerfilRol()
		Dim strCx As New StringConex
		Dim dt As DataTable
		Dim strSql As String
		Dim strResult = """"
		Dim RolS As String = """"
		Dim rolcol = 0
		Dim rolstr = 0
		Dim rols_comapre As String = """"
		strSql = sqlText("vPerfilRol")
		
		dt = strCx.retornaDataTable(strSql)

		If dt.Rows.Count > 0 Then
			strResult = "["
			For Each dr As DataRow In dt.Rows
				strResult = strResult & "{"
				For Each dc As DataColumn In dt.Columns
					If dc.DataType.Name = "Byte[]" Then
						strResult = strResult & dc.ColumnName & ": """ & System.Text.Encoding.UTF8.GetString(dr(dc.ColumnName)) & """" & IIf(dc.Ordinal < dt.Columns.Count - 1, ",", "")
					Else
						rols_comapre = dr(dc.ColumnName)
						rolcol = String.Compare(RolS, rols_comapre)
						If (rolcol = -1 And dc.ColumnName = "ROL") Then
							If rolstr = 1 Then
								strResult = strResult.Substring(0, strResult.Length - 2) & "]},{"
								rolstr = 0
							End If
							strResult = strResult & """" & dc.ColumnName & """: """ & dr(dc.ColumnName) & """" & IIf(dc.Ordinal < dt.Columns.Count - 1, ",", "")
							RolS = dr(dc.ColumnName)
						Else
							If dc.ColumnName = "NOMBRE" Then
								If rolstr = 0 Then
									strResult = strResult & """subNombre""" & ": [{"
									strResult = strResult & """" & dc.ColumnName & """: """ & dr(dc.ColumnName) & """" & IIf(dc.Ordinal < dt.Columns.Count - 1, ",", "")
								Else
									strResult = strResult & """" & dc.ColumnName & """: """ & dr(dc.ColumnName) & """" & IIf(dc.Ordinal < dt.Columns.Count - 1, ",", "")
								End If

								strResult = strResult & "},"
								rolstr = 1
							End If

						End If

					End If
				Next

			Next

			strResult = strResult.Substring(0, strResult.Length - 1) & "]}"
		Else
			strResult = """"""
		End If
		strResult = strResult & "]"
		If strCx.flagError Then
			rsp.estadoError(100, "Lista: No se pudo acceder a la base")
		Else
			rsp.totalFila = dt.Rows.Count
			rsp.args = strResult
			Debug.Print(rsp.args)
		End If

	End Sub

	'' ##############################################################
	'' ###  caraga de cargar informacion detalle del perfil         #
	'' ##############################################################

	Sub ListarMatriz()
		Dim strCx As New StringConex
		Dim dt As DataTable
		Dim strSql As String
		strSql = sqlText("vMatriz")
		strSql = strSql & " and al2.rol= '" & prForm("txtTipo") & "'"

		dt = strCx.retornaDataTable(strSql)

		If strCx.flagError Then
			rsp.estadoError(100, "Lista: No se pudo acceder a la base", strCx.msgError)
		Else
			rsp.totalFila = dt.Rows.Count
			rsp.args = Me.retornaTablaSerializada(dt)
			Debug.Print(rsp.args)
		End If

	End Sub

	'' ############################################################
	'' ### Carga Variables Matriz                				###
	'' ############################################################

	Sub ListarVariable()
		Dim strCx As New StringConex
		Dim dt As DataTable
		Dim strSql As String
		Dim numRol = 0
		Dim strVariable = ""
		Dim strTabla = ""
		Dim strColumns = ""

		numRol = strCx.retornaDato("select idRol from elx_hr_rol where rol = '" & prForm("idRol") & "'")
		strTabla = strCx.retornaDatoStr("select tabla from elx_cdt_variable where idVariable = " & prForm("idvariable"))
		strColumns = strCx.retornaDatoStr("select columnaid from elx_cdt_variable where idVariable = " & prForm("idvariable"))
		strVariable = strCx.retornaDatoStr("select " & strColumns & " from " & strTabla & " where id" & strColumns & " = " & prForm("idVar"))
		strSql = "Select  " & _
		   "al2.idResponsabilidad,  " & _
		   "al3.Rol,  " & _
			"'" & strVariable & "' as variable, " & _
		   "al2.estado,  " & _
		   "al2.valorInt,  " & _
		   "al2.valorChar " & _
		   "From " & _
		   "elx_cdt_variable al1, " & _
		   "elx_cdt_matrizresponsabilidad al2, " & _
		   "elx_hr_rol al3 " & _
		   "where " & _
		   "al2.idrol = al3.idrol And " & _
		   "al1.idvariable = al2.idVariable And " & _
		   "al2.idVariable =   " & prForm("idVariable") & " and " & _
		   "al2.idrol = " & numRol

		If prForm("idVar") <> 0 Then
			strSql = strSql & " and idTabVariable = " & prForm("idVar")
		End If

		dt = strCx.retornaDataTable(strSql)

		If strCx.flagError Then
			rsp.estadoError(100, "Lista: No se pudo acceder a la base", strCx.msgError)
		Else
			rsp.totalFila = dt.Rows.Count
			rsp.args = Me.retornaTablaSerializada(dt)
			Debug.Print(rsp.args)
		End If
	End Sub

	'' ############################################################
	'' ###	carga combo de acuerdo a variable                   ###
	'' ############################################################

	Sub ListarcmbVariable()
		Dim strCx As New StringConex
		Dim dt As DataTable
		Dim strSql As String
		Dim strTabla = ""
		Dim strColumns = ""
		Dim numRol = 0

		strTabla = strCx.retornaDatoStr("select tabla from elx_cdt_variable where idVariable = " & prForm("idvariable"))
		strColumns = strCx.retornaDatoStr("select columnaid from elx_cdt_variable where idVariable = " & prForm("idvariable"))
		numRol = strCx.retornaDato("select idRol from elx_hr_rol where rol = '" & prForm("idRol") & "'")
		strSql = "Select  " & _
		   "distinct al1." & strColumns & " as TIPO,  " & _
		   "al1.id" & strColumns & " as TIP " & _
		   "From " & _
			 strTabla & " al1, " & _
		   "elx_cdt_matrizresponsabilidad al2 " & _
		   "where " & _
		   "al2.IdTabVariable = al1.id" & strColumns & " and " & _
		   "al2.idVariable =   " & prForm("idvariable") & " and " & _
		   "al2.idrol = " & numRol

		dt = strCx.retornaDataTable(strSql)

		If strCx.flagError Then
			rsp.estadoError(100, "Lista: No se pudo acceder a la base", strCx.msgError)
		Else
			rsp.totalFila = dt.Rows.Count
			rsp.args = Me.retornaTablaSerializada(dt)
			Debug.Print(rsp.args)
		End If

	End Sub

	'' ############################################################
	'' ###	Elimina de la matriz de reponsabilidad				###
	'' ############################################################

	Sub eliminar()
		Dim strCx As New StringConex
		Dim strSql As String
		strSql = "DELETE FROM  elx_cdt_matrizresponsabilidad WHERE idResponsabilidad =  $1"
		strSql = Replace(strSql, "$1", Me.prForm("txtidresponsabilidad"))

		strCx.ejecutaSql(strSql)
		If strCx.flagError Then
			rsp.estadoError(100, "Eliminar: No se pudo acceder a la base", strCx.msgError)
		End If
	End Sub

	'' ############################################################
	'' ###	Insertar en la matriz de responsabilidad			###
	'' ############################################################

	Sub insertar()
		Dim strCx As New StringConex
		Dim strSql As String
		Dim numRol

		numRol = strCx.retornaDato("select idRol from elx_hr_rol where rol = '" & prForm("txtidRol") & "'")

		strSql = "INSERT INTO ELX_CDT_MATRIZRESPONSABILIDAD VALUES (null, $1, $2, $3, $4,'$5',$6)"
		strSql = Replace(strSql, "$1", numRol)
		strSql = Replace(strSql, "$2", prForm("txtidVariable"))
		strSql = Replace(strSql, "$3", prForm("txtestado"))
		strSql = Replace(strSql, "$4", prForm("txtvalorInt"))
		strSql = Replace(strSql, "$5", prForm("txtvalorChar"))
		strSql = Replace(strSql, "$6", prForm("txtidTabVariable"))

		Debug.Print(strSql)
		strCx.ejecutaSql(strSql)

		If strCx.flagError Then
			rsp.estadoError(100, "Insertar: No se pudo acceder a la base", strCx.msgError)
		Else
			rsp.args = "{ ""OK"": ""OK""}"
		End If
	End Sub

	'' ############################################################
	'' ###	Carga combos grid                                   ###
	'' ############################################################

	Sub listacmbTiendas()
		Dim strCx As New StringConex
		Dim dt As DataTable
		Dim strSql As String
		strSql = "Select idtienda as variable, tienda From elx_core_tienda "

		dt = strCx.retornaDataTable(strSql)

		If strCx.flagError Then
			rsp.estadoError(100, "Lista: No se pudo acceder a la base", strCx.msgError)
		Else
			rsp.totalFila = dt.Rows.Count
			rsp.args = Me.retornaTablaSerializada(dt)
			Debug.Print(rsp.args)
		End If
	End Sub

	Sub listacmbMarcas()
		Dim strCx As New StringConex
		Dim dt As DataTable
		Dim strSql As String
		strSql = "Select idmarca as variable, marca From elx_core_marca "

		dt = strCx.retornaDataTable(strSql)

		If strCx.flagError Then
			rsp.estadoError(100, "Lista: No se pudo acceder a la base", strCx.msgError)
		Else
			rsp.totalFila = dt.Rows.Count
			rsp.args = Me.retornaTablaSerializada(dt)
			Debug.Print(rsp.args)
		End If
	End Sub

	Sub listacmbLineas()
		Dim strCx As New StringConex
		Dim dt As DataTable
		Dim strSql As String
		strSql = "Select idlinea as variable, linea From elx_core_linea "
		dt = strCx.retornaDataTable(strSql)

		If strCx.flagError Then
			rsp.estadoError(100, "Lista: No se pudo acceder a la base", strCx.msgError)
		Else
			rsp.totalFila = dt.Rows.Count
			rsp.args = Me.retornaTablaSerializada(dt)
			Debug.Print(rsp.args)
		End If
	End Sub

End Class
