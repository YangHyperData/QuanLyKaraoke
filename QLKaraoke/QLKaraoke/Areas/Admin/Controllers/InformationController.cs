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
    public class InformationController : Controller
    {
        private QLKARAOKEEntities db = new QLKARAOKEEntities();

        // GET: Admin/Information
    
        public ActionResult Index(int? page, int? id)
        {
          
            var tinTucs = db.ThongTins;
        
            int pageSize = 10;
            int pageNumber = (page ?? 1);
            return View(tinTucs.OrderByDescending(n=>n.Id).ToPagedList(pageNumber, pageSize));
        }
        // GET: Admin/Information/Details/5
        public async Task<ActionResult> Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ThongTin thongTin = await db.ThongTins.FindAsync(id);
            if (thongTin == null)
            {
                return HttpNotFound();
            }
            return View(thongTin);
        }

        // GET: Admin/Information/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Admin/Information/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public async Task<ActionResult> Create([Bind(Include = "Id,TieuDe,ThongTinn,Hinhanh")] ThongTin thongTin, HttpPostedFileBase Hinhanh)
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
                    thongTin.Hinhanh = newName;
                }
          
                thongTin.Ngay = DateTime.Now;
       
                db.ThongTins.Add(thongTin);
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }

            return View(thongTin);
        }

        // GET: Admin/Information/Edit/5
        public async Task<ActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ThongTin thongTin = await db.ThongTins.FindAsync(id);
            if (thongTin == null)
            {
                return HttpNotFound();
            }
            return View(thongTin);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public async Task<ActionResult> Edit([Bind(Include = "Id,TieuDe,ThongTinn,Hinhanh")] ThongTin thongTin, HttpPostedFileBase Hinhanh)
        {
            var existingDichVu = db.ThongTins.Find(thongTin.Id);
            if (ModelState.IsValid)
            {
                thongTin.Ngay = DateTime.Now;

                // Check if the file was uploaded
                if (Hinhanh != null && Hinhanh.ContentLength > 0)
                {
                    // Delete the old image file
                    if (existingDichVu.Hinhanh != null)
                    {
                        string oldImagePath = Path.Combine(Server.MapPath("~/Areas/Admin/assets/img/"), existingDichVu.Hinhanh);
                        if (System.IO.File.Exists(oldImagePath))
                        {
                            System.IO.File.Delete(oldImagePath);
                        }
                    }

                    // Save the new image file
                    string extension = Path.GetExtension(Hinhanh.FileName);
                    string imageName = DateTime.Now.ToString("yyyyMMddHHmmssfff") + extension;
                    string imagePath = Path.Combine(Server.MapPath("~/Areas/Admin/assets/img/"), imageName);
                    Hinhanh.SaveAs(imagePath);
                    thongTin.Hinhanh = imageName;
                }
                else
                {
                    // Keep the existing image if no new file is uploaded
                    thongTin.Hinhanh = existingDichVu.Hinhanh;
                }

                // Update the entity
                db.Entry(existingDichVu).CurrentValues.SetValues(thongTin);
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            return View(thongTin);
        }


    }
}
