using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;


namespace QLKaraoke.Models
{
    public class DatPhongViewModel
    {
        public DateTime NgayTao { get; set; }
        public List<SelectListItem> ListLoaiPhong { get; set; }
        public List<SelectListItem> ListPhong { get; set; }
        public List<SelectListItem> ListTime { get; set; }
        public int IdLoai { get; set; }
        public int IdPhong { get; set; }
    }

}