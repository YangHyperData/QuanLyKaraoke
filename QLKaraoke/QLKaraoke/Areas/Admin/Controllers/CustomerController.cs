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
    public class CustomerController : Controller
    {
        private QLKARAOKEEntities db = new QLKARAOKEEntities();

        // GET: Admin/Customer

        public ActionResult Index( int? page, string Email, string ten, string sdt)
        {
            IQueryable<KhachHangg> hOADONs = db.KhachHanggs;
           
            if (!string.IsNullOrEmpty(Email))
            {
                hOADONs = hOADONs.Where(l => l.Email.Contains(Email));
            }
            if (!string.IsNullOrEmpty(ten))
            {
                hOADONs = hOADONs.Where(l => l.Name.ToLower().Contains(ten.ToLower()));
            }
            if (!string.IsNullOrEmpty(sdt))
            {
                hOADONs =hOADONs.Where(l => l.Phone.ToLower().Contains(sdt.ToLower()));
            }

            int pageSize = 10; // số lượng lịch đặt phòng trên mỗi trang
            int pageNumber = (page ?? 1); // số trang hiện tại (nếu không có thì mặc định là trang 1)

            return View(hOADONs.OrderByDescending(n => n.ID )

                                .ToPagedList(pageNumber, pageSize));
        }



        // GET: Admin/Customer/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Admin/Customer/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create([Bind(Include = "ID,Name,Password,Email,Phone,Address,Avata,Gender")] KhachHangg accCustomer)
        {
            if (ModelState.IsValid)
            {
                var existingCustomer = db.KhachHanggs.FirstOrDefault(c => c.Email == accCustomer.Email);
                if (existingCustomer != null)
                {
                    ModelState.AddModelError("Email", "Email đã được đăng ký.");
                    return View(accCustomer);
                }

                if (string.IsNullOrEmpty(accCustomer.Gender))
                {
                    ModelState.AddModelError("Gender", "Vui lòng chọn giới tính.");
                    return View(accCustomer);
                }

                if (accCustomer.Gender == "Nữ")
                {
                    accCustomer.Avata = "nu.jpg";
                }
                else if (accCustomer.Gender == "Nam")
                {
                    accCustomer.Avata = "profile-img.jpg";
                }
                else
                {
                    accCustomer.Avata = "nu.jpg";
                }

                db.KhachHanggs.Add(accCustomer);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(accCustomer);
        }
   

        // GET: Admin/Customer/Edit/5
        public async Task<ActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            KhachHangg khachHangg = await db.KhachHanggs.FindAsync(id);
            if (khachHangg == null)
            {
                return HttpNotFound();
            }
            return View(khachHangg);
        }

        // POST: Admin/Customer/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include = "ID,Password")] KhachHangg khachHangg)
        {
            if (ModelState.IsValid)
            {
                var existingKhachHangg = await db.KhachHanggs.FindAsync(khachHangg.ID);
                if (existingKhachHangg == null)
                {
                    return HttpNotFound();
                }
                existingKhachHangg.Password = khachHangg.Password;
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            return View(khachHangg);
        }

        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            KhachHangg khachHangg = await db.KhachHanggs.FindAsync(id);
            if (khachHangg == null)
            {
                return HttpNotFound();
            }

           
            db.KhachHanggs.Remove(khachHangg);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
        }


     
    }
}
