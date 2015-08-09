USE [COMSOFT_AAI]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateReportData]    Script Date: 08/10/2015 02:32:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_UpdateReportData]
(
 @Id int
,@Actual decimal
,@Year1  decimal
,@Year2  decimal
,@Year3  decimal
,@Year4  decimal
,@Year5  decimal

)
as
begin
		Update tariff_expenditure_revenue_file 
			set	Actual_Year=@Actual,
				First_Year=@Year1,
				Second_Year=@Year2,
				Third_Year=@Year3,
				Fourth_Year=@Year4,	
				Fifth_Year=@Year5
where Id=@Id

end
GO
/****** Object:  StoredProcedure [dbo].[sp_GetReportDataForExcel]    Script Date: 08/10/2015 02:32:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetReportDataForExcel]
(
	@ProfitCenter INT
	,@BlockYear INT
	,@Unit INT
)
AS
BEGIN

	
	SELECT DISTINCT	Head_tariff_Name AS PARTICULAR
	,MainHead_tariff_Name 
	,ACTUAL_YEAR/@Unit AS [ACTUAL]  
	,FIRST_YEAR/@Unit AS [TARRIF YEAR 1]  
	,SECOND_YEAR/@Unit AS [TARRIF YEAR 2]  
	,THIRD_YEAR/@Unit AS [TARRIF YEAR 3]  
	,FOURTH_YEAR/@Unit AS [TARRIF YEAR 4]  
	,FIFTH_YEAR/@Unit AS [TARRIF YEAR 5]  
	FROM	tariff_expenditure_revenue_file T
	WHERE	ProfitCenter = @ProfitCenter  AND Block_Year = @BlockYear
	ORDER by [Tarrif year 1]
	
	
	SELECT	Projection_Year FROM BlockYearMaster 
	WHERE	Block_Year = @BlockYear

END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetReportDataForEach]    Script Date: 08/10/2015 02:32:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetReportDataForEach]  
(  
 @ProfitCenter INT  
 ,@TarrifFormName varchar(10)  
 ,@BlockYear INT  
 ,@Unit INT  
)  
AS  
BEGIN  
  
   
	SELECT DISTINCT Head_tariff_Name as PARTICULAR  
		,ACTUAL_YEAR/@Unit AS [ACTUAL]    
		,FIRST_YEAR/@Unit AS [TARRIF YEAR 1]    
		,SECOND_YEAR/@Unit AS [TARRIF YEAR 2]    
		,THIRD_YEAR/@Unit AS [TARRIF YEAR 3]    
		,FOURTH_YEAR/@Unit AS [TARRIF YEAR 4]    
		,FIFTH_YEAR/@Unit AS [TARRIF YEAR 5]    
		,MainHead_tariff_Name 
	FROM tariff_expenditure_revenue_file T  
	WHERE ProfitCenter = @ProfitCenter  AND tariff_form_name = @TarrifFormName AND Block_Year = @BlockYear  
	ORDER by [Tarrif year 1]  
   
	SELECT Projection_Year FROM BlockYearMaster   
	WHERE Block_Year = @BlockYear  
  
	SELECT Tariff_form_header FROM Tariff_form_header_master   
	WHERE Tariff_form_name = @TarrifFormName
  
	SELECT DISTINCT MainHead_tariff_Name   
		,SUM(ACTUAL_YEAR/@Unit) AS [ACTUAL]    
		,SUM(FIRST_YEAR/@Unit) AS [TARRIF YEAR 1]    
		,SUM(SECOND_YEAR/@Unit) AS [TARRIF YEAR 2]    
		,SUM(THIRD_YEAR/@Unit) AS [TARRIF YEAR 3]    
		,SUM(FOURTH_YEAR/@Unit) AS [TARRIF YEAR 4]    
		,SUM(FIFTH_YEAR/@Unit) AS [TARRIF YEAR 5]    
	FROM tariff_expenditure_revenue_file T  
	WHERE ProfitCenter = @ProfitCenter  AND tariff_form_name = @TarrifFormName AND Block_Year = @BlockYear  
	group by MainHead_tariff_Name
	 
  
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetReportData]    Script Date: 08/10/2015 02:32:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetReportData]  
(  
 @ProfitCenter INT  
 ,@TarrifFormName varchar(10)  
 ,@BlockYear INT  
 ,@Unit INT  
)  
AS  
BEGIN  
  
 SELECT DISTINCT NULL as PARTICULAR  
 ,NULL as Id 
 ,NULL AS [ACTUAL]    
 ,NULL AS [TARRIF YEAR 1]    
 ,NULL AS [TARRIF YEAR 2]    
 ,NULL AS [TARRIF YEAR 3]    
 ,NULL AS [TARRIF YEAR 4]    
 ,NULL AS [TARRIF YEAR 5]    
 FROM tariff_expenditure_revenue_file  
 WHERE ProfitCenter = @ProfitCenter  AND tariff_form_name = @TarrifFormName AND Block_Year = @BlockYear  
   
 UNION  
  
 SELECT DISTINCT MainHead_tariff_Name  as PARTICULAR  
 ,NULL as Id 
 ,NULL AS [ACTUAL]    
 ,NULL AS [TARRIF YEAR 1]    
 ,NULL AS [TARRIF YEAR 2]    
 ,NULL AS [TARRIF YEAR 3]    
 ,NULL AS [TARRIF YEAR 4]    
 ,NULL AS [TARRIF YEAR 5]    
 FROM tariff_expenditure_revenue_file  
 WHERE ProfitCenter = @ProfitCenter  AND tariff_form_name = @TarrifFormName AND Block_Year = @BlockYear  
   
 UNION  
   
 SELECT DISTINCT 'Total Staff Cost' as PARTICULAR  
 ,NULL as Id 
 ,SUM(ACTUAL_YEAR/@Unit) AS [ACTUAL]    
 ,SUM(FIRST_YEAR/@Unit) AS [TARRIF YEAR 1]    
 ,SUM(SECOND_YEAR/@Unit) AS [TARRIF YEAR 2]    
 ,SUM(THIRD_YEAR/@Unit) AS [TARRIF YEAR 3]    
 ,SUM(FOURTH_YEAR/@Unit) AS [TARRIF YEAR 4]    
 ,SUM(FIFTH_YEAR/@Unit) AS [TARRIF YEAR 5]    
 FROM tariff_expenditure_revenue_file T  
 WHERE ProfitCenter = @ProfitCenter  AND tariff_form_name = @TarrifFormName AND Block_Year = @BlockYear  
   
 UNION  
   
 SELECT DISTINCT Head_tariff_Name as PARTICULAR  
 ,Id 
 ,ACTUAL_YEAR/@Unit AS [ACTUAL]    
 ,FIRST_YEAR/@Unit AS [TARRIF YEAR 1]    
 ,SECOND_YEAR/@Unit AS [TARRIF YEAR 2]    
 ,THIRD_YEAR/@Unit AS [TARRIF YEAR 3]    
 ,FOURTH_YEAR/@Unit AS [TARRIF YEAR 4]    
 ,FIFTH_YEAR/@Unit AS [TARRIF YEAR 5]    
 FROM tariff_expenditure_revenue_file T  
 WHERE ProfitCenter = @ProfitCenter  AND tariff_form_name = @TarrifFormName AND Block_Year = @BlockYear  
 ORDER by [Tarrif year 1]  
   
   
   
   
   
 SELECT Projection_Year FROM BlockYearMaster   
 WHERE Block_Year = @BlockYear  
  
  SELECT Tariff_form_header FROM Tariff_form_header_master   
  WHERE Tariff_form_name = @TarrifFormName
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetProfitCenter]    Script Date: 08/10/2015 02:32:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		rahul Gupta
-- Create date: 26/07/2015
-- Description:	Genate menu bar based on profit center code
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetProfitCenter]

AS
BEGIN
	select distinct ProfitCenter, ProfitCenterName from ProfitCenterMaster order by ProfitCenterName asc
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetMenuItemByProfitCenter]    Script Date: 08/10/2015 02:32:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		rahul Gupta
-- Create date: 26/07/2015
-- Description:	Genate menu bar based on profit center code
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetMenuItemByProfitCenter]
@ProfitCenter int
AS
BEGIN
	select distinct tariff_form_name from tariff_expenditure_revenue_file 
						where ProfitCenter= @ProfitCenter order by tariff_form_name
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetExpenseData]    Script Date: 08/10/2015 02:32:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetExpenseData]  
(  
 @ProfitCenter INT  
 ,@TarrifFormName varchar(10)  
 ,@BlockYear INT  
 ,@Unit INT  
)  
AS  
BEGIN  
  
	 SELECT	id
			,MainHead_tariff_Name
			,Head_tariff_Name
			,Actual_Year/@Unit	AS Actual_Year
			,First_Year/@Unit	AS	First_Year
			,Second_Year/@Unit	AS	Second_Year
			,Third_Year/@Unit	AS	Third_Year
			,Fourth_Year/@Unit	AS	Fourth_Year
			,Fifth_Year/@Unit	AS	Fifth_Year
	FROM	tariff_expenditure_revenue_file 
	WHERE profitcenter=@ProfitCenter AND tariff_form_name=@TarrifFormName AND Block_Year = @BlockYear
 
	SELECT Projection_Year FROM BlockYearMaster   
	WHERE Block_Year = @BlockYear  
  
	SELECT Tariff_form_header FROM Tariff_form_header_master   
	WHERE Tariff_form_name = @TarrifFormName
 

END
GO
