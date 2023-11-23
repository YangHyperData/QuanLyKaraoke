using QLKaraoke.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.Xml.Linq;

namespace QLKaraoke.Controllers
{
    public class CustomerInfoController : Controller
    {
        // GET: CustomerInfo
        QLKARAOKEEntities db = new QLKARAOKEEntities();
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult ModifyInfo()
        {
            if (Session["CInfo"] != null)
            {
                int id = Convert.ToInt32(((KhachHangg)Session["CInfo"]).ID.ToString());
                if (id == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                }
                KhachHangg accCustomer = db.KhachHanggs.Find(id);
                if (accCustomer == null)
                {
                    return HttpNotFound();
                }
                return View(accCustomer);
            }
            return RedirectToAction("Index");
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ModifyInfo([Bind(Include = "ID,Name,Password,Email,Phone,Address")] KhachHangg accCustomer, HttpPostedFileBase Avata)
        {
            if (ModelState.IsValid)
            {
                var existingCustomer = db.KhachHanggs.FirstOrDefault(c => c.Email == accCustomer.Email && c.ID != accCustomer.ID);
                if (existingCustomer != null)
                {
                    ModelState.AddModelError("Email", "The email address is already registered.");
                    return View(accCustomer);
                }

                KhachHangg customer = db.KhachHanggs.Find(accCustomer.ID);
                if (customer == null)
                {
                    return HttpNotFound();
                }

                // Kiểm tra xem khách hàng đã tải lên hình ảnh mới chưa
                if (Avata != null && Avata.ContentLength > 0)
                {
                    // Lưu hình ảnh mới vào thư mục trên máy chủ
                    string fileName = Path.GetFileName(Avata.FileName);
                    string filePath = Path.Combine(Server.MapPath("~/Asset/Img/"), fileName);
                    Avata.SaveAs(filePath);
                    customer.Avata = fileName;
                }
                else
                {
                    db.Entry(customer).Property(c => c.Avata).IsModified = false;
                }

                customer.Name = accCustomer.Name;
                customer.Password = accCustomer.Password;
                customer.Email = accCustomer.Email;
                customer.Phone = accCustomer.Phone;
                customer.Address = accCustomer.Address;

                db.Entry(customer).State = EntityState.Modified;
                db.Entry(customer).Property(c => c.Gender).IsModified = false;
                db.SaveChanges();
                Session["CInfo"] = customer;
                return RedirectToAction("Index");
            }

            return View(accCustomer);
        }


        public ActionResult Change()
        {

            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Change(string currentPassword, string newPassword, string confirmNewPassword)
        {
            // Lấy thông tin người dùng từ Session
            KhachHangg user = (KhachHangg)Session["CInfo"];

            // Kiểm tra mật khẩu cũ
            if (user.Password != currentPassword)
            {
                ModelState.AddModelError("", "Mật khẩu cũ không chính xác.");
                return View();
            }

            // Kiểm tra mật khẩu mới
            if (newPassword != confirmNewPassword)
            {
                ModelState.AddModelError("", "Mật khẩu mới không trùng với mật khẩu cũ.");
                return View();
            }

            // Update mật khẩu mới vào database
            using (QLKARAOKEEntities db = new QLKARAOKEEntities())
            {
                KhachHangg userProfile = db.KhachHanggs.Find(user.ID);
                userProfile.Password = newPassword;
                db.SaveChanges();
            }

            // Cập nhật thông tin người dùng trong Session
            user.Password = newPassword;
            Session["CInfo"] = user;

            ViewBag.Message = "Thay đổi thành công.";
            return RedirectToAction("Index", "CustomerInfo");
        }
        public ActionResult _Discount()
        {
            KhachHangg cust = (KhachHangg)Session["CInfo"];
            int ID = Convert.ToInt32(cust.ID.ToString());
            var dis = db.GiammGias.Include(n => n.DatPhongs).Include(n => n.KhachHangg).OrderByDescending(d => d.IdGG)
                ;
            return View(dis.ToList());
        }
        public ActionResult _BookTickket()
        {
            KhachHangg cust = (KhachHangg)Session["CInfo"];
            int ID = Convert.ToInt32(cust.ID.ToString());
            var book = db.DatPhongs
                .Include(d => d.GiammGia)
                .Include(d => d.KhachHangg)
                .Include(d => d.HOADONs)
                .OrderByDescending(d => d.Ngay == DateTime.Today)
                .ThenByDescending(d => d.Id);
            return View(book.ToList());
        }
        public ActionResult _Bill()
        {
            KhachHangg cust = (KhachHangg)Session["CInfo"];
            int ID = Convert.ToInt32(cust.ID.ToString());
            var bill = db.HOADONs.Include(d => d.DatPhong.KhachHangg).Include(d => d.DatPhong).Where(n=>n.TrangThai==true).OrderByDescending(d => d.Ngay == DateTime.Today)
                .ThenByDescending(d => d.IDHoaDon);
            return View(bill.ToList());
        }
        public ActionResult _SerVice()
        {
            KhachHangg cust = (KhachHangg)Session["CInfo"];
            int ID = Convert.ToInt32(cust.ID.ToString());
            var SerVice = db.SuDungDichVus.Include(s => s.DichVu1).Include(s => s.KhachHangg).Include(s => s.DatPhong).OrderByDescending(d => d.NgayTao == DateTime.Today)
                .ThenByDescending(d => d.ID);
            return View(SerVice.ToList());
        }
        public ActionResult _Staff()
        {
            KhachHangg cust = (KhachHangg)Session["CInfo"];
            int ID = Convert.ToInt32(cust.ID.ToString());
            var Staff = db.NhanViens.Include(s => s.ChucVu).Include(s => s.KhachHangg)
                .OrderByDescending(d => d.IDNhanVien);
            return View(Staff.ToList());
        }
        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            DatPhong dp = await db.DatPhongs.FindAsync(id);
            if (dp == null)
            {
                return HttpNotFound();
            }



            db.DatPhongs.Remove(dp);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
        }

    
    }
}
