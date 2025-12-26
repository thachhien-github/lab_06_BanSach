<%@ Page Title="Quản Lý Khách Hàng" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="QuanLyKhachHang.aspx.cs" Inherits="lab_06_BanSach.Admin.QuanLyKhachHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h4 class="fw-bold text-dark mb-1"><i class="fas fa-users-cog me-2 text-primary"></i>QUẢN LÝ KHÁCH HÀNG</h4>
                <p class="text-muted small mb-0">Danh sách người dùng đăng ký tài khoản trên hệ thống</p>
            </div>
        </div>

        <div class="card shadow-sm border-0 mb-4 rounded-3">
            <div class="card-body bg-white">
                <div class="row g-2 align-items-end">
                    <div class="col-md-10">
                        <label class="form-label small fw-bold text-muted">Thông tin khách hàng</label>
                        <div class="input-group input-group-sm">
                            <span class="input-group-text bg-light border-2 border-end-0"><i class="fas fa-search text-muted"></i></span>
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control border-2 border-start-0" placeholder="Nhập tên, số điện thoại hoặc email khách hàng..."></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <asp:Button ID="btnSearch" runat="server" Text="Tìm kiếm" CssClass="btn btn-primary btn-sm w-100 fw-bold" OnClick="btnSearch_Click" />
                    </div>
                </div>
            </div>
        </div>

        <div class="card shadow-sm border-0 rounded-3">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvKhachHang" runat="server" AutoGenerateColumns="False" 
                        CssClass="table table-hover align-middle mb-0" DataKeyNames="MaKH" 
                        OnRowCommand="gvKhachHang_RowCommand"
                        AllowPaging="True" PageSize="10" OnPageIndexChanging="gvKhachHang_PageIndexChanging" 
                        GridLines="None">
                        
                        <HeaderStyle CssClass="bg-light text-muted small text-uppercase fw-bold border-bottom" />
                        <PagerStyle CssClass="pagination-container py-3" HorizontalAlign="Center" />

                        <Columns>
                            <asp:BoundField DataField="MaKH" HeaderText="ID" ItemStyle-CssClass="ps-4 fw-bold text-muted" HeaderStyle-CssClass="ps-4" />
                            
                            <asp:TemplateField HeaderText="Khách hàng">
                                <ItemTemplate>
                                    <div class="d-flex align-items-center py-2">
                                        <div class="avatar-sm bg-primary bg-opacity-10 text-primary rounded-circle me-3 d-flex align-items-center justify-content-center" style="width: 35px; height: 35px;">
                                            <i class="fas fa-user small"></i>
                                        </div>
                                        <div>
                                            <div class="fw-bold text-dark"><%# Eval("HoTenKH") %></div>
                                            <small class="text-muted">User: <%# Eval("TenDN") %></small>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Liên hệ">
                                <ItemTemplate>
                                    <div class="small"><i class="fas fa-envelope me-2 text-muted"></i><%# Eval("Email") %></div>
                                    <div class="small mt-1"><i class="fas fa-phone me-2 text-muted"></i><%# Eval("Dienthoai") %></div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Ngày sinh">
                                <ItemTemplate>
                                    <span class="small text-dark"><%# Eval("Ngaysinh", "{0:dd/MM/yyyy}") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Thao tác">
                                <ItemTemplate>
                                    <div class="pe-4 text-end">
                                        <asp:LinkButton ID="btnReset" runat="server" CommandName="ResetPass" CommandArgument='<%# Eval("MaKH") %>'
                                            CssClass="btn btn-sm btn-outline-warning border-2 fw-bold me-1" 
                                            OnClientClick="return confirm('Đặt lại mật khẩu về mặc định (123456)?')">
                                            <i class="fas fa-sync-alt"></i> Reset
                                        </asp:LinkButton>
                                        
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteKH" CommandArgument='<%# Eval("MaKH") %>'
                                            CssClass="btn btn-sm btn-outline-danger border-2 fw-bold" 
                                            OnClientClick="return confirm('Xóa khách hàng sẽ mất toàn bộ lịch sử mua hàng. Xác nhận xóa?')">
                                            <i class="fas fa-user-slash"></i> Xóa
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                                <HeaderStyle CssClass="text-end pe-4" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>

    <style>
        /* Đồng bộ phân trang hình tròn */
        .pagination-container table { margin: 0 auto; }
        .pagination-container td { border: none; }
        .pagination-container a, .pagination-container span {
            display: block; padding: 6px 12px; margin: 0 3px; border-radius: 50% !important;
            border: 1px solid #eee; text-decoration: none; color: #666; font-size: 0.8rem;
        }
        .pagination-container span { background-color: #0d6efd !important; color: white !important; border-color: #0d6efd !important; }
        
        /* Table hover effect */
        .table-hover tbody tr:hover { background-color: #f8faff !important; }
    </style>
</asp:Content>