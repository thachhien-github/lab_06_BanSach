<%@ Page Title="Quản Lý Kho Sách" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="QuanLySach.aspx.cs" Inherits="lab_06_BanSach.Admin.QuanLySach" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h4 class="fw-bold text-dark mb-1"><i class="fas fa-boxes me-2 text-primary"></i>QUẢN LÝ KHO SÁCH</h4>
                <p class="text-muted small mb-0">Hệ thống có tổng cộng <span class="fw-bold text-primary">124</span> đầu sách</p>
            </div>
            <a href="QuanLySach_Edit.aspx" class="btn btn-success shadow-sm px-3">
                <i class="fas fa-plus-circle me-1"></i> Thêm sách mới
            </a>
        </div>

        <div class="card shadow-sm border-0 mb-4 rounded-3">
            <div class="card-body bg-white">
                <div class="row g-3 align-items-end">
                    <div class="col-md-4">
                        <label class="form-label small fw-bold text-muted">Từ khóa tìm kiếm</label>
                        <div class="input-group input-group-sm">
                            <span class="input-group-text bg-light border-end-0"><i class="fas fa-search"></i></span>
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control border-start-0" placeholder="Tên sách, tác giả..."></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label small fw-bold text-muted">Chủ đề</label>
                        <asp:DropDownList ID="ddlChuDe" runat="server" CssClass="form-select form-select-sm"></asp:DropDownList>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label small fw-bold text-muted">Nhà xuất bản</label>
                        <asp:DropDownList ID="ddlNXB" runat="server" CssClass="form-select form-select-sm"></asp:DropDownList>
                    </div>
                    <div class="col-md-2">
                        <asp:Button ID="btnFilter" runat="server" Text="Áp dụng lọc" CssClass="btn btn-primary btn-sm w-100 fw-bold" OnClick="btnFilter_Click" />
                    </div>
                    <div class="col-md-2">
                        <button type="reset" class="btn btn-outline-secondary btn-sm w-100">Làm mới</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="card shadow-sm border-0 rounded-3">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <asp:GridView ID="gvSach" runat="server" AutoGenerateColumns="False"
                        CssClass="table table-hover align-middle mb-0" DataKeyNames="MaSach" 
                        OnRowCommand="gvSach_RowCommand"
                        AllowPaging="True" PageSize="5" OnPageIndexChanging="gvSach_PageIndexChanging" 
                        GridLines="None">
                        <Columns>
                            <asp:BoundField DataField="MaSach" HeaderText="ID" ItemStyle-CssClass="ps-4 fw-bold text-muted" HeaderStyle-CssClass="ps-4 text-muted small" />
                            
                            <asp:TemplateField HeaderText="Thông tin sách">
                                <ItemTemplate>
                                    <div class="d-flex align-items-center py-2">
                                        <div class="position-relative me-3">
                                            <img src='../Bia_sach/<%# Eval("AnhBia") %>' 
                                                 style="width: 50px; height: 72px; object-fit: cover;" 
                                                 class="rounded shadow-sm border" />
                                        </div>
                                        <div>
                                            <div class="fw-bold text-dark mb-0"><%# Eval("TenSach") %></div>
                                            <div class="text-muted small"><i class="far fa-eye me-1"></i><%# Eval("Soluotxem") %> lượt xem</div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                                <HeaderStyle CssClass="text-muted small" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Đơn giá">
                                <ItemTemplate>
                                    <span class="fw-bold text-danger"><%# Eval("Dongia", "{0:N0}") %> đ</span>
                                </ItemTemplate>
                                <HeaderStyle CssClass="text-muted small text-center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Trạng thái">
                                <ItemTemplate>
                                    <%-- Ví dụ logic cho trạng thái kho --%>
                                    <span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1">Đang bán</span>
                                </ItemTemplate>
                                <HeaderStyle CssClass="text-muted small text-center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Thao tác">
                                <ItemTemplate>
                                    <div class="pe-4 text-end">
                                        <a href='<%# "QuanLySach_Edit.aspx?id=" + Eval("MaSach") %>' class="btn btn-icon btn-sm btn-outline-info me-1" title="Sửa">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteSach" CommandArgument='<%# Eval("MaSach") %>'
                                            CssClass="btn btn-icon btn-sm btn-outline-danger" OnClientClick="return confirm('Xác nhận xóa sách này?')" title="Xóa">
                                            <i class="fas fa-trash"></i>
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                                <HeaderStyle CssClass="text-muted small text-end pe-4" />
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle CssClass="pagination-container" />
                    </asp:GridView>
                </div>
            </div>
            <div class="card-footer bg-white border-0 py-3">
                <small class="text-muted">Hiển thị trang số <span class="fw-bold"><%= gvSach.PageIndex + 1 %></span></small>
            </div>
        </div>
    </div>

    <style>
        /* Tinh chỉnh Header của GridView */
        .table thead { background-color: #f9fafb; text-transform: uppercase; letter-spacing: 0.05em; }
        
        /* Pagination Modern Style */
        .pagination-container table { margin: 0 auto; }
        .pagination-container td { border: none; }
        .pagination-container a, .pagination-container span {
            display: block;
            padding: 6px 14px;
            margin: 0 4px;
            border-radius: 50% !important;
            border: 1px solid #e5e7eb;
            text-decoration: none;
            color: #4b5563;
            font-size: 0.85rem;
            transition: all 0.2s;
        }
        .pagination-container span { background-color: #0d6efd !important; color: white !important; border-color: #0d6efd !important; }
        .pagination-container a:hover { background-color: #f3f4f6; color: #0d6efd; }

        /* Nút icon tròn */
        .btn-icon { width: 32px; height: 32px; padding: 0; line-height: 32px; border-radius: 50%; }
        
        /* Badge màu nhẹ nhàng */
        .bg-success-subtle { background-color: #d1fae5; }
        .text-success { color: #059669 !important; }
    </style>
</asp:Content>