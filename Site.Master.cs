using System;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;

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
                ltrTenKH.Text = Session["HoTenKH"].ToString();
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
            // Chuyển hướng về trang chủ kèm từ khóa tìm kiếm
            Response.Redirect("Default.aspx?search=" + Server.UrlEncode(keyword));
        }

        public string GetCartCount()
        {
            if (Session["GioHang"] != null)
            {
                DataTable dt = (DataTable)Session["GioHang"];
                // Sử dụng LINQ để tính tổng cột SoLuong
                return dt.AsEnumerable().Sum(row => row.Field<int>("SoLuong")).ToString();
            }
            return "0";
        }

        // Thêm sự kiện xử lý Đăng xuất
        protected void lbtnLogout_Click(object sender, EventArgs e)
        {
            // Xóa các Session liên quan đến người dùng
            Session.Remove("TenDN");
            Session.Remove("HoTenKH");
            Session.Remove("MaKH");

            // Chuyển hướng về trang chủ sau khi thoát
            Response.Redirect("Default.aspx");
        }
    }
}