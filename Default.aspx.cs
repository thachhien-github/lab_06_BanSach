using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace lab_06_BanSach
{
    public partial class Default : System.Web.UI.Page
    {
        string strCon = ConfigurationManager.ConnectionStrings["BookStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData(0); // Mặc định load trang đầu tiên
            }
        }

        private void BindData(int pageIndex)
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                string keyword = Request.QueryString["search"];
                // Lấy toàn bộ dữ liệu khớp với search để PagedDataSource tự chia trang
                string sql = "SELECT MaSach, TenSach, AnhBia, Dongia FROM Sach " +
                             "WHERE (@TenSach IS NULL OR TenSach LIKE '%' + @TenSach + '%') " +
                             "ORDER BY Ngaycapnhat DESC";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@TenSach", string.IsNullOrEmpty(keyword) ? (object)DBNull.Value : keyword);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Cấu hình phân trang
                PagedDataSource pds = new PagedDataSource();
                pds.DataSource = dt.DefaultView;
                pds.AllowPaging = true;
                pds.PageSize = 6; // Hiện 6 cuốn 1 trang
                pds.CurrentPageIndex = pageIndex;

                // Bind vào Repeater chính
                Repeater1.DataSource = pds;
                Repeater1.DataBind();

                // Tạo thanh số trang
                GeneratePager(pds.PageCount, pageIndex);
            }
        }

        private void GeneratePager(int totalPages, int currentPageIndex)
        {
            List<object> pages = new List<object>();
            if (totalPages > 1)
            {
                for (int i = 0; i < totalPages; i++)
                {
                    pages.Add(new { Text = (i + 1).ToString(), Value = i.ToString(), Active = (i == currentPageIndex) });
                }
            }
            rptPager.DataSource = pages;
            rptPager.DataBind();
        }

        protected void Page_Changed(object sender, EventArgs e)
        {
            int pageIndex = int.Parse((sender as LinkButton).CommandArgument);
            BindData(pageIndex);
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            string maSach = ((LinkButton)sender).CommandArgument;
            // Logic giỏ hàng...
            Response.Write("<script>alert('Đã thêm mã " + maSach + " vào giỏ!');</script>");
        }
    }
}