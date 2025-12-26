using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace lab_06_BanSach
{
    public partial class LichSuDonHang : System.Web.UI.Page
    {
        string strCon = ConfigurationManager.ConnectionStrings["BookStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Bảo mật: Nếu chưa đăng nhập thì đẩy về trang Login
            if (Session["MaKH"] == null)
            {
                Response.Redirect("Login.aspx?ReturnUrl=LichSuDonHang.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadLichSu();
            }
        }

        private void LoadLichSu()
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                // Lấy đơn hàng mới nhất lên đầu (ORDER BY SoDH DESC)
                string sql = "SELECT SoDH, NgayDH, Trigia, Dagiao, Ngaygiao FROM DonDatHang WHERE MaKH = @MaKH ORDER BY SoDH DESC";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@MaKH", Session["MaKH"]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvLichSu.DataSource = dt;
                gvLichSu.DataBind();
            }
        }
    }
}