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
    public class DutyController : Controller
    {
        private QLKARAOKEEntities db = new QLKARAOKEEntities();

        // GET: Admin/Duty
        public async Task<ActionResult> Index()
        {
            return View(await db.ChucVus.ToListAsync());
        }

        // GET: Admin/Duty/Details/5
      
        // GET: Admin/Duty/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Admin/Duty/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create([Bind(Include = "IDChucVu,TenChucVu,NgayCapNhat,LuongCV")] ChucVu chucVu)
        {
            if (ModelState.IsValid)
            {
                if (chucVu.LuongCV == null)
                {
                    chucVu.LuongCV = 0;
                }
                chucVu.NgayCapNhat = DateTime.Now;
                db.ChucVus.Add(chucVu);
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }

            return View(chucVu);
        }
        // GET: ChucVus/Edit/5
        public async Task<ActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ChucVu chucVu = await db.ChucVus.FindAsync(id);
            if (chucVu == null)
            {
                return HttpNotFound();
            }
            return View(chucVu);
        }

        // POST: Admin/Duty/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include = "NgayCapNhat,LuongCV")] ChucVu chucVu, int id)
        {
            if (ModelState.IsValid)
            {
                var chucVuTruoc = db.ChucVus.Find(id); // Lấy chức vụ trước khi sửa

                if (chucVuTruoc != null)
                {
                    db.Entry(chucVuTruoc).State = EntityState.Detached; // detach the existing entity

                    if (chucVu.LuongCV == null)
                    {
                        chucVu.LuongCV = 0;
                    }

                    var chenhLechLuong = chucVu.LuongCV - chucVuTruoc.LuongCV; // Tính chênh lệch giữa lương mới và lương cũ

                    var nhanViens = db.NhanViens.Where(nv => nv.IDChucVu == chucVuTruoc.IDChucVu).ToList();

                    foreach (var nv in nhanViens)
                    {
                        if (chenhLechLuong < 0) // Lương mới nhỏ hơn lương cũ, trừ lương nhân viên đi chênh lệch
                        {
                            nv.Luong -= Math.Abs((double)chenhLechLuong);
                        }
                        else // Lương mới lớn hơn lương cũ, cộng lương nhân viên thêm chênh lệch
                        {
                            nv.Luong += chenhLechLuong;
                        }
                    }

                    chucVu.IDChucVu = id;
                    chucVu.TenChucVu = chucVuTruoc.TenChucVu;
                    chucVu.NgayCapNhat = DateTime.Now;
                    db.Entry(chucVu).State = EntityState.Modified;
                    await db.SaveChangesAsync();
                    return RedirectToAction("Index");
                }
                else
                {
                    // Handle the case when the existing entity is not found
                    return HttpNotFound();
                }
            }
            return View(chucVu);
        }

        // GET: Admin/Duty/Delete/5
        public async Task<ActionResult> Delete(int? id)
        {
            // Kiểm tra xem chức vụ có nhân viên sử dụng không
            var hasEmployee = await db.NhanViens.AnyAsync(nv => nv.IDChucVu == id);
            if (hasEmployee)
            {
                ModelState.AddModelError("", "Không thể xóa chức vụ này vì có nhân viên đang sử dụng");
                return RedirectToAction("Index");
            }

            // Xóa chức vụ và chuyển hướng đến trang chủ
            ChucVu chucVu = await db.ChucVus.FindAsync(id);
            db.ChucVus.Remove(chucVu);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
        }

    }
}
