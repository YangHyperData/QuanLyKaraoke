using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QLKaraoke.Models
{
    public class OrderViewModel
    {
        public KhachHangg KhachHang { get; set; }
        public List<DatPhong> DatPhongs { get; set; }
        public List<DichVu1> dichVu1s { get; set; }
        public List<SuDungDichVu> ListCart { get; set; }
        public double Total { get; set; }
    }


}