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
    public class TimesController : Controller
    {
        private QLKARAOKEEntities db = new QLKARAOKEEntities();

        // GET: Admin/Times
        public async Task<ActionResult> Index()
        {
            List<Time> times = await db.Times.ToListAsync();
            return View(times);
        }




        // GET: Admin/Times/Create
        public async Task<ActionResult> Create()
        {
            // Get all existing time slots
            var timeSlots = await db.Times.ToListAsync();

            // Pass the time slots to the view via ViewBag
            ViewBag.TimeSlots = timeSlots;

            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create([Bind(Include = "Id,TimeStar,TimeEnd,Gia")] Time time)
        {
            // Check for existing time slot with same start and end time
            bool existingTimeSlot = await db.Times.AnyAsync(t => t.TimeStar == time.TimeStar && t.TimeEnd == time.TimeEnd);

            if (existingTimeSlot)
            {
                ModelState.AddModelError("", "Khoảng thời gian đã tồn tại.");
            }
            else if (ModelState.IsValid)
            {
                db.Times.Add(time);
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }

            // Get all existing time slots
            var timeSlots = await db.Times.ToListAsync();

            // Pass the time slots to the view via ViewBag
            ViewBag.TimeSlots = timeSlots;

            return View(time);
        }


        // GET: Admin/Times/Edit/5
        public async Task<ActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Time time = await db.Times.FindAsync(id);
            if (time == null)
            {
                return HttpNotFound();
            }
            return View(time);
        }

        // POST: Admin/Times/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include = "Id,TimeStar,TimeEnd,Gia")] Time time)
        {
            if (ModelState.IsValid)
            {
                db.Entry(time).State = EntityState.Modified;
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            return View(time);
        }


        // GET: Admin/Times/Delete/5
        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Time time = await db.Times.FindAsync(id);
            if (time == null)
            {
                return HttpNotFound();
            }
            return View(time);
        }

        // POST: Admin/Times/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteConfirmed(int id)
        {
            Time time = await db.Times.FindAsync(id);
            db.Times.Remove(time);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
        }

        
    }
}
