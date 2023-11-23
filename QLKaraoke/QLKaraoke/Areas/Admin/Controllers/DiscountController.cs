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
    public class DiscountController : Controller
    {
        private QLKARAOKEEntities db = new QLKARAOKEEntities();

        // GET: Admin/Discount
        public async Task<ActionResult> Index()
        {
            var giammGias = db.GiammGias.Include(g => g.KhachHangg);
            return View(await giammGias.ToListAsync());
        }

        // GET: Admin/Discount/Details/5
        public async Task<ActionResult> Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            GiammGia giammGia = await db.GiammGias.FindAsync(id);
            if (giammGia == null)
            {
                return HttpNotFound();
            }
            return View(giammGia);
        }

        // GET: Admin/Discount/Create
        public ActionResult Create()
        {
            ViewBag.Idk = new SelectList(db.KhachHanggs, "ID", "Name");
            return View();
        }

        // POST: Admin/Discount/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create([Bind(Include = "IdGG,SoTien,code,Soluong,Idk,TrangThai")] GiammGia giammGia)
        {
            if (ModelState.IsValid)
            {
                // Tạo chuỗi ngẫu nhiên gồm 10 ký tự
                string randomCode = Guid.NewGuid().ToString("N").Substring(0, 10).ToUpper();
                // Gán giá trị cho thuộc tính code của đối tượng giammGia
                giammGia.code = randomCode;

                if (giammGia.TrangThai == true)
                {
                    giammGia.Idk = null;
                }

                db.GiammGias.Add(giammGia);
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }

            ViewBag.Idk = new SelectList(db.KhachHanggs, "ID", "Name", giammGia.Idk);
            return View(giammGia);
        }



        // GET: Admin/GiammGias/Delete/5
        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            GiammGia giammGia = await db.GiammGias.FindAsync(id);
            if (giammGia == null)
            {
                return HttpNotFound();
            }
            return View(giammGia);
        }

        // POST: Admin/GiammGias/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteConfirmed(int id)
        {
            GiammGia giammGia = await db.GiammGias.FindAsync(id);
            db.GiammGias.Remove(giammGia);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
        }


    }
}
