
Partial Class Results
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            BindTable()

        End If
    End Sub

    Protected Sub BindTable()
        Dim sds As SqlDataSource


        If Request.QueryString.HasKeys Then
            ' page request is for filtered user results
            sds = sdsUserResults
            sds.SelectParameters("userName").DefaultValue = User.Identity.Name
            Dim eventCode As String = Request.QueryString("e")
            If Not String.IsNullOrEmpty(eventCode) Then
                sdsUserResults.FilterExpression = String.Format("eventCode = '{0}'", eventCode)
                panFiltered.Visible = True
                panCriteria.Visible = False
            End If


        Else
            ' filtered results for all users
            sds = sdsAllResults

        End If


        rptResults.DataSource = sds
        rptResults.DataBind()
    End Sub

   
    Protected Sub btnRemoveFilter_Click(sender As Object, e As System.EventArgs) Handles btnRemoveFilter.Click
        Response.Redirect("~/Results.aspx")
    End Sub

    Protected Sub btnApplyFilter_Click(sender As Object, e As System.EventArgs) Handles btnApplyFilter.Click
        BindTable()

    End Sub
End Class
