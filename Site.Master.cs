using System;
using System.Data;
using System.Web;

namespace lab_06_BanSach
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e) { }

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
                return dt.Rows.Count.ToString();
            }
            return "0";
        }
    }
}