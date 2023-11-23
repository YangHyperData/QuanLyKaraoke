using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Drawing.Printing;
using System.IO;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using PagedList;
using QLKaraoke.Models;

namespace QLKaraoke.Areas.Admin.Controllers
{
    public class RoomController : Controller
    {
        private QLKARAOKEEntities db = new QLKARAOKEEntities();

        // GET: Admin/Phong
        public ActionResult Index(int? IdLoai, int? IdPhong, bool? trangThai, int? page)
        {
            var phongs = db.Phongs.Include(p => p.LoaiPhong);
            // Lọc theo id loại phòng (nếu có)
            if (IdLoai.HasValue)
            {
                phongs = phongs.Where(p => p.IDLoaiPhong == IdLoai.Value);
            }

            // Lọc theo id phòng (nếu có)
            if (IdPhong.HasValue)
            {
                phongs = phongs.Where(p => p.IDPhong == IdPhong.Value);
            }

            // Lọc theo trạng thái (nếu có)
            if (trangThai.HasValue)
            {
                phongs = phongs.Where(p => p.TrangThai == trangThai.Value);
            }
            ViewBag.IdLoai = new SelectList(db.LoaiPhongs, "IDLoaiPhong", "TenPhong");
            ViewBag.IdPhong = new SelectList(db.Phongs, "IDPhong", "TenPhong");
            int pageSize = 10; // số lượng phòng trên mỗi trang
            int pageNumber = (page ?? 1); // số trang hiện tại (nếu không có thì mặc định là trang 1)
            return View(phongs.OrderByDescending(n => n.IDPhong).ToPagedList(pageNumber, pageSize));
        }
            // GET: Admin/Phong/Create
            public ActionResult Create()
        {
            ViewBag.IDLoaiPhong = new SelectList(db.LoaiPhongs, "IDLoaiPhong", "TenPhong");
            return View();
        }

        // POST: Admin/Phong/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public ActionResult Create([Bind(Include = "TenPhong,DonGia,TrangThai,NgayTao,SoLuongNguoi,IDLoaiPhong,HinhAnh,NoiDung")] Phong phong, HttpPostedFileBase HinhAnh)
        {
            if (ModelState.IsValid)
            {
                if (HinhAnh != null && HinhAnh.ContentLength > 0)
                {
                    var fileName = Path.GetFileName(HinhAnh.FileName);
                    var path = Path.Combine(Server.MapPath("~/Areas/Admin/assets/img/"), fileName);
                    HinhAnh.SaveAs(path);
                    phong.HinhAnh = "~/Areas/Admin/assets/img/" + fileName;
                }
                phong.TrangThai = true;
                phong.NgayTao = DateTime.Now;
                db.Phongs.Add(phong);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.IDLoaiPhong = new SelectList(db.LoaiPhongs, "IDLoaiPhong", "TenPhong", phong.IDLoaiPhong);
            return View(phong);
        }
        public JsonResult GetRoomsByType(int IdLoai)
        {
            var rooms = db.Phongs.Where(p => p.IDLoaiPhong == IdLoai)
                                 .Select(p => new { value = p.IDPhong, text = p.TenPhong })
                                 .ToList();
            return Json(rooms, JsonRequestBehavior.AllowGet);
        }
        // GET: Admin/Phong/Edit/5
        public async Task<ActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Phong phong = await db.Phongs.FindAsync(id);
            if (phong == null)
            {
                return HttpNotFound();
            }
            ViewBag.IDLoaiPhong = new SelectList(db.LoaiPhongs, "IDLoaiPhong", "TenPhong", phong.IDLoaiPhong);
            return View(phong);
        }

        // POST: Admin/Phongs/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public async Task<ActionResult> Edit(Phong phong, HttpPostedFileBase HinhAnh)

        {

            if (ModelState.IsValid)
            {


                if (ModelState.IsValid)
                {
                    var existingPhong = db.Phongs.Find(phong.IDPhong);
                    if (existingPhong != null)
                    {
                        // Update the properties of the existing entity
                        existingPhong.TenPhong = phong.TenPhong;
                        existingPhong.DonGia = phong.DonGia;
                        existingPhong.TrangThai = phong.TrangThai;
                        existingPhong.SoLuongNguoi = phong.SoLuongNguoi;
                        existingPhong.IDLoaiPhong = phong.IDLoaiPhong;
                        existingPhong.NoiDung = phong.NoiDung;

                        if (HinhAnh != null && HinhAnh.ContentLength > 0)
                        {
                            var fileName = Path.GetFileName(HinhAnh.FileName);
                            var path = Path.Combine(Server.MapPath("~/Areas/Admin/assets/img/"), fileName);
                            HinhAnh.SaveAs(path);
                            existingPhong.HinhAnh = fileName;
                        }
                        else
                        {
                            // Keep the existing image
                            db.Entry(existingPhong).Property(c => c.HinhAnh).IsModified = false;
                        }

                        existingPhong.NgayTao = DateTime.Now;
                        await db.SaveChangesAsync();
                        return RedirectToAction("Index");
                    }
                }

            }
            ViewBag.IDLoaiPhong = new SelectList(db.LoaiPhongs, "IDLoaiPhong", "TenPhong", phong.IDLoaiPhong);
            return View(phong);

        }
        public ActionResult Details(int? id, DateTime? selectedDate, TimeSpan? timeStart, TimeSpan? timeEnd)
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

        

        // GET: Admin/Phong/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(System.Net.HttpStatusCode.BadRequest);
            }

            Phong phong = db.Phongs.Find(id);
            if (phong == null)
            {
                return HttpNotFound();
            }

            return View(phong);
        }

        // POST: Admin/Phong/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Delete(int id)
        {
            try
            {
                Phong phong = await db.Phongs.FindAsync(id);
                db.Phongs.Remove(phong);
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                // Check if the error message contains "FK_LichDatP_Phong"
                if (ex.Message.Contains("FK_LichDatP_Phong"))
                {
                    TempData["Error"] = "Không thể xóa phòng này vì đang có lịch đặt liên quan.";
                }
                else
                {
                    TempData["Error"] = "Đã xảy ra lỗi khi xóa phòng.";
                }

                return RedirectToAction("Index");
            }
        }

    }
}
