<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ThanhToan.aspx.cs" Inherits="lab_06_BanSach.ThanhToan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-8">
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-white fw-bold text-primary">
                        <i class="fas fa-file-invoice me-2"></i>TÓM TẮT ĐƠN HÀNG
                    </div>
                    <div class="card-body">
                        <asp:GridView ID="gvTomTat" runat="server" AutoGenerateColumns="False" CssClass="table table-sm border-0">
                            <Columns>
                                <asp:BoundField DataField="TenSach" HeaderText="Tên sách" />
                                <asp:BoundField DataField="SoLuong" HeaderText="SL" ItemStyle-HorizontalAlign="Center" />
                                <asp:TemplateField HeaderText="Thành tiền" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate><%# Eval("ThanhTien", "{0:0,0}") %> đ</ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <hr />
                        <div class="text-end">
                            <h5 class="fw-bold">Tổng cộng: <asp:Label ID="lblTongTien" runat="server" CssClass="text-danger"></asp:Label> đ</h5>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-primary text-white fw-bold text-center">
                        THÔNG TIN GIAO HÀNG
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label class="form-label small fw-bold">Ngày giao dự kiến:</label>
                            <asp:TextBox ID="txtNgayGiao" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label small fw-bold">Ghi chú:</label>
                            <asp:TextBox ID="txtGhiChu" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Ví dụ: Giao giờ hành chính..."></asp:TextBox>
                        </div>
                        <div class="d-grid gap-2">
                            <asp:Button ID="btnXacNhan" runat="server" Text="XÁC NHẬN ĐẶT HÀNG" CssClass="btn btn-danger fw-bold shadow" OnClick="btnXacNhan_Click" />
                            <a href="GioHang.aspx" class="btn btn-outline-secondary btn-sm border-0 mt-2">Quay lại giỏ hàng</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
