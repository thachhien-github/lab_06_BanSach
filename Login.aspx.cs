using System;
using System.Configuration;
using System.Data.SqlClient;

namespace lab_06_BanSach
{
    public partial class Login : System.Web.UI.Page
    {
        string strCon = ConfigurationManager.ConnectionStrings["BookStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string tenDN = txtTenDN.Text.Trim();
            string matKhau = txtMatKhau.Text.Trim();

            if (string.IsNullOrEmpty(tenDN) || string.IsNullOrEmpty(matKhau))
            {
                lblError.Text = "Vui lòng nhập đầy đủ thông tin!";
                lblError.Visible = true;
                return;
            }

            using (SqlConnection con = new SqlConnection(strCon))
            {
                // Truy vấn dựa trên cấu trúc bảng KhachHang của bro
                string sql = "SELECT MaKH, HoTenKH FROM KhachHang WHERE TenDN = @TenDN AND Matkhau = @Matkhau";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@TenDN", tenDN);
                cmd.Parameters.AddWithValue("@Matkhau", matKhau);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    // Đăng nhập thành công -> Lưu Session
                    Session["MaKH"] = dr["MaKH"].ToString();
                    Session["HoTenKH"] = dr["HoTenKH"].ToString();
                    Session["TenDN"] = tenDN;

                    // Kiểm tra xem khách hàng có đang dở dang ở trang Giỏ hàng không
                    if (Request.QueryString["ReturnUrl"] != null)
                    {
                        Response.Redirect(Request.QueryString["ReturnUrl"]);
                    }
                    else
                    {
                        Response.Redirect("Default.aspx");
                    }
                }
                else
                {
                    lblError.Text = "Tên đăng nhập hoặc mật khẩu không đúng!";
                    lblError.Visible = true;
                }
            }
        }
    }
}