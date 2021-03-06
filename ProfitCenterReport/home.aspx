﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="ProfitCenterReport.home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .grid-sltrow
        {
            background: #ddd;
            font-weight: bold;
        }
        .SubTotalRowStyle
        {
            border: solid 1px Black;
            background-color: #D8D8D8;
            font-weight: bold;
        }
        .GrandTotalRowStyle
        {
            border: solid 1px Gray;
            background-color: #000000;
            color: #ffffff;
            font-weight: bold;
        }
        .GroupHeaderStyle
        {
            border: solid 1px Black;
            background-color: #4682B4;
            color: #ffffff;
            font-weight: bold;
        }
        .serh-grid
        {
            width: 85%;
            border: 1px solid #6AB5FF;
            background: #fff;
            line-height: 14px;
            font-size: 11px;
            font-family: Verdana;
        }
        .align {
        text-align:right;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table cellpadding="0" cellspacing="5" class="tableInfo">
            <tr>
                <td align="center">
                    <asp:GridView ID="grdViewOrders" CssClass="serh-grid" runat="server" AutoGenerateColumns="False"
                        TabIndex="1" Width="100%" CellPadding="4" ForeColor="Black" GridLines="Vertical"
                        OnRowDataBound="grdViewOrders_RowDataBound" OnRowCommand="grdViewOrders_RowCommand"
                        OnRowCreated="grdViewOrders_RowCreated" BackColor="White" BorderColor="#DEDFDE"
                        BorderStyle="None" BorderWidth="1px"  >
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
                            <asp:TemplateField ItemStyle-Width="150px" HeaderText="TARRIF YEAR 1"  ItemStyle-HorizontalAlign="right">
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
                            <asp:TemplateField ItemStyle-Width="150px" HeaderText="TARRIF YEAR 2" ItemStyle-HorizontalAlign="right">
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
                            <asp:TemplateField ItemStyle-Width="150px" HeaderText="TARRIF YEAR 3" ItemStyle-HorizontalAlign="right">
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
                            <asp:TemplateField ItemStyle-Width="150px" HeaderText="TARRIF YEAR 4" ItemStyle-HorizontalAlign="right">
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
                            <asp:TemplateField ItemStyle-Width="150px" HeaderText="TARRIF YEAR 5" ItemStyle-HorizontalAlign="right">
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

                            <asp:CommandField ShowEditButton="True" ButtonType="Image" CancelImageUrl="~/image/Close.png" EditImageUrl="~/image/edit.png" UpdateImageUrl="~/image/download.jpg" />
                        </Columns>
                        <FooterStyle BackColor="#CCCC99" />
                        <SelectedRowStyle CssClass="grid-sltrow" />
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" BorderStyle="Solid"
                            BorderWidth="1px" BorderColor="Black" />
                    </asp:GridView>
                </td>
            </tr>
        </table>
        
        
    </div>
    </form>
</body>
</html>
