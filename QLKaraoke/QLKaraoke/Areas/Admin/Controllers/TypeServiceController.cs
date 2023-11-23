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
    public class TypeServiceController : Controller
    {
        private QLKARAOKEEntities db = new QLKARAOKEEntities();

        // GET: Admin/TypeService
        public async Task<ActionResult> Index()
        {
            return View(await db.LoaiDVs.ToListAsync());
        }

        // GET: Admin/TypeService/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Admin/TypeService/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create([Bind(Include = "ID,TenDV")] LoaiDV loaiDV)
        {
            if (ModelState.IsValid)
            {
                db.LoaiDVs.Add(loaiDV);
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }

            return View(loaiDV);
        }

        // GET: Admin/TypeService/Edit/5
        public async Task<ActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            LoaiDV loaiDV = await db.LoaiDVs.FindAsync(id);
            if (loaiDV == null)
            {
                return HttpNotFound();
            }
            return View(loaiDV);
        }

        // POST: Admin/TypeService/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include = "ID,TenDV")] LoaiDV loaiDV)
        {
            if (ModelState.IsValid)
            {
                db.Entry(loaiDV).State = EntityState.Modified;
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            return View(loaiDV);
        }

        // GET: Admin/TypeService/Delete/5
        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            LoaiDV loaiDV = await db.LoaiDVs.FindAsync(id);
            if (loaiDV == null)
            {
                return HttpNotFound();
            }
            return View(loaiDV);
        }

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteConfirmed(int id)
        {
            LoaiDV loaiDV = await db.LoaiDVs.FindAsync(id);

            // Kiểm tra xem loại dịch vụ có dịch vụ nào thuộc về nó không
            if (loaiDV.KhoHangs.Any())
            {
                TempData["Er"]= "Không thể xóa loại dịch vụ khi có dịch vụ thuộc về nó.";
                return View(loaiDV);
            }

            db.LoaiDVs.Remove(loaiDV);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
        }



    }
}
