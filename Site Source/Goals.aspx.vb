
Partial Class Goals
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load


        If Not Page.IsPostBack Then
            LoadGoals()

            ' load DDLs for time entry
            LoadDDL(ddlAddMinutes, 59)
            LoadDDL(ddlAddSeconds, 59)
            LoadDDL(ddlAddMS, 99)
        End If

    End Sub

    Protected Sub LoadGoals()
        sdsGoals.SelectParameters("userName").DefaultValue = User.Identity.Name
        rptGoals.DataBind()
    End Sub

    Protected Sub LoadDDL(ByRef ddl As DropDownList, upperLimit As Int16)
        ' clear anything that may already be there
        ddl.Items.Clear()
        ' loop through upper limit
        For x As Int16 = 0 To upperLimit
            ' add number to items for DDL
            ddl.Items.Add(x.ToString.PadLeft(2, "0"))
        Next
    End Sub

    Protected Sub btnAddTime_Click(sender As Object, e As System.EventArgs) Handles btnAddTime.Click
        ' create time string
        Dim sTime As String
        sTime = String.Format("00:{0}:{1}.{2}", ddlAddMinutes.SelectedValue, ddlAddSeconds.SelectedValue, ddlAddMS.SelectedValue)

        If ddlAddType.SelectedValue = "result" Then
            AddResult(sTime)
        Else
            AddGoal(sTime)
        End If

        LoadGoals()


    End Sub

    Protected Sub AddGoal(sTime As String)
        sdsGoals.UpdateParameters("userName").DefaultValue = User.Identity.Name
        sdsGoals.UpdateParameters("strokeCode").DefaultValue = ddlAddStroke.SelectedValue
        sdsGoals.UpdateParameters("distance").DefaultValue = ddlAddDistance.SelectedValue
        sdsGoals.UpdateParameters("time").DefaultValue = sTime

        sdsGoals.Update()
    End Sub

    Protected Sub AddResult(sTime As String)
        sdsGoals.InsertParameters("userName").DefaultValue = User.Identity.Name
        sdsGoals.InsertParameters("strokeCode").DefaultValue = ddlAddStroke.SelectedValue
        sdsGoals.InsertParameters("distance").DefaultValue = ddlAddDistance.SelectedValue
        sdsGoals.InsertParameters("ResultTime").DefaultValue = sTime
        sdsGoals.InsertParameters("resultDate").DefaultValue = txtAddDate.Text

        sdsGoals.Insert()
    End Sub

    Protected Sub rptGoals_ItemCommand(source As Object, e As System.Web.UI.WebControls.RepeaterCommandEventArgs) Handles rptGoals.ItemCommand
        Response.Redirect(String.Format("~/Results.aspx?e={0}", e.CommandArgument))
    End Sub
End Class
