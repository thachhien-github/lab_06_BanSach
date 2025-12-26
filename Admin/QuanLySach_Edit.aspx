<%@ Page Title="Chỉnh sửa sách" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="QuanLySach_Edit.aspx.cs" Inherits="lab_06_BanSach.Admin.QuanLySach_Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <div class="mb-4">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="QuanLySach.aspx" class="text-decoration-none">Quản lý sách</a></li>
                    <li class="breadcrumb-item active"><asp:Literal ID="ltrTitle" runat="server"></asp:Literal></li>
                </ol>
            </nav>
            <h4 class="fw-bold text-dark"><i class="fas fa-edit me-2 text-primary"></i>Thông tin chi tiết sách</h4>
        </div>

        <div class="row g-4">
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-body p-4">
                        <div class="row g-3">
                            <div class="col-12">
                                <label class="form-label fw-bold small text-muted text-uppercase">Tên sách</label>
                                <asp:TextBox ID="txtTenSach" runat="server" CssClass="form-control form-control-lg border-2" placeholder="Ví dụ: Đắc Nhân Tâm"></asp:TextBox>
                            </div>
                            
                            <div class="col-md-6">
                                <label class="form-label fw-bold small text-muted text-uppercase">Chủ đề</label>
                                <asp:DropDownList ID="ddlChuDe" runat="server" CssClass="form-select border-2"></asp:DropDownList>
                            </div>
                            
                            <div class="col-md-6">
                                <label class="form-label fw-bold small text-muted text-uppercase">Nhà xuất bản</label>
                                <asp:DropDownList ID="ddlNXB" runat="server" CssClass="form-select border-2"></asp:DropDownList>
                            </div>

                            <div class="col-12">
                                <label class="form-label fw-bold small text-muted text-uppercase">Mô tả nội dung</label>
                                <asp:TextBox ID="txtMoTa" runat="server" CssClass="form-control border-2" TextMode="MultiLine" Rows="8" placeholder="Viết một đoạn giới thiệu ngắn gọn về cuốn sách..."></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="card border-0 shadow-sm rounded-3 mb-4">
                    <div class="card-body p-4">
                        <label class="form-label fw-bold small text-muted text-uppercase">Giá bán (VNĐ)</label>
                        <div class="input-group mb-3">
                            <span class="input-group-text bg-light border-2 text-primary fw-bold">₫</span>
                            <asp:TextBox ID="txtGiaBan" runat="server" CssClass="form-control form-control-lg border-2 fw-bold text-danger" TextMode="Number"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="card border-0 shadow-sm rounded-3 mb-4">
                    <div class="card-header bg-white py-3 border-0">
                        <h6 class="mb-0 fw-bold">Ảnh bìa sản phẩm</h6>
                    </div>
                    <div class="card-body text-center p-4 pt-0">
                        <div class="mb-3 bg-light rounded-3 p-3 border-dashed border-2 text-center" style="border: 2px dashed #dee2e6;">
                            <asp:Image ID="imgHienTai" runat="server" CssClass="img-fluid rounded shadow-sm mb-3" style="max-height: 250px;" />
                            <asp:HiddenField ID="hfAnhCu" runat="server" />
                            <p class="text-muted small">Ảnh hiện tại</p>
                        </div>
                        <div class="text-start">
                            <label class="form-label fw-bold small text-muted text-uppercase">Thay đổi ảnh</label>
                            <asp:FileUpload ID="fuAnhBia" runat="server" CssClass="form-control form-control-sm" onchange="previewImage(this);" />
                        </div>
                    </div>
                </div>

                <div class="card border-0 shadow-sm rounded-3">
                    <div class="card-body d-grid gap-2 p-4">
                        <asp:Button ID="btnSave" runat="server" Text="Cập nhật sách" CssClass="btn btn-primary btn-lg fw-bold" OnClick="btnSave_Click" />
                        <a href="QuanLySach.aspx" class="btn btn-light border fw-bold text-muted">Hủy bỏ</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        // Script để xem trước ảnh ngay khi chọn file
        function previewImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    document.getElementById('<%= imgHienTai.ClientID %>').setAttribute('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</asp:Content>