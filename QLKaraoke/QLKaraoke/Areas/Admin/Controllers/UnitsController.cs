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
    public class UnitsController : Controller
    {
        private QLKARAOKEEntities db = new QLKARAOKEEntities();

        // GET: Admin/Units

        public ActionResult Index(string searchQuery, int? page, int? id)
        {
            DateTime currentDate = DateTime.Now.Date;
            IQueryable<DonViTinh> lienHes = db.DonViTinhs;
            if (!string.IsNullOrEmpty(searchQuery))
            {
                lienHes = lienHes.Where(d => d.TenDonVi.Contains(searchQuery));
            }
            int pageSize = 10;
            int pageNumber = (page ?? 1);
            return View(lienHes.OrderByDescending(n => n.IDDonVT).ToPagedList(pageNumber, pageSize));
        }
 

        // GET: Admin/Units/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Admin/Units/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create([Bind(Include = "IDDonVT,TenDonVi,NgayCapNhat")] DonViTinh donViTinh)
        {
            if (ModelState.IsValid)
            {
                donViTinh.NgayCapNhat = DateTime.Now;
                db.DonViTinhs.Add(donViTinh);
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }

            return View(donViTinh);
        }

        // GET: Admin/Units/Edit/5
        public async Task<ActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DonViTinh donViTinh = await db.DonViTinhs.FindAsync(id);
            if (donViTinh == null)
            {
                return HttpNotFound();
            }
            return View(donViTinh);
        }

        // POST: Admin/Units/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include = "IDDonVT,TenDonVi,NgayCapNhat")] DonViTinh donViTinh)
        {
            if (ModelState.IsValid)
            {
                donViTinh.NgayCapNhat =DateTime.Now;
                db.Entry(donViTinh).State = EntityState.Modified;
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            return View(donViTinh);
        }

        // GET: Admin/Units/Delete/5
        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DonViTinh donViTinh = await db.DonViTinhs.FindAsync(id);
            if (donViTinh == null)
            {
                return HttpNotFound();
            }
            return View(donViTinh);
        }

        // POST: Admin/Units/Delete/5
        // POST: Admin/Units/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteConfirmed(int id)
        {
            DonViTinh donViTinh = await db.DonViTinhs.FindAsync(id);

         
      
            bool hasBatchs = db.KhoHangs.Any(l => l.IDDonVT == id);

            // Nếu có dịch vụ hoặc lô hàng sử dụng đơn vị này, trả về thông báo lỗi
            if ( hasBatchs)
            {
                TempData["Er"]="Không thể xóa đơn vị tính này vì có dịch vụ hoặc Kho hàng đang sử dụng.";
                return View(donViTinh);
            }

            db.DonViTinhs.Remove(donViTinh);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
        }



    }
}
