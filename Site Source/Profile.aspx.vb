
Partial Class Profile
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            sdsProfile.SelectParameters("userName").DefaultValue = User.Identity.Name
            fvProfile.DataBind()

        End If

    End Sub
End Class
