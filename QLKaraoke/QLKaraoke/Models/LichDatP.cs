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
    
    public partial class LichDatP
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public LichDatP()
        {
            this.DatPhongs = new HashSet<DatPhong>();
        }
    
        public int Id { get; set; }
        public Nullable<int> IdDate { get; set; }
        public Nullable<int> IdLoai { get; set; }
        public Nullable<int> IdPhong { get; set; }
        public Nullable<System.TimeSpan> TimeStar { get; set; }
        public Nullable<System.TimeSpan> TimeEnd { get; set; }
        public Nullable<System.DateTime> Ngay { get; set; }
        public Nullable<double> TongGia { get; set; }
        public Nullable<int> IdKh { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DatPhong> DatPhongs { get; set; }
        public virtual DaysOfWeek DaysOfWeek { get; set; }
        public virtual KhachHangg KhachHangg { get; set; }
        public virtual KhachHangg KhachHangg1 { get; set; }
        public virtual LoaiPhong LoaiPhong { get; set; }
        public virtual Phong Phong { get; set; }
    }
}
