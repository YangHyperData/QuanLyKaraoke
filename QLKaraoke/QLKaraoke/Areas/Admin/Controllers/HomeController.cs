using QLKaraoke.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace QLKaraoke.Areas.Admin.Controllers
{

    public class HomeController : Controller
    {
        QLKARAOKEEntities db = new QLKARAOKEEntities();
        // GET: Admin/Home

        public ActionResult Index()
        {

            ViewBag.Tongdt = ThongKe();
            ViewBag.Tongdt1 = DVBan();
            ViewBag.Nv = NhanVien();
            return View();
        }
        public ActionResult Fa()
        {


            return View();
        }
        public double ThongKe()
        {
            double tongdt = db.HOADONs.Where(n => n.TrangThai == true).Sum(n => (double)n.ThanhTien);
            return tongdt;
        }
        public int DVBan()
        {
            int tongdt = db.DichVu1.Sum(n => (int)n.DaBan);
            tongdt += db.HOADONs.Count();
            return tongdt;
        }
        public int NhanVien()
        {
            int tongdt = db.NhanViens.Where(n => n.TrangThai == 1).Count();
            return tongdt;
        }
        public PartialViewResult TopCustomers()
        {
            var topCustomers = db.KhachHanggs
                .OrderByDescending(kh => kh.DatPhongs.Count(dp => dp.TrangThai == 1 && dp.TrangThaiNhan == true))
                .Take(5)
                .Select(kh => new
                {
                    KhachHang = kh,
                    SoLuongHoaDon = kh.DatPhongs.Count(dp => dp.TrangThai == 1 && dp.TrangThaiNhan == true),
                    TongGiaTriHoaDon = kh.DatPhongs.Where(dp => dp.TrangThai == 1 && dp.TrangThaiNhan == true)
                                                   .Sum(dp => dp.ThanhTien)
                })
                .ToList();

            return PartialView("_TopCustomers", topCustomers);
        }
        public ActionResult TopSelling()
        {
            var topSellingProducts = db.DichVu1
                                    .OrderByDescending(dv => dv.DaBan)
                                    .Take(5)
                                    .Select(dv => new
                                    {
                                        TenDichVu = dv.Ten,
                                        GiaDichVu = dv.TongGia,
                                        SoLuongCon = dv.SoLuong,
                                        SoLuongDaBan = dv.DaBan,
                                        DoanhThu = dv.DaBan * dv.TongGia
                                    })
                                    .ToList();
            return PartialView("_topSellingProducts", topSellingProducts);

        }

        public ActionResult RevenueByMonth(int year)
        {
            var revenueByMonth = db.HOADONs
                .Where(i => i.Ngay.Value.Year == year)
                .GroupBy(i => i.Ngay.Value.Month)
                .Select(g => new { Month = g.Key, Revenue = g.Sum(i => i.ThanhTien) })
                .OrderBy(g => g.Month)
                .ToList();

            ViewBag.Year = year;
            ViewBag.RevenueByMonth = revenueByMonth;

            return PartialView("_revenueByMonth", revenueByMonth);
        }
        public ActionResult RevenueByYear(int? year)
        {

            int selectedYear = year ?? DateTime.Now.Year;


            var revenueByYear = db.HOADONs.Where(i => i.Ngay.Value.Year == selectedYear)

                .GroupBy(i => i.Ngay.Value.Year)
                .Select(g => new { Year = g.Key, Revenue = g.Sum(i => i.ThanhTien) })
                .ToList();

            // Pass the revenue data and selected year to the view
            return PartialView("_revenueByYear", revenueByYear);
        }


        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(QuanLii user, bool? remember, string returnUrl)
        {
            if (ModelState.IsValid)
            {
                using (QLKARAOKEEntities db = new QLKARAOKEEntities())
                {
                    var loginUser = db.QuanLiis.Where(u => u.Email == user.Email && u.MatKhau == user.MatKhau).FirstOrDefault();

                    if (loginUser != null)
                    {
                        Session["AdminEmail"] = loginUser.Email;
                        Session["AdminTen"] = loginUser.Ten;
                        Session["AdminChucVu"] = loginUser.ChucVu;
                        @Session["AdminHinh"] = loginUser.HinhAnh;
                        FormsAuthentication.SetAuthCookie(loginUser.Email, false);
                        return RedirectToAction("Index", "Home");
                    }
                    else
                    {
                        ViewBag.ThongBao = "Thông tin đăng nhập không chính xác.";
                    }
                }
            }
            FormsAuthentication.SetAuthCookie(user.Email, remember ?? false);

            return View(user);
        }
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Login", "Home");
        }



    }
}