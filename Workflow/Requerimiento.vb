Imports Elx.CommonClass
Imports System.Net.Mail

Public Class Requerimiento
	Inherits clsEntidad

#Region "Vista de Requerimiento"

	Sub lista()
		Dim vFiltro As String = ""
		If prForm("idTienda") <> "" Then
			vFiltro = " and al1.idTienda= " & prForm("idTienda")
		End If

		If prForm("idProducto") <> "" Then
			vFiltro = " and al1.idRequerimiento in (select idRequerimiento from elx_wf_flujoClave where variable = 'producto' and idClave =  " & prForm("idTienda") & ") "
		End If

		If prForm("idMaterial") <> "" Then
			vFiltro = " and al1.idRequerimiento in (select idRequerimiento from elx_wf_flujoClave where variable = 'material' and idClave =  " & prForm("idMaterial") & ") "
		End If

		If prForm("idCita") <> "" Then
			vFiltro = " and al1.idRequerimiento in (select idRequerimiento from elx_wf_flujoClave where variable = 'cita' and idClave =  " & prForm("idCita") & ") "
		End If

		If prForm("idRequerimiento") <> "" Then
			vFiltro = " and al1.idRequerimiento = " & prForm("idRequerimiento")
		End If
		vFiltro = vFiltro & " and al1.idRol = " & Rol.idRol
		vFiltro = Rol.aplicaFiltro("Tienda", vFiltro, "al1.idTienda")
		listaSql("vWfRequerimientoFull", vFiltro)
	End Sub

	Sub listaEstados()
		Dim vFiltro As String = ""
		If prForm("idRequerimiento") <> "" Then
			vFiltro = " and al1.idRequerimiento = " & prForm("idRequerimiento")
		End If
		listaSql("vWfEstados", vFiltro)
	End Sub

	Sub listaRoles()
		Dim vFiltro As String = ""
		If prForm("idRequerimiento") <> "" Then
			vFiltro = " and al1.idRequerimiento = " & prForm("idRequerimiento")
		End If
		listaSql("vWfEstadoActual", vFiltro)
	End Sub

	Sub listaClaves()
		Dim strCx As New StringConex
		Dim dtClave As DataTable
		Dim drResultado As DataRow
		Dim strSql As String
		dtClave = strCx.retornaDataTable("select variable, idClave from elx_wf_flujoClave where idRequerimiento = " & prForm("idRequerimiento"))
		rsp.args = "["
		For Each r As DataRow In dtClave.Rows
			If r("variable") = "producto" Then
				strSql = sqlText("vWfProductos")
				strSql = strSql & " and al1.idProducto = " & r("idClave")
				drResultado = strCx.retornaDataRow(strSql)
				rsp.args = rsp.args & "{ 'tipo' :'producto', 'data' : { 'idProducto' : '$1', 'producto': '$2', 'marca': '$3', 'categoria': '$4'} } ,"
				rsp.args = Replace(rsp.args, "$1", drResultado("idProducto"))
				rsp.args = Replace(rsp.args, "$2", drResultado("nombre"))
				rsp.args = Replace(rsp.args, "$3", drResultado("marca"))
				rsp.args = Replace(rsp.args, "$4", drResultado("categoria"))
			End If
			If r("variable") = "repuesto" Then
				strSql = sqlText("vWfRepuesto")
				strSql = strSql & " and al1.idRepuesto = " & r("idClave")
				drResultado = strCx.retornaDataRow(strSql)
				rsp.args = rsp.args & "{ 'tipo' : 'repuesto', 'data': { 'idRepuesto' : '$1', 'codigo': '$2', 'repuesto': '$3', 'categoria': '$4'} } ,"
				rsp.args = Replace(rsp.args, "$1", drResultado("idRepuesto"))
				rsp.args = Replace(rsp.args, "$2", drResultado("codigo"))
				rsp.args = Replace(rsp.args, "$3", drResultado("repuesto"))
				rsp.args = Replace(rsp.args, "$4", drResultado("categoria"))
			End If
		Next
		rsp.args = Replace(rsp.args, "'", """")
		rsp.args = rsp.args & "]"
		rsp.args = Replace(rsp.args, ",]", "]")
	End Sub

	Sub listaFinalizacion()
		Dim vFiltro As String = ""
		If prForm("idActividad") <> "" Then
			vFiltro = " and al1.idActividad = " & prForm("idActividad")
		End If
		listaSql("vWfEstadoFinalizacion", vFiltro)
	End Sub
#End Region

#Region "Operaciones de Flujo"
	Sub iniciarFlujo()
		Dim strCx As New StringConex
		Dim idSubFlujo As Integer
		Dim drFlujo As DataRow
		Dim itx As DateInterval
		Dim strSql As String
		Dim idRequerimiento As Integer
		idSubFlujo = buscaSubFlujo()
		strCx.iniciaTransaccion()
		drFlujo = strCx.retornaDataRow("select duracion, medida from elx_wf_subFlujo where idSubFlujo = " & idSubFlujo)
		itx = retornaIntervalo(drFlujo("medida"))
		strSql = "insert into elx_wf_requerimiento (idRol, idTienda, idSubFlujo , fechaInicio, fechaCompromiso, fechaFin, estado, cantidad, malla)VALUES ( $1, $2, $3, '$4','$5','$6',$7, $8, $9) "
		strSql = Replace(strSql, "$1", Rol.idUsuario)
		strSql = Replace(strSql, "$2", prForm("idTienda"))
		strSql = Replace(strSql, "$3", idSubFlujo)	' 
		strSql = Replace(strSql, "$4", Format(Now(), "yyyy-MM-dd HH:mm:ss"))
		strSql = Replace(strSql, "$5", Format(DateAdd(itx, drFlujo("duracion"), Now()), "yyyy-MM-dd HH:mm:ss"))	'compromiso
		strSql = Replace(strSql, "$6", Format(Now(), "yyyy-MM-dd HH:mm:ss")) 'fin
		strSql = Replace(strSql, "$7", "1")	' estado
		strSql = Replace(strSql, "$8", prForm("Cantidad"))	' cantidad
		strSql = Replace(strSql, "$9", prForm("malla"))	' malla
		strCx.ejecutaSql(strSql)
		idRequerimiento = strCx.retornaDato("select LAST_INSERT_ID()")

		' ###################################
		' ## Claves
		' ###################################

		If prForm("idProducto") <> "" Then
			strSql = "INSERT INTO elx_wf_flujoClave ( idRequerimiento, variable, idClave)VALUES ( $1, '$2', $3)"
			strSql = Replace(strSql, "$1", idRequerimiento)
			strSql = Replace(strSql, "$2", "producto")
			strSql = Replace(strSql, "$3", prForm("idProducto"))
			strCx.ejecutaSql(strSql)
		End If
		If prForm("idRepuesto") <> "" Then
			strSql = "INSERT INTO elx_wf_flujoClave ( idRequerimiento, variable, idClave)VALUES ( $1, '$2', $3)"
			strSql = Replace(strSql, "$1", idRequerimiento)
			strSql = Replace(strSql, "$2", "repuesto")
			strSql = Replace(strSql, "$3", prForm("idRepuesto"))
			strCx.ejecutaSql(strSql)
		End If

		' ###################################
		' ## Comentario
		' ###################################

		If prForm("comentario") <> "" Then
			strSql = "INSERT INTO ELX_wf_mensaje (idRequerimiento, idUsuario, mensaje , fechaIngreso) VALUES ( $1, $2, '$3', '$4') "
			strSql = Replace(strSql, "$1", idRequerimiento)
			strSql = Replace(strSql, "$2", Me.Rol.idUsuario)
			strSql = Replace(strSql, "$3", prForm("comentario"))
			strSql = Replace(strSql, "$4", Format(Now(), "yyyy-MM-dd HH:mm:ss"))
			strCx.ejecutaSql(strSql)
		End If
		Dim drActividadInicial As Integer
		drActividadInicial = strCx.retornaDato("select idActividad from elx_wf_actividad where idSubFlujo = " & idSubFlujo)

		strSql = "insert into elx_wf_estados values (null, '$0', '$1', '$2', '$3','$4','$5', '$6', '$7','$8', $9, 1) "
		strSql = Replace(strSql, "$0", idRequerimiento)
		strSql = Replace(strSql, "$1", drActividadInicial)	' idActividad
		strSql = Replace(strSql, "$2", "1")	' idFinalizacion
		strSql = Replace(strSql, "$3", "1")	' idDocumento
		strSql = Replace(strSql, "$4", Format(Now(), "yyyy-MM-dd HH:mm:ss"))
		strSql = Replace(strSql, "$5", Format(Now(), "yyyy-MM-dd HH:mm:ss"))
		strSql = Replace(strSql, "$6", Format(Now(), "yyyy-MM-dd HH:mm:ss"))
		strSql = Replace(strSql, "$7", "1")	' estado
		strSql = Replace(strSql, "$8", "") 'comentario
		strSql = Replace(strSql, "$9", "1")	'activo
		strCx.ejecutaSql(strSql)
		avanzarActividad(strCx, idRequerimiento, 1)
		If strCx.flagError Then
			rsp.estadoError(100, "Insertar: No se pudo acceder a la base", strCx.msgError)
		Else
			strCx.finTransaccion()
			rsp.args = "{ ""OK"": ""OK""}"
		End If

	End Sub

	Sub avanzarActividad(Optional ByVal strCx As StringConex = Nothing, Optional ByVal idRequerimiento As Integer = 0, Optional ByVal idFinalizacion As Integer = 0)
		Dim strSql As String
		Dim flagCx As Boolean = False
		Dim idTipoDocumento As Integer
		Dim idDocumento As Integer
		Dim estado As Integer = 0

		If IsNothing(strCx) Then
			flagCx = True
			strCx = New StringConex
			strCx.iniciaTransaccion()
		End If

		If idRequerimiento = 0 Then idRequerimiento = prForm("idRequerimiento")
		If idFinalizacion = 0 Then idFinalizacion = prForm("idFinalizacion")

		strSql = "select idActividad from elx_wf_estados where idRequerimiento = $1 and activo = 1"
		strSql = Replace(strSql, "$1", idRequerimiento)

		Dim idActividad As Integer = strCx.retornaDato(strSql)

		strSql = "select idActividadSiguiente from elx_wf_actividadFinalizacion where idActividad = $1 and idFinalizacion = $2"
		strSql = Replace(strSql, "$1", idActividad)
		strSql = Replace(strSql, "$2", idFinalizacion)

		Dim idActividadSiguiente As Integer = strCx.retornaDato(strSql)

		' #####################
		' ### Crea Documento
		' #####################

		If Not IsNothing(prForm("id")) Then
			If prForm("id") <> "1" Then
				If prForm("idTipoDocumento") = prForm("TipoDocumento") Then
					strSql = "insert into elx_wf_tipodocumento  values (null, '$1') "
					strSql = Replace(strSql, "$1", prForm("TipoDocumento"))
					strCx.ejecutaSql(strSql)
					idTipoDocumento = strCx.retornaDato("select LAST_INSERT_ID()")
				Else
					idTipoDocumento = prForm("idTipoDocumento")
				End If
				strSql = "insert into elx_wf_documento  values (null, '$1','$2', '$3', '$4', '$5') "
				strSql = Replace(strSql, "$1", idTipoDocumento)	' idTipoDocumento
				strSql = Replace(strSql, "$2", prForm("idDocumento"))	' nroDocumento
				strSql = Replace(strSql, "$3", prForm("valor"))	   ' valorUnitario
				strSql = Replace(strSql, "$4", prForm("valor"))	' valorTotal
				strSql = Replace(strSql, "$5", "")	' comentario
				strCx.ejecutaSql(strSql)
				idDocumento = strCx.retornaDato("select LAST_INSERT_ID()")
			Else
				idDocumento = prForm("id")
			End If
		Else
			idDocumento = 1
		End If

		If idActividadSiguiente > 0 Then

			Dim dr As DataRow
			Dim itx As DateInterval
			Dim idEstado As Integer
			dr = strCx.retornaDataRow("select duracion, medida from elx_wf_actividad where idActividad = " & idActividadSiguiente)

			itx = retornaIntervalo(dr("medida"))

			strSql = "insert into elx_wf_estados values (null, '$0', '$1', '$2', '$3','$4','$5', '$6', '$7','$8', $9, $A) "
			strSql = Replace(strSql, "$0", idRequerimiento)
			strSql = Replace(strSql, "$1", idActividadSiguiente)
			strSql = Replace(strSql, "$2", idFinalizacion)
			strSql = Replace(strSql, "$3", idDocumento)	' idDocumento
			strSql = Replace(strSql, "$4", Format(Now(), "yyyy-MM-dd HH:mm:ss"))
			strSql = Replace(strSql, "$5", Format(DateAdd(itx, dr("duracion"), Now()), "yyyy-MM-dd HH:mm:ss"))
			strSql = Replace(strSql, "$6", Format(Now(), "yyyy-MM-dd HH:mm:ss"))
			strSql = Replace(strSql, "$7", "1")	'estado
			strSql = Replace(strSql, "$8", "") 'comentario
			strSql = Replace(strSql, "$9", "1")	'activo
			strSql = Replace(strSql, "$A", Me.Rol.idUsuario)	'activo
			strCx.ejecutaSql(strSql)
			idEstado = strCx.retornaDato("select LAST_INSERT_ID()")

			' ########################
			' ### Define Responsables
			' ########################
			Dim drResponsable As DataRow
			strSql = "select idRol, idPerfil from elx_wf_responsable where idActividad = $1 "
			strSql = Replace(strSql, "$1", idActividadSiguiente)
			drResponsable = strCx.retornaDataRow(strSql)
			If drResponsable("idRol") <> 0 Then
				strSql = "insert into elx_wf_estadoRol  (idEstados,idRol,estado, fechaModificacion )values ( $1, $2, 0, now()) "
				strSql = Replace(strSql, "$1", idEstado)
				strSql = Replace(strSql, "$2", drResponsable("idRol"))
				strCx.ejecutaSql(strSql)
			Else
				Dim drRoles As New List(Of DataRow)
				drRoles = buscaRoles(idRequerimiento, drResponsable("idPerfil"))
				For Each r As DataRow In drRoles
					strSql = "insert into elx_wf_estadoRol  (idEstados,idRol,estado, fechaModificacion )values ( $1, $2, 0, now()) "
					strSql = Replace(strSql, "$1", idEstado)
					strSql = Replace(strSql, "$2", r("idRol"))
					strCx.ejecutaSql(strSql)
				Next
			End If
		Else
			estado = 1
			strSql = "update elx_wf_requerimiento set  fechaFin = now(), estado = 2 where idRequerimiento = $1 "
			strSql = Replace(strSql, "$1", idRequerimiento)
			strCx.ejecutaSql(strSql)
		End If

		strSql = "update elx_wf_estados set idFinalizacion = $1, fechaFin = now(), estado = $4, activo = $5, idDocumento = $2 where idActividad = $3"
		strSql = Replace(strSql, "$1", idFinalizacion)
		strSql = Replace(strSql, "$2", idDocumento)
		strSql = Replace(strSql, "$3", idActividad)
		strSql = Replace(strSql, "$4", "2")
		strSql = Replace(strSql, "$5", estado)
		strCx.ejecutaSql(strSql)

		If strCx.flagError Then
			rsp.estadoError(100, "Insertar: No se pudo acceder a la base", strCx.msgError)
		Else
			If flagCx Then strCx.finTransaccion()
			rsp.args = "{ ""OK"": ""OK""}"
		End If
	End Sub

	Function buscaSubFlujo() As Integer
		Dim strCx As New StringConex
		Dim dtFiltro As DataTable
		Dim drTienda As DataRow = Nothing
		Dim drProducto As DataRow = Nothing
		Dim drRepuesto As DataRow = Nothing
		Dim drFiltrada As DataRow = Nothing
		Dim idSubFlujo As Integer = 0
		Dim strSql As String
		Dim criterio As Boolean = False
		dtFiltro = strCx.retornaDataTable("select campo, variable, operador, idFlujoSi, idFlujoNo, idTipoSi, idTipoNo, flagInicio, valor, idFlujoFiltro from elx_wf_flujoFiltro where idFlujo = " & prForm("idFlujo"))
		If Not IsNothing(dtFiltro) Then
			drFiltrada = dtFiltro.Select("flagInicio = 1")(0)
			If Not IsNothing(drFiltrada) Then
				Do
					' Genera filtros
					If drFiltrada("campo") = "tienda" Then
						If IsNothing(drTienda) Then
							strSql = sqlText("vWfTiendas")
							strSql = strSql & " and al1.idTienda = " & prForm("idTienda")
							drTienda = strCx.retornaDataRow(strSql)
							If IsNothing(drTienda) Then Exit Do
						End If
						criterio = evaluaCriterio(drFiltrada, drTienda)
					End If
					If drFiltrada("campo") = "repuesto" Then
						If IsNothing(drRepuesto) Then
							strSql = sqlText("vWfRepuesto")
							strSql = strSql & " and al1.idRepuesto = " & prForm("idRepuesto")
							drRepuesto = strCx.retornaDataRow(strSql)
							If IsNothing(drRepuesto) Then Exit Do
						End If
						criterio = evaluaCriterio(drFiltrada, drRepuesto)
					End If
					If drFiltrada("campo") = "producto" Then
						If IsNothing(drProducto) Then
							strSql = sqlText("vWfProductos")
							strSql = strSql & " and al1.idProducto= " & prForm("idProducto")
							drProducto = strCx.retornaDataRow(strSql)
							If IsNothing(drProducto) Then Exit Do
						End If
						criterio = evaluaCriterio(drFiltrada, drProducto)
					End If
					' Evaluacion del criterio
					If criterio Then
						If drFiltrada("idTipoSi") = 1 Then
							idSubFlujo = drFiltrada("idFlujoSi")
						Else
							drFiltrada = dtFiltro.Select("idFlujoFiltro = " & drFiltrada("idFlujoSi"))(0)
						End If
					Else
						If drFiltrada("idTipoNo") = 1 Then
							idSubFlujo = drFiltrada("idFlujoNo")
						Else
							drFiltrada = dtFiltro.Select("idFlujoFiltro = " & drFiltrada("idFlujoNo"))(0)
						End If
					End If
				Loop While idSubFlujo = 0 Or IsNothing(drFiltrada)
			End If
		End If
		buscaSubFlujo = idSubFlujo
	End Function

#End Region

#Region "Operacion generales"
	Function evaluaCriterio(ByVal vFiltro As DataRow, ByVal vRegistro As DataRow) As Boolean
		evaluaCriterio = False
		If vFiltro("operador") = 1 Then
			If vRegistro(vFiltro("variable")) = vFiltro("valor") Then
				evaluaCriterio = True
			End If
		End If
		If vFiltro("operador") = 2 Then
			If vRegistro(vFiltro("variable")) <> vFiltro("valor") Then
				evaluaCriterio = True
			End If
		End If
		If vFiltro("operador") = 3 Then
			Dim vValores() As String
			vValores = Split(vFiltro("variable"), ",")
			For Each v As String In vValores
				If vRegistro(vFiltro("campo")) = v Then
					evaluaCriterio = True
					Exit For
				End If
			Next
		End If

	End Function

	Sub enviarMail(ByVal aRequerimiento As ArrayList)
		Dim s As New Mail
		Dim vBody As String
		Dim cidOK As String

		Dim dt As DataTable

		s.Subject = "Ingreso de Requerimiento"
		cidOK = "okImg" & Format(Now(), "yyyyMMddHHmmssff")
		s.AgregarImagen(AppDomain.CurrentDomain.BaseDirectory & "bin\Mail\Images\ok.png", cidOK)

		vBody = "<tr><td colspan='2'><br><img src='cid:" & cidOK & "' /></td></tr>"
		vBody = vBody & "<tr><td colspan='2'>Se ha ingresado un requerimiento exitosamente</td></tr>"


		For Each idReq As Integer In aRequerimiento

			dt = DataTableSql("vRequerimiento", " and al1.idRequerimiento = " & idReq)
			vBody = vBody & "<tr style='width:100%'><td colspan='2' style='border-top-style: dashed ; border-top-color: #CCCCCC; border-top-width: 1px; padding-top: 10px'></td></tr>"
			vBody = vBody & "<tr><td colspan='2'>"
			vBody = vBody & "Asignado a : <strong>" & Rol.Nombre & "</strong><br>"
			vBody = vBody & "Tienda : <strong>" & dt.Rows(0)("tienda") & "</strong><br>"
			vBody = vBody & "Producto : <strong>" & dt.Rows(0)("nombre") & "</strong><br>"
			vBody = vBody & "Repuesto : <strong>" & dt.Rows(0)("Repuesto") & "</strong><br>"
			vBody = vBody & "Cantidad : <strong>" & dt.Rows(0)("Cantidad") & "</strong><br>"
			vBody = vBody & "</td></tr>"
			vBody = vBody & "<tr><td colspan='2' style='font-size:14px;color:#333;font-weight:bold; padding: 8px'>Fecha de Compromiso:</td></tr>"
			vBody = vBody & "<tr><td colspan='2'>"
			vBody = vBody & "<div style='width:37px;min-height:43px;border:1px #eee solid;margin-right:5px;margin-left:290px'>"
			vBody = vBody & "<div style='padding:1px 5px;background-color:#d60000;color:#fff;font-size:8px'>" & UCase(Format(CDate(dt.Rows(0)("fechaCompromiso")), "MMM")) & "</div>"
			vBody = vBody & "<div style='padding:5px;font-weight:bold;padding:5px'>" & Format(CDate(dt.Rows(0)("fechaCompromiso")), "dd") & "</div>"
			vBody = vBody & "</div></td></tr>"
			vBody = vBody & "<tr><td colspan='2'>"
			vBody = vBody & "<div style='font-size:13px;padding-left:5px;padding-right:10px'>"
			vBody = vBody & "<a href=" & s.HttpServer & "'Electrolux/modulos/repuestos/seguimiento.aspx?idRequerimiento=" & idReq & "' style='text-decoration:none;font-weight:bold;color:#003366' target='_blank'>Flujo de Respuestos</a></div>"
			vBody = vBody & "<div style='padding-left:5px;font-size:11px;color:#666;padding-right:10px'> Su ID de Requerimiento es el siguiente: " & idReq & "<br><span style='text-align:center;color:#0F0;font-size:10px'> " & DateDiff(DateInterval.Day, DateAdd(DateInterval.Day, -1, Now), CDate(dt.Rows(0)("fechaCompromiso"))) & " días&nbsp;más</span></div>"
			vBody = vBody & "</td></tr>"

		Next

		s.Template("mailPrincipal", "Ingreso de Requerimiento", Me.Rol.Name & " - " & Format(Now, "D"), vBody)
		s.To = Rol.Email
		If s.Send() Then
			respuesta.args = "'msg': 'ok'"
		Else
			respuesta.args = "'msg': 'ERROR'"
		End If
	End Sub

	Function retornaIntervalo(ByVal drMedida As String) As DateInterval
		If drMedida = "dd" Then
			retornaIntervalo = DateInterval.Day
		ElseIf drMedida = "hh" Then
			retornaIntervalo = DateInterval.Hour
		Else
			retornaIntervalo = DateInterval.Day
		End If
	End Function

	Function buscaRoles(ByVal idRequerimiento As Integer, ByVal idPerfil As Integer) As List(Of DataRow)
		buscaRoles = Nothing
		Dim strSql As String
		Dim strCx As New StringConex
		Dim drRequerimiento As DataRow
		Dim dr As DataRow
		strSql = sqlText("vWfRequerimiento")
		strSql = strSql & " and al1.idRequerimiento = " & idRequerimiento
		drRequerimiento = strCx.retornaDataRow(strSql)

		strSql = "select idRol from elx_cdt_matrizResponsabilidad where idVariable in (select idVariable from elx_cdt_variable where variable = 'tienda')"
		strSql = strSql & " and idRol in (select idRol from elx_hr_rol where idPerfil = " & idPerfil & ")"
		strSql = strSql & " and valorInt = " & drRequerimiento("idTienda")
		dr = strCx.retornaDataRow(strSql)
		If Not IsNothing(dr) Then buscaRoles.Add(dr)
		strSql = "select idRol from elx_cdt_matrizResponsabilidad where idVariable in (select idVariable from elx_cdt_variable where variable = 'Cadena')"
		strSql = strSql & " and idRol in (select idRol from elx_hr_rol where idPerfil = " & idPerfil & ")"
		strSql = strSql & " and valorInt = " & drRequerimiento("idCadena")
		dr = strCx.retornaDataRow(strSql)
		If Not IsNothing(dr) Then buscaRoles.Add(dr)

		If Not IsDBNull(drRequerimiento("idClave")) Then
			strSql = "select idRol from elx_cdt_matrizResponsabilidad where idVariable in (select idVariable from elx_cdt_variable where variable = 'Marca')"
			strSql = strSql & " and idRol in (select idRol from elx_hr_rol where idPerfil = " & idPerfil & ")"
			strSql = strSql & " and valorInt = " & drRequerimiento("idMarca")
			dr = strCx.retornaDataRow(strSql)
			If Not IsNothing(dr) Then buscaRoles.Add(dr)
			strSql = "select idRol from elx_cdt_matrizResponsabilidad where idVariable in (select idVariable from elx_cdt_variable where variable = 'Categoria')"
			strSql = strSql & " and idRol in (select idRol from elx_hr_rol where idPerfil = " & idPerfil & ")"
			strSql = strSql & " and valorInt = " & drRequerimiento("idCategoria")
			dr = strCx.retornaDataRow(strSql)
			If Not IsNothing(dr) Then buscaRoles.Add(dr)
		End If

	End Function

#End Region

#Region "Operaciones CRUD"
	Sub anular()
		Dim strCx As New StringConex
		Dim strSql As String
		strCx.iniciaTransaccion()
		strSql = "update elx_wf_requerimiento set estado = 4 WHERE idRequerimiento =  $1"
		strSql = Replace(strSql, "$1", Me.prForm("idRequerimiento"))
		strCx.ejecutaSql(strSql)
		strSql = "update elx_wf_estados set estado = 4 WHERE idRequerimiento =  $1 and activo = 1"
		strSql = Replace(strSql, "$1", Me.prForm("idRequerimiento"))
		strCx.ejecutaSql(strSql)

		If strCx.flagError Then
			rsp.estadoError(100, "Anular: No se pudo acceder a la base", strCx.msgError)
		Else
			rsp.args = " {""result"": ""OK""}"
			strCx.finTransaccion()
		End If
	End Sub
#End Region



End Class
