using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Collections;
using System.Configuration;
using System.IO;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;

namespace ProfitCenterReport
{
    public partial class Report : System.Web.UI.Page
    {
        static int pcId = 0;
        static int unit = 1;
        static string tfName = string.Empty;
        static string strRole = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["centerid"]))
                {
                    pcId = Convert.ToInt32(Request.QueryString["centerid"]);
                    strRole = Request.QueryString["role"];
                    BindMenuItem(pcId);
                    lblCntName.Text = Convert.ToString(Session["centername"]);

                    if (!string.IsNullOrEmpty(Request.QueryString["tfName"]))
                    {
                        tfName = Request.QueryString["tfName"].ToString();
                        lblFormName.Text = tfName;
                        if (!string.IsNullOrEmpty(Request.QueryString["unit"]) && Request.QueryString["unit"].ToUpper() == "C")
                            unit = 10000000;
                        else
                            unit = 100000;

                        BindGrid();
                    }
                }
            }
        }

        private void BindGrid()
        {
            try
            {
                ReportDB _db = new ReportDB();
                string actualYear = ConfigurationManager.AppSettings["ActualYear"];
                DataSet dt = _db.GetReportData(pcId, tfName, Convert.ToInt32(actualYear), unit);
                lblHeaderName.Text = dt.Tables[2].Rows[0][0].ToString();
                if (dt.Tables[0] != null)
                {
                    GridView1.DataSource = dt.Tables[0];
                    GridView1.DataBind();
                    if (dt.Tables[0].Rows.Count > 0)
                    {
                        GridView1.HeaderRow.Cells[1].Text = GetActualYear(actualYear) + "<br/>" + GridView1.HeaderRow.Cells[1].Text;
                        for (int i = 0; i < dt.Tables[1].Rows.Count; i++)
                        {
                            GridView1.HeaderRow.Cells[i + 2].Text = dt.Tables[1].Rows[i][0] + "<br/>" + GridView1.HeaderRow.Cells[i + 2].Text;
                        }

                        //making particular bold
                        GridView1.Rows[GridView1.Rows.Count - 1].Cells[0].Font.Bold = true;

                        //making total row bold
                        foreach (TableCell item in GridView1.Rows[GridView1.Rows.Count - 1].Cells)
                        {
                            item.Font.Bold = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        private string GetActualYear(string actualYear)
        {

            if (actualYear.Length > 7)
                return actualYear.Substring(0, 4) + '-' + actualYear.Substring(4, 4);
            else
                return actualYear;
        }

        public void BindMenuItem(int profitCenter)
        {
            if (Session["menuContent"] != null)
            {
                cssmenu.InnerHtml = Session["menuContent"].ToString();
                return;
            }
            ReportDB _db = new ReportDB();
            DataTable dt = _db.GetMenuItem(profitCenter);
            StringBuilder sb = new StringBuilder();
            sb.Append("<ul>");
            ArrayList str = new ArrayList();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string strFyear = dt.Rows[i][0].ToString();
                string[] arrFy = strFyear.Split('(');
                if (arrFy.Length > 1)
                {
                    if (!str.Contains(arrFy[0]))
                    {
                        if (str.Count == 0)
                            sb.Append("<li class='has-sub'><a href='#'><span>" + arrFy[0] + "</span></a><ul>");
                        else
                            sb.Append("</ul></li><li class='has-sub'><a href='#'><span>" + arrFy[0] + "</span></a><ul>");
                        str.Add(arrFy[0]);
                    }
                    sb.Append("<li class='has-sub'><a href='" + string.Format("Report.aspx?centerid={0}&tfName={1}&unit={2}&role={3}", profitCenter, dt.Rows[i][0].ToString(), unit, strRole) + "'><span>" + dt.Rows[i][0].ToString() + "</span></a></li>");
                }
                else
                {
                    sb.Append("<li><a href='" + dt.Rows[i][0].ToString() + "'><span>" + dt.Rows[i][0].ToString() + "</span></a><ul>");
                }

            }
            sb.Append("</ul> </li></ul>");
            Session["menuContent"] = sb.ToString();
            cssmenu.InnerHtml = sb.ToString();
        }

        protected void btnReport_Click(object sender, EventArgs e)
        {
            ReportDB _db = new ReportDB();
            DataTable formTable = _db.GetMenuItem(pcId);
            DataSet ds = null;

            ////Create new Excel Workbook
            var workbook = new HSSFWorkbook();
            foreach (DataRow item in formTable.Rows)
            {
                HSSFSheet sheet = (HSSFSheet)workbook.CreateSheet(item[0].ToString());

                string actualYear = ConfigurationManager.AppSettings["ActualYear"];

                //Getting reportData
                ds = new ReportDB().GetReportData(pcId, item[0].ToString(), Convert.ToInt32(actualYear), unit);


                //setting width of cloumns in excel
                sheet.SetColumnWidth(0, 25 * 256);
                for (int i = 2; i < ds.Tables[0].Columns.Count; i++)
                {
                    sheet.SetColumnWidth(i, 15 * 256);
                }

                HSSFRow firstRow = (HSSFRow)sheet.CreateRow(1);

                firstRow.CreateCell(1).SetCellValue(GetActualYear(actualYear));
                for (int i = 2; i < ds.Tables[1].Rows.Count + 2; i++)
                {
                    var row = ds.Tables[1].Rows[i - 2];
                    firstRow.CreateCell(i).SetCellValue(Convert.ToString(row[0]));
                }



                // handling value.
                int rowIndex = 3;
                foreach (DataRow row in ds.Tables[0].Rows)
                {


                    HSSFRow secondRow = (HSSFRow)sheet.CreateRow(2);

                    HSSFRow dataRow = (HSSFRow)sheet.CreateRow(rowIndex);
                    rowIndex++;
                    foreach (DataColumn column in ds.Tables[0].Columns)
                    {
                        secondRow.CreateCell(column.Ordinal).SetCellValue(column.ColumnName);

                        if (!System.DBNull.Value.Equals(row[column]))
                        {
                            if (column.DataType == typeof(Nullable))
                                dataRow.CreateCell(column.Ordinal).SetCellValue(Convert.ToString(row[column]));
                            else if (column.DataType == typeof(DateTime))
                                dataRow.CreateCell(column.Ordinal).SetCellValue(Convert.ToDateTime(row[column]));
                            else if (column.DataType == typeof(decimal))
                                dataRow.CreateCell(column.Ordinal).SetCellValue(Convert.ToDouble(row[column]));
                            else
                                dataRow.CreateCell(column.Ordinal).SetCellValue(Convert.ToString(row[column]));
                        }
                    }
                }
            }

            //Write the Workbook to a memory stream
            MemoryStream output = new MemoryStream();
            workbook.Write(output);

            //return File(output.ToArray(),   //The binary data of the XLS file
            //"application/vnd.ms-excel",//MIME type of Excel files
            //"ArticleList.xls");


            FileStream file = new FileStream(Server.MapPath("/Export/report.xls"), FileMode.Create, FileAccess.Write);
            output.WriteTo(file);

            output.Close();
            file.Close();
        }

        private void GenerateExcel(DataSet customerOrders)
        {
            try
            {
                ////Create new Excel Workbook
                var workbook = new HSSFWorkbook();
                int index = 0;
                string[] sheetName = "JPR-LKW,F1,F2".Split(',');
                CellStyle cellStyleBold = workbook.CreateCellStyle();
                Font boldFont = workbook.CreateFont();
                cellStyleBold.SetFont(boldFont);
                foreach (DataTable table in customerOrders.Tables)
                {
                    //Create header 
                    HSSFSheet sheet = (HSSFSheet)workbook.CreateSheet(sheetName[index++]);
                    HSSFRow headerRow = (HSSFRow)sheet.CreateRow(0);
                    headerRow.CreateCell(0).SetCellValue("this is bold content");
                    headerRow.GetCell(0).CellStyle = cellStyleBold;
                    headerRow.CreateCell(1).SetCellValue("this is second column");
                    HSSFRow secondRow = (HSSFRow)sheet.CreateRow(2);

                    foreach (DataColumn column in table.Columns)
                        secondRow.CreateCell(column.Ordinal).SetCellValue(column.ColumnName);

                    // handling value.
                    int rowIndex = 1;
                    foreach (DataRow row in table.Rows)
                    {
                        HSSFRow dataRow = (HSSFRow)sheet.CreateRow(rowIndex);
                        rowIndex++;
                        foreach (DataColumn column in table.Columns)
                        {
                            if (!System.DBNull.Value.Equals(row[column]))
                            {
                                if (column.DataType == typeof(Nullable))
                                    dataRow.CreateCell(column.Ordinal).SetCellValue(Convert.ToString(row[column]));
                                else if (column.DataType == typeof(DateTime))
                                    dataRow.CreateCell(column.Ordinal).SetCellValue(Convert.ToDateTime(row[column]));
                                else if (column.DataType == typeof(double))
                                    dataRow.CreateCell(column.Ordinal).SetCellValue(Convert.ToDouble(row[column]));
                                else
                                    dataRow.CreateCell(column.Ordinal).SetCellValue(Convert.ToString(row[column]));
                            }
                        }
                    }
                }

                //Write the Workbook to a memory stream
                MemoryStream output = new MemoryStream();
                workbook.Write(output);

                FileStream file = new FileStream("C:\\Users\\rahulgupta\\Desktop\\excel.xls", FileMode.Create, FileAccess.Write);
                output.WriteTo(file);

                output.Close();
                file.Close();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            BindGrid();
        }
        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value.ToString());
                GridViewRow row = (GridViewRow)GridView1.Rows[e.RowIndex];
                TextBox textActual = (TextBox)row.Cells[1].FindControl("txtACTUAL");
                TextBox textYear1 = (TextBox)row.Cells[2].FindControl("txtyear1");
                TextBox textYear2 = (TextBox)row.Cells[3].FindControl("txtyear2");
                TextBox textYear3 = (TextBox)row.Cells[4].FindControl("txtyear3");
                TextBox textYear4 = (TextBox)row.Cells[5].FindControl("txtyear4");
                TextBox textYear5 = (TextBox)row.Cells[6].FindControl("txtyear5");
                ReportDB _db = new ReportDB();
                _db.UpdateReportData(id, GetDecimalValue(textActual.Text), GetDecimalValue(textYear1.Text), GetDecimalValue(textYear2.Text), GetDecimalValue(textYear3.Text), GetDecimalValue(textYear4.Text), GetDecimalValue(textYear5.Text));
                GridView1.EditIndex = -1;
                BindGrid();
            }
            catch (Exception ex)
            {
                throw new ApplicationException("GridView1_RowUpdating", ex);
            }
        }

        private decimal? GetDecimalValue(string p)
        {
            try
            {
                if (!string.IsNullOrEmpty(p))
                    return Convert.ToDecimal(p) * unit;
            }
            catch
            {
            }
            return null;
        }



        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            BindGrid();
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (strRole == "E")
                {
                    DataRowView row = (DataRowView)e.Row.DataItem;
                    if (e.Row.RowIndex == 1)
                    {
                        ImageButton btn = (ImageButton)e.Row.Cells[7].Controls[0];
                        btn.Visible = false;
                    }
                    if (e.Row.RowIndex == 0)
                    {
                        ImageButton btn = (ImageButton)e.Row.Cells[7].Controls[0];
                        btn.Visible = false;
                    }
                    if (e.Row.RowIndex == row.DataView.Count - 1)
                    {
                        ImageButton btn = (ImageButton)e.Row.Cells[7].Controls[0];
                        btn.Visible = false;
                    }
                }
            }
        }
    }
}