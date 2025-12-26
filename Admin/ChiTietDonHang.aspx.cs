using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace lab_06_BanSach.Admin
{
    public partial class ChiTietDonHang : System.Web.UI.Page
    {
        string strCon = ConfigurationManager.ConnectionStrings["BookStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Request.QueryString["id"] != null)
            {
                int id = Convert.ToInt32(Request.QueryString["id"]);
                LoadDonHang(id);
                LoadChiTiet(id);
            }
        }

        private void LoadDonHang(int id)
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                // Cập nhật đúng tên bảng DonDatHang và các cột HoTenKH, Diachi, Dienthoai
                string sql = @"SELECT d.*, k.HoTenKH, k.Dienthoai, k.Diachi 
                               FROM DonDatHang d JOIN KhachHang k ON d.MaKH = k.MaKH 
                               WHERE d.SoDH = @id";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@id", id);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    lblMaDH.Text = dr["SoDH"].ToString();
                    lblTenKH.Text = dr["HoTenKH"].ToString();
                    lblSDT.Text = dr["Dienthoai"].ToString();
                    lblDiaChi.Text = dr["Diachi"].ToString();

                    // Kiểm tra trạng thái Dagiao (bit) để ẩn/hiện nút xác nhận
                    if (dr["Dagiao"] != DBNull.Value && (bool)dr["Dagiao"])
                    {
                        btnXacNhan.Visible = false;
                    }
                }
            }
        }

        private void LoadChiTiet(int id)
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                // Cập nhật bảng CTDatHang và Join với Sach
                string sql = @"SELECT c.*, s.TenSach 
                               FROM CTDatHang c JOIN Sach s ON c.MaSach = s.MaSach 
                               WHERE c.SoDH = @id";

                SqlDataAdapter da = new SqlDataAdapter(sql, con);
                da.SelectCommand.Parameters.AddWithValue("@id", id);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvChiTiet.DataSource = dt;
                gvChiTiet.DataBind();

                // Tính tổng tiền dựa trên cột Thanhtien có sẵn trong DB hoặc tính tay
                decimal tong = 0;
                foreach (DataRow row in dt.Rows)
                {
                    tong += Convert.ToDecimal(row["Thanhtien"]);
                }
                lblTongTien.Text = tong.ToString("N0") + " đ";
            }
        }

        protected void btnXacNhan_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null)
            {
                int id = Convert.ToInt32(Request.QueryString["id"]);
                using (SqlConnection con = new SqlConnection(strCon))
                {
                    // Cập nhật cột Dagiao = 1 và Ngaygiao = hiện tại
                    string sql = "UPDATE DonDatHang SET Dagiao = 1, Ngaygiao = GETDATE() WHERE SoDH = @id";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@id", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                Response.Redirect("QuanLyDonHang.aspx");
            }
        }
    }
}