<%@ Page Title="Đăng Ký Thành Viên" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="lab_06_BanSach.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* Đồng bộ tiêu đề Navy */
        .register-title {
            color: #2c3e50;
            letter-spacing: 1px;
        }

        /* Icon và các chi tiết màu Coral */
        .text-coral {
            color: #ff7e5f !important;
        }

        /* Đồng bộ Card bo tròn */
        .register-card {
            border-radius: 20px !important;
        }

        /* Style cho label giống Profile */
        .form-label {
            color: #6c757d;
            text-transform: uppercase;
            font-size: 0.75rem;
            margin-bottom: 5px;
        }

        /* Ô nhập liệu hiện đại */
        .form-control {
            border-radius: 8px;
            padding: 10px 15px;
            border: 1px solid #e9ecef;
            background-color: #f8f9fa;
            transition: all 0.3s;
        }

        .form-control:focus {
            background-color: #fff;
            border-color: #ff7e5f;
            box-shadow: 0 0 0 0.2rem rgba(255, 126, 95, 0.1);
        }

        /* Nút bấm Gradient đồng bộ toàn trang */
        .btn-register-custom {
            background: linear-gradient(135deg, #ff7e5f, #feb47b);
            border: none;
            color: white;
            border-radius: 50px;
            transition: 0.3s;
            letter-spacing: 1px;
        }

        .btn-register-custom:hover {
            background: linear-gradient(135deg, #e74c3c, #ff7e5f);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 126, 95, 0.3);
            color: white;
        }

        /* Link chuyển sang Đăng nhập */
        .link-login {
            color: #ff7e5f;
            text-decoration: none;
        }
        .link-login:hover {
            color: #e74c3c;
            text-decoration: underline;
        }
    </style>

    <div class="row justify-content-center align-items-center" style="min-height: 85vh;">
        <div class="col-md-7 col-lg-6">
            <div class="card shadow-lg border-0 register-card mt-4 mb-4">
                <div class="card-body p-5">
                    <div class="text-center mb-4">
                        <i class="fas fa-user-plus fa-3x text-coral mb-3"></i>
                        <h3 class="fw-bold register-title">ĐĂNG KÝ THÀNH VIÊN</h3>
                        <p class="text-muted small">Gia nhập cộng đồng yêu sách BookStore để nhận nhiều ưu đãi</p>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold">Họ và tên</label>
                            <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control" placeholder="Nguyễn Văn A"></asp:TextBox>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold">Tên đăng nhập</label>
                            <asp:TextBox ID="txtTenDN" runat="server" CssClass="form-control" placeholder="user123"></asp:TextBox>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold">Mật khẩu</label>
                            <asp:TextBox ID="txtMatKhau" runat="server" CssClass="form-control" TextMode="Password" placeholder="••••••••"></asp:TextBox>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-bold">Nhập lại mật khẩu</label>
                            <asp:TextBox ID="txtNhapLaiMK" runat="server" CssClass="form-control" TextMode="Password" placeholder="••••••••"></asp:TextBox>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Địa chỉ Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="email@example.com"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Số điện thoại</label>
                        <asp:TextBox ID="txtDienThoai" runat="server" CssClass="form-control" placeholder="090xxxxxxx"></asp:TextBox>
                    </div>

                    <asp:Label ID="lblMsg" runat="server" CssClass="d-block mb-3 small fw-bold text-center" Visible="false"></asp:Label>

                    <div class="d-grid gap-2 mt-4">
                        <asp:Button ID="btnRegister" runat="server" Text="TẠO TÀI KHOẢN NGAY" 
                            CssClass="btn btn-register-custom fw-bold py-2 shadow-sm" OnClick="btnRegister_Click" />
                    </div>

                    <div class="text-center mt-4">
                        <p class="small text-muted">Đã có tài khoản? <a href="Login.aspx" class="link-login fw-bold">Đăng nhập tại đây</a></p>
                        <a href="Default.aspx" class="text-muted small text-decoration-none mt-2 d-inline-block">
                             <i class="fas fa-chevron-left me-1"></i> Trở về trang chủ
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>