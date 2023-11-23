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
using System.IO;
using System.Data.Entity.Migrations;
using PagedList;

namespace QLKaraoke.Areas.Admin.Controllers
{
    public class ServiceController : Controller
    {
        private QLKARAOKEEntities db = new QLKARAOKEEntities();

        // GET: Admin/Service

        public ActionResult Index(string searchQuery, int? page, int? id)
        {
            var dichVu1 = db.DichVu1.Include(d => d.DonViTinh).Include(d => d.KhoHang).Include(d => d.LoaiDV1);

            if (!string.IsNullOrEmpty(searchQuery))
            {
                dichVu1 = dichVu1.Where(d => d.Ten.Contains(searchQuery));
            }

            int pageSize = 10;
            int pageNumber = (page ?? 1);
            return View(dichVu1.OrderByDescending(n => n.IDDichVu).ToPagedList(pageNumber, pageSize));
        }


        // GET: Admin/Service/Details/5


        // GET: Admin/Service/Create
        public ActionResult Create()
        {
            ViewBag.IDDVT = new SelectList(db.DonViTinhs, "IDDonVT", "TenDonVi");
            ViewBag.IDKhoHang = new SelectList(db.KhoHangs, "IDMatHang", "TenMatHang");
            ViewBag.IdLoai = new SelectList(db.LoaiDVs, "ID", "TenDV");
            return View();
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public async Task<ActionResult> Create([Bind(Include = "IDDichVu,IDKhoHang,DonGia,DVT,LoaiDV,HinhAnh,SoLuong,GiaBan,DaBan,Ten,IdLoai,IDDVT,soluongthem,MoTa")] DichVu1 dichVu, HttpPostedFileBase HinhAnh)
        {
            if (ModelState.IsValid)
            {
                
                KhoHang khoHang = db.KhoHangs.Find(dichVu.IDKhoHang);
              
                bool dichVuExists = db.DichVu1.Any(dv => dv.IDKhoHang == dichVu.IDKhoHang);

                if (dichVuExists)
                {
                    TempData["Er1"] = "Sản phẩm đã được tạo trong bảng dịch vụ";
                }
                else
                {
                   
                    if (dichVu.SoLuong > khoHang.ConLai || khoHang.ConLai == 0)
                    {
                        TempData["Er"] = "Vui lòng nhập số lượng sản phẩm nhỏ hơn hoặc kho hàng đã hết" + " " + khoHang.ConLai;
                    }
                    else
                    {
                        dichVu.Ten = khoHang.TenMatHang;

                    
                        DonViTinh donViTinh = db.DonViTinhs.Find(khoHang.IDDonVT);
                        LoaiDV loaiDV = db.LoaiDVs.Find(khoHang.LoaiDv);

                    
                        dichVu.DVT = donViTinh.TenDonVi;
                        dichVu.LoaiDV = loaiDV.TenDV;

                    
                        dichVu.DonGia = khoHang.DonGia;

                    
                        if (HinhAnh != null && HinhAnh.ContentLength > 0)
                        {
                            var fileName = Path.GetFileName(HinhAnh.FileName);
                            var path = Path.Combine(Server.MapPath("~/Areas/Admin/assets/img/"), fileName);
                            HinhAnh.SaveAs(path);
                            dichVu.HinhAnh = fileName;
                        }

                        dichVu.IdLoai = khoHang.LoaiDv;
                        dichVu.IDDVT = khoHang.IDDonVT;
                        dichVu.TongGia = (double)(dichVu.DonGia + dichVu.GiaBan);
                        dichVu.DaBan = 0;
                        TimeSpan gio = DateTime.Now.TimeOfDay;
                        // Add the DichVu object to the database
                        khoHang.ConLai -= (int)dichVu.SoLuong;
                        var ctKhoHang = new CTKhoHang
                        {

                            TenSP = dichVu.Ten,
                            SoLuong = dichVu.SoLuong,
                            Ngay = DateTime.Now,
                            ConLai = dichVu.SoLuong,
                            TrangThai = true,
                            IdKh = dichVu.IDKhoHang,
                            Gio= gio
                        };
                        db.CTKhoHangs.Add(ctKhoHang);
                        db.Entry(khoHang).State = EntityState.Modified;
                        db.DichVu1.Add(dichVu);
                        await db.SaveChangesAsync();
                        return RedirectToAction("Index");
                    }
                }
            }


            ViewBag.IDDVT = new SelectList(db.DonViTinhs, "IDDonVT", "TenDonVi", dichVu.IDDVT);
            ViewBag.IDKhoHang = new SelectList(db.KhoHangs, "IDMatHang", "TenMatHang", dichVu.IDKhoHang);
            ViewBag.IdLoai = new SelectList(db.LoaiDVs, "ID", "TenDV", dichVu.IdLoai);
            return View(dichVu);
        }


        // GET: Admin/DichVu1/Edit/5
        public async Task<ActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DichVu1 dichVu1 = await db.DichVu1.FindAsync(id);
            if (dichVu1 == null)
            {
                return HttpNotFound();
            }
            ViewBag.IDDVT = new SelectList(db.DonViTinhs, "IDDonVT", "TenDonVi", dichVu1.IDDVT);
            ViewBag.IDKhoHang = new SelectList(db.KhoHangs, "IDMatHang", "TenMatHang", dichVu1.IDKhoHang);
            ViewBag.IdLoai = new SelectList(db.LoaiDVs, "ID", "TenDV", dichVu1.IdLoai);
            return View(dichVu1);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public async Task<ActionResult> Edit([Bind(Include = "IDDichVu,IDKhoHang,DonGia,DVT,LoaiDV,HinhAnh,SoLuong,GiaBan,TongGia,DaBan,Ten,IdLoai,IDDVT,soluongthem,MoTa")] DichVu1 dichVuu, HttpPostedFileBase HinhAnh)
        {
            if (ModelState.IsValid)
            {
                var existingDichVu = db.DichVu1.Find(dichVuu.IDDichVu);
                // Check if the file was uploaded
                if (HinhAnh != null && HinhAnh.ContentLength > 0)
                {
                    // Delete the old image file
                    if (dichVuu.HinhAnh != null)
                    {
                        string oldImagePath = Path.Combine(Server.MapPath("~/Areas/Admin/assets/img/"), dichVuu.HinhAnh);
                        if (System.IO.File.Exists(oldImagePath))
                        {
                            System.IO.File.Delete(oldImagePath);
                        }
                    }
                    // Save the new image file
                    string extension = Path.GetExtension(HinhAnh.FileName);
                    string imageName = DateTime.Now.ToString("yyyyMMddHHmmssfff") + extension;
                    string imagePath = Path.Combine(Server.MapPath("~/Areas/Admin/assets/img/"), imageName);
                    HinhAnh.SaveAs(imagePath);
                    dichVuu.HinhAnh = imageName;
                }
                else
                {
                    // Keep the existing image if no new file is uploaded
                    dichVuu.HinhAnh = existingDichVu.HinhAnh;
                }

                // Set the quantity to be the sum of the current quantity and the quantity to be added
                dichVuu.SoLuong = existingDichVu.SoLuong + dichVuu.soluongthem ?? 0;

                // Set the total price to be the sum of the selling price and the cost price
                dichVuu.TongGia = dichVuu.GiaBan + dichVuu.DonGia;

                // Update the quantity of the item in the warehouse
                var khoHang = db.KhoHangs.Find(dichVuu.IDKhoHang);
                if (khoHang != null && khoHang.ConLai >= dichVuu.soluongthem)
                {
                    // Subtract the quantity to be added from the remaining quantity in the warehouse
                    khoHang.ConLai -= (int)dichVuu.soluongthem;
                    db.Entry(khoHang).State = EntityState.Modified;
                }
                else
                {
                    ModelState.AddModelError("soluongthem", "Số lượng thêm vượt quá số lượng trong kho hàng.");
                    ViewBag.IDDVT = new SelectList(db.DonViTinhs, "IDDonVT", "TenDonVi", dichVuu.IDDVT);
                    ViewBag.IDKhoHang = new SelectList(db.KhoHangs, "IDMatHang", "TenMatHang", dichVuu.IDKhoHang);
                    ViewBag.IdLoai = new SelectList(db.LoaiDVs, "ID", "TenDV", dichVuu.IdLoai);
                    return View(dichVuu);
                }
                if (dichVuu.soluongthem == null)
                {
                    dichVuu.soluongthem = 0;
                }
                if (dichVuu.soluongthem > 0)
                {
                    TimeSpan gio = DateTime.Now.TimeOfDay;
                    var ctKhoHang = new CTKhoHang
                    {

                        TenSP = dichVuu.Ten,
                        SoLuong = dichVuu.soluongthem,
                        Ngay = DateTime.Now,
                        ConLai = dichVuu.SoLuong,
                        TrangThai = true,
                        IdKh = dichVuu.IDKhoHang,
                        Gio = gio
                    };
                    db.CTKhoHangs.Add(ctKhoHang);
                }
             
                // Use AddOrUpdate instead of State to handle conflicts with existing entities
                db.DichVu1.AddOrUpdate(dichVuu);
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            ViewBag.IDDVT = new SelectList(db.DonViTinhs, "IDDonVT", "TenDonVi", dichVuu.IDDVT);
            ViewBag.IDKhoHang = new SelectList(db.KhoHangs, "IDMatHang", "TenMatHang", dichVuu.IDKhoHang);
            ViewBag.IdLoai = new SelectList(db.LoaiDVs, "ID", "TenDV", dichVuu.IdLoai);
            return View(dichVuu);
        }

        public async Task<ActionResult> Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DichVu1 dichVu1 = await db.DichVu1.FindAsync(id);
            if (dichVu1 == null)
            {
                return HttpNotFound();
            }
            return View(dichVu1);
        }

        // GET: Admin/Service/Delete/5
        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DichVu1 dichVu = await db.DichVu1.FindAsync(id);
            if (dichVu == null)
            {
                return HttpNotFound();
            }
            return View(dichVu);
        }

        // POST: Admin/Service/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteConfirmed(int id)
        {
            DichVu1 dichVu = await db.DichVu1.FindAsync(id);
            db.DichVu1.Remove(dichVu);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
        }

    }
}
