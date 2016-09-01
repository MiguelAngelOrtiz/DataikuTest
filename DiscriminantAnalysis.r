	####################
	### Dataiku Test ###
	####################

#US Census dataset analysis#
#Author: Miguel Angel Ortiz#

#Script to do a very simple prediction model based on Discriminant Analisys

#Governs the execution of the Discriminant Analysis
DiscriminantAnalysis <- function()
{
	SplitData()
	PerformDA()
}

#Splits the datasource into two groups: one in which people earn more than 50K and vice verza
SplitData <- function()
{
	sSelection <- c("age", 
					"wage.per.hour", 
					"capital.gains", 
					"capital.losses", 
					"dividends.from.stocks",
					#"instance.weight",
					"num.persons.worked.for.employer",
					"own.business.or.self.employed",
					"veterans.benefits",
					"weeks.worked.in.year",
					"year")
					
	cat("Splitting datasets into two groups: those with income level > 50K and those whit < 50K\n")
	cat("Warning: categorical variables are not going to be taken into account\n")
	dsLearnIncomeLvl1 <<- subset(dsLearn, income.lvl.binary == 1, select = sSelection)
	dsLearnIncomeLvl0 <<- subset(dsLearn, income.lvl.binary == 0, select = sSelection)
	dsTestIncomeLvl1 <<- subset(dsTest, income.lvl.binary == 1, select = sSelection)
	dsTestIncomeLvl0 <<- subset(dsTest, income.lvl.binary == 0, select = sSelection)
	cat("Done\n")
}

#Implementation of the DA algorithm
PerformDA <- function()
{
	#Calculate Mean Vector of both sets
	dsMeanIncLvl1 <- colMeans(dsLearnIncomeLvl1)
	dsMeanIncLvl0 <- colMeans(dsLearnIncomeLvl0)
	
	#Calculate Variance Matrix of both sets
	dsVarIncLvl1 <- var(dsLearnIncomeLvl1)
	dsVarIncLvl0 <- var(dsLearnIncomeLvl0)
	
	#Calculate n1 and n2
	n1 <- dim(dsLearnIncomeLvl1)[1]
	n2 <- dim(dsLearnIncomeLvl0)[1]
	
	#Matrix S and Inverse of S calculation
	mS <- ( n1*dsVarIncLvl1 + n2*dsVarIncLvl0 ) / (n1 + n2 - 1 )
	mInvS <- solve (mS)
	
	mA <<- mInvS %*% ( dsMeanIncLvl1 - dsMeanIncLvl0 )
	t1Med <<- t ( as.matrix ( mA ) ) %*% as.matrix ( dsMeanIncLvl1 )
	t2Med <<- t ( as.matrix ( mA ) ) %*% as.matrix ( dsMeanIncLvl0 )
	#TODO: Implement error handling
}
	
#Routine to create the confussion matrix to evaluate the model
TestDAPredictions <- function()
{
	inScoreCat11 <- 0
	inScoreCat10 <- 0
	inScoreCat00 <- 0
	inScoreCat01 <- 0
	
	for(i in 1:nrow(dsTestIncomeLvl1))
	{
		if(PredictWithDAModel(dsTestIncomeLvl1[i,]) == 1)
		{
			inScoreCat11 = inScoreCat11 + 1
		}
		else
		{
			inScoreCat01 = inScoreCat01 + 1
		}
	}
	
	for(i in 1:nrow(dsTestIncomeLvl0))
	{
		if(PredictWithDAModel(dsTestIncomeLvl0[i,]) == 0)
		{
			inScoreCat00 = inScoreCat00 + 1
		}
		else
		{
			inScoreCat10 = inScoreCat10 + 1
		}
	}
	
	cat("Confussion Matrix results\n")
	cat("Prediction = >50K | >50K (Correct prediction): ", inScoreCat11, "\n")
	cat("Prediction = <50K | >50K (Incorrect prediction): ", inScoreCat01, "\n")
	cat("Prediction = >50K | <50K (Incorrect prediction): ", inScoreCat10, "\n")
	cat("Prediction = <50K | <50K (Correct prediction): ", inScoreCat00, "\n")
}

#Implements the criteria given the values T1 and T2, as well as the matrix A
#Receives as parameter the vector to estimate the group to which it belongs
PredictWithDAModel <- function(vX)
{
	inT <- t(as.matrix(mA)) %*% t(as.matrix(vX))
	if(abs(inT - t1Med) < abs(inT - t2Med))
	{
		return(1)
	}
	else
	{
		return(0)
	}
}


