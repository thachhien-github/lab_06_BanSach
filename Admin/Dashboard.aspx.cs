using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI.WebControls;

namespace lab_06_BanSach.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        string strCon = ConfigurationManager.ConnectionStrings["BookStoreDBConnectionString"].ConnectionString;

        // Hai biến này dùng để truyền chuỗi dữ liệu sang JavaScript ở trang ASPX
        public string chartLabels = "";
        public string chartData = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["TenDN"] == null || Session["TenDN"].ToString().ToLower() != "admin")
                Response.Redirect("../Login.aspx");

            if (!IsPostBack)
            {
                // Mặc định lọc từ đầu tháng đến hiện tại
                txtTuNgay.Text = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).ToString("yyyy-MM-dd");
                txtDenNgay.Text = DateTime.Now.ToString("yyyy-MM-dd");

                RefreshData();
            }
        }

        protected void btnLoc_Click(object sender, EventArgs e)
        {
            RefreshData();
        }

        private void RefreshData()
        {
            ThongKe();
            LoadDonHangMoi();
            PrepareChartData();
        }

        private void ThongKe()
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                con.Open();
                // Lọc theo khoảng ngày người dùng chọn
                string filter = " WHERE NgayDH >= @tu AND NgayDH <= @den";

                // 1. Doanh thu
                SqlCommand cmdDT = new SqlCommand("SELECT SUM(Trigia) FROM DonDatHang" + filter, con);
                cmdDT.Parameters.AddWithValue("@tu", txtTuNgay.Text);
                cmdDT.Parameters.AddWithValue("@den", txtDenNgay.Text + " 23:59:59");
                object dt = cmdDT.ExecuteScalar();
                ltrDoanhThu.Text = dt != DBNull.Value ? string.Format("{0:N0}", dt) : "0";

                // 2. Đơn hàng
                SqlCommand cmdDH = new SqlCommand("SELECT COUNT(*) FROM DonDatHang" + filter, con);
                cmdDH.Parameters.AddWithValue("@tu", txtTuNgay.Text);
                cmdDH.Parameters.AddWithValue("@den", txtDenNgay.Text + " 23:59:59");
                ltrDonHang.Text = cmdDH.ExecuteScalar().ToString();

                // 3. Khách hàng & Sách (Tổng hệ thống)
                ltrKhachHang.Text = new SqlCommand("SELECT COUNT(*) FROM KhachHang WHERE TenDN <> 'admin'", con).ExecuteScalar().ToString();
                ltrTongSach.Text = new SqlCommand("SELECT COUNT(*) FROM Sach", con).ExecuteScalar().ToString();
            }
        }

        private void PrepareChartData()
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                // Lấy doanh thu gom nhóm theo ngày của 7 ngày gần nhất có phát sinh đơn
                string sql = @"SELECT TOP 7 CAST(NgayDH AS DATE) as Ngay, SUM(Trigia) as Tong 
                               FROM DonDatHang 
                               GROUP BY CAST(NgayDH AS DATE) 
                               ORDER BY Ngay DESC";
                SqlDataAdapter da = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                List<string> labels = new List<string>();
                List<string> values = new List<string>();

                // Đọc ngược lại để biểu đồ chạy từ trái (cũ) sang phải (mới)
                for (int i = dt.Rows.Count - 1; i >= 0; i--)
                {
                    labels.Add("'" + Convert.ToDateTime(dt.Rows[i]["Ngay"]).ToString("dd/MM") + "'");
                    values.Add(dt.Rows[i]["Tong"].ToString());
                }

                chartLabels = string.Join(",", labels);
                chartData = string.Join(",", values);
            }
        }

        private void LoadDonHangMoi()
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                string sql = @"SELECT TOP 6 k.HoTenKH, d.Trigia 
                               FROM DonDatHang d JOIN KhachHang k ON d.MaKH = k.MaKH 
                               ORDER BY d.SoDH DESC";
                SqlDataAdapter da = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvMoiNhat.DataSource = dt;
                gvMoiNhat.DataBind();
            }
        }

        protected void btnExportExcel_Click(object sender, EventArgs e)
        {
            ExportToExcel();
        }

        private void ExportToExcel()
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                // 1. Lấy dữ liệu chi tiết đơn hàng theo khoảng ngày đã chọn
                string sql = @"SELECT d.SoDH as [Mã Đơn], k.HoTenKH as [Khách Hàng], 
                              d.NgayDH as [Ngày Đặt], d.Trigia as [Trị Giá (VNĐ)],
                              CASE WHEN d.Dagiao = 1 THEN N'Đã giao' ELSE N'Chưa giao' END as [Trạng Thái]
                       FROM DonDatHang d 
                       JOIN KhachHang k ON d.MaKH = k.MaKH 
                       WHERE d.NgayDH >= @tu AND d.NgayDH <= @den
                       ORDER BY d.NgayDH DESC";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@tu", txtTuNgay.Text);
                cmd.Parameters.AddWithValue("@den", txtDenNgay.Text + " 23:59:59");

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // 2. Thiết lập Header để trình duyệt hiểu đây là file Excel
                Response.Clear();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", "attachment;filename=BaoCaoDoanhThu_" + DateTime.Now.ToString("yyyyMMdd") + ".xls");
                Response.Charset = "";
                Response.ContentType = "application/vnd.ms-excel";
                Response.ContentEncoding = System.Text.Encoding.Unicode;
                Response.BinaryWrite(System.Text.Encoding.Unicode.GetPreamble());

                // 3. Sử dụng StringWriter để ghi dữ liệu table vào stream
                using (System.IO.StringWriter sw = new System.IO.StringWriter())
                {
                    using (System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(sw))
                    {
                        // Tạo một GridView tạm thời để render dữ liệu ra HTML
                        GridView gvExport = new GridView();
                        gvExport.DataSource = dt;
                        gvExport.DataBind();

                        // Định dạng tiêu đề cho file Excel (tùy chọn)
                        hw.Write("<h3>BAO CAO DOANH THU TU NGAY " + txtTuNgay.Text + " DEN " + txtDenNgay.Text + "</h3>");

                        gvExport.RenderControl(hw);
                        Response.Output.Write(sw.ToString());
                        Response.Flush();
                        Response.End();
                    }
                }
            }
        }

        // Lưu ý: Phải override phương thức này để tránh lỗi "Control must be placed inside a form tag"
        public override void VerifyRenderingInServerForm(System.Web.UI.Control control)
        {
            /* Confirms that an HtmlForm control is rendered for the specified ASP.NET server control at run time. */
        }
    }
}