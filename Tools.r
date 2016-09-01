	####################
	### Dataiku Test ###
	####################

#US Census dataset analysis#
#Author: Miguel Angel Ortiz#

#Script of transversal functionality used by other scripts

#Emulates the effect of several strokes of "enter" to clear the screen
ClearConsole <<- function()
{
	cat(rep("\n",64))
}

#Waits until the user inputs a key stroke
WaitForUserKeyStroke <- function()
{
	cat ("Press any key to continue...")
	line <- readline()
}