using System;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using ProfitCenterReport.Datalayer;

namespace ProfitCenterReport
{
    public class ReportDB
    {
        private string connectionString;

        public ReportDB()
        {
            connectionString = WebConfigurationManager.ConnectionStrings["ComsoftAAIConnection"].ConnectionString;
        }
        public ReportDB(string connectionString)
        {
            this.connectionString = connectionString;
        }

        //public int InsertEmployee(EmployeeDetails emp)
        //{
        //  SqlConnection con = new SqlConnection(connectionString);
        //  SqlCommand cmd = new SqlCommand("InsertEmployee", con);
        //  cmd.CommandType = CommandType.StoredProcedure;

        //  cmd.Parameters.Add(new SqlParameter("@FirstName", SqlDbType.NVarChar, 10));
        //  cmd.Parameters["@FirstName"].Value = emp.FirstName;
        //  cmd.Parameters.Add(new SqlParameter("@LastName", SqlDbType.NVarChar, 20));
        //  cmd.Parameters["@LastName"].Value = emp.LastName;
        //  cmd.Parameters.Add(new SqlParameter("@TitleOfCourtesy", SqlDbType.NVarChar, 25));
        //  cmd.Parameters["@TitleOfCourtesy"].Value = emp.TitleOfCourtesy;
        //  cmd.Parameters.Add(new SqlParameter("@EmployeeID", SqlDbType.Int, 4));
        //  cmd.Parameters["@EmployeeID"].Direction = ParameterDirection.Output;

        //  try 
        //  {
        //    con.Open();
        //    cmd.ExecuteNonQuery();
        //    return (int)cmd.Parameters["@EmployeeID"].Value;
        //  }
        //  catch (SqlException err) 
        //  {
        //    throw new ApplicationException("Data error.");
        //  }
        //  finally 
        //  {
        //    con.Close();      
        //  }
        //}


        //public void UpdateEmployee(EmployeeDetails emp)
        //{
        //  SqlConnection con = new SqlConnection(connectionString);
        //  SqlCommand cmd = new SqlCommand("UpdateEmployee", con);
        //  cmd.CommandType = CommandType.StoredProcedure;

        //  cmd.Parameters.Add(new SqlParameter("@FirstName", SqlDbType.NVarChar, 10));
        //  cmd.Parameters["@FirstName"].Value = emp.FirstName;
        //  cmd.Parameters.Add(new SqlParameter("@LastName", SqlDbType.NVarChar, 20));
        //  cmd.Parameters["@LastName"].Value = emp.LastName;
        //  cmd.Parameters.Add(new SqlParameter("@TitleOfCourtesy", SqlDbType.NVarChar, 25));
        //  cmd.Parameters["@TitleOfCourtesy"].Value = emp.TitleOfCourtesy;
        //  cmd.Parameters.Add(new SqlParameter("@EmployeeID", SqlDbType.Int, 4));
        //  cmd.Parameters["@EmployeeID"].Value = emp.EmployeeID;

        //  try
        //  {
        //    con.Open();
        //    cmd.ExecuteNonQuery();
        //  }
        //  catch (SqlException err)
        //  {
        //    throw new ApplicationException("Data error.");
        //  }
        //  finally
        //  {
        //    con.Close();
        //  }
        //}



        //public DataSet GetEmployee(int employeeID)
        //{
        //    SqlConnection con = new SqlConnection(connectionString);
        //    SqlCommand cmd = new SqlCommand("GetEmployee", con);
        //    cmd.CommandType = CommandType.StoredProcedure;

        //    cmd.Parameters.Add(new SqlParameter("@EmployeeID", SqlDbType.Int, 4));
        //    cmd.Parameters["@EmployeeID"].Value = employeeID;

        //    try
        //    {
        //        con.Open();
        //        SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.SingleRow);

        //        reader.Read();
        //        EmployeeDetails emp = new EmployeeDetails(
        //          (int)reader["EmployeeID"], (string)reader["FirstName"],
        //          (string)reader["LastName"], (string)reader["TitleOfCourtesy"]);
        //        reader.Close();
        //        return emp;
        //    }
        //    catch (SqlException err)
        //    {
        //        throw new ApplicationException("Data error.");
        //    }
        //    finally
        //    {
        //        con.Close();
        //    }
        //}

        public DataTable GetProfitCenter()
        {
            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand("SP_GetProfitCenter", con);
            cmd.CommandType = CommandType.StoredProcedure;
            DataTable dt = new DataTable();
            try
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                return dt;
            }
            catch (SqlException err)
            {
                throw new ApplicationException("Data error.");
            }
            finally
            {
                con.Close();
            }
        }

        public DataTable GetMenuItem(int profitCenter)
        {
            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand("SP_GetMenuItemByProfitCenter", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@ProfitCenter", SqlDbType.Int, 4));
            cmd.Parameters["@ProfitCenter"].Value = profitCenter;
            DataTable dt = new DataTable();
            try
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                return dt;
            }
            catch (SqlException err)
            {
                throw new ApplicationException("Data error.");
            }
            finally
            {
                con.Close();
            }
        }

        public DataSet GetReportData(int profitCenter, string tarrifFormName, int blockYear, int unit)
        {
            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand("sp_GetReportData", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@ProfitCenter", SqlDbType.Int, 4));
            cmd.Parameters.Add(new SqlParameter("@TarrifFormName", SqlDbType.VarChar, 10));
            cmd.Parameters.Add(new SqlParameter("@BlockYear", SqlDbType.Int, 10));
            cmd.Parameters.Add(new SqlParameter("@Unit", SqlDbType.Int, 10));
            cmd.Parameters["@ProfitCenter"].Value = profitCenter;
            cmd.Parameters["@TarrifFormName"].Value = tarrifFormName;
            cmd.Parameters["@BlockYear"].Value = blockYear;
            cmd.Parameters["@Unit"].Value = unit;

            DataSet ds = new DataSet();
            try
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                return ds;
            }
            catch (SqlException err)
            {
                throw new ApplicationException("Data error.");
            }
            finally
            {
                con.Close();
            }
        }

        public DataSet GetReportDataForExcel(int profitCenter, int blockYear, int unit)
        {
            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand("sp_GetReportDataForExcel", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@ProfitCenter", SqlDbType.Int, 4));
            cmd.Parameters.Add(new SqlParameter("@BlockYear", SqlDbType.Int, 10));
            cmd.Parameters.Add(new SqlParameter("@Unit", SqlDbType.Int, 10));
            cmd.Parameters["@ProfitCenter"].Value = profitCenter;
            cmd.Parameters["@BlockYear"].Value = blockYear;
            cmd.Parameters["@Unit"].Value = unit;

            DataSet ds = new DataSet();
            try
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                return ds;
            }
            catch (SqlException err)
            {
                throw new ApplicationException("Data error.");
            }
            finally
            {
                con.Close();
            }
        }

        public int UpdateReportData(int id, decimal? actual, decimal? F1, decimal? F2, decimal? F3, decimal? F4, decimal? F5)
        {
            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand("sp_UpdateReportData", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int)).Value = id;
            if (actual != null)
                cmd.Parameters.Add(new SqlParameter("@Actual", SqlDbType.Decimal)).Value = actual;
            else
                cmd.Parameters.Add(new SqlParameter("@Actual", SqlDbType.Decimal)).Value = DBNull.Value;
            cmd.Parameters.Add(new SqlParameter("@Year1", SqlDbType.Decimal)).Value = F1;
            cmd.Parameters.Add(new SqlParameter("@Year2", SqlDbType.Decimal)).Value = F2;
            cmd.Parameters.Add(new SqlParameter("@Year3", SqlDbType.Decimal)).Value = F3;
            cmd.Parameters.Add(new SqlParameter("@Year4", SqlDbType.Decimal)).Value = F4;
            cmd.Parameters.Add(new SqlParameter("@Year5", SqlDbType.Decimal)).Value = F5;
            try
            {
                con.Open();
                return cmd.ExecuteNonQuery();
            }

            catch (SqlException err)
            {
                throw new ApplicationException("Data error.");
            }
            finally
            {
                con.Close();
            }
        }

    }
}
