using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace lab_06_BanSach.Admin
{
    public partial class QuanLyKhachHang : System.Web.UI.Page
    {
        string strCon = ConfigurationManager.ConnectionStrings["BookStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["TenDN"] == null || Session["TenDN"].ToString().ToLower() != "admin")
                Response.Redirect("../Login.aspx");

            if (!IsPostBack) LoadKhachHang();
        }

        private void LoadKhachHang()
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                // SQL động để tìm kiếm
                string sql = "SELECT * FROM KhachHang WHERE TenDN <> 'admin'";
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;

                if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
                {
                    sql += " AND (HoTenKH LIKE @key OR Email LIKE @key OR Dienthoai LIKE @key OR TenDN LIKE @key)";
                    cmd.Parameters.AddWithValue("@key", "%" + txtSearch.Text.Trim() + "%");
                }

                sql += " ORDER BY MaKH DESC";
                cmd.CommandText = sql;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvKhachHang.DataSource = dt;
                gvKhachHang.DataBind();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            gvKhachHang.PageIndex = 0;
            LoadKhachHang();
        }

        protected void gvKhachHang_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvKhachHang.PageIndex = e.NewPageIndex;
            LoadKhachHang();
        }

        protected void gvKhachHang_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandArgument == null || e.CommandArgument.ToString() == "") return;
            int maKH = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "ResetPass")
            {
                ExecuteSql("UPDATE KhachHang SET Matkhau = '123456' WHERE MaKH = @id", maKH);
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Đã reset mật khẩu về 123456!');", true);
            }
            else if (e.CommandName == "DeleteKH")
            {
                XoaKhachHangLienQuan(maKH);
            }
            LoadKhachHang();
        }

        private void ExecuteSql(string sql, int id)
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@id", id);
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        private void XoaKhachHangLienQuan(int id)
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                con.Open();
                SqlTransaction trans = con.BeginTransaction();
                try
                {
                    // 
                    // 1. Xóa chi tiết đơn hàng của các đơn hàng thuộc khách hàng này
                    string sqlCT = "DELETE FROM CTDatHang WHERE SoDH IN (SELECT SoDH FROM DonDatHang WHERE MaKH = @id)";
                    SqlCommand cmdCT = new SqlCommand(sqlCT, con, trans);
                    cmdCT.Parameters.AddWithValue("@id", id);
                    cmdCT.ExecuteNonQuery();

                    // 2. Xóa các đơn hàng của khách hàng này
                    string sqlDH = "DELETE FROM DonDatHang WHERE MaKH = @id";
                    SqlCommand cmdDH = new SqlCommand(sqlDH, con, trans);
                    cmdDH.Parameters.AddWithValue("@id", id);
                    cmdDH.ExecuteNonQuery();

                    // 3. Cuối cùng mới xóa khách hàng
                    string sqlKH = "DELETE FROM KhachHang WHERE MaKH = @id";
                    SqlCommand cmdKH = new SqlCommand(sqlKH, con, trans);
                    cmdKH.Parameters.AddWithValue("@id", id);
                    cmdKH.ExecuteNonQuery();

                    trans.Commit();
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Đã xóa khách hàng và toàn bộ dữ liệu liên quan!');", true);
                }
                catch (Exception ex)
                {
                    trans.Rollback();
                    string msg = "Lỗi khi xóa: " + ex.Message.Replace("'", "");
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('{msg}');", true);
                }
            }
        }
    }
}