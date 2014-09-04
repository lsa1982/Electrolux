Public Class Rol
	Dim modulo As Hashtable
	Dim _name As String
	Public ActiveMenu As Menu
	Public ActiveModulo As Modulo
	Public idUsuario As Integer
	Sub New()
		modulo = New Hashtable
	End Sub

	Public Sub SetRol(ByVal vRol As String, ByVal vUser As Integer)
		Dim mRepuesto As Modulo
		Dim mCore As Modulo
		Dim mDashBoard As Modulo
		Dim mCoordinador As Modulo

		Dim mnuSeguimiento As Menu
		Dim mnuRequerimiento As Menu

		modulo.Clear()
		idUsuario = vUser

		mRepuesto = New Modulo("Repuestos", "../Repuestos/default.aspx")
		mCore = New Modulo("Administración", "../Core/frmGridCadena.aspx")
		mDashBoard = New Modulo("DashBoard", "")
		mCoordinador = New Modulo("Coordinador", "")

		mnuSeguimiento = New Menu("Seguimiento", "Seguimiento.aspx", "")
		mnuSeguimiento.AddSeccion(New Seccion("AvanzaActividad"))
		mnuRequerimiento = New Menu("Mis Requerimientos", "default.aspx", "")

		If vRol = "1" Then
			_name = "Administrador"
			mRepuesto.AddMenu(mnuRequerimiento)
			mRepuesto.AddMenu(New Menu("Ingreso", "Ingreso.aspx", ""))
			mRepuesto.AddMenu(mnuSeguimiento)
			mRepuesto.AddMenu(New Menu("Repuestos", "frmGridRepuestos.aspx", ""))
			modulo.Add(mRepuesto.Name, mRepuesto)

			modulo.Add(mCore.Name, mCore)
			modulo.Add(mDashBoard.Name, mDashBoard)
			modulo.Add(mCoordinador.Name, mCoordinador)
		End If
		If vRol = "2" Then
			_name = "Shop Display"
			mRepuesto.AddMenu(New Menu("Mis Requerimientos", "default.aspx", ""))
			mRepuesto.AddMenu(New Menu("Ingreso", "Ingreso.aspx", ""))
			mRepuesto.AddMenu(mnuSeguimiento)
			modulo.Add(mRepuesto.Name, mRepuesto)
			modulo.Add(mDashBoard.Name, mDashBoard)
			modulo.Add(mCoordinador.Name, mCoordinador)
		End If
		If vRol = "3" Then
			_name = "Supervisor"
			mRepuesto.AddMenu(New Menu("Mis Requerimientos", "default.aspx", ""))
			mRepuesto.AddMenu(New Menu("Ingreso", "Ingreso.aspx", ""))
			mRepuesto.AddMenu(mnuSeguimiento)
			modulo.Add(mRepuesto.Name, mRepuesto)
			modulo.Add(mDashBoard.Name, mDashBoard)
			modulo.Add(mCoordinador.Name, mCoordinador)
		End If
		
	End Sub
	Public ReadOnly Property Modulos() As Hashtable
		Get
			Return modulo
		End Get
	End Property
	Public ReadOnly Property Name() As String
		Get
			Return _name
		End Get
	End Property
	Public Overrides Function ToString() As String
		Return Convert.ToString(_name)
	End Function

	Function aplicaFiltro(ByVal vModulo As String, ByVal vStrFiltro As String, ByVal vCampo As String) As String
		Select Case Name
			Case "Supervisor", "Ejecutivo"
				If vModulo = "Tienda" Then
					vStrFiltro = vStrFiltro & " and " & vCampo & " in (select idTienda from elx_hr_asignacionDetalle where idUsuario = " & idUsuario & ")"
				End If
		End Select
		aplicaFiltro = vStrFiltro
	End Function
End Class
