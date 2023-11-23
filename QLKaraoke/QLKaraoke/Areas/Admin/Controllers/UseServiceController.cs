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
    public class UseServiceController : Controller
    {
        private QLKARAOKEEntities db = new QLKARAOKEEntities();

        // GET: Admin/UseService

        public ActionResult Index(DateTime? ngaytao, int? page, string madat, string ten, string sdt)
        {
            var suDungDichVus = db.SuDungDichVus.Include(s => s.DichVu1).Include(s => s.KhachHangg).Include(s => s.DatPhong);


            if (ngaytao.HasValue || !string.IsNullOrEmpty(madat) || !string.IsNullOrEmpty(ten) || !string.IsNullOrEmpty(sdt))
            {
                if (ngaytao.HasValue)
                {
                    suDungDichVus = suDungDichVus.Where(l => l.NgayTao == ngaytao.Value);
                }
                if (!string.IsNullOrEmpty(madat))
                {
                    suDungDichVus = suDungDichVus.Where(l => l.DatPhong.MaDat.ToLower().Contains(madat.ToLower()));
                }
                if (!string.IsNullOrEmpty(ten))
                {
                    suDungDichVus = suDungDichVus.Where(l => l.KhachHangg.Name.ToLower().Contains(ten.ToLower()));
                }
                if (!string.IsNullOrEmpty(sdt))
                {
                    suDungDichVus = suDungDichVus.Where(l => l.KhachHangg.Phone.ToLower().Contains(sdt.ToLower()));
                }
                suDungDichVus = suDungDichVus.Where(l => l.TrangThai == false );
            }
            else
            {
                suDungDichVus = suDungDichVus.Where(l => l.TrangThai == false);
            }

            int pageSize = 10;
            int pageNumber = (page ?? 1);
            return View(suDungDichVus.OrderByDescending(n => n.NgayTao == DateTime.Today)
                               .ThenByDescending(n => n.ID)
                               .OrderByDescending(n => n.IdDP)
                               .ToPagedList(pageNumber, pageSize));

        }
        public ActionResult Index1(DateTime? ngaytao, int? page, string madat, string ten, string sdt)
        {
            var suDungDichVus = db.SuDungDichVus.Include(s => s.DichVu1).Include(s => s.KhachHangg).Include(s => s.DatPhong);


            if (ngaytao.HasValue || !string.IsNullOrEmpty(madat) || !string.IsNullOrEmpty(ten) || !string.IsNullOrEmpty(sdt))
            {
                if (ngaytao.HasValue)
                {
                    suDungDichVus = suDungDichVus.Where(l => l.NgayTao == ngaytao.Value);
                }
                if (!string.IsNullOrEmpty(madat))
                {
                    suDungDichVus = suDungDichVus.Where(l => l.DatPhong.MaDat.ToLower().Contains(madat.ToLower()));
                }
                if (!string.IsNullOrEmpty(ten))
                {
                    suDungDichVus = suDungDichVus.Where(l => l.KhachHangg.Name.ToLower().Contains(ten.ToLower()));
                }
                if (!string.IsNullOrEmpty(sdt))
                {
                    suDungDichVus = suDungDichVus.Where(l => l.KhachHangg.Phone.ToLower().Contains(sdt.ToLower()));
                }
                suDungDichVus = suDungDichVus.Where(l => l.TrangThai == true);
            }
            else
            {
                suDungDichVus = suDungDichVus.Where(l => l.TrangThai == true);
            }
            int pageSize = 10;
            int pageNumber = (page ?? 1);
            return View(suDungDichVus.OrderByDescending(n => n.NgayTao == DateTime.Today)
                               .ThenByDescending(n => n.ID)
                               .OrderByDescending(n => n.IdDP)
                               .ToPagedList(pageNumber, pageSize));

        }
        public ActionResult Edit1(int id)
        {
            SuDungDichVu suDungDichVu = db.SuDungDichVus.Find(id);
            if (suDungDichVu == null)
            {
                return HttpNotFound();
            }

            if (suDungDichVu.TrangThai == false)
            {
                suDungDichVu.TrangThai = true;
                db.Entry(suDungDichVu).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(suDungDichVu);
        }
        // GET: Admin/UseService/Details/5
        public async Task<ActionResult> Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SuDungDichVu suDungDichVu = await db.SuDungDichVus.FindAsync(id);
            if (suDungDichVu == null)
            {
                return HttpNotFound();
            }
            return View(suDungDichVu);
        }

        public async Task<ActionResult> Create()
        {
            var currentDate = DateTime.Now;
            var currentTime = DateTime.Now.TimeOfDay;
            var datPhongList = await db.DatPhongs
                .Where(dp => dp.TrangThaiNhan == true && dp.Ngay == DateTime.Today && dp.TimeEnd >= currentTime)
                .OrderBy(dp => dp.TimeStar)
                .Select(dp => new { Id = dp.Id, TenPhong = dp.TenPhong })
                .ToListAsync();
            ViewBag.Idkh = new SelectList(db.KhachHanggs, "ID", "Name");
            ViewBag.IDDv = new SelectList(db.DichVu1.Where(dv => dv.SoLuong > 0), "IDDichVu", "Ten");
            ViewBag.IdDP = new SelectList(datPhongList, "Id", "TenPhong");

            return View();
        }

        // POST: SuDungDichVus/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create([Bind(Include = "IDDv, IdDP, SoLuong")] SuDungDichVu suDungDichVu)
        {
            if (ModelState.IsValid)
            {
                var datPhong = await db.DatPhongs.FirstOrDefaultAsync(s => s.TrangThaiNhan == true && s.Id == suDungDichVu.IdDP);
                if (datPhong != null)
                {
                    var dichVu = await db.DichVu1.FirstOrDefaultAsync(s => s.SoLuong > 0 && s.IDDichVu == suDungDichVu.IDDv);
                    if (dichVu != null && dichVu.SoLuong >= suDungDichVu.SoLuong)
                    {
                        suDungDichVu.Ten = dichVu.Ten;
                        suDungDichVu.TenLoai = dichVu.LoaiDV;
                        suDungDichVu.Gia = dichVu.TongGia;
                        suDungDichVu.TenDVT = dichVu.DonViTinh.TenDonVi;
                       
                        dichVu.SoLuong -= suDungDichVu.SoLuong;
                        dichVu.DaBan += suDungDichVu.SoLuong;
                        suDungDichVu.Idkh = datPhong.IdKH;
                        datPhong.TienDichVu += suDungDichVu.Gia * suDungDichVu.SoLuong;
                        datPhong.ThanhTien += suDungDichVu.Gia * suDungDichVu.SoLuong;
                        suDungDichVu.ThoiGianBatDat = datPhong.TimeStar;
                        suDungDichVu.NgayTao = datPhong.Ngay;
                    

                        suDungDichVu.TrangThai = false;
                        db.SuDungDichVus.Add(suDungDichVu);
                        await db.SaveChangesAsync();
                        return RedirectToAction("Create");
                    }
                    else if (dichVu != null && dichVu.SoLuong < suDungDichVu.SoLuong)
                    {
                        ModelState.AddModelError("", "Số lượng sử dụng dịch vụ vượt quá số lượng "+" "+dichVu.SoLuong);
                    }
                }
            }

            var currentDate = DateTime.Now;
            var currentTime = DateTime.Now.TimeOfDay;
            var datPhongList = await db.DatPhongs
                .Where(dp => dp.TrangThaiNhan == true && dp.Ngay == DateTime.Today && dp.TimeEnd >= currentTime)
                .OrderBy(dp => dp.TimeStar)
                .Select(dp => new { Id = dp.Id, TenPhong = dp.TenPhong })
                .ToListAsync();

            ViewBag.IDDv = new SelectList(db.DichVu1.Where(dv => dv.SoLuong > 0), "IDDichVu", "Ten");
            ViewBag.Idkh = new SelectList(db.KhachHanggs, "ID", "Name");
            ViewBag.IdDP = new SelectList(datPhongList, "Id", "TenPhong");
            return View(suDungDichVu);
        }


        // GET: Admin/UseService/Edit/5
        public async Task<ActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SuDungDichVu suDungDichVu = await db.SuDungDichVus.FindAsync(id);
            if (suDungDichVu == null)
            {
                return HttpNotFound();
            }
            ViewBag.IDDv = new SelectList(db.DichVu1, "IDDichVu", "DVT", suDungDichVu.IDDv);
            ViewBag.Idkh = new SelectList(db.KhachHanggs, "ID", "Name", suDungDichVu.Idkh);
            ViewBag.IdDP = new SelectList(db.DatPhongs, "Id", "MaGG", suDungDichVu.IdDP);
            return View(suDungDichVu);
        }

        // POST: Admin/UseService/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include = "ID,Ten,IDDv,SoLuong,Gia,TenDVT,TenLoai,Idkh,NgayTao,ThoiGianBatDat,IdDP,TrangThai")] SuDungDichVu suDungDichVu)
        {
            if (ModelState.IsValid)
            {
                db.Entry(suDungDichVu).State = EntityState.Modified;
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            ViewBag.IDDv = new SelectList(db.DichVu1, "IDDichVu", "DVT", suDungDichVu.IDDv);
            ViewBag.Idkh = new SelectList(db.KhachHanggs, "ID", "Name", suDungDichVu.Idkh);
            ViewBag.IdDP = new SelectList(db.DatPhongs, "Id", "MaGG", suDungDichVu.IdDP);
            return View(suDungDichVu);
        }

        // GET: Admin/UseService/Delete/5
        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            SuDungDichVu suDungDichVu = await db.SuDungDichVus.FindAsync(id);
            if (suDungDichVu == null)
            {
                return HttpNotFound();
            }

            // Kiểm tra nếu trạng thái của SuDungDichVu là false
            if (suDungDichVu.TrangThai==false)
            {
                var dichVu = await db.DichVu1.FindAsync(suDungDichVu.IDDv);
                var dat = await db.DatPhongs.FindAsync(suDungDichVu.IdDP);
                // Trả lại số lượng của dịch vụ
                dichVu.SoLuong += suDungDichVu.SoLuong;
                dichVu.DaBan -= suDungDichVu.SoLuong;
                dat.TienDichVu -= suDungDichVu.SoLuong * suDungDichVu.Gia;
                dat.ThanhTien -= suDungDichVu.SoLuong * suDungDichVu.Gia;
                db.Entry(dichVu).State = EntityState.Modified;
            }

            db.SuDungDichVus.Remove(suDungDichVu);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
        }


     
    }
}
