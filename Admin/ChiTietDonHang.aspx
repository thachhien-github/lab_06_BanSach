<%@ Page Title="Chi Tiết Đơn Hàng" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ChiTietDonHang.aspx.cs" Inherits="lab_06_BanSach.Admin.ChiTietDonHang" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h4 class="fw-bold text-dark mb-1">
                    <i class="fas fa-file-invoice me-2 text-primary"></i>ĐƠN HÀNG #<asp:Label ID="lblMaDH" runat="server" />
                </h4>
                <p class="text-muted small mb-0">Xem chi tiết sản phẩm và thông tin khách hàng</p>
            </div>
            <a href="QuanLyDonHang.aspx" class="btn btn-sm btn-outline-secondary px-3 shadow-sm">
                <i class="fas fa-arrow-left me-1"></i> Quay lại danh sách
            </a>
        </div>

        <div class="row g-4">
            <div class="col-md-4">
                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-header bg-white py-3">
                        <h6 class="mb-0 fw-bold text-dark"><i class="fas fa-user-tag me-2 text-primary"></i>Thông tin giao hàng</h6>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label class="text-muted small text-uppercase fw-bold d-block">Khách hàng</label>
                            <span class="fw-bold text-dark fs-5"><asp:Label ID="lblTenKH" runat="server" /></span>
                        </div>
                        <div class="mb-3">
                            <label class="text-muted small text-uppercase fw-bold d-block">Số điện thoại</label>
                            <span class="text-dark"><i class="fas fa-phone-alt me-2 text-muted"></i><asp:Label ID="lblSDT" runat="server" /></span>
                        </div>
                        <div class="mb-0">
                            <label class="text-muted small text-uppercase fw-bold d-block">Địa chỉ nhận hàng</label>
                            <span class="text-dark"><i class="fas fa-map-marker-alt me-2 text-muted"></i><asp:Label ID="lblDiaChi" runat="server" /></span>
                        </div>
                    </div>
                    <div class="card-footer bg-light border-0 py-3">
                        <div class="d-grid">
                            <asp:Button ID="btnXacNhan" runat="server" Text="Xác nhận đã giao & Thanh toán" 
                                CssClass="btn btn-success fw-bold shadow-sm" OnClick="btnXacNhan_Click" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-8">
                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-header bg-white py-3 d-flex justify-content-between">
                        <h6 class="mb-0 fw-bold text-dark">Sản phẩm trong đơn</h6>
                        <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-3">Hóa đơn bán lẻ</span>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <asp:GridView ID="gvChiTiet" runat="server" AutoGenerateColumns="False" 
                                CssClass="table table-hover align-middle mb-0" GridLines="None">
                                <HeaderStyle CssClass="bg-light text-muted small text-uppercase fw-bold border-bottom" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Sản phẩm">
                                        <ItemTemplate>
                                            <div class="fw-bold text-dark ps-3 py-2"><%# Eval("TenSach") %></div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:BoundField DataField="Soluong" HeaderText="SL" ItemStyle-CssClass="text-center fw-bold" HeaderStyle-CssClass="text-center" />
                                    
                                    <asp:BoundField DataField="Dongia" HeaderText="Đơn giá" DataFormatString="{0:N0} đ" 
                                        ItemStyle-CssClass="text-end text-muted" HeaderStyle-CssClass="text-end" />
                                    
                                    <asp:TemplateField HeaderText="Thành tiền">
                                        <HeaderStyle CssClass="text-end pe-4" />
                                        <ItemTemplate>
                                            <div class="text-end pe-4 fw-bold text-primary">
                                                <%# string.Format("{0:N0} đ", Convert.ToDouble(Eval("Soluong")) * Convert.ToDouble(Eval("Dongia"))) %>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                    <div class="card-footer bg-white border-top-0 p-4">
                        <div class="row justify-content-end">
                            <div class="col-md-5">
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Tạm tính:</span>
                                    <span class="text-dark"><asp:Label ID="lblTamTinh" runat="server" Text="0" /> đ</span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Phí vận chuyển:</span>
                                    <span class="text-success fw-bold">Miễn phí</span>
                                </div>
                                <hr />
                                <div class="d-flex justify-content-between align-items-center">
                                    <h6 class="fw-bold mb-0 text-dark">TỔNG CỘNG:</h6>
                                    <h4 class="text-danger fw-bold mb-0"><asp:Label ID="lblTongTien" runat="server" /></h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <style>
        /* Tinh chỉnh bảng chi tiết */
        .table thead th { border-top: none; }
        .bg-primary-subtle { background-color: #eef2ff; }
        .text-primary { color: #4338ca !important; }
        
        /* Card styling */
        .card-header { border-bottom: 1px solid #f1f5f9; }
        .form-label { margin-bottom: 0.2rem; }
    </style>
</asp:Content>