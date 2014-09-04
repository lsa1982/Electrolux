Public Class Menu
	Private _image As String
	Private _name As String
	Private _page As String
	Private _seccion As New Hashtable
	Sub New(ByVal vName As String, ByVal vPage As String, Optional ByVal vImage As String = "")
		_image = vImage
		_name = vName
		_page = vPage
	End Sub

	Public Sub AddSeccion(ByVal sName As Seccion)
		_seccion.Add(sName.Name, sName)
	End Sub

	Public Property Name() As String
		Get
			Return _name
		End Get
		Set(ByVal value As String)
			_name = value
		End Set
	End Property
	Public Property Page() As String
		Get
			Return _page
		End Get
		Set(ByVal value As String)
			_page = value
		End Set
	End Property
	Public Property Image() As String
		Get
			Return _image
		End Get
		Set(ByVal value As String)
			_image = value
		End Set
	End Property
	Public ReadOnly Property Seccion As Hashtable
		Get
			Return _seccion
		End Get

	End Property

End Class
