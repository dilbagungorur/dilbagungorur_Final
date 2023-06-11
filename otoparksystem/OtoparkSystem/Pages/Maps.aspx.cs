using OtoparkSystem.Models.Manager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OtoparkSystem.Pages
{
    public partial class Maps : System.Web.UI.Page
    {
        public int? numaraId
        {
            get
            {
                return Convert.ToInt32( ViewState["numaraId"]);
            }
            set
            {
                ViewState["numaraId"] = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.numaraId = Convert.ToInt32(Request.Params["numaraId"]);
                LoadIsparks();
            }
        }

        private void LoadIsparks()
        {
            var result = IsParkManager.GetIsParks(this.numaraId.Value);
            hdnValue.Value = result;
        }
    }
}