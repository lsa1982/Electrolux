Imports Elx.CommonClass
Imports Elx.Workflow
Imports System.Net.Mail
Imports System.Collections.Specialized

Public Class Requerimiento
	Inherits clsEntidad


	' detalle
	' ->repuesto
	' ->producto
	' ->cantidad
	' tienda
	' comentario

	Sub insertar()

		Dim strCx As New StringConex
		Dim detalle() As String
		Dim idMail As New ArrayList
		Dim idFlujo As Integer
		idFlujo = strCx.retornaDato("select idFlujo from elx_wf_flujo where malla = 1")

		detalle = Me.prForm("detalle").Split(";")
		For Each d As String In detalle
			Dim idRequerimiento As Integer = 0
			If d <> "" Then
				Dim registro() As String = d.Split("|")
				Dim idProducto As Integer = registro(1)
				Dim idRepuesto As Integer = registro(0)
				Dim cantidadSolicitada As Integer = registro(2)
				Dim idTienda As Integer = prForm("idTienda")
				Dim wf As New Workflow.Requerimiento
				Dim paramWf As New NameValueCollection
				paramWf("idTienda") = prForm("idTienda")
				paramWf("idRepuesto") = registro(0)
				paramWf("idProducto") = registro(1)
				paramWf("cantidad") = registro(2)
				paramWf("comentario") = prForm("comentario")
				paramWf("idFlujo") = idFlujo
				paramWf("malla") = 1
				wf.Rol = Me.Rol
				wf.prForm = paramWf
				wf.iniciarFlujo()
				rsp = wf.rsp
			End If
		Next
	End Sub
	Sub lista()
		Dim vFiltro As String = ""
		If prForm("idRequerimiento") <> "" Then
			vFiltro = " and al1.idRequerimiento = " & prForm("idRequerimiento")
		End If
		vFiltro = vFiltro & " and al1.idUsuario = " & Rol.idUsuario
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
	
	Sub eliminar()
		Dim strCx As New StringConex
		Dim strSql As String
		strCx.iniciaTransaccion()
		strSql = "DELETE FROM  elx_rep_requerimiento WHERE idRequerimiento =  $1"
		strSql = Replace(strSql, "$1", Me.prForm("idRequerimiento"))
		strCx.ejecutaSql(strSql)
		strSql = "DELETE FROM  elx_rep_estados WHERE idRequerimiento =  $1"
		strSql = Replace(strSql, "$1", Me.prForm("idRequerimiento"))
		strCx.ejecutaSql(strSql)

		If strCx.flagError Then
			rsp.estadoError(100, "Eliminar: No se pudo acceder a la base", strCx.msgError)
		Else
			rsp.args = " {""result"": ""OK""}"
			strCx.finTransaccion()
		End If
	End Sub

End Class
