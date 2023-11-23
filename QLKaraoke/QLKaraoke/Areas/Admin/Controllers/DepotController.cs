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
using PagedList;

namespace QLKaraoke.Areas.Admin.Controllers
{
    public class DepotController : Controller
    {
        private QLKARAOKEEntities db = new QLKARAOKEEntities();

        // GET: Admin/Depot
  
        public ActionResult Index(string searchQuery, int? page, int? id)
        {
            var khoHangs = db.KhoHangs.Include(k => k.DonViTinh).Include(k => k.LoaiDV1);

            if (!string.IsNullOrEmpty(searchQuery))
            {
                khoHangs = khoHangs.Where(d => d.TenMatHang.Contains(searchQuery));
            }
            int pageSize = 10; // số lượng lịch đặt phòng trên mỗi trang
            int pageNumber = (page ?? 1); // số trang hiện tại (nếu không có thì mặc định là trang 1)
            return View(khoHangs.OrderByDescending(n => n.IDMatHang).ToPagedList(pageNumber, pageSize));
        }
      

        // GET: Admin/Depot/Details/5
        public async Task<ActionResult> Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            KhoHang khoHang = await db.KhoHangs.FindAsync(id);
            if (khoHang == null)
            {
                return HttpNotFound();
            }
            return View(khoHang);
        }

        // GET: Admin/Depot/Create
        public ActionResult Create()
        {
            ViewBag.IDDonVT = new SelectList(db.DonViTinhs, "IDDonVT", "TenDonVi");
            ViewBag.LoaiDv = new SelectList(db.LoaiDVs, "ID", "TenDV");
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create([Bind(Include = "IDMatHang,TenMatHang,DonGia,SoLuong,NgayCapNhat,LoaiDv,IDDonVT")] KhoHang khoHang)
        {
            if (ModelState.IsValid)
            {
                db.KhoHangs.Add(khoHang);
                await db.SaveChangesAsync();

                // Cập nhật số lượng và tổng giá của sản phẩm trong bảng KhoHang
                var dichVus = db.DichVu1.Where(d => d.IDKhoHang == khoHang.IDMatHang).ToList();
                int soldQuantity = 0;
                foreach (var dv in dichVus)
                {
                    soldQuantity += dv.SoLuong ?? 0;
                }
                khoHang.NgayCapNhat = DateTime.Now;
                khoHang.Soluongthem = 0;
                khoHang.ConLai = khoHang.SoLuong - soldQuantity;
                khoHang.TongGia = khoHang.DonGia * khoHang.ConLai;
                TimeSpan gio = DateTime.Now.TimeOfDay;
                var ctKhoHang = new CTKhoHang
                {
                  
                    TenSP = khoHang.TenMatHang,
                    SoLuong = khoHang.SoLuong,
                    Ngay = khoHang.NgayCapNhat,
                    ConLai= khoHang.ConLai,
                    TrangThai = false,
                    IdKh = khoHang.IDMatHang,
                    Gio = gio
                };
                db.CTKhoHangs.Add(ctKhoHang);
                db.Entry(khoHang).State = EntityState.Modified;
                await db.SaveChangesAsync();

                return RedirectToAction("Index");
            }

            ViewBag.IDDonVT = new SelectList(db.DonViTinhs, "IDDonVT", "TenDonVi", khoHang.IDDonVT);
            ViewBag.LoaiDv = new SelectList(db.LoaiDVs, "IDLoaiDV", "TenLoaiDV", khoHang.LoaiDv);
            return View(khoHang);
        }


        // GET: Admin/Depot/Edit/5
        public async Task<ActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            KhoHang khoHang = await db.KhoHangs.FindAsync(id);
            if (khoHang == null)
            {
                return HttpNotFound();
            }
            ViewBag.IDDonVT = new SelectList(db.DonViTinhs, "IDDonVT", "TenDonVi", khoHang.IDDonVT);
            ViewBag.LoaiDv = new SelectList(db.LoaiDVs, "ID", "TenDV", khoHang.LoaiDv);
            return View(khoHang);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include = "IDMatHang,TenMatHang,DonGia,SoLuong,NgayCapNhat,LoaiDv,IDDonVT,ConLai,TongGia,Soluongthem")] KhoHang khoHang)
        {
            if (ModelState.IsValid)
            {
                // Retrieve the existing entity from the database
                var existingKhoHang = await db.KhoHangs.FindAsync(khoHang.IDMatHang);

                // Update the properties of the existing entity with the new values from the model
                existingKhoHang.TenMatHang = khoHang.TenMatHang;
                existingKhoHang.DonGia = khoHang.DonGia;
                existingKhoHang.SoLuong = existingKhoHang.SoLuong + (int)khoHang.Soluongthem; // updated here
                existingKhoHang.NgayCapNhat = DateTime.Now;
                existingKhoHang.IDDonVT = khoHang.IDDonVT;
                existingKhoHang.LoaiDv = khoHang.LoaiDv;
                existingKhoHang.ConLai = (int)(existingKhoHang.SoLuong + khoHang.Soluongthem);
                // Calculate the ConLai and TongGia properties
                var dichVus = await db.DichVu1.Where(dv => dv.IDKhoHang == khoHang.IDMatHang).ToListAsync();
                if (dichVus != null)
                {
                    var soLuongDaBan = dichVus.Sum(dv => dv.SoLuong ?? 0);
                    existingKhoHang.ConLai = existingKhoHang.SoLuong - soLuongDaBan;
                   
                }
                else
                {
                    existingKhoHang.ConLai = existingKhoHang.SoLuong;
                }
         
                existingKhoHang.TongGia = existingKhoHang.DonGia * existingKhoHang.SoLuong;
                TimeSpan gio = DateTime.Now.TimeOfDay;
                if(khoHang.Soluongthem > 0)
                {
                     var ctKhoHang = new CTKhoHang
                        {

                            TenSP = existingKhoHang.TenMatHang,
                            SoLuong = khoHang.Soluongthem,
                            Ngay = DateTime.Now,
                            ConLai = existingKhoHang.ConLai,
                            TrangThai = false,
                            IdKh = existingKhoHang.IDMatHang,
                            Gio= gio
                        };
                    db.CTKhoHangs.Add(ctKhoHang);
                }
               
              
                // Update the related DichVu objects
                var relatedDichVus = await db.DichVu1.Where(dv => dv.IDKhoHang == khoHang.IDMatHang).ToListAsync();
                var donViTinh = await db.DonViTinhs.FindAsync(existingKhoHang.IDDonVT);
                var loaiDv = await db.LoaiDVs.FindAsync(existingKhoHang.LoaiDv);
                foreach (var dv in relatedDichVus)
                {
                    dv.IDDVT = existingKhoHang.IDDonVT;
                    dv.DonGia = existingKhoHang.DonGia;
                    dv.IdLoai = existingKhoHang.LoaiDv;
                    dv.DVT = donViTinh.TenDonVi;
                    dv.LoaiDV = loaiDv.TenDV;
                    dv.TongGia = (double)(dv.DonGia + dv.GiaBan);

                }
              

                // Call the SaveChanges method to update the database
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            ViewBag.IDDonVT = new SelectList(db.DonViTinhs, "IDDonVT", "TenDonVi", khoHang.IDDonVT);
            ViewBag.LoaiDv = new SelectList(db.LoaiDVs, "ID", "TenDV", khoHang.LoaiDv);
            return View(khoHang);
        }


        // GET: Admin/Depot/Delete/5
        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            KhoHang khoHang = await db.KhoHangs.FindAsync(id);
            if (khoHang == null)
            {
                return HttpNotFound();
            }
            return View(khoHang);
        }

        // POST: Admin/Depot/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteConfirmed(int id)
        {
            KhoHang khoHang = await db.KhoHangs.FindAsync(id);
            db.KhoHangs.Remove(khoHang);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
        }

    
    }
}
