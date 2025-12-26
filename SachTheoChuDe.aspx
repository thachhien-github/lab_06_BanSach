<%@ Page Title="Sách Theo Chủ Đề" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SachTheoChuDe.aspx.cs" Inherits="lab_06_BanSach.SachTheoChuDe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row mb-4">
        <div class="col-12">
            <h3 class="text-primary border-bottom pb-3 text-uppercase fw-bold">
                <i class="fas fa-bookmark me-2"></i>Chủ đề: <asp:Literal ID="ltrTenChuDe" runat="server"></asp:Literal>
            </h3>
        </div>
    </div>

    <div class="row">
        <asp:Repeater ID="rptSachTheoCD" runat="server">
            <ItemTemplate>
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card h-100 shadow-sm border-0 transition-hover">
                        <div class="text-center p-3">
                            <a href='ChiTietSach.aspx?MaSach=<%# Eval("MaSach") %>'>
                                <img src='<%# "Bia_sach/" + Eval("AnhBia") %>' class="card-img-top img-fluid" 
                                     style="height: 220px; object-fit: contain;" 
                                     alt='<%# Eval("TenSach") %>'>
                            </a>
                        </div>
                        <div class="card-body d-flex flex-column text-center">
                            <h6 class="card-title fw-bold text-dark mb-2" style="height: 40px; overflow: hidden;">
                                <%# Eval("TenSach") %>
                            </h6>
                            <p class="text-danger fs-5 fw-bold mb-3">
                                <%# Eval("Dongia", "{0:0,0}") %> <small>đ</small>
                            </p>
                            <div class="mt-auto d-grid gap-2">
                                <a href='ChiTietSach.aspx?MaSach=<%# Eval("MaSach") %>' class="btn btn-sm btn-outline-secondary rounded-pill">
                                    <i class="fas fa-info-circle me-1"></i>Chi tiết
                                </a>
                                <asp:LinkButton ID="btnAdd" runat="server" CssClass="btn btn-sm btn-danger rounded-pill"
                                    CommandArgument='<%# Eval("MaSach") %>' OnClick="btnAddToCart_Click">
                                    <i class="fas fa-cart-plus me-1"></i>Thêm vào giỏ
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <div class="row mt-4">
        <div class="col-12 d-flex justify-content-center">
            <nav aria-label="Page navigation">
                <ul class="pagination shadow-sm">
                    <asp:Repeater ID="rptPager" runat="server">
                        <ItemTemplate>
                            <li class='<%# (bool)Eval("Active") ? "page-item active" : "page-item" %>'>
                                <asp:LinkButton ID="lnkPage" runat="server" 
                                    CssClass="page-link" 
                                    Text='<%# Eval("Text") %>' 
                                    CommandArgument='<%# Eval("Value") %>' 
                                    OnClick="Page_Changed">
                                </asp:LinkButton>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </nav>
        </div>
    </div>

    <style>
        .transition-hover { transition: transform 0.2s ease-in-out; }
        .transition-hover:hover { transform: translateY(-5px); }
        .page-item.active .page-link { background-color: #F98189; border-color: #F98189; }
        .page-link { color: #2c3e50; }
    </style>
</asp:Content>