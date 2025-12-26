<%@ Page Title="Hồ Sơ Cá Nhân" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="lab_06_BanSach.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* Đồng bộ màu Navy cho tiêu đề */
        .text-primary {
            color: #2c3e50 !important;
            letter-spacing: 0.5px;
        }

        /* Card bo góc và đổ bóng nhẹ */
        .card {
            border-radius: 15px !important;
            overflow: hidden;
            border: none;
        }

        /* Label nhỏ, in đậm và màu xám sang trọng */
        .form-label {
            color: #6c757d;
            text-transform: uppercase;
            font-size: 0.75rem;
            margin-bottom: 5px;
        }

        /* Tùy chỉnh các ô nhập liệu */
        .form-control {
            border-radius: 8px;
            padding: 10px 15px;
            border: 1px solid #e9ecef;
            transition: all 0.3s;
        }

        .form-control:focus {
            border-color: #ff7e5f;
            box-shadow: 0 0 0 0.2rem rgba(255, 126, 95, 0.1);
        }

        /* Nút Lưu thay đổi đồng bộ Gradient với trang chủ */
        .btn-primary {
            background: linear-gradient(135deg, #ff7e5f, #feb47b);
            border: none;
            color: white;
            border-radius: 50px;
            transition: 0.3s;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #e74c3c, #ff7e5f);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 126, 95, 0.4);
        }

        /* Màu cho thông báo lỗi/thành công */
        .msg-label {
            font-style: italic;
        }
    </style>

    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-white py-3 border-bottom">
                        <h4 class="mb-0 fw-bold text-primary">
                            <i class="fas fa-user-circle me-2" style="color: #ff7e5f;"></i>THÔNG TIN CÁ NHÂN
                        </h4>
                    </div>
                    <div class="card-body p-4">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Họ tên khách hàng</label>
                                <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control" placeholder="Nhập họ tên"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Tên đăng nhập</label>
                                <asp:TextBox ID="txtTenDN" runat="server" CssClass="form-control" ReadOnly="true" BackColor="#f8f9fa"></asp:TextBox>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Email liên hệ</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="example@mail.com"></asp:TextBox>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Số điện thoại</label>
                            <asp:TextBox ID="txtDienThoai" runat="server" CssClass="form-control" placeholder="Số điện thoại di động"></asp:TextBox>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Địa chỉ giao hàng mặc định</label>
                            <asp:TextBox ID="txtDiaChi" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" placeholder="Số nhà, tên đường, phường/xã..."></asp:TextBox>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Ngày sinh</label>
                                <asp:TextBox ID="txtNgaySinh" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Mật khẩu mới</label>
                                <asp:TextBox ID="txtMatKhau" runat="server" CssClass="form-control" TextMode="Password" placeholder="Để trống nếu không đổi"></asp:TextBox>
                            </div>
                        </div>

                        <div class="mt-4 border-top pt-4 d-flex justify-content-between align-items-center">
                            <asp:Label ID="lblMsg" runat="server" CssClass="small fw-bold msg-label"></asp:Label>
                            <asp:Button ID="btnUpdate" runat="server" Text="LƯU THAY ĐỔI" CssClass="btn btn-primary px-5 fw-bold shadow-sm" OnClick="btnUpdate_Click" />
                        </div>
                    </div>
                </div>
                
                <div class="text-center mt-3">
                    <a href="Default.aspx" class="text-muted small text-decoration-none">
                        <i class="fas fa-arrow-left me-1"></i> Quay lại cửa hàng
                    </a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>