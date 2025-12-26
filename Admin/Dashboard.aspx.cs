using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace lab_06_BanSach.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        string strCon = ConfigurationManager.ConnectionStrings["BookStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ThongKe();
                LoadDonHangMoi();
            }
        }

        private void ThongKe()
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                con.Open();

                // 1. Tính tổng doanh thu (Trigia)
                SqlCommand cmdDT = new SqlCommand("SELECT SUM(Trigia) FROM DonDatHang", con);
                object dt = cmdDT.ExecuteScalar();
                ltrDoanhThu.Text = dt != DBNull.Value ? string.Format("{0:0,0}", dt) : "0";

                // 2. Đếm tổng đơn hàng
                SqlCommand cmdDH = new SqlCommand("SELECT COUNT(*) FROM DonDatHang", con);
                ltrDonHang.Text = cmdDH.ExecuteScalar().ToString();

                // 3. Đếm tổng khách hàng (trừ admin)
                SqlCommand cmdKH = new SqlCommand("SELECT COUNT(*) FROM KhachHang WHERE TenDN <> 'admin'", con);
                ltrKhachHang.Text = cmdKH.ExecuteScalar().ToString();

                // 4. Đếm tổng số sách
                SqlCommand cmdSach = new SqlCommand("SELECT COUNT(*) FROM Sach", con);
                ltrTongSach.Text = cmdSach.ExecuteScalar().ToString();
            }
        }

        private void LoadDonHangMoi()
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                // Join với bảng khách hàng để lấy tên người đặt
                string sql = @"SELECT TOP 5 d.SoDH, k.HoTenKH, d.NgayDH, d.Trigia 
                               FROM DonDatHang d JOIN KhachHang k ON d.MaKH = k.MaKH 
                               ORDER BY d.SoDH DESC";
                SqlDataAdapter da = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvMoiNhat.DataSource = dt;
                gvMoiNhat.DataBind();
            }
        }
    }
}