using System;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace lab_06_BanSach
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Kiểm tra trạng thái đăng nhập mỗi khi trang được tải
            if (Session["TenDN"] != null)
            {
                // Nếu đã đăng nhập: Hiện vùng Chào khách, ẩn nút Đăng nhập
                phAnonymous.Visible = false;
                phLoggedIn.Visible = true;

                // Kiểm tra xem có phải là Admin hay không để hiển thị tên đặc biệt
                string hoTen = Session["HoTenKH"].ToString();
                if (Session["TenDN"].ToString().ToLower() == "admin")
                {
                    ltrTenKH.Text = hoTen + " (Admin)";
                }
                else
                {
                    ltrTenKH.Text = hoTen;
                }
            }
            else
            {
                // Nếu chưa đăng nhập: Hiện nút Đăng nhập, ẩn vùng Chào khách
                phAnonymous.Visible = true;
                phLoggedIn.Visible = false;
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string keyword = txtSearch.Text.Trim();
            if (!string.IsNullOrEmpty(keyword))
            {
                // Chuyển hướng về trang chủ kèm từ khóa tìm kiếm
                Response.Redirect("Default.aspx?search=" + Server.UrlEncode(keyword));
            }
        }

        // Hàm được gọi từ giao diện .aspx để hiển thị số lượng trên Badge giỏ hàng
        public string GetCartCount()
        {
            if (Session["GioHang"] != null)
            {
                DataTable dt = (DataTable)Session["GioHang"];
                if (dt.Rows.Count > 0)
                {
                    // Sử dụng LINQ để tính tổng cột SoLuong trong DataTable
                    int total = dt.AsEnumerable().Sum(row => row.Field<int>("SoLuong"));
                    return total.ToString();
                }
            }
            return "0";
        }

        // Xử lý khi nhấn nút Đăng xuất
        protected void lbtnLogout_Click(object sender, EventArgs e)
        {
            // Hủy toàn bộ Session (MaKH, TenDN, HoTenKH, GioHang...)
            Session.Abandon();
            Session.Clear();

            // Chuyển hướng về trang chủ sau khi thoát
            Response.Redirect("Default.aspx");
        }
    }
}