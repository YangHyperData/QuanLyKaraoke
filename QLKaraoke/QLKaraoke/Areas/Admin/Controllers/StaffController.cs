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
using System.IO;
using System.Net.NetworkInformation;
using static System.Net.WebRequestMethods;
using System.Data.Entity.Migrations;

namespace QLKaraoke.Areas.Admin.Controllers
{
    public class StaffController : Controller
    {
        private QLKARAOKEEntities db = new QLKARAOKEEntities();

        // GET: Admin/Staff
  
        public ActionResult Index(int? page, string Email, string HoTenNV, string sdt, string gioitinh)
        {
            var nhanViens = db.NhanViens.Where(n=>n.TrangThai==2||n.TrangThai==4).Include(n => n.ChucVu).Include(n => n.KhachHangg).Include(n => n.TinTuc);

            if (!string.IsNullOrEmpty(Email))
            {
                nhanViens = nhanViens.Where(l => l.Email.Contains(Email));
            }
            if (!string.IsNullOrEmpty(HoTenNV))
            {
                nhanViens = nhanViens.Where(l => l.HoTenNV.ToLower().Contains(HoTenNV.ToLower()));
            }
            if (!string.IsNullOrEmpty(sdt))
            {
                nhanViens = nhanViens.Where(l => l.SDT.ToLower().Contains(sdt.ToLower()));
            }
            if (!string.IsNullOrEmpty(gioitinh))
            {
                nhanViens = nhanViens.Where(l => l.GioiTinh.ToLower().Contains(gioitinh.ToLower()));
            }

            int pageSize = 10; // số lượng lịch đặt phòng trên mỗi trang
            int pageNumber = (page ?? 1); // số trang hiện tại (nếu không có thì mặc định là trang 1)

            return View(nhanViens.OrderByDescending(n => n.TrangThai == 2|| n.TrangThai == 4)
                      .ThenByDescending(n => n.IDNhanVien)
                      .ToPagedList(pageNumber, pageSize));
        }

        public ActionResult Index1(int? page, string Email, string HoTenNV, string sdt, string gioitinh)
        {
            var nhanViens = db.NhanViens.Where(n => n.TrangThai == 1).Include(n => n.ChucVu).Include(n => n.KhachHangg).Include(n => n.TinTuc);

            if (!string.IsNullOrEmpty(Email))
            {
                nhanViens = nhanViens.Where(l => l.ChucVu.TenChucVu.Contains(Email));
            }
            if (!string.IsNullOrEmpty(HoTenNV))
            {
                nhanViens = nhanViens.Where(l => l.HoTenNV.ToLower().Contains(HoTenNV.ToLower()));
            }
            if (!string.IsNullOrEmpty(sdt))
            {
                nhanViens = nhanViens.Where(l => l.SDT.ToLower().Contains(sdt.ToLower()));
            }
            if (!string.IsNullOrEmpty(gioitinh))
            {
                nhanViens = nhanViens.Where(l => l.GioiTinh.ToLower().Contains(gioitinh.ToLower()));
            }

            int pageSize = 10; // số lượng lịch đặt phòng trên mỗi trang
            int pageNumber = (page ?? 1); // số trang hiện tại (nếu không có thì mặc định là trang 1)

            return View(nhanViens.OrderByDescending(n => n.TrangThai == 1)
                      .ThenByDescending(n => n.IDNhanVien)
                      .ToPagedList(pageNumber, pageSize));
        }
        public ActionResult Index2(int? page, string Email, string HoTenNV, string sdt, string gioitinh)
        {
            var nhanViens = db.NhanViens.Where(n => n.TrangThai == 3).Include(n => n.ChucVu).Include(n => n.KhachHangg).Include(n => n.TinTuc);

            if (!string.IsNullOrEmpty(Email))
            {
                nhanViens = nhanViens.Where(l => l.Email.Contains(Email));
            }
            if (!string.IsNullOrEmpty(HoTenNV))
            {
                nhanViens = nhanViens.Where(l => l.HoTenNV.ToLower().Contains(HoTenNV.ToLower()));
            }
            if (!string.IsNullOrEmpty(sdt))
            {
                nhanViens = nhanViens.Where(l => l.SDT.ToLower().Contains(sdt.ToLower()));
            }
            if (!string.IsNullOrEmpty(gioitinh))
            {
                nhanViens = nhanViens.Where(l => l.GioiTinh.ToLower().Contains(gioitinh.ToLower()));
            }

            int pageSize = 10; // số lượng lịch đặt phòng trên mỗi trang
            int pageNumber = (page ?? 1); // số trang hiện tại (nếu không có thì mặc định là trang 1)

            return View(nhanViens.OrderByDescending(n => n.TrangThai == 3)
                      .ThenByDescending(n => n.IDNhanVien)
                      .ToPagedList(pageNumber, pageSize));
        }

        public async Task<ActionResult> Edit1(int id)
        {
            NhanVien nhanVien = await db.NhanViens.FindAsync(id);
            if (nhanVien == null)
            {
                return HttpNotFound();
            }

            // Find the associated TinTuc record
            var tinTuc = await db.TinTucs.FirstOrDefaultAsync(x => x.Id == nhanVien.IdTin);

            if (nhanVien.TrangThai == 2)
            {
                // Change the TrangThai and IdTin properties
                

                // Decrement the SoLuong property of the associated TinTuc record
                if (tinTuc.TrangThaiTin == 2)
                {
                    tinTuc.Soluong-=1;
                    db.Entry(tinTuc).State = EntityState.Modified;
                }
                nhanVien.TrangThai = 1;
                nhanVien.IdTin = null;
                db.Entry(nhanVien).State = EntityState.Modified;
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }

            return View(nhanVien);
        }

        public ActionResult Edit3(int id)
        {
            NhanVien nhanVien = db.NhanViens.Find(id);
            if (nhanVien == null)
            {
                return HttpNotFound();
            }

            if (nhanVien.TrangThai == 2)
            {
                nhanVien.IdTin = null;
                nhanVien.TrangThai = 4;
                db.Entry(nhanVien).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(nhanVien);
        }
        public ActionResult Edit2(int id)
        {
            NhanVien nhanVien = db.NhanViens.Find(id);
            if (nhanVien == null)
            {
                return HttpNotFound();
            }

            if (nhanVien.TrangThai == 1)
            {
                nhanVien.IdKh = null;
                nhanVien.IdTin = null;
                nhanVien.TrangThai = 3;
                db.Entry(nhanVien).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index2");
            }

            return View(nhanVien);
        }
        // GET: Admin/Staff/Details/5
        public async Task<ActionResult> Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            NhanVien nhanVien = await db.NhanViens.FindAsync(id);
            if (nhanVien == null)
            {
                return HttpNotFound();
            }
            return View(nhanVien);
        }

        // GET: Admin/Staff/Create
        public ActionResult Create()
        {
            ViewBag.IDChucVu = new SelectList(db.ChucVus, "IDChucVu", "TenChucVu");
            ViewBag.IdKh = new SelectList(db.KhachHanggs, "ID", "Name");
            ViewBag.IdTin = new SelectList(db.TinTucs, "Id", "TieuDe");
            return View();
        }

        // POST: Admin/Staff/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create([Bind(Include = "IDNhanVien,HoTenNV,HinhAnh,DiaChi,SDT,Luong,Email,TrangThai,GioiTinh,NgaySinh,IDChucVu,IdTin,IdKh")] NhanVien nhanVien, HttpPostedFileBase HinhAnh)
        {
            if (ModelState.IsValid)
            {
                if (HinhAnh != null && HinhAnh.ContentLength > 0)
                {
                    // Get the file name and extension
                    var fileName = Path.GetFileName(HinhAnh.FileName);
                    var extension = Path.GetExtension(fileName);

                    // Generate a unique file name to avoid conflicts
                    var newName = Guid.NewGuid().ToString("N") + extension;

                    // Save the file to the server
                    var path = Path.Combine(Server.MapPath("~/Areas/Admin/assets/img/"), newName);
                    HinhAnh.SaveAs(path);

                    // Update the employee's image URL
                    nhanVien.HinhAnh = newName;
                }

                // Find the selected position and add its salary to the employee's current salary
                var chucVu = await db.ChucVus.FindAsync(nhanVien.IDChucVu);
                nhanVien.Luong += chucVu.LuongCV;
                nhanVien.IdKh = null;
                nhanVien.IdTin = null;
                nhanVien.TrangThai = 1;
                db.NhanViens.Add(nhanVien);
                await db.SaveChangesAsync();
                return RedirectToAction("Index1");
            }

            ViewBag.IDChucVu = new SelectList(db.ChucVus, "IDChucVu", "TenChucVu", nhanVien.IDChucVu);
            ViewBag.IdKh = new SelectList(db.KhachHanggs, "ID", "Name", nhanVien.IdKh);
            ViewBag.IdTin = new SelectList(db.TinTucs, "Id", "TieuDe", nhanVien.IdTin);
            return View(nhanVien);
        }

        // GET: Admin/Staff/Edit/5
        public async Task<ActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            NhanVien nhanVien = await db.NhanViens.FindAsync(id);
            if (nhanVien == null)
            {
                return HttpNotFound();
            }
            ViewBag.IDChucVu = new SelectList(db.ChucVus, "IDChucVu", "TenChucVu", nhanVien.IDChucVu);
            ViewBag.IdKh = new SelectList(db.KhachHanggs, "ID", "Name", nhanVien.IdKh);
            ViewBag.IdTin = new SelectList(db.TinTucs, "Id", "TieuDe", nhanVien.IdTin);
            return View(nhanVien);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include = "IDNhanVien,HoTenNV,HinhAnh,DiaChi,SDT,Luong,Email,TrangThai,GioiTinh,NgaySinh,IDChucVu,IdTin,IdKh")] NhanVien nhanVien, HttpPostedFileBase HinhAnh)
        {
            if (ModelState.IsValid)
            {
                var existingDichVu = db.NhanViens.Find(nhanVien.IDNhanVien);
                // Check if the file was uploaded
                if (HinhAnh != null && HinhAnh.ContentLength > 0)
                {
                    // Delete the old image file
                    if (nhanVien.HinhAnh != null)
                    {
                        string oldImagePath = Path.Combine(Server.MapPath("~/Areas/Admin/assets/img/"), nhanVien.HinhAnh);
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
                    nhanVien.HinhAnh = imageName;
                }
                else
                {
                    // Keep the existing image if no new file is uploaded
                    nhanVien.HinhAnh = existingDichVu.HinhAnh;
                }

                // Set the quantity to be the sum of the current quantity and the quantity to be added
                nhanVien.TrangThai = existingDichVu.TrangThai;
                nhanVien.GioiTinh = existingDichVu.GioiTinh;
                nhanVien.NgaySinh = existingDichVu.NgaySinh;
            
                nhanVien.IdTin = null;
     

                var chucVuMoi = await db.ChucVus.FindAsync(nhanVien.IDChucVu);
          
                if(existingDichVu.IDChucVu!= chucVuMoi.IDChucVu)
                {
                    double luongMoi = (double)chucVuMoi.LuongCV;
                    double luongCu = (double)existingDichVu.ChucVu.LuongCV;
                    if (luongMoi > luongCu)
                    {
                        nhanVien.Luong += (luongMoi - luongCu);
                    }
                    else
                    {
                        nhanVien.Luong -= (luongCu - luongMoi);
                    }
                }
                    
                

                // Use AddOrUpdate instead of State to handle conflicts with existing entities
                db.NhanViens.AddOrUpdate(nhanVien);
                await db.SaveChangesAsync();
                return RedirectToAction("Index1");
            }
            ViewBag.IDChucVu = new SelectList(db.ChucVus, "IDChucVu", "TenChucVu", nhanVien.IDChucVu);
            ViewBag.IdKh = new SelectList(db.KhachHanggs, "ID", "Name", nhanVien.IdKh);
            ViewBag.IdTin = new SelectList(db.TinTucs, "Id", "TieuDe", nhanVien.IdTin);
            return View(nhanVien);
        }

        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            NhanVien nhanVien = await db.NhanViens.FindAsync(id);
            if (nhanVien == null)
            {
                return HttpNotFound();
            }

            // Kiểm tra nếu trạng thái của SuDungDichVu là false
        

            db.NhanViens.Remove(nhanVien);
            await db.SaveChangesAsync();
            return RedirectToAction("Index2");
        }
    }
}
