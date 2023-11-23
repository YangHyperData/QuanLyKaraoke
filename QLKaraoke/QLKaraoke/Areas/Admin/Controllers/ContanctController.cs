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
using System.ComponentModel;
using PagedList;
using PagedList.Mvc;


namespace QLKaraoke.Areas.Admin.Controllers
{
   
    public class ContanctController : Controller
    {
        private QLKARAOKEEntities db = new QLKARAOKEEntities();



        public ActionResult Index(DateTime? ngaytao, int? page, int? id)
        {
            DateTime currentDate = DateTime.Now.Date;
            IQueryable<LienHe> lienHes = db.LienHes;
            if (ngaytao.HasValue)
            {
                lienHes = lienHes.Where(l => l.NgayLH == ngaytao.Value).OrderByDescending(l => l.TrangThai == 2);
            }
            int pageSize = 10;
            int pageNumber = (page ?? 1);
            return View(lienHes.OrderByDescending(l => l.NgayLH == DateTime.Today).ThenByDescending(l => l.TrangThai==2)
                                 .ThenByDescending(l => l.Id).ToPagedList(pageNumber, pageSize));
        }


        // GET: Admin/Contanct/Details/5
        public async Task<ActionResult> Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            LienHe lienHe = await db.LienHes.FindAsync(id);
            if (lienHe == null)
            {
                return HttpNotFound();
            }
            return View(lienHe);
        }



        // GET: Admin/Contanct/Edit/5
        public async Task<ActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            LienHe lienHe = await db.LienHes.FindAsync(id);
            if (lienHe == null)
            {
                return HttpNotFound();
            }
            return View(lienHe);
        }

        // POST: Admin/Contanct/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include = "Id,TenKH,NoiDung,SDT,Email,TrangThai,NgayLH")] LienHe lienHe)
        {
            if (ModelState.IsValid)
            {
                db.Entry(lienHe).State = EntityState.Modified;
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            return View(lienHe);
        }

        // GET: Admin/Contanct/Delete/5
        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            LienHe lienHe = await db.LienHes.FindAsync(id);
            if (lienHe == null)
            {
                return HttpNotFound();
            }
            if (lienHe.TrangThai == 2)
            {
                ViewBag.Error = "Không thể xóa yêu cầu liên hệ khách hàng chưa được liên hệ";
            }
            return View(lienHe);
        }

        // POST: Admin/Contanct/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteConfirmed(int id)
        {
            LienHe lienHe = await db.LienHes.FindAsync(id);
            if (lienHe.TrangThai == 2)
            {
                ViewBag.Error = "Không thể xóa yêu cầu liên hệ khách hàng chưa được liên hệ";
                return View(lienHe);
            }
            else
            {
                db.LienHes.Remove(lienHe);
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
        }


        public ActionResult Status(int id)
        {
            LienHe lh = db.LienHes.Find(id);
            int status = (lh.TrangThai == 1) ? 2 : 1;
            lh.TrangThai = status;
            db.Entry(lh).State = EntityState.Modified;
            db.SaveChangesAsync();
            return RedirectToAction("Index");


        }
    }
}
