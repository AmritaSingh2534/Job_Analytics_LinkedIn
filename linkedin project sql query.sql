create database pro;
use pro;
select * from [dbo].[company]
select * from [dbo].[details]
select * from [dbo].[jobs1]

----joining all the tables as one
select [dbo].[jobs1].[company_id], [dbo].[jobs1].[details_id],[dbo].[jobs1].[job_id],
[dbo].[company].[company_name],[dbo].[jobs1].[title],[dbo].[company].[industry],
[dbo].[details].[level],[dbo].[details].[involvement],[dbo].[details].[total_applicants],
[dbo].[jobs1].[City],[dbo].[jobs1].[State],[dbo].[jobs1].[Country]
 from [dbo].[jobs1] left join [dbo].[company] 
 on [dbo].[jobs1].[company_id]=[dbo].[company].[company_id]
 left join [dbo].[details] on [dbo].[jobs1].[details_id]=[dbo].[details].[details_id];

---industry wise job count
select [dbo].[company].[industry], count([dbo].[jobs1].[job_id]) as Number_of_jobs 
from [dbo].[jobs1] inner join [dbo].[company] 
on [dbo].[jobs1].[company_id]=[dbo].[company].[company_id] group by [dbo].[company].[industry];

---Comparison of number of jobs across different cities for different level
select [dbo].[jobs1].[City], count([dbo].[jobs1].[company_id]) 
as Number_of_jobs from [dbo].[jobs1] left join [dbo].[details] 
on [dbo].[jobs1].[details_id]=[dbo].[details].[details_id] group by [dbo].[jobs1].[City];

---creating pivot of the same job across cities
select[dbo].[jobs1].[job_id] ,[dbo].[jobs1].[State],[dbo].[details].[level] from [dbo].[jobs1] 
left join [dbo].[details] on [dbo].[jobs1].[details_id]=[dbo].[details].[details_id];

create view  level_count_state as 
select[dbo].[jobs1].[job_id] ,[dbo].[jobs1].[State],[dbo].[details].[level] from [dbo].[jobs1] 
left join [dbo].[details] on [dbo].[jobs1].[details_id]=[dbo].[details].[details_id];

select * from level_count_state

select * from level_count_state pivot (count([job_id])for [level]  
in ([Associate],[Director],[Entry level],[Executive],[Internship],[Mid-Senior level],[Not Applicable])) as pvttable;

----industry level involvement;
select [dbo].[jobs1].[details_id],[dbo].[company].[industry],[dbo].[details].[level] from [dbo].[jobs1] 
left join [dbo].[company]  on [dbo].[jobs1].[company_id]=[dbo].[company].[company_id]
left join [dbo].[details] on [dbo].[jobs1].[details_id]=[dbo].[details].[details_id];

---pivot table of same industry level involvement
create view  industry_level_invovement as
select [dbo].[jobs1].[details_id],[dbo].[company].[industry],[dbo].[details].[level] from [dbo].[jobs1] 
left join [dbo].[company]  on [dbo].[jobs1].[company_id]=[dbo].[company].[company_id]
left join [dbo].[details] on [dbo].[jobs1].[details_id]=[dbo].[details].[details_id];

select * from industry_level_invovement pivot(count(details_id) for [level]  
in ([Associate],[Director],[Entry level],[Executive],[Internship],[Mid-Senior level],[Not Applicable])) as pvttable;



