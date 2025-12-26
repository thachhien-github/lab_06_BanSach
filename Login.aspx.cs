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
                // Truy vấn lấy đầy đủ thông tin cần thiết
                string sql = "SELECT MaKH, HoTenKH FROM KhachHang WHERE TenDN = @TenDN AND Matkhau = @Matkhau";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@TenDN", tenDN);
                cmd.Parameters.AddWithValue("@Matkhau", matKhau);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    // --- ĐĂNG NHẬP THÀNH CÔNG ---

                    // 1. Lưu các Session quan trọng
                    Session["MaKH"] = dr["MaKH"].ToString();
                    Session["HoTenKH"] = dr["HoTenKH"].ToString(); // Site.Master dùng cái này để hiện tên
                    Session["TenDN"] = tenDN;

                    // 2. PHÂN QUYỀN ADMIN
                    if (tenDN.ToLower() == "admin")
                    {
                        Session["IsAdmin"] = true;
                        // Chuyển hướng ngay vào khu vực quản trị
                        Response.Redirect("~/Admin/Dashboard.aspx");
                        return;
                    }

                    // 3. ĐIỀU HƯỚNG CHO KHÁCH HÀNG
                    // Nếu có ReturnUrl (ví dụ từ Giỏ hàng qua) thì quay lại đó, không thì về Home
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
                    // --- ĐĂNG NHẬP THẤT BẠI ---
                    lblError.Text = "Tên đăng nhập hoặc mật khẩu không chính xác!";
                    lblError.Visible = true;
                }
            }
        }
    }
}