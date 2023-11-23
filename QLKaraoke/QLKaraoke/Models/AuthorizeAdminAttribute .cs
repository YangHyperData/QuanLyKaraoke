using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QLKaraoke.Models
{
    public class AuthorizeAdminAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            var adminEmail = filterContext.HttpContext.Session["AdminEmail"];

            if (adminEmail == null)
            {
                filterContext.Result = new RedirectResult("~/Admin/Home/Login");
            }
            else
            {
                base.OnActionExecuting(filterContext);
            }
        }

    }


}