<%@ Page Title="User Profile" Language="VB" MasterPageFile="~/master.master" AutoEventWireup="false" CodeFile="Profile.aspx.vb" Inherits="Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(function () {
            $(".datePicker").datepicker({
                changeMonth: true,
                changeYear: true,
                constrainInput: true,
                dateFormat: 'mm/dd/yy',
                minDate: '-20y'  
            });
            
            
        });
        
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="divInstructionBlurb" class="notice">
        For More Information:  <a id="aMoreInfo" href="#">click here</a>
    </div>
    <div id="divInstructionDetails">
       <h2>Enter Specific Profile Information.</h2> </p>
        <h3>Date of birth format is:</p>
        Month: 05 / Day: 12 / Year: 2010 Example: 05/12/2010 </p>
        The State refers to where profile user resides/competes.</p>
        Other sections are self explanatory.</p>
        To Update, simply fill in new information and click the <b>UPDATE</b> Link.</h3>
    </div>
    <asp:FormView ID="fvProfile" CssClass="profileEdit" runat="server" CellPadding="4" 
        DataKeyNames="userName" DataSourceID="sdsProfile" DefaultMode="Edit" 
        EnableModelValidation="True" ForeColor="#333333">
        <EditItemTemplate>
            User Name:
            <asp:Label ID="userNameLabel1" runat="server" Text='<%# Eval("userName") %>' />
            <br />
            First Name:
            <asp:TextBox ID="firstNameTextBox" runat="server" 
                Text='<%# Bind("firstName") %>' MaxLength=50 />
            <br />
            Last Name:
            <asp:TextBox ID="lastNameTextBox" runat="server" 
                Text='<%# Bind("lastName") %>' MaxLength=50 />
            <br />
            Middle Initial:
            <asp:TextBox ID="middleInitialTextBox" runat="server" 
                Text='<%# Bind("middleInitial") %>' MaxLength=1 />
            <br />
            Gender: <asp:DropDownList ID="DropDownList1" runat="server" 
                SelectedValue='<%# Bind("gender") %>'>
                <asp:ListItem Value="s">Select</asp:ListItem>
                <asp:ListItem Value="F">female</asp:ListItem>
                <asp:ListItem Value="M">male</asp:ListItem>
            </asp:DropDownList>
            
            <br />
            DOB:
            <asp:TextBox ID="DOBTextBox" CssClass="datePicker" runat="server" Text='<%# Bind("DOB") %>' />
            <br />
            State: 
            <asp:DropDownList ID="ddlStates" runat="server" DataSourceID="sdsStates" 
                DataTextField="stateName" DataValueField="stateCode" 
                SelectedValue='<%# Bind("stateCode") %>'>
            </asp:DropDownList><br />
            <asp:SqlDataSource ID="sdsStates" runat="server" 
                ConnectionString="<%$ ConnectionStrings:SwimConnectionString %>" 
                SelectCommand="SELECT stateCode, stateName FROM States ORDER BY stateName">
            </asp:SqlDataSource>
            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                CommandName="Update" Text="Update" />
            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" 
                CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        </EditItemTemplate>
        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
    </asp:FormView>
    
    <asp:SqlDataSource ID="sdsProfile" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SwimConnectionString %>" 
        SelectCommand="SELECT dbo.UserProfile.userName, dbo.UserProfile.firstName, dbo.UserProfile.lastName, dbo.UserProfile.middleInitial, dbo.UserProfile.gender, CONVERT (varchar, dbo.UserProfile.DOB, 101) AS DOB, dbo.UserProfile.stateCode, States.stateName FROM dbo.UserProfile LEFT OUTER JOIN States ON dbo.UserProfile.stateCode = States.stateCode WHERE (dbo.UserProfile.userName = @userName)" 
        
        UpdateCommand="UPDATE dbo.UserProfile SET firstName = @firstName, lastName = @lastName, middleInitial = @middleInitial, gender = @gender, DOB = @DOB, stateCode = @stateCode WHERE (userName = @userName)">
        <SelectParameters>
            <asp:Parameter Name="userName" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="firstName" />
            <asp:Parameter Name="lastName" />
            <asp:Parameter Name="middleInitial" />
            <asp:Parameter Name="gender" />
            <asp:Parameter Name="DOB" />
            <asp:Parameter Name="stateCode" />
            <asp:Parameter Name="userName" />
        </UpdateParameters>
    </asp:SqlDataSource>
    
</asp:Content>

