<%@ Page Title="Xác Nhận Thanh Toán" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ThanhToan.aspx.cs" Inherits="lab_06_BanSach.ThanhToan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .checkout-container {
            background-color: #f4f7f6;
            border-radius: 15px;
            padding: 30px;
        }
        .checkout-card {
            border: none;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }
        .card-header-custom {
            background: #ffffff;
            border-bottom: 2px solid #f1f1f1;
            padding: 15px 20px;
        }
        .table-summary {
            margin-bottom: 0;
        }
        .table-summary th {
            background-color: #f8f9fa;
            color: #6c757d;
            font-size: 0.8rem;
            text-transform: uppercase;
            border: none;
        }
        .table-summary td {
            vertical-align: middle;
            border-top: 1px solid #f1f1f1;
            padding: 12px;
        }
        .info-delivery-header {
            background: linear-gradient(135deg, #2c3e50, #4ca1af);
            color: white;
            font-weight: 600;
        }
        .btn-confirm {
            background: linear-gradient(135deg, #ff7e5f, #feb47b);
            border: none;
            color: white;
            padding: 12px;
            transition: 0.3s;
        }
        .btn-confirm:hover {
            background: linear-gradient(135deg, #e74c3c, #ff7e5f);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 126, 95, 0.4);
            color: white;
        }
        .total-price {
            font-size: 1.4rem;
            color: #e74c3c;
            font-weight: 800;
        }
    </style>

    <div class="container mt-5 mb-5">
        <div class="row checkout-container shadow-sm">
            <div class="col-md-8">
                <h4 class="mb-4 fw-bold text-dark"><i class="fas fa-check-double me-2 text-success"></i>Kiểm tra đơn hàng</h4>
                <div class="card checkout-card">
                    <div class="card-header-custom d-flex justify-content-between align-items-center">
                        <span class="fw-bold text-primary">Sản phẩm của bạn</span>
                        <span class="badge bg-secondary">Tạm tính</span>
                    </div>
                    <div class="card-body p-0">
                        <asp:GridView ID="gvTomTat" runat="server" AutoGenerateColumns="False" 
                            CssClass="table table-summary" GridLines="None">
                            <Columns>
                                <asp:BoundField DataField="TenSach" HeaderText="Tên sách" HeaderStyle-CssClass="ps-4" ItemStyle-CssClass="ps-4 fw-bold" />
                                <asp:BoundField DataField="SoLuong" HeaderText="Số lượng" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                                <asp:TemplateField HeaderText="Thành tiền" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" ItemStyle-CssClass="pe-4">
                                    <ItemTemplate>
                                        <span class="text-dark"><%# Eval("ThanhTien", "{0:0,0}") %> đ</span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        
                        <div class="p-4 bg-light text-end border-top">
                            <span class="text-muted me-2">Thành tiền tất cả:</span>
                            <span class="total-price"><asp:Label ID="lblTongTien" runat="server"></asp:Label> đ</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <h4 class="mb-4 fw-bold text-dark"><i class="fas fa-shipping-fast me-2 text-primary"></i>Giao hàng</h4>
                <div class="card checkout-card">
                    <div class="card-header info-delivery-header text-center py-3">
                        HÌNH THỨC NHẬN HÀNG
                    </div>
                    <div class="card-body p-4">
                        <div class="mb-3">
                            <label class="form-label small fw-bold text-muted uppercase">Ngày nhận mong muốn</label>
                            <div class="input-group">
                                <span class="input-group-text bg-white border-end-0 text-muted"><i class="far fa-calendar-alt"></i></span>
                                <asp:TextBox ID="txtNgayGiao" runat="server" CssClass="form-control border-start-0 ps-0" TextMode="Date"></asp:TextBox>
                            </div>
                        </div>
                        <div class="mb-4">
                            <label class="form-label small fw-bold text-muted uppercase">Ghi chú cho shipper</label>
                            <asp:TextBox ID="txtGhiChu" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" 
                                placeholder="Ví dụ: Giao ở cổng sau, gọi trước 15 phút..."></asp:TextBox>
                        </div>
                        
                        <div class="d-grid gap-2">
                            <asp:Button ID="btnXacNhan" runat="server" Text="HOÀN TẤT ĐẶT HÀNG" 
                                CssClass="btn btn-confirm rounded-pill fw-bold shadow-sm" OnClick="btnXacNhan_Click" />
                            <a href="GioHang.aspx" class="btn btn-outline-secondary btn-sm border-0 mt-2">
                                <i class="fas fa-chevron-left me-1"></i>Thay đổi giỏ hàng
                            </a>
                        </div>
                    </div>
                    <div class="card-footer bg-white text-center py-3 border-0">
                        <img src="https://cdn-icons-png.flaticon.com/512/349/349221.png" height="20" class="me-2 opacity-50" title="Visa" />
                        <img src="https://cdn-icons-png.flaticon.com/512/349/349228.png" height="20" class="me-2 opacity-50" title="Mastercard" />
                        <img src="https://cdn-icons-png.flaticon.com/512/1554/1554401.png" height="20" class="opacity-50" title="COD" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>