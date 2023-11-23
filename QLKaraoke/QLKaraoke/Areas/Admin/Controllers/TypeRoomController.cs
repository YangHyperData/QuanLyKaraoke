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

namespace QLKaraoke.Areas.Admin.Controllers
{
    public class TypeRoomController : Controller
    {
        private const string keyElement = "Loại Phòng";
        QLKARAOKEEntities db = new QLKARAOKEEntities();
       
        public ActionResult Index()
        {
            ViewBag.Feature = "Danh sách";
            ViewBag.Element = keyElement;
            if (Request.Url != null) ViewBag.BaseURL = Request.Url.LocalPath;

            using (QLKARAOKEEntities db = new QLKARAOKEEntities())
            {
                var listData = db.LoaiPhongs.ToList();
                return View(listData);
            }
        }

        public ActionResult Create()
        {
            return View();
        }

        // POST: LoaiPhong/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "IDLoaiPhong,TenPhong,DonGia,NgayCapNhat")] LoaiPhong loaiPhong)
        {
            if (ModelState.IsValid)
            {
                loaiPhong.NgayCapNhat = DateTime.Now;
                
                db.LoaiPhongs.Add(loaiPhong);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(loaiPhong);
        }

        public async Task<ActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            LoaiPhong loaiPhong = await db.LoaiPhongs.FindAsync(id);
            if (loaiPhong == null)
            {
                return HttpNotFound();
            }
            return View(loaiPhong);
        }

        // POST: Admin/LoaiPhongs/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include = "IDLoaiPhong,TenPhong,DonGia,NgayCapNhat")] LoaiPhong loaiPhong)
        {
            if (ModelState.IsValid)
            {
                loaiPhong.NgayCapNhat = DateTime.Now;
                db.Entry(loaiPhong).State = EntityState.Modified;
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            return View(loaiPhong);
        }
        // GET: Admin/TypeRoom/Delete/5
        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            LoaiPhong loaiPhong = await db.LoaiPhongs.FindAsync(id);
            if (loaiPhong == null)
            {
                return HttpNotFound();
            }
            return View(loaiPhong);
        }

        // POST: Admin/TypeRoom/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteConfirmed(int id)
        {
            LoaiPhong loaiPhong = await db.LoaiPhongs.FindAsync(id);
            db.LoaiPhongs.Remove(loaiPhong);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
        }
    }
}
