	####################
	### Dataiku Test ###
	####################

#US Census dataset analysis#
#Author: Miguel Angel Ortiz#

#Script to do value imputations

#Uses the missForest implementation to impute missing values
#Warning: this proces takes considerable time to complete
ImputeValues <- function()
{
	dsTestImp <- missForest(dsTest)
	dsLearnImp <- missForest(dsLearn)
}

