<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="lab_06_BanSach.Admin.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <h3 class="fw-bold mb-4 text-dark">TỔNG QUAN HỆ THỐNG</h3>
        
        <div class="row g-4">
            <div class="col-md-3">
                <div class="card border-0 shadow-sm bg-primary text-white p-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-uppercase small">Doanh thu</h6>
                            <h3 class="fw-bold mb-0"><asp:Literal ID="ltrDoanhThu" runat="server"></asp:Literal> đ</h3>
                        </div>
                        <i class="fas fa-dollar-sign fa-2x opacity-50"></i>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="card border-0 shadow-sm bg-success text-white p-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-uppercase small">Đơn hàng</h6>
                            <h3 class="fw-bold mb-0"><asp:Literal ID="ltrDonHang" runat="server"></asp:Literal></h3>
                        </div>
                        <i class="fas fa-shopping-bag fa-2x opacity-50"></i>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="card border-0 shadow-sm bg-warning text-dark p-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-uppercase small">Khách hàng</h6>
                            <h3 class="fw-bold mb-0"><asp:Literal ID="ltrKhachHang" runat="server"></asp:Literal></h3>
                        </div>
                        <i class="fas fa-users fa-2x opacity-50"></i>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="card border-0 shadow-sm bg-danger text-white p-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-uppercase small">Đầu sách</h6>
                            <h3 class="fw-bold mb-0"><asp:Literal ID="ltrTongSach" runat="server"></asp:Literal></h3>
                        </div>
                        <i class="fas fa-book fa-2x opacity-50"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-5">
            <div class="col-md-12">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white fw-bold">ĐƠN HÀNG MỚI NHẤT</div>
                    <div class="card-body p-0">
                        <asp:GridView ID="gvMoiNhat" runat="server" AutoGenerateColumns="False" CssClass="table table-hover mb-0">
                            <Columns>
                                <asp:BoundField DataField="SoDH" HeaderText="Mã đơn" />
                                <asp:BoundField DataField="HoTenKH" HeaderText="Khách hàng" />
                                <asp:BoundField DataField="NgayDH" HeaderText="Ngày đặt" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                                <asp:TemplateField HeaderText="Trị giá">
                                    <ItemTemplate><%# Eval("Trigia", "{0:0,0}") %> đ</ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
