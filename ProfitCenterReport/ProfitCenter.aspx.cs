using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ProfitCenterReport.Datalayer;
using System.Data;

namespace ProfitCenterReport
{
    public partial class ProfitCenter : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindProfitCenter();

        }

        public void BindProfitCenter()
        {
            ReportDB _db = new ReportDB();
            DataTable dt = _db.GetProfitCenter();
           // = dt.Columns["ProfitCenterName"].Caption;
            ddlProfitCenter.DataSource = dt;
            ddlProfitCenter.DataTextField = dt.Columns["ProfitCenterName"].Caption;
            ddlProfitCenter.DataValueField = dt.Columns["ProfitCenter"].Caption;
            ddlProfitCenter.DataBind();
            ddlProfitCenter.Items.Insert(0, new ListItem("--Select Center--", "-1"));

        }

        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                Session["centername"] = ddlProfitCenter.SelectedItem.Text;
                Response.Redirect("Report.aspx?centerid=" + ddlProfitCenter.SelectedItem.Value + "&unit=" + DropDownRsType.SelectedItem.Value + "&role=E");
            }
        }


    }
}