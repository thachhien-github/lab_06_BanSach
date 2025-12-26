using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Linq;

namespace lab_06_BanSach
{
    public partial class ThanhToan : System.Web.UI.Page
    {
        string strCon = ConfigurationManager.ConnectionStrings["BookStoreDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Kiểm tra đăng nhập và giỏ hàng
            if (Session["MaKH"] == null || Session["GioHang"] == null)
            {
                Response.Redirect("Login.aspx?ReturnUrl=ThanhToan.aspx");
                return;
            }

            DataTable dt = (DataTable)Session["GioHang"];
            if (dt.Rows.Count == 0)
            {
                Response.Redirect("Default.aspx");
                return;
            }

            if (!IsPostBack)
            {
                gvTomTat.DataSource = dt;
                gvTomTat.DataBind();

                // Tính tổng trị giá đơn hàng
                decimal tongTien = dt.AsEnumerable().Sum(x => x.Field<decimal>("ThanhTien"));
                lblTongTien.Text = string.Format("{0:0,0}", tongTien);

                // Mặc định ngày giao là 3 ngày sau
                txtNgayGiao.Text = DateTime.Now.AddDays(3).ToString("yyyy-MM-dd");
            }
        }

        protected void btnXacNhan_Click(object sender, EventArgs e)
        {
            DataTable dt = (DataTable)Session["GioHang"];
            decimal tongTien = dt.AsEnumerable().Sum(x => x.Field<decimal>("ThanhTien"));

            using (SqlConnection con = new SqlConnection(strCon))
            {
                con.Open();
                SqlTransaction trans = con.BeginTransaction();

                try
                {
                    // 1. Thêm vào bảng DonDatHang theo đúng cấu trúc DB của bro
                    // Các cột: MaKH, NgayDH, Trigia, Dagiao, Ngaygiao
                    string sqlDonHang = @"INSERT INTO DonDatHang (MaKH, NgayDH, Trigia, Dagiao, Ngaygiao) 
                                         OUTPUT INSERTED.SoDH 
                                         VALUES (@MaKH, @NgayDH, @Trigia, @Dagiao, @Ngaygiao)";

                    SqlCommand cmdDH = new SqlCommand(sqlDonHang, con, trans);
                    cmdDH.Parameters.AddWithValue("@MaKH", Session["MaKH"]);
                    cmdDH.Parameters.AddWithValue("@NgayDH", DateTime.Now);
                    cmdDH.Parameters.AddWithValue("@Trigia", tongTien);
                    cmdDH.Parameters.AddWithValue("@Dagiao", false); // Mới đặt nên chưa giao
                    cmdDH.Parameters.AddWithValue("@Ngaygiao", DateTime.Parse(txtNgayGiao.Text));

                    // Lấy SoDH vừa tạo tự động
                    int soDH = (int)cmdDH.ExecuteScalar();

                    // 2. Thêm vào bảng CTDatHang
                    // Các cột: MaSach, SoDH, Soluong, Dongia, Thanhtien
                    foreach (DataRow dr in dt.Rows)
                    {
                        string sqlCT = @"INSERT INTO CTDatHang (MaSach, SoDH, Soluong, Dongia, Thanhtien) 
                                        VALUES (@MaSach, @SoDH, @SL, @Gia, @ThanhTien)";

                        SqlCommand cmdCT = new SqlCommand(sqlCT, con, trans);
                        cmdCT.Parameters.AddWithValue("@MaSach", dr["MaSach"]);
                        cmdCT.Parameters.AddWithValue("@SoDH", soDH);
                        cmdCT.Parameters.AddWithValue("@SL", dr["SoLuong"]);
                        cmdCT.Parameters.AddWithValue("@Gia", dr["Dongia"]);
                        cmdCT.Parameters.AddWithValue("@ThanhTien", dr["ThanhTien"]);

                        cmdCT.ExecuteNonQuery();
                    }

                    // Nếu mọi thứ ok thì xác nhận lưu vào DB
                    trans.Commit();

                    // Xóa giỏ hàng và thông báo
                    Session.Remove("GioHang");
                    Response.Write("<script>alert('Xác nhận đơn hàng thành công! Mã số đơn: " + soDH + "'); window.location='Default.aspx';</script>");
                }
                catch (Exception ex)
                {
                    // Có lỗi thì hủy toàn bộ thao tác trong transaction này
                    trans.Rollback();
                    Response.Write("<script>alert('Lỗi hệ thống: " + ex.Message + "');</script>");
                }
            }
        }
    }
}