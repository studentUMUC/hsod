<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>High School Swimmers On Deck</title>
    <meta http-equiv="x-ua-compatible" content="IE=9" >
<link rel="stylesheet" href="styles/blueprint/screen.css" type="text/css" />
<!--[if lt IE 8]>
<link rel="stylesheet" href="styles/blueprint/ie.css" type="text/css" />
<![endif]-->
<link rel="stylesheet" href="styles/start/jquery-ui-1.8.9.custom.css" type="text/css" />
<link href="styles/main.css" rel="stylesheet" type="text/css" />
<script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="js/jquery-ui-1.8.22.custom.min.js" type="text/javascript"></script>

</head>
<body>
    <form id="form1" runat="server">
    <div id="divMaster" class="container">
        <div id="divHeader">
            <h1>High School Swimmers On Deck</h1>
        </div>
        <div id="divContent" class="span-18 prepend-3 last">
        <div class="ui-widget ui-widget-content ui-corner-all aCenter" style="width:600px;">
        <asp:LoginView ID="LoginView1" runat="server">
        <AnonymousTemplate><h2>Welcome!</h2>
            <asp:Login ID="Login1" CssClass="centered" MembershipProvider="SwimMembershipProvider" runat="server" CreateUserText="New User" CreateUserUrl="~/Default.aspx?t=c" 
                DisplayRememberMe="False" PasswordRecoveryText="Forgot Password" 
                PasswordRecoveryUrl="~/Default.aspx?t=f" >
                <LayoutTemplate>
                                <table class="centered" cellpadding="0">
                                    <tr>
                                        <td style="text-align:center;" colspan="2">
                                            Log In</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:right;">
                                            <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:</asp:Label>
                                        </td>
                                        <td style="text-align:left;">
                                            <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" 
                                                ControlToValidate="UserName" ErrorMessage="User Name is required." 
                                                ToolTip="User Name is required." ValidationGroup="ctl00$Login1">*</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:right;">
                                            <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                                        </td>
                                        <td style="text-align:left;">
                                            <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" 
                                                ControlToValidate="Password" ErrorMessage="Password is required." 
                                                ToolTip="Password is required." ValidationGroup="ctl00$Login1">*</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center; color:Red;" colspan="2">
                                            <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align:center;" colspan="2">
                                            <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Log In" 
                                                ValidationGroup="ctl00$Login1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:HyperLink ID="CreateUserLink" runat="server" 
                                                NavigateUrl="~/Default.aspx?t=c">Create a new user account</asp:HyperLink>
                                            <br />
                                            <asp:HyperLink ID="PasswordRecoveryLink" runat="server" 
                                                NavigateUrl="~/Default.aspx?t=f">Forgot your password?</asp:HyperLink>
                                        </td>
                                    </tr>
                                </table>
                </LayoutTemplate>
            </asp:Login>

            
        </AnonymousTemplate>
        <LoggedInTemplate>
            <h2>You are currently logged into the system.  Please use the link below to go to the main page.</h2>
            <a href="~/Profile.aspx">Go to profile page</a>
        
        </LoggedInTemplate>
        </asp:LoginView>
        <asp:CreateUserWizard ID="CreateUserWizard1" CssClass="centered"  Visible="false" runat="server" MembershipProvider="SwimMembershipProvider">
                <WizardSteps>
                    <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server">
                    </asp:CreateUserWizardStep>
                    <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server"><ContentTemplate>
                    Congratulations!  Your account was successfully created!<br />
                        <asp:Button ID="Button1" runat="server" Text="Continue" PostBackUrl="~/Profile.aspx" />
                    </ContentTemplate>
                    </asp:CompleteWizardStep>
                </WizardSteps>
            </asp:CreateUserWizard>
        <asp:PasswordRecovery ID="PasswordRecovery1"  Visible="false" runat="server">
            <UserNameTemplate>
                            <table class="aCenter centered" cellpadding="0">
                                <tr>
                                    <td colspan="2">
                                        Forgot Your Password?</td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        Enter your User Name to receive your password.</td>
                                </tr>
                                <tr>
                                    <td style="text-align:right;">
                                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:</asp:Label>
                                    </td>
                                    <td style="text-align:left;">
                                        <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" 
                                            ControlToValidate="UserName" ErrorMessage="User Name is required." 
                                            ToolTip="User Name is required." ValidationGroup="PasswordRecovery1">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="color:Red;">
                                        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Button ID="SubmitButton" runat="server" CommandName="Submit" Text="Submit" 
                                            ValidationGroup="PasswordRecovery1" />
                                    </td>
                                </tr>
                            </table>
            </UserNameTemplate>
        </asp:PasswordRecovery>
        <asp:SqlDataSource ID="sdsProfile" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SwimConnectionString %>" 
            SelectCommand="SELECT UserName, UserId FROM aspnet_Users" 
            InsertCommand="INSERT INTO UserProfile(userName) VALUES (@userName)">
            <InsertParameters>
                <asp:Parameter Name="userName" />
            </InsertParameters>
        </asp:SqlDataSource>
        </div>
    </div>
    <div class="clear">&nbsp;</div>
    </div>
    </form>
</body>
</html>
