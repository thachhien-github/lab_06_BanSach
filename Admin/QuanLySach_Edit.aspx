<%@ Page Title="Chỉnh sửa sách" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="QuanLySach_Edit.aspx.cs" Inherits="lab_06_BanSach.Admin.QuanLySach_Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <div class="card shadow border-0">
            <div class="card-header bg-primary text-white">
                <h4 class="mb-0"><asp:Literal ID="ltrTitle" runat="server"></asp:Literal></h4>
            </div>
            <div class="card-body">
                <div class="row g-3">
                    <div class="col-md-8">
                        <label class="form-label fw-bold">Tên sách</label>
                        <asp:TextBox ID="txtTenSach" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-bold">Giá bán</label>
                        <asp:TextBox ID="txtGiaBan" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold">Chủ đề</label>
                        <asp:DropDownList ID="ddlChuDe" runat="server" CssClass="form-select"></asp:DropDownList>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold">Nhà xuất bản</label>
                        <asp:DropDownList ID="ddlNXB" runat="server" CssClass="form-select"></asp:DropDownList>
                    </div>
                    <div class="col-12">
                        <label class="form-label fw-bold">Mô tả</label>
                        <asp:TextBox ID="txtMoTa" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5"></asp:TextBox>
                    </div>
                    <div class="col-md-12">
                        <label class="form-label fw-bold">Ảnh bìa</label>
                        <asp:FileUpload ID="fuAnhBia" runat="server" CssClass="form-control" />
                        <div class="mt-2">
                            <asp:Image ID="imgHienTai" runat="server" Width="100px" CssClass="rounded border" />
                            <asp:HiddenField ID="hfAnhCu" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-footer bg-light d-flex justify-content-end">
                <a href="QuanLySach.aspx" class="btn btn-secondary me-2">Quay lại</a>
                <asp:Button ID="btnSave" runat="server" Text="Lưu dữ liệu" CssClass="btn btn-primary" OnClick="btnSave_Click" />
            </div>
        </div>
    </div>
</asp:Content>