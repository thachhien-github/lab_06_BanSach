<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LichSuDonHang.aspx.cs" Inherits="lab_06_BanSach.LichSuDonHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h3 class="fw-bold mb-4"><i class="fas fa-history me-2 text-primary"></i>ĐƠN HÀNG CỦA BẠN</h3>

        <div class="card shadow-sm border-0">
            <div class="card-body">
                <asp:GridView ID="gvLichSu" runat="server" AutoGenerateColumns="False"
                    CssClass="table table-hover align-middle" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="SoDH" HeaderText="Mã Đơn" />
                        <asp:BoundField DataField="NgayDH" HeaderText="Ngày Đặt" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:TemplateField HeaderText="Tổng Tiền">
                            <ItemTemplate>
                                <span class="fw-bold text-danger"><%# Eval("Trigia", "{0:0,0}") %> đ</span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Trạng Thái">
                            <ItemTemplate>
                                <%# (bool)Eval("Dagiao") ? 
                    "<span class='badge bg-success'>Đã giao</span>" : 
                    "<span class='badge bg-warning text-dark'>Đang xử lý</span>" %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%-- Cột mới thêm vào ở đây --%>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <a href='ChiTietDonHang.aspx?SoDH=<%# Eval("SoDH") %>' class="btn btn-outline-primary btn-sm">
                                    <i class="fas fa-eye me-1"></i>Xem chi tiết
                                </a>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
