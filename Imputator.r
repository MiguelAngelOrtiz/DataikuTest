	####################
	### Dataiku Test ###
	####################

#US Census dataset analysis#
#Author: Miguel Angel Ortiz#

#Script to do value imputations

ImputeValues <- function()
{
	dsTestImp <- missForest(dsTest)
	dsLearnImp <- missForest(dsLearn)
}

