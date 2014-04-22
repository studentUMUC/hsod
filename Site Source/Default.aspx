<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>High School On Deck</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:LoginView ID="LoginView1" runat="server">
        <AnonymousTemplate><h1>Anonymous</h1>
            <asp:Login ID="Login1" MembershipProvider="SwimMembershipProvider" runat="server" CreateUserText="New User" CreateUserUrl="~/Default.aspx?t=c" 
                DisplayRememberMe="False" PasswordRecoveryText="Forgot Password" 
                PasswordRecoveryUrl="~/Default.aspx?t=f" >
            </asp:Login>

            
        </AnonymousTemplate>
        <LoggedInTemplate><h1>Logged in</h1>
        
        </LoggedInTemplate>
        </asp:LoginView>
        <asp:CreateUserWizard ID="CreateUserWizard1"  Visible="false" runat="server" MembershipProvider="SwimMembershipProvider">
                <WizardSteps>
                    <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server">
                    </asp:CreateUserWizardStep>
                    <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server"><ContentTemplate>
                    Congrats !  Yo account wuz created!<br />
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
    </form>
</body>
</html>
