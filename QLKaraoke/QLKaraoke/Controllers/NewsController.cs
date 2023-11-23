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
using System.Web.UI;
using PagedList;
using System.IO;
using System.Web.Helpers;

namespace QLKaraoke.Controllers
{
    public class NewsController : Controller
    {
        private QLKARAOKEEntities db = new QLKARAOKEEntities();

        public ActionResult Index(int? page, string searchTerm)
        {
            int pageNum = page ?? 1;
            int pageSize = 6;
            var tinTucs = db.TinTucs.Include(t => t.ChucVu);

            if (!string.IsNullOrEmpty(searchTerm))
            {
                tinTucs = tinTucs.Where(l => l.TieuDe.Contains(searchTerm));
            }
            var pagedTinTucs = tinTucs.Where(n => n.TrangThai == 1||(n.TrangThai==1&&n.TrangThaiTin==2&&n.Soluong>0))
                                      .OrderByDescending(n => n.Ngay)
                                      .ToPagedList(pageNum, pageSize);

            return View(pagedTinTucs);
        }
     

        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TinTuc tinTuc = db.TinTucs.Find(id);
            if (tinTuc == null)
            {
                return HttpNotFound();
            }
            return View(tinTuc);
        }

        public ActionResult Job(int? id)
        {
            var tt = db.TinTucs.FirstOrDefault(d => d.Id == id);
            if (tt == null)
            {
                return HttpNotFound();
            }

            if (Session["CInfo"] == null)
            {
                return RedirectToAction("Login", "Security");
            }

            var khachHang = (KhachHangg)Session["CInfo"];

            // Kiểm tra thời gian bắt đầu và kết thúc có hợp lệ hay không.
            var nv = new NhanVien();
            ViewBag.Ma = tt.Id;
            var model = new Tuple<TinTuc, NhanVien, KhachHangg>(tt, nv, khachHang);
            return View(model);
        }
        [HttpPost]
        public ActionResult Job(int? id,NhanVien nhan, HttpPostedFileBase HinhAnh)
        {
            if (ModelState.IsValid)
            {
                var khachHang = (KhachHangg)Session["CInfo"];
                var tt = db.TinTucs.FirstOrDefault(d => d.Id == id);

                if (tt == null)
                {
                    return HttpNotFound();
                }
                if (HinhAnh != null && HinhAnh.ContentLength > 0)
                {
                    // Get the file name and extension
                    var fileName = Path.GetFileName(HinhAnh.FileName);
                    var extension = Path.GetExtension(fileName);

                    // Generate a unique file name to avoid conflicts
                    var newName = Guid.NewGuid().ToString("N") + extension;

                    // Save the file to the server
                    var path = Path.Combine(Server.MapPath("~/Areas/Admin/assets/img/"), newName);
                    HinhAnh.SaveAs(path);

                    // Update the employee's image URL
                    nhan.HinhAnh = newName;
                }
               
                nhan.IdTin= tt.Id;
                nhan.Luong=tt.Luong;
                nhan.IDChucVu=tt.ChucVuId;
                nhan.TrangThai = 2;
                nhan.IdTin = tt.Id;
                
                if (khachHang != null)
                {
                    nhan.IdKh = khachHang.ID;
                    if (nhan.SDT == null)
                    {
                        nhan.SDT = khachHang.Phone;

                    }
                    if (nhan.Email == null)
                    {
                        nhan.Email = khachHang.Email;
                    }
                    if (nhan.DiaChi == null)
                    {
                        nhan.DiaChi = khachHang.Address;
                    }
                    if (nhan.HinhAnh == null)
                    {
                        nhan.HinhAnh = khachHang.Avata;
                    }
                    if (nhan.GioiTinh == null)
                    {
                        nhan.GioiTinh = khachHang.Gender;
                    }
                }
                db.NhanViens.Add(nhan);
                db.SaveChanges();
                return RedirectToAction("Success1", new { id = nhan.IDNhanVien });
            }
            else
            {
                var khachHang = (KhachHangg)Session["CInfo"];
                var tt = db.TinTucs.FirstOrDefault(d => d.Id == nhan.IdTin);

                var model = new Tuple<TinTuc, NhanVien, KhachHangg>(tt, nhan, khachHang);

                return View("BookRoom", model);
            }
        }
        public ActionResult Success1(int id)
        {
            var nhanVien = db.NhanViens.FirstOrDefault(n => n.IDNhanVien == id);
            if (nhanVien == null)
            {
                return HttpNotFound();
            }

            var khachHang = db.KhachHanggs.FirstOrDefault(kh => kh.ID == nhanVien.IdKh);

            var model = new Tuple<NhanVien, KhachHangg>(nhanVien, khachHang);
            return View(model);
        }

    }

}

