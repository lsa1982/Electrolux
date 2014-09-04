Imports System.Collections.Specialized
Public Class Modulo
	Dim _menu As Hashtable
	Private _name As String
	Private _pageDefault As String

	Sub New(ByVal vName As String, ByVal vPage As String)
		_name = vName
		_menu = New Hashtable
		_pageDefault = vPage
	End Sub

	Public Property PageDefault() As String
		Get
			Return _pageDefault
		End Get
		Set(ByVal value As String)
			_pageDefault = value
		End Set
	End Property
	Public Property Name() As String
		Get
			Return _name
		End Get
		Set(ByVal value As String)
			_name = value
		End Set
	End Property
	Public ReadOnly Property Menu() As Hashtable
		Get
			Return _menu
		End Get

	End Property
	Public Sub AddMenu(ByVal menu As Menu)
		_menu.Add(menu.Page, menu)
	End Sub

End Class
