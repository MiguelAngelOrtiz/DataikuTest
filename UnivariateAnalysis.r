	####################
	### Dataiku Test ###
	####################

#US Census dataset analysis#
#Author: Miguel Angel Ortiz#

#Script to do a descriptive analysis of the dataset

#Descrives globally the complete dataset
DescriveDataset <- function(Dataset)
{
	ClearConsole()
	GetStructureOfDataset(Dataset)
	WaitForUserKeyStroke()
}

#Shows the dataset structure
GetStructureOfDataset <- function(Dataset)
{
	cat("----------------------------\n")
	cat("--Structure of the dataset--\n")
	cat("----------------------------\n\n")
	str(Dataset)
	cat("\n")
}

#Iterates through all the variables in the dataset and shows relevant information
#and graphics
DescriveEachVariable <- function (Dataset)
{
	cat("\n-----------------------\n")
	cat("--Univariate Analysis--\n")
	cat("-----------------------\n")
	
	for (i in 1:ncol(Dataset))
	{
		ClearConsole()
		ShowSummary(Dataset, i)
		
		ShowGraphic(Dataset, i)
		WaitForUserKeyStroke()
	}
}

#Presents the name of the variable, its distribution and calculates the percentaje of
#missing values
ShowSummary <- function(Dataset, column)
{
	cat("\nVariable: ", colnames(Dataset[column]), "\n")
	cat(summary(Dataset[column]), "\n\n")
	
	cat("Distribution of the variable")
	print(table(Dataset[column]))
	cat("\n")
	
	fPercentMissing <- 100 * (sum(is.na(Dataset[column])) / nrow(Dataset[column]))
	cat("% of missing values (case '?'):", fPercentMissing, "%\n")
}

#Creates the proper arrangement of graphics depending on the type of variable
ShowGraphic <- function(Dataset, column)
{
	x <- Dataset[,attributes(Dataset[column])$name]

	if(!is.factor(x))
	{
		layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE))
		
		hist(	x,
				freq=TRUE,
				xlab=attributes(Dataset[column])$name,
				main="Histogram"
			)
		
		boxplot(x,
				horizontal=TRUE,
				xlab=attributes(Dataset[column])$name,
				main="Boxplot")
		
		plot(	density(x),
				xlab=attributes(Dataset[column])$name,
				main="Density")
	}
	else
	{
		layout(matrix(c(1,1,2,2,2,2), 3, 2, byrow = TRUE))
		
		plot(	x,
				xlab=attributes(Dataset[column])$name,
				ylab="Frequency",
				main="Histogram")
				
		sDataSetLevels <- levels(x)
		inCount <- c(1:length(sDataSetLevels))
		for(i in 1:length(sDataSetLevels))
		{
			inCount[i] = length(grep(sDataSetLevels[i], x))
		}
		
		pie(	inCount,
				labels=sDataSetLevels,
				main="Pie chart")
	}
}

#Creates a correlation diagram
ShowCorrelationMatrix <- function(Dataset)
{
	corrgram(Dataset, lower.panel=panel.shade,upper.panel=panel.pie, main="Correlation Matrix")
}