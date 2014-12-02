Public Class controlSeguridad
	Inherits System.Web.UI.UserControl

	Private m_messageTemplate As ITemplate = Nothing
	Private _name As String

	<PersistenceMode(PersistenceMode.InnerProperty)> Public Property _
	  SectorSeguridad() As ITemplate
		Get
			Return m_messageTemplate
		End Get
		Set(ByVal value As ITemplate)
			m_messageTemplate = value
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

	Private Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
		Dim siteMaster As Site = Page.Master.Master
		PlaceHolder1.Visible = False
		If Not IsNothing(Name) Then
			If Not IsNothing(siteMaster.rolUsuario.ActiveMenu.Seccion(Name)) Then
				PlaceHolder1.Visible = True
				Dim container As New Control
				SectorSeguridad.InstantiateIn(container)
				PlaceHolder1.Controls.Add(container)
			End If
		End If
		
	End Sub
End Class


