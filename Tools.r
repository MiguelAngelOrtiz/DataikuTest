	####################
	### Dataiku Test ###
	####################

#US Census dataset analysis#
#Author: Miguel Angel Ortiz#

#Script of transversal functionality used by other scripts


ClearConsole <<- function()
{
	cat(rep("\n",64))
}

WaitForUserKeyStroke <- function()
{
	cat ("Press any key to continue...")
	line <- readline()
}