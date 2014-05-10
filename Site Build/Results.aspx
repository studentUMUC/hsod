<%@ page title="All Results" language="VB" masterpagefile="~/master.master" autoeventwireup="false" inherits="Results, App_Web_esdf5vyz" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="styles/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="js/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            // initialize date picker
            $(".datePicker").datepicker({
                changeMonth: true,
                changeYear: true,
                constrainInput: true,
                dateFormat: 'mm/dd/yy',
                minDate: '-20y'
            });

            // initialize datatable
            $("#tblResults").dataTable({
                "bPaginate": false,
                "bLengthChange": false,
                "bFilter": false,
                "bAutoWidth": false,
                "aoColumnDefs": [{ "bVisible": false, "aTargets": [1] },
                 { "iDataSort": 1, "aTargets": [2]}],
                "sDom": 'lfr<"giveHeight"t>ip'
            });
        });
        
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="divInstructionBlurb" class="notice">
        For More Information:  <a id="aMoreInfo" href="#">click here</a>
    </div>
    <div id="divInstructionDetails">
        <h2>To Display Specific Results:</h2> </p>
        Select each criteria to be displayed.</p>
        Use drop down menus for specific result views.
        Click <b>APPLY FILTER</b> to show requested results.</p>
        Example:  In order to show all 18 year old swimmers from Wisconsin that competed on May 10, 2013, in the 25 yard backstroke:</p>
        Event:  BACKSTROKE 25Y</p>  Gender:  Both</p> Age Range:  18   18</p>   State:  Wisconsin</p> Date Range: May 10, 2013  May 10, 2013 
    </div>
    <asp:Panel ID="panCriteria" CssClass="dCriteria aCenter" runat="server">
    <h3>Selection Criteria</h3>
    <table>
        <tr>
            <td>Event</td>
            <td>Gender</td>
            <td colspan="2">Age Range</td>
        </tr>
        <tr>
            <td>
                <asp:DropDownList ID="ddlEvent" runat="server" DataSourceID="sdsEvents" 
                    DataTextField="eDisplay" DataValueField="eValue">
                </asp:DropDownList>
            </td>
            <td>
                <asp:DropDownList ID="ddlGender" runat="server">
                    <asp:ListItem Value="b" Text="both"></asp:ListItem>
                    <asp:ListItem Value="f" Text="female"></asp:ListItem>
                    <asp:ListItem Value="m" Text="male"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
               Min: <asp:DropDownList ID="ddlAgeMin" runat="server">
                    <asp:ListItem>12</asp:ListItem>
                    <asp:ListItem>13</asp:ListItem>
                    <asp:ListItem>14</asp:ListItem>
                    <asp:ListItem>15</asp:ListItem>
                    <asp:ListItem>16</asp:ListItem>
                    <asp:ListItem>17</asp:ListItem>
                    <asp:ListItem>18</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                Max: <asp:DropDownList ID="ddlAgeMax" runat="server">
                 <asp:ListItem>12</asp:ListItem>
                    <asp:ListItem>13</asp:ListItem>
                    <asp:ListItem>14</asp:ListItem>
                    <asp:ListItem>15</asp:ListItem>
                    <asp:ListItem>16</asp:ListItem>
                    <asp:ListItem>17</asp:ListItem>
                    <asp:ListItem>18</asp:ListItem>
                </asp:DropDownList>
            </td>
                
        </tr>
        <tr>
        <td colspan="2">State</td>
            <td colspan="2">Date Range</td>
        </tr>
        <tr>
        <td colspan="2">
                <asp:DropDownList Width="150" ID="ddlState" runat="server" DataSourceID="sdsStates" 
                    DataTextField="stateName" DataValueField="stateCode">
                </asp:DropDownList>
            </td>
            <td>
               Min: <asp:TextBox ID="txtDateMin" CssClass="datePicker" runat="server"></asp:TextBox></td>
            <td>
                Max: <asp:TextBox ID="txtDateMax" CssClass="datePicker" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td colspan="4">
                <asp:Button ID="btnApplyFilter" CssClass="button" runat="server" Text="Apply Filter" />
            </td>
        </tr>
    </table>
    </asp:Panel>
    <asp:Panel ID="panFiltered" CssClass="error aCenter" Visible="false" runat="server">
    <h4>THESE RESULTS ARE FILTERED FOR A SPECIFIC STROKE AND DISTANCE!!!</h4>To remove this filter and view your full history of results:
    <asp:Button ID="btnRemoveFilter" CssClass="button" runat="server" Text="Remove Filter" />
    </asp:Panel>
<asp:Repeater ID="rptResults" runat="server">
                    <HeaderTemplate>
                        <table id="tblResults" class="eTable">
                            <thead>
                                <tr>
                                    <th>
                                        Stroke
                                    </th>
                                    <th>iDistance</th>
                                    <th>
                                        Distance
                                    </th>
                                    <th>
                                        Event Date
                                    </th>
                                    <th>Age</th>
                                    <th>Gender</th>
                                    <th>
                                       Result Time
                                    </th>
                                    <th>Swimmer</th>
                                    <th>State</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <%# Eval("strokeName")%>
                            </td>
                            <td>
                                <%# Eval("iDistance")%>
                            </td>
                            <td>
                                <%# Eval("distance")%>
                            </td>
                            <td>
                                <%#Eval("resultDate")%>
                            </td>
                            <td>
                                <%#Eval("Age")%>
                            </td>
                            <td>
                                <%#Eval("Gender")%>
                            </td>
                            <td>
                                <%#Eval("resultTime")%>
                            </td>
                            <td>
                                <%#Eval("swimmer")%>
                            </td>
                            <td>
                                <%#Eval("stateName")%>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody></table>
                    </FooterTemplate>
                </asp:Repeater>
    <asp:SqlDataSource ID="sdsUserResults" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SwimConnectionString %>" 
        
        
        
        SelectCommand="SELECT dbo.UserResult.userName, dbo.UserResult.strokeCode + dbo.UserResult.distance AS eventCode, dbo.UserResult.strokeCode, dbo.UserResult.distance, dbo.Distance.iDistance, dbo.Stroke.strokeName, RIGHT (CONVERT (varchar, dbo.UserResult.resultTime, 121), 8) AS resultTime, CONVERT (varchar, dbo.UserResult.resultDate, 101) AS resultDate, LEFT (CONVERT (varchar, DATEDIFF(d, dbo.UserProfile.DOB, dbo.UserResult.resultDate) / 365.25), 2) AS age, States.stateCode, States.stateName, dbo.UserProfile.firstName + ' ' + dbo.UserProfile.lastName AS swimmer, dbo.UserProfile.gender FROM dbo.UserResult INNER JOIN dbo.Stroke ON dbo.UserResult.strokeCode = dbo.Stroke.strokeCode INNER JOIN dbo.Distance ON dbo.UserResult.distance = dbo.Distance.distance INNER JOIN dbo.UserProfile ON dbo.UserResult.userName = dbo.UserProfile.userName INNER JOIN States ON dbo.UserProfile.stateCode = States.stateCode WHERE (dbo.UserResult.userName = @userName) ORDER BY resultDate DESC, dbo.Stroke.strokeName, dbo.Distance.iDistance">
        <SelectParameters>
            <asp:Parameter Name="userName" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsEvents" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SwimConnectionString %>" 
        SelectCommand="SELECT dbo.Stroke.strokeName, dbo.Stroke.strokeCode, dbo.Distance.distance, dbo.Distance.iDistance, dbo.Stroke.strokeName + ' - ' + dbo.Distance.distance AS eDisplay, dbo.Stroke.strokeCode + dbo.Distance.distance AS eValue FROM dbo.Distance CROSS JOIN dbo.Stroke ORDER BY dbo.Stroke.strokeName, dbo.Distance.iDistance">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsAllResults" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SwimConnectionString %>" 
        SelectCommand="SELECT dbo.UserResult.userName, dbo.UserResult.strokeCode + dbo.UserResult.distance AS eventCode, dbo.UserResult.strokeCode, dbo.UserResult.distance, dbo.Distance.iDistance, dbo.Stroke.strokeName, RIGHT (CONVERT (varchar, dbo.UserResult.resultTime, 121), 8) AS resultTime, CONVERT (varchar, dbo.UserResult.resultDate, 101) AS resultDate, LEFT (CONVERT (varchar, DATEDIFF(d, dbo.UserProfile.DOB, dbo.UserResult.resultDate) / 365.25), 2) AS age, States.stateCode, States.stateName, dbo.UserProfile.firstName + ' ' + dbo.UserProfile.lastName AS swimmer, dbo.UserProfile.gender, CONVERT (varchar, dbo.UserResult.resultDate, 112) AS Expr3, CONVERT (varchar, dbo.UserResult.resultDate, 112) AS Expr2 FROM dbo.UserResult INNER JOIN dbo.Stroke ON dbo.UserResult.strokeCode = dbo.Stroke.strokeCode INNER JOIN dbo.Distance ON dbo.UserResult.distance = dbo.Distance.distance INNER JOIN dbo.UserProfile ON dbo.UserResult.userName = dbo.UserProfile.userName INNER JOIN States ON dbo.UserProfile.stateCode = States.stateCode WHERE ('b' + dbo.UserProfile.gender LIKE '%' + @genderCode + '%') AND (States.stateCode = @stateCode) AND (LEFT (CONVERT (varchar, DATEDIFF(d, dbo.UserProfile.DOB, dbo.UserResult.resultDate) / 365.25), 2) BETWEEN @ageMin AND @ageMax) AND (dbo.UserResult.strokeCode + dbo.UserResult.distance = @eventCode) AND (CONVERT (varchar, dbo.UserResult.resultDate, 112) &gt;= CONVERT (varchar, CONVERT (date, @dateMin), 112)) AND (CONVERT (varchar, dbo.UserResult.resultDate, 112) &lt;= CONVERT (varchar, CONVERT (date, @dateMax), 112)) ORDER BY resultDate DESC, dbo.Stroke.strokeName, dbo.Distance.iDistance">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlGender" Name="genderCode" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ddlState" Name="stateCode" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ddlAgeMin" Name="ageMin" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ddlAgeMax" Name="ageMax" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ddlEvent" Name="eventCode" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txtDateMin" Name="dateMin" 
                PropertyName="Text" />
            <asp:ControlParameter ControlID="txtDateMax" Name="dateMax" 
                PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsStates" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SwimConnectionString %>" 
        SelectCommand="SELECT States.stateName, States.stateCode FROM States INNER JOIN dbo.UserProfile ON States.stateCode = dbo.UserProfile.stateCode INNER JOIN dbo.UserResult ON dbo.UserProfile.userName = dbo.UserResult.userName GROUP BY States.stateName, States.stateCode HAVING (States.stateCode &lt;&gt; 'ss') ORDER BY States.stateName">
    </asp:SqlDataSource>
</asp:Content>

