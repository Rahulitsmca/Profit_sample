<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="ProfitCenterReport.Report" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Financial Report</title>
    <style>
        .grid-sltrow {
            background: #ddd;
            font-weight: bold;
        }

        .SubTotalRowStyle {
            border: solid 1px Black;
            background-color: #D8D8D8;
            font-weight: bold;
        }

        .GrandTotalRowStyle {
            border: solid 1px Gray;
            background-color: #000000;
            color: #ffffff;
            font-weight: bold;
        }

        .GroupHeaderStyle {
            border: solid 1px Black;
            background-color: #4682B4;
            color: #ffffff;
            font-weight: bold;
        }

        .serh-grid {
            width: 85%;
            border: 1px solid #6AB5FF;
            background: #fff;
            line-height: 14px;
            font-size: 11px;
            font-family: Verdana;
        }
    </style>
    <script>

        function add(a) {
            var tblUpdate = document.getElementById("tblUpdate");
            tblUpdate.style.display = "table";
            
            var classRemove = document.getElementsByClassName("grid-sltrow");
            for (var i = 0; i < classRemove.length; i++) {
                classRemove[i].className = '';
            }
            console.log();
            a.className += "grid-sltrow";
            var arrId = a.getElementsByTagName("td");
            document.getElementById('<%=txtParticilar.ClientID%>').value = a.getElementsByTagName("td")[0].innerText;
            document.getElementById('<%=hidden.ClientID%>').value = a.getElementsByTagName("input")[0].value;
            document.getElementById('<%=txt1.ClientID%>').value = a.getElementsByTagName("td")[1].innerText;
            document.getElementById('<%=TextBox1.ClientID%>').value = a.getElementsByTagName("td")[2].innerText;
            document.getElementById('<%=TextBox2.ClientID%>').value = a.getElementsByTagName("td")[3].innerText;
            document.getElementById('<%=TextBox3.ClientID%>').value = a.getElementsByTagName("td")[4].innerText;
            document.getElementById('<%=TextBox4.ClientID%>').value = a.getElementsByTagName("td")[5].innerText;
            document.getElementById('<%=TextBox5.ClientID%>').value = a.getElementsByTagName("td")[6].innerText;

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
                                    <asp:HiddenField ID="id" runat="server" Value='<%# Eval("Id")%>' />
                                </ItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="100px" HeaderText="ACTUAL">
                                <ItemTemplate>
                                    <asp:Label ID="lblACTUAL" runat="server"
                                        Text='<%# Eval("Actual_Year")%>'></asp:Label>
                                </ItemTemplate>


                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="TARRIF YEAR 1" ItemStyle-HorizontalAlign="right">
                                <ItemTemplate>
                                    <asp:Label ID="lblyear1" runat="server"
                                        Text='<%# Eval("First_Year")%>' CssClass="align"></asp:Label>
                                </ItemTemplate>


                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="TARRIF YEAR 2" ItemStyle-HorizontalAlign="right">
                                <ItemTemplate>
                                    <asp:Label ID="lblyear2" runat="server"
                                        Text='<%# Eval("Second_Year")%>'></asp:Label>
                                </ItemTemplate>


                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="TARRIF YEAR 3" ItemStyle-HorizontalAlign="right">
                                <ItemTemplate>
                                    <asp:Label ID="lblyear3" runat="server"
                                        Text='<%# Eval("Third_Year")%>'></asp:Label>
                                </ItemTemplate>


                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="TARRIF YEAR 4" ItemStyle-HorizontalAlign="right">
                                <ItemTemplate>
                                    <asp:Label ID="lblyear4" runat="server"
                                        Text='<%# Eval("Fourth_Year")%>'></asp:Label>
                                </ItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="TARRIF YEAR 5" ItemStyle-HorizontalAlign="right">
                                <ItemTemplate>
                                    <asp:Label ID="lblyear5" runat="server"
                                        Text='<%# Eval("Fifth_Year")%>'></asp:Label>
                                </ItemTemplate>


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
        <table cellpadding="0" cellspacing="5" class="tableInfo" border="0" id="tblUpdate" style="display:none;">
            <tr>
                <td>
                    <asp:HiddenField ID="hidden" runat="server" Value="0" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:TextBox ID="txtParticilar" runat="server" ReadOnly="true" Width="200px"></asp:TextBox>
                </td>

                <td align="center">
                    <asp:TextBox ID="txt1" runat="server"></asp:TextBox>
                    <%--<asp:RequiredFieldValidator ErrorMessage="Enter Values" ControlToValidate="txt1" runat="server" Display="Dynamic" ForeColor="Red" />--%>

                </td>
                <td align="center">
                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationExpression="^\d*\.?\d+$" ControlToValidate="TextBox1" Text="*" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ErrorMessage="Enter Values" ControlToValidate="TextBox1" runat="server" Display="Dynamic" ForeColor="Red" />

                </td>
                <td align="center">
                    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ValidationExpression="^\d*\.?\d+$" ControlToValidate="TextBox2" Text="*" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ErrorMessage="Enter Values" ControlToValidate="TextBox2" runat="server" Display="Dynamic" ForeColor="Red" />

                </td>
                <td align="center">
                    <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ValidationExpression="^\d*\.?\d+$" ControlToValidate="TextBox3" Text="*" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ErrorMessage="Enter Values" ControlToValidate="TextBox3" runat="server" Display="Dynamic" ForeColor="Red" />

                </td>
                <td align="center">
                    <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ValidationExpression="^\d*\.?\d+$" ControlToValidate="TextBox4" Text="*" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ErrorMessage="Enter Values" ControlToValidate="TextBox4" runat="server" Display="Dynamic" ForeColor="Red" />

                </td>
                <td align="center">
                    <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ValidationExpression="^\d*\.?\d+$" ControlToValidate="TextBox5" Text="*" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ErrorMessage="Enter Values" ControlToValidate="TextBox5" runat="server" Display="Dynamic" ForeColor="Red" />

                </td>
                <td>
                    <asp:Button Text="Update" runat="server" ID="btnUpdate" OnClick="btnUpdate_Click" CausesValidation="true" /></td>
            </tr>

        </table>





        <asp:Button ID="btnReport" runat="server" Text="Export" OnClick="btnReport_Click" />



    </form>
</body>
</html>
