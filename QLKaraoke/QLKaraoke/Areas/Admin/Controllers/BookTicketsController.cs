using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Net;
using System.Web;
using System.Web.Mvc;
using QLKaraoke.Models;
using System.Globalization;
using System.Web.Services.Description;
using PagedList;

namespace QLKaraoke.Areas.Admin.Controllers
{
    public class BookTicketsController : Controller
    {
        private QLKARAOKEEntities db = new QLKARAOKEEntities();

        // GET: Admin/BookTickets

        public ActionResult Index(DateTime? Ngay, int? page, string madat, string ten, string sdt)
        {
            var datPhongs = db.DatPhongs.Include(d => d.GiammGia).Include(d => d.KhachHangg);

            if (Ngay.HasValue || !string.IsNullOrEmpty(madat) || !string.IsNullOrEmpty(ten) || !string.IsNullOrEmpty(sdt))
            {
                if (Ngay.HasValue)
                {
                    datPhongs = datPhongs.Where(l => l.Ngay == Ngay.Value);
                }
                if (!string.IsNullOrEmpty(madat))
                {
                    datPhongs = datPhongs.Where(l => l.MaDat.ToLower().Contains(madat.ToLower()));
                }
                if (!string.IsNullOrEmpty(ten))
                {
                    datPhongs = datPhongs.Where(l => l.KhachHangg.Name.ToLower().Contains(ten.ToLower()));
                }
                if (!string.IsNullOrEmpty(sdt))
                {
                    datPhongs = datPhongs.Where(l => l.KhachHangg.Phone.ToLower().Contains(sdt.ToLower()));
                }
                datPhongs = datPhongs.Where(l => l.TrangThaiNhan == false||l.TrangThaiNhan== true);
            }
            else
            {
                datPhongs = datPhongs.Where(l => l.TrangThaiNhan == false);
            }
            var gio = DateTime.Now.TimeOfDay;
            int pageSize = 10;
            int pageNumber = (page ?? 1);
            return View(datPhongs.OrderByDescending(n => n.Ngay == DateTime.Today&&n.TimeStar==gio&& n.TrangThaiNhan == false || n.TrangThaiNhan == false).ThenByDescending(n => n.Ngay >DateTime.Now).ThenByDescending(n => n.Id).ThenByDescending(n => n.IdPhong).ThenByDescending(n=>n.TimeStar)
                                 .ToPagedList(pageNumber, pageSize));
        }

        public ActionResult Index1(DateTime? Ngay, int? page, string madat, string ten, string sdt)
        {
            var datPhongs = db.DatPhongs.Include(d => d.GiammGia).Include(d => d.KhachHangg);

            if (Ngay.HasValue || !string.IsNullOrEmpty(madat) || !string.IsNullOrEmpty(ten) || !string.IsNullOrEmpty(sdt))
            {
                if (Ngay.HasValue)
                {
                    datPhongs = datPhongs.Where(l => l.Ngay == Ngay.Value);
                }
                if (!string.IsNullOrEmpty(madat))
                {
                    datPhongs = datPhongs.Where(l => l.MaDat.ToLower().Contains(madat.ToLower()));
                }
                if (!string.IsNullOrEmpty(ten))
                {
                    datPhongs = datPhongs.Where(l => l.KhachHangg.Name.ToLower().Contains(ten.ToLower()));
                }
                if (!string.IsNullOrEmpty(sdt))
                {
                    datPhongs = datPhongs.Where(l => l.KhachHangg.Phone.ToLower().Contains(sdt.ToLower()));
                }
                datPhongs = datPhongs.Where(l => l.TrangThaiNhan == true);
            }
            else
            {
                datPhongs = datPhongs.Where(l =>  l.TrangThaiNhan == true);
            }

            int pageSize = 10;
            int pageNumber = (page ?? 1);
            return View(datPhongs.OrderByDescending(n => n.Ngay == DateTime.Today && n.TrangThai == 2|| n.TrangThai == 2).ThenByDescending(n => n.Ngay >DateTime.Now).ThenByDescending(n => n.Id).ThenByDescending(n => n.IdPhong).ThenByDescending(n => n.TimeEnd)
                                 .ToPagedList(pageNumber, pageSize));
        }


        // GET: Admin/BookTickets/Details/5
        public async Task<ActionResult> Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DatPhong datPhong = await db.DatPhongs.FindAsync(id);
            if (datPhong == null)
            {
                return HttpNotFound();
            }

            return View(datPhong);
        }

        // GET: Admin/BookTickets/Create
        public ActionResult Create()
        {
            ViewBag.IdGG = new SelectList(db.GiammGias, "IdGG", "code");
            ViewBag.IdKH = new SelectList(db.KhachHanggs, "ID", "Name");

            ViewBag.IdDate = new SelectList(db.DaysOfWeeks, "ID", "Name");
            ViewBag.IdPhong = new SelectList(db.Phongs, "IDPhong", "TenPhong");
            ViewBag.IdTime = new SelectList(db.Times, "Id", "TimeStar");
            ViewBag.IdLoai = new SelectList(db.LoaiPhongs, "IDLoaiPhong", "TenPhong");
            return View();
        }

        // POST: Admin/BookTickets/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create([Bind(Include = "Id,IdDate,IdLoai,IdPhong,IdTime,TimeStar,TimeEnd,Ngay,IdKH,IdLich,TrangThai,IdGG,ThanhTien,MaGG,Sdt,Email,MaDat,TenPhong,TienGiamGia,TienDichVu,Tienlich,LoaiP,TrangThaiNhan")] DatPhong datPhong)
        {
            if (ModelState.IsValid)
            {



                // Lấy giá trị từ bảng LoaiPhong, Phong và DaysOfWeek
                var loaiPhong = db.LoaiPhongs.Find(datPhong.IdLoai);
                var phong = db.Phongs.Find(datPhong.IdPhong);
                var daysOfWeek = db.DaysOfWeeks.Find(datPhong.IdDate);

                // Tính toán tổng giá



                // Set giá trị cho datPhong
                datPhong.LoaiP = phong.LoaiPhong.TenPhong;

                datPhong.TrangThai = 2;
                datPhong.TenPhong = phong.TenPhong;

                datPhong.TrangThaiNhan = false;
                // Kiểm tra nếu lịch đặt phòng đã có sẵn trong cùng khoảng thời gian
                // check if the room is available during the requested time slot and within valid time range


                var khachHang = await db.KhachHanggs.FindAsync(datPhong.IdKH);
                if (khachHang != null)
                {
                    datPhong.IdKH = khachHang.ID;
                    datPhong.Sdt = khachHang.Phone;
                    datPhong.Email = khachHang.Email;
                }

                string randomCode = Guid.NewGuid().ToString("N").Substring(0, 5).ToUpper();
                datPhong.MaDat = randomCode;
                // check if the requested time slot overlaps with any existing bookings for the same room
                bool isExist = db.DatPhongs.Any(x => x.IdPhong == datPhong.IdPhong
                                         && x.IdLoai == datPhong.IdLoai
                                         && DbFunctions.TruncateTime(x.Ngay) == DbFunctions.TruncateTime(datPhong.Ngay)
                                  
                                         && x.TimeEnd != datPhong.TimeStar
                                         && x.TimeEnd != datPhong.TimeEnd
                                          && x.TimeStar != datPhong.TimeEnd
                                         && x.TimeStar != datPhong.TimeStar
                                         && (
                                               (x.TimeStar >= datPhong.TimeEnd || x.TimeEnd <= datPhong.TimeStar)
                                               || (x.TimeStar >= x.TimeEnd && x.TimeStar != datPhong.TimeEnd)
                                               || (datPhong.TimeStar >= x.TimeStar && datPhong.TimeStar < x.TimeEnd)
                                               || (datPhong.TimeEnd > x.TimeStar && datPhong.TimeEnd <= x.TimeEnd)
                                               || (x.TimeStar >= datPhong.TimeStar && x.TimeStar < datPhong.TimeEnd)
                                               || (x.TimeEnd > datPhong.TimeStar && x.TimeEnd <= datPhong.TimeEnd)
                                               || (x.TimeStar < datPhong.TimeStar && x.TimeEnd > datPhong.TimeEnd)
                                          )
                                 );

                if (isExist)
                {
                    TempData["Errr"] = string.Format(" Khoảng thời gian {0} - {1} đã được tạo ở phòng này.", datPhong.TimeStar.ToString(), datPhong.TimeEnd.ToString());
                }
                else
                {
                    var time = await db.Times.FirstOrDefaultAsync(t =>
                    (datPhong.TimeStar >= t.TimeStar && datPhong.TimeStar < t.TimeEnd)
                    || (datPhong.TimeEnd > t.TimeStar && datPhong.TimeEnd <= t.TimeEnd)
                    || (t.TimeStar >= datPhong.TimeStar && t.TimeStar < datPhong.TimeEnd)
                    || (t.TimeEnd > datPhong.TimeStar && t.TimeEnd <= datPhong.TimeEnd)
                    || (t.TimeStar < datPhong.TimeStar && t.TimeEnd > datPhong.TimeEnd)
                );

                    double gia = 0;
                    if (time != null)
                    {
                        datPhong.IdTime = time.Id;
                        gia = (double)time.Gia;
                    }
                    if (datPhong.TimeEnd.HasValue && datPhong.TimeStar.HasValue && (datPhong.TimeEnd.Value - datPhong.TimeStar.Value).TotalHours > 1)
                    {
                        if (loaiPhong != null && phong != null && daysOfWeek != null)
                        {
                            double tienLich = (double)(gia + loaiPhong.DonGia  + daysOfWeek.Gia) + (double)(phong.DonGia *
                               Math.Round((datPhong.TimeEnd.Value - datPhong.TimeStar.Value).TotalHours, 2));
                            datPhong.Tienlich = tienLich;
                        }
                    }
                    else
                    {
                        if (loaiPhong != null && phong != null && daysOfWeek != null)
                        {
                            double tienLich = (double)(gia + loaiPhong.DonGia + daysOfWeek.Gia) + (double)(phong.DonGia *
                                Math.Round((datPhong.TimeEnd.Value - datPhong.TimeStar.Value).TotalHours, 2));
                            datPhong.Tienlich = tienLich;
                        }
                    }




                    var discount = await db.GiammGias.FirstOrDefaultAsync(d =>
                                            (d.Idk == datPhong.IdKH && d.TrangThai == false && d.Soluong > 0 && d.code == datPhong.MaGG)
                                            || (d.TrangThai == true && d.Soluong > 0 && d.code == datPhong.MaGG));

                    if (discount != null)
                    {
                        datPhong.Id = discount.IdGG;
                        datPhong.TienGiamGia = discount.SoTien;
                        discount.Soluong--;
                        db.Entry(discount).State = EntityState.Modified;
                    }
                    else
                    {
                        ModelState.AddModelError("MaGG", "Mã giảm giá không hợp lệ.");
                        datPhong.TienGiamGia = 0;
                    }

                    datPhong.TienDichVu = 0;

                    if (datPhong.TienGiamGia != null && datPhong.TienGiamGia > 0 && datPhong.Tienlich > datPhong.TienGiamGia)
                    {
                        datPhong.ThanhTien = datPhong.TienDichVu + (datPhong.Tienlich - datPhong.TienGiamGia);
                    }
                    else if (datPhong.Tienlich < datPhong.TienGiamGia)
                    {
                        datPhong.ThanhTien = 0;
                    }
                    else
                    {
                        datPhong.ThanhTien = datPhong.Tienlich + datPhong.TienDichVu;
                    }

                    db.DatPhongs.Add(datPhong);
                    await db.SaveChangesAsync();
                    return RedirectToAction("Index");
                }
            }

            ViewBag.IdTime = new SelectList(db.Times, "Id", "TimeStar", datPhong.IdTime);
            ViewBag.IdDate = new SelectList(db.DaysOfWeeks, "ID", "Name", datPhong.IdDate);
            ViewBag.IdLoai = new SelectList(db.LoaiPhongs, "IDLoaiPhong", "TenPhong", datPhong.IdLoai);
            ViewBag.IdPhong = new SelectList(db.Phongs, "IDPhong", "TenPhong", datPhong.IdPhong);
            ViewBag.IdGG = new SelectList(db.GiammGias, "IdGG", "code", datPhong.IdGG);
            ViewBag.IdKH = new SelectList(db.KhachHanggs, "ID", "Name", datPhong.IdKH);

            return View(datPhong);
        }
        public JsonResult GetTimeStartAndTimeEnd(string ngay, int idLoai, int idPhong)
        {
            // Convert ngay string to DateTime object
            DateTime date = DateTime.ParseExact(ngay, "yy/MM/dd", CultureInfo.InvariantCulture);
            // Retrieve the DatPhong objects that match the given criteria
            var datPhongs = db.DatPhongs.Where(d => d.Ngay == date && d.IdLoai == idLoai && d.IdPhong == idPhong).ToList();

            // Create a list to store the timeStart and timeEnd values
            var timeList = new List<object>();

            // Loop through the DatPhong objects and add their timeStart and timeEnd values to the list
            foreach (var datPhong in datPhongs)
            {
                var time = new
                {
                    timeStart = datPhong.TimeStar,
                    timeEnd = datPhong.TimeEnd
                };
                timeList.Add(time);
            }

            return Json(timeList, JsonRequestBehavior.AllowGet);
        }


            public JsonResult GetRoomsByType(int IdLoai)
        {
            var rooms = db.Phongs.Where(p => p.IDLoaiPhong == IdLoai)
                                 .Select(p => new { value = p.IDPhong, text = p.TenPhong })
                                 .ToList();
            return Json(rooms, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public JsonResult GetDayOfWeek(int idDate)
        {
            var dayOfWeek = db.DaysOfWeeks.SingleOrDefault(d => d.ID == idDate);
            return Json(new { NameOfDay = dayOfWeek.Name, IdDate = dayOfWeek.ID });
        }

        [HttpPost]
        public ActionResult Details(DatPhong model, int? id)
        {
            if (ModelState.IsValid)
            {
                // Check if iddatphong matches id parameter
                if (model.Id == id)
                {
                    // Update the DatPhong object with the new state
                    var datPhong = db.DatPhongs.Find(model.Id);
                    if (datPhong.TrangThai == 1)
                    {
                        ViewBag.Message = "Phòng này đã được thanh toán.";
                        return View(model);
                    }
                    else
                    {
                        datPhong.TrangThai = 1;
                        db.Entry(datPhong).State = EntityState.Modified;
                        db.SaveChanges();

                        // Get the name of the customer with IdKH equal to datPhong.IdKH
                        var tenKh = db.KhachHanggs.Where(kh => kh.ID == datPhong.IdKH).Select(kh => kh.Name).FirstOrDefault();

                        // Create a new HoaDon object with the necessary properties
                        var hoaDon = new HOADON
                        {
                            IDDatPhong = datPhong.Id,
                            TenP = datPhong.TenPhong,
                            ThoiGianBatDau = datPhong.TimeStar,
                            ThoiGianKetThuc = datPhong.TimeEnd,
                            NoiDung = "Đặt phòng karaoke",
                            TienDv = datPhong.TienDichVu,
                            TienGG = datPhong.TienGiamGia,
                            TienPhong = datPhong.Tienlich,
                            ThanhTien = datPhong.ThanhTien,
                            Ngay = datPhong.Ngay,
                            Tenkh = tenKh,
                            TienThem = 0,
                            TienGiam = 0,
                            TrangThai = false,
                           
                        };

                        // Add the HoaDon object to the database and save changes
                        db.HOADONs.Add(hoaDon);
                        db.SaveChanges();

                        return RedirectToAction("Index1");
                    }
                }
            }

            return View(model);
        }

        public ActionResult Edit(int id)
        {
            DatPhong datPhong = db.DatPhongs.Find(id);
            if (datPhong == null)
            {
                return HttpNotFound();
            }

            if (datPhong.TrangThaiNhan == false)
            {
                datPhong.TrangThaiNhan = true;
                db.Entry(datPhong).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(datPhong);
        }
        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            DatPhong dp = await db.DatPhongs.FindAsync(id);
            if (dp == null)
            {
                return HttpNotFound();
            }



            db.DatPhongs.Remove(dp);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
        }

    }
}
