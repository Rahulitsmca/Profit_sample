<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProfitCenter.aspx.cs" Inherits="ProfitCenterReport.ProfitCenter" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:DropDownList ID="ddlProfitCenter" runat="server" Width="220px"></asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvDDlProfitCenter" runat="server" ControlToValidate="ddlProfitCenter"
                InitialValue="-1" Text="Please Select any Profit Center" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
             <asp:DropDownList ID="DropDownRsType" runat="server" Width="220px">
                 <asp:ListItem Value="-1" Text="--Select Rupees Type--"></asp:ListItem>
                 <asp:ListItem Value="l" Text="Lacs"></asp:ListItem>
                 <asp:ListItem Value="C" Text="Crores"></asp:ListItem>
             </asp:DropDownList>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="DropDownRsType"
                InitialValue="-1" Text="Please Select Any Rupees Type" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:Button Text="Show" runat="server" OnClick="Unnamed1_Click" />
        </div>
    </form>
</body>
</html>
