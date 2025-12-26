<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="lab_06_BanSach.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row justify-content-center align-items-center" style="min-height: 80vh;">
        <div class="col-md-6">
            <div class="card shadow-lg border-0 rounded-4">
                <div class="card-body p-5">
                    <div class="text-center mb-4">
                        <i class="fas fa-user-plus fa-3x text-primary mb-3"></i>
                        <h3 class="fw-bold">ĐĂNG KÝ THÀNH VIÊN</h3>
                        <p class="text-muted">Gia nhập cộng đồng yêu sách BookStore</p>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Họ và tên</label>
                            <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control" placeholder="Nguyễn Văn A"></asp:TextBox>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Tên đăng nhập</label>
                            <asp:TextBox ID="txtTenDN" runat="server" CssClass="form-control" placeholder="user123"></asp:TextBox>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Mật khẩu</label>
                            <asp:TextBox ID="txtMatKhau" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Nhập lại mật khẩu</label>
                            <asp:TextBox ID="txtNhapLaiMK" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="email@example.com"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Số điện thoại</label>
                        <asp:TextBox ID="txtDienThoai" runat="server" CssClass="form-control" placeholder="090xxxxxxx"></asp:TextBox>
                    </div>

                    <asp:Label ID="lblMsg" runat="server" CssClass="d-block mb-3 small" Visible="false"></asp:Label>

                    <div class="d-grid gap-2 mt-4">
                        <asp:Button ID="btnRegister" runat="server" Text="TẠO TÀI KHOẢN" CssClass="btn btn-primary fw-bold py-2 shadow-sm" OnClick="btnRegister_Click" />
                    </div>

                    <div class="text-center mt-3">
                        <p class="small">Đã có tài khoản? <a href="Login.aspx" class="text-decoration-none fw-bold">Đăng nhập</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
