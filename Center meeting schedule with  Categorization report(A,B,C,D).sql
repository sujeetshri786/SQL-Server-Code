						
			--drop table #RR			
						
			;with temp			
			as			
			(			
						
			select Center_ID,Classification_Flag	,Designation,	Entry_By,	cast(Entry_Date as date)Entry_Date
			 ,row_number() over(partition by Center_ID,Designation order by cast(Entry_Date as date) desc) Rownumner			
			  from  [43.242.214.235].appcashpor.dbo.center_classification k(nolock)	where Classification_Flag<>0	 and designation='BM'	
			) select * into #RR from temp t (nolock) where t.Rownumner=1			
						
						
						
			select a.*, (case when b.Classification_Flag=1 then 'A' when b.Classification_Flag=2 then 'B' when b.Classification_Flag=3 then 'C' 			
			when b.Classification_Flag=4 then 'D' else 'No Classification' end) Center_category, c.member,d.ALC			
			from			
			(			
			select b.zone,b.districtname,c.branchid, upper(b.branchname) AS BRANCH_NAME			
			,			
			c.centerid AS CENTER_ID,upper(c.centername) AS CENTERNAME,			
			Case When c.CENTERMEETINGDAY=1 Then 'MONDAY '			
			       When c.CENTERMEETINGDAY=2 Then 'TUESDAY '			
			       When c.CENTERMEETINGDAY=3 Then 'WEDNESDAY '			
			       When c.CENTERMEETINGDAY=4 Then 'THURSDAY  '			
			       When c.CENTERMEETINGDAY=5 Then 'FRIDAY  '			
			       When c.CENTERMEETINGDAY=6 Then 'SATURDAY ' End as MeetingDay			
			,c.CenterMeetingTime			
						
			from centers as c			
			inner join Branches as b  on  c.branchid=b.branchid 			
			where c.DissolvedDate is NULL 	 and c.CenterID not in('15:05:14','32:15:68','32:16:55','32:16:57','32:17:86','38:09:77','38:12:34','38:12:41','32:17:54','32:17:55','32:17:57')		
						
			) A left join 			
			(			
			select center_ID,Classification_Flag  from #RR r(nolock) where designation='BM'			
			) b on A.CENTER_ID=b.center_ID 	left join		
			(			
				select Centerid,count(clientid) member from clients c (nolock) where DropOutStatus=0 group by Centerid		
			) c on c.CenterID=a.CENTER_ID left join			
						
			(			
				select centerid,count(distinct(clientid)) ALC from ClientLoanSubscription c (nolock) where ActualPaidUpDate is null and PrincipalOutstanding>0		
				group by centerid		
			) d on d.CenterID=a.CENTER_ID			
			order by a.CENTER_ID			
						
						
--select * from [43.242.214.235].appcashpor.dbo.centers c (nolock) inner join centers cs (nolock) on c.centerid=cs.CenterID						
--where c.dissolveddate is null and c.CenterMeetingTime<>cs.CenterMeetingTime						
						
						
						
--update cs set cs.CenterMeetingTime=c.CenterMeetingTime from [43.242.214.235].appcashpor.dbo.centers c (nolock) inner join centers cs (nolock) on c.centerid=cs.CenterID						
--where c.dissolveddate is null and c.CenterMeetingTime<>cs.CenterMeetingTime						
