<%@ Page Title="Trang Chủ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="lab_06_BanSach.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3 class="mb-4 text-primary border-bottom pb-2">
        <%= string.IsNullOrEmpty(Request.QueryString["search"]) ? "SÁCH MỚI NHẤT" : "KẾT QUẢ TÌM KIẾM: " + Request.QueryString["search"] %>
    </h3>

    <div class="row">
        <asp:Repeater ID="Repeater1" runat="server">
            <ItemTemplate>
                <div class="col-md-4 mb-4">
                    <div class="card h-100 shadow-sm border-0">
                        <img src='<%# "Bia_sach/" + Eval("AnhBia") %>' class="card-img-top" style="height: 280px; object-fit: contain; padding: 10px;">
                        <div class="card-body text-center">
                            <h6 class="card-title fw-bold text-truncate" title='<%# Eval("TenSach") %>'><%# Eval("TenSach") %></h6>
                            <p class="text-danger fw-bold"><%# Eval("Dongia", "{0:0,0}") %> đ</p>
                            <div class="d-grid gap-2">
                                <a href='ChiTietSach.aspx?MaSach=<%# Eval("MaSach") %>' class="btn btn-sm btn-outline-secondary">Chi tiết</a>
                                <asp:LinkButton ID="btnAdd" runat="server" CssClass="btn btn-sm btn-danger"
                                    CommandArgument='<%# Eval("MaSach") %>' OnClick="btnAddToCart_Click">
                                    <i class="fas fa-plus"></i> Thêm vào giỏ
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <nav aria-label="Page navigation" class="mt-4">
        <ul class="pagination justify-content-center">
            <asp:Repeater ID="rptPager" runat="server">
                <ItemTemplate>
                    <li class='page-item <%# (bool)Eval("Active") ? "active" : "" %>'>
                        <asp:LinkButton ID="lnkPage" runat="server" Text='<%# Eval("Text") %>'
                            CommandArgument='<%# Eval("Value") %>' OnClick="Page_Changed" CssClass="page-link"
                            Enabled='<%# !(bool)Eval("Active") %>'>
                        </asp:LinkButton>
                    </li>
                </ItemTemplate>
            </asp:Repeater>
        </ul>
    </nav>
</asp:Content>