﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="ProfitCenterReport.Report" EnableEventValidation="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Financial Report</title>
    <link href="Style/style.css" rel="stylesheet" />
    <script>

        function add(a)
        {
            var table = document.getElementById(a);
            var r = 0;
            

        }
    </script>
</head>
<body>
    <form id="form1" runat="server">

        <table>
            <tr valign="middle">
                <td colspan="2">
                    <asp:Label ID="lblCntName" runat="server" Font-Bold="true"></asp:Label>

                </td>

            </tr>
            <tr valign="middle">
                <td colspan="2">
                    <asp:Label ID="lblHeaderName" runat="server" Font-Bold="true"></asp:Label>


                </td>
            </tr>
            <tr valign="middle">
                <td colspan="2">
                    <asp:Label Text="" runat="server" ID="lblFormName" Font-Bold="true" />

                </td>
            </tr>
            <tr valign="top">
                <td>
                    <div id="cssmenu" runat="server">
                    </div>
                </td>
                <td>

                    <asp:GridView ID="GridView1" CssClass="serh-grid" runat="server" DataKeyNames="Id" AutoGenerateColumns="False"
                        TabIndex="1" Width="100%" CellPadding="4" ForeColor="Black" GridLines="Vertical"
                        OnRowDataBound="GridView1_RowDataBound"
                        OnRowCreated="GridView1_RowCreated" BackColor="White" BorderColor="#DEDFDE"
                        BorderStyle="None" BorderWidth="1px">
                        <Columns>
                            <asp:TemplateField ItemStyle-Width="400px" HeaderText="PARTICULAR" ItemStyle-Height="40px">
                                <ItemTemplate>
                                    <asp:Label ID="lblPARTICULAR" runat="server"
                                        Text='<%# Eval("Head_tariff_Name")%>'></asp:Label>
                                </ItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="100px" HeaderText="ACTUAL">
                                <ItemTemplate>
                                    <asp:Label ID="lblACTUAL" runat="server"
                                        Text='<%# Eval("Actual_Year")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtACTUAL" runat="server"
                                        Text='<%# Eval("Actual_Year")%>' Height="30px"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="rf1" runat="server" ValidationExpression="^\d*\.?\d+$" ControlToValidate="txtACTUAL" Text="*" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>
                                </EditItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="TARRIF YEAR 1" ItemStyle-HorizontalAlign="right">
                                <ItemTemplate>
                                    <asp:Label ID="lblyear1" runat="server"
                                        Text='<%# Eval("First_Year")%>' CssClass="align"></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtyear1" runat="server"
                                        Text='<%# Eval("First_Year")%>' Height="30px"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="rf2" runat="server" ValidationExpression="^\d*\.?\d+$" ControlToValidate="txtyear1" Text="*" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>

                                </EditItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="TARRIF YEAR 2" ItemStyle-HorizontalAlign="right">
                                <ItemTemplate>
                                    <asp:Label ID="lblyear2" runat="server"
                                        Text='<%# Eval("Second_Year")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtyear2" runat="server"
                                        Text='<%# Eval("Second_Year")%>' Height="30px"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="rf3" runat="server" ValidationExpression="^\d*\.?\d+$" ControlToValidate="txtyear2" Text="*" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>

                                </EditItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="TARRIF YEAR 3" ItemStyle-HorizontalAlign="right">
                                <ItemTemplate>
                                    <asp:Label ID="lblyear3" runat="server"
                                        Text='<%# Eval("Third_Year")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtyear3" runat="server"
                                        Text='<%# Eval("Third_Year")%>' Height="30px"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="rf4" runat="server" ValidationExpression="^\d*\.?\d+$" ControlToValidate="txtyear3" Text="*" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>

                                </EditItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="TARRIF YEAR 4" ItemStyle-HorizontalAlign="right">
                                <ItemTemplate>
                                    <asp:Label ID="lblyear4" runat="server"
                                        Text='<%# Eval("Fourth_Year")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtyear4" runat="server"
                                        Text='<%# Eval("Fourth_Year")%>' Height="30px"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="rf5" runat="server" ValidationExpression="^\d*\.?\d+$" ControlToValidate="txtyear4" Text="*" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>

                                </EditItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="TARRIF YEAR 5" ItemStyle-HorizontalAlign="right">
                                <ItemTemplate>
                                    <asp:Label ID="lblyear5" runat="server"
                                        Text='<%# Eval("Fifth_Year")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtyear5" runat="server"
                                        Text='<%# Eval("Fifth_Year")%>' Height="30px"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="rf6" runat="server" ValidationExpression="^\d*\.?\d+$" ControlToValidate="txtyear5" Text="*" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>

                                </EditItemTemplate>

                            </asp:TemplateField>

                        </Columns>
                        <FooterStyle BackColor="#CCCC99" />
                        <SelectedRowStyle CssClass="grid-sltrow" />
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" BorderStyle="Solid"
                            BorderWidth="1px" BorderColor="Black" />
                    </asp:GridView>



                </td>
            </tr>
        </table>
        <table cellpadding="0" cellspacing="5" class="tableInfo" border="1">
            <tr><td>
                <asp:Label ID="lblname" Text="text" runat="server" /></td></tr>
            <tr>
                <td align="center">
                    <asp:TextBox ID="txt1" runat="server"></asp:TextBox>
                </td>
                <td align="center">
                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                </td>
                <td align="center">
                    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                </td>
                <td align="center">
                    <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                </td>
                <td align="center">
                    <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
                </td>
            </tr>
           
        </table>





        <asp:Button ID="btnReport" runat="server" Text="Export" OnClick="btnReport_Click" />



    </form>
</body>
</html>
