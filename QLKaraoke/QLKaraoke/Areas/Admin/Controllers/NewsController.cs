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

namespace QLKaraoke.Areas.Admin.Controllers
{
    public class NewsController : Controller
    {
        private QLKARAOKEEntities db = new QLKARAOKEEntities();

        // GET: Admin/News

        public ActionResult Index(DateTime? ngay, int? page, int? id)
        {
            DateTime currentDate = DateTime.Now.Date;
            var tinTucs = db.TinTucs.Include(t => t.ChucVu);
            if (ngay.HasValue)
            {
                tinTucs = tinTucs.Where(l => l.Ngay == ngay.Value);
            }
            int pageSize = 10;
            int pageNumber = (page ?? 1);
            return View(tinTucs.Where(n=>n.TrangThaiTin==1).OrderByDescending(l => l.Ngay == DateTime.Today)
                                 .ThenByDescending(l => l.Id).ToPagedList(pageNumber, pageSize));
        }
        public ActionResult Index1(DateTime? ngay, int? page, int? id)
        {
            DateTime currentDate = DateTime.Now.Date;
            var tinTucs = db.TinTucs.Include(t => t.ChucVu);
            if (ngay.HasValue)
            {
                tinTucs = tinTucs.Where(l => l.Ngay == ngay.Value);
            }
            int pageSize = 10;
            int pageNumber = (page ?? 1);
            return View(tinTucs.Where(n => n.TrangThaiTin == 2).OrderByDescending(l => l.Ngay == DateTime.Today)
                                 .ThenByDescending(l => l.Id).ToPagedList(pageNumber, pageSize));
        }
        public async Task<ActionResult> Status(int? id)
        {
            TinTuc tinTuc = await db.TinTucs.FindAsync(id);
            int status = (tinTuc.TrangThai == 1) ? 2 : 1;
            tinTuc.TrangThai = (int)status; // Cast the status to an int
            db.Entry(tinTuc).State = EntityState.Modified;
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
        }

        public async Task<ActionResult> Status1(int? id)
        {
            TinTuc tinTuc = await db.TinTucs.FindAsync(id);
            int status = (tinTuc.TrangThai == 1) ? 2 : 1;
            tinTuc.TrangThai = (int)status; // Cast the status to an int
            db.Entry(tinTuc).State = EntityState.Modified;
            await db.SaveChangesAsync();
            return RedirectToAction("Index1");
        }

        // GET: Admin/News/Details/5
        public async Task<ActionResult> Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TinTuc tinTuc = await db.TinTucs.FindAsync(id);
            if (tinTuc == null)
            {
                return HttpNotFound();
            }
            return View(tinTuc);
        }

        // GET: Admin/News/Create
        public ActionResult Create()
        {
            ViewBag.ChucVuId = new SelectList(db.ChucVus, "IDChucVu", "TenChucVu");
            return View();
        }

        // POST: Admin/News/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public async Task<ActionResult> Create([Bind(Include = "Id,TieuDe,Ngay,NoiDung,ChucVuId,Hinhanh,TrangThai,Luong,TrangThaiTin")] TinTuc tinTuc, HttpPostedFileBase Hinhanh)
        {
            if (ModelState.IsValid)
            {
                if (Hinhanh != null && Hinhanh.ContentLength > 0)
                {
                    // Get the file name and extension
                    var fileName = Path.GetFileName(Hinhanh.FileName);
                    var extension = Path.GetExtension(fileName);

                    // Generate a unique file name to avoid conflicts
                    var newName = Guid.NewGuid().ToString("N") + extension;

                    // Save the file to the server
                    var path = Path.Combine(Server.MapPath("~/Areas/Admin/assets/img/"), newName);
                    Hinhanh.SaveAs(path);

                    // Update the employee's image URL
                    tinTuc.Hinhanh = newName;
                }
                tinTuc.TrangThai = 1;
                tinTuc.TrangThaiTin = 1;
                tinTuc.Ngay = DateTime.Now;
                tinTuc.Luong = null;

                db.TinTucs.Add(tinTuc);
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }

            ViewBag.ChucVuId = new SelectList(db.ChucVus, "IDChucVu", "TenChucVu", tinTuc.ChucVuId);
            return View(tinTuc);
        }
        public ActionResult Create1()
        {
            ViewBag.ChucVuId = new SelectList(db.ChucVus, "IDChucVu", "TenChucVu");
            return View();
        }

        // POST: Admin/News/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public async Task<ActionResult> Create1([Bind(Include = "Id,TieuDe,NoiDung,Ngay,ChucVuId,Hinhanh,TrangThai,Luong,TrangThaiTin,Soluong")] TinTuc tinTuc, HttpPostedFileBase Hinhanh)
        {
            if (ModelState.IsValid)
            {
                if (Hinhanh != null && Hinhanh.ContentLength > 0)
                {
                    // Get the file name and extension
                    var fileName = Path.GetFileName(Hinhanh.FileName);
                    var extension = Path.GetExtension(fileName);

                    // Generate a unique file name to avoid conflicts
                    var newName = Guid.NewGuid().ToString("N") + extension;

                    // Save the file to the server
                    var path = Path.Combine(Server.MapPath("~/Areas/Admin/assets/img/"), newName);
                    Hinhanh.SaveAs(path);

                    // Update the employee's image URL
                    tinTuc.Hinhanh = newName;
                }
              
                tinTuc.TrangThai = 1;
                tinTuc.TrangThaiTin = 2;
                var chucVu = await db.ChucVus.FindAsync(tinTuc.ChucVuId);
                tinTuc.Luong += chucVu.LuongCV;
                tinTuc.Ngay = DateTime.Now;
                db.TinTucs.Add(tinTuc);
                await db.SaveChangesAsync();
                return RedirectToAction("Index1");
            }

            ViewBag.ChucVuId = new SelectList(db.ChucVus, "IDChucVu", "TenChucVu", tinTuc.ChucVuId);
            return View(tinTuc);
        }

        // GET: Admin/News/Edit/5
        public async Task<ActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TinTuc tinTuc = await db.TinTucs.FindAsync(id);
            if (tinTuc == null)
            {
                return HttpNotFound();
            }
            ViewBag.ChucVu = new SelectList(db.ChucVus, "IDChucVu", "TenChucVu", tinTuc.ChucVu);
            return View(tinTuc);
        }

        // POST: Admin/News/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include = "Id,TieuDe,NoiDung,ChucVu,Hinhanh,TrangThai,Luong")] TinTuc tinTuc)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tinTuc).State = EntityState.Modified;
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            ViewBag.ChucVu = new SelectList(db.ChucVus, "IDChucVu", "TenChucVu", tinTuc.ChucVu);
            return View(tinTuc);
        }

        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            TinTuc tt = await db.TinTucs.FindAsync(id);
            if (tt == null)
            {
                return HttpNotFound();
            }

            db.TinTucs.Remove(tt);
            await db.SaveChangesAsync();

            if (tt.TrangThaiTin == 1)
            {
                return RedirectToAction("Index");
            }
            else
            {
                return RedirectToAction("Index1");
            }
        }

    }
}
