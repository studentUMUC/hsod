
Partial Class _Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Request.QueryString.HasKeys AndAlso Not String.IsNullOrEmpty(Request.QueryString("t")) Then
                ' by default, hide login view
                LoginView1.Visible = False

                ' get type of querystring
                Select Case Request.QueryString("t").ToLower()
                    Case "f"    ' user forgot password
                        PasswordRecovery1.Visible = True
                    Case "c"    ' create new user
                        CreateUserWizard1.Visible = True
                End Select
            End If
        End If


    End Sub


    Protected Sub CreateProfile()
        ' creates a profile record for a new user

        ' set profile insert data source parameter to newly created user's name
        sdsProfile.InsertParameters("userName").DefaultValue = CreateUserWizard1.UserName
        ' create profile record
        sdsProfile.Insert()
    End Sub

 
  
    Protected Sub CreateUserWizard1_CreatedUser(sender As Object, e As System.EventArgs) Handles CreateUserWizard1.CreatedUser
        ' we aren't using the built-in ASP.NET profile provider, so call function to create new profile record
        CreateProfile()
    End Sub
End Class
