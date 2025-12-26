<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ChiTietSach.aspx.cs" Inherits="lab_06_BanSach.ChiTietSach" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card shadow-sm border-0 p-4">
        <asp:Repeater ID="rptChiTiet" runat="server">
            <ItemTemplate>
                <div class="row">
                    <div class="col-md-5 text-center mb-4 mb-md-0">
                        <img src='<%# "Bia_sach/" + Eval("AnhBia") %>' class="img-fluid rounded shadow" style="max-height: 500px;" alt='<%# Eval("TenSach") %>' />
                    </div>

                    <div class="col-md-7">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="Default.aspx">Trang chủ</a></li>
                                <li class="breadcrumb-item active"><%# Eval("Tenchude") %></li>
                            </ol>
                        </nav>
                        
                        <h2 class="fw-bold text-dark"><%# Eval("TenSach") %></h2>
                        <hr class="border-warning opacity-75" style="width: 50px; height: 3px;">
                        
                        <div class="mb-3 mt-4">
                            <span class="h3 text-danger fw-bold"><%# Eval("Dongia", "{0:0,0}") %> đ</span>
                            <span class="text-muted ms-2 px-2 border-start">Tình trạng: <span class="text-success fw-bold">Còn hàng</span></span>
                        </div>

                        <div class="bg-light p-3 rounded mb-4">
                            <p class="mb-2"><strong>Tác giả:</strong> <span class="text-primary"><%# Eval("TenTacGia") %></span></p>
                            <p class="mb-2"><strong>Nhà xuất bản:</strong> <%# Eval("TenNXB") %></p>
                            <p class="mb-0"><strong>Ngày cập nhật:</strong> <%# Eval("Ngaycapnhat", "{0:dd/MM/yyyy}") %></p>
                        </div>

                        <h5 class="fw-bold"><i class="fas fa-book-open me-2 text-warning"></i>Tóm tắt nội dung</h5>
                        <p class="text-muted lh-base" style="text-align: justify;">
                            <%# Eval("Mota").ToString().Replace("\n", "<br/>") %>
                        </p>

                        <div class="d-grid gap-2 d-md-flex mt-5">
                            <asp:LinkButton ID="btnAdd" runat="server" CssClass="btn btn-danger btn-lg px-5 shadow-sm" 
                                CommandArgument='<%# Eval("MaSach") %>' OnClick="btnAddToCart_Click">
                                <i class="fas fa-cart-plus me-2"></i>Thêm vào giỏ hàng
                            </asp:LinkButton>
                            <a href="Default.aspx" class="btn btn-outline-secondary btn-lg px-4">
                                <i class="fas fa-undo me-2"></i>Quay lại
                            </a>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
