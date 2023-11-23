using QLKaraoke.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace QLKaraoke.Controllers
{
    public class InformationController : Controller
    {
        QLKARAOKEEntities db = new QLKARAOKEEntities();
        public async Task<ActionResult> Index(int? id)
        {
            if (id == null)
            {
                id = 1; // Set id to 1 if it is null
            }

            ThongTin thongTin = await db.ThongTins.FindAsync(id);

            if (thongTin == null)
            {
                return HttpNotFound();
            }

            return View(thongTin);
        }

    }
}