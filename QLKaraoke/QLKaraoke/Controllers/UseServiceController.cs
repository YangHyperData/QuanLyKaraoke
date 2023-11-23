using QLKaraoke.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QLKaraoke.Controllers
{
    public class UseServiceController : Controller
    {
        QLKARAOKEEntities db = new QLKARAOKEEntities();
        // GET: UseService
        public ActionResult Index()
        {
            return View();
        }
        public List<SuDungDichVu> TakeCart()
        {
            List<SuDungDichVu> lstCart = Session["SuDungDichVu"] as List<SuDungDichVu>;
            if (lstCart == null)
            {
                lstCart = new List<SuDungDichVu>();
                Session["SuDungDichVu"] = lstCart;
            }
            return lstCart;
        }
        public ActionResult AddCart(int ms, string url, FormCollection f)
        {
            List<SuDungDichVu> lstCart = TakeCart();
            SuDungDichVu sp = lstCart.Find(n => n.IDDv == ms);
            if (sp == null)
            {
                var product = db.DichVu1.FirstOrDefault(n => n.IDDichVu.Equals(ms));
                sp = new SuDungDichVu();
                sp.IDDv = ms;
                sp.SoLuong = 1;
                sp.Ten = product.Ten;
                sp.Gia = product.TongGia;
                sp.TenDVT = product.DVT;
                sp.TenLoai = product.LoaiDV;
                lstCart.Add(sp);
            }
            else
            {
                sp.SoLuong++;
            }
            return Redirect(url);
        }
        public ActionResult AddCartAll(int ms, string url, FormCollection f)
        {
            List<SuDungDichVu> lstCart = TakeCart();
            SuDungDichVu sp = lstCart.Find(n => n.IDDv == ms);
            if (sp == null)
            {
                var product = db.DichVu1.FirstOrDefault(n => n.IDDichVu.Equals(ms));
                sp = new SuDungDichVu();
                sp.IDDv = ms;
                sp.SoLuong = int.Parse(f["SoLuong"].ToString());
                sp.Ten = product.Ten;
                sp.Gia = product.TongGia;
                sp.TenDVT = product.DVT;
                sp.TenLoai = product.LoaiDV;
                lstCart.Add(sp);
            }
            else
            {
                sp.SoLuong += int.Parse(f["SoLuong"].ToString());
            }
            return Redirect(url);
        }
        private int SumCart()
        {
            int sum = 0;
            List<SuDungDichVu> lstCart = Session["SuDungDichVu"] as List<SuDungDichVu>;
            if (lstCart != null)
            {
                sum = (int)lstCart.Sum(n => n.SoLuong);
            }
            return sum;
        }
        private double Total()
        {
            double sum = 0;
            List<SuDungDichVu> lstCart = Session["SuDungDichVu"] as List<SuDungDichVu>;
            if (lstCart != null)
            {
                sum =(double)lstCart.Sum(n => n.Gia*n.SoLuong);
            }
            return sum;
        }
        public ActionResult Cart()
        {

            List<SuDungDichVu> lstCart = TakeCart();

            ViewBag.SumCart = SumCart();
            ViewBag.Total = Total();
            return View(lstCart);
        }
        public ActionResult DeleteCart(int? iProductID)
        {
            List<SuDungDichVu> lstCart = TakeCart();
            SuDungDichVu sp = lstCart.SingleOrDefault(n => n.IDDv == iProductID);
            if (sp != null)
            {
                lstCart.RemoveAll(n => n.IDDv == iProductID);
                if (lstCart.Count == 0)
                {
                    return RedirectToAction("Index", "Home");
                }
            }
            return RedirectToAction("Cart");
        }
        public ActionResult Cart_partial()
        {
            ViewBag.SumCart = SumCart();
            ViewBag.Total = Total();
            return PartialView();
        }
        public ActionResult UpdateCart(int? iProductID, int SoLuong)
        {
            List<SuDungDichVu> lstCart = TakeCart();
            SuDungDichVu sp = lstCart.SingleOrDefault(n => n.IDDv == iProductID&&n.SoLuong>0);
            if (sp != null)
            {
                sp.SoLuong = SoLuong;
            }
            return RedirectToAction("Cart");
        }

        public ActionResult DeleteCart1()
        {
            List<SuDungDichVu> lstCart = TakeCart();
            lstCart.Clear();
            return RedirectToAction("Index", "Home");
        }

        public ActionResult Order()
        {
            if (Session["CEmail"] == null || Session["CEmail"].ToString() == "")
            {
                return Redirect("~/Security/Login");
            }

            // Check if there are items in the cart
            if (Session["SuDungDichVu"] == null)
            {
                return RedirectToAction("Index", "Home");
            }

            var khachHang = (KhachHangg)Session["CInfo"];
            List<SuDungDichVu> lstCart = TakeCart();
            double total = Total();
            var currentDate = DateTime.Now;
            var currentTime = DateTime.Now.TimeOfDay;

            // Get the list of reservations made by the customer within the current time range
            var datPhongs = db.DatPhongs
                .Where(dp => dp.IdKH == khachHang.ID && dp.TrangThaiNhan == true && dp.Ngay == DateTime.Today && dp.TimeEnd >= currentTime)
                .OrderBy(dp => dp.TimeStar)
                .ToList();

            // Get the list of items in the DichVu1 table
            var dichVus = db.DichVu1.ToList();

            // Check if the number of items in the cart is less than or equal to the quantity in the DichVu1 table
            foreach (var item in lstCart)
            {
                var dichVu = dichVus.FirstOrDefault(dv => dv.IDDichVu == item.IDDv);
                if (dichVu != null && item.SoLuong > dichVu.SoLuong)
                {
                    TempData["ErrorMessage"] = $"Số lượng của {dichVu.Ten} trong giỏ hàng vượt quá số lượng dịch vụ vu lòng đặt nhỏ hơn {dichVu.SoLuong}.";
                    return RedirectToAction("Cart", "UseService");
                }
            }


            // Create an OrderViewModel object and pass the data to it
            var viewModel = new OrderViewModel
            {
                KhachHang = khachHang,
                DatPhongs = datPhongs,
                ListCart = lstCart,
                Total = total
            };

            return View(viewModel);
        }

        [HttpPost]
        public ActionResult Order(SuDungDichVu model)
        {
            List<SuDungDichVu> lstCart = TakeCart();
            if (ModelState.IsValid)
            {
                var khachHangg = (KhachHangg)Session["CInfo"];
                int selectedDatPhongId = int.Parse(Request.Form["DatPhongs"]);

                // Get the DatPhong object for the current reservation
                var datPhong = db.DatPhongs.SingleOrDefault(dp => dp.Id == selectedDatPhongId);
                ViewBag.Total = Total();

                // Save the values to the SuDungDichVu model
                double totalPrice = 0;
                foreach (var item in lstCart)
                {
                    SuDungDichVu suDungDichVu = new SuDungDichVu
                    {
                        Ten = item.Ten,
                        IDDv = item.IDDv,
                        SoLuong = item.SoLuong,
                        Gia = item.Gia,
                        TenDVT = item.TenDVT,
                        TenLoai = item.TenLoai,
                        Idkh = khachHangg.ID,
                        NgayTao = datPhong.Ngay,
                        ThoiGianBatDat = datPhong.TimeStar,
                        IdDP = selectedDatPhongId,
                        TrangThai= false
                    };

                    db.SuDungDichVus.Add(suDungDichVu);

                    // Update the quantity of the corresponding DichVu object
                    var dichVu = db.DichVu1.SingleOrDefault(dv => dv.IDDichVu == item.IDDv);
                    if (dichVu != null)
                    {
                        dichVu.DaBan += item.SoLuong;
                        dichVu.SoLuong -= item.SoLuong;
                    }

                    totalPrice = ViewBag.Total = Total();
                }

                // Update the TienDichVu field in the DatPhong table
                datPhong.TienDichVu += totalPrice;
                datPhong.ThanhTien += datPhong.TienDichVu;

                db.Entry(datPhong).State = EntityState.Modified;
                db.SaveChanges();

                // Clear the cart and redirect to the confirmation page
                Session.Remove("SuDungDichVu");
                Session.Remove("CartCount");

                return RedirectToAction("Confirmation", new { id = datPhong.Id });
            }

            // If the model state is not valid, return to the order page
            var khachHang = (KhachHangg)Session["CInfo"];
            double total = Total();
            var currentDate = DateTime.Now;
            var currentTime = DateTime.Now.TimeOfDay;

            //Lấy danh sách các đặt phòng của khách hàng trong khoảng thời gian hiện tại
            var datPhongs = db.DatPhongs.Where(dp => dp.IdKH == khachHang.ID && dp.TrangThaiNhan == true && dp.Ngay == DateTime.Today && dp.TimeEnd >= currentTime)
                .OrderBy(dp => dp.TimeStar)
               
                .ToList();
            //Lấy thông tin bảng Dịch vụ
            var dichVus = db.DichVu1.ToList();

            //Tạo đối tượng OrderViewModel và truyền dữ liệu vào
            var viewModel = new OrderViewModel
            {
                KhachHang = khachHang,
                DatPhongs = datPhongs,
                ListCart = lstCart,
                Total = total
            };

            return View(viewModel);
        }
        public ActionResult Confirmation(int id)
        {
            var datPhong = db.DatPhongs.FirstOrDefault(d => d.Id == id);
            if (datPhong == null)
            {
                return HttpNotFound();
            }
            return View(datPhong);
        }






    }
}