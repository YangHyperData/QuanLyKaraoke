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
    public class CTDepotController : Controller
    {
        private QLKARAOKEEntities db = new QLKARAOKEEntities();
        public ActionResult Index(DateTime? Ngay, int? page, string madat, string ten, string sdt)
        {
            var cTKhoHangs = db.CTKhoHangs.Include(c => c.KhoHang).Where(c=>c.TrangThai==false);

         
            if (Ngay.HasValue || !string.IsNullOrEmpty(madat) || !string.IsNullOrEmpty(ten) || !string.IsNullOrEmpty(sdt))
            {
                if (Ngay.HasValue)
                {
                    cTKhoHangs = cTKhoHangs.Where(l => l.Ngay == Ngay.Value);
                }
             
                if (!string.IsNullOrEmpty(ten))
                {
                    cTKhoHangs = cTKhoHangs.Where(l => l.TenSP.ToLower().Contains(ten.ToLower()));
                }
               
             
            }
            else
            {
                cTKhoHangs = cTKhoHangs.Where(l =>  l.TrangThai == false);
            }

            int pageSize = 10; // số lượng lịch đặt phòng trên mỗi trang
            int pageNumber = (page ?? 1); // số trang hiện tại (nếu không có thì mặc định là trang 1)

            return View(cTKhoHangs.OrderByDescending(n => n.IdKh).ThenByDescending(n => n.Ngay==DateTime.Now).ThenByDescending(n => n.Gio)

                                .ToPagedList(pageNumber, pageSize));
        }
        public ActionResult Index1(DateTime? Ngay, int? page, string madat, string ten, string sdt)
        {
            var cTKhoHangs = db.CTKhoHangs.Include(c => c.KhoHang).Where(c => c.TrangThai == true);

            if (Ngay.HasValue || !string.IsNullOrEmpty(madat) || !string.IsNullOrEmpty(ten) || !string.IsNullOrEmpty(sdt))
            {
                if (Ngay.HasValue)
                {
                    cTKhoHangs = cTKhoHangs.Where(l => l.Ngay == Ngay.Value);
                }

                if (!string.IsNullOrEmpty(ten))
                {
                    cTKhoHangs = cTKhoHangs.Where(l => l.TenSP.ToLower().Contains(ten.ToLower()));
                }


            }
            else
            {
                cTKhoHangs = cTKhoHangs.Where(l => l.TrangThai == true);
            }

            int pageSize = 10; // số lượng lịch đặt phòng trên mỗi trang
            int pageNumber = (page ?? 1); // số trang hiện tại (nếu không có thì mặc định là trang 1)

            return View(cTKhoHangs.OrderByDescending(n => n.IdKh).ThenByDescending(n => n.Ngay == DateTime.Now).ThenByDescending(n => n.Gio)

                                .ToPagedList(pageNumber, pageSize));
        }
        // GET: Admin/CTDepot/Details/5

        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            CTKhoHang suDungDichVu = await db.CTKhoHangs.FindAsync(id);
            if (suDungDichVu == null)
            {
                return HttpNotFound();
            }

            // Kiểm tra nếu trạng thái của SuDungDichVu là false
           

            db.CTKhoHangs.Remove(suDungDichVu);
            await db.SaveChangesAsync();
            if (suDungDichVu.TrangThai == true)
            {
                return RedirectToAction("Index1");
            }
            else
            {
                return RedirectToAction("Index");
            }    
          
        }


    }
}
