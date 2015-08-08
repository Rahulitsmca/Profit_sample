<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" EnableEventValidation="false"
    Inherits="GridviewGrouping._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Grouping in asp.net GridView</title>
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
                        BorderStyle="None" BorderWidth="1px">
                        <Columns>
                            <asp:BoundField DataField="OrderID" HeaderText="OrderID" SortExpression="OrderID">
                            </asp:BoundField>
                            <asp:BoundField DataField="ProductName" HeaderText="ProductName" SortExpression="ProductName" />
                            <asp:BoundField DataField="UnitPrice" HeaderText="UnitPrice" SortExpression="UnitPrice" />
                            <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                            <asp:BoundField DataField="Discount" HeaderText="Discount" SortExpression="Discount" />
                            <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
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
            <tr>
                <td align="center">
                    Selected Product ID
                </td>
                <td align="center">
                    <asp:Label ID="lblProductID" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="center">
                    Selected Product
                </td>
                <td align="center">
                    <asp:Label ID="lblProduct" runat="server" Text=""></asp:Label>
                </td>
            </tr>
        </table>
        <asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="~/XmlDataSource1.xml">
        </asp:XmlDataSource>
    </div>
    </form>
</body>
</html>
