<%@ Page Title="Quản Lý Đơn Hàng" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="QuanLyDonHang.aspx.cs" Inherits="lab_06_BanSach.Admin.QuanLyDonHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h4 class="fw-bold text-dark mb-1"><i class="fas fa-shopping-bag me-2 text-primary"></i>QUẢN LÝ ĐƠN HÀNG</h4>
                <p class="text-muted small mb-0">Theo dõi, duyệt và quản lý lịch sử mua hàng</p>
            </div>
            <div class="d-flex gap-2">
                <asp:LinkButton ID="btnExport" runat="server" CssClass="btn btn-sm btn-outline-success px-3 fw-bold">
                    <i class="fas fa-file-excel me-1"></i> Xuất báo cáo
                </asp:LinkButton>
            </div>
        </div>

        <div class="card shadow-sm border-0 mb-4 rounded-3">
            <div class="card-body bg-white">
                <div class="row g-2 align-items-end">
                    <div class="col-md-3">
                        <label class="form-label small fw-bold text-muted">Tìm kiếm nhanh</label>
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control form-control-sm border-2" placeholder="Số ĐH hoặc Tên khách..."></asp:TextBox>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label small fw-bold text-muted">Từ ngày</label>
                        <asp:TextBox ID="txtTuNgay" runat="server" TextMode="Date" CssClass="form-control form-control-sm border-2"></asp:TextBox>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label small fw-bold text-muted">Đến ngày</label>
                        <asp:TextBox ID="txtDenNgay" runat="server" TextMode="Date" CssClass="form-control form-control-sm border-2"></asp:TextBox>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label small fw-bold text-muted">Trạng thái</label>
                        <asp:DropDownList ID="ddlTrangThai" runat="server" CssClass="form-select form-select-sm border-2">
                            <asp:ListItem Value="-1">Tất cả đơn</asp:ListItem>
                            <asp:ListItem Value="0">Chờ xử lý</asp:ListItem>
                            <asp:ListItem Value="1">Đã giao hàng</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-3">
                        <asp:LinkButton ID="btnLoc" runat="server" CssClass="btn btn-primary btn-sm w-100 fw-bold" OnClick="btnLoc_Click">
                            <i class="fas fa-filter me-1"></i> Tìm kiếm & Lọc
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>

        <div class="card shadow-sm border-0 rounded-3">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvDonHang" runat="server" AutoGenerateColumns="False"
                        CssClass="table table-hover align-middle mb-0" DataKeyNames="SoDH"
                        OnRowCommand="gvDonHang_RowCommand"
                        AllowPaging="True" PageSize="8" OnPageIndexChanging="gvDonHang_PageIndexChanging" 
                        GridLines="None">
                        
                        <HeaderStyle CssClass="bg-light text-muted small text-uppercase fw-bold border-bottom" />
                        <PagerStyle CssClass="pagination-container py-3" HorizontalAlign="Center" />

                        <Columns>
                            <asp:TemplateField HeaderText="Mã ĐH">
                                <ItemTemplate>
                                    <span class="fw-bold text-dark ps-3">#<%# Eval("SoDH") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Khách hàng">
                                <ItemTemplate>
                                    <div class="fw-bold text-primary"><%# Eval("HoTenKH") %></div>
                                    <small class="text-muted"><i class="far fa-calendar-alt me-1"></i><%# Eval("NgayDH", "{0:dd/MM/yyyy HH:mm}") %></small>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Tổng tiền">
                                <ItemTemplate>
                                    <span class="fw-bold text-dark"><%# Eval("Trigia", "{0:N0}") %> đ</span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Tình trạng">
                                <ItemTemplate>
                                    <%# (Eval("Dagiao") != DBNull.Value && (bool)Eval("Dagiao")) ? 
                                        "<span class='badge rounded-pill bg-success-subtle text-success border border-success-subtle px-3'>Đã giao</span>" : 
                                        "<span class='badge rounded-pill bg-warning-subtle text-warning border border-warning-subtle px-3'>Chờ xử lý</span>" %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Ngày giao dự kiến">
                                <ItemTemplate>
                                    <span class="small"><%# Eval("Ngaygiao") == DBNull.Value ? "<i class='text-muted'>Chưa cập nhật</i>" : Eval("Ngaygiao", "{0:dd/MM/yyyy}") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Thao tác">
                                <ItemTemplate>
                                    <div class="pe-3 text-end">
                                        <a href='<%# "ChiTietDonHang.aspx?id=" + Eval("SoDH") %>' class="btn btn-icon btn-sm btn-outline-primary me-1" title="Xem chi tiết">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <asp:LinkButton ID="btnDelete" runat="server"
                                            CommandName="DeleteDH" CommandArgument='<%# Eval("SoDH") %>'
                                            CssClass="btn btn-icon btn-sm btn-outline-danger"
                                            OnClientClick="return confirm('Cảnh báo: Xóa đơn hàng sẽ xóa tất cả dữ liệu liên quan. Tiếp tục?')">
                                            <i class="fas fa-trash"></i>
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>

    <style>
        /* Đồng bộ màu Badge nhẹ nhàng */
        .bg-success-subtle { background-color: #e6fffa; }
        .text-success { color: #059669 !important; }
        .bg-warning-subtle { background-color: #fffaf0; }
        .text-warning { color: #d97706 !important; }

        /* Nút icon tròn giống trang Quản lý sách */
        .btn-icon { width: 32px; height: 32px; padding: 0; line-height: 32px; border-radius: 50%; border: 1px solid #eee; }
        .btn-icon:hover { background-color: #f8f9fa; }

        /* Phân trang tròn đồng bộ */
        .pagination-container table { margin: 0 auto; }
        .pagination-container td { border: none; }
        .pagination-container a, .pagination-container span {
            display: block; padding: 6px 12px; margin: 0 3px; border-radius: 50% !important;
            border: 1px solid #eee; text-decoration: none; color: #666; font-size: 0.8rem;
        }
        .pagination-container span { background-color: #0d6efd !important; color: white !important; }
    </style>
</asp:Content>