<%@ Page Title="Lịch Sử Đơn Hàng" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LichSuDonHang.aspx.cs" Inherits="lab_06_BanSach.LichSuDonHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* Đồng bộ tiêu đề với trang Default */
        .section-title {
            font-weight: 700;
            letter-spacing: 1px;
            color: #2c3e50;
            position: relative;
            padding-bottom: 15px;
            text-transform: uppercase;
        }
        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 4px;
            background: #ff7e5f;
            border-radius: 2px;
        }

        /* Card container */
        .history-card {
            border-radius: 15px !important;
            border: none;
            overflow: hidden;
            background: #fff;
        }

        /* Style cho GridView */
        .table-custom {
            margin-bottom: 0;
        }
        .table-custom thead th {
            background-color: #f8f9fa;
            color: #2c3e50;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            border-top: none;
            padding: 15px;
        }
        .table-custom td {
            padding: 15px;
            color: #444;
            border-bottom: 1px solid #eee;
        }

        /* Badge trạng thái bo tròn */
        .badge-status {
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.8rem;
        }

        /* Nút xem chi tiết đồng bộ outline */
        .btn-view-detail {
            border-radius: 20px;
            font-weight: 600;
            transition: all 0.3s;
            border: 1px solid #2c3e50;
            color: #2c3e50;
        }
        .btn-view-detail:hover {
            background-color: #2c3e50;
            color: #fff;
            box-shadow: 0 4px 10px rgba(44, 62, 80, 0.2);
        }
    </style>

    <div class="container mt-5 mb-5">
        <h3 class="section-title mb-5">
            <i class="fas fa-history me-2" style="color: #ff7e5f;"></i>ĐƠN HÀNG CỦA BẠN
        </h3>

        <div class="card shadow-sm history-card">
            <div class="card-body p-0">
                <asp:GridView ID="gvLichSu" runat="server" AutoGenerateColumns="False"
                    CssClass="table table-custom table-hover align-middle" GridLines="None">
                    <Columns>
                        <asp:TemplateField HeaderText="Mã Đơn">
                            <ItemTemplate>
                                <span class="fw-bold">#<%# Eval("SoDH") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:BoundField DataField="NgayDH" HeaderText="Ngày Đặt" DataFormatString="{0:dd/MM/yyyy}" />
                        
                        <asp:TemplateField HeaderText="Tổng Tiền">
                            <ItemTemplate>
                                <span class="text-danger fw-bold"><%# Eval("Trigia", "{0:0,0}") %> đ</span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Trạng Thái">
                            <ItemTemplate>
                                <%# (bool)Eval("Dagiao") ? 
                                    "<span class='badge bg-success-subtle text-success border border-success-subtle badge-status'><i class='fas fa-check-circle me-1'></i>Đã giao</span>" : 
                                    "<span class='badge bg-warning-subtle text-dark border border-warning-subtle badge-status'><i class='fas fa-clock me-1'></i>Đang xử lý</span>" %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>
                                <a href='ChiTietDonHang.aspx?SoDH=<%# Eval("SoDH") %>' class="btn btn-sm btn-view-detail px-3">
                                    <i class="fas fa-eye me-1"></i>Chi tiết
                                </a>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    
                    <%-- Dòng hiển thị khi không có dữ liệu --%>
                    <EmptyDataTemplate>
                        <div class="text-center py-5">
                            <i class="fas fa-box-open fa-3x text-muted mb-3"></i>
                            <p class="text-muted">Bạn chưa có đơn hàng nào.</p>
                            <a href="Default.aspx" class="btn btn-cart rounded-pill px-4">Mua sắm ngay</a>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>