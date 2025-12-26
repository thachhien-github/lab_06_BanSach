<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ChiTietDonHang.aspx.cs" Inherits="lab_06_BanSach.ChiTietDonHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="LichSuDonHang.aspx">Lịch sử</a></li>
                <li class="breadcrumb-item active">Đơn hàng #<asp:Literal ID="ltrSoDH" runat="server"></asp:Literal></li>
            </ol>
        </nav>

        <div class="card shadow-sm border-0">
            <div class="card-header bg-white py-3">
                <h5 class="mb-0 fw-bold text-primary">DANH SÁCH SẢN PHẨM</h5>
            </div>
            <div class="card-body p-0">
                <asp:GridView ID="gvChiTiet" runat="server" AutoGenerateColumns="False" CssClass="table table-hover mb-0 align-middle">
                    <Columns>
                        <asp:TemplateField HeaderText="Sản phẩm">
                            <ItemTemplate>
                                <div class="d-flex align-items-center">
                                    <img src='Bia_sach/<%# Eval("AnhBia") %>' style="width:50px; height:70px; object-fit:cover;" class="me-3 rounded shadow-sm" />
                                    <span class="fw-bold"><%# Eval("TenSach") %></span>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Soluong" HeaderText="Số lượng" ItemStyle-HorizontalAlign="Center" />
                        <asp:TemplateField HeaderText="Đơn giá" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate><%# Eval("Dongia", "{0:0,0}") %> đ</ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Thành tiền" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>
                                <span class="text-danger fw-bold"><%# Eval("Thanhtien", "{0:0,0}") %> đ</span>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
            <div class="card-footer bg-light text-end py-3">
                <h5 class="fw-bold mb-0">Tổng giá trị: <span class="text-danger"><asp:Literal ID="ltrTongTien" runat="server"></asp:Literal> đ</span></h5>
            </div>
        </div>
    </div>
</asp:Content>
