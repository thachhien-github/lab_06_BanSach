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