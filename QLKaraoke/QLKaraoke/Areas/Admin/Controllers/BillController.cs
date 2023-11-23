using System;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Net;
using System.Web.Mvc;
using QLKaraoke.Models;
using PagedList;
using System.Collections.Generic;
using System.Drawing.Printing;

namespace QLKaraoke.Areas.Admin.Controllers
{
    public class BillController : Controller
    {
        private QLKARAOKEEntities db = new QLKARAOKEEntities();

        public ActionResult Index(DateTime? ngaytao, int? page, string madat, string ten, string sdt)
        {
            var hOADONs = db.HOADONs.Include(h => h.DatPhong);

            if (ngaytao.HasValue)
            {
                hOADONs = hOADONs.Where(l => l.Ngay == ngaytao.Value);
            }

            if (!string.IsNullOrEmpty(madat))
            {
                hOADONs = hOADONs.Where(l => l.DatPhong.MaDat.Contains(madat));
            }
            if (!string.IsNullOrEmpty(ten))
            {
                hOADONs = hOADONs.Where(l => l.DatPhong.KhachHangg.Name.ToLower().Contains(ten.ToLower()));
            }
            if (!string.IsNullOrEmpty(sdt))
            {
                hOADONs = hOADONs.Where(l => l.DatPhong.KhachHangg.Phone.ToLower().Contains(sdt.ToLower()));
            }
          
            int pageSize = 10; // số lượng lịch đặt phòng trên mỗi trang
            int pageNumber = (page ?? 1); // số trang hiện tại (nếu không có thì mặc định là trang 1)

            return View(hOADONs.OrderByDescending(n => n.Ngay == DateTime.Today && n.TrangThai == false || n.TrangThai == false).ThenByDescending(n => n.Ngay > DateTime.Now).ThenByDescending(n => n.IDHoaDon)
                           .ToPagedList(pageNumber, pageSize));
        }
 

        public ActionResult Edit1(int id)
        {
            var hoaDon = db.HOADONs.Find(id);
            if (hoaDon == null)
            {
                return HttpNotFound();
            }

            hoaDon.TrangThai = true;
            db.SaveChanges();

            return RedirectToAction("Details", new { id = id });
        }


        // GET: Admin/Bill/Details/5
        public async Task<ActionResult> Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            var hoadon = await db.HOADONs.FindAsync(id);
            if (hoadon == null)
            {
                return HttpNotFound();
            }
          
            var suDungDichVus = await db.SuDungDichVus.Where(x => x.IdDP == hoadon.IDDatPhong).ToListAsync();

            var viewModel = new BillDetailsViewModel
            {
                hOADONs = hoadon,
                suDungDichVus = suDungDichVus,
                TongTien = TinhTongTien(suDungDichVus)
            };

            return View(viewModel);
        }


        public async Task<ActionResult> Edit2(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            var suDungDichVu = await db.SuDungDichVus.FindAsync(id);
            if (suDungDichVu == null)
            {
                return HttpNotFound();
            }

            return  View(suDungDichVu); // Chuyển hướng về trang danh sách sản phẩm.
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit2(int id, int soLuong)
        {
            var suDungDichVu = await db.SuDungDichVus.FindAsync(id);

            if (suDungDichVu == null)
            {
                return HttpNotFound();
            }

            var soLuongCu = suDungDichVu.SoLuong;
            var donGia = suDungDichVu.Gia;

            suDungDichVu.SoLuong = soLuong;

            db.Entry(suDungDichVu).State = EntityState.Modified;
            await db.SaveChangesAsync();

            // Find the HOADON that has the same IDDP as the SudungDichVu's DatPhong
            var hoadon = await db.HOADONs.FirstOrDefaultAsync(x => x.IDDatPhong == suDungDichVu.IdDP);

            if (hoadon == null)
            {
                return HttpNotFound();
            }
            var dichvu1 = await db.DatPhongs.FirstOrDefaultAsync(x => x.Id == suDungDichVu.IdDP);
            var dichvu = await db.DichVu1.FirstOrDefaultAsync(x => x.IDDichVu == suDungDichVu.IDDv);
            var tiendichvu = hoadon.TienDv;
            var thanhtien = hoadon.ThanhTien;
            var dich = dichvu.DaBan;
            var dichv = dichvu.SoLuong;
            var giam = hoadon.TienGiam;
            var tang = hoadon.TienThem;
            if (soLuong > soLuongCu)
            {
                tiendichvu += (soLuong - soLuongCu) * donGia;
               tang= (soLuong - soLuongCu) * donGia;
               giam = 0;
                dich += (soLuong - soLuongCu);
                thanhtien += (soLuong - soLuongCu) * donGia;
                dichv += (soLuong - soLuongCu);
            }
            else
            {
                tiendichvu -= (soLuongCu - soLuong) * donGia;
               giam = (soLuongCu - soLuong) * donGia;
               tang = 0;
                dich -= (soLuongCu - soLuong);
                dichv -= (soLuongCu - soLuong);
                thanhtien -= (soLuongCu - soLuong) * donGia;
            }
            hoadon.TienThem = tang;
            hoadon.TienGiam = giam;
            dichvu.SoLuong = dichv;
            dichvu.DaBan = dich;
            hoadon.TienDv = tiendichvu;
            dichvu1.TienDichVu=tiendichvu;
            dichvu1.ThanhTien = thanhtien;
            hoadon.ThanhTien = thanhtien;

            db.Entry(hoadon).State = EntityState.Modified;
            await db.SaveChangesAsync();

            return RedirectToAction("Details", "Bill", new { id = hoadon.IDHoaDon });
        }

        public double TinhTongTien(List<SuDungDichVu> danhSachSuDungDichVu)
        {
            double tong = 0;
            foreach (var suDungDichVu in danhSachSuDungDichVu)
            {
               tong += (double)(suDungDichVu.Gia * suDungDichVu.SoLuong);
            }
            return tong;
        }



     
        public async Task<ActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            HOADON hOADON = await db.HOADONs.FindAsync(id);
            if (hOADON == null)
            {
                return HttpNotFound();
            }
            ViewBag.IDDatPhong = new SelectList(db.DatPhongs, "Id", "MaGG", hOADON.IDDatPhong);
            return View(hOADON);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public async Task<ActionResult> Edit(HOADON hOADON)
        {
            if (ModelState.IsValid)
            {
                HOADON hOADONToUpdate = await db.HOADONs.FindAsync(hOADON.IDHoaDon);
                if (hOADONToUpdate == null)
                {
                    return HttpNotFound();
                }
                hOADONToUpdate.NoiDung = hOADON.NoiDung;
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            ViewBag.IDDatPhong = new SelectList(db.DatPhongs, "Id", "MaGG", hOADON.IDDatPhong);
            return View(hOADON);
        }




        // GET: Admin/Bill/Delete/5
        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            HOADON hOADON = await db.HOADONs.FindAsync(id);
            if (hOADON == null)
            {
                return HttpNotFound();
            }
            return View(hOADON);
        }

        // POST: Admin/Bill/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteConfirmed(int id)
        {
            HOADON hOADON = await db.HOADONs.FindAsync(id);
            db.HOADONs.Remove(hOADON);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
        }

     
    }
}
