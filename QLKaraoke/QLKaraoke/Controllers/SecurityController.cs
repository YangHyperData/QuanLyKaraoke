using QLKaraoke.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QLKaraoke.Controllers
{
    public class SecurityController : Controller
    {
        QLKARAOKEEntities db = new QLKARAOKEEntities();
        // GET: Security
        public ActionResult Login()
        {
            return View();
        }
        public ActionResult Register()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult LoginToSystem(FormCollection frm)
        {
            string Email = frm["CEmail"].ToString();
            string Password = frm["CPassword"].ToString();
            var Result = db.KhachHanggs.Where(n => n.Email == Email && n.Password == Password).ToList();
            if (Result.Count() > 0)
            {

                Session["CEmail"] = Email;
                Session["CName"] = Result[0].Name;
                Session["CInfo"] = Result[0];

                Response.Redirect("~/Home/Index");
            }
            if (Result == null)
            {
                TempData["Error"] = "Tài Khoản hoặc Mật Khẩu Không Đúng";
            }
            TempData["Error"] = "Tài Khoản hoặc Mật Khẩu Không Đúng";
            return RedirectToAction("Login");

        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Register([Bind(Include = "ID,Name,Password,ConfirmPassword,Email,Phone,Address,Avata,Gender")] KhachHangg accCustomer, string ConfirmPassword)
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
                    ModelState.AddModelError("Giới Tính", "Vui lòng chọn giới tính.");
                    return View(accCustomer);
                }

                if (accCustomer.Password != ConfirmPassword)
                {
                    ModelState.AddModelError("", "Mật khẩu nhập lại không trùng với mật khẩu trên.");
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
                return RedirectToAction("Login", "Security");
            }

            return View(accCustomer);
        }




    }
}