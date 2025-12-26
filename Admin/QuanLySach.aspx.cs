using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace lab_06_BanSach.Admin
{
    public partial class QuanLySach : System.Web.UI.Page
    {
        string strCon = ConfigurationManager.ConnectionStrings["BookStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["TenDN"] == null || Session["TenDN"].ToString().ToLower() != "admin")
                Response.Redirect("../Login.aspx");

            if (!IsPostBack) LoadSach();
        }

        private void LoadSach()
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Sach ORDER BY MaSach DESC", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvSach.DataSource = dt;
                gvSach.DataBind();
            }
        }

        protected void gvSach_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteSach")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                using (SqlConnection con = new SqlConnection(strCon))
                {
                    SqlCommand cmd = new SqlCommand("DELETE FROM Sach WHERE MaSach = @ID", con);
                    cmd.Parameters.AddWithValue("@ID", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                LoadSach();
            }
        }
    }
}