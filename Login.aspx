<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="lab_06_BanSach.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row justify-content-center align-items-center" style="min-height: 70vh;">
        <div class="col-md-5">
            <div class="card shadow-lg border-0 rounded-4">
                <div class="card-body p-5">
                    <div class="text-center mb-4">
                        <i class="fas fa-user-circle fa-4x text-warning mb-3"></i>
                        <h3 class="fw-bold">ĐĂNG NHẬP</h3>
                        <p class="text-muted">Chào mừng bạn quay trở lại với BookStore</p>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tên đăng nhập</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0"><i class="fas fa-user"></i></span>
                            <asp:TextBox ID="txtTenDN" runat="server" CssClass="form-control border-start-0" placeholder="Nhập tên tài khoản..."></asp:TextBox>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold">Mật khẩu</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0"><i class="fas fa-lock"></i></span>
                            <asp:TextBox ID="txtMatKhau" runat="server" CssClass="form-control border-start-0" TextMode="Password" placeholder="Nhập mật khẩu..."></asp:TextBox>
                        </div>
                    </div>

                    <asp:Label ID="lblError" runat="server" CssClass="text-danger small mb-3 d-block" Visible="false"></asp:Label>

                    <div class="d-grid gap-2">
                        <asp:Button ID="btnLogin" runat="server" Text="ĐĂNG NHẬP NGAY" CssClass="btn btn-warning fw-bold py-2 shadow-sm" OnClick="btnLogin_Click" />
                    </div>

                    <div class="text-center mt-4">
                        <p class="small mb-0">Chưa có tài khoản? <a href="Register.aspx" class="text-decoration-none text-primary fw-bold">Đăng ký ngay</a></p>
                        <a href="Default.aspx" class="text-muted small text-decoration-none mt-2 d-inline-block">Quay lại trang chủ</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
