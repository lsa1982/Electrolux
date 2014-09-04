Imports Elx.CommonClass
Imports System.Net.Mail

Public Class Requerimiento
	Inherits clsEntidad
	
	Sub insertar()

		Dim strCx As New StringConex
		Dim strSql As String
		strCx.iniciaTransaccion()
		Dim detalle() As String
		Dim idMail As New ArrayList
		detalle = Me.prForm("detalle").Split(";")

		For Each d As String In detalle
			Dim idRequerimiento As Integer = 0
			If d <> "" Then
				Dim registro() As String = d.Split("|")
				Dim dr As DataRow
				Dim tipoFlujo As String
				Dim idFlujo As String

				tipoFlujo = strCx.retornaDatoStr("select tipo from elx_core_categoria where idCategoria in (select idCategoria from elx_rep_respuesto where idRepuesto = " & registro(0) & ")")

				If tipoFlujo = "Repuesto menor" Then
					idFlujo = 1
				ElseIf tipoFlujo = "Repuesto mayor" Then
					idFlujo = 2
				Else
					Exit For
				End If

				dr = strCx.retornaDataRow("select duracion, medida from elx_wf_flujo where idFlujo = " & idFlujo)
				Dim itx As DateInterval
				If dr("medida") = "dd" Then
					itx = DateInterval.Day
				ElseIf dr("medida") = "hh" Then
					itx = DateInterval.Hour
				End If
				strSql = "INSERT INTO ELX_REP_REQUERIMIENTO VALUES (null, '$1', '$2', '$3', '$4','$5','$6','$7', '$8', '$9', '$A', '$B') "
				strSql = Replace(strSql, "$1", "1")
				strSql = Replace(strSql, "$2", Me.prForm("idTienda"))
				strSql = Replace(strSql, "$3", registro(0))	' Repuesto
				strSql = Replace(strSql, "$4", registro(1))	' Producto
				strSql = Replace(strSql, "$5", Format(Now(), "yyyy-MM-dd HH:mm:ss"))
				strSql = Replace(strSql, "$6", Format(DateAdd(itx, dr("duracion"), Now()), "yyyy-MM-dd HH:mm:ss")) 'compromiso
				strSql = Replace(strSql, "$7", Format(Now(), "yyyy-MM-dd HH:mm:ss")) 'fin
				strSql = Replace(strSql, "$8", "1")	' estado
				strSql = Replace(strSql, "$9", "") ' codigo legado
				strSql = Replace(strSql, "$A", Me.prForm("comentario"))
				strSql = Replace(strSql, "$B", registro(2))	' cantidad
				strCx.ejecutaSql(strSql)


				idRequerimiento = strCx.retornaDato("select LAST_INSERT_ID()")
				If idRequerimiento < 1 Then Exit For

				iniciarFlujo(idFlujo, strCx, idRequerimiento)
				avanzarActividad(strCx, idRequerimiento, 1)
				idMail.Add(idRequerimiento)
			End If

		Next
		If strCx.flagError Then
			rsp.estadoError(100, "Insertar: No se pudo acceder a la base", strCx.msgError)
		Else
			strCx.finTransaccion()
			enviarMail(idMail)
			rsp.args = "{ ""OK"": ""OK""}"
		End If
	End Sub
	Sub lista()
		Dim vFiltro As String = ""
		If prForm("idRequerimiento") <> "" Then
			vFiltro = " and al1.idRequerimiento = " & prForm("idRequerimiento")
		End If

		vFiltro = Rol.aplicaFiltro("Tienda", vFiltro, "al1.idTienda")
		listaSql("vRequerimiento", vFiltro)
	End Sub
	Sub listaEstado()
		Dim vFiltro As String = ""
		If prForm("idRequerimiento") <> "" Then
			vFiltro = " and al1.idRequerimiento = " & prForm("idRequerimiento")
			listaSql("vRequerimientoEstado", vFiltro)
		End If
	End Sub
	Sub listaFinalizacion()
		Dim vFiltro As String = ""
		If prForm("idRequerimiento") <> "" Then
			vFiltro = " and al1.idRequerimiento = " & prForm("idRequerimiento")
			listaSql("vRequerimientoFinalizacion", vFiltro)
		End If
	End Sub
	Sub avanzarActividad(Optional ByVal strCx As StringConex = Nothing, Optional ByVal idRequerimiento As Integer = 0, Optional ByVal idFinalizacion As Integer = 0)

		Dim strSql As String

		If IsNothing(strCx) Then
			strCx = New StringConex
			strCx.iniciaTransaccion()
		End If

		If idRequerimiento = 0 Then idRequerimiento = prForm("idRequerimiento")
		If idFinalizacion = 0 Then idFinalizacion = prForm("idFinalizacion")

		strSql = "select idActividad from elx_rep_estados where  idRequerimiento = $1 and activo = 1"
		strSql = Replace(strSql, "$1", idRequerimiento)

		Dim idActividad As Integer = strCx.retornaDato(strSql)

		strSql = "select idActividadSiguiente from elx_wf_actividadFinalizacion where  idActividad = $1 and idFinalizacion = $2"
		strSql = Replace(strSql, "$1", idActividad)
		strSql = Replace(strSql, "$2", idFinalizacion)

		Dim idActividadSiguiente As Integer = strCx.retornaDato(strSql)

		If idActividadSiguiente > 0 Then
			Dim dr As DataRow

			dr = strCx.retornaDataRow("select duracion, medida from elx_wf_actividad where idActividad = " & idActividadSiguiente)
			Dim itx As DateInterval
			If dr("medida") = "dd" Then
				itx = DateInterval.Day
			ElseIf dr("medida") = "hh" Then
				itx = DateInterval.Hour
			End If


			strSql = "update elx_rep_estados set idFinalizacion = $1, fechaFin = now(), estado = 2, activo = 0 where idRequerimiento = $2 and activo = 1"
			strSql = Replace(strSql, "$1", idFinalizacion)
			strSql = Replace(strSql, "$2", idRequerimiento)
			strCx.ejecutaSql(strSql)

			strSql = "insert into elx_rep_estados values (null, '$0', '$1', '$2', '$3','$4','$5', '$6', '$7','$8', $9) "
			strSql = Replace(strSql, "$0", idRequerimiento)
			strSql = Replace(strSql, "$1", idActividadSiguiente)
			strSql = Replace(strSql, "$2", idFinalizacion)
			strSql = Replace(strSql, "$3", "0")	' idDocumento
			strSql = Replace(strSql, "$4", Format(Now(), "yyyy-MM-dd HH:mm:ss"))
			strSql = Replace(strSql, "$5", Format(DateAdd(itx, dr("duracion"), Now()), "yyyy-MM-dd HH:mm:ss"))
			strSql = Replace(strSql, "$6", Format(Now(), "yyyy-MM-dd HH:mm:ss"))
			strSql = Replace(strSql, "$7", "1")	'estado
			strSql = Replace(strSql, "$8", "") 'comentario
			strSql = Replace(strSql, "$9", "1")	'activo
			strCx.ejecutaSql(strSql)
		Else
			strSql = "update elx_rep_estados set idFinalizacion = $1, fechaFin = now(), estado = 2 where idRequerimiento = $2 and activo = 1"
			strSql = Replace(strSql, "$1", idFinalizacion)
			strSql = Replace(strSql, "$2", idRequerimiento)
			strCx.ejecutaSql(strSql)

			strSql = "update elx_rep_requerimiento set  fechaFin = now(), estado = 2 where idRequerimiento = $1 "
			strSql = Replace(strSql, "$1", idRequerimiento)
			strCx.ejecutaSql(strSql)
		End If


		If strCx.flagError Then
			rsp.estadoError(100, "Insertar: No se pudo acceder a la base", strCx.msgError)
		Else
			strCx.finTransaccion()
			rsp.args = "{ ""OK"": ""OK""}"
		End If
	End Sub
	

	Sub iniciarFlujo(ByVal idFlujo As Integer, ByVal strCx As StringConex, ByVal idRequerimiento As Integer)
		Dim strSql As String
		Dim dr As DataRow

		dr = strCx.retornaDataRow("select duracion, medida from elx_wf_actividad where orden = 1 and idFlujo = " & idFlujo)
		Dim itx As DateInterval
		If dr("medida") = "dd" Then
			itx = DateInterval.Day
		ElseIf dr("medida") = "hh" Then
			itx = DateInterval.Hour
		End If

		strSql = "insert into elx_rep_estados values (null, '$0', '$1', '$2', '$3','$4','$5', '$6', '$7','$8', $9) "
		strSql = Replace(strSql, "$0", idRequerimiento)
		strSql = Replace(strSql, "$1", dr("idActividad"))	' idActividad
		strSql = Replace(strSql, "$2", "1")	' idFinalizacion
		strSql = Replace(strSql, "$3", "0")	' idDocumento
		strSql = Replace(strSql, "$4", Format(Now(), "yyyy-MM-dd HH:mm:ss"))
		strSql = Replace(strSql, "$5", Format(DateAdd(itx, dr("duracion"), Now()), "yyyy-MM-dd HH:mm:ss"))
		strSql = Replace(strSql, "$6", Format(Now(), "yyyy-MM-dd HH:mm:ss"))
		strSql = Replace(strSql, "$7", "1")	' estado
		strSql = Replace(strSql, "$8", "") 'comentario
		strSql = Replace(strSql, "$9", "1")	'activo
		strCx.ejecutaSql(strSql)

	End Sub

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
			vBody = vBody & "Asignado a : <strong>" & dt.Rows(0)("usuario") & "</strong><br>"
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
			vBody = vBody & "<a href='http://be762102de2c4ef:81/Electrolux/modulos/repuestos/seguimiento.aspx?idRequerimiento=" & idReq & "' style='text-decoration:none;font-weight:bold;color:#003366' target='_blank'>Flujo Respuestos Pequeños</a></div>"
			vBody = vBody & "<div style='padding-left:5px;font-size:11px;color:#666;padding-right:10px'>" & dt.Rows(0)("actividad") & "<br><span style='text-align:center;color:#0F0;font-size:10px'> 7 días&nbsp;más</span></div>"
			vBody = vBody & "</td></tr>"

		Next


		s.Template("mailPrincipal", "Ingreso de Requerimiento", Me.Rol.Name & " - " & Format(Now, "D"), vBody)
		s.To = "lsa1982@gmail.com"
		If s.Send() Then
			respuesta.args = "'msg': 'ok'"
		Else
			respuesta.args = "'msg': 'ERROR'"
		End If
	End Sub

End Class
