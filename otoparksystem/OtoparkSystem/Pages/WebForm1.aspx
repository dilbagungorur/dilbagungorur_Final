<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="OtoparkSystem.Pages.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label runat="server" Text="Lütfen araç türünü seçiniz."></asp:Label>
        </div>

        <%--<asp:DropDownList runat="server" ID="drpAracTurleri"></asp:DropDownList>--%>

        <asp:Repeater runat="server" ID="rptAracTurleri">
            <ItemTemplate>
                <asp:HiddenField runat="server" ID="hdnNumaraId" Value='<%#Eval("NumaraId") %>' />
               <asp:LinkButton runat="server" ID="btnyönlendir" OnClick="btnyönlendir_Click"> <img width="400" height="400" align="center" style="border: solid 1px; margin-right:40px" src='<%#Eval("image") %>' /></asp:LinkButton>
            </ItemTemplate>
        </asp:Repeater>
    </form>
</body>
</html>
