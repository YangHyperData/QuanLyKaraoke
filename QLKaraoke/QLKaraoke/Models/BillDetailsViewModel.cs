using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QLKaraoke.Models
{
    public class BillDetailsViewModel
    {
        public DatPhong DatPhongs { get; set; }
        public HOADON hOADONs { get; set; }
        public List<SuDungDichVu> suDungDichVus { get; set; }
        public double TongTien { get; internal set; }
    }
}