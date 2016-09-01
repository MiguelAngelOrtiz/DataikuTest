	####################
	### Dataiku Test ###
	####################

#US Census dataset analysis#
#Author: Miguel Angel Ortiz#

#Script to load all needed libraries, create required objects, and load the required data

Init <- function()
{
	LoadAllLibraries()
	CreateObjects()
	LoadRequiredData()
}

LoadAllLibraries <- function()
{
	cat("Loading all needed libraries...\n")
	LoadLibrary("hexbin")
	LoadLibrary("corrgram")
	LoadLibrary("missForest")
	cat("Done\n\n")
}

LoadLibrary <- function(sLibName)
{
	if(isTRUE(library(sLibName, logical.return=TRUE, quietly = TRUE, character.only=TRUE)))
	{
		cat(sLibName, " library loaded successfuly\n")
	}
	else
	{
		cat("The library ", sLibName, " is not installed, proceeding to download it\n")
		install.packages(sLibName)
		library(sLibName, logical.return=TRUE, quietly = TRUE, character.only=TRUE)
	}
}
CreateObjects <- function()
{
	cat("Creating objects...\n")
	source("Tools.r")
	source("LoadData.r")
	source("UnivariateAnalysisExecutor.r")
	source("UnivariateAnalysis.r")
	source("Imputator.r")
	source("PCAModel.r")
	source("DiscriminantAnalysis.r")
	cat("Done\n\n")
}

LoadRequiredData <- function()
{
	cat("Loading all required datasets, this might take some time...\n")
	LoadAllDatasets()
	cat("Done\n\n")
}