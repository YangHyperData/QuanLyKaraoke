using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QLKaraoke.Models
{
    public class RoomDetailViewModel
    {
        public int IdDate { get; set; }
        public int IdLoai { get; set; }
        public int IdPhong { get; set; }
        public string TenPhong { get; set; }
        public string LoaiPhong { get; set; }
        public DateTime NgayDatPhong { get; set; }
        public TimeSpan ThoiGianBatDau { get; set; }
        public TimeSpan ThoiGianKetThuc { get; set; }
        public KhachHangg KhachHang { get; set; }
        public Phong phong { get; set; }
        public DatPhong datPhong { get; set; }
        public double TongGia { get; set; }
     
    }
}