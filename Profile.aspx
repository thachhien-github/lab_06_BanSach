<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="lab_06_BanSach.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-white py-3">
                        <h4 class="mb-0 fw-bold text-primary"><i class="fas fa-user-cog me-2"></i>THÔNG TIN CÁ NHÂN</h4>
                    </div>
                    <div class="card-body p-4">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-bold small">Họ tên khách hàng</label>
                                <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold small">Tên đăng nhập</label>
                                <asp:TextBox ID="txtTenDN" runat="server" CssClass="form-control" ReadOnly="true" BackColor="#f8f9fa"></asp:TextBox>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold small">Email</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold small">Số điện thoại</label>
                            <asp:TextBox ID="txtDienThoai" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold small">Địa chỉ giao hàng</label>
                            <asp:TextBox ID="txtDiaChi" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-bold small">Ngày sinh</label>
                                <asp:TextBox ID="txtNgaySinh" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold small">Mật khẩu mới (để trống nếu không đổi)</label>
                                <asp:TextBox ID="txtMatKhau" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                            </div>
                        </div>

                        <div class="mt-4 border-top pt-3 d-flex justify-content-between">
                            <asp:Label ID="lblMsg" runat="server" CssClass="small fw-bold"></asp:Label>
                            <asp:Button ID="btnUpdate" runat="server" Text="LƯU THAY ĐỔI" CssClass="btn btn-primary px-4 fw-bold" OnClick="btnUpdate_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
