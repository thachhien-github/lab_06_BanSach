using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

namespace lab_06_BanSach.Admin
{
    public partial class QuanLySach_Edit : System.Web.UI.Page
    {
        string strCon = ConfigurationManager.ConnectionStrings["BookStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDataPhu();
                if (Request.QueryString["id"] != null)
                {
                    int id = Convert.ToInt32(Request.QueryString["id"]);
                    ltrTitle.Text = "Cập nhật thông tin sách";
                    LoadChiTietSach(id);
                }
                else
                {
                    ltrTitle.Text = "Thêm sách mới";
                    imgHienTai.Visible = false;
                }
            }
        }

        private void LoadDataPhu()
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                SqlDataAdapter daCD = new SqlDataAdapter("SELECT * FROM CHUDE", con);
                DataTable dtCD = new DataTable(); daCD.Fill(dtCD);
                ddlChuDe.DataSource = dtCD; ddlChuDe.DataTextField = "TenChuDe"; ddlChuDe.DataValueField = "MaCD"; ddlChuDe.DataBind();

                SqlDataAdapter daNXB = new SqlDataAdapter("SELECT * FROM NHAXUATBAN", con);
                DataTable dtNXB = new DataTable(); daNXB.Fill(dtNXB);
                ddlNXB.DataSource = dtNXB; ddlNXB.DataTextField = "TenNXB"; ddlNXB.DataValueField = "MaNXB"; ddlNXB.DataBind();
            }
        }

        private void LoadChiTietSach(int id)
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Sach WHERE MaSach = @ID", con);
                cmd.Parameters.AddWithValue("@ID", id);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtTenSach.Text = dr["TenSach"].ToString();
                    txtGiaBan.Text = string.Format("{0:0}", dr["Dongia"]);
                    txtMoTa.Text = dr["Mota"].ToString();
                    ddlChuDe.SelectedValue = dr["MaCD"].ToString();
                    ddlNXB.SelectedValue = dr["MaNXB"].ToString();
                    hfAnhCu.Value = dr["AnhBia"].ToString();
                    imgHienTai.ImageUrl = "../Bia_sach/" + dr["AnhBia"].ToString();
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                string fileName = hfAnhCu.Value;
                if (fuAnhBia.HasFile)
                {
                    fileName = Path.GetFileName(fuAnhBia.FileName);
                    fuAnhBia.SaveAs(Server.MapPath("~/Bia_sach/") + fileName);
                }

                string sql = "";
                bool isEdit = Request.QueryString["id"] != null;

                if (!isEdit)
                    sql = "INSERT INTO Sach(TenSach, Dongia, Mota, AnhBia, MaCD, MaNXB, Ngaycapnhat, Soluotxem) VALUES(@Ten, @Gia, @MoTa, @Anh, @MaCD, @MaNXB, GETDATE(), 0)";
                else
                    sql = "UPDATE Sach SET TenSach=@Ten, Dongia=@Gia, Mota=@MoTa, AnhBia=@Anh, MaCD=@MaCD, MaNXB=@MaNXB WHERE MaSach=@ID";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Ten", txtTenSach.Text);
                cmd.Parameters.AddWithValue("@Gia", decimal.Parse(txtGiaBan.Text));
                cmd.Parameters.AddWithValue("@MoTa", txtMoTa.Text);
                cmd.Parameters.AddWithValue("@Anh", fileName);
                cmd.Parameters.AddWithValue("@MaCD", ddlChuDe.SelectedValue);
                cmd.Parameters.AddWithValue("@MaNXB", ddlNXB.SelectedValue);
                if (isEdit) cmd.Parameters.AddWithValue("@ID", Request.QueryString["id"]);

                con.Open();
                cmd.ExecuteNonQuery();
                Response.Redirect("QuanLySach.aspx");
            }
        }
    }
}