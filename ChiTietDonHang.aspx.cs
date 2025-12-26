using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Linq;

namespace lab_06_BanSach
{
    public partial class ChiTietDonHang : System.Web.UI.Page
    {
        string strCon = ConfigurationManager.ConnectionStrings["BookStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["MaKH"] == null) Response.Redirect("Login.aspx");

            string soDH = Request.QueryString["SoDH"];
            if (string.IsNullOrEmpty(soDH)) Response.Redirect("LichSuDonHang.aspx");

            if (!IsPostBack)
            {
                ltrSoDH.Text = soDH;
                LoadData(soDH);
            }
        }

        private void LoadData(string soDH)
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                // Query kết hợp 2 bảng để lấy thông tin sách
                string sql = @"SELECT s.TenSach, s.AnhBia, ct.Soluong, ct.Dongia, ct.Thanhtien 
                               FROM CTDatHang ct 
                               JOIN Sach s ON ct.MaSach = s.MaSach 
                               WHERE ct.SoDH = @SoDH";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@SoDH", soDH);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvChiTiet.DataSource = dt;
                gvChiTiet.DataBind();

                // Tính tổng tiền hiển thị ở dưới
                decimal tong = dt.AsEnumerable().Sum(r => r.Field<decimal>("Thanhtien"));
                ltrTongTien.Text = string.Format("{0:0,0}", tong);
            }
        }
    }
}