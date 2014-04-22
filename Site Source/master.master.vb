
Partial Class master
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadHeader()

        End If
    End Sub

    Protected Sub LoadHeader()
        ' get current page's title
        Dim pageTitle As String = Page.Title

        ' set header page title
        litHeader.Text = String.Format("Welcome, {0}", Page.User.Identity.Name)

        ' set application title
        Page.Title = String.Format("HSoD - {0}", pageTitle)

    End Sub

End Class

