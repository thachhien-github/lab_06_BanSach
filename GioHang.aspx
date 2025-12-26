<%@ Page Title="Giỏ Hàng" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GioHang.aspx.cs" Inherits="lab_06_BanSach.GioHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .cart-container {
            background-color: #f8f9fa;
            border-radius: 20px;
            padding: 30px;
        }
        .table-cart {
            border-radius: 15px;
            overflow: hidden;
            border: none !important;
        }
        .table-cart thead {
            background: #2c3e50;
            color: white;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 1px;
        }
        .table-cart th, .table-cart td {
            vertical-align: middle !important;
            padding: 15px !important;
        }
        .qty-input {
            border-radius: 10px;
            border: 1px solid #dee2e6;
            transition: all 0.3s;
        }
        .qty-input:focus {
            border-color: #ff7e5f;
            box-shadow: 0 0 0 0.2rem rgba(255, 126, 95, 0.25);
        }
        .summary-box {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        }
        .btn-checkout {
            background: linear-gradient(135deg, #ff7e5f, #feb47b);
            border: none;
            color: white;
            font-weight: 700;
            letter-spacing: 1px;
            transition: 0.3s;
        }
        .btn-checkout:hover {
            background: linear-gradient(135deg, #e74c3c, #ff7e5f);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 126, 95, 0.4);
            color: white;
        }
        .empty-cart-icon {
            font-size: 4rem;
            color: #dee2e6;
            margin-bottom: 20px;
        }
    </style>

    <div class="container mt-5 mb-5 cart-container shadow-sm">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-dark fw-bold m-0"><i class="fas fa-shopping-bag me-3 text-coral" style="color:#ff7e5f;"></i>Giỏ Hàng</h2>
            <span class="badge bg-dark rounded-pill px-3 py-2">Sản phẩm trong giỏ</span>
        </div>
        
        <div class="table-responsive">
            <asp:GridView ID="gvGioHang" runat="server" AutoGenerateColumns="False" 
                CssClass="table table-cart bg-white shadow-sm" 
                OnRowDeleting="gvGioHang_RowDeleting" DataKeyNames="MaSach" GridLines="None">
                <Columns>
                    <asp:TemplateField HeaderText="Sản phẩm">
                        <ItemTemplate>
                            <div class="d-flex align-items-center">
                                <img src='<%# "Bia_sach/" + Eval("AnhBia") %>' width="70" class="rounded shadow-sm me-3" />
                                <span class="fw-bold text-dark"><%# Eval("TenSach") %></span>
                            </div>
                        </ItemTemplate>
                        <ItemStyle Width="40%" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Đơn giá">
                        <ItemTemplate>
                            <span class="text-muted"><%# Eval("Dongia", "{0:0,0}") %> đ</span>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Số lượng">
                        <ItemTemplate>
                            <asp:TextBox ID="txtSoLuong" runat="server" Text='<%# Eval("SoLuong") %>' 
                                TextMode="Number" CssClass="form-control qty-input text-center mx-auto" 
                                Width="80px" AutoPostBack="true" OnTextChanged="txtSoLuong_TextChanged"></asp:TextBox>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Thành tiền">
                        <ItemTemplate>
                            <span class="fw-bold text-danger"><%# Eval("ThanhTien", "{0:0,0}") %> đ</span>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Xóa">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" 
                                CssClass="btn btn-link text-danger p-0" OnClientClick="return confirm('Xóa sách này khỏi giỏ?');">
                                <i class='fas fa-trash-alt fs-5'></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="text-center py-5">
                        <i class="fas fa-cart-arrow-down empty-cart-icon"></i>
                        <h4 class="text-muted">Giỏ hàng của bạn đang trống!</h4>
                        <p class="mb-4">Hãy chọn cho mình những cuốn sách yêu thích nhé.</p>
                        <a href="Default.aspx" class="btn btn-dark btn-lg rounded-pill px-5">Quay lại cửa hàng</a>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>

        <div class="row mt-5 justify-content-end">
            <div class="col-md-5">
                <div class="summary-box">
                    <div class="d-flex justify-content-between mb-3">
                        <span class="text-muted">Tạm tính:</span>
                        <span class="fw-bold"><asp:Label ID="lblTamTinh" runat="server" Text="0"></asp:Label> đ</span>
                    </div>
                    <div class="d-flex justify-content-between mb-4 border-bottom pb-3">
                        <span class="text-muted">Phí vận chuyển:</span>
                        <span class="text-success fw-bold">Miễn phí</span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4 class="m-0 fw-bold">Tổng cộng:</h4>
                        <h3 class="m-0 text-danger fw-bold"><asp:Label ID="lblTongTien" runat="server" Text="0"></asp:Label> đ</h3>
                    </div>
                    <div class="d-grid gap-2">
                        <asp:Button ID="btnDatHang" runat="server" Text="TIẾN HÀNH THANH TOÁN" 
                            CssClass="btn btn-checkout btn-lg rounded-pill" OnClick="btnDatHang_Click" />
                        <a href="Default.aspx" class="btn btn-link text-muted mt-2">
                            <i class="fas fa-chevron-left me-2"></i>Tiếp tục mua hàng
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>