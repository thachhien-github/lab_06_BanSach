<%@ Page Title="Sách Theo Chủ Đề" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SachTheoChuDe.aspx.cs" Inherits="lab_06_BanSach.SachTheoChuDe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* Đồng bộ Tiêu đề giống Default */
        .section-title {
            font-weight: 700;
            letter-spacing: 1px;
            color: #2c3e50;
            position: relative;
            padding-bottom: 15px;
            text-transform: uppercase;
        }
        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 4px;
            background: #ff7e5f;
            border-radius: 2px;
        }

        /* Đồng bộ Card Sách giống Default */
        .book-card {
            transition: all 0.3s cubic-bezier(.25,.8,.25,1);
            border-radius: 15px !important;
            overflow: hidden;
            background: #fff;
        }
        .book-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.12) !important;
        }

        /* Đồng bộ Zoom ảnh */
        .img-container {
            overflow: hidden;
            background: #fdfdfd;
            border-bottom: 1px solid #f1f1f1;
        }
        .book-card .card-img-top {
            transition: transform 0.5s ease;
        }
        .book-card:hover .card-img-top {
            transform: scale(1.1);
        }

        /* Đồng bộ Text & Price */
        .book-title {
            height: 42px;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            line-height: 1.3;
            margin-bottom: 8px;
            font-size: 0.95rem;
        }
        .book-price {
            font-size: 1.15rem;
            color: #e74c3c;
            margin-bottom: 15px;
        }

        /* Đồng bộ Button Gradient */
        .btn-cart {
            background: linear-gradient(135deg, #ff7e5f, #feb47b);
            border: none;
            color: white;
            font-weight: 600;
            transition: 0.3s;
        }
        .btn-cart:hover {
            background: linear-gradient(135deg, #e74c3c, #ff7e5f);
            color: white;
            box-shadow: 0 4px 15px rgba(255, 126, 95, 0.4);
        }

        /* Đồng bộ Phân trang */
        .pagination .page-link {
            border: none;
            margin: 0 3px;
            color: #2c3e50;
            border-radius: 8px !important;
            transition: all 0.2s;
        }
        .pagination .page-item.active .page-link {
            background-color: #2c3e50;
            color: white;
        }
        .pagination .page-link:hover {
            background-color: #ff7e5f;
            color: white;
        }
    </style>

    <h3 class="mb-5 section-title">
        <i class="fas fa-bookmark me-2 text-coral" style="color:#ff7e5f;"></i>
        CHỦ ĐỀ: <asp:Literal ID="ltrTenChuDe" runat="server"></asp:Literal>
    </h3>

    <div class="row">
        <asp:Repeater ID="rptSachTheoCD" runat="server">
            <ItemTemplate>
                <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                    <div class="card h-100 border-0 shadow-sm book-card">
                        <div class="img-container">
                            <img src='<%# "Bia_sach/" + Eval("AnhBia") %>' 
                                 class="card-img-top" 
                                 style="height: 250px; object-fit: contain; padding: 15px;" 
                                 alt='<%# Eval("TenSach") %>'>
                        </div>
                        <div class="card-body text-center d-flex flex-column">
                            <h6 class="card-title fw-bold book-title" title='<%# Eval("TenSach") %>'>
                                <%# Eval("TenSach") %>
                            </h6>
                            <p class="fw-bold book-price mt-auto"><%# Eval("Dongia", "{0:0,0}") %> đ</p>
                            <div class="d-grid gap-2">
                                <a href='ChiTietSach.aspx?MaSach=<%# Eval("MaSach") %>' 
                                   class="btn btn-sm btn-outline-secondary rounded-pill">
                                   Chi tiết
                                </a>
                                <asp:LinkButton ID="btnAdd" runat="server" 
                                    CssClass="btn btn-sm btn-cart rounded-pill"
                                    CommandArgument='<%# Eval("MaSach") %>' 
                                    OnClick="btnAddToCart_Click">
                                    <i class="fas fa-shopping-basket me-1"></i> Thêm vào giỏ
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <nav aria-label="Page navigation" class="mt-5 mb-5">
        <ul class="pagination justify-content-center">
            <asp:Repeater ID="rptPager" runat="server">
                <ItemTemplate>
                    <li class='page-item <%# (bool)Eval("Active") ? "active" : "" %>'>
                        <asp:LinkButton ID="lnkPage" runat="server" 
                            Text='<%# Eval("Text") %>'
                            CommandArgument='<%# Eval("Value") %>' 
                            OnClick="Page_Changed" 
                            CssClass="page-link shadow-sm"
                            Enabled='<%# !(bool)Eval("Active") %>'>
                        </asp:LinkButton>
                    </li>
                </ItemTemplate>
            </asp:Repeater>
        </ul>
    </nav>
</asp:Content>