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
    
    public partial class GiammGia
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public GiammGia()
        {
            this.DatPhongs = new HashSet<DatPhong>();
        }
    
        public int IdGG { get; set; }
        public Nullable<double> SoTien { get; set; }
        public string code { get; set; }
        public int Soluong { get; set; }
        public Nullable<int> Idk { get; set; }
        public Nullable<bool> TrangThai { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DatPhong> DatPhongs { get; set; }
        public virtual KhachHangg KhachHangg { get; set; }
    }
}