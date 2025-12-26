using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace lab_06_BanSach
{
    public partial class SachTheoChuDe : System.Web.UI.Page
    {
        string strCon = ConfigurationManager.ConnectionStrings["BookStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Load dữ liệu trang đầu tiên (index 0)
                BindData(0);
            }
        }

        private void BindData(int pageIndex)
        {
            string maCD = Request.QueryString["MaCD"];
            if (string.IsNullOrEmpty(maCD))
            {
                Response.Redirect("Default.aspx");
                return;
            }

            using (SqlConnection con = new SqlConnection(strCon))
            {
                // 1. Lấy tên chủ đề để hiển thị tiêu đề trang
                SqlCommand cmdTitle = new SqlCommand("SELECT Tenchude FROM ChuDe WHERE MaCD = @MaCD", con);
                cmdTitle.Parameters.AddWithValue("@MaCD", maCD);
                con.Open();
                object title = cmdTitle.ExecuteScalar();
                ltrTenChuDe.Text = title != null ? title.ToString() : "Danh mục sách";
                con.Close();

                // 2. Lấy danh sách sách thuộc chủ đề (kết hợp logic ORDER BY mới nhất)
                string sql = "SELECT MaSach, TenSach, AnhBia, Dongia FROM Sach " +
                             "WHERE MaCD = @MaCD " +
                             "ORDER BY Ngaycapnhat DESC";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@MaCD", maCD);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // 3. Cấu hình phân trang PagedDataSource
                PagedDataSource pds = new PagedDataSource();
                pds.DataSource = dt.DefaultView;
                pds.AllowPaging = true;
                pds.PageSize = 6; // Hiển thị 6 cuốn trên mỗi trang
                pds.CurrentPageIndex = pageIndex;

                // Bind dữ liệu vào Repeater chính (nhớ ID phải khớp với file .aspx)
                rptSachTheoCD.DataSource = pds;
                rptSachTheoCD.DataBind();

                // 4. Tạo thanh phân trang
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
                    pages.Add(new
                    {
                        Text = (i + 1).ToString(),
                        Value = i.ToString(),
                        Active = (i == currentPageIndex)
                    });
                }
            }
            // rptPager là Repeater hiển thị các nút số trang
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
            // Tạm thời alert, sau này sẽ code logic Session ở đây
            Response.Write("<script>alert('Đã thêm sách mã " + maSach + " vào giỏ hàng!');</script>");
        }
    }
}