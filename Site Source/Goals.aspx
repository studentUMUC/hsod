<%@ Page Title="User Goals & Performance" Language="VB" MasterPageFile="~/master.master" AutoEventWireup="false" CodeFile="Goals.aspx.vb" Inherits="Goals" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="styles/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="js/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>
    <script type="text/javascript">
        function initAdd(aType, eCode) {
            // parse event code
            var strokeCode = eCode.substr(0,2);
            var distance = eCode.substr(2);

            // set variables
            $("#<%= ddlAddMinutes.ClientID %>").val("00");
            $("#<%= ddlAddSeconds.ClientID %>").val("00");
            $("#<%= ddlAddms.ClientID %>").val("00");
            $("#<%= txtAddDate.ClientID %>").val("");
            $("#<%= ddlAddStroke.ClientID %>").val(strokeCode);
            $("#<%= ddlAddDistance.ClientID %>").val(distance);

            // determine Title
            var lTitle = (aType == "result") ? "n Event Result" : " Personal Goal";

            // set title
            $("#hAddTitle").html("Add a" + lTitle);

            // set add type
            $("#<%= ddlAddType.ClientID %>").val(aType);

            // open dialog
            $("#divAdd").dialog("open");
            
        }


        $(function () {
            $(".datePicker").datepicker({
                changeMonth: true,
                changeYear: true,
                constrainInput: true,
                dateFormat: 'mm/dd/yy',
                minDate: '-20y'
            });

            $(".button").button();

            $("#btnAddResult").click(function () {
                initAdd("result", "BA25y");
                return false;
            });

            $(".aTime").click(function () {
                var tCode = $(this)[0].id;
                var eventCode = tCode.substr(1);
                var aType = (tCode.substr(0, 1) == "g") ? "goal" : "result";
                initAdd(aType, eventCode);
                return false;
            });

            $("#tblUserGoals").dataTable({
                "bPaginate": false,
                "bLengthChange": false,
                "bFilter": false,
                "bAutoWidth": false,
                "aoColumnDefs": [{ "bVisible": false, "aTargets": [0, 1] },
                { "iDataSort": 1, "aTargets": [2]}],
                "aaSortingFixed": [[0, 'asc']],
                "aaSorting": [[1, 'asc']],
                "sDom": 'lfr<"giveHeight"t>ip'
            }).rowGrouping({ bExpandableGrouping: true });

            $("#divAdd").dialog({
                autoOpen: false,
                modal: true,
                buttons: {
                    Submit: function () {
                        // validate
                        if (($("#<%= ddlAddType.ClientID %>").val() == "result") && ($("#<%= txtAddDate.ClientID %>").val().length != 10)) {
                            // a date must be entered for event results
                            alert("You must enter a date for event results");
                            return false;
                        } else {
                            $(this).dialog("close");

                            // submit the form
                            $("#<%= btnAddTime.ClientID %>").click();
                        }
                    },
                    Cancel: function () {
                        $(this).dialog("close");
                    }
                },
                open: function () {
                    if ($("#<%= ddlAddType.ClientID %>").val() == "result")
                        $("#divAddResult").show();
                    else
                        $("#divAddResult").hide();

                }
            });


            $("#divAdd").parent().appendTo($("form:first"));
        });
        
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="divInstructionBlurb" class="notice">Instruction summary goes here  <a id="aMoreInfo" href="#">click for more info</a>
    </div>
    <div id="divInstructionDetails">
    
    </div>
    <input id="btnAddResult" type="button" class="button" value="Add New Event Result" />
    <asp:Repeater ID="rptGoals" runat="server" DataSourceID="sdsGoals">
                    <HeaderTemplate>
                        <table id="tblUserGoals" class="eTable">
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
                                        Goal Time
                                    </th>
                                    <th>
                                        Best Time
                                    </th>
                                    <th>
                                        Time from goal
                                    </th>
                                    <th></th>
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
                                <a id='<%# Eval("eventCode","g{0}")%>' class="aTime" title="Click to add/update goal" href="#"><%# Eval("goalTime")%></a>
                            </td>
                            <td><a id='<%# Eval("eventCode","r{0}") %>' class="aTime" title="Click to add new event result" href="#"><%#Eval("bestResult")%></a>
                            </td>
                            <td>
                                <%#Eval("endResult")%>
                            </td>
                            <td>
                                <asp:LinkButton CommandName="history" CommandArgument='<%# Eval("eventCode") %>' ID="LinkButton1" runat="server">View History</asp:LinkButton>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody></table>
                    </FooterTemplate>
                </asp:Repeater>

    <asp:SqlDataSource ID="sdsGoals" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SwimConnectionString %>" 
        
        SelectCommand="SELECT strokeName, strokeCode, iDistance, distance, strokeCode + distance as eventCode, ISNULL(RIGHT (CONVERT (varchar, goalTime, 121), 8), 'add') AS goalTime, ISNULL(RIGHT(bestResult, 8), 'add') AS bestResult, CASE WHEN goalTime IS NOT NULL AND bestResult IS NOT NULL THEN case when goaltime > bestResult then 'Congrats!' else  left(RIGHT (CONVERT (varchar , DATEADD(ms , DATEDIFF(ms , goalTime , bestResult) , '00:00:00') , 121) , 9),8) end ELSE '-' END AS endResult FROM (SELECT Stroke.strokeName, EventV.strokeCode, EventV.distance,EventV.idistance, dtGoals.goalTime, dtResults.bestResult FROM Stroke INNER JOIN EventV ON Stroke.strokeCode = EventV.strokeCode LEFT OUTER JOIN (SELECT strokeCode, distance, MIN(resultTime) AS bestResult FROM UserResult WHERE (userName = @userName) GROUP BY strokeCode, distance) AS dtResults ON EventV.strokeCode = dtResults.strokeCode AND EventV.distance = dtResults.distance LEFT OUTER JOIN (SELECT userName, strokeCode, distance, goalTime FROM UserGoal WHERE (userName = @userName)) AS dtGoals ON EventV.strokeCode = dtGoals.strokeCode AND EventV.distance = dtGoals.distance) AS dtAll" 
        InsertCommand="INSERT INTO UserResult(userName, strokeCode, distance, resultTime, resultDate) VALUES (@userName, @strokeCode, @distance, @resultTime, @resultDate)" 
        UpdateCommand="usp_UpdateGoal" UpdateCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter Name="userName" />
            <asp:Parameter Name="strokeCode" />
            <asp:Parameter Name="distance" />
            <asp:Parameter Name="resultTime" />
            <asp:Parameter Name="resultDate" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter Name="userName" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="userName" Type="String" />
            <asp:Parameter Name="strokeCode" Type="String" />
            <asp:Parameter Name="distance" Type="String" />
            <asp:Parameter Name="time" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:Button ID="btnAddTime" CssClass="hidden" runat="server" Text="Button" />
    <div id="divAdd">
        <h2 id="hAddTitle"></h2>
        <div id="divAddInstructions" class="notice">Instructionz</div>
        Stroke: 
        <asp:DropDownList ID="ddlAddStroke" runat="server" DataSourceID="sdsStroke" 
            DataTextField="strokeName" DataValueField="strokeCode">
        </asp:DropDownList>
        <asp:SqlDataSource ID="sdsStroke" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SwimConnectionString %>" 
            SelectCommand="SELECT strokeName, strokeCode FROM Stroke ORDER BY strokeCode">
        </asp:SqlDataSource>
        <br />
        Distance: 
        <asp:DropDownList ID="ddlAddDistance" runat="server" DataSourceID="sdsDistance" 
            DataTextField="distance" DataValueField="distance">
        </asp:DropDownList>
        <asp:SqlDataSource ID="sdsDistance" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SwimConnectionString %>" 
            SelectCommand="SELECT distance, iDistance FROM Distance ORDER BY iDistance">
        </asp:SqlDataSource>
        <br />
        Time: 
        <asp:DropDownList ID="ddlAddMinutes" runat="server">
        </asp:DropDownList> <span class="timeAdd">:</span> <asp:DropDownList ID="ddlAddSeconds" runat="server">
        </asp:DropDownList> <span class="timeAdd">.</span> <asp:DropDownList ID="ddlAddMS" runat="server">
        </asp:DropDownList>
        <br />
        <div id="divAddResult">
            Date:
            <asp:TextBox CssClass="datePicker" ID="txtAddDate" runat="server"></asp:TextBox>
        </div>
        <asp:DropDownList ID="ddlAddType" CssClass="hidden" runat="server">
            <asp:ListItem>result</asp:ListItem>
            <asp:ListItem>goal</asp:ListItem>
        </asp:DropDownList>
    </div>
</asp:Content>

