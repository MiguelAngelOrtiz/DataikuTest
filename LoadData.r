	####################
	### Dataiku Test ###
	####################

#US Census dataset analysis#
#Author: Miguel Angel Ortiz#

#Script to load the datasets into the workspace
#Call the LoadAllDatasets function to read the datasets available in the Working Directory


#Global Variables Definition
sLearnDatasetFullName 		<<- "census_income_learn.csv"
sLearnDatasetImpFullName 	<<- "census_income_learn_imp.csv"
sTestDataSetFullName  		<<- "census_income_test.csv"
sTestDataSetImpFullName		<<- "census_income_test_imp.csv"

#LoadAllDatasets function
#Sets the Working Directory and then loads the datasets
LoadAllDatasets <- function()
{
	if(SetWorkingDirectory())
	{
		dsLearn <<- LoadDataSet(sLearnDatasetFullName)
		if(!is.null(dsLearn))
		{
			dsTest <<- LoadDataSet(sTestDataSetFullName)
			if(!is.null(dsTest))
			{
				dsLearnImp <<- LoadDataSet(sLearnDatasetImpFullName)
				if(!is.null(dsLearnImp))
				{
					dsTestImp <<- LoadDataSet(sTestDataSetImpFullName)
					if(!is.null(dsTestImp))
					{
						cat("All datasets loaded successfuly\n")
					}
					else
					{
						cat("Error loading ", sTestDataSetImpFullName, "\n")
					}
				}
				else
				{
					cat("Error loading ", sLearnDatasetImpFullName, "\n")
				}
			}
			else
			{
				cat("Error loading ", sTestDataSetFullName, "\n")
			}
		}
		else
		{
			cat("Error loading ", sLearnDatasetFullName, "\n")
		}
	}
}

#SetWorkingDirectory function
#Allows the user to set a new Working Directory
SetWorkingDirectory <- function()
{
	inRetVal <- 0
	
	cat("\nThe scripts are going to be uploaded from:", getwd(), "\n")
	sAns <- readline("Would you like to change this path? y/n\n")
	
	if(substr(sAns, 1, 1) == "Y" || substr(sAns, 1, 1) =="y")
	{
		#sAns = readline("Enter the new path (use double \\ or single / to separate folders)\n\n")
		#setwd(sAns)
		setwd(choose.dir())
		if(!is.null(getwd()))
		{
			inRetVal = 1
		}
	}
	else
	{
		if(substr(sAns, 1, 1) == "N" || substr(sAns, 1, 1) =="n")
		{
			cat("The current Working Directory will be used\n")
			inRetVal = 1
		}
		else
		{
			cat("invalid answer, pleas try again\n")
			inRetVal = 0
		}
	}
	
	return (inRetVal)
}

#LoadDataSet function
#Reads a CSV file
LoadDataSet <- function(sDataSetName)
{	
	dsRetVal <- read.csv(	sDataSetName, 
							header = TRUE, 
							na.strings = " ?" 
						)
}
