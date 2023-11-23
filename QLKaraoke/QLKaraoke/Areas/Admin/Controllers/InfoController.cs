using QLKaraoke.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QLKaraoke.Areas.Admin.Controllers
{
    public class InfoController : Controller
    {

        // GET: Admin/Info
        QLKARAOKEEntities db = new QLKARAOKEEntities(); 

        public ActionResult Index()
        {
            using (QLKARAOKEEntities db = new QLKARAOKEEntities())
            {
                string email = User.Identity.Name; // Lấy email của người dùng đã đăng nhập
                var user = db.QuanLiis.FirstOrDefault(u => u.Email == email); // Tìm thông tin của người dùng từ email
                if (user != null)
                {
                    QuanLii userProfile = new QuanLii();
                    userProfile.Id = user.Id;
                    userProfile.Ten = user.Ten;
                    userProfile.Gender = user.Gender;
                    userProfile.Sdt = user.Sdt;
                    userProfile.ChucVu = user.ChucVu;
                    userProfile.MatKhau = user.MatKhau;
                    userProfile.HinhAnh = user.HinhAnh;
                    userProfile.Email = user.Email;

                    // Lưu đối tượng userProfile vào Session để sử dụng trong các request sau
                    Session["UserProfile"] = userProfile;
                }
            }

            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Change(string currentPassword, string newPassword, string confirmNewPassword)
        {
            // Lấy thông tin người dùng từ Session
            QuanLii user = (QuanLii)Session["UserProfile"];

            // Kiểm tra mật khẩu cũ
            if (user.MatKhau != currentPassword)
            {
                TempData["Error"] = "Mật khẩu cũ không chính xác.";
                return RedirectToAction("Index", "Home");
            }

            // Kiểm tra mật khẩu mới
            if (newPassword != confirmNewPassword)
            {
                TempData["Error"] = "Mật khẩu mới không trùng với mật khẩu cũ.";
                return RedirectToAction("Index", "Home");
            }

            // Update mật khẩu mới vào database
            using (QLKARAOKEEntities db = new QLKARAOKEEntities())
            {
                QuanLii userProfile = db.QuanLiis.Find(user.Id);
                userProfile.MatKhau = newPassword;
                db.SaveChanges();
            }

            // Cập nhật thông tin người dùng trong Session
            user.MatKhau = newPassword;
            Session["UserProfile"] = user;

            TempData["SuccessMessage"] = "Thay đổi mật khẩu thành công.";
            return RedirectToAction("Index","Home");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditProfile(QuanLii user, HttpPostedFileBase HinhAnh)
        {
            // Check ModelState to determine validity of data
            if (ModelState.IsValid)
            {
                using (QLKARAOKEEntities db = new QLKARAOKEEntities())
                {
                    // Get current user information from Session
                    QuanLii currentUser = (QuanLii)Session["UserProfile"];

                    // Check if user uploaded a new image
                    if (HinhAnh != null && HinhAnh.ContentLength > 0)
                    {
                        // Save the new image to a folder on the server
                        string fileName = Path.GetFileName(HinhAnh.FileName);
                        string filePath = Path.Combine(Server.MapPath("~/Areas/Admin/assets/img/"), fileName);
                        HinhAnh.SaveAs(filePath);
                        user.HinhAnh = fileName;
                    }
                    else
                    {
                        // If no new image uploaded, keep the current image
                        user.HinhAnh = currentUser.HinhAnh;
                    }

                    // Update user information in the database
                    QuanLii userProfile = db.QuanLiis.Find(currentUser.Id);
                    userProfile.Ten = user.Ten;
                    userProfile.Sdt = user.Sdt;
                    userProfile.ChucVu = user.ChucVu;
                    userProfile.HinhAnh = user.HinhAnh;
                    db.SaveChanges();

                    // Update user information in Session
                    currentUser.Ten = user.Ten;
                    currentUser.Sdt = user.Sdt;
                    currentUser.ChucVu = user.ChucVu;
                    currentUser.HinhAnh = user.HinhAnh;
                    Session["UserProfile"] = currentUser;
                    Session["AdminTen"] = user.Ten;
                    Session["AdminHinh"] = user.HinhAnh;
                    Session["AdminChucVu"] = user.ChucVu;

                    ViewBag.Message = "Cập nhật thông tin thành công.";
                    return RedirectToAction("Index", "Home");
                }
            }

            return View(user);
        }



    }
}