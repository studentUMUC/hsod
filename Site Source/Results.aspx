<%@ Page Title="All Results" Language="VB" MasterPageFile="~/master.master" AutoEventWireup="false" CodeFile="Results.aspx.vb" Inherits="Results" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="styles/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="js/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $(".datePicker").datepicker({
                changeMonth: true,
                changeYear: true,
                constrainInput: true,
                dateFormat: 'mm/dd/yy',
                minDate: '-20y'
            });

            $(".button").button();

            $("#tblUserResults").dataTable({
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
    <div class="notice">Instructions go here
    </div>
    <asp:Panel ID="panFiltered" CssClass="error aCenter" Visible="false" runat="server">
    <h4>THESE RESULTS ARE FILTERED FOR A SPECIFIC STROKE AND DISTANCE!!!</h4>To remove this filter and view your full history of results:
    <asp:Button ID="btnRemoveFilter" CssClass="button" runat="server" Text="Remove Filter" />
    </asp:Panel>
<asp:Repeater ID="rptResults" runat="server">
                    <HeaderTemplate>
                        <table id="tblUserResults" class="eTable">
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
                                    <th>
                                        Event Result Time
                                    </th>
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
                                <%#Eval("resultTime")%>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody></table>
                    </FooterTemplate>
                </asp:Repeater>
    <asp:SqlDataSource ID="sdsResults" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SwimConnectionString %>" 
        
        SelectCommand="SELECT UserResult.userName, UserResult.strokeCode + UserResult.distance AS eventCode, UserResult.strokeCode, UserResult.distance, Distance.iDistance, Stroke.strokeName, RIGHT (CONVERT (varchar, UserResult.resultTime, 121), 8) AS resultTime, CONVERT (varchar, UserResult.resultDate, 101) AS resultDate, LEFT (CONVERT (varchar, DATEDIFF(d, UserProfile.DOB, UserResult.resultDate) / 365.25), 2) AS age FROM UserResult INNER JOIN Stroke ON UserResult.strokeCode = Stroke.strokeCode INNER JOIN Distance ON UserResult.distance = Distance.distance INNER JOIN UserProfile ON UserResult.userName = UserProfile.userName WHERE (UserResult.userName = @userName) ORDER BY resultDate DESC, Stroke.strokeName, Distance.iDistance">
        <SelectParameters>
            <asp:Parameter Name="userName" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

