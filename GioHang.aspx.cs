using System;
using System.Data;
using System.Linq;
using System.Web.UI.WebControls;

namespace lab_06_BanSach
{
    public partial class GioHang : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadGioHang();
            }
        }

        private void LoadGioHang()
        {
            if (Session["GioHang"] != null)
            {
                DataTable dt = (DataTable)Session["GioHang"];

                // Nếu giỏ hàng trống (sau khi xóa hết item) thì hiện thông báo trống
                if (dt.Rows.Count == 0)
                {
                    ShowEmptyCart();
                    return;
                }

                gvGioHang.DataSource = dt;
                gvGioHang.DataBind();

                // Tính tổng tiền bằng LINQ
                decimal tongTien = dt.AsEnumerable().Sum(row => row.Field<decimal>("ThanhTien"));
                lblTongTien.Text = string.Format("{0:0,0}", tongTien);

                // Hiển thị nút đặt hàng nếu có hàng
                btnDatHang.Visible = true;
            }
            else
            {
                ShowEmptyCart();
            }
        }

        private void ShowEmptyCart()
        {
            gvGioHang.DataSource = null;
            gvGioHang.DataBind();
            lblTongTien.Text = "0";
            btnDatHang.Visible = false; // Ẩn nút đặt hàng nếu không có gì để mua
        }

        protected void txtSoLuong_TextChanged(object sender, EventArgs e)
        {
            TextBox txt = (TextBox)sender;
            GridViewRow row = (GridViewRow)txt.NamingContainer;

            // Lấy MaSach từ DataKeys của GridView
            int maSach = (int)gvGioHang.DataKeys[row.RowIndex].Value;

            int soLuongMoi;
            if (!int.TryParse(txt.Text, out soLuongMoi) || soLuongMoi <= 0)
                soLuongMoi = 1;

            DataTable dt = (DataTable)Session["GioHang"];
            foreach (DataRow dr in dt.Rows)
            {
                if ((int)dr["MaSach"] == maSach)
                {
                    dr["SoLuong"] = soLuongMoi;
                    dr["ThanhTien"] = soLuongMoi * (decimal)dr["Dongia"];
                    break;
                }
            }
            Session["GioHang"] = dt;
            LoadGioHang();
        }

        protected void gvGioHang_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int maSach = (int)gvGioHang.DataKeys[e.RowIndex].Value;
            DataTable dt = (DataTable)Session["GioHang"];

            for (int i = dt.Rows.Count - 1; i >= 0; i--)
            {
                if ((int)dt.Rows[i]["MaSach"] == maSach)
                {
                    dt.Rows.RemoveAt(i);
                }
            }
            Session["GioHang"] = dt;
            LoadGioHang();
        }

        protected void btnDatHang_Click(object sender, EventArgs e)
        {
            // 1. Kiểm tra xem giỏ hàng có dữ liệu không
            if (Session["GioHang"] == null || ((DataTable)Session["GioHang"]).Rows.Count == 0)
            {
                Response.Write("<script>alert('Giỏ hàng của bạn đang trống!');</script>");
                return;
            }

            // 2. Kiểm tra đăng nhập
            if (Session["TenDN"] == null)
            {
                // Truyền kèm ReturnUrl để sau khi Login xong thì tự quay lại đây
                Response.Redirect("Login.aspx?ReturnUrl=ThanhToan.aspx");
            }
            else
            {
                // Nếu đã đăng nhập thì chuyển thẳng sang trang xác nhận thanh toán
                Response.Redirect("ThanhToan.aspx");
            }
        }
    }
}