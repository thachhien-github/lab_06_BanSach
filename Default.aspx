<%@ Page Title="Trang Chủ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="lab_06_BanSach.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* Làm mượt chuyển cảnh Carousel */
        .carousel-item {
            transition: transform 0.8s ease-in-out, opacity 0.8s ease-in-out;
        }

        .carousel-caption {
            bottom: 20%;
            animation: fadeInUp 1s ease-in-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }


        /* Tiêu đề phần nội dung */
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

        /* Card Sách hiện đại */
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

        /* Container ảnh để zoom */
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

        /* Tên sách: Giới hạn 2 dòng để đều Card */
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

        /* Giá tiền */
        .book-price {
            font-size: 1.15rem;
            color: #e74c3c;
            margin-bottom: 15px;
        }

        /* Custom Button */
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

        /* Phân trang */
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

    <div id="bookStoreCarousel" class="carousel slide mb-5 shadow rounded-3 overflow-hidden" data-bs-ride="carousel">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#bookStoreCarousel" data-bs-slide-to="0" class="active"></button>
            <button type="button" data-bs-target="#bookStoreCarousel" data-bs-slide-to="1"></button>
            <button type="button" data-bs-target="#bookStoreCarousel" data-bs-slide-to="2"></button>
        </div>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="https://images.unsplash.com/photo-1507842217343-583bb7270b66?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" class="d-block w-100" style="height: 400px; object-fit: cover;" alt="Banner 1">
                <div class="carousel-caption d-none d-md-block" style="background: rgba(0,0,0,0.4); border-radius: 15px; padding: 20px;">
                    <h2 class="fw-bold text-white">Thế Giới Sách Trong Tầm Tay</h2>
                    <p>Khám phá hàng ngàn tựa sách mới mỗi ngày với ưu đãi hấp dẫn.</p>
                    <a href="#" class="btn btn-cart rounded-pill px-4">Xem Ngay</a>
                </div>
            </div>
            <div class="carousel-item">
                <img src="https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" class="d-block w-100" style="height: 400px; object-fit: cover;" alt="Banner 2">
                <div class="carousel-caption d-none d-md-block" style="background: rgba(0,0,0,0.4); border-radius: 15px; padding: 20px;">
                    <h2 class="fw-bold text-white">Giảm Giá Đến 50%</h2>
                    <p>Chương trình khuyến mãi lớn nhất trong năm cho các dòng sách kỹ năng.</p>
                    <a href="#" class="btn btn-warning rounded-pill px-4">Nhận Ưu Đãi</a>
                </div>
            </div>
            <div class="carousel-item">
                <img src="https://images.unsplash.com/photo-1481627834876-b7833e8f5570?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" class="d-block w-100" style="height: 400px; object-fit: cover;" alt="Banner 3">
                <div class="carousel-caption d-none d-md-block" style="background: rgba(0,0,0,0.4); border-radius: 15px; padding: 20px;">
                    <h2 class="fw-bold text-white">Sách Ngoại Văn Tuyển Chọn</h2>
                    <p>Nâng tầm tri thức với những đầu sách nhập khẩu chất lượng cao.</p>
                </div>
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#bookStoreCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#bookStoreCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </button>
    </div>

    <h3 class="mb-5 section-title">
        <%= string.IsNullOrEmpty(Request.QueryString["search"]) ? "SÁCH MỚI NHẤT" : "KẾT QUẢ TÌM KIẾM: " + Request.QueryString["search"] %>
    </h3>

    <div class="row">
        <asp:Repeater ID="Repeater1" runat="server">
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
                                    class="btn btn-sm btn-outline-secondary rounded-pill">Chi tiết
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
