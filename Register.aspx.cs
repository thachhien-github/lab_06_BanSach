using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;

namespace lab_06_BanSach
{
    public partial class Register : System.Web.UI.Page
    {
        string strCon = ConfigurationManager.ConnectionStrings["BookStoreDBConnectionString"].ConnectionString;

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            // 1. Kiểm tra nhập liệu cơ bản
            if (string.IsNullOrEmpty(txtTenDN.Text) || string.IsNullOrEmpty(txtMatKhau.Text) || txtMatKhau.Text != txtNhapLaiMK.Text)
            {
                ShowMessage("Mật khẩu không khớp hoặc thông tin trống!", Color.Red);
                return;
            }

            using (SqlConnection con = new SqlConnection(strCon))
            {
                con.Open();

                // 2. Kiểm tra tên đăng nhập đã tồn tại chưa
                string checkSql = "SELECT COUNT(*) FROM KhachHang WHERE TenDN = @TenDN";
                SqlCommand checkCmd = new SqlCommand(checkSql, con);
                checkCmd.Parameters.AddWithValue("@TenDN", txtTenDN.Text.Trim());

                int exists = (int)checkCmd.ExecuteScalar();
                if (exists > 0)
                {
                    ShowMessage("Tên đăng nhập đã tồn tại!", Color.Red);
                    return;
                }

                // 3. Thực hiện thêm khách hàng mới
                string sql = "INSERT INTO KhachHang (HoTenKH, TenDN, Matkhau, Email, Dienthoai) " +
                             "VALUES (@HoTen, @TenDN, @MK, @Email, @SDT)";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@HoTen", txtHoTen.Text.Trim());
                cmd.Parameters.AddWithValue("@TenDN", txtTenDN.Text.Trim());
                cmd.Parameters.AddWithValue("@MK", txtMatKhau.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@SDT", txtDienThoai.Text.Trim());

                try
                {
                    cmd.ExecuteNonQuery();
                    // Đăng ký xong cho sang trang Login luôn
                    Response.Write("<script>alert('Đăng ký thành công!'); window.location='Login.aspx';</script>");
                }
                catch (Exception ex)
                {
                    ShowMessage("Lỗi hệ thống: " + ex.Message, Color.Red);
                }
            }
        }

        private void ShowMessage(string msg, Color color)
        {
            lblMsg.Text = msg;
            lblMsg.ForeColor = color;
            lblMsg.Visible = true;
        }
    }
}