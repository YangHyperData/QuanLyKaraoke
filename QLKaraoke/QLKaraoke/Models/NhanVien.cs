//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace QLKaraoke.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class NhanVien
    {
        public int IDNhanVien { get; set; }
        public string HoTenNV { get; set; }
        public string HinhAnh { get; set; }
        public string DiaChi { get; set; }
        public string SDT { get; set; }
        public Nullable<double> Luong { get; set; }
        public string Email { get; set; }
        public Nullable<int> TrangThai { get; set; }
        public string GioiTinh { get; set; }
        public Nullable<System.DateTime> NgaySinh { get; set; }
        public Nullable<int> IDChucVu { get; set; }
        public Nullable<int> IdTin { get; set; }
        public Nullable<int> IdKh { get; set; }
    
        public virtual ChucVu ChucVu { get; set; }
        public virtual KhachHangg KhachHangg { get; set; }
        public virtual TinTuc TinTuc { get; set; }
    }
}
