load "stdlib.ring"
load "qtcore.ring"
load "../data/stkStringArtData.ring"
load "../error/stkError.ring"

#NOTE This class is dedicatd to Mahmoud for the effors he deployed
# in delivering the 1.21 version of Ring

# It provides several string art font styles (3 for the mean time).
# These styles can be rounded and background-shaded.



$DEFAULT_STRING_ART_STYLE = :retro

#--------------------#
#  GLOBAL FUNCTIONS  #
#--------------------#

func StringArtStylesXT()
	return $STRING_ART_STYLESXT

func StringArtStyles()
	aStylesXT = StringArtStylesXT()
	nLen = len(aStylesXT)

	acResult = []

	for i = 1 to nLen
		acResult + aStylesXT[i][1]
	next

	return acResult

func DefaultStringArtStyle()
	return $DEFAULT_STRING_ART_STYLE

	func StringArtStyle()
		return return $DEFAULT_STRING_ART_STYLE

func SetDefaultStringArtStyle(cStyle)
	bFound = find(StringArtStyles(), lower(cStyle))
	if bFound = 0
		raise("ERR-" + StkError(:IncorrectParamValue))
	ok

	$DEFAULT_STRING_ART_STYLE = cStyle

	def SetStringArtStyle(cStyle)
		SetDefaultStringArtStyle(cStyle)

func StringArt(str)
	oStrArt = new stkStringArt(str)
	oStrArt.SetStyle(DefaultStringArtStyle())
	return oStrArt.Artify()

func StringArtBoxified(str)
	oStrArt = new stkStringArt(str)
	oStrArt.SetStyle(DefaultStringArtStyle())
	return oStrArt.Boxify()

	func StringArtBoxed(str)
		return StringArtBoxified(str)

func DefaultCharArt()
	return @cDefaultCharArt = ""

func CharArtLayers(c)
	if NOT (isString(c) and len(c) = 1)
		raise("ERR-" + StkError(:IncorrectParamType))
	ok

	c = upper(c)

	# Getting the data about all the chars in the default style

	aDataXT = StringArtStylesXT()[DefaultStringArtStyle()]

	# Finding the char c in the list 

	nLen = len(aDataXT)
	nPos = 0

	for i = 1 to nLen
		if aDataXT[i][1] = c
			nPos = i
			exit
		ok
	next

	return aDataXT[nPos][2]

#--------------------#
#  STRING ART CLASS  #
#--------------------#

class stkStringArt
	@cContent
	@cStyle = DefaultStringArtStyle()

	def init(str)
		if not isString(str)
			raise("ERR-" + StkError(:IncorrectParamType))
		ok

		@cContent = upper(str)

	def Content()
		return @cContent

		def String()
			return @cContent

	def Style()
		return @cStyle

	def SetStyle(cStyle)

		# Early check of default style

		if isString(cStyle) and cStyle = :Default
			@cStyle = DefaultStringArtStyle()
			return
		ok

		# Param type check

		if NOT isString(cStyle)
			raise("ERR-" + StkError(:IncorrectParamType))
		ok

		# Param value check

		nFound = find(StringArtStyles(), lower(cStyle))
		if nFound = 0
			raise("ERR-" + StkError(:IncorrectParamValue))
		ok

		# Setting the style

		@cStyle = cStyle

	def Artify()
 
		cSpacified = pvtSpacify(@cContent)
		nLenStr = len(@cContent) // #NOTE: work only for latin

		aCharSetXT = StringArtStylesXT()[This.Style()]

		nLenCharSet = len(aCharSetXT)
		#--> [
		# 	[ "A", [ ... ] ],
		# 	[ "B", [ ... ] ],
		# 	...
		# 	[ "O", [
		# 		"╭───╮",
		# 		"│╭─╮│", 
		# 		"││ ││", 
		# 		"│╰─╯│", 
		# 		"╰───╯" ],
		# 	...
		# ]

		cResult = ""
		
		for i = 1 to 5
			for j = 1 to nLenStr
				c = @cContent[j]
				cResult += pvtCharArtLayers(c)[i] + " "	
			next

			# Adding the line (without space at the end)

			cResult = left(cResult, len(cResult) - 1) + NL
		next

		cResult = left(cResult, len(cResult) - 1)  // Remove the last newline
		return cResult

	def Boxify()

		# First, convert the input string to string art

	    	oQStrArt = new QString2()
		oQStrArt.append(This.Artify())

		# Split the string art into lines

		oQStrList = oQStrArt.split(NL, 0, 0)
				
		acLines = []
		for i = 0 to oQStrList.size()-1
			acLines + oQStrList.at(i)	
		next

		nLen = len(acLines)

		# Find the maximum line length

		anLenLines = []

		for i = 1 to nLen
			oQStr = new QString2()
			oQStr.append(acLines[i])
			anLenLines + oQStr.count()
		next

		anLenLines = sort(anLenLines)
		nLenMax = anLenLines[nLen]

		# Create the boxed result

		cResult = "╭" + copy("─", (nLenMax + 2)) + "╮" + NL
	    
		for i = 1 to nLen
	        	cResult += "│ " + acLines[i] + " │" + NL
		next
	    
		cResult += "╰" + copy("─", (nLenMax + 2)) + "╯"
	    
		return cResult


	PRIVATE

	func pvtSpacify(str)

		nLen = len(str)
		cResult = ""

		for i = 1 to nLen
			cResult += str[i] + " "
		next
	    
		return trim(cResult)

	func pvtCharArtLayers(c)
		if NOT (isString(c) and len(c) = 1)
			raise("ERR-" + StkError(:IncorrectParamType))
		ok
	
		c = upper(c)
	
		# Getting the data about all the chars in the default style
	
		aDataXT = StringArtStylesXT()[This.Style()]
	
		# Finding the char c in the list 
	
		nLen = len(aDataXT)
		nPos = 0
	
		for i = 1 to nLen
			if aDataXT[i][1] = c
				nPos = i
				exit
			ok
		next
	
		return aDataXT[nPos][2]
	
