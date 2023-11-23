using PagedList;
using QLKaraoke.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net.NetworkInformation;
using System.Threading.Tasks;
using System.Web;
using System.Web.Configuration;
using System.Web.Mvc;
using System.Web.WebPages;
using static System.Data.Entity.Infrastructure.Design.Executor;

namespace QLKaraoke.Controllers
{
    public class HomeController : Controller
    {
        QLKARAOKEEntities db = new QLKARAOKEEntities();
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }
        public ActionResult Contact()
        {

            return View();
        }
        [HttpPost]
        [ValidateInput(false)]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Contact([Bind(Include = "Id,TenKH,NoiDung,SDT,Email,TrangThai")] LienHe lienHe)
        {

            if (ModelState.IsValid)
            {

                lienHe.NgayLH = DateTime.Now;
                lienHe.TrangThai = 2;
                db.LienHes.Add(lienHe);
                db.SaveChanges();
                TempData["SuccessMessage"] = "Gửi liên hệ thành công! Chúng tôi sẽ liên lạc với bạn trong thời gian sớm nhất.";
                return RedirectToAction("Contact", "Home");
            }

            return View(lienHe);
        }
        [ChildActionOnly]
        public ActionResult LatestServices()
        {
            var latestServices = db.DichVu1.Where(s => s.SoLuong > 0).OrderByDescending(s => s.IDDichVu).Take(4).ToList();
            return PartialView(latestServices);
        }
        public ActionResult ProductDetail(int id)
        {
            var product = db.DichVu1.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }
        [ChildActionOnly]
        public ActionResult _Room()
        {
            var Room1 = db.Phongs.Where(s => s.TrangThai == true).OrderByDescending(s => s.IDPhong).Take(4).ToList();
            return PartialView(Room1);
        }

        public ActionResult ServicesType(int? page, int? id)
        {
            int PageNum = (page ?? 1);
            int PageSize = 6;
            var Services1 = db.DichVu1.Where(d => d.IdLoai == id).ToList();
            return PartialView(Services1.OrderBy(n => n.IDDichVu).ToPagedList(PageNum, PageSize));
        }
        public ActionResult Services(int? page, string searchString)
        {
            int PageNum = (page ?? 1);
            int PageSize = 6;
            var Services1 = db.DichVu1.ToList();

            // Lọc dịch vụ theo từ khóa tìm kiếm
            if (!String.IsNullOrEmpty(searchString))
            {
                Services1 = Services1.Where(s => s.Ten.Contains(searchString)).ToList();
            }

            return PartialView(Services1.OrderBy(n => n.IDDichVu).ToPagedList(PageNum, PageSize));
        }

        public ActionResult Categories()
        {
            var categories = db.LoaiDVs.ToList();
            return PartialView("_Categories", categories);
        }
        public ActionResult TypeRoom()
        {
            var TypeRoom1 = db.LoaiPhongs.ToList();
            return PartialView("_TypeRoom", TypeRoom1);
        }
        public ActionResult Room(int? page)
        {
            int PageNum = (page ?? 1);
            int PageSize = 6;
            var Room1 = db.Phongs.ToList();
            return PartialView(Room1.OrderBy(n => n.IDPhong).ToPagedList(PageNum, PageSize));
        }
        public ActionResult RoomType(int? page, int? id)
        {
            ViewBag.id = id;
            int PageNum = (page ?? 1);
            int PageSize = 6;
            var RoomType1 = db.Phongs.Where(d => d.IDLoaiPhong == id).ToList();
            return PartialView(RoomType1.OrderBy(n => n.IDPhong).ToPagedList(PageNum, PageSize));
        }
        public ActionResult RoomDetail(int? id, DateTime? selectedDate, TimeSpan? timeStart, TimeSpan? timeEnd)
        {


            var currentTime = DateTime.Now.TimeOfDay;
            var room = db.Phongs.Find(id);

            if (room == null)
            {
                return HttpNotFound();
            }
            else
            {
                DateTime searchDate;
                if (selectedDate.HasValue && selectedDate.Value >= DateTime.Now.Date)
                {
                    searchDate = selectedDate.Value.Date;
                }
                else
                {
                    searchDate = DateTime.Now.Date;
                }
                List<DatPhong> bookings;
                if (searchDate == DateTime.Now.Date)
                {
                    bookings = db.DatPhongs.Where(b => b.IdPhong == id
                                                       && b.IdLoai == room.IDLoaiPhong
                                                       && b.Ngay == searchDate
                                                     )
                                           .OrderBy(b => b.Ngay)
                                           .ThenBy(b => b.TimeStar)
                                           .ToList();
                }
                else
                {
                    bookings = db.DatPhongs.Where(b => b.IdPhong == id
                                                       && b.IdLoai == room.IDLoaiPhong
                                                       && b.Ngay == searchDate)
                                           .OrderBy(b => b.Ngay)
                                           .ThenBy(b => b.TimeStar)
                                           .ToList();
                }

                ViewBag.TimeStart = bookings.Select(b => b.TimeStar).ToList();
                ViewBag.TimeEnd = bookings.Select(b => b.TimeEnd).ToList();
                ViewBag.SearchDate = searchDate;


            }

            return View(room);
        }

        public ActionResult BookRoom1(int? id, int? idLoai, DateTime? selectedDate, TimeSpan? timeStart, TimeSpan? timeEnd)
        {
            if (Session["CInfo"] == null)
            {
                return RedirectToAction("Login", "Security");
            }
            var room = db.Phongs.FirstOrDefault(d => d.IDPhong == id && d.IDLoaiPhong == idLoai);
            if (timeStart == null || timeEnd == null)
            {
                TempData["ErrorMessage"] = $"Vui lòng chọn thời gia đặt phòng.";

                return RedirectToAction("RoomDetail", "Home", new { id = room.IDPhong });
            }
            else
            {
                double day = 0;
                ViewBag.time = timeStart;
                ViewBag.timeEnd = timeEnd;
                double tienLich = 0;

                var dayOfWeekDict = new Dictionary<string, string>
            {
                { "Monday", "Thứ Hai" },
                { "Tuesday", "Thứ Ba" },
                { "Wednesday", "Thứ Tư" },
                { "Thursday", "Thứ Năm" },
                { "Friday", "Thứ Sáu" },
                { "Saturday", "Thứ Bảy" },
                { "Sunday", "Chủ Nhật" }
            };

                var dayOfWeekName = dayOfWeekDict[selectedDate.Value.DayOfWeek.ToString()];
                var dayOfWeek = db.DaysOfWeeks.FirstOrDefault(d => d.Name.ToLower() == dayOfWeekName.ToLower());
                var gio = DateTime.Now.TimeOfDay;
                if (dayOfWeek != null)
                {

                    day = (double)dayOfWeek.Gia;
                }
              
                if (room == null)
                {
                    return HttpNotFound();
                }

             

                var khachHang = (KhachHangg)Session["CInfo"];

                // Kiểm tra thời gian bắt đầu và kết thúc có hợp lệ hay không.
                if (timeEnd <= timeStart)
                {
                    TempData["ErrorMessage"] = ("Thời gian kết thúc phải lớn hơn thời gian bắt đầu.");
                    return RedirectToAction("RoomDetail", "Home", new { id = room.IDPhong });
                }


                // Kiểm tra xem thời gian bắt đầu và kết thúc vừa chọn có trùng với bất kỳ DatP nào của phòng và loại phòng tương ứng không.
                var isExist = db.DatPhongs.FirstOrDefault(d => d.IdPhong == id && d.IdLoai == idLoai && d.Ngay == selectedDate && ((d.TimeStar <= timeStart && timeStart < d.TimeEnd) || (d.TimeStar < timeEnd && timeEnd <= d.TimeEnd) || (timeStart <= d.TimeStar && d.TimeEnd <= timeEnd)));



                tienLich = (double)(room.LoaiPhong.DonGia + day) + (double)(room.DonGia *
                           Math.Round((timeEnd.Value - timeStart.Value).TotalHours, 2));

                if (isExist != null)
                {
                    TempData["ErrorMessage"] = $"Thời gian này đã được đặt. Vui lòng chọn thời gian khác.";

                    return RedirectToAction("RoomDetail", "Home", new { id = room.IDPhong });

                }
                else
                {

                    if (selectedDate == DateTime.Today && timeStart < gio)
                    {
                        TempData["ErrorMessage"] = $"Thời gian này bắt đấu hát phải lớn hơn thời gian {gio}";
                        return RedirectToAction("RoomDetail", "Home", new { id = room.IDPhong });
                    }
                    else
                    {
                        var booking = new DatPhong();
                        var roomDetail = new LichDatP
                        {
                            IdKh = khachHang.ID,
                            IdLoai = room.IDLoaiPhong,
                            IdPhong = room.IDPhong,
                            Ngay = selectedDate.Value,
                            TimeStar = timeStart.Value,
                            TimeEnd = timeEnd.Value,
                            IdDate = dayOfWeek.ID,
                            TongGia = tienLich,

                        };
                        db.LichDatPs.Add(roomDetail);
                        db.SaveChanges();
                        ViewBag.ten = khachHang.Name;
                        ViewBag.MaPhong = room.IDPhong;
                        // Nếu không có DatP nào trùng khớp, tạo một đối tượng mới của lớp DatP và lưu thông tin đặt phòng.
                        ViewBag.time = Math.Round((timeEnd.Value - timeStart.Value).TotalHours, 2);
                        var model = new Tuple<LichDatP, DatPhong, KhachHangg>(roomDetail, booking, khachHang);
                        return View(model);
                    }


                }
            }


        }
        [HttpPost]
        public async Task<ActionResult> BookRoom1(DatPhong datPhong)
        {



            if (ModelState.IsValid)
            {
                var khachHang = (KhachHangg)Session["CInfo"];
                var lichDatPhong = db.LichDatPs
                          .Include(l => l.Phong)
                          .Include(l => l.Phong.LoaiPhong)
                          .OrderByDescending(l => l.Id)
                          .FirstOrDefault();

                if (lichDatPhong == null)
                {
                    return HttpNotFound();
                }
                datPhong.IdDate = lichDatPhong.IdDate;
                datPhong.IdLich = lichDatPhong.Id;
                datPhong.LoaiP = lichDatPhong.LoaiPhong.TenPhong;
                datPhong.TenPhong = lichDatPhong.Phong.TenPhong;
                datPhong.TimeStar = lichDatPhong.TimeStar;
                datPhong.TimeEnd = lichDatPhong.TimeEnd;
                datPhong.Ngay = lichDatPhong.Ngay;
                datPhong.TrangThaiNhan = false;
                datPhong.TrangThai = 2;
                datPhong.IdPhong = lichDatPhong.IdPhong;
                datPhong.IdLoai = lichDatPhong.IdLoai;
                datPhong.Tienlich = lichDatPhong.TongGia;


                if (khachHang != null)
                {
                    datPhong.IdKH = khachHang.ID;
                    if (datPhong.Sdt == null)
                    {
                        datPhong.Sdt = khachHang.Phone;

                    }
                    if (datPhong.Email == null)
                    {
                        datPhong.Email = khachHang.Email;
                    }
                }
                var discount = await db.GiammGias.FirstOrDefaultAsync(d => (d.Idk == datPhong.IdKH && d.TrangThai == false && d.Soluong > 0 && d.code == datPhong.MaGG) || (d.TrangThai == true && d.Soluong > 0 && d.code == datPhong.MaGG));
                if (discount != null)
                {


                    datPhong.TienGiamGia = discount.SoTien;
                    discount.Soluong--;
                    db.Entry(discount).State = EntityState.Modified;
                }
                else
                {
                    ModelState.AddModelError("MaGG", "Mã giảm giá không hợp lệ.");
                    datPhong.TienGiamGia = 0;

                }


                if (datPhong.TienDichVu == null)
                {
                    datPhong.TienDichVu = 0;
                }


                datPhong.TrangThai = 2;

                if (datPhong.TienGiamGia > 0 && datPhong.Tienlich > datPhong.TienGiamGia)
                {
                    datPhong.ThanhTien = datPhong.Tienlich - datPhong.TienGiamGia + datPhong.TienDichVu;
                }
                else
                {
                    datPhong.ThanhTien = datPhong.Tienlich + datPhong.TienDichVu;
                }

                string randomCode = Guid.NewGuid().ToString("N").Substring(0, 5).ToUpper();
                datPhong.MaDat = randomCode;
                db.DatPhongs.Add(datPhong);
                db.SaveChanges();
                return RedirectToAction("Success", new { id = datPhong.Id });
            }
            else
            {
                var khachHang = (KhachHangg)Session["CInfo"];
                var lichDatPhong = db.LichDatPs.Include(l => l.Phong).Include(l => l.Phong.LoaiPhong)
                                    .FirstOrDefault(l => l.Id == datPhong.IdLich);

                var model = new Tuple<KhachHangg, LichDatP, DatPhong>(khachHang, lichDatPhong, datPhong);

                return View("BookRoom", model);
            }
        }
        public ActionResult Success(int id)
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



