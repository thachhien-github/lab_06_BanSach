<%@ Page Title="Chi Tiết Sách" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ChiTietSach.aspx.cs" Inherits="lab_06_BanSach.ChiTietSach" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .book-detail-card {
            border-radius: 20px;
            overflow: hidden;
            background: #fff;
            border: none;
        }
        .img-detail-container {
            padding: 20px;
            background: #f9f9f9;
            border-radius: 15px;
        }
        .price-tag {
            font-size: 2rem;
            color: #e74c3c;
            font-weight: 800;
        }
        .info-label {
            min-width: 120px;
            display: inline-block;
            font-weight: 600;
            color: #7f8c8d;
        }
        .description-box {
            line-height: 1.8;
            color: #2c3e50;
            font-size: 1.05rem;
            border-left: 4px solid #feb47b;
            padding-left: 15px;
            background: #fffaf0;
        }
        .breadcrumb-item a {
            color: #ff7e5f;
            text-decoration: none;
        }
        .btn-add-cart {
            background: linear-gradient(135deg, #ff7e5f, #feb47b);
            border: none;
            color: white;
            transition: 0.3s;
            padding: 12px 30px;
        }
        .btn-add-cart:hover {
            background: linear-gradient(135deg, #e74c3c, #ff7e5f);
            transform: scale(1.05);
            color: white;
            box-shadow: 0 10px 20px rgba(255, 126, 95, 0.3);
        }
    </style>

    <div class="container py-4">
        <asp:Repeater ID="rptChiTiet" runat="server">
            <ItemTemplate>
                <div class="card shadow-lg book-detail-card p-4 p-md-5">
                    <div class="row">
                        <div class="col-md-5 mb-4 mb-md-0">
                            <div class="img-detail-container text-center shadow-sm">
                                <img src='<%# "Bia_sach/" + Eval("AnhBia") %>' 
                                     class="img-fluid rounded" 
                                     style="max-height: 550px; transition: transform 0.3s;" 
                                     alt='<%# Eval("TenSach") %>' />
                            </div>
                        </div>

                        <div class="col-md-7 ps-md-5">
                            <nav aria-label="breadcrumb" class="mb-3">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="Default.aspx"><i class="fas fa-home me-1"></i>Trang chủ</a></li>
                                    <li class="breadcrumb-item active"><%# Eval("Tenchude") %></li>
                                </ol>
                            </nav>
                            
                            <h1 class="fw-bold mb-2 text-dark"><%# Eval("TenSach") %></h1>
                            <div class="mb-4">
                                <span class="badge bg-success-soft text-success p-2 px-3 rounded-pill" style="background: #e8f5e9;">
                                    <i class="fas fa-check-circle me-1"></i>Còn hàng
                                </span>
                                <span class="ms-2 text-muted small"><i class="fas fa-eye me-1"></i> Đang xem: 12</span>
                            </div>

                            <div class="mb-4">
                                <span class="price-tag"><%# Eval("Dongia", "{0:0,0}") %> đ</span>
                            </div>

                            <div class="row g-3 mb-4">
                                <div class="col-6">
                                    <span class="info-label">Tác giả:</span>
                                    <span class="text-primary fw-bold"><%# Eval("TenTacGia") %></span>
                                </div>
                                <div class="col-6">
                                    <span class="info-label">NXB:</span>
                                    <span><%# Eval("TenNXB") %></span>
                                </div>
                                <div class="col-6">
                                    <span class="info-label">Ngày đăng:</span>
                                    <span><%# Eval("Ngaycapnhat", "{0:dd/MM/yyyy}") %></span>
                                </div>
                            </div>

                            <h5 class="fw-bold mb-3"><i class="fas fa-info-circle me-2 text-warning"></i>Giới thiệu sách</h5>
                            <div class="description-box p-3 rounded mb-4">
                                <%# Eval("Mota").ToString().Replace("\n", "<br/>") %>
                            </div>

                            <div class="d-flex flex-wrap gap-3 mt-5">
                                <asp:LinkButton ID="btnAdd" runat="server" 
                                    CssClass="btn btn-add-cart btn-lg rounded-pill fw-bold" 
                                    CommandArgument='<%# Eval("MaSach") %>' 
                                    OnClick="btnAddToCart_Click">
                                    <i class="fas fa-shopping-cart me-2"></i>THÊM VÀO GIỎ HÀNG
                                </asp:LinkButton>
                                
                                <a href="Default.aspx" class="btn btn-outline-secondary btn-lg rounded-pill px-4">
                                    <i class="fas fa-arrow-left me-2"></i>Tiếp tục mua sắm
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>