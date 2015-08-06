<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="ProfitCenterReport.Report" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Financial Report</title>

    <link href="Style/style.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            AIRPORTS AUTHORITY OF INDIA, 
            <asp:Label ID="lblCntName" runat="server"></asp:Label>
            AIRPORT
        </div>
        <br />
        <asp:Label ID="lblHeaderName" runat="server"></asp:Label>
        <br />
        <div>
            Form 
        <asp:Label Text="text" runat="server" ID="lblFormName" />
        </div>
        <asp:ScriptManager runat="server"></asp:ScriptManager>
        <div class="header">
            <div id="cssmenu" runat="server">
            </div>
            <!--main-->
        </div>

        <div>
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <asp:GridView ID="GridView1" runat="server" Width="100%" DataKeyNames="Id"
                        AutoGenerateColumns="false" Font-Names="Arial"
                        Font-Size="11pt" AlternatingRowStyle-BackColor="#C2D69B"
                        HeaderStyle-BackColor="green"
                        OnRowEditing="GridView1_RowEditing"
                        OnRowUpdating="GridView1_RowUpdating" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowDataBound="GridView1_RowDataBound">
                        <Columns>
                            <asp:TemplateField ItemStyle-Width="400px" HeaderText="PARTICULAR" ItemStyle-Height="40px">
                                <ItemTemplate>
                                    <asp:Label ID="lblPARTICULAR" runat="server"
                                        Text='<%# Eval("PARTICULAR")%>'></asp:Label>
                                </ItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="100px" HeaderText="ACTUAL">
                                <ItemTemplate>
                                    <asp:Label ID="lblACTUAL" runat="server"
                                        Text='<%# Eval("ACTUAL")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtACTUAL" runat="server"
                                        Text='<%# Eval("ACTUAL")%>' Height="30px"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="rf1" runat="server" ValidationExpression="^\d*\.?\d+$" ControlToValidate="txtACTUAL" Text="*" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>
                                </EditItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="150px" HeaderText="TARRIF YEAR 1">
                                <ItemTemplate>
                                    <asp:Label ID="lblyear1" runat="server"
                                        Text='<%# Eval("TARRIF YEAR 1")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtyear1" runat="server"
                                        Text='<%# Eval("TARRIF YEAR 1")%>' Height="30px"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="rf2" runat="server" ValidationExpression="^\d*\.?\d+$" ControlToValidate="txtyear1" Text="*" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>

                                </EditItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="150px" HeaderText="TARRIF YEAR 2">
                                <ItemTemplate>
                                    <asp:Label ID="lblyear2" runat="server"
                                        Text='<%# Eval("TARRIF YEAR 2")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtyear2" runat="server"
                                        Text='<%# Eval("TARRIF YEAR 2")%>' Height="30px"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="rf3" runat="server" ValidationExpression="^\d*\.?\d+$" ControlToValidate="txtyear2" Text="*" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>

                                </EditItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="150px" HeaderText="TARRIF YEAR 3">
                                <ItemTemplate>
                                    <asp:Label ID="lblyear3" runat="server"
                                        Text='<%# Eval("TARRIF YEAR 3")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtyear3" runat="server"
                                        Text='<%# Eval("TARRIF YEAR 3")%>' Height="30px"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="rf4" runat="server" ValidationExpression="^\d*\.?\d+$" ControlToValidate="txtyear3" Text="*" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>

                                </EditItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="150px" HeaderText="TARRIF YEAR 4">
                                <ItemTemplate>
                                    <asp:Label ID="lblyear4" runat="server"
                                        Text='<%# Eval("TARRIF YEAR 4")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtyear4" runat="server"
                                        Text='<%# Eval("TARRIF YEAR 4")%>' Height="30px"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="rf5" runat="server" ValidationExpression="^\d*\.?\d+$" ControlToValidate="txtyear4" Text="*" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>

                                </EditItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="150px" HeaderText="TARRIF YEAR 4">
                                <ItemTemplate>
                                    <asp:Label ID="lblyear5" runat="server"
                                        Text='<%# Eval("TARRIF YEAR 5")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtyear5" runat="server"
                                        Text='<%# Eval("TARRIF YEAR 5")%>' Height="30px"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="rf6" runat="server" ValidationExpression="^\d*\.?\d+$" ControlToValidate="txtyear5" Text="*" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>

                                </EditItemTemplate>

                            </asp:TemplateField>

                            <asp:CommandField ShowEditButton="True" ButtonType="Image" CancelImageUrl="~/image/Close.png" EditImageUrl="~/image/edit.png" UpdateImageUrl="~/image/download.jpg" />
                        </Columns>
                        <AlternatingRowStyle BackColor="#C2D69B" />
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="GridView1" />
                </Triggers>
            </asp:UpdatePanel>

            <br />
            <asp:Button ID="btnReport" runat="server" Text="Export" OnClick="btnReport_Click" />

        </div>
    </form>
</body>
</html>
