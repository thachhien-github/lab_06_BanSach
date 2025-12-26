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
            // 1. Lấy MaSach từ CommandArgument của nút được nhấn
            int maSach = int.Parse(((LinkButton)sender).CommandArgument);

            // 2. Lấy hoặc Khởi tạo Giỏ hàng (DataTable) từ Session
            DataTable dt;
            if (Session["GioHang"] == null)
            {
                dt = new DataTable();
                dt.Columns.Add("MaSach", typeof(int));
                dt.Columns.Add("TenSach", typeof(string));
                dt.Columns.Add("AnhBia", typeof(string));
                dt.Columns.Add("Dongia", typeof(decimal));
                dt.Columns.Add("SoLuong", typeof(int));
                dt.Columns.Add("ThanhTien", typeof(decimal));
            }
            else
            {
                dt = (DataTable)Session["GioHang"];
            }

            // 3. Kiểm tra xem sách này đã có trong giỏ chưa
            bool isExist = false;
            foreach (DataRow row in dt.Rows)
            {
                if ((int)row["MaSach"] == maSach)
                {
                    row["SoLuong"] = (int)row["SoLuong"] + 1;
                    row["ThanhTien"] = (int)row["SoLuong"] * (decimal)row["Dongia"];
                    isExist = true;
                    break;
                }
            }

            // 4. Nếu chưa có thì lấy thông tin từ DB và thêm dòng mới
            if (!isExist)
            {
                using (SqlConnection con = new SqlConnection(strCon))
                {
                    string sql = "SELECT TenSach, AnhBia, Dongia FROM Sach WHERE MaSach = @MaSach";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@MaSach", maSach);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        DataRow nr = dt.NewRow();
                        nr["MaSach"] = maSach;
                        nr["TenSach"] = dr["TenSach"];
                        nr["AnhBia"] = dr["AnhBia"];
                        nr["Dongia"] = dr["Dongia"];
                        nr["SoLuong"] = 1;
                        nr["ThanhTien"] = dr["Dongia"];
                        dt.Rows.Add(nr);
                    }
                }
            }

            // 5. Lưu giỏ hàng vào Session và chuyển hướng sang trang Giỏ hàng
            Session["GioHang"] = dt;
            //Response.Redirect("GioHang.aspx");
        }
    }
}