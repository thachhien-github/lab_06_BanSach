<%@ Page Title="Tổng Quan Hệ Thống" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="lab_06_BanSach.Admin.Dashboard" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <div class="container-fluid">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h4 class="fw-bold text-dark mb-0"><i class="fas fa-chart-line me-2 text-primary"></i>Báo cáo doanh thu</h4>
            <div class="d-flex align-items-center gap-2 bg-white p-2 rounded shadow-sm">
                <div class="input-group input-group-sm" style="width: auto;">
                    <span class="input-group-text bg-light border-end-0">Từ</span>
                    <asp:TextBox ID="txtTuNgay" runat="server" CssClass="form-control border-start-0" TextMode="Date"></asp:TextBox>
                </div>
                <div class="input-group input-group-sm" style="width: auto;">
                    <span class="input-group-text bg-light border-end-0">Đến</span>
                    <asp:TextBox ID="txtDenNgay" runat="server" CssClass="form-control border-start-0" TextMode="Date"></asp:TextBox>
                </div>
                <asp:Button ID="btnLoc" runat="server" Text="Lọc" CssClass="btn btn-sm btn-primary px-3" OnClick="btnLoc_Click" />
                <asp:LinkButton ID="btnExportExcel" runat="server" CssClass="btn btn-sm btn-outline-success px-3" OnClick="btnExportExcel_Click">
                    <i class="fas fa-file-excel me-1"></i> Excel
                </asp:LinkButton>
            </div>
        </div>

        <div class="row g-4 mb-4">
            <div class="col-md-3">
                <div class="card border-0 shadow-sm overflow-hidden border-start border-primary border-4">
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h6 class="text-muted small text-uppercase fw-bold">Doanh thu</h6>
                                <h3 class="fw-bold mb-0 text-primary"><asp:Literal ID="ltrDoanhThu" runat="server"></asp:Literal> đ</h3>
                            </div>
                            <div class="bg-primary bg-opacity-10 p-3 rounded-circle">
                                <i class="fas fa-dollar-sign text-primary fa-lg"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card border-0 shadow-sm overflow-hidden border-start border-success border-4">
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h6 class="text-muted small text-uppercase fw-bold">Đơn hàng</h6>
                                <h3 class="fw-bold mb-0 text-success"><asp:Literal ID="ltrDonHang" runat="server"></asp:Literal></h3>
                            </div>
                            <div class="bg-success bg-opacity-10 p-3 rounded-circle">
                                <i class="fas fa-shopping-basket text-success fa-lg"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card border-0 shadow-sm overflow-hidden border-start border-warning border-4">
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h6 class="text-muted small text-uppercase fw-bold">Khách hàng</h6>
                                <h3 class="fw-bold mb-0 text-warning"><asp:Literal ID="ltrKhachHang" runat="server"></asp:Literal></h3>
                            </div>
                            <div class="bg-warning bg-opacity-10 p-3 rounded-circle">
                                <i class="fas fa-user-friends text-warning fa-lg"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card border-0 shadow-sm overflow-hidden border-start border-danger border-4">
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h6 class="text-muted small text-uppercase fw-bold">Đầu sách</h6>
                                <h3 class="fw-bold mb-0 text-danger"><asp:Literal ID="ltrTongSach" runat="server"></asp:Literal></h3>
                            </div>
                            <div class="bg-danger bg-opacity-10 p-3 rounded-circle">
                                <i class="fas fa-book text-danger fa-lg"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-8">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-header bg-transparent border-0 py-3">
                        <h6 class="fw-bold mb-0 text-dark">XU HƯỚNG DOANH THU (7 NGÀY GẦN NHẤT)</h6>
                    </div>
                    <div class="card-body">
                        <canvas id="revenueChart" style="height: 300px;"></canvas>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-header bg-transparent border-0 py-3 d-flex justify-content-between">
                        <h6 class="fw-bold mb-0 text-dark">ĐƠN MỚI NHẤT</h6>
                        <a href="QuanLyDonHang.aspx" class="small text-primary text-decoration-none">Xem tất cả</a>
                    </div>
                    <div class="card-body p-0">
                        <asp:GridView ID="gvMoiNhat" runat="server" AutoGenerateColumns="False" 
                            CssClass="table table-hover align-middle mb-0" GridLines="None" ShowHeader="false">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div class="d-flex align-items-center px-3 py-2">
                                            <div class="avatar-sm bg-light rounded-circle text-center p-2 me-3" style="width: 40px; height: 40px;">
                                                <i class="fas fa-shopping-cart text-muted small"></i>
                                            </div>
                                            <div class="flex-grow-1">
                                                <div class="fw-bold text-dark small"><%# Eval("HoTenKH") %></div>
                                                <div class="text-muted" style="font-size: 0.75rem;">Mã đơn: #<%# Container.DataItemIndex + 1000 %></div>
                                            </div>
                                            <div class="text-end fw-bold text-success small">
                                                <%# Eval("Trigia", "{0:N0}") %> đ
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const ctx = document.getElementById('revenueChart').getContext('2d');
            const chartLabels = [<%= chartLabels %>];
            const chartData = [<%= chartData %>];

            new Chart(ctx, {
                type: 'line',
                data: {
                    labels: chartLabels,
                    datasets: [{
                        label: 'Doanh thu (đ)',
                        data: chartData,
                        borderColor: '#0d6efd',
                        backgroundColor: 'rgba(13, 110, 253, 0.08)',
                        borderWidth: 3,
                        pointBackgroundColor: '#fff',
                        pointBorderColor: '#0d6efd',
                        pointHoverRadius: 6,
                        fill: true,
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { display: false },
                        tooltip: { backgroundColor: '#212529', padding: 10 }
                    },
                    scales: {
                        y: { beginAtZero: true, grid: { borderDash: [5, 5] } },
                        x: { grid: { display: false } }
                    }
                }
            });
        });
    </script>
</asp:Content>