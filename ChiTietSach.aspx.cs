using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace lab_06_BanSach
{
    public partial class ChiTietSach : System.Web.UI.Page
    {
        string strCon = ConfigurationManager.ConnectionStrings["BookStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string maSach = Request.QueryString["MaSach"];
                if (!string.IsNullOrEmpty(maSach))
                {
                    LoadChiTiet(maSach);
                }
                else
                {
                    Response.Redirect("Default.aspx");
                }
            }
        }

        private void LoadChiTiet(string maSach)
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                // Query chuẩn theo Database của bro: Kết nối qua bảng VietSach để lấy TacGia
                string sql = @"SELECT S.*, CD.Tenchude, NXB.TenNXB, 
                        (SELECT TOP 1 TG.TenTG FROM TacGia TG 
                         JOIN VietSach VS ON TG.MaTG = VS.MaTG 
                         WHERE VS.MaSach = S.MaSach) as TenTacGia
                       FROM Sach S
                       LEFT JOIN ChuDe CD ON S.MaCD = CD.MaCD
                       LEFT JOIN NhaXuatBan NXB ON S.MaNXB = NXB.MaNXB
                       WHERE S.MaSach = @MaSach";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@MaSach", maSach);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    rptChiTiet.DataSource = dt;
                    rptChiTiet.DataBind();
                }
                else
                {
                    Response.Redirect("Default.aspx");
                }
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            string maSach = ((LinkButton)sender).CommandArgument;
            // Tạm thời thông báo, sẽ tích hợp Session GioHang sau
            Response.Write("<script>alert('Đã thêm " + maSach + " vào giỏ hàng!');</script>");
        }
    }
}