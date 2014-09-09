Public Class Seccion

	Private _name As String
	Private _visible As Boolean = False
	Sub New(ByVal vName As String)
		_name = vName

	End Sub


	Public Property Name() As String
		Get
			Return _name
		End Get
		Set(ByVal value As String)
			_name = value
		End Set
	End Property

	Public Property Visible() As Boolean
		Get
			Return _visible
		End Get
		Set(ByVal value As Boolean)
			_visible = value
		End Set
	End Property

	Public Overrides Function ToString() As String
		Return _name
	End Function
	Public Sub copyto()

	End Sub

End Class
