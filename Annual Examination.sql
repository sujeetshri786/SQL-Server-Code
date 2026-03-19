/*Annual Examination Purpose*/

Examinelist (table) stores all the eligible Examinelist
PaperData (table) stores all the eligible Examinelist who have downloaded their paper
finalanswer (table) stores all the eligible Examinelist who have downloaded their paper and Submitted their final Answer

Select * from Examinelist where [Exam Date]='17th April 2022' And EMPID ='7098'
Select * from Examinelist where EMPID   not in(Select Staffid from paperdata ) and [Exam Date]='17th April 2022'
Select * from Examinelist where EMPID not  in(Select Staffid from finalanswer ) and [Exam Date]='17th April 2022'

Select distinct a.*,
case when b.Staffid is not null then 'PaperDownloaded' else 'AppNotDownloaded' end as Paper_Downloading_Status, 
case when c.Staffid is not null then 'PaperSubmittedSuccessfully' else  'PaperNotSubmittedSuccessfully' end as Final_Submission_Status 
from Examinelist a
left join paperdata b on a.EMPID=b.Staffid
left join finalanswer c on a.EMPID=c.Staffid
Where [Exam Date]='17th April 2022' And Region like '%Siwan%' And EMPID = '19153'

/*Annual Examination Purpose*/
Sitamadi
