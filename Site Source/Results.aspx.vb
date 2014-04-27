
Partial Class Results
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            BindTable()

        End If
    End Sub

    Protected Sub BindTable()
        sdsUserResults.SelectParameters("userName").DefaultValue = User.Identity.Name
        If Request.QueryString.HasKeys Then
            Dim eventCode As String = Request.QueryString("e")
            If Not String.IsNullOrEmpty(eventCode) Then
                sdsUserResults.FilterExpression = String.Format("eventCode = '{0}'", eventCode)
                panFiltered.Visible = True
            End If

        End If
        rptResults.DataSource = sdsUserResults
        rptResults.DataBind()
    End Sub

   
    Protected Sub btnRemoveFilter_Click(sender As Object, e As System.EventArgs) Handles btnRemoveFilter.Click
        Response.Redirect("~/Results.aspx")
    End Sub
End Class
