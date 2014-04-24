
Partial Class Goals
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load


        If Not Page.IsPostBack Then
            ' call function to databind goals/performance display table
            LoadGoals()

            ' load DDLs for time entry
            LoadDDL(ddlAddMinutes, 59)
            LoadDDL(ddlAddSeconds, 59)
            LoadDDL(ddlAddMS, 99)
        End If

    End Sub

    Protected Sub LoadGoals()
        ' set userName parameter on main datasource
        sdsGoals.SelectParameters("userName").DefaultValue = User.Identity.Name
        
        ' databind goals/performance table
        rptGoals.DataBind()
    End Sub

    Protected Sub LoadDDL(ByRef ddl As DropDownList, upperLimit As Int16)
        ' helper function to automate the loading of time-related drop-down lists
        
        ' clear anything that may already be there
        ddl.Items.Clear()
        ' loop through upper limit
        For x As Int16 = 0 To upperLimit
            ' add number to items for DDL
            ddl.Items.Add(x.ToString.PadLeft(2, "0"))
        Next
    End Sub

    Protected Sub btnAddTime_Click(sender As Object, e As System.EventArgs) Handles btnAddTime.Click
        ' This function creates a string that properly formats the user-sepcified time, then calls
        ' either the AddGoal or AddResult function depending on the add type
        
        ' create and format time string
        Dim sTime As String
        sTime = String.Format("00:{0}:{1}.{2}", ddlAddMinutes.SelectedValue, ddlAddSeconds.SelectedValue, ddlAddMS.SelectedValue)

        ' call function depending on add type
        If ddlAddType.SelectedValue = "result" Then
            AddResult(sTime)
        Else
            AddGoal(sTime)
        End If

        ' call function to re-databind goals/performance display table
        LoadGoals()


    End Sub

    Protected Sub AddGoal(sTime As String)
        ' This function adds or modifies an event goal time for the current user. 
        ' The sdsGoals.update command calls a stored procedure on the DB that 
        ' determines the appropriate action (update/insert)
        
        ' set parameter values from user form
        sdsGoals.UpdateParameters("userName").DefaultValue = User.Identity.Name
        sdsGoals.UpdateParameters("strokeCode").DefaultValue = ddlAddStroke.SelectedValue
        sdsGoals.UpdateParameters("distance").DefaultValue = ddlAddDistance.SelectedValue
        sdsGoals.UpdateParameters("time").DefaultValue = sTime

        ' call update function on data source
        sdsGoals.Update()
    End Sub

    Protected Sub AddResult(sTime As String)
        ' this function inserts an event result time for the current user
        
        ' set parameter values from user form
        sdsGoals.InsertParameters("userName").DefaultValue = User.Identity.Name
        sdsGoals.InsertParameters("strokeCode").DefaultValue = ddlAddStroke.SelectedValue
        sdsGoals.InsertParameters("distance").DefaultValue = ddlAddDistance.SelectedValue
        sdsGoals.InsertParameters("ResultTime").DefaultValue = sTime
        sdsGoals.InsertParameters("resultDate").DefaultValue = txtAddDate.Text

        ' call insert function on data source
        sdsGoals.Insert()
    End Sub

    Protected Sub rptGoals_ItemCommand(source As Object, e As System.Web.UI.WebControls.RepeaterCommandEventArgs) Handles rptGoals.ItemCommand
        ' Fired when a user clicks the "view history" link for a particular event.
        '
        ' The command argument is passed from the link button control.  It is the combination of the
        ' stroke code and distance for the selected event.  This function redirects the user to the
        ' results page using the command argument in the query string to indicate which filter to apply 
        
        Response.Redirect(String.Format("~/Results.aspx?e={0}", e.CommandArgument))
    End Sub
End Class
