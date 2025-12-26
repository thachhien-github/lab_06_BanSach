<%@ Page Title="Đăng Nhập" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="lab_06_BanSach.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* Tông màu Navy cho tiêu đề */
        .login-title {
            color: #2c3e50;
            letter-spacing: 1px;
        }

        /* Đồng bộ icon màu Coral */
        .text-coral {
            color: #ff7e5f !important;
        }

        /* Hiệu ứng Input focus */
        .form-control:focus {
            border-color: #ff7e5f;
            box-shadow: none;
        }
        .input-group-text {
            color: #ff7e5f;
        }

        /* Nút đăng nhập Gradient đồng bộ Default */
        .btn-login-custom {
            background: linear-gradient(135deg, #ff7e5f, #feb47b);
            border: none;
            color: white;
            transition: 0.3s;
            border-radius: 8px;
        }

        .btn-login-custom:hover {
            background: linear-gradient(135deg, #e74c3c, #ff7e5f);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 126, 95, 0.3);
            color: white;
        }

        /* Link đăng ký */
        .link-register {
            color: #ff7e5f;
            transition: 0.2s;
        }
        .link-register:hover {
            color: #e74c3c;
        }

        /* Bo góc Card */
        .login-card {
            border-radius: 20px !important;
        }
    </style>

    <div class="row justify-content-center align-items-center" style="min-height: 75vh;">
        <div class="col-md-5 col-lg-4">
            <div class="card shadow-lg border-0 login-card">
                <div class="card-body p-5">
                    <div class="text-center mb-4">
                        <i class="fas fa-user-circle fa-4x text-coral mb-3"></i>
                        <h3 class="fw-bold login-title">ĐĂNG NHẬP</h3>
                        <p class="text-muted small">Chào mừng bạn quay trở lại với BookStore</p>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold small text-secondary">Tên đăng nhập</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0"><i class="fas fa-user"></i></span>
                            <asp:TextBox ID="txtTenDN" runat="server" CssClass="form-control border-start-0 bg-light" placeholder="Username..."></asp:TextBox>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold small text-secondary">Mật khẩu</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0"><i class="fas fa-lock"></i></span>
                            <asp:TextBox ID="txtMatKhau" runat="server" CssClass="form-control border-start-0 bg-light" TextMode="Password" placeholder="Password..."></asp:TextBox>
                        </div>
                    </div>

                    <asp:Label ID="lblError" runat="server" CssClass="text-danger small mb-3 d-block text-center" Visible="false"></asp:Label>

                    <div class="d-grid">
                        <asp:Button ID="btnLogin" runat="server" Text="ĐĂNG NHẬP NGAY" 
                            CssClass="btn btn-login-custom fw-bold py-2 shadow-sm" OnClick="btnLogin_Click" />
                    </div>

                    <div class="text-center mt-4">
                        <p class="small mb-1 text-muted">Chưa có tài khoản?</p>
                        <a href="Register.aspx" class="text-decoration-none link-register fw-bold">Tạo tài khoản mới</a>
                        <div class="mt-3">
                            <a href="Default.aspx" class="text-muted small text-decoration-none">
                                <i class="fas fa-long-arrow-alt-left me-1"></i>Quay lại trang chủ
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>