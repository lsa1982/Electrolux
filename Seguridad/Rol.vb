Public Class Rol
	Dim modulo As Hashtable
	Dim _name As String
	Public ActiveMenu As Menu
	Public ActiveModulo As Modulo
	Public idUsuario As Integer

	Public _email As String
	Public _nombre As String
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
		Dim mnuCategoria As Menu

		modulo.Clear()
		idUsuario = vUser

		mRepuesto = New Modulo("Repuestos", "../Repuestos/default.aspx")
		mCore = New Modulo("Core", "../Core/frmGridCategoria.aspx")
		mDashBoard = New Modulo("DashBoard", "")
		mCoordinador = New Modulo("Coordinador", "../Coordinador/frmGridActividad.aspx")

		mnuSeguimiento = New Menu("Seguimiento", "Seguimiento.aspx", "")
		mnuSeguimiento.AddSeccion(New Seccion("AvanzaActividad"))
		mnuRequerimiento = New Menu("Mis Requerimientos", "default.aspx", "")

		mnuCategoria = New Menu("Categoria", "frmGridCategoria.aspx", "")

		If vRol = "1" Then
			_name = "Administrador"
			mRepuesto.AddMenu(mnuRequerimiento)
			mRepuesto.AddMenu(New Menu("Ingreso", "Ingreso.aspx", ""))
			mRepuesto.AddMenu(mnuSeguimiento)
			mRepuesto.AddMenu(New Menu("Repuestos", "frmGridRepuestos.aspx", ""))
			mCore.AddMenu(New Menu("Marca", "frmGridMarca.aspx", ""))
			mCore.AddMenu(New Menu("Productos", "frmGridProducto.aspx", ""))
			mCore.AddMenu(New Menu("Tiendas", "frmGridTienda.aspx", ""))
			mCore.AddMenu(New Menu("Cadena", "frmGridCadena.aspx", ""))
			mCore.AddMenu(New Menu("Usuarios", "frmGridUsuario.aspx", ""))
			mCoordinador.AddMenu(New Menu("Flujos", "frmFlujo.aspx", ""))
			mCoordinador.AddMenu(New Menu("Actividad", "frmGridActividad.aspx", ""))
			mCore.AddMenu(mnuCategoria)
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

	Public Property Email() As String
		Get
			Return _email
		End Get
		Set(ByVal value As String)
			_email = value
		End Set
	End Property

	Public Property Nombre() As String
		Get
			Return _nombre
		End Get
		Set(ByVal value As String)
			_nombre = value
		End Set
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
