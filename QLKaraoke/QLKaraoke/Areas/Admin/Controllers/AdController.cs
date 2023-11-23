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
    public class AdController : Controller
    {
        private QLKARAOKEEntities db = new QLKARAOKEEntities();

        // GET: Admin/Ad
  
        public ActionResult Index(int? page, string Email, string ten, string sdt)
        {
            IQueryable<QuanLii> hOADONs = db.QuanLiis;

            if (!string.IsNullOrEmpty(Email))
            {
                hOADONs = hOADONs.Where(l => l.Email.Contains(Email));
            }
            if (!string.IsNullOrEmpty(ten))
            {
                hOADONs = hOADONs.Where(l => l.Ten.ToLower().Contains(ten.ToLower()));
            }
            if (!string.IsNullOrEmpty(sdt))
            {
                hOADONs = hOADONs.Where(l => l.Sdt.ToLower().Contains(sdt.ToLower()));
            }

            int pageSize = 10; // số lượng lịch đặt phòng trên mỗi trang
            int pageNumber = (page ?? 1); // số trang hiện tại (nếu không có thì mặc định là trang 1)

            return View(hOADONs.OrderByDescending(n => n.Id)

                                .ToPagedList(pageNumber, pageSize));
        }


        // GET: Admin/Ad/Details/5
        public ActionResult Create()
        {
            return View();
        }
        // GET: Admin/Ad/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create( QuanLii quanLii)
        {
           
            if (ModelState.IsValid)
            {
                var existingCustomer = db.QuanLiis.FirstOrDefault(c => c.Email == quanLii.Email);
                if (existingCustomer != null)
                {
                    ModelState.AddModelError("Email", "Email đã được đăng ký.");
                }

                if (string.IsNullOrEmpty(quanLii.Gender))
                {
                    ModelState.AddModelError("Gender", "Vui lòng chọn giới tính.");
                }

                if (ModelState.IsValid)
                {
                    if (quanLii.Gender == "Nữ")
                    {
                        quanLii.HinhAnh = "nu.jpg";
                    }
                    else if (quanLii.Gender == "Nam")
                    {
                        quanLii.HinhAnh = "profile-img.jpg";
                    }
                    else
                    {
                        quanLii.HinhAnh = "nu.jpg";
                    }

                    quanLii.ChucVu = "Quản lý";
                    db.QuanLiis.Add(quanLii);
                    await db.SaveChangesAsync();
                    return RedirectToAction("Index");
                }
            }
            return View(quanLii);
        }

        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            QuanLii khachHangg = await db.QuanLiis.FindAsync(id);
            if (khachHangg == null)
            {
                return HttpNotFound();
            }


            db.QuanLiis.Remove(khachHangg);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
        }

    }
}
