using QLKaraoke.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Net.NetworkInformation;
using System.Web;
using System.Web.Mvc;



namespace QLKaraoke.Areas.Admin.Controllers
{
    public class DaysOfWeekController : Controller
    {
        QLKARAOKEEntities db = new QLKARAOKEEntities();

        private const string KeyElement = "Ngày chiếu";

        // GET: Admin/DaysOfWeek
        public ActionResult Index()
        {
            ViewBag.Feature = "Danh sách";
            ViewBag.Element = KeyElement;
            if (Request.Url != null) ViewBag.BaseURL = Request.Url.LocalPath;

            using (QLKARAOKEEntities db = new QLKARAOKEEntities())
            {
                var listData = db.DaysOfWeeks.OrderBy(x => x.ID).ToList();
                return View(listData);
            }
        }

        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DaysOfWeek daysOfWeek = db.DaysOfWeeks.Find(id);
            if (daysOfWeek == null)
            {
                return HttpNotFound();
            }
            return View(daysOfWeek);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ID,Name,Gia")] DaysOfWeek daysOfWeek)
        {
            if (ModelState.IsValid)
            {
                // Get the current entity from the database
                var currentEntity = db.DaysOfWeeks.Find(daysOfWeek.ID);
                currentEntity.Gia = daysOfWeek.Gia;

                db.Entry(currentEntity).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index", "DaysOfWeek");
            }
            return View(daysOfWeek);
        }
    }
}