using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace lab_06_BanSach.Admin
{
    public partial class QuanLySach : System.Web.UI.Page
    {
        string strCon = ConfigurationManager.ConnectionStrings["BookStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["TenDN"] == null || Session["TenDN"].ToString().ToLower() != "admin")
                Response.Redirect("../Login.aspx");

            if (!IsPostBack)
            {
                LoadFilterData();
                LoadSach();
            }
        }

        private void LoadFilterData()
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                // Lọc Chủ đề - Tenchude (Khớp DB của bạn)
                SqlDataAdapter daCD = new SqlDataAdapter("SELECT MaCD, Tenchude FROM ChuDe", con);
                DataTable dtCD = new DataTable();
                daCD.Fill(dtCD);
                ddlChuDe.DataSource = dtCD;
                ddlChuDe.DataTextField = "Tenchude";
                ddlChuDe.DataValueField = "MaCD";
                ddlChuDe.DataBind();
                ddlChuDe.Items.Insert(0, new ListItem("-- Tất cả chủ đề --", "-1"));

                // Lọc Nhà xuất bản
                SqlDataAdapter daNXB = new SqlDataAdapter("SELECT MaNXB, TenNXB FROM NhaXuatBan", con);
                DataTable dtNXB = new DataTable();
                daNXB.Fill(dtNXB);
                ddlNXB.DataSource = dtNXB;
                ddlNXB.DataTextField = "TenNXB";
                ddlNXB.DataValueField = "MaNXB";
                ddlNXB.DataBind();
                ddlNXB.Items.Insert(0, new ListItem("-- Tất cả NXB --", "-1"));
            }
        }

        private void LoadSach()
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                // Xây dựng câu lệnh SQL động
                string sql = "SELECT * FROM Sach WHERE 1=1";
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;

                // Tìm theo tên
                if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
                {
                    sql += " AND TenSach LIKE @Ten";
                    cmd.Parameters.AddWithValue("@Ten", "%" + txtSearch.Text.Trim() + "%");
                }

                // Lọc theo chủ đề
                if (ddlChuDe.SelectedValue != "-1")
                {
                    sql += " AND MaCD = @MaCD";
                    cmd.Parameters.AddWithValue("@MaCD", ddlChuDe.SelectedValue);
                }

                // Lọc theo NXB
                if (ddlNXB.SelectedValue != "-1")
                {
                    sql += " AND MaNXB = @MaNXB";
                    cmd.Parameters.AddWithValue("@MaNXB", ddlNXB.SelectedValue);
                }

                sql += " ORDER BY MaSach DESC";
                cmd.CommandText = sql;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvSach.DataSource = dt;
                gvSach.DataBind();
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            gvSach.PageIndex = 0; // Quay về trang 1 khi lọc mới
            LoadSach();
        }

        protected void gvSach_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvSach.PageIndex = e.NewPageIndex;
            LoadSach();
        }

        protected void gvSach_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteSach")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                try
                {
                    using (SqlConnection con = new SqlConnection(strCon))
                    {
                        SqlCommand cmd = new SqlCommand("DELETE FROM Sach WHERE MaSach = @ID", con);
                        cmd.Parameters.AddWithValue("@ID", id);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                    LoadSach();
                }
                catch (Exception)
                {
                    // Trường hợp sách đã có trong đơn hàng (bảng CTDatHang), SQL sẽ chặn xóa do khóa ngoại
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Không thể xóa sách này vì đã có dữ liệu liên quan trong đơn hàng!');", true);
                }
            }
        }
    }
}