USE `planner`;



UPDATE			snpBudgetAverageMonthly
INNER JOIN	(
							SELECT 		snpBudgetAverageMonthly.KeyID 	AS KeyID
												,MD5(CONCAT(
													snpBudgetAverageMonthly.BudgetAverageMonthlyID 					
													,snpBudgetAverageMonthly.IncomeActual 								
													,snpBudgetAverageMonthly.IncomeAverage 								
													,snpBudgetAverageMonthly.ExpenseActual 								
													,snpBudgetAverageMonthly.ExpenseAverage 							
													,snpBudgetAverageMonthly.TotalIncomeVsExpenseActual 		
													,snpBudgetAverageMonthly.TotalIncomeVsExpenseAverage	
												))	AS SnapshotHash 
							FROM 		snpBudgetAverageMonthly snpBudgetAverageMonthly	
						) RS
SET					snpBudgetAverageMonthly.SnapshotHash = RS.SnapshotHash
WHERE 			snpBudgetAverageMonthly.KeyID = RS.KeyID
; 



select * from snpBudgetAverageMonthly;