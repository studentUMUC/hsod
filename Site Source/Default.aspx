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
            <h1>High School Swimmer On Deck</h1>
        </div> 
        <div id="divContent" class="span-18 prepend-3 last">
        <div class="ui-widget ui-widget-content ui-corner-all aCenter" style="width:600px;">
        <asp:LoginView ID="LoginView1" runat="server">
        <AnonymousTemplate><h1>Anonymous</h1>
            <asp:Login ID="Login1" MembershipProvider="SwimMembershipProvider" runat="server" CreateUserText="New User" CreateUserUrl="~/Default.aspx?t=c" 
                DisplayRememberMe="False" PasswordRecoveryText="Forgot Password" 
                PasswordRecoveryUrl="~/Default.aspx?t=f" >
            </asp:Login>

            
        </AnonymousTemplate>
        <LoggedInTemplate>
            <h2>You are currently logged into the system.  Please use the link below to go to the main page.</h2>
            <a href="~/Profile.aspx">Go to profile page</a>
        
        </LoggedInTemplate>
        </asp:LoginView>
        <asp:CreateUserWizard ID="CreateUserWizard1"  Visible="false" runat="server" MembershipProvider="SwimMembershipProvider">
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
        <asp:Panel ID="panMailError" Visible="false" runat="server"><h2>No mail server defined</h2>
        </asp:Panel>
        <asp:PasswordRecovery ID="PasswordRecovery1" Visible="false" runat="server">
        </asp:PasswordRecovery>
        <asp:SqlDataSource ID="sdsProfile" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SwimConnectionString %>" 
            SelectCommand="SELECT UserName, UserId FROM aspnet_Users" 
            InsertCommand="INSERT INTO UserProfile(userName) VALUES (@userName)">
            <InsertParameters>
                <asp:Parameter Name="userName" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:Label ID="lblNewUserName" runat="server" Text=""></asp:Label>
        </div>
    </div>
    </div>
    </form>
</body>
</html>
