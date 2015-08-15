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
using System.Web.Configuration;
using System.Data.SqlClient;
using System.Globalization;
using System.Threading;

namespace ProfitCenterReport
{
    public partial class Report : System.Web.UI.Page
    {
        static int pcId = 0;
        static int unit = 1;
        static string strRsType = string.Empty;
        static string tfName = string.Empty;
        static string strRole = string.Empty;
        static string headerContent = string.Empty;
        string strPreviousRowID = string.Empty;
        // To keep track the Index of Group Total    
        int intSubTotalIndex = 1;
        // To temporarily store Sub Total    
        double dblSubTotalFstYear = 0;
        double dblSubTotalSndYear = 0;
        double dblSubTotalThdYear = 0;
        double dblSubTotalFothYear = 0;
        double dblSubTotalFifthYear = 0;
        // To temporarily store Grand Total    

        double dblGrandTotalFstYear = 0;
        double dblGrandTotalSndYear = 0;
        double dblGrandTotalThdYear = 0;
        double dblGrandTotalFothYear = 0;
        double dblGrandTotalFifthYear = 0;




        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (string.IsNullOrEmpty(Request.QueryString["link"]))
                    Session["menuContent"] = null;
                if (!string.IsNullOrEmpty(Request.QueryString["centerid"]))
                {
                    pcId = Convert.ToInt32(Request.QueryString["centerid"]);
                    strRole = Request.QueryString["role"];
                    strRsType = Request.QueryString["unit"].ToUpper();
                    BindMenuItem(pcId);

                    if (Session["centername"] != null)
                        headerContent = string.Format(ConfigurationManager.AppSettings["headerContent"], Convert.ToString(Session["centername"]).ToUpper());
                    lblCntName.Text = headerContent;

                    if (!string.IsNullOrEmpty(Request.QueryString["tfName"]))
                    {
                        btnReport.Visible = true;
                        tfName = Request.QueryString["tfName"].ToString();
                        lblFormName.Text = string.Format(ConfigurationManager.AppSettings["formName"], tfName.ToUpper());

                        if (!string.IsNullOrEmpty(Request.QueryString["unit"]) && Request.QueryString["unit"].ToUpper() == "C")
                        {

                            unit = 10000000;
                            lblRuppes.Text = "In Crores";
                        }
                        else
                            unit = 100000;

                        BindGrid();
                        trExport.Visible = true;
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
                DataSet dt = _db.GetExpenseData(pcId, tfName, Convert.ToInt32(actualYear), unit);

                if (dt.Tables[2].Rows.Count > 0)
                    lblHeaderName.Text = Convert.ToString(dt.Tables[2].Rows[0][0]);
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
                        //GridView1.Rows[GridView1.Rows.Count - 1].Cells[0].Font.Bold = true;

                        //making total row bold
                        foreach (TableCell item in GridView1.Rows[GridView1.Rows.Count - 1].Cells)
                        {
                            //item.Font.Bold = true;
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
                    sb.Append("<li class='has-sub'><a href='" + string.Format("Report.aspx?centerid={0}&tfName={1}&unit={2}&role={3}&link=menu", profitCenter, dt.Rows[i][0].ToString(), strRsType, strRole) + "'><span>" + dt.Rows[i][0].ToString() + "</span></a></li>");
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
            string actualYear = ConfigurationManager.AppSettings["ActualYear"];

            ////Create new Excel Workbook
            var workbook = new HSSFWorkbook();

            CellStyle cellStyleBold = workbook.CreateCellStyle();
            Font boldFont = workbook.CreateFont();
            boldFont.Boldweight = (short)NPOI.SS.UserModel.FontBoldWeight.BOLD;
            cellStyleBold.SetFont(boldFont);
            foreach (DataRow item in formTable.Rows)
            {
                HSSFSheet sheet = (HSSFSheet)workbook.CreateSheet(item[0].ToString());


                //Getting reportData
                ds = new ReportDB().GetReportDataForExcel(pcId, item[0].ToString(), Convert.ToInt32(actualYear), unit);


                //setting width of cloumns in excel
                sheet.SetColumnWidth(0, 25 * 256);
                for (int i = 2; i < ds.Tables[0].Columns.Count; i++)
                {
                    sheet.SetColumnWidth(i, 15 * 256);
                }

                HSSFRow firstRow = (HSSFRow)sheet.CreateRow(0);
                firstRow.CreateCell(1).SetCellValue(headerContent);
                firstRow.GetCell(1).CellStyle = cellStyleBold;
                firstRow.GetCell(1).CellStyle.WrapText = true;
                //firstRow.GetCell(1).Row.Height = 800;
                NPOI.SS.Util.CellRangeAddress cra = new NPOI.SS.Util.CellRangeAddress(0, 0, 1, 5);
                sheet.AddMergedRegion(cra);

                HSSFRow thirdRow = (HSSFRow)sheet.CreateRow(2);
                thirdRow.CreateCell(0).SetCellValue(string.Format(ConfigurationManager.AppSettings["formName"], tfName.ToUpper()));
                thirdRow.GetCell(0).CellStyle = cellStyleBold;

                HSSFRow forthRow = (HSSFRow)sheet.CreateRow(3);
                if (ds.Tables[2].Rows.Count > 0)
                {
                    forthRow.CreateCell(0).SetCellValue(Convert.ToString(ds.Tables[2].Rows[0][0]));
                    forthRow.GetCell(0).CellStyle = cellStyleBold;
                }

                HSSFRow fifthRow = (HSSFRow)sheet.CreateRow(5);

                fifthRow.CreateCell(1).SetCellValue(GetActualYear(actualYear));
                for (int i = 2; i < ds.Tables[1].Rows.Count + 2; i++)
                {
                    var row = ds.Tables[1].Rows[i - 2];
                    fifthRow.CreateCell(i).SetCellValue(Convert.ToString(row[0]));
                }

                // handling value.
                int rowIndex = 6;

                HSSFRow sixthRow = (HSSFRow)sheet.CreateRow(rowIndex);
                for (int i = 0; i < ds.Tables[0].Columns.Count - 1; i++)
                {
                    sixthRow.CreateCell(i).SetCellValue(ds.Tables[0].Columns[i].ColumnName);
                    sixthRow.GetCell(i).CellStyle = cellStyleBold;
                }
                foreach (DataRow headerRow in ds.Tables[3].Rows)
                {
                    string filterExp = string.Format("MainHead_tariff_Name='{0}'", headerRow[0]);
                    HSSFRow subHeadRow = (HSSFRow)sheet.CreateRow(++rowIndex);
                    subHeadRow.CreateCell(0).SetCellValue(Convert.ToString(headerRow[0]));
                    subHeadRow.GetCell(0).CellStyle = cellStyleBold;

                    foreach (DataRow row in ds.Tables[0].Select(filterExp))
                    {
                        HSSFRow dataRow = (HSSFRow)sheet.CreateRow(++rowIndex);
                        foreach (DataColumn column in ds.Tables[0].Columns)
                        {
                            if (column.ColumnName == "MainHead_tariff_Name")
                                continue;
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

                    HSSFRow subTotalRow = (HSSFRow)sheet.CreateRow(++rowIndex);
                    subTotalRow.CreateCell(0).SetCellValue("Sub Total");
                    subTotalRow.GetCell(0).CellStyle = cellStyleBold;
                    foreach (DataColumn column in ds.Tables[0].Columns)
                    {

                    }
                    for (int i = 1; i < ds.Tables[0].Columns.Count - 1; i++)
                    {
                        if (headerRow[i] != DBNull.Value)
                        {
                            subTotalRow.CreateCell(i).SetCellValue(Convert.ToDouble(headerRow[i]));
                            subTotalRow.GetCell(i).CellStyle = cellStyleBold;
                        }
                    }
                    HSSFRow blankRow = (HSSFRow)sheet.CreateRow(++rowIndex);

                }
            }

            //Write the Workbook to a memory stream
            MemoryStream output = new MemoryStream();
            workbook.Write(output);

            //return File(output.ToArray(),   //The binary data of the XLS file
            //"application/vnd.ms-excel",//MIME type of Excel files
            //"ArticleList.xls");

            string fileName = "report.xls";
            const int bufferLength = 10000;
            byte[] buffer = new Byte[bufferLength];
            int length = 0;
            if (!string.IsNullOrEmpty(Convert.ToString(Session["centername"])))
            {
                fileName = Convert.ToString(Session["centername"]) + ".xls";
            }
            Response.ContentType = "Application/x-msexcel";
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName + "");
            Stream download = null;
            try
            {
                using (FileStream file = new FileStream(Server.MapPath("/Export/" + fileName + ""), FileMode.Create, FileAccess.Write))
                {
                    output.WriteTo(file);
                }

                download = new FileStream(Server.MapPath("/Export/" + fileName + ""),
                                                   FileMode.Open,
                                                   FileAccess.Read);
                do
                {
                    if (Response.IsClientConnected)
                    {
                        length = download.Read(buffer, 0, bufferLength);
                        Response.OutputStream.Write(buffer, 0, length);
                        buffer = new Byte[bufferLength];
                    }
                    else
                    {
                        length = -1;
                    }
                }
                while (length > 0);
                Response.Flush();
                Response.End();
            }
            finally
            {
                if (download != null)
                    download.Close();
            }
            BindGrid();
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
                boldFont.Boldweight = (short)NPOI.SS.UserModel.FontBoldWeight.BOLD;
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

        protected void GridView1_RowCreated(object sender, GridViewRowEventArgs e)
        {

            bool IsSubTotalRowNeedToAdd = false;
            bool IsGrandTotalRowNeedtoAdd = false;
            if ((strPreviousRowID != string.Empty) && (DataBinder.Eval(e.Row.DataItem, "MainHead_tariff_Name") != null))
                if (strPreviousRowID != DataBinder.Eval(e.Row.DataItem, "MainHead_tariff_Name").ToString())
                    IsSubTotalRowNeedToAdd = true;
            if ((strPreviousRowID != string.Empty) && (DataBinder.Eval(e.Row.DataItem, "MainHead_tariff_Name") == null))
            {
                IsSubTotalRowNeedToAdd = true;
                IsGrandTotalRowNeedtoAdd = true;
                intSubTotalIndex = 0;
            }
            #region Inserting first Row and populating fist Group Header details
            if ((strPreviousRowID == string.Empty) && (DataBinder.Eval(e.Row.DataItem, "MainHead_tariff_Name") != null))
            {
                GridView grdViewOrders = (GridView)sender;
                GridViewRow row = new GridViewRow(0, 0, DataControlRowType.DataRow, DataControlRowState.Insert);
                TableCell cell = new TableCell();
                cell.Text = DataBinder.Eval(e.Row.DataItem, "MainHead_tariff_Name").ToString();
                cell.ColumnSpan = 8;
                cell.CssClass = "GroupHeaderStyle";
                row.Cells.Add(cell);
                grdViewOrders.Controls[0].Controls.AddAt(e.Row.RowIndex + intSubTotalIndex, row);
                intSubTotalIndex++;
            }

            #endregion
            if (IsSubTotalRowNeedToAdd)
            {
                #region Adding Sub Total Row
                GridView GridView1 = (GridView)sender;
                // Creating a Row          
                GridViewRow row = new GridViewRow(0, 0, DataControlRowType.DataRow, DataControlRowState.Insert);
                //Adding Total Cell          
                TableCell cell = new TableCell();
                cell.Text = "Sub Total";
                cell.HorizontalAlign = HorizontalAlign.Left;
                cell.ColumnSpan = 2;
                cell.CssClass = "SubTotalRowStyle";
                row.Cells.Add(cell);
                //Adding Unit Price Column          
                cell = new TableCell();
                cell.Text = string.Format("{0:0.00}", dblSubTotalFstYear);
                cell.HorizontalAlign = HorizontalAlign.Right;
                cell.CssClass = "SubTotalRowStyle";
                row.Cells.Add(cell);
                //Adding Quantity Column            
                cell = new TableCell();
                cell.Text = string.Format("{0:0.00}", dblSubTotalSndYear);
                cell.HorizontalAlign = HorizontalAlign.Right;
                cell.CssClass = "SubTotalRowStyle";
                row.Cells.Add(cell);
                //Adding Discount Column         
                cell = new TableCell();
                cell.Text = string.Format("{0:0.00}", dblSubTotalThdYear);
                cell.HorizontalAlign = HorizontalAlign.Right;
                cell.CssClass = "SubTotalRowStyle";
                row.Cells.Add(cell);
                //Adding Amount Column         
                cell = new TableCell();
                cell.Text = string.Format("{0:0.00}", dblSubTotalFothYear);
                cell.HorizontalAlign = HorizontalAlign.Right;
                cell.CssClass = "SubTotalRowStyle"; row.Cells.Add(cell);
                cell = new TableCell();
                cell.Text = string.Format("{0:0.00}", dblSubTotalFifthYear);
                cell.HorizontalAlign = HorizontalAlign.Right;
                cell.CssClass = "SubTotalRowStyle"; row.Cells.Add(cell);

                //Adding the Row at the RowIndex position in the Grid      
                GridView1.Controls[0].Controls.AddAt(e.Row.RowIndex + intSubTotalIndex, row);
                intSubTotalIndex++;

                #endregion
                #region Adding Next Group Header Details
                if (DataBinder.Eval(e.Row.DataItem, "MainHead_tariff_Name") != null)
                {
                    row = new GridViewRow(0, 0, DataControlRowType.DataRow, DataControlRowState.Insert);
                    cell = new TableCell();
                    cell.Text = DataBinder.Eval(e.Row.DataItem, "MainHead_tariff_Name").ToString();
                    cell.ColumnSpan = 8;
                    cell.CssClass = "GroupHeaderStyle";
                    row.Cells.Add(cell);
                    GridView1.Controls[0].Controls.AddAt(e.Row.RowIndex + intSubTotalIndex, row);
                    intSubTotalIndex++;
                }
                #endregion
                #region Reseting the Sub Total Variables
                dblSubTotalFstYear = 0;
                dblSubTotalSndYear = 0;
                dblSubTotalThdYear = 0;
                dblSubTotalFothYear = 0;
                dblSubTotalFifthYear = 0;
                #endregion
            }
            if (IsGrandTotalRowNeedtoAdd)
            {
                #region Grand Total Row
                GridView grdViewOrders = (GridView)sender;
                // Creating a Row      
                GridViewRow row = new GridViewRow(0, 0, DataControlRowType.DataRow, DataControlRowState.Insert);
                //Adding Total Cell           
                TableCell cell = new TableCell();
                cell.Text = "Grand Total";
                cell.HorizontalAlign = HorizontalAlign.Left;
                cell.ColumnSpan = 2;
                cell.CssClass = "GrandTotalRowStyle";
                row.Cells.Add(cell);
                //Adding Unit Price Column          
                cell = new TableCell();
                cell.Text = string.Format("{0:0.00}", dblGrandTotalFstYear);
                cell.HorizontalAlign = HorizontalAlign.Right;
                cell.CssClass = "GrandTotalRowStyle";
                row.Cells.Add(cell);
                //Adding Quantity Column           
                cell = new TableCell();
                cell.Text = string.Format("{0:0.00}", dblGrandTotalSndYear);
                cell.HorizontalAlign = HorizontalAlign.Right;
                cell.CssClass = "GrandTotalRowStyle";
                row.Cells.Add(cell);
                //Adding Discount Column          
                cell = new TableCell();
                cell.Text = string.Format("{0:0.00}", dblGrandTotalThdYear);
                cell.HorizontalAlign = HorizontalAlign.Right;
                cell.CssClass = "GrandTotalRowStyle";
                row.Cells.Add(cell);
                //Adding Amount Column          
                cell = new TableCell();
                cell.Text = string.Format("{0:0.00}", dblGrandTotalFothYear);
                cell.HorizontalAlign = HorizontalAlign.Right;
                cell.CssClass = "GrandTotalRowStyle";
                row.Cells.Add(cell);
                cell = new TableCell();
                cell.Text = string.Format("{0:0.00}", dblGrandTotalFifthYear);
                cell.HorizontalAlign = HorizontalAlign.Right;
                cell.CssClass = "GrandTotalRowStyle";
                row.Cells.Add(cell);

                //Adding the Row at the RowIndex position in the Grid     
                grdViewOrders.Controls[0].Controls.AddAt(e.Row.RowIndex, row);
                #endregion
            }
        }
        /// <summary>    
        /// Event fires when data binds to each row   
        /// Used for calculating Group Total     
        /// </summary>   
        /// /// <param name="sender"></param>    
        /// <param name="e"></param>    

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                strPreviousRowID = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "MainHead_tariff_Name"));
                double dblFstYear = Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "First_Year"));
                double dblSndYear = Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "Second_Year"));
                double dblThdYear = Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "Third_Year"));
                double dblFothYear = Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "Fourth_Year"));
                double dblFiftYear = Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "Fifth_Year"));
                // Cumulating Sub Total 
                dblSubTotalFstYear += dblFstYear;
                dblSubTotalSndYear += dblSndYear;
                dblSubTotalThdYear += dblThdYear;
                dblSubTotalFothYear += dblFothYear;
                dblSubTotalFifthYear += dblFiftYear;

                // Cumulating Grand Total      
                dblGrandTotalFstYear += dblFstYear;
                dblGrandTotalSndYear += dblSndYear;
                dblGrandTotalThdYear += dblThdYear;
                dblGrandTotalFothYear += dblFothYear;
                dblGrandTotalFifthYear += dblFiftYear;
                // This is for cumulating the values  
                if (strRole == "E")
                {
                    e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#ddd'");
                    e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=''");
                    e.Row.Attributes.Add("style", "cursor:pointer;");
                    int a = e.Row.RowIndex + intSubTotalIndex;
                    e.Row.Attributes["onclick"] = "add(this);";

                }

            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                ReportDB _db = new ReportDB();
                _db.UpdateReportData(Convert.ToInt32(hidden.Value), GetDecimalValue(txt1.Text), GetDecimalValue(TextBox1.Text), GetDecimalValue(TextBox2.Text), GetDecimalValue(TextBox3.Text), GetDecimalValue(TextBox4.Text), GetDecimalValue(TextBox5.Text));
                BindGrid();
            }
        }



    }
}