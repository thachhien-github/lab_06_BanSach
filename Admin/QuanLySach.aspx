<%@ Page Title="Quản Lý Kho Sách" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="QuanLySach.aspx.cs" Inherits="lab_06_BanSach.Admin.QuanLySach" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold text-primary"><i class="fas fa-book me-2"></i>QUẢN LÝ KHO SÁCH</h3>
            <a href="QuanLySach_Edit.aspx" class="btn btn-success shadow-sm">
                <i class="fas fa-plus me-1"></i> Thêm sách mới
            </a>
        </div>

        <div class="card shadow-sm border-0">
            <div class="card-body">
                <asp:GridView ID="gvSach" runat="server" AutoGenerateColumns="False"
                    CssClass="table table-hover align-middle" DataKeyNames="MaSach" OnRowCommand="gvSach_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="MaSach" HeaderText="ID" />
                        <asp:TemplateField HeaderText="Ảnh">
                            <ItemTemplate>
                                <img src='../Bia_sach/<%# Eval("AnhBia") %>' style="width: 50px; height: 70px; object-fit: cover;" class="rounded shadow-sm" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="TenSach" HeaderText="Tên sách" />
                        <asp:BoundField DataField="Dongia" HeaderText="Giá bán" DataFormatString="{0:N0} đ" />
                        <asp:BoundField DataField="Soluotxem" HeaderText="Lượt xem" />

                        <asp:TemplateField HeaderText="Thao tác">
                            <ItemTemplate>
                                <a href='<%# "QuanLySach_Edit.aspx?id=" + Eval("MaSach") %>' class="btn btn-sm btn-info text-white me-1">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteSach" CommandArgument='<%# Eval("MaSach") %>'
                                    CssClass="btn btn-sm btn-danger" OnClientClick="return confirm('Xác nhận xóa sách này?')">
                                    <i class="fas fa-trash"></i>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>