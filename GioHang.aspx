<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GioHang.aspx.cs" Inherits="lab_06_BanSach.GioHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h2 class="mb-4 text-primary fw-bold"><i class="fas fa-shopping-cart me-2"></i>GIỎ HÀNG CỦA BẠN</h2>
        
        <asp:GridView ID="gvGioHang" runat="server" AutoGenerateColumns="False" 
            CssClass="table table-hover table-bordered shadow-sm bg-white" 
            OnRowDeleting="gvGioHang_RowDeleting" DataKeyNames="MaSach">
            <Columns>
                <asp:TemplateField HeaderText="Ảnh">
                    <ItemTemplate>
                        <img src='<%# "Bia_sach/" + Eval("AnhBia") %>' width="60" class="rounded shadow-sm" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="100px" />
                </asp:TemplateField>

                <asp:BoundField DataField="TenSach" HeaderText="Tên Sách" />
                
                <asp:TemplateField HeaderText="Đơn Giá">
                    <ItemTemplate>
                        <%# Eval("Dongia", "{0:0,0}") %> đ
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" Width="120px" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Số Lượng">
                    <ItemTemplate>
                        <asp:TextBox ID="txtSoLuong" runat="server" Text='<%# Eval("SoLuong") %>' 
                            TextMode="Number" CssClass="form-control form-control-sm text-center mx-auto" 
                            Width="70px" AutoPostBack="true" OnTextChanged="txtSoLuong_TextChanged"></asp:TextBox>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="100px" />
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Thành Tiền">
                    <ItemTemplate>
                        <span class="fw-bold text-danger"><%# Eval("ThanhTien", "{0:0,0}") %> đ</span>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" Width="150px" />
                </asp:TemplateField>

                <asp:CommandField ShowDeleteButton="True" DeleteText="<i class='fas fa-trash-alt'></i> Xóa" 
                    ControlStyle-CssClass="btn btn-sm btn-outline-danger" HeaderText="Thao tác" />
            </Columns>
            <EmptyDataTemplate>
                <div class="alert alert-warning text-center py-5">
                    <h5>Giỏ hàng đang trống!</h5>
                    <a href="Default.aspx" class="btn btn-primary mt-3">Tiếp tục mua sắm</a>
                </div>
            </EmptyDataTemplate>
        </asp:GridView>

        <div class="row mt-4 align-items-center bg-light p-3 rounded shadow-sm">
            <div class="col-md-6 text-start">
                <a href="Default.aspx" class="btn btn-outline-secondary"><i class="fas fa-arrow-left me-1"></i>Tiếp tục mua hàng</a>
            </div>
            <div class="col-md-6 text-end">
                <h4 class="mb-3">Tổng tiền: <asp:Label ID="lblTongTien" runat="server" CssClass="text-danger fw-bold" Text="0"></asp:Label> đ</h4>
                <asp:Button ID="btnDatHang" runat="server" Text="TIẾN HÀNH ĐẶT HÀNG" CssClass="btn btn-danger btn-lg px-5 shadow" OnClick="btnDatHang_Click" />
            </div>
        </div>
    </div>
</asp:Content>
