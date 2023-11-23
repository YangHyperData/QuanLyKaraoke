using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QLKaraoke.Models
{
    public class ThongKeViewModel
    {
        public double HoaDonRevenue { get; set; }
        public double DichVuRevenue { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
    }
}