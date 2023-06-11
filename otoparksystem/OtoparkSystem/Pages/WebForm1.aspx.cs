using OtoparkSystem.Models.Manager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OtoparkSystem.Pages
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAracTurleri();

            }
        }

        private void LoadAracTurleri()
        {
            var result = AracTurleriManager.GetAracTurleri();
            rptAracTurleri.DataSource = result;
            rptAracTurleri.DataBind();

            //drpAracTurleri.DataSource = result;
            //drpAracTurleri.DataValueField = "NumaraId";
            //drpAracTurleri.DataTextField = "Name";
            //drpAracTurleri.DataBind();
        }

        protected void btnyönlendir_Click(object sender, EventArgs e)
        {
            LinkButton btnyönlendir = sender as LinkButton;
            HiddenField hdnNumaraId = btnyönlendir.FindControl("hdnNumaraId") as HiddenField;
            Response.Redirect("Maps.aspx?numaraId=" + hdnNumaraId.Value);
        }
    }
}