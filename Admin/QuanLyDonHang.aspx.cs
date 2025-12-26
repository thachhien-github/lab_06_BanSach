using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace lab_06_BanSach.Admin
{
    public partial class QuanLyDonHang : System.Web.UI.Page
    {
        string strCon = ConfigurationManager.ConnectionStrings["BookStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["TenDN"] == null || Session["TenDN"].ToString().ToLower() != "admin")
            {
                Response.Redirect("../Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadDonHang();
            }
        }

        private void LoadDonHang()
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                // 1=1 là mẹo để nối thêm AND cực dễ
                string sql = @"SELECT d.SoDH, d.NgayDH, d.Trigia, d.Dagiao, d.Ngaygiao, k.HoTenKH 
                       FROM DonDatHang d 
                       LEFT JOIN KhachHang k ON d.MaKH = k.MaKH 
                       WHERE 1=1";

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;

                // 1. Tìm kiếm theo từ khóa (Tên khách hàng hoặc Số ĐH)
                if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
                {
                    sql += " AND (k.HoTenKH LIKE @Keyword OR CAST(d.SoDH AS NVARCHAR) LIKE @Keyword)";
                    cmd.Parameters.AddWithValue("@Keyword", "%" + txtSearch.Text.Trim() + "%");
                }

                // 2. Lọc theo trạng thái
                if (ddlTrangThai.SelectedValue != "-1")
                {
                    sql += " AND d.Dagiao = @Dagiao";
                    cmd.Parameters.AddWithValue("@Dagiao", ddlTrangThai.SelectedValue);
                }

                // 3. Lọc theo ngày đặt
                if (!string.IsNullOrEmpty(txtTuNgay.Text))
                {
                    sql += " AND d.NgayDH >= @TuNgay";
                    cmd.Parameters.AddWithValue("@TuNgay", txtTuNgay.Text + " 00:00:00");
                }
                if (!string.IsNullOrEmpty(txtDenNgay.Text))
                {
                    sql += " AND d.NgayDH <= @DenNgay";
                    cmd.Parameters.AddWithValue("@DenNgay", txtDenNgay.Text + " 23:59:59");
                }

                sql += " ORDER BY d.NgayDH DESC";
                cmd.CommandText = sql;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvDonHang.DataSource = dt;
                gvDonHang.DataBind();
            }
        }

        protected void btnLoc_Click(object sender, EventArgs e)
        {
            gvDonHang.PageIndex = 0; // Reset về trang 1 khi bắt đầu lọc mới
            LoadDonHang();
        }

        protected void gvDonHang_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvDonHang.PageIndex = e.NewPageIndex;
            LoadDonHang();
        }

        protected void gvDonHang_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteDH")
            {
                int soDH = Convert.ToInt32(e.CommandArgument);
                XoaDonHang(soDH);
                LoadDonHang();
            }
        }

        private void XoaDonHang(int soDH)
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                con.Open();
                SqlTransaction trans = con.BeginTransaction();
                try
                {
                    // Xóa chi tiết trước
                    SqlCommand cmdDetail = new SqlCommand("DELETE FROM CTDatHang WHERE SoDH = @id", con, trans);
                    cmdDetail.Parameters.AddWithValue("@id", soDH);
                    cmdDetail.ExecuteNonQuery();

                    // Xóa đơn hàng sau
                    SqlCommand cmdOrder = new SqlCommand("DELETE FROM DonDatHang WHERE SoDH = @id", con, trans);
                    cmdOrder.Parameters.AddWithValue("@id", soDH);
                    cmdOrder.ExecuteNonQuery();

                    trans.Commit();
                }
                catch
                {
                    trans.Rollback();
                }
            }
        }
    }
}