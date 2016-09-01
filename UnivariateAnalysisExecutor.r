	####################
	### Dataiku Test ###
	####################

#US Census dataset analysis#
#Author: Miguel Angel Ortiz#

#Script to execute the univariate descriptive analysis

#Governs the execution of the Univariate Analysis
ExecuteUnivariateAnalysis <- function()
{
	DescriveDataset(dsLearn)
	DescriveEachVariable(dsLearn)
	ShowCorrelationMatrix(dsLearn)
}