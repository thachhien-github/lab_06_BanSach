using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Drawing;

namespace lab_06_BanSach
{
    public partial class Profile : System.Web.UI.Page
    {
        string strCon = ConfigurationManager.ConnectionStrings["BookStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["MaKH"] == null) Response.Redirect("Login.aspx");

            if (!IsPostBack)
            {
                LoadProfile();
            }
        }

        private void LoadProfile()
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                string sql = "SELECT * FROM KhachHang WHERE MaKH = @MaKH";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@MaKH", Session["MaKH"]);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtHoTen.Text = dr["HoTenKH"].ToString();
                    txtTenDN.Text = dr["TenDN"].ToString();
                    txtEmail.Text = dr["Email"].ToString();
                    txtDienThoai.Text = dr["Dienthoai"].ToString();
                    txtDiaChi.Text = dr["Diachi"].ToString();
                    if (dr["Ngaysinh"] != DBNull.Value)
                        txtNgaySinh.Text = Convert.ToDateTime(dr["Ngaysinh"]).ToString("yyyy-MM-dd");
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                // Nếu mật khẩu trống thì giữ nguyên mật khẩu cũ, ngược lại thì cập nhật mới
                string sql = @"UPDATE KhachHang SET HoTenKH=@HoTen, Email=@Email, Dienthoai=@SDT, Diachi=@DC, Ngaysinh=@NS";
                if (!string.IsNullOrEmpty(txtMatKhau.Text))
                    sql += ", Matkhau=@MK";

                sql += " WHERE MaKH=@MaKH";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@HoTen", txtHoTen.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@SDT", txtDienThoai.Text.Trim());
                cmd.Parameters.AddWithValue("@DC", txtDiaChi.Text.Trim());
                cmd.Parameters.AddWithValue("@NS", txtNgaySinh.Text);
                cmd.Parameters.AddWithValue("@MaKH", Session["MaKH"]);

                if (!string.IsNullOrEmpty(txtMatKhau.Text))
                    cmd.Parameters.AddWithValue("@MK", txtMatKhau.Text.Trim());

                con.Open();
                int result = cmd.ExecuteNonQuery();
                if (result > 0)
                {
                    // Cập nhật lại Session tên hiển thị nếu người dùng đổi họ tên
                    Session["HoTenKH"] = txtHoTen.Text;
                    lblMsg.Text = "Cập nhật thành công!";
                    lblMsg.ForeColor = Color.Green;
                }
            }
        }
    }
}