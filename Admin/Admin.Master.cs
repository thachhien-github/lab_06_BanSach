using System;
using System.Web;

namespace lab_06_BanSach.Admin
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Kiểm tra quyền Admin
            // Giả sử admin là người có TenDN = 'admin' hoặc Session["IsAdmin"]
            if (Session["TenDN"] == null || Session["TenDN"].ToString().ToLower() != "admin")
            {
                // Nếu không phải admin, đá về trang Login của người dùng
                Response.Redirect("../Login.aspx");
            }

            if (!IsPostBack)
            {
                ltrAdminName.Text = Session["HoTenKH"] != null ? Session["HoTenKH"].ToString() : "Quản trị viên";
            }
        }

        protected void lbtnThoat_Click(object sender, EventArgs e)
        {
            // Xóa session và thoát
            Session.Abandon();
            Response.Redirect("../Default.aspx");
        }
    }
}