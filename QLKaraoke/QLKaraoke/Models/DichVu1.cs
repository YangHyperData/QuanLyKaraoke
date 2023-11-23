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
    
    public partial class DichVu1
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public DichVu1()
        {
            this.SuDungDichVus = new HashSet<SuDungDichVu>();
        }
    
        public int IDDichVu { get; set; }
        public Nullable<int> IDKhoHang { get; set; }
        public Nullable<double> DonGia { get; set; }
        public string DVT { get; set; }
        public string LoaiDV { get; set; }
        public string HinhAnh { get; set; }
        public Nullable<int> SoLuong { get; set; }
        public Nullable<double> GiaBan { get; set; }
        public Nullable<double> TongGia { get; set; }
        public Nullable<int> DaBan { get; set; }
        public string Ten { get; set; }
        public Nullable<int> IdLoai { get; set; }
        public Nullable<int> IDDVT { get; set; }
        public Nullable<int> soluongthem { get; set; }
        public string MoTa { get; set; }
    
        public virtual DonViTinh DonViTinh { get; set; }
        public virtual KhoHang KhoHang { get; set; }
        public virtual LoaiDV LoaiDV1 { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<SuDungDichVu> SuDungDichVus { get; set; }
    }
}