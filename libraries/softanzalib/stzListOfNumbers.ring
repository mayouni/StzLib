#---------------------------------------------------------------------------#
# 		    SOFTANZA LIBRARY (V1.0) - StzListOfNumbers		    #
#		An accelerative library for Ring applications		    #
#---------------------------------------------------------------------------#
#									    #
# 	Description	: The core class for managing lists of numbers      #
#	Version		: V1.0 (2020-2024)				    #
#	Author		: Mansour Ayouni (kalidianow@gmail.com)		    #
#									    #
#---------------------------------------------------------------------------#

/*
Short term objective:
	Max() Min() Mean() Sum()
	
	Correlation()
	Covariance()
	AverageDeviation()
	StandardDeviation()
	StandardDeviationP()
	StatError()
	Variance()
	VarianceP()

Long terme objective:
Support all the features of NumPy
	Array Creation:
	arange, array, copy, empty, empty_like, eye, fromfile, fromfunction, identity, linspace, logspace, mgrid, ogrid, ones, ones_like, r_, zeros, zeros_like
	
	Conversions:
	ndarray.astype, atleast_1d, atleast_2d, atleast_3d, mat
	
	Manipulations:
	array_split, column_stack, concatenate, diagonal, dsplit, dstack, hsplit, hstack, ndarray.item, newaxis, ravel, repeat, reshape, resize, squeeze, swapaxes, take, transpose, vsplit, vstack
	
	Questions:
	all, any, nonzero, where
	
	Ordering:
	argmax, argmin, argsort, max, min, ptp, searchsorted, sort
	
	Operations:
	choose, compress, cumprod, cumsum, inner, ndarray.fill, imag, prod, put, putmask, real, sum
	
	Basic Statistics:
	cov, mean, std, var
	
	Basic Linear Algebra:
	cross, dot, outer, linalg.svd, vdot
*/

  ///////////////////
 ///  FUNCTIONS  ///
///////////////////

func StzListOfNumbersQ(paListOfNumbers)
	return new stzListOfNumbers(paListOfNumbers)

	func StzNumbersQ(paListOfNumbers)
		return StzListOfNumbersQ(paListOfNumbers)

func LN(p)

	if  IsPair(p) and
	    IsPair(p[1]) and IsPair(p[2]) and
	    isString(p[1][1]) and isString(p[2][1]) and
	    p[1][1] = :From and p[2][1] = :To and
	    isNumber(p[1][2]) and isNumber(p[2][2])

		return NumbersBetween(p[1][2], p[2][2])

	but isList(p)
		return StzListQ(p).OnlyNumbers()

	but isString(p) and Q(p).IsListInString()
		aResult = Q(p).ToListQ().OnlyNumbers()
		return aResult

	but isNumber(p)
		aResult = []
		for i = 1 to p
			aResult + 0
		next
		return aResult
	ok

	func LNQ(p)
		return Q(LN(p))

		func QLN(p)
			return LNQ(p)

	func LoN(p)
		return LN(p)

		func LoNQ(p)
			return LNQ(p)

func NumbersUnicodes(anNumbers)
	return StzListOfNumbersQ(anNumbers).Unicodes()

func Min(panNumbers)

	if NOT (isList(panNumbers) and Q(panNumbers).IsListOfNumbers())
		StzRaise("Incorrect param! panNumbers must be a list of numbers!")
	ok

	nResult = ring_sort(panNumbers)[1]
	return nResult

	func @Min(panNumbers)
		return Min(panNumbers)

func Max(panNumbers)

	if NOT (isList(panNumbers) and Q(panNumbers).IsListOfNumbers())
		StzRaise("Incorrect param! panNumbers must be a list of numbers!")
	ok

	nResult = ring_reverse( ring_sort(panNumbers) )[1]
	return nResult

	func @Max(panNumbers)
		return Max(panNumbers)

func Sum(panNumbers)
	if CheckParams()
		if NOT ( isList(panNumbers) and IsListOfNumbers(panNumbers) )
			StzRaise("Incorrect param type! panNumbers must be a list of numbers.")
		ok
	ok

	nResult = 0
	nLen = len(panNumbers)
	for i = 1 to nLen
		nResult += panNumbers[i]
	next

	return nResult

	func @Sum(panNumbers)
		return Sum(panNumbers)

func Product(panNumbers)
	oListOfNumbers = new stzListOfNumbers(panNumbers)
	return oListOfNumbers.Product()

	func @Product(panNumbers)
		return Product(panNumbers)

func MultiplicationsYieldingN(n)
	aResult = []
			
	aFactors = reverse(factors(n))

	for i = 1 to len(aFactors)
		aResult + [ factors(n)[i] , aFactors[i] ]
	next i

	return aResult

func MultiplicationsYielding(n)
	return MultiplicationsYieldingN(n)

func MultiplicationsYieldingN_WithoutCommutation(n)
	aResult = []
			
	aFactors = reverse(factors(n))

	for i = 1 to len(aFactors)-1
		if i > 1
			if factors(n)[i] = aFactors[i-1]
				exit
			ok
		ok
		aResult + [ factors(n)[i] , aFactors[i] ]

	next i

	return aResult

func NZeros(n)
	if CheckParams()
		if NOT isNumber(n) and n >= 0
			StzRaise("Incorrect param type! n must be a postive number.")
		ok
	ok

	anResult = []
	for i = 1 to n
		anResult + 0
	next

	return anResult

func NumbersXT(n1, n2)
	if isList(n1) and Q(n1).IsOneOfTheseNamedParams([ :Between, :From ])
		n1 = n1[2]
	ok

	if isList(n2) and Q(n2).IsOneOfTheseNamedParams([ :And, :To ])
		n2 = n2[2]
	ok

	if NOT @BothAreNumbers(n1, n2)
		StzRaise("Incorrect param type! n1 and n2 must both be numbers.")
	ok

	anResult = n1 : n2
	return anResult

	func NumbersBetweenXT(n1, n2)
		return NumbersXT(n1, n2)
	
	func NumbersIB(n1, n2)
		return NumbersXT(n1, n2)
	
	func NumbersBetweenIB(n1, n2)
		return NumbersXT(n1, n2)

func NumbersBetween(n1, n2)
	if CheckParams()

		if isList(n1) and Q(n1).IsOneOfTheseNamedParams([ :Between, :From ])
			n1 = n1[2]
		ok
	
		if isList(n2) and Q(n2).IsOneOfTheseNamedParams([ :And, :To ])
			n2 = n2[2]
		ok
	
		if NOT @BothAreNumbers(n1, n2)
			StzRaise("Incorrect param type! n1 and n2 must both be numbers.")
		ok
	
	ok

	anResult = []

	if n1 = n2
		anResult + n1

	but n1 < n2
		for i = 1 to n2
			aResult + i
		next

	else
		for i = 1 to n2 step -1
			aResult + i
		next
	ok

	return anResult

	func @NumbersBetween(nMin, nMax)
		return NumbersBetween(nMin, nMax)

func CommonNumbers(paListsOfNumbers)
	if NOT ( isList(paListsOfNumbers) and Q(paListsOfNumbers).IsListOfListsOfNumbers())
		StzRaise("Incorrect param type! paListsOfNumbers must be a list of lists of numbers.")
	ok

	return CommonItems(paListsOfNumbers)

	func CommunNumbers(paListsOfNumbers)
		return CommonNumbers(paListsOfNumbers)

	func @CommonNumbers(paListsOfNumbers)
		return CommonNumbers(paListsOfNumbers)
	
func NumbersIn(paList)
	if CheckParams()
		if NOT IsList(paList)
			StzRaise("Incorrect param type! paList must be a list.")
		ok
	ok

	nLen = len(paList)
	anResult = []

	for i = 1 to nLen
		if isNumber(paList[i])
			anResult + palist[i]
		ok
	next

	return anResult

	#< @FunctionAlternativeForm


	func @NumbersIn(paList)
		return NumbersIn(paList)

	#>

func PositiveNumbersIn(paList)
	if CheckParams()
		if NOT IsList(paList)
			StzRaise("Incorrect param type! paList must be a list.")
		ok
	ok

	nLen = len(paList)
	anResult = []

	for i = 1 to nLen
		if isNumber(paList[i]) and paList[i] > 0
			anResult + palist[i]
		ok
	next

	return anResult

	#< @FunctionAlternativeForms

	func @PositiveNumbersIn(paList)
		return PositiveNumbers(paList)

	#--

	func Positive(paList)
		return PositiveNumbers(paList)

	func @Positive(paList)
		return PositiveNumbers(paList)

	#>

func NegativeNumbersIn(paList)
	if CheckParams()
		if NOT IsList(paList)
			StzRaise("Incorrect param type! paList must be a list.")
		ok
	ok

	nLen = len(paList)
	anResult = []

	for i = 1 to nLen
		if isNumber(paList[i]) and paList[i] < 0
			anResult + palist[i]
		ok
	next

	return anResult

	#< @FunctionAlternativeForms

	func @NegativeNumbersIn(paList)
		return NegativeNumbers(paList)

	#--

	func Negative(paList)
		return NegativeNumbers(paList)

	func @Negative(paList)
		return NegativeNumbers(paList)

	#>

func PositiveNumbersBetween(n1, n2)
	if CheckParams()
		if NOT @BothAreNumbers(n1, n2)
			StzRaise("Incorrect param types! n1 and n2 must both be numbers.")
		ok
	ok

	return PositiveNumbersIn(n1:n2)

	#< @FunctionAlternativeForms

	func @PositiveNumbersBetween(n1, n2)
		return PositiveNumbersBetween(n1, n2)

	#>

func NegativeNumbersBetween(n1, n2)
	if CheckParams()
		if NOT @BothAreNumbers(n1, n2)
			StzRaise("Incorrect param types! n1 and n2 must both be numbers.")
		ok
	ok

	return NegativeNumbersIn(n1:n2)

	#< @FunctionAlternativeForms

	func @NegativeNumbersBetween(n1, n2)
		return NegativeNumbersBetween(n1, n2)

	#>

func EvenNumbersIn(paList)
	if CheckParams()
		if NOT IsList(paList)
			StzRaise("Incorrect param type! paList must be a list.")
		ok
	ok

	nLen = len(paList)
	anResult = []

	for i = 1 to nLen
		if isNumber(paList[i]) and IsEven(paList[i])
			anResult + palist[i]
		ok
	next

	return anResult

	#< @FunctionAlternativeForms

	func @EvenNumbersIn(paList)
		return EvenNumbers(paList)

	#--

	func Even(paList)
		return EvenNumbers(paList)

	func @Even(paList)
		return EvenNumbers(paList)

	#>

func OddNumbersIn(paList)
	if CheckParams()
		if NOT IsList(paList)
			StzRaise("Incorrect param type! paList must be a list.")
		ok
	ok

	nLen = len(paList)
	anResult = []

	for i = 1 to nLen
		if isNumber(paList[i]) and IsOdd(paList[i])
			anResult + palist[i]
		ok
	next

	return anResult

	#< @FunctionAlternativeForms

	func @OddNumbersIn(paList)
		return OddNumbers(paList)

	#--

	func Odd(paList)
		return OddNumbers(paList)

	func @Odd(paList)
		return OddNumbers(paList)

	#>

func PrimeNumbersIn(paList)
	if CheckParams()
		if NOT IsList(paList)
			StzRaise("Incorrect param type! paList must be a list.")
		ok
	ok

	nLen = len(paList)
	anResult = []

	for i = 1 to nLen
		if isNumber(paList[i]) and IsPrime(paList[i])
			anResult + palist[i]
		ok
	next

	return anResult

	#< @FunctionAlternativeForms

	func @PrimeNumbersIn(paList)
		return PrimeNumbers(paList)

	#--

	func Prime(paList)
		return PrimeNumbers(paList)

	func @Prime(paList)
		return PrimeNumbers(paList)

	#>

  ////////////////
 ///  CLASS   ///
////////////////

class stzNumbers from stzListOfNumbers

class stzListOfNumbers from stzList
	@anContent

	// TODO: Add the possibility to add a list of numbers in strings
	// --> So we can manage numbers as stzNumbers (wich can be provided
	// in strings to conserve their round.
	def init(paList)
		if isList(paList) and
		   ( Q(paList).IsEmpty() or Q(paList).IsListOfNumbers() )

			@anContent = paList

		but isString(paList)
			try
				aList = Q(paList).ToList()
				if StzListQ(aList).IsListOfNumbers()
					@anContent = aList
				else
					StzRaise("The list in the string you provided is not a list of numbers!")
				ok

			catch
				StzRaise("Can't transform the string into a llist of numbers!")
			done
		else
			StzRaise("Can't create a stzListOfNumbers object!")
		ok

	def Content()
		aResult = @anContent

		return aResult

		def Value()
			return Content()

	def Copy()
		return new stzListOfNumbers(This.Content())

	def ListOfNumbers()
		return Content()

		def Numbers()
			return This.Content()

			def NumbersQ()
				return This.NumbersQR(:stzList)

			def NumbersQR(pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsReturnedParamType()
					pcReturnType = pcReturnType[2]
				ok

				if NOT isString(pcReturnType)
					StzRaise("Incorrect param! pcReturnType must be a string.")
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.Numbers() )

				on :stzListOfStrings
					return new stzListOfStrings( This.Numbers() )

				other
					StzRaise("Unsupported return type!")
				off

	def NumbersW(pcCondition)
		return This.YieldW('@number', pcCondition)

		def NumbersWQ(pcCondition)
			return NumbersWQR(pcCondition, :stzList)

		def NumbersWQR(pcCondition, pcReturnType)
			if isList(pcReturnType) and Q(pcReturnType).IsReturnedParamType()
				pcReturnType = pcReturnType[2]
			ok

			if NOT isString(pcReturnType)
				StzRaise("Incorrect param! pcReturnType must be a string.")
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.NumbersW(pcCondition) )

			on :stzListOfNumbers
				return new stzListOfStrings( This.NumbersW(pcCondition) )

			other
				StzRaise("Unsupported return type!")
			off

	def ToStzList()
		return new stzList(This.Content())

	def ToStzListOfStrings()
		anContent = This.Content()
		nLen = len(anContent)

		acStrings = []

		for i = 1 to nLen
			acStrings + ( ""+ anContent[i] )
		next

		oResult = new stzListOfStrings(acStrings)
		return oResult

	def NumbersTurnedToStrings()
		aResult = This.ToStzListOfStrings().Content()

		return aResult

		def Stringified()
			return This.NumbersTurnedToStrings()

		def AllNumbersTurnedToStrings()
			return This.NumbersTurnedToStrings()

	def NumberAt(n)
		return This.ItemAt(n)	# Inherited from stzList

		def NumberAtPosition(n)
			return This.NumberAt(n)

		def Number(n)
			return This.NumberAt(n)

	  #================================#
	 #  FINDING THE LOWEST N NUMBERS  #
	#================================#

	def NLowestNumbers(n)
		anResult = This.ToStzList().RemoveDuplicatesQ().SortUpQ().FirstNItems(n)
		return anResult

		#< @FunctionAlternativeForms

		def MinNNumbers(n)
			return This.NLowestNumbers(n)

		def NMinNumbers(n)
			return This.NLowestNumbers(n)

		def NMin(n)
			return This.NLowestNumbers(n)

		def MinN(n)
			return This.NLowestNumbers(n)

		def NSmallestNumbers(n)
			return This.NLowestNumbers(n)

		def SmallestNNumbers(n)
			return This.NLowestNumbers(n)

		def SmallestN(n)
			return This.NLowestNumbers(n)

		def LowestNNumbers(n)
			return This.NLowestNumbers(n)

		def LowestN(n)
			return This.NLowestNumbers(n)

		def NSmallest(n)
			return This.NLowestNumbers(n)

		#--

		def NBottomNumbers(n)
			return This.NLowestNumbers(n)

		def BottomNNumbers(n)
			return This.NLowestNumbers(n)

		def NBottom(n)
			return This.NLowestNumbers(n)

		def BottomN(n)
			return This.NLowestNumbers(n)

		#>

	def FindNLowestNumbers(n)
		anNumbers = This.NLowestNumbers(n)
		anResult  = This.FindMany(anNumbers)

		return anResult

		#< @FunctionAlternativeForms

		def FindMinNNumbers(n)
			return This.FindNLowestNumbers(n)

		def FindNMinNumbers(n)
			return This.FindNLowestNumbers(n)

		def FindNMin(n)
			return This.FindNLowestNumbers(n)

		def FindMinN(n)
			return This.FindNLowestNumbers(n)

		def FindNSmallestNumbers(n)
			return This.FindNLowestNumbers(n)

		def FindSmallestNNumbers(n)
			return This.FindNLowestNumbers(n)

		def FindSmallestN(n)
			return This.FindNLowestNumbers(n)

		def FindLowestNNumbers(n)
			return This.FindNLowestNumbers(n)

		def FindLowestN(n)
			return This.FindNLowestNumbers(n)

		def FindNSmallest(n)
			return This.FindNLowestNumbers(n)

		#--

		def FindNBottomNumbers(n)
			return This.FindNLowestNumbers(n)

		def FindBottomNNumbers(n)
			return This.FindNLowestNumbers(n)

		def FindNBottom(n)
			return This.FindNLowestNumbers(n)

		def FindBottomN(n)
			return This.FindNLowestNumbers(n)

		#>

	  #------------------------------------------------------------#
	 #  GETTING THE LOWEST N NUMBERS ALONG WITH THEIR POSITIONS  #
	#------------------------------------------------------------#

	def NLowestNumbersZ(n)
		aResult = @Association([ This.NLowestNumbers(n), This.FindNLowestNumbers(n) ])
		return aResult

		#< @FunctionAlternativeForms

		def MinNNumbersZ(n)
			return This.NLowestNumbersZ(n)

		def NMinNumbersZ(n)
			return This.NLowestNumbersZ(n)

		def NMinZ(n)
			return This.NLowestNumbersZ(n)

		def MinNZ(n)
			return This.NLowestNumbersZ(n)

		def NSmallestNumbersZ(n)
			return This.NLowestNumbersZ(n)

		def SmallestNNumbersZ(n)
			return This.NLowestNumbersZ(n)

		def SmallestNZ(n)
			return This.NLowestNumbersZ(n)

		def LowestNNumbersZ(n)
			return This.NLowestNumbersZ(n)

		def LowestNZ(n)
			return This.NLowestNumbersZ(n)

		def NSmallestZ(n)
			return This.NLowestNumbersZ(n)

		#--

		#--

		def NBottomNumbersZ(n)
			return This.NLowestNumbersZ(n)

		def BottomNNumbersZ(n)
			return This.NLowestNumbersZ(n)

		def NBottomZ(n)
			return This.NLowestNumbersZ(n)

		def BottomNZ(n)
			return This.NLowestNumbersZ(n)

		#==

		def MinNNumbersAndTheirPositions(n)
			return This.NLowestNumbersZ(n)

		def NMinNumbersAndTheirPositions(n)
			return This.NLowestNumbersZ(n)

		def NMinAndTheirPositions(n)
			return This.NLowestNumbersZ(n)

		def MinNAndTheirPositions(n)
			return This.NLowestNumbersZ(n)

		def NSmallestNumbersAndTheirPositions(n)
			return This.NLowestNumbersZ(n)

		def SmallestNNumbersAndTheirPositions(n)
			return This.NLowestNumbersZ(n)

		def SmallestNAndTheirPositions(n)
			return This.NLowestNumbersZ(n)

		def LowestNNumbersAndTheirPositions(n)
			return This.NLowestNumbersZ(n)

		def LowestNAndTheirPositions(n)
			return This.NLowestNumbersZ(n)

		def NSmallestAndTheirPositions(n)
			return This.NLowestNumbersZ(n)

		#--

		def NBottomNumbersAndTheirPositions(n)
			return This.NLowestNumbersZ(n)

		def BottomNNumbersAndTheirPositions(n)
			return This.NLowestNumbersZ(n)

		def NBottomAndTheirPositions(n)
			return This.NLowestNumbersZ(n)

		def BottomNAndTheirPositions(n)
			return This.NLowestNumbersZ(n)

		#>

	#==

	def FindMin()
		aContent = This.Content()
		nLen = len(aContent)

		# Early check

		if nLen = 0
			return 0

		but nLen = 1
			return 1
		ok

		nResult = 1
		nTempNumber = aContent[1]

		for i = 2 to nLen
			if aContent[i] < nTempNumber
				nResult = i
				nTempNumber = aContent[i]
			ok
		next

		return nResult

	def Min()
		anContent = This.Content()
		nResult = ring_sort( anContent )[1]
		return nResult

		def MinNumber()
			return This.Min()

	def MinZ()
		return This.TopNZ(1)[1]

		def MinNumberZ()
			return This.MinZ()

		def MinAndItsPosition()
			return This.MinZ()

		def MinNumberAndItsPosition()
			return This.MinZ()

	#--

	def Bottom3()
		return This.BottomN(3)

	def Bottom3Numbers()
		return This.BottomN(3)

	def Bottom5()
		return This.BottomN(5)

	def Bottom5Numbers()
		return This.BottomN(5)

	def Bottom7()
		return This.BottomN(7)

	def Bottom7Numbers()
		return This.BottomN(7)

	def Bottom10()
		return This.BottomN(10)

	def Bottom10Numbers()
		return This.BottomN(10)

	#--

	def FindBottom3()
		return This.FindBottomN(3)

	def FindBottom3Numbers()
		return This.FindBottomN(3)

	def FindBottom5()
		return This.FindBottomN(5)

	def FindBottom5Numbers()
		return This.FindBottomN(5)

	def FindBottom7()
		return This.FindBottomN(7)

	def FindBottom7Numbers()
		return This.FindBottomN(7)

	def FindBottom10()
		return This.FindBottomN(10)

	def FindBottom10Numbers()
		return This.FindBottomN(10)

	#--

	def Bottom3Z()
		return This.BottomNZ(3)

	def Bottom3NumbersZ()
		return This.BottomNZ(3)

	def Bottom5Z()
		return This.BottomNZ(5)

	def Bottom5NumbersZ()
		return This.BottomNZ(5)

	def Bottom7Z()
		return This.BottomNZ(7)

	def Bottom7NumbersZ()
		return This.BottomNZ(7)

	def Bottom10Z()
		return This.BottomNZ(10)

	def Bottom10NumbersZ()
		return This.BottomNZ(10)

	def Bottom3AndTheirPositions()
		return This.BottomNZ(3)

	def Bottom3NumbersAndTheirPositions()
		return This.BottomNZ(3)

	def Bottom5AndTheirPositions()
		return This.BottomNZ(5)

	def Bottom5NumbersAndTheirPositions()
		return This.BottomNZ(5)

	def Bottom7AndTheirPositions()
		return This.BottomNZ(7)

	def Bottom7NumbersAndTheirPositions()
		return This.BottomNZ(7)

	def Bottom10AndTheirPositions()
		return This.BottomNZ(10)

	def Bottom10NumbersAndTheirPositions()
		return This.BottomNZ(10)

	  #=================================#
	 #  FINDING THE LARGEST N NUMBERS  #
	#=================================#

	def NLargestNumbers(n)
		anResult = This.ToStzList().RemoveDuplicatesQ().SortUpQ().LastNItems(n)
		return anResult

		#< @FunctionAlternativeForms

		def MaxNNumbers(n)
			return This.NLargestNumbers(n)

		def NMaxNumbers(n)
			return This.NLargestNumbers(n)

		def NMax(n)
			return This.NLargestNumbers(n)

		def MaxN(n)
			return This.NLargestNumbers(n)

		def NBiggestNumbers(n)
			return This.NLargestNumbers(n)

		def BiggestNNumbers(n)
			return This.NLargestNumbers(n)

		def BiggestN(n)
			return This.NLargestNumbers(n)

		def LargestNNumbers(n)
			return This.NLargestNumbers(n)

		def LargestN(n)
			return This.NLargestNumbers(n)

		def NBiggest(n)
			return This.NLargestNumbers(n)

		#--

		def NGreatestNumbers(n)
			return This.NLargestNumbers(n)

		def GreatestNNumbers(n)
			return This.NLargestNumbers(n)

		def NGreatest(n)
			return This.NLargestNumbers(n)

		def GreatestN(n)
			return This.NLargestNumbers(n)

		#==

		def NTopNumbers(n)
			return This.NLargestNumbers(n)

		def TopNNumbers(n)
			return This.NLargestNumbers(n)

		def NTop(n)
			return This.NLargestNumbers(n)

		def TopN(n)
			return This.NLargestNumbers(n)

		#>

	def FindNLargestNumbers(n)
		anNumbers = This.NLargestNumbers(n)
		anResult  = This.FindMany(anNumbers)

		return anResult

		#< @FunctionAlternativeForms

		def FindMaxNNumbers(n)
			return This.FindNLargestNumbers(n)

		def FindNMaxNumbers(n)
			return This.FindNLargestNumbers(n)

		def FindNMax(n)
			return This.FindNLargestNumbers(n)

		def FindMaxN(n)
			return This.FindNLargestNumbers(n)

		def FindNBiggestNumbers(n)
			return This.FindNLargestNumbers(n)

		def FindBiggestNNumbers(n)
			return This.FindNLargestNumbers(n)

		def FindBiggestN(n)
			return This.FindNLargestNumbers(n)

		def FindLargestNNumbers(n)
			return This.FindNLargestNumbers(n)

		def FindLargestN(n)
			return This.FindNLargestNumbers(n)

		def FindNBiggest(n)
			return This.FindNLargestNumbers(n)

		#--

		def FindNGreatestNumbers(n)
			return This.FindNLargestNumbers(n)

		def FindGreatestNNumbers(n)
			return This.FindNLargestNumbers(n)

		def FindNGreatest(n)
			return This.FindNLargestNumbers(n)

		def FindGreatestN(n)
			return This.FindNLargestNumbers(n)

		#==

		def FindNTopNumbers(n)
			return This.FindNLargestNumbers(n)

		def FindTopNNumbers(n)
			return This.FindNLargestNumbers(n)

		def FindNTop(n)
			return This.FindNLargestNumbers(n)

		def FindTopN(n)
			return This.FindNLargestNumbers(n)

		#>

	  #------------------------------------------------------------#
	 #  GETTING THE LARGEST N NUMBERS ALONG WITH THEIR POSITIONS  #
	#------------------------------------------------------------#

	def NLargestNumbersZ(n)
		aResult = Association([ This.NLargestNumbers(n), This.FindNLargestNumbers(n) ])
		return aResult

		#< @FunctionAlternativeForms

		def MaxNNumbersZ(n)
			return This.NLargestNumbersZ(n)

		def NMaxNumbersZ(n)
			return This.NLargestNumbersZ(n)

		def NMaxZ(n)
			return This.NLargestNumbersZ(n)

		def MaxNZ(n)
			return This.NLargestNumbersZ(n)

		def NBiggestNumbersZ(n)
			return This.NLargestNumbersZ(n)

		def BiggestNNumbersZ(n)
			return This.NLargestNumbersZ(n)

		def BiggestNZ(n)
			return This.NLargestNumbersZ(n)

		def LargestNNumbersZ(n)
			return This.NLargestNumbersZ(n)

		def LargestNZ(n)
			return This.NLargestNumbersZ(n)

		def NBiggestZ(n)
			return This.NLargestNumbersZ(n)

		#--

		def NGreatestNumbersZ(n)
			return This.NLargestNumbersZ(n)

		def GreatestNNumbersZ(n)
			return This.NLargestNumbersZ(n)

		def NGreatestZ(n)
			return This.NLargestNumbersZ(n)

		def GreatestNZ(n)
			return This.NLargestNumbersZ(n)

		#==

		def MaxNNumbersAndTheirPositions(n)
			return This.NLargestNumbersZ(n)

		def NMaxNumbersAndTheirPositions(n)
			return This.NLargestNumbersZ(n)

		def NMaxAndTheirPositions(n)
			return This.NLargestNumbersZ(n)

		def MaxNAndTheirPositions(n)
			return This.NLargestNumbersZ(n)

		def NBiggestNumbersAndTheirPositions(n)
			return This.NLargestNumbersZ(n)

		def BiggestNNumbersAndTheirPositions(n)
			return This.NLargestNumbersZ(n)

		def BiggestNAndTheirPositions(n)
			return This.NLargestNumbersZ(n)

		def LargestNNumbersAndTheirPositions(n)
			return This.NLargestNumbersZ(n)

		def LargestNAndTheirPositions(n)
			return This.NLargestNumbersZ(n)

		def NBiggestAndTheirPositions(n)
			return This.NLargestNumbersZ(n)

		#--

		def NGreatestNumbersAndTheirPositions(n)
			return This.NLargestNumbersZ(n)

		def GreatestNNumbersAndTheirPositions(n)
			return This.NLargestNumbersZ(n)

		def NGreatestAndTheirPositions(n)
			return This.NLargestNumbersZ(n)

		def GreatestNAndTheirPositions(n)
			return This.NLargestNumbersZ(n)

		#==

		def NTopNumbersZ(n)
			return This.NLargestNumbersZ(n)

		def TopNNumbersZ(n)
			return This.NLargestNumbersZ(n)

		def NTopZ(n)
			return This.NLargestNumbersZ(n)

		def TopNZ(n)
			return This.NLargestNumbersZ(n)

		#--

		def NTopNumbersAndTheirPositions(n)
			return This.NLargestNumbersZ(n)

		def TopNNumbersAndTheirPositions(n)
			return This.NLargestNumbersZ(n)

		def NTopAndTheirPositions(n)
			return This.NLargestNumbersZ(n)

		def TopNAndTheirPositions(n)
			return This.NLargestNumbersZ(n)

		#>

	#==

	def FindMax()
		aContent = This.Content()
		nLen = len(aContent)

		# Early check

		if nLen = 0
			return 0

		but nLen = 1
			return 1
		ok

		nResult = 1
		nTempNumber = aContent[1]

		for i = 2 to nLen
			if aContent[i] > nTempNumber
				nResult = i
				nTempNumber = aContent[i]
			ok
		next

		return nResult

	def Max()
		anContent = This.Content()
		nResult = ring_reverse( ring_sort( anContent ) )[1]
		return nResult

		def MaxNumber()
			return This.Max()

	def MaxZ()
		return This.TopNZ(1)[1]

		def MaxNumberZ()
			return This.MaxZ()

		def MaxAndItsPosition()
			return This.MaxZ()

		def MaxNumberAndItsPosition()
			return This.MaxZ()

	#--

	def Top3()
		return This.TopN(3)

	def Top3Numbers()
		return This.TopN(3)

	def Top5()
		return This.TopN(5)

	def Top5Numbers()
		return This.TopN(5)

	def Top7()
		return This.TopN(7)

	def Top7Numbers()
		return This.TopN(7)

	def Top10()
		return This.TopN(10)

	def Top10Numbers()
		return This.TopN(10)

	#--

	def FindTop3()
		return This.FindTopN(3)

	def FindTop3Numbers()
		return This.FindTopN(3)

	def FindTop5()
		return This.FindTopN(5)

	def FindTop5Numbers()
		return This.FindTopN(5)

	def FindTop7()
		return This.FindTopN(7)

	def FindTop7Numbers()
		return This.FindTopN(7)

	def FindTop10()
		return This.FindTopN(10)

	def FindTop10Numbers()
		return This.FindTopN(10)

	#--

	def Top3Z()
		return This.TopNZ(3)

	def Top3NumbersZ()
		return This.TopNZ(3)

	def Top5Z()
		return This.TopNZ(5)

	def Top5NumbersZ()
		return This.TopNZ(5)

	def Top7Z()
		return This.TopNZ(7)

	def Top7NumbersZ()
		return This.TopNZ(7)

	def Top10Z()
		return This.TopNZ(10)

	def Top10NumbersZ()
		return This.TopNZ(10)

	def Top3AndTheirPositions()
		return This.TopNZ(3)

	def Top3NumbersAndTheirPositions()
		return This.TopNZ(3)

	def Top5AndTheirPositions()
		return This.TopNZ(5)

	def Top5NumbersAndTheirPositions()
		return This.TopNZ(5)

	def Top7AndTheirPositions()
		return This.TopNZ(7)

	def Top7NumbersAndTheirPositions()
		return This.TopNZ(7)

	def Top10AndTheirPositions()
		return This.TopNZ(10)

	def Top10NumbersAndTheirPositions()
		return This.TopNZ(10)

	  #==========================================================================#
	 #  NEAREST NUMBER IN THE LIST TO A GIVEN NUMBER COMING BEFORE OR AFTER IT  #
	#==========================================================================#

	def NearestXT(n, pcBeforeOrAfter)

		# Checking the n param

		if isList(n) and Q(n).IsToNamedParam()
			n = n[2]
		ok

		if NOT isNumber(n)
			StzRaise("Incorrect param type! n must be a number.")
		ok

		# Checking the pcBeforeOrAfter param

		if isList(pcBeforeOrAfter) and
		   Q(pcBeforeOrAfter).IsComingNamedParam()

			pcBeforeOrAfter = pcBeforeOrAfter[2]
		ok

		if NOT 	( isString(pcBeforeOrAfter) and
			  Q(pcBeforeOrAfter).IsOneOfThese([
				:Before, :After, :BeforeIt, :AfterIt,
				:BeforeOrAfter, :BeforeOrAfterIt,
				:AfterOrBefore, :AfterOrBeforeIt,

				:ComingBefore, :ComingAfter, :ComingBeforeIt, :ComingAfterIt,
				:ComingBeforeOrAfter, :ComingBeforeOrAfterIt,
				:ComingAfterOrBefore, :ComingAfterOrBeforeIt

			  ]) )

			StzRaise("Incorrect param type! pcComingBeforeOrAfter must be a string equal to :Before, :After, or :BeforeOrAfter.")

		ok

		# Doing the job

		if Q( pcBeforeOrAfter ).IsOneOfThese([
			:BeforeOrAfter, :BeforeOrAfterIt,
			:AfterOrBefore, :AfterOrBeforeIt,

			:ComingBeforeOrAfter, :ComingBeforeOrAfterIt,
			:ComingAfterOrBefore, :ComingAfterOrBeforeIt
			])

			nResult = This.NearestTo(n)

		but Q( pcBeforeOrAfter ).IsOneOfThese([
			:Before, :BeforeIt,
			:ComingBefore, :ComingBeforeIt
			])

			anPair = This.NeighborsOf(n)
			nResult = anPair[1]

		but Q( pcBeforeOrAfter ).IsOneOfThese([
			:After, :AfterIt,
			:ComingAfter, :ComingAfterIt
			])

			anPair = This.NeighborsOf(n)
			nResult = anPair[2]

		else # Impossible case, but let's deal with it
			StzRaise("Syntax error!")
		ok

		return nResult

		#< @FunctionAlternativeForm

		def NearestToXT(n, pcBeforeOrAfter)
			return This.NearestXT(n, pcBeforeOrAfter)

		#--

		def NearestNumberXT(n, pcBeforeOrAfter)
			return This.NearestXT(n, pcBeforeOrAfter)

		def NearestNumberToXT(n, pcBeforeOrAfter)
			return This.NearestXT(n, pcBeforeOrAfter)

		#==

		def ClosestXT(n, pcBeforeOrAfter)
			return This.NearestXT(n, pcBeforeOrAfter)

		def ClosestToXT(n, pcBeforeOrAfter)
			return This.NearestXT(n, pcBeforeOrAfter)

		#--

		def ClosestNumberXT(n, pcBeforeOrAfter)
			return This.NearestXT(n, pcBeforeOrAfter)

		def ClosestNumberToXT(n, pcBeforeOrAfter)
			return This.NearestXT(n, pcBeforeOrAfter)


		#>

		#< @FunctionMisspelledForm

		def NearstXT(n, pcBeforeOrAfter)
			return This.NearestXT(n, pcBeforeOrAfter)

		def NearstToXT(n, pcBeforeOrAfter)
			return This.NearestXT(n, pcBeforeOrAfter)

		#--

		def NearstNumberXT(n, pcBeforeOrAfter)
			return This.NearestXT(n, pcBeforeOrAfter)

		def NearstNumberToXT(n, pcBeforeOrAfter)
			return This.NearestXT(n, pcBeforeOrAfter)

		#>

	  #---------------------------------------------------------------------------#
	 #  FARTHEST NUMBER IN THE LIST TO A GIVEN NUMBER COMING BEFORE OR AFTER IT  #
	#---------------------------------------------------------------------------#

	def FarthestXT(n, pcBeforeOrAfter)

		# Checking the n param

		if isList(n) and Q(n).IsToNamedParam()
			n = n[2]
		ok

		if NOT isNumber(n)
			StzRaise("Incorrect param type! n must be a number.")
		ok

		# Checking the pcBeforeOrAfter param

		if isList(pcBeforeOrAfter) and
		   Q(pcBeforeOrAfter).IsComingNamedParam()

			pcBeforeOrAfter = pcBeforeOrAfter[2]
		ok

		if NOT ( isString(pcBeforeOrAfter) and
			  Q(pcBeforeOrAfter).IsOneOfThese([
				:Before, :After, :BeforeIt, :AfterIt,
				:BeforeOrAfter, :BeforeOrAfterIt,
				:AfterOrBefore, :AfterOrBeforeIt,

				:ComingBefore, :ComingAfter, :ComingBeforeIt, :ComingAfterIt,
				:ComingBeforeOrAfter, :ComingBeforeOrAfterIt,
				:ComingAfterOrBefore, :ComingAfterOrBeforeIt

			  ]) )

			StzRaise("Incorrect param type! pcComingBeforeOrAfter must be a string equal to :Before, :After, or :BeforeOrAfter.")

		ok

		# Doing the job

		if Q( pcBeforeOrAfter ).IsOneOfThese([
			:BeforeOrAfter, :BeforeOrAfterIt,
			:AfterOrBefore, :AfterOrBeforeIt,

			:ComingBeforeOrAfter, :ComingBeforeOrAfterIt,
			:ComingAfterOrBefore, :ComingAfterOrBeforeIt
			])

			nResult = This.FarthestTo(n)

		but Q( pcBeforeOrAfter ).IsOneOfThese([
			:Before, :BeforeIt,
			:ComingBefore, :ComingBeforeIt
			])

			anSorted = This.ToSetQ().Sorted()
			nLen = len(anSorted)
			
			if nLen = 0
				return NULL

			but nLen = 1
				if anSorted[1] = n
					return NULL

				else
					return anSorted[1]
				ok

			else
				nPos = ring_find(anSorted, n)

				if nPos > 1
					nFirst = anSorted[1]
					nLast  = anSorted[nLen]

					nDif1 = abs(n - nFirst)
					nDif2 = abs(n - nLast)

					if nDif1 > nDif2
						return nLast
					else
						return nFirst
					ok

				else
					return NULL
				ok

			ok

		but Q( pcBeforeOrAfter ).IsOneOfThese([
			:After, :AfterIt,
			:ComingAfter, :ComingAfterIt
			])

			anSorted = This.ToSetQ().Sorted()
			nLen = len(anSorted)

			if nLen = 0
				return NULL

			but nLen = 1
				if anSorted[1] = n
					return NULL

				else
					return anSorted[1]
				ok

			else
				nPos = ring_find(anSorted, n)

				if nPos > 0 and nPos < nLen
					nFirst = anSorted[1]
					nLast  = anSorted[nLen]

					nDif1 = abs(n - nFirst)
					nDif2 = abs(n - nLast)

					if nDif1 > nDif2
						return nFirst
					else
						return nLast
					ok

				else
					return NULL
				ok

			ok		

		ok

		return nResult

		#< @FunctionAlternativeForm

		def FarthestToXT(n, pcBeforeOrAfter)
			return This.FarthestXT(n, pcBeforeOrAfter)

		#>

		#< @FunctionMisspelledForm

		def FarthstXT(n, pcBeforeOrAfter)
			return This.FarthestXT(n, pcBeforeOrAfter)

		def FarthstToXT(n, pcBeforeOrAfter)
			return This.FarthestXT(n, pcBeforeOrAfter)

		#--

		def FarthestNumberXT(n, pcBeforeOrAfter)
			return This.FarthestXT(n, pcBeforeOrAfter)

		def FarthstNumberXT(n, pcBeforeOrAfter)
			return This.FarthestXT(n, pcBeforeOrAfter)

		def FarthstNumberToXT(n, pcBeforeOrAfter)
			return This.FarthestXT(n, pcBeforeOrAfter)

		#>

	  #----------------------------------------------------#
	 #     NEAREST NUMBER IN THE LIST TO A GIVEN NUMBER   #
	#----------------------------------------------------#

	def Nearest(n)
		/* EXAMPLE

		? Q([ 2, 7, 18, 10, 25, 4 ]).NearestTo(12)
		#--> 10
		
		*/

		# Checking the n param

		if isList(n) and Q(n).IsToNamedParam()
			n = n[2]
		ok

		if NOT isNumber(n)
			StzRaise("Incorrect param type! n must be a number.")
		ok

		# Doing the job

		anSorted = This.ToSetQ().Sorted()
		nLen = len(anSorted)

		# Case where the list contains only one number
		# (even if duplicated, like in [ 2, 2, 2 ])

		if nLen = 0
			return NULL

		but nLen = 1
			if anSorted[1] = n
				return NULL
			else
				return anSorted[1]
			ok
		ok

		# Case where n exists in the list

		nPos = ring_find(anSorted, n)

		if nPos > 0
			if nPos = 1
				return anSorted[2]

			but nPos = nLen
				return anSorted[nLen - 1]

			else
				nDif1 = abs( n - anSorted[nPos-1] )
				nDif2 = abs( n - anSorted[nPos+1] )

				if nDif1 < nDif2
					return anSorted[nPos-1]
				else
					return anSorted[nPos+1]
				ok
			ok

		# Case where n does not exist in the list

		else

			nNearest = anSorted[1]
			for i = 2 to nLen
	
				nDif2 = abs(n - anSorted[i])
				nDif1 = abs(n - anSorted[i-1])
	
				if nDif2 < nDif1
					nNearest = anSorted[i]
				ok
						
			next
		
			return nNearest
		ok

		#< @FunctionAlternativeForms

		def NearestTo(n)
			return This.Nearest(n)

		#--

		def NearestNumber(n)
			return This.Nearest(n)

		def NearstNumber(n)
			return This.Nearest(n)

		def NearstNumberTo(n)
			return This.Nearest(n)

		#==

		def Closest(n)
			return This.Nearest()

		#--

		def ClosestTo(n)
			return This.Nearest(n)

		#--

		def ClosestNumber(n)
			return This.Nearest(n)

		def ClosestNumberTo(n)
			return This.Nearest(n)

		#>

		#< @MisspelledForms

		def NearstTo(n)
			return This.Nearest(n)

		def Nearst(n)
			return This.Nearest(n)

		#>
	  #---------------------------------------------------#
	 #   FARTHEST NUMBER IN THE LIST TO A GIVEN NUMBER   #
	#---------------------------------------------------#

	def Farthest(n)

		# Checking the n param

		if isList(n) and Q(n).IsToNamedParam()
			n = n[2]
		ok

		if NOT isNumber(n)
			StzRaise("Incorrect param type! n must be a number.")
		ok

		# Doing the job

		anSorted = This.ToSetQ().Sorted()
		nLen = len(anSorted)

		# Case where the list contains only one number
		# (even if duplicated, like in [ 2, 2, 2 ])

		if nLen = 0
			return NULL

		but nLen = 1
			if anSorted[1] = n
				return NULL
			else
				return anSorted[1]
			ok
		ok

		# Case where n exists in the list

		nPos = ring_find(anSorted, n)

		if nPos > 0
			nDif1 = abs( n - anSorted[1] )
			nDif2 = abs( n - anSorted[nLen] )

			if nDif1 > nDif2
				return anSorted[1]
			else
				return anSorted[nLen]
			ok
		
		# Case where n does not extist in the list
		else

			nFarthest = anSorted[1]
			for i = 2 to nLen
	
				nDif2 = abs(n - anSorted[1])
				nDif1 = abs(n - anSorted[nLen])
	
				if nDif2 < nDif1
					nFarthest = anSorted[nLen]
				ok
						
			next
		
			return nFarthest
		ok

		#< @FunctionAlternativeForm

		def FarthestTo(n)
			return This.Farthest(n)

		#--

		def FarthestNumber(n)
			return This.Farthest(n)

		#>

		#< @FunctionMisspelledForms

		def Fartehst(n)
			return This.Farthest(n)

		def FartehstTo(n)
			return This.Farthest(n)

		def Farthst(n)
			return This.Farthest(n)

		def FarthstTo(n)
			return This.Farthest(n)

		#--

		def FartehstNumber(n)
			return This.Farthest(n)

		def FartehstNumberTo(n)
			return This.Farthest(n)

		def FarthstNumber(n)
			return This.Farthest(n)

		def FarthstNumberTo(n)
			return This.Farthest(n)

		#>

	  #-------------------------------------------------------#
	 #  GETTING THE TWO NIGHBORS (IF ANY) OF A GIVEN NUMBER  #
	#-------------------------------------------------------#

	def Neighbors(n)
		/* EXAMPLE

		o1 = new stzListOfNumbers([ 1, 4, 6, 11, 18 ])
		? o1.NeighborsOf(5)
		#--> [4, 6]
		
		*/

		# Checking the n param

		if isList(n) and Q(n).IsToOrOfNamedParam()
			n = n[2]
		ok

		if NOT isNumber(n)
			StzRaise("Incorrect param type! n must be a number.")
		ok

		# Doing the job
	
		anSorted = This.ToSetQ().Sorted()
		nLen = len(anSorted)

		if nLen = 0 or nLen = 1
			return [ NULL, NULL ]
		ok

		nFirst = anSorted[1]
		nLast  = anSorted[nLen]

		if n > nLast
			aResult = [ nLast, NULL ]
			return aResult
	
		but n < nFirst
			aResult = [ NULL, nFirst ]
			return aResult
	
		ok

		nPos = ring_find( anSorted, n )

		if nPos = 0
			return [ NULL, NULL ]
		ok

		if nPos = 1
			aResult = [ NULL, anSorted[2] ]

		but nPos = nLen
			aResult = [ anSorted[nLen-1], NULL ]

		else
			aResult = [ anSorted[nPos-1], anSorted[nPos+1] ]

		ok

		return aResult

		#< @functionAlternativeForm

		def NeighborsOf(n)
			return This.Neighbors(n)

		def NNeighbors(n)
			return This.Neighbors(n)

		def NNeighborsOf(n)
			return This.Neighbors(n)

		def NNeighborsTo(n)
			return This.Neighbors(n)

		#--

		def NeighboringNumbers(n)
			return This.Neighbors(n)

		def NeighboringNumbersOf(n)
			return This.Neighbors(n)

		def NNeighboringNumbers(n)
			return This.Neighbors(n)

		def NNeighboringNumbersOf(n)
			return This.Neighbors(n)

		def NNeighboringNumbersTo(n)
			return This.Neighbors(n)

		#==

		def NearestNeighbors(n)
			return This.Neighbors(n)

		def NearestNeighborsOf(n)
			return This.Neighbors(n)

		def NearestNeighborsTo(n)
			return This.Neighbors(n)

		def NearestNeighboringNumbers(n)
			return This.Neighbors(n)

		def NearestNeighboringNumbersOf(n)
			return This.Neighbors(n)

		def NearestNeighboringNumbersTo(n)
			return This.Neighbors(n)

		#--

		def ClosesestNeighbors(n)
			return This.Neighbors(n)

		def ClosestNeighborsOf(n)
			return This.Neighbors(n)

		def ClosestNeighborsTo(n)
			return This.Neighbors(n)

		def ClosestNeighboringNumbers(n)
			return This.Neighbors(n)

		def ClosestNeighboringNumbersOf(n)
			return This.Neighbors(n)

		def ClosestNeighboringNumbersTo(n)
			return This.Neighbors(n)

		#>

		#< @FunctionMisspelledForms

		def Nighbors(n)
			return NeighborsOf(n)

		def NearestNighbors(n)
			return NeighborsOf(n)

		def NighborsOf(n)
			return NeighborsOf(n)

		def NearestNighborsOf(n)
			return NeighborsOf(n)

		def NighborsTo(n)
			return NeighborsOf(n)

		def NearestNighborsTo(n)
			return NeighborsOf(n)

		#>

	def FarthestNeighbors(n)

		# Checking the n param

		if isList(n) and Q(n).IsToOrOfNamedParam()
			n = n[2]
		ok

		if NOT isNumber(n)
			StzRaise("Incorrect param type! n must be a number.")
		ok

		# Doing the job
	
		anSorted = This.ToSetQ().Sorted()
		nLen = len(anSorted)
			
		if nLen = 0
			return [ NULL, NULL ]
		ok

		nPos = ring_find( anSorted, n )

		if nPos = 0
			return [ NULL, NULL ]
		ok

		n1 = anSorted[1]
		n2 = anSorted[nLen]

		if nPos = 1
			n1 = NULL

		but nPos = nLen
			n2 = NULL
		ok

		anResult = [ n1, n2 ]
		return anResult

		#< @FunctionAlternativeForms

		def FNeighbors(n)
			return This.FarthestNeighbors(n)

		def FarthestNeighborsOf(n)
			return This.FarthestNeighbors(n)

		def FNeighborsOf(n)
			return This.FarthestNeighbors(n)

		def FarthestNeighborsTo(n)
			return This.FarthestNeighbors(n)

		def FNeighborsTo(n)
			return This.FarthestNeighbors(n)


		#--

		def FarthestNeighboringNumbers(n)
			return This.FarthestNeighbors(n)

		def FNeighboringNumbers(n)
			return This.FarthestNeighbors(n)

		def FarthestNeighboringNumbersOf(n)
			return This.FarthestNeighbors(n)

		def FNeighboringNumbersOf(n)
			return This.FarthestNeighbors(n)

		def FarthestNeighboringNumbersTo(n)
			return This.FarthestNeighbors(n)

		def FNeighboringNumbersTo(n)
			return This.FarthestNeighbors(n)

		#>

		#< @FunctionMisspelledForms

		def FarthestNighbors(n)
			return This.FarthestNeighbors(n)

		def FNighbors(n)
			return This.FarthestNeighbors(n)

		def FarthstNeighbors(n)
			return This.FarthestNeighbors(n)

		def FarthstNighbors(n)
			return This.FarthestNeighbors(n)

		#>

	  #======================================================#
	 #  LEAST COMMON NUMBER WITH AN OTHER LIST OF NUMBERS   #
	#======================================================#

	def LeastCommonNumber(panOtherList)
		/* EXAMPLE

		? StzListOfNumbersQ([8, 12, 46, 102]).
			LeastCommonNumber( :With = [4, 6, 12, 89, 102, 122 ] )

		#--> 12
		*/

		if isList(panOtherList) and Q(panOtherList).IsWithNamedParam()
			panOtherList = panOtherList[2]
		ok

		if NOT Q(panOtherList).IsListOfNumbers()
			StzRaise("Incorrect pram type! panOtherList must be a list of numbers.")
		ok

		anThisSorted = This.SortedInAscending()
		anOtherSorted = Q(panOtherList).SortedInAscending()

		anMain = []
		if len(anThisSorted) <= len(anOtherSorted)
			anMain  = anThisSorted
			anOther = anOtherSorted
		else
			anMain  = anOtherSorted
			anOther = anThisSorted
		ok

		nLen = len(anMain)

		for i = 1 to nLen
			if Q(anOther).FindFirst(anMain[i]) > 0
				return anMain[i]
			ok
		next

		StzRaise("There is no Common Numbers at all between the two lists!")

		def LCN(pOtherNumber)
			return This.LeastCommonNumber(pOtherNumber)

		def SmallestCommunNumber(pOtherNumber)
			return This.LeastCommonNumber(pOtherNumber)


	  #------------------------------------------------------#
	 #  LEAST COMMON NUMBER WITH AN OTHER LIST OF NUMBERS   #
	#------------------------------------------------------#

	def GreatestCommonNumber(panOtherList)
		/* EXAMPLE

		? StzListOfNumbersQ([8, 12, 46, 102]).
			GreatestCommonNumber( :With = [4, 6, 12, 89, 102, 122 ] )

		#--> 102
		*/

		if isList(panOtherList) and Q(panOtherList).IsWithNamedParam()
			panOtherList = panOtherList[2]
		ok

		if NOT Q(panOtherList).IsListOfNumbers()
			StzRaise("Incorrect pram type! panOtherList must be a list of numbers.")
		ok

		anThisSorted = This.SortedInDescending()
		anOtherSorted = Q(panOtherList).SortedInDescending()

		anMain = []
		if len(anThisSorted) <= len(anOtherSorted)
			anMain  = anThisSorted
			anOther = anOtherSorted
		else
			anMain  = anOtherSorted
			anOther = anThisSorted
		ok
		nLen = len(anMain)

		for i = 1 to nLen
			if Q(anOther).FindFirst(anMain[i]) > 0
				return anMain[i]
			ok
		next

		StzRaise("There is no Common Numbers at all between the two lists!")

		def GCN(pOtherNumber)
			return This.GreatestCommonNumber(pOtherNumber)

	  #--------------------------------------------#
	 #  THE LEAST COMMON MULTIPLE OF THE NUMBERS  #
	#--------------------------------------------#

	def LeastCommonMultiple()
		if len( This.ListOfNumbers() ) < 2
			StzRaise("Incorrect value! The list must contain at least 2 numbers.")
		ok

		nResult = 0+ StzNumberQ( This.FirstItem() ).LCM( :With = This.Section(2, :LastItem) )

		return nResult

		def LCM()
			return This.LeastCommonMultiple()

	  #----------------------------------------#
	 #     "ABSOLUTING' THE LIST OF NUMBERS   #
	#----------------------------------------#

	def Absolute()
		anContent = This.Content()*
		nLen = len(anContent)

		for i = 1 to nLen
			if anContent[i] < 0
				anContent[i] = -anContent[i]
			ok
		next

		def AbsoluteQ()
			This.Absolute()
			return This

	def Absoluted()
		return This.Copy().AbsoluteQ().Content()

	  #----------------------------------------#
	 #     "NEGATING' THE LIST OF NUMBERS     #
	#----------------------------------------#

	def Negate()
		anContent = This.Content()
		nLen = len(anContent)

		for i = 1 to nLen
			if anContent[i] > 0
				anContent[i] = -anContent[i]
			ok
		next

		def NegateQ()
			This.Negate()
			return This

	def Negated()
		return This.Copy().NegateQ().Content()

	  #---------------------------#
	 #     BASIC CALCULATIONS    #
	#---------------------------#

	def Product()
		nResult = 1
		nLen = This.NumberOfItems()
		anContent = This.Content()

		for i = 1 to nLen
			nResult *= anContent[i]
		next

		return nResult

	def Sum()
		
		anContent = This.Content()
		nLen = len(anContent)
		nResult = 0

		for i = 1 to nLen
			nResult += anContent[i]
		next

		return nResult

	def Mean()
		return Sum() / (This.NumberOfNumbers())

	def MeanByCoefficient(paList)
		// [ 16, 18, 20, 17 ]
		// [  4,  2,  2,  1 ]
		i = 0

		aProduct = []
		for i=1 to This.NumberOfNumbers()
			aProduct + This.ListOfNumbers()[i] * paList[i]
		next

		oTempList = new steListOfNumbers(aProduct)
		oCoefList = new steListOfNumbers(paList)

		nResult = oTempList.Sum() / oCoefList.Sum()

		return nResult

	  #---------------------------------------#
	 #     CONTAINING DIVIDABLE NUMBER BY    #
	#---------------------------------------#

	def ContainsADividableNumberBy(n)
		oNumber = new stzNumber( This.Product() )

		if oNumber.IsDividableBy(n)
			return TRUE
		else
			return FALSE
		ok

	def DividableNumbersBy(n)
		anContent = This.Content()
		nLen = len(anContent)

		aResult = []

		for i = 1 to nLen
			n = anContent[i]
			oNumber = new stzNumber(n)
			if oNumber.IsDividableBy(n)
				aResult + n
			ok
		next

		return aResult

	  #--------------------------------------#
	 #     CLIPPING THE LIST OF NUMBERS     #
	#--------------------------------------#

	# Limits the values of the list by adjusting the numbers outside
	# the provided range (nMin, nMax). Each number lesser then nMin
	# becomes equal to nMin. And each number greater then nMax becomes
	# equal to nMax.

	def Clip(nMin, nMax)
		/*
		o1 = new stzListOfNumbers([1, 2, 3, 4, 5, 6, 7, 8 ])
		? o1.Clip(3, 5)
		// --> Should return: [ 3, 3, 3, 4, 5, 5, 5, 5, 5 ])
		*/

		anContent = This.Content()
		nLen = len(anContent)

		for i = 1 to nLen
			n = anContent[i]

			if n < nMin
				n = nMin
			but n > nMax
				n = nMax
			ok
		next

		def ClipQ(nMin, nMax)
			return This.ClipQR(nMin, nMax, pcReturnType)

		def ClipQR(nMin, nMax, pcReturnType)
			if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.Clip(nMin, nMax) )

			on :stzListOfNumbers
				return new stzListOfNumbers( This.Clip(nMin, nMax) )

			other
				StzRaise("Unsupported return type!")
			off

	  #-----------------------------------------#
	 #     REPLACING A SECTION OF THE LIST     #
	#-----------------------------------------#

	def ReplaceSectionWith(n1, n2, n)
		for i = 1 to This.NumberOfNumber()
			if i >= n1 and i <= n2
				This.Content()[i] = n
			ok
		next
		
		def ReplaceSectionWithQ(n1, n2, n)
			return This.ReplaceSectionWithQR(n1, n2, n)

		def ReplaceSectionWithQR(n1, n2, n)
			if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.ReplaceSectionWith(n1, n2, n) )

			on :stzListOfNumbers
				return new stzListOfNumbers( This.ReplaceSectionWith(n1, n2, n) )

			other
				StzRaise("Unsupported return type!")
			off

	  #----------------------------#
	 #     CUMULATING NUMBERS     #
	#----------------------------#

	def Cumulate()
		aResult = []
		nLen = This.Content()
		for i = 3 to nLen
			@anContent[i] += @anContent[i-1]
		next
			
		def CumulateQ()
			return This.CumulateQR()

		def CumulateQR()
			if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.Cumulate() )

			on :stzListOfNumbers
				return new stzList( This.Cumulate(n1) )

			other
				StzRaise("Unsupported return type!")
			off

	def Cumulated()
		anResult = This.Copy().CumulateQ().Content()
		return anResult

	  #-------------------------------------------------------------#
	 #  GETTING ONLY UNICODE NUMBERS AMONG THE NUMBER IN THE LIST  #
	#-------------------------------------------------------------#

	def OnlyUnicodes()
		anContent = This.Content()
		nLen = len(anContent)

		aResult = []

		for i = 1 to nLen
			n = anContent[i]

			if IsUnicodeNumber(n)
				aResult + n
			ok
		next

		return aResult

		#< @FunctionFluentForm

		def OnlyUnicodesQ()
			return This.CumulateQR(:stzList)

		def OnlyUnicodesQR(pcReturnType)
			if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok
	
			switch pcReturnType
			on :stzList
				return new stzList( This.OnlyUnicodes() )
	
			on :stzListOfNumbers
				return new stzList( This.OnlyUnicodes() )
	
			other
				StzRaise("Unsupported return type!")
			off

		#>

	  #========================================#
	 #     ADDING A NUMBER TO EACH NUMBER     #
	#========================================#

	def AddToEach(n)
		
		anContent = This.Content()

		nLen = len(anContent)

		anResult = []

		for i = 1 to nLen
			anResult + (anContent[i] + n)
		next

		This.Update(anResult)

		def AddToEachQ(n)
			This.AddToEach(n)
			return This

		def AddToEachNumber(n)
			This.AddToEach(n)

			def AddToEachNumberQ(n)
				return This. AddToEachQ(n)

		def AddToEveryNumber(n)
			This.AddToEach(n)

			def AddToEveryNumberQ(n)
				return This. AddToEachQ(n)

	def AddedToEach(n)
		anResult = This.Copy().AddToEachQ(n).Content()
		return anResult

		def AddedToEachNumber(n)
			return This.AddedToEach(n)

		def AddedToEveryNumber(n)
			return This.AddedToEach(n)

	  #------------------------------------------------#
	 #     SubStructING A NUMBER FROM EACH NUMBER     #
	#------------------------------------------------#

	def SubStructFromEach(n)
		anContent = This.Content()
		nLen = len(anContent)

		anResult = []

		for i = 1 to nLen
			anResult + (anContent[i] - n)
		next

		This.Update(anResult)

		#< @FunctionFluentForm

		def SubStructFromEachQ(n)
			This.SubStructFromEach(n)
			return This

		#>

		#< @FunctionAlternativeForms

		def SubStructFromEachNumber(n)
			This.SubStructFromEach(n)

			def SubStructFromEachNumberQ(n)
				return This.SubStructFromEachQ(n)

		#>

		#< @FunctionAlternativeForms

		def SubstractFromEach(n)
			This.SubStructFromEach(n)

		def SubStractFromEachNumber(n)
			This.SubStructFromEach(n)

			def SubStractFromEachNumberQ(n)
				return This.SubStructFromEachQ(n)

		#--

		def SubtractFromEach(n)
			This.SubStructFromEach(n)

		def SubtractFromEachNumber(n)
			This.SubStructFromEach(n)

			def SubtractFromEachNumberQ(n)
				return This.SubStructFromEachQ(n)

		#--

		def SubtructFromEach(n)
			This.SubStructFromEach(n)

		def SubtructFromEachNumber(n)
			This.SubStructFromEach(n)

			def SubtructFromEachNumberQ(n)
				return This.SubStructFromEachQ(n)

		#>

	def SubStructedFromEach(n)
		anResult = This.Copy().SubStructFromEachQ(n).Content()
		return anResult

		#< @FunctionAlternativeForm

		def SubStructedFromEachNumber(n)
			return This.SubStructedFromEach(n)

		def SubStructedFromEveryNumber(n)
			return This.SubStructedFromEach(n)

		#>

		#< @FunctionAlternativeForms

		def SubstractedFromEach(n)
			return This.SubStructFromEach(n)

		def SubstractedFromEachNumber(n)
			return This.SubStructedFromEach(n)

		def SubstractedFromEveryNumber(n)
			return This.SubStructedFromEach(n)

		#--

		def SubtractedFromEach(n)
			return This.SubStructFromEach(n)

		def SubtractedFromEachNumber(n)
			return This.SubStructedFromEach(n)

		def SubtractedFromEveryNumber(n)
			return This.SubStructedFromEach(n)

		#--

		def SubtructedFromEach(n)
			return This.SubStructFromEach(n)

		def SubtructedFromEachNumber(n)
			return This.SubStructedFromEach(n)

		def SubtructedFromEveryNumber(n)
			return This.SubStructedFromEach(n)

		#>

	  #---------------------------------------------#
	 #     MULTIPLYING EACH NUMBER BY A NUMBER     #
	#---------------------------------------------#

	def MultiplyEachBy(n)
		anContent = This.Content()
		nLen = len(anContent)

		anResult = []

		for i = 1 to nLen
			anResult + (anContent[i] * n)
		next

		This.Update(anResult)

		#< @FunctionFluentForm

		def MultiplyEachByQ(n)
			This.MultiplyEachBy(n)
			return This

		#>

		#< @FunctionAlternativeForms

		def MultiplyEachNumberBy(n)
			This.MultiplyEachBy(n)

			def MultiplyEachNumberByQ(n)
				return This.MultiplyEachByQ(n)

		def MultiplyEveryNumberBy(n)
			This.MultiplyEachBy(n)

			def MultiplyEveryNumberByQ(n)
				return This.MultiplyEachByQ(n)
 
		#>

	def EachMultipliedBy(n)
		anResult = This.Copy().MultiplyEachByQ(n).Content()
		return anResult

		def EachNumberMultipliedBy(n)
			return This.EachMultipliedBy(n)

		def EveryNumberMultipliedBy(n)
			return This.EachMultipliedBy(n)

	  #------------------------------------------#
	 #     DIVIDING EACH NUMBER BY A NUMBER     # 
	#------------------------------------------#

	def DivideEachBy(n)
		anContent = This.Content()
		nLen = len(anContent)

		anResult = []

		for i = 1 to nLen
			anResult + (anContent[i] / n)
		next

		This.Update(anResult)

		#< @FunctionFluentForm

		def DivideEachByQ(n)
			This.DivideEachBy(n)
			return This

		#>

		#< @FunctionAlternativeForms

		def DivideEachNumberBy(n)
			This.DivideEachBy(n)

			def DivideEachNumberByQ(n)
				return This.DivideEachByQ(n)

		def DivideEveryNumberBy(n)
			This.DivideEachBy(n)

			def DivideEveryNumberByQ(n)
				return This.DivideEachByQ(n)

		#>

	def EachDividedBy(n)
		anResult = This.Copy().DivideEachByQ(n).Content()
		return anResult

		def EachNumberDividedBy(n)
			return This.EachDividedBy(n)

		def EveryNumberDividedBy(n)
			return This.EachDividedBy(n)

	  #====================================#
	 #   ADDING MANY NUMBERS ONE BY ONE   #
	#====================================#

	def AddManyOneByOne(panNumbers)

		if NOT ( isList(panNumbers) and Q(panNumbers).IsListOfNumbers() )
			StzRaise("Incorrect param type! You must provide a list of numbers.")
		ok

		anContent = This.Content()
		nLen1 = This.NumberOfNumbers()
		nLen2 = len(panNumbers)

		nLen = nLen1
		if nLen2 < nLen1
			nLen = nLen2
		ok

		anResult = []

		for i = 1 to nLen
			nSum = anContent[i] + panNumbers[i]
			anResult + nSum
		next

		This.Update(anResult)

		#< @FunctionFluentForm

		def AddManyOneByOneQ(panNumbers)
			This.AddManyOneByOne(panNumbers)
			return This

		#>

		#< @FunctionAlternativeForm

		def AddManyNumbersOneByOne(panNumbers)
			This.AddManyOneByOne(panNumbers)

			def AddManyNumbersOneByOneQ(panNumbers)
				return This.AddManyOneByOneQ(panNumbers)

		#>

	def ManyAddOneByOne(panNumbers)
		anResult = This.Copy().AddManyOneByOneQ(panNumbers).Content()
		return anResult

		def ManyNumbersAddedOneByOne(panNumbers)
			return This.ManyAddOneByOne(panNumbers)

	  #------------------------------------------#
	 #   SubStructING MANY NUMBERS ONE BY ONE   #
	#------------------------------------------#

	def SubStructManyOneByOne(panNumbers)

		if NOT ( isList(panNumbers) and Q(panNumbers).IsListOfNumbers() )
			StzRaise("Incorrect param type! You must provide a list of numbers.")
		ok

		anContent = This.Content()
		nLen1 = This.NumberOfNumbers()
		nLen2 = len(panNumbers)

		nLen = nLen1
		if nLen2 < nLen1
			nLen = nLen2
		ok

		anResult = []

		for i = 1 to nLen
			nDif = anContent[i] - panNumbers[i]
			anResult + nDif
		next

		This.Update(anResult)

		#< @FunctionFluentForm

		def SubStructManyOneByOneQ(panNumbers)
			This.SubStructManyOneByOne(panNumbers)
			return This

		#>

		#< @FunctionAlternativeForm

		def SubStructManyNumbersOneByOne(panNumbers)
			This.SubStructManyOneByOne(panNumbers)

			def SubStructManyNumbersOneByOneQ(panNumbers)
				return This.SubStructManyOneByOneQ(panNumbers)

		#>

	def ManySubStructedOneByOne(panNumbers)
		aResult = This.Copy().SubStructManyOneByOneQ(panNumbers).Content()
		return aResult

		def ManyNumbersSubStructedOneByOne(panNumbers)
			return This.ManyAddOneByOne(panNumbers)


	  #----------------------------------------------------------------------#
	 #   MULTIPLYING THE NUMBERS OF THE LIST WITH MANY NUMBERS ONE BY ONE   #
	#----------------------------------------------------------------------#

	def MultiplyWithManyOneByOne(panNumbers)

		if NOT ( isList(panNumbers) and Q(panNumbers).IsListOfNumbers() )
			StzRaise("Incorrect param type! You must provide a list of numbers.")
		ok

		anContent = This.Content()
		nLen1 = This.NumberOfNumbers()
		nLen2 = len(panNumbers)

		nLen = nLen1
		if nLen2 < nLen1
			nLen = nLen2
		ok

		anResult = []

		for i = 1 to nLen
			nProd = anContent[i] * panNumbers[i]
			anResult + nProd
		next

		This.Update(anResult)

		#< @FunctionFluentForm

		def MultiplyWithManyOneByOneQ(panNumbers)
			This.MultiplyWithManyOneByOne(panNumbers)
			return This

		#>

		#< @FunctionAlternativeForms

		def MultiplyByManyOneByOne(panNumbers)
			return This.MultiplyWithManyOneByOne(panNumbers)

			def MultiplyByManyOneByOneQ(panNumbers)
				return This.MultiplyWithManyOneByOneQ(panNumbers)

		def MultiplyByManyNumbersOneByOne(panNumbers)
			return This.MultiplyWithManyOneByOne(panNumbers)

			def MultiplyByManyNumbersOneByOneQ(panNumbers)
				return This.MultiplyWithManyOneByOneQ(panNumbers)

		def MultiplyWithManyNumbersOneByOne(panNumbers)
			return This.MultiplyWithManyOneByOne(panNumbers)

			def MultiplyWithManyNumbersOneByOneQ(panNumbers)
				return This.MultiplyWithManyOneByOneQ(panNumbers)

		#>

	def MultipliedWithManyOneByOne(panNumbers)
		anResult = This.Copy().MultiplyWithManyOneByOneQ(panNumbers).Content()
		return anResult

		#< @FunctionAlternativeForms

		def MultipliedByManyOneByOne(panNumbers)
			return This.MultipliedWithManyOneByOne(panNumbers)

		def MultipliedByManyNumbersOneByOne(panNumbers)
			return This.MultipliedWithManyOneByOne(panNumbers)

		def MultipliedWithManyNumbersOneByOne(panNumbers)
			return This.MultipliedWithManyOneByOne(panNumbers)

		#>

	  #-------------------------------------------------------------------#
	 #   DEVIDING THE NUMBERS OF THE LIST WITH MANY NUMBERS ONE BY ONE   #
	#-------------------------------------------------------------------#

	def DivideByManyOneByOne(panNumbers)

		if NOT ( isList(panNumbers) and Q(panNumbers).IsListOfNumbers() )
			StzRaise("Incorrect param type! You must provide a list of numbers.")
		ok

		anContent = This.Content()
		nLen1 = This.NumberOfNumbers()
		nLen2 = len(panNumbers)

		nLen = nLen1
		if nLen2 < nLen1
			nLen = nLen2
		ok

		anResult = []

		for i = 1 to nLen
			nDiv = anContent[i] / panNumbers[i]
			anResult + nDiv
		next

		This.Update(anResult)

		def DivideByManyOneByOneQ(panNumbers)
			This.DivideByManyOneByOne(panNumbers)
			return This

		#TODO
		# Add alternatives

	def DividedByManyOneByOne(panNumbers)
		anResult = This.Copy().DivideByManyOneByOneQ(panNumbers).Content()
		return anResult

		#TODO
		# Add alternatives

	  #===================================================#
	 #   ADDING NUMBER TO EACH UNDER A GIVEN CONDITION   #
	#===================================================#

	def AddToEachW(n, pcCondition)

		# Checking params

		if NOT isNumber(n)
			StzRaise("Incorrect param type! n must be a number.")
		ok

		if isList(pcCondition) and Q(pcCondition).IsWhereNamedParam()
			pcCondition = pcCondition[2]
		ok

		if NOT isString(pcCondition)
			StzRaise("Incorrect param type! pcCondition must be a string.")
		ok

		# Doing the job

		anContent = This.Content()
		nLen = len(anContent)
		if nLen = 0
			return []
		ok

		oCCode = StzCCodeQ(pcCondition)
		aSection = oCCode.ExecutableSection()

		nStart = aSection[1]
		if nStart = :First
			nStart = 1
		ok

		nEnd = aSection[2]
		if nEnd = :Last
			nEnd = nLen
		ok

		cCode = oCCode.Transpiled()
		cCode = 'bOk + (' + cCode + ')'

		anResult = []

		for @i = nStart to nEnd
			eval(cCode)
			if bOk
				anResult + (anContent[@i] + n)
			ok
		next

		This.Update( anResult )

		def AddToEachWQ(n)
			This.AddToEachW(n)
			return This

		#TODO
		# Add alternatives

	def AddedToEachW(n)
		aResult = This.Copy().AddToEachWQ(n).Content()
		return aResult

		#TODO
		# Add alternatives

	  #--------------------------------------------------------#
	 #   SubStruct NUMBER FROM EACH UNDER A GIVEN CONDITION   #
	#--------------------------------------------------------#

	def SubStructFromEachW(n, pcCondition)
		This.AddToEachW(-n, pcCondition)

		def SubStructFromEachWQ(n)
			This.SubStructFromEachW(n)
			return This

		#TODO
		# Add alternatives

	def SubStructedFromEachW(n)
		aResult = This.Copy().SubStructFromEachWQ(n).Content()
		return aResult
	
		#TODO
		# Add alternatives

	  #--------------------------------------------------------------------#
	 #   MULTIPLYING NUMBERS BY AN OTHER NUMBER UNDER A GIVEN CONDITION   #
	#--------------------------------------------------------------------#

	def MultiplyEachWithW(n, pcCondition)

		if NOT isNumber(n)
			StzRaise("Incorrect param type! n must be a number.")
		ok


		if isList(pcCondition) and Q(pcCondition).IsWhereNamedParam()
			pcCondition = pcCondition[2]
		ok

		if NOT isString(pcCondition)
			StzRaise("Incorrect param type! pcCondition must be a string.")
		ok

		anContent = This.Content()
		nLen = len(anContent)

		cCondition = StzCCodeQ(pcCondition).Transpiled()
		cCode = "bOk = (" + cCondition + ")"
		oCode = new stzString(cCode)

		for @i = 1 to nLen
			@number = anContent[@i]
			bEval = TRUE

			if @i = nLen and
			   oCode.Copy().RemoveSpacesQ().ContainsCS( "This[i+1]", :CS = FALSE )

				bEval = FALSE

			ok

			if @i = 1 and
			   oCode.Copy().RemoveSpacesQ().ContainsCS( "This[i-1]", :CS = FALSE )

				bEval = TRUE
			ok

			if bEval
				eval(cCode)
				if bOk
					@number *= n
				ok
			ok
		next

		def MultiplyEachWithWQ(n)
			This.MultiplyEachWithW(n)
			return This

		def MultiplyEachByW()
			This.MultiplyEachWithW(n, pcCondition)

			def MultiplyEachByWQ()
				This.MultiplyEachByW()
				return This

		#TODO
		# Add other alternatives

	def EachMultipliedWithW(n)
		aResult = This.Copy().MultiplyEachWithWQ(n).Content()
		return aResult

		def EachMultipliedByW(n)
			return This.EachMultipliedWithW(n)

		#TODO
		# Add other alternatives

	  #-------------------------------------------------------------------#
	 #   DIVIDE EACH NUMBER BY AN OTHER NUMBER UNDER A GIVEN CONDITION   #
	#-------------------------------------------------------------------#

	def DivideEachWithW(n, pcCondition)
		This.MultiplyEachWithW( 1/n, pcCondition )

		def DivideEachWithWQ(n)
			This.DivideEachWithW(n)
			return This

		def DivideEachByW(n, pcCondition)
			This.DivideEachWithW(n, pcCondition)

		#TODO
		# Add alternatives

	def EachDividedWithW(n)
		aResult = This.Copy().DivideEachWithWQ(n).Content()
		return aResult

		def EachDividedByW(n)
			return This.EachDividedWithW(n)
	
		#TODO
		# Add alternatives

	  #=====================================================#
	 #     UPDATING THE LIST WITH A NEW LIST OF NUMBERS    #
	#=====================================================#

	def Update(panNewListOfNumbers)

		if isList(panNewListOfNumbers) and Q(panNewListOfNumbers).IsWithOrByOrUsingNamedParam()
			panNewListOfNumbers = panNewListOfNumbers[2]
		ok

		if NOT ( isList(panNewListOfNumbers) and
			 Q(panNewListOfNumbers).IsListOfNumbers()
		       )

			StzRaise("Incorrect param type!")
		ok

		@anContent = panNewListOfNumbers

		#< @FunctionFluentForm

		def UpdateQ(panNewListOfNumbers)
			This.Update(panNewListOfNumbers)
			return This

		#>

		#< @FunctionAlternativeForms

		def UpdateWith(panNewListOfNumbers)
			This.Update(panNewListOfNumbers)

			def UpdateWithQ(panNewListOfNumbers)
				return This.UpdateQ(panNewListOfNumbers)
	
		def UpdateBy(panNewListOfNumbers)
			This.Update(panNewListOfNumbers)

			def UpdateByQ(panNewListOfNumbers)
				return This.UpdateQ(panNewListOfNumbers)

		def UpdateUsing(panNewListOfNumbers)
			This.Update(panNewListOfNumbers)

			def UpdateUsingQ(panNewListOfNumbers)
				return This.UpdateQ(panNewListOfNumbers)

		#>

	def Updated(panNewListOfNumbers)
		return panNewListOfNumbers

		#< @FunctionAlternativeForms

		def UpdatedWith(panNewListOfNumbers)
			return This.Updated(panNewListOfNumbers)

		def UpdatedBy(panNewListOfNumbers)
			return This.Updated(panNewListOfNumbers)

		def UpdatedUsing(panNewListOfNumbers)
			return This.Updated(panNewListOfNumbers)

		#>

	  #-----------------------------------------------------------#
	 #     REPLACING A NUMBER AT A GIVEN POSITION IN THE LIST    #
	#-----------------------------------------------------------#

	def ReplaceNumberAtPosition(n, pnNewNumber)

		if NOT isNumber(n)
			StzRaise("Incorrect param! n must be a number.")
		ok

		if isList(pnNewNumber) and Q(pnNewNumber).IsWithOrByNamedParam()
			pnNewNumber = pnNewNumber[2]
		ok

		if NOT isNumber(pnNewNumber)
			StzRaise("Incorrect param! pnNewNumber must be a number.")
		ok

		@anContent[n] = pnNewNumber

	  #---------------------------------------#
	 #     REVERSING THE LIST OF NUMBERS     #
	#---------------------------------------#

	def Reverse()
		aResult = This.ToStzList().Reversed()
		This.UpdateWith( aResult )

		def ReverseQ()
			This.Reverse()
			return This

		def ReverseNumbers()
			This.Reverse()

			def ReverseNumbersQ()
				This.ReverseNumbers()
				return This

	def Reversed()
		aResult = This.Copy().ReverseQ().Content()

		return aResult

		def NumbersReversed()
			return This.Reversed()

	  #=========================================#
	 #   PERFORMING AN ACTION ON EACH NUMBER   #
	#=========================================#

	def Perform(pcCode)
		# Must begin with '@number ='

		This.PerformOnThesePositions(1:This.NumberOfNumbers(), pcCode)

		#--

		def PerformQ(pcCode)
			This.Perform(pcCode)
			return This

	  #------------------------------------------------------#
	 #   PERFORMING ACTIONS ON NUMBERS IN GIVEN POSITIONS   #
	#------------------------------------------------------#

	def PerformOn(panPos, pcCode)

		if NOT ( isList(panPos) and Q(panPos).IsListOfNumbers() )
			StzRaise("Invalid param type! panPos must be a list of numbers.")
		ok

		if NOT isString(pcCode)
			StzRaise("Invalid param type! pcCode must be a string.")
		ok

		oCode = new stzString( StzCCodeQ(pcCode).UnifiedFor(:stzListOfNumbers) )

		if NOT oCode.BeginsWithOneOfTheseCS(
			[ "@number =", "@number=",
			  "@number +=", "@number+=",
			  "@number -=", "@number-=",
			  "@number *=", "@number*=",
			  "@number /=", "@number/="
			],

			:CaseSensitive = FALSE )

			StzRaise("Syntax error! pcCode must begin with '@item ='.")
		ok

		cCode = oCode.Content()
		nLenPos = len(panPos)
		nLen = this.NumberOfNumbers()

		for i = 1 to nLenPos
			@i = panPos[i]
			@number = This[ @i ]
			bEval = TRUE

			if @i = nLen and
			   oCode.Copy().RemoveSpacesQ().ContainsCS( "This[@i+1]", :CS=FALSE )

				bEval = FALSE

			but @i = 1 and
			    oCode.Copy().RemoveSpacesQ().ContainsCS( "This[@i-1]", :CS=FALSE )

				bEval = FALSE
			
			ok

			if bEval

			eval(cCode)
				This.ReplaceNumberAtPosition(@i, @number)
			ok

		next

		#--

		def PerformOnQ(panPos, pcCode)
			This.PerformOn(panPos, pcCode)
			return This

		def PerformOnPositions(panPos, pcCode)
			This.PerformOn(panPos, pcCode)

			def PerformOnPositionsQ(panPos, pcCode)
				This.PerformOnPositions(panPos, pcCode)
				return This

		def PerformOnThesePositions(panPos, pcCode)
			This.PerformOn(panPos, pcCode)

			def PerformOnThesePositionsQ(panPos, pcCode)
				This.PerformOnThesePositions(panPos, pcCode)
				return This

	  #--------------------------------------------------------#
	 #   PERFORMING AN ACTION ON NUMBERS IN GIVEN SECTIONS    #
	#--------------------------------------------------------#

	def PerformOnSections(paSections, pcCode)

		anPos = StzListOfPairsQ(paSections).
				ExpandedIfPairsOfNumbersQ().MergeQ().
				RemoveDuplicatesQ().SortedInAscending()

		This.PerformOnPositions(anPos, pcCode)

		#--

		def PerformOnSectionsQ(paSections, pcCode)
			This.PerformOnSections(paSections, pcCode)
			return This

		def PerformOnTheseSections(paSections, pcCode)
			This.PerformOnSections(paSections, pcCode)

			def PerformOnTheseSectionsQ(paSections, pcCode)
				This.PerformOnTheseSections(paSections, pcCode)
				return This

	  #-----------------------------------------------------------------#
	 #   PERFORMING AN ACTION ON NUMBERS VERIFYING A GIVEN CONDITION   #
	#-----------------------------------------------------------------#

	def PerformW(pcAction, pcCondition)

		This.UpdateWith(
			This.NumbersQ().
			PerformWQ(pcAction, pcCondition).Content()
		)		

		#--

		def PerformWQ(paParams)
			This.PerformW(paParams)
			return This

	  #===========#
	 #   MISC.   #
	#===========#

	def IsStzListOfNumbers()
		return TRUE

	def stzType()
		return :stzListOfNumbers

		def ClassName()
			return This.stzType()

	#-----

	def ToStzListOfChars()
		return new stzListOfChars( This.Content() )

	def NumberOfNumbers()
		return len( This.Content() )

	def IsContiguous()
		nLen = This.NumberOfNumbers()

		if nLen = 0 or nLen = 1
			return FALSE
		ok

		aContent = This.Content()

		if nLen = 2
			if aContent[1] = aContent[2]
				return FALSE
			ok
		ok

		# Case nLen > 2 (3 and more)

		n1 = aContent[1]
		n2 = aContent[2]

		bResult = TRUE
		if n1 < n2
			for i = 3 to nLen
				if aContent[i] != aContent[i-1] + 1
					bResult = FALSE
					exit
				ok
			next
		else // n1 > n2
			for i = 3 to nLen
				if aContent[i] != aContent[i-1] - 1
					bResult = FALSE
					exit
				ok
			next

		ok

		return bResult

		def IsContinuous()
			return This.IsContiguous()

	  #=========================================#
	 #  GETTING A RANDOM NUMBER FROM THE LIST  #
	#=========================================#

	def ARandomNumber()
		nRandom  = ARandomNumberBetween(1, This.NumberOfNumbers())
		anResult = This.Content()[nRandom]

		return anResult

		def ANumber()
			return ARandomNumber()

		def AnyRandomNumber()
			return ARandomNumber()

		def AnyNumber()
			return ARandomNumber()

	#-- Z/EXTENDED FORM

	def ARandomNumberZ()
		nRandom  = ARandomNumberBetween(1, This.NumberOfNumbers())
		aResult = [ This.Content()[nRandom], nRandom ]

		return aResult

	  #------------------------------------------------------------------#
	 #  GETTING A RANDOM NUMBER FROM THE LIST LESS THAN A GIVEN NUMBER  #
	#------------------------------------------------------------------#

	def ANumberLessThan(nNumber)
		nResult = This.NumbersLessThanQR(nNumber, :stzListOfNumbers).ARandomNumber()
		return nResult

		#< @FunctionAlternativeForms

		def AnyNumberLessThan(nNumber)
			return This.ANumberLessThan(nNumber)

		def NumberLessThan(nNumber)
			return This.ANumberLessThan(nNumber)

		#--

		def ARandomNumberLessThan(nNumber)
			return This.ANumberLessThan(nNumber)

		def RandomNumberLessThan(nNumber)
			return This.ANumberLessThan(nNumber)

		#==

		def ANumberSmallerThan(nNumber)
			return This.ANumberLessThan(nNumber)

		def AnyNumberSmallerThan(nNumber)
			return This.ANumberLessThan(nNumber)

		def NumberSmallerThan(nNumber)
			return This.ANumberLessThan(nNumber)

		#--

		def ARandomNumberSmallerThan(nNumber)
			return This.ANumberLessThan(nNumber)

		def RandomNumberSmallerThan(nNumber)
			return This.ANumberLessThan(nNumber)

		#>

	#-- Z/EXTENDED FORM

	def ANumberLessThanZ(nNumber)
		aResult = This.NumbersLessThanQR(nNumber, :stzListOfNumbers).ARandomNumberZ()

		return aResult

		#< @FunctionAlternativeForms

		def AnyNumberLessThanZ(nNumber)
			return This.ANumberLessThanZ(nNumber)

		def NumberLessThanZ(nNumber)
			return This.ANumberLessThanZ(nNumber)

		#--

		def ARandomNumberLessThanZ(nNumber)
			return This.ANumberLessThanZ(nNumber)

		def RandomNumberLessThanZ(nNumber)
			return This.ANumberLessThanZ(nNumber)

		#==

		def ANumberSmallerThanZ(nNumber)
			return This.ANumberLessThanZ(nNumber)

		def AnyNumberSmallerThanZ(nNumber)
			return This.ANumberLessThanZ(nNumber)

		def NumberSmallerThanZ(nNumber)
			return This.ANumberLessThanZ(nNumber)

		#--

		def ARandomNumberSmallerThanZ(nNumber)
			return This.ANumberLessThanZ(nNumber)

		def RandomNumberSmallerThanZ(nNumber)
			return This.ANumberLessThanZ(nNumber)

		#>

	  #---------------------------------------------------------------------#
	 #  GETTING A RANDOM NUMBER FROM THE LIST GREATER THAN A GIVEN NUMBER  #
	#---------------------------------------------------------------------#

	def ANumberGreaterThan(nNumber)
		nResult = This.NumbersGreaterThanQR(nNumber, :stzListOfNumbers).ARandomNumber()
		return nResult

		#< @FunctionAlternativeForms

		def AnyNumberGreaterThan(nNumber)
			return This.ANumberGreaterThan(nNumber)

		def NumberGreaterThan(nNumber)
			return This.ANumberGreaterThan(nNumber)

		#--

		def ARandomNumberGreaterThan(nNumber)
			return This.ANumberGreaterThan(nNumber)

		def RandomNumberGreaterThan(nNumber)
			return This.ANumberGreaterThan(nNumber)

		#--

		def ANumberLargerThan(nNumber)
			return This.ANumberGreaterThan(nNumber)

		def AnyNumberLargerThan(nNumber)
			return This.ANumberGreaterThan(nNumber)

		def NumberLargerThan(nNumber)
			return This.ANumberGreaterThan(nNumber)

		def ARandomNumberLargerThan(nNumber)
			return This.ANumberGreaterThan(nNumber)

		def RandomNumberLargerThan(nNumber)
			return This.ANumberGreaterThan(nNumber)

		#--

		def AnyNumberMoreThan(nNumber)
			return This.ANumberGreaterThan(nNumber)

		def NumberMoreThan(nNumber)
			return This.ANumberGreaterThan(nNumber)

		def ARandomNumberMoreThan(nNumber)
			return This.ANumberGreaterThan(nNumber)

		def RandomNumberMoreThan(nNumber)
			return This.ANumberGreaterThan(nNumber)

		#>

	#-- Z/EXTENDED FORM

	def ANumberGreaterThanZ(nNumber)
		aResult = This.NumbersGreaterThanQR(nNumber, :stzListOfNumbers).ARandomNumberZ()
		return aResult

		#< @FunctionAlternativeForms

		def AnyNumberGreaterThanZ(nNumber)
			return This.ANumberGreaterThanZ(nNumber)

		def NumberGreaterThanZ(nNumber)
			return This.ANumberGreaterThanZ(nNumber)

		#--

		def ARandomNumberGreaterThanZ(nNumber)
			return This.ANumberGreaterThanZ(nNumber)

		def RandomNumberGreaterThanZ(nNumber)
			return This.ANumberGreaterThanZ(nNumber)

		#--

		def ANumberLargerThanZ(nNumber)
			return This.ANumberGreaterThanZ(nNumber)

		def AnyNumberLargerThanZ(nNumber)
			return This.ANumberGreaterThanZ(nNumber)

		def NumberLargerThanZ(nNumber)
			return This.ANumberGreaterThanZ(nNumber)

		def ARandomNumberLargerThanZ(nNumber)
			return This.ANumberGreaterThanZ(nNumber)

		def RandomNumberLargerThanZ(nNumber)
			return This.ANumberGreaterThanZ(nNumber)

		#--

		def AnyNumberMoreThanZ(nNumber)
			return This.ANumberGreaterThanZ(nNumber)

		def NumberMoreThanZ(nNumber)
			return This.ANumberGreaterThanZ(nNumber)

		def ARandomNumberMoreThanZ(nNumber)
			return This.ANumberGreaterThanZ(nNumber)

		def RandomNumberMoreThanZ(nNumber)
			return This.ANumberGreaterThanZ(nNumber)

		#>

	  #------------------------------------------------------------------#
	 #  GETTING ANY NUMBER BEFORE OR AFTER A GIVEN NUMBER (OTHER THAN)  #
	#==================================================================#

	def AnyNumberBeforeOrAfter(n) # Or AnyNumberOtherThan()
		if isList(n) and Q(n).IsPositionNamedParam()
			n = n[2]
		ok

		nPos = 0
		if random(1) = 0
			nPos = This.AnyNumberBefore(n)

		else
			nPos = This.AnyNumberAfter(n)
		ok

		nResult = This.Item(nPos)
		return nResult

		#< @FunctionAlternativeForms

		def AnyNumberAfterOrBefore(n)
			return This.AnyNumberBeforeOrAfter(n)

		def ANumberBeforeOrAfter(n)
			return This.AnyNumberBeforeOrAfter(n)

		def ANumberAfterOrBefore(n)
			return This.AnyNumberBeforeOrAfter(n)

		def NumberBeforeOrAfter(n)
			return This.AnyNumberBeforeOrAfter(n)

		def NumberAfterOrBefore(n)
			return This.AnyNumberBeforeOrAfter(n)

		#--

		def AnyNumberOtherThan(n)
			return This.AnyNumberBeforeOrAfter(n)

		def ANumberOtherThan(n)
			return This.AnyNumberBeforeOrAfter(n)

		def NumberOtherThan(n)
			return This.AnyNumberBeforeOrAfter(n)

		#--

		def ARandoomNumberAfterOrBefore(n)
			return This.AnyNumberBeforeOrAfter(n)

		def RandomNumberBeforeOrAfter(n)
			return This.AnyNumberBeforeOrAfter(n)

		def RandomNumberAfterOrBefore(n)
			return This.AnyNumberBeforeOrAfter(n)

		def ARandomNumberOtherThan(n)
			return This.AnyNumberBeforeOrAfter(n)

		def RandomNumberOtherThan(n)
			return This.AnyNumberBeforeOrAfter(n)

		#--
	
		def ANumberDifferentThan(pcChar)
			return This.AnyNumberBeforeOrAfter(pcChar)
	
		def ANumberDifferentFrom(pcChar)
			return This.AnyNumberBeforeOrAfter(pcChar)
	
		#--
	
		def NumberDifferentThan(pcChar)
			return This.AnyNumberBeforeOrAfter(pcChar)
	
		def NumberDifferentFrom(pcChar)
			return This.AnyNumberBeforeOrAfter(pcChar)
	
		#--
	
		def AnyNumberDifferentThan(pcChar)
			return This.AnyNumberBeforeOrAfter(pcChar)
	
		def AnyNumberDifferentFrom(pcChar)
			return This.AnyNumberBeforeOrAfter(pcChar)
	
		#--

		def ARandomNumberDifferentThan(pcChar)
			return This.AnyNumberBeforeOrAfter(pcChar)
	
		def ARandomNumberDifferentFrom(pcChar)
			return This.AnyNumberBeforeOrAfter(pcChar)
	
		def RandomNumberDifferentThan(pcChar)
			return This.AnyNumberBeforeOrAfter(pcChar)
	
		def RandomNumberDifferentFrom(pcChar)
			return This.AnyNumberBeforeOrAfter(pcChar)

		#>

	#-- Z/EXTENDED FORM

	def AnyNumberBeforeOrAfterZ(n) # Or AnyNumberOtherThan()
		if isList(n) and Q(n).IsPositionNamedParam()
			n = n[2]
		ok

		nPos = 0
		if random(1) = 0
			nPos = This.AnyNumberBefore(n)

		else
			nPos = This.AnyNumberAfter(n)
		ok

		aResult = [ This.Item(nPos), nPos ]
		return aResult

		#< @FunctionAlternativeForms

		def AnyNumberAfterOrBeforeZ(n)
			return This.AnyNumberBeforeOrAfterZ(n)

		def ANumberBeforeOrAfterZ(n)
			return This.AnyNumberBeforeOrAfterZ(n)

		def ANumberAfterOrBeforeZ(n)
			return This.AnyNumberBeforeOrAfterZ(n)

		def NumberBeforeOrAfterZ(n)
			return This.AnyNumberBeforeOrAfterZ(n)

		def NumberAfterOrBeforeZ(n)
			return This.AnyNumberBeforeOrAfterZ(n)

		#--

		def AnyNumberOtherThanZ(n)
			return This.AnyNumberBeforeOrAfterZ(n)

		def ANumberOtherThanZ(n)
			return This.AnyNumberBeforeOrAfterZ(n)

		def NumberOtherThanZ(n)
			return This.AnyNumberBeforeOrAfterZ(n)

		#--

		def ARandoomNumberAfterOrBeforeZ(n)
			return This.AnyNumberBeforeOrAfterZ(n)

		def RandomNumberBeforeOrAfterZ(n)
			return This.AnyNumberBeforeOrAfterZ(n)

		def RandomNumberAfterOrBeforeZ(n)
			return This.AnyNumberBeforeOrAfterZ(n)

		def ARandomNumberOtherThanZ(n)
			return This.AnyNumberBeforeOrAfterZ(n)

		def RandomNumberOtherThanZ(n)
			return This.AnyNumberBeforeOrAfterZ(n)

		#--
	
		def ANumberDifferentThanZ(pcChar)
			return This.AnyNumberBeforeOrAfterZ(pcChar)
	
		def ANumberDifferentFromZ(pcChar)
			return This.AnyNumberBeforeOrAfterZ(pcChar)
	
		#--
	
		def NumberDifferentThanZ(pcChar)
			return This.AnyNumberBeforeOrAfterZ(pcChar)
	
		def NumberDifferentFromZ(pcChar)
			return This.AnyNumberBeforeOrAfterZ(pcChar)
	
		#--
	
		def AnyNumberDifferentThanZ(pcChar)
			return This.AnyNumberBeforeOrAfterZ(pcChar)
	
		def AnyNumberDifferentFromZ(pcChar)
			return This.AnyNumberBeforeOrAfterZ(pcChar)
	
		#--

		def ARandomNumberDifferentThanZ(pcChar)
			return This.AnyNumberBeforeOrAfterZ(pcChar)
	
		def ARandomNumberDifferentFromZ(pcChar)
			return This.AnyNumberBeforeOrAfterZ(pcChar)
	
		def RandomNumberDifferentThanZ(pcChar)
			return This.AnyNumberBeforeOrAfterZ(pcChar)
	
		def RandomNumberDifferentFromZ(pcChar)
			return This.AnyNumberBeforeOrAfterZ(pcChar)

		#>

	  #--------------------------------------------------------#
	 #  GETTING ANY NUMBER BEFORE A GIVEN NUMBER OR POSITION  #
	#--------------------------------------------------------#

	def AnyNumberBefore(n)
		if isList(n) and Q(n).IsPositionNamedParam(n)
			return This.AnyNumberBeforePosition(n)
		ok

		if NOT isNumber(n)
			StzRaise("Incorrect param type! n must be a number.")
		ok

		nPos = ring_find( This.Content(), n)
		nResult = This.AnyNumberBeforePosition(nPos)

		return nResult

		#< @FunctionAlternativeForms

		def ANumberBefore(n)
			return This.AnyNumberBefore(n)

		def NumberBefore(n)
			return This.AnyNumberBefore(n)

		def ARandomNumberBefore(n)
			return This.AnyNumberBefore(n)

		def RandomNumberBefore(n)
			return This.AnyNumberBefore(n)

		#>

	#-- Z/EXTENDED FORM

	def AnyNumberBeforeZ(n)
		if isList(n) and Q(n).IsPositionNamedParam(n)
			return This.AnyNumberBeforePosition(n)
		ok

		if NOT isNumber(n)
			StzRaise("Incorrect param type! n must be a number.")
		ok

		nPos = ring_find( This.Content(), n)
		aResult = This.AnyNumberBeforePositionZ(nPos)

		return aResult

		#< @FunctionAlternativeForms

		def ANumberBeforeZ(n)
			return This.AnyNumberBeforeZ(n)

		def NumberBeforeZ(n)
			return This.AnyNumberBeforeZ(n)

		def ARandomNumberBeforeZ(n)
			return This.AnyNumberBeforeZ(n)

		def RandomNumberBeforeZ(n)
			return This.AnyNumberBeforeZ(n)

		#>

	  #----------------------------------------------#
	 #  GETTING ANY NUMBER BEFORE A GIVEN POSITION  #
	#----------------------------------------------#

	def AnyNumberBeforePosition(n)
		if NOT isNumber(n)
			StzRaise("Incorrect param type! n must be a number.")
		ok

		nLen = This.NumberOfNumbers()
		
		if n <= 1 or n > nLen
			StzRaise("Index out of range!")
		ok

		if n = 2
			return This.Number(1)
		ok

		nRandom = random(n - 1)
		if nRandom = 0
			nRandom = 1
		ok

		nResult = This.Number(nRandom)

		return nResult

		#< @FunctionAlternativeForms

		def ANumberBeforePosition(n)
			return This.AnyNumberBeforePosition(n)

		def NumberBeforePosition(n)
			return This.AnyNumberBeforePosition(n)

		def ARandomNumberBeforePosition(n)
			return This.AnyNumberBeforePosition(n)

		def RandomNumberBeforePosition(n)
			return This.AnyNumberBeforePosition(n)

		#>

	#-- Z/EXTENDED FORM

	def AnyNumberBeforePositionZ(n)
		if NOT isNumber(n)
			StzRaise("Incorrect param type! n must be a number.")
		ok

		nLen = This.NumberOfNumbers()
		
		if n <= 1 or n > nLen
			StzRaise("Index out of range!")
		ok

		if n = 2
			return This.Number(1)
		ok

		nRandom = random(n - 1)
		if nRandom = 0
			nRandom = 1
		ok

		aResult = [ This.Number(nRandom), nRandom ]

		return aResult

		#< @FunctionAlternativeForms

		def ANumberBeforePositionZ(n)
			return This.AnyNumberBeforePositionZ(n)

		def NumberBeforePositionZ(n)
			return This.AnyNumberBeforePositionZ(n)

		def ARandomNumberBeforePositionZ(n)
			return This.AnyNumberBeforePositionZ(n)

		def RandomNumberBeforePositionZ(n)
			return This.AnyNumberBeforePositionZ(n)

		#>

	  #-------------------------------------------------------#
	 #  GETTING ANY NUMBER AFTER A GIVEN NUMBER OR POSITION  #
	#-------------------------------------------------------#

	def AnyNumberAfter(n)
		if isList(n) and Q(n).IsPositionNamedParam(n)
			return This.AnyNumberAfterPosition(n)
		ok

		if NOT isNumber(n)
			StzRaise("Incorrect param type! n must be a number.")
		ok

		nPos = ring_find( ring_reverse(This.Content()), n )
		nResult = This.AnyNumberAfterPosition(nPos)

		return nResult

		#< @FunctionAlternativeForms

		def ANumberAfter(n)
			return This.AnyNumberAfter(n)

		def NumberAfter(n)
			return This.AnyNumberAfter(n)

		def ARandomNumberAfter(n)
			return This.AnyNumberAfter(n)

		def RandomNumberAfter(n)
			return This.AnyNumberAfter(n)

		#>

	# Z/EXTENDED FORM

	def AnyNumberAfterZ(n)
		if isList(n) and Q(n).IsPositionNamedParam(n)
			return This.AnyNumberAfterPosition(n)
		ok

		if NOT isNumber(n)
			StzRaise("Incorrect param type! n must be a number.")
		ok

		nPos = ring_find( ring_reverse(This.Content()), n )
		aResult = This.AnyNumberAfterPositionZ(nPos)

		return aResult

		#< @FunctionAlternativeForms

		def ANumberAfterZ(n)
			return This.AnyNumberAfterZ(n)

		def NumberAfterZ(n)
			return This.AnyNumberAfterZ(n)

		def ARandomNumberAfterZ(n)
			return This.AnyNumberAfterZ(n)

		def RandomNumberAfterZ(n)
			return This.AnyNumberAfterZ(n)

		#>

	  #---------------------------------------------#
	 #  GETTING ANY NUMBER AFETR A GIVEN POSITION  #
	#---------------------------------------------#

	def AnyNumberAfterPosition(n)
		if NOT isNumber(n)
			StzRaise("Incorrect param type! n must be a number.")
		ok

		nLen = This.NumberOfNumbers()

		if n < 1 or n >= nLen
			StzRaise("Index out of range!")
		ok

		if n = nLen - 1
			return This.Number(nLen)
		ok

		n--
		nRandom = random(n)
		if nRandom = 0
			nRandom = 1
		ok

		nResult = This.Number(n + nRandom - 1)

		return nResult

		#< @FunctionAlternativeForms

		def ANumberAfterPosition(n)
			return This.AnyNumberAfterPosition(n)

		def NumberAfterPosition(n)
			return This.AnyNumberAfterPosition(n)

		def ARandomNumberAfterPosition(n)
			return This.AnyNumberAfterPosition(n)

		def RandomNumberAfterPosition(n)
			return This.AnyNumberAfterPosition(n)

		#>

	# Z/EXTENDED FORM

	def AnyNumberAfterPositionZ(n)
		if NOT isNumber(n)
			StzRaise("Incorrect param type! n must be a number.")
		ok

		nLen = This.NumberOfNumbers()

		if n < 1 or n >= nLen
			StzRaise("Index out of range!")
		ok

		if n = nLen - 1
			return This.Number(nLen)
		ok

		n--
		nRandom = random(n)
		if nRandom = 0
			nRandom = 1
		ok

		nPos = n + nRandom - 1
		aResult = [ This.Number(nPos), nPos ]

		return aResult

		#< @FunctionAlternativeForms

		def ANumberAfterPositionZ(n)
			return This.AnyNumberAfterPositionZ(n)

		def NumberAfterPositionZ(n)
			return This.AnyNumberAfterPositionZ(n)

		def ARandomNumberAfterPositionZ(n)
			return This.AnyNumberAfterPositionZ(n)

		def RandomNumberAfterPositionZ(n)
			return This.AnyNumberAfterPositionZ(n)

		#>

	  #--------------------------------------------------------------------#
	 #  GETTING A RANDOM NUMBER FROM THE LISTS BETWEEN TOW OTHER NUMBERS  #
	#--------------------------------------------------------------------#

	def AnyNumberBetween(n1, n2)
		if isList(n1) and Q(n1).IsPositionOrPositionsNamedParam()
			return AnyNumberBetweenPositions(n1[2], n2)
		ok

		if isList(n2) and Q(n2).IsAndNamedParam()
			n2 = n2[2]
		ok

		aContent = This.Content()
		nLen = len(aContent)

		anNumbers = This.NumbersBetween(n1, n2)
		nResult = ARandomNumberIn(anNumbers) #TODO: Add ARandomItemIn() function to stzRandomFunctions.ring

		return nResult

		#< @FunctionAlternativeForms

		def ANumberBetween(n1, n2)
			return This.AnyNumberBetween(n1, n2)

		def NumberBetween(n1, n2)
			return This.AnyNumberBetween(n1, n2)

		#--

		def ARandomNumberBetween(n1, n2)
			return This.AnyNumberBetween(n1, n2)

		def RandomNumberBetween(n1, n2)
			return This.AnyNumberBetween(n1, n2)

		#>

	#-- Z/EXTENDED FORM

	def AnyNumberBetweenZ(n1, n2)
		if isList(n1) and Q(n1).IsPositionOrPositionsNamedParam()
			return AnyNumberBetweenPositions(n1[2], n2)
		ok

		if isList(n2) and Q(n2).IsAndNamedParam()
			n2 = n2[2]
		ok

		aContent = This.Content()
		nLen = len(aContent)

		anNumbers = This.NumbersBetween(n1, n2)
		aResult = ARandomNumberInZ(anNumbers)
		
		return aResult

		#< @FunctionAlternativeForms

		def ANumberBetweenZ(n1, n2)
			return This.AnyNumberBetweenZ(n1, n2)

		def NumberBetweenZ(n1, n2)
			return This.AnyNumberBetweenZ(n1, n2)

		#--

		def ARandomNumberBetweenZ(n1, n2)
			return This.AnyNumberBetweenZ(n1, n2)

		def RandomNumberBetweenZ(n1, n2)
			return This.AnyNumberBetweenZ(n1, n2)

		#>

	  #---------------------------------------------------------------------------------------#
	 #  GETTING A RANDOM NUMBER FROM THE LISTS BETWEEN TOW OTHER NUMBERS -- INCLUDING BOUNDS #
	#---------------------------------------------------------------------------------------#

	def AnyNumberBetweenIB(n1, n2)
		if isList(n1) and Q(n1).IsPositionOrPositionsNamedParam()
			return AnyNumberBetweenPositions(n1[2], n2)
		ok

		if isList(n2) and Q(n2).IsAndNamedParam()
			n2 = n2[2]
		ok

		aContent = This.Content()
		nLen = len(aContent)

		anNumbers = This.NumbersBetweenIB(n1, n2)
		nResult = ARandomNumberIn(anNumbers)

		return nResult

		#< @FunctionAlternativeForms

		def ANumberBetweenIB(n1, n2)
			return This.AnyNumberBetweenIB(n1, n2)

		def NumberBetweenIB(n1, n2)
			return This.AnyNumberBetweenIB(n1, n2)

		#--

		def AnyNumberBetweenXT(n1, n2)
			return This.AnyNumberBetweenIB(n1, n2)

		def ANumberBetweenXT(n1, n2)
			return This.AnyNumberBetweenIB(n1, n2)

		def NumberBetweenXT(n1, n2)
			return This.AnyNumberBetweenIB(n1, n2)

		#--

		def ARandomNumberBetweenIB(n1, n2)
			return This.AnyNumberBetweenIB(n1, n2)

		def RandomNumberBetweenIB(n1, n2)
			return This.AnyNumberBetweenIB(n1, n2)

		def ARandomNumberBetweenXT(n1, n2)
			return This.AnyNumberBetweenIB(n1, n2)

		def RandomNumberBetweenXT(n1, n2)
			return This.AnyNumberBetweenIB(n1, n2)

		#>

	#-- Z/EXTENDED FORM

	def AnyNumberBetweenIBZ(n1, n2)
		if isList(n1) and Q(n1).IsPositionOrPositionsNamedParam()
			return AnyNumberBetweenPositions(n1[2], n2)
		ok

		if isList(n2) and Q(n2).IsAndNamedParam()
			n2 = n2[2]
		ok

		aContent = This.Content()
		nLen = len(aContent)

		anNumbers = This.NumbersBetweenIB(n1, n2)
		aResult = ARandomNumberInZ(anNumbers)

		return aResult

		#< @FunctionAlternativeForms

		def ANumberBetweenIBZ(n1, n2)
			return This.AnyNumberBetweenIBZ(n1, n2)

		def NumberBetweenIBZ(n1, n2)
			return This.AnyNumberBetweenIBZ(n1, n2)

		#--

		def AnyNumberBetweenXTZ(n1, n2)
			return This.AnyNumberBetweenIBZ(n1, n2)

		def ANumberBetweenXTZ(n1, n2)
			return This.AnyNumberBetweenIBZ(n1, n2)

		def NumberBetweenXTZ(n1, n2)
			return This.AnyNumberBetweenIBZ(n1, n2)

		#--

		def ARandomNumberBetweenIBZ(n1, n2)
			return This.AnyNumberBetweenIBZ(n1, n2)

		def RandomNumberBetweenIBZ(n1, n2)
			return This.AnyNumberBetweenIBZ(n1, n2)

		def ARandomNumberBetweenXTZ(n1, n2)
			return This.AnyNumberBetweenIBZ(n1, n2)

		def RandomNumberBetweenXTZ(n1, n2)
			return This.AnyNumberBetweenIBZ(n1, n2)

		#>

	  #------------------------------------------------------------------------#
	 #  GETTING A RANDOM NUMBER FROM THE LISTS NOT BETWEEN TWO OTHER NUMBERS  #
	#-----------------------------------------------------------------------#

	def AnyNumberNotBetween(n1, n2)
		if isList(n1) and Q(n1).IsPositionOrPositionsNamedParam()
			return AnyNumberBetweenPositions(n1[2], n2)
		ok

		if isList(n2) and Q(n2).IsAndNamedParam()
			n2 = n2[2]
		ok

		aContent = This.Content()
		nLen = len(aContent)

		anNumbers = This.NumbersNotBetween(n1, n2) #TODO
		nResult = ARandomNumberIn(anNumbers)

		return nResult

		#< @FunctionAlternativeForms

		def ANumberNotBetween(n1, n2)
			return This.AnyNumberNotBetween(n1, n2)

		def NumberNotBetween(n1, n2)
			return This.AnyNumberNotBetween(n1, n2)

		#--

		def ARandomNumberNotBetween(n1, n2)
			return This.AnyNumberNotBetween(n1, n2)

		def RandomNumberNotBetween(n1, n2)
			return This.AnyNumberNotBetween(n1, n2)

		#>

	#-- Z/EXTENDED FORM

	def AnyNumberNotBetweenZ(n1, n2)
		if isList(n1) and Q(n1).IsPositionOrPositionsNamedParam()
			return AnyNumberBetweenPositions(n1[2], n2)
		ok

		if isList(n2) and Q(n2).IsAndNamedParam()
			n2 = n2[2]
		ok

		aContent = This.Content()
		nLen = len(aContent)

		anNumbers = This.NumbersNotBetween(n1, n2)
		aResult = ARandomNumberInZ(anNumbers)

		return aResult

		#< @FunctionAlternativeForms

		def ANumberNotBetweenZ(n1, n2)
			return This.AnyNumberNotBetweenZ(n1, n2)

		def NumberNotBetweenZ(n1, n2)
			return This.AnyNumberNotBetweenZ(n1, n2)

		#--

		def ARandomNumberNotBetweenZ(n1, n2)
			return This.AnyNumberNotBetweenZ(n1, n2)

		def RandomNumberNotBetweenZ(n1, n2)
			return This.AnyNumberNotBetweenZ(n1, n2)

		#>

	  #-------------------------------------------------------------------------------------------#
	 #  GETTING A RANDOM NUMBER FROM THE LISTS NOT BETWEEN TWO OTHER NUMBERS -- INCLUDING BOUNDS #
	#-------------------------------------------------------------------------------------------#

	def AnyNumberNotBetweenIB(n1, n2)
		if isList(n1) and Q(n1).IsPositionOrPositionsNamedParam()
			return AnyNumberBetweenPositions(n1[2], n2)
		ok

		if isList(n2) and Q(n2).IsAndNamedParam()
			n2 = n2[2]
		ok

		aContent = This.Content()
		nLen = len(aContent)

		anNumbers = This.NumbersNotBetweenIB(n1, n2) #TODO
		nResult = ARandomNumberIn(anNumbers) #TODO: Add ARandomItemIn() function to stzRandomFunctions.ring

		return nResult

		#< @FunctionAlternativeForms

		def ANumberNotBetweenIB(n1, n2)
			return This.AnyNumberNotBetweenIB(n1, n2)

		def NumberNotBetweenIB(n1, n2)
			return This.AnyNumberNotBetweenIB(n1, n2)

		#--

		def AnyNumberNotBetweenXT(n1, n2)
			return This.AnyNumberNotBetweenIB(n1, n2)

		def ANumberNotBetweenXT(n1, n2)
			return This.AnyNumberNotBetweenIB(n1, n2)

		def NumberNotBetweenXT(n1, n2)
			return This.AnyNumberNotBetweenIB(n1, n2)

		#==

		def ARandomNumberNotBetweenIB(n1, n2)
			return This.AnyNumberNotBetweenIB(n1, n2)

		def RandomNumberNotBetweenIB(n1, n2)
			return This.AnyNumberNotBetweenIB(n1, n2)

		#--

		def ARandomNumberNotBetweenXT(n1, n2)
			return This.AnyNumberNotBetweenIB(n1, n2)

		def RandomNumberNotBetweenXT(n1, n2)
			return This.AnyNumberNotBetweenIB(n1, n2)

		#>

	#-- Z/EXTENDED FORM

	def AnyNumberNotBetweenIBZ(n1, n2)
		if isList(n1) and Q(n1).IsPositionOrPositionsNamedParam()
			return AnyNumberBetweenPositions(n1[2], n2)
		ok

		if isList(n2) and Q(n2).IsAndNamedParam()
			n2 = n2[2]
		ok

		aContent = This.Content()
		nLen = len(aContent)

		anNumbers = This.NumbersNotBetweenIB(n1, n2)
		aResult   = ARandomNumberInZ(anNumbers)

		return aResult

		#< @FunctionAlternativeForms

		def ANumberNotBetweenIBZ(n1, n2)
			return This.AnyNumberNotBetweenIBZ(n1, n2)

		def NumberNotBetweenIBZ(n1, n2)
			return This.AnyNumberNotBetweenIBZ(n1, n2)

		#--

		def AnyNumberNotBetweenXTZ(n1, n2)
			return This.AnyNumberNotBetweenIBZ(n1, n2)

		def ANumberNotBetweenXTZ(n1, n2)
			return This.AnyNumberNotBetweenIBZ(n1, n2)

		def NumberNotBetweenXTZ(n1, n2)
			return This.AnyNumberNotBetweenIBZ(n1, n2)

		#==

		def ARandomNumberNotBetweenIBZ(n1, n2)
			return This.AnyNumberNotBetweenIBZ(n1, n2)

		def RandomNumberNotBetweenIBZ(n1, n2)
			return This.AnyNumberNotBetweenIBZ(n1, n2)

		#--

		def ARandomNumberNotBetweenXTZ(n1, n2)
			return This.AnyNumberNotBetweenIBZ(n1, n2)

		def RandomNumberNotBetweenXTZ(n1, n2)
			return This.AnyNumberNotBetweenIBZ(n1, n2)

		#>

	  #----------------------------------------------------------------------#
	 #  GETTING A RANDOM NUMBER FROM THE LISTS BETWEEN TOW OTHER POSITIONS  #
	#----------------------------------------------------------------------#

	def AnyNumberBetweenPositions(n1, n2)
		if isList(n2) and Q(n2).IsAndNamedParam()
			n2 = n2[2]
		ok

		if NOT @BothAreNumbers(n1, n2)
			StzRaise("Incorrect param types! n1 and n2 must both be numbers.")
		ok

		nMin = Min([ n1, n2 ])
		nMax = Max([ n1, n2 ])

		anPos = nMin : nMax
		nRandom = AnyNumberIn(anPos)
		nResult = This.Number(nRandom)

		return nResult

		#< @FunctionAlternativeForms

		def RandomNumberBetweenPositions(n1, n2)
			return This.AnyNumberBetweenPositions(n1, n2)

		def ARandomNumberBetweenPositions(n1, n2)
			return This.AnyNumberBetweenPositions(n1, n2)

		def ANumberBetweenPositions(n1, n2)
			return This.AnyNumberBetweenPositions(n1, n2)

		def NumberBetweenPositions(n1, n2)
			return This.AnyNumberBetweenPositions(n1, n2)

		#--

		def RandomNumberInSection(n1, n2)
			return This.AnyNumberBetweenPositions(n1, n2)

		def ARandomNumberInSection(n1, n2)
			return This.AnyNumberInSection(n1, n2)

		def ANumberInSection(n1, n2)
			return This.AnyNumberBetweenPositions(n1, n2)

		def NumberInSection(n1, n2)
			return This.AnyNumberBetweenPositions(n1, n2)

		def AnyNumberInSection(n1, n2)
			return This.AnyNumberBetweenPositions(n1, n2)

		#>

	#-- Z/EXTENDED FORM

	def AnyNumberBetweenPositionsZ(n1, n2)
		if isList(n2) and Q(n2).IsAndNamedParam()
			n2 = n2[2]
		ok

		if NOT @BothAreNumbers(n1, n2)
			StzRaise("Incorrect param types! n1 and n2 must both be numbers.")
		ok

		nMin = Min([ n1, n2 ])
		nMax = Max([ n1, n2 ])

		anPos = nMin : nMax
		nRandom = AnyNumberIn(anPos)
		aResult = [ This.Number(nRandom), nRandom ]

		return aResult

		#< @FunctionAlternativeForms

		def RandomNumberBetweenPositionsZ(n1, n2)
			return This.AnyNumberBetweenPositionsZ(n1, n2)

		def ARandomNumberBetweenPositionsZ(n1, n2)
			return This.AnyNumberBetweenPositionsZ(n1, n2)

		def ANumberBetweenPositionsZ(n1, n2)
			return This.AnyNumberBetweenPositionsZ(n1, n2)

		def NumberBetweenPositionsZ(n1, n2)
			return This.AnyNumberBetweenPositionsZ(n1, n2)

		#--

		def RandomNumberInSectionZ(n1, n2)
			return This.AnyNumberBetweenPositionsZ(n1, n2)

		def ARandomNumberInSectionZ(n1, n2)
			return This.AnyNumberInSectionZ(n1, n2)

		def ANumberInSectionZ(n1, n2)
			return This.AnyNumberBetweenPositionsZ(n1, n2)

		def NumberInSectionZ(n1, n2)
			return This.AnyNumberBetweenPositionsZ(n1, n2)

		def AnyNumberInSectionZ(n1, n2)
			return This.AnyNumberBetweenPositionsZ(n1, n2)

		#>

	  #--------------------------------------------------------------------------#
	 #  GETTING A RANDOM NUMBER FROM THE LISTS NOT BETWEEN TWO OTHER POSITIONS  #
	#--------------------------------------------------------------------------#

	def AnyNumberNotBetweenPositions(n1, n2)
		if isList(n2) and Q(n2).IsAndNamedParam()
			n2 = n2[2]
		ok

		if NOT @BothAreNumbers(n1, n2)
			StzRaise("Incorrect param types! n1 and n2 must both be numbers.")
		ok

		nMin = Min([ n1, n2 ])
		nMax = Max([ n1, n2 ])

		anPos = nMin : nMax
		nRandom = AnyNumberNotIn(anPos) #TODO
		nResult = This.Number(nRandom)

		return nResult

		#< @FunctionAlternativeForms

		def RandomNumberNotBetweenPositions(n1, n2)
			return This.AnyNumberNotBetweenPositions(n1, n2)

		def ARandomNumberNotBetweenPositions(n1, n2)
			return This.AnyNumberNotBetweenPositions(n1, n2)

		def ANumberNotBetweenPositions(n1, n2)
			return This.AnyNumberNotBetweenPositions(n1, n2)

		def NumberNotBetweenPositions(n1, n2)
			return This.AnyNumberNotBetweenPositions(n1, n2)

		#--

		def RandomNumberNotInSection(n1, n2)
			return This.AnyNumberNotBetweenPositions(n1, n2)

		def ARandomNumberNotInSection(n1, n2)
			return This.AnyNumberNotInSection(n1, n2)

		def ANumberNotInSection(n1, n2)
			return This.AnyNumberNotBetweenPositions(n1, n2)

		def NumberNotInSection(n1, n2)
			return This.AnyNumberNotBetweenPositions(n1, n2)

		def AnyNumberNotInSection(n1, n2)
			return This.AnyNumberNotBetweenPositions(n1, n2)

		#--

		def RandomNumberOutsideSection(n1, n2)
			return This.AnyNumberNotBetweenPositions(n1, n2)

		def ARandomNumberOutsideSection(n1, n2)
			return This.AnyNumberNotInSection(n1, n2)

		def ANumberOutsideSection(n1, n2)
			return This.AnyNumberNotBetweenPositions(n1, n2)

		def NumberOutsideSection(n1, n2)
			return This.AnyNumberNotBetweenPositions(n1, n2)

		def AnyNumberOutsideSection(n1, n2)
			return This.AnyNumberNotBetweenPositions(n1, n2)

		#>

	#-- Z/EXTENDED FROM

	def AnyNumberNotBetweenPositionsZ(n1, n2)
		if isList(n2) and Q(n2).IsAndNamedParam()
			n2 = n2[2]
		ok

		if NOT @BothAreNumbers(n1, n2)
			StzRaise("Incorrect param types! n1 and n2 must both be numbers.")
		ok

		nMin = Min([ n1, n2 ])
		nMax = Max([ n1, n2 ])

		anPos = nMin : nMax
		nRandom = AnyNumberNotIn(anPos)
		aResult = [ This.Number(nRandom), nRandom ]

		return aResult

		#< @FunctionAlternativeForms

		def RandomNumberNotBetweenPositionsZ(n1, n2)
			return This.AnyNumberNotBetweenPositionsZ(n1, n2)

		def ARandomNumberNotBetweenPositionsZ(n1, n2)
			return This.AnyNumberNotBetweenPositionsZ(n1, n2)

		def ANumberNotBetweenPositionsZ(n1, n2)
			return This.AnyNumberNotBetweenPositionsZ(n1, n2)

		def NumberNotBetweenPositionsZ(n1, n2)
			return This.AnyNumberNotBetweenPositionsZ(n1, n2)

		#--

		def RandomNumberNotInSectionZ(n1, n2)
			return This.AnyNumberNotBetweenPositionsZ(n1, n2)

		def ARandomNumberNotInSectionZ(n1, n2)
			return This.AnyNumberNotInSectionZ(n1, n2)

		def ANumberNotInSectionZ(n1, n2)
			return This.AnyNumberNotBetweenPositionsZ(n1, n2)

		def NumberNotInSectionZ(n1, n2)
			return This.AnyNumberNotBetweenPositionsZ(n1, n2)

		def AnyNumberNotInSectionZ(n1, n2)
			return This.AnyNumberNotBetweenPositionsZ(n1, n2)

		#--

		def RandomNumberOutsideSectionZ(n1, n2)
			return This.AnyNumberNotBetweenPositionsZ(n1, n2)

		def ARandomNumberOutsideSectionZ(n1, n2)
			return This.AnyNumberNotInSectionZ(n1, n2)

		def ANumberOutsideSectionZ(n1, n2)
			return This.AnyNumberNotBetweenPositionsZ(n1, n2)

		def NumberOutsideSectionZ(n1, n2)
			return This.AnyNumberNotBetweenPositionsZ(n1, n2)

		def AnyNumberOutsideSectionZ(n1, n2)
			return This.AnyNumberNotBetweenPositionsZ(n1, n2)

		#>

	  #---------------------------------------------------#
	 #  GETTING A RANDOM NUMBER OUSIDE A GIVEN POSITION  #
	#---------------------------------------------------#

	def AnyNumberOutsidePosition(n)
		anPositons = Q(1 : This.NumberOfItems()) - n
		nRandom = AnyNumberIn(anPos)
		nResult = This.Number(nRandom)

		return nResult

		#< @FunctionAlternativeForms

		def ANumberOutsidePosition(n)
			return This.AnyNumberOutsidePosition(n)

		def NumberOutsidePosition(n)
			return This.AnyNumberOutsidePosition(n)

		#--

		def AnyNumberBeforeOrAfterPosition(n)
			return This.AnyNumberOutsidePosition(n)

		def AnyNumberAfterOrBeforePosition(n)
			return This.AnyNumberOutsidePosition(n)

		def ANumberBeforeOrAfterPosition(n)
			return This.AnyNumberOutsidePosition(n)

		def ANumberAfterOrBeforePosition(n)
			return This.AnyNumberOutsidePosition(n)

		def NumberBeforeOrAfterPosition(n)
			return This.AnyNumberOutsidePosition(n)

		def NumberAfterOrBeforePosition(n)
			return This.AnyNumberOutsidePosition(n)

		#--

		def ARandomNumberOutsidePosition(n)
			return This.AnyNumberOutsidePosition(n)

		def RandomNumberOutsidePosition(n)
			return This.AnyNumberOutsidePosition(n)

		def ARandomNumberBeforeOrAfterPosition(n)
			return This.AnyNumberOutsidePosition(n)

		def ARandomNumberAfterOrBeforePosition(n)
			return This.AnyNumberOutsidePosition(n)

		def RandomNumberBeforeOrAfterPosition(n)
			return This.AnyNumberOutsidePosition(n)

		def RandomNumberAfterOrBeforePosition(n)
			return This.AnyNumberOutsidePosition(n)

		#--

		def ARandomNumberNotAtPosition(n)
			return This.AnyNumberOutsidePosition(n)

		def RandomNumberNotAtPosition(n)
			return This.AnyNumberOutsidePosition(n)

		#--

		def ARandomNumberNotAt(n)
			return This.AnyNumberOutsidePosition(n)

		def RandomNumberNotAt(n)
			return This.AnyNumberOutsidePosition(n)

		#>

	# Z/EXTENDED FORM

	def AnyNumberOutsidePositionZ(n)
		anPositons = Q(1 : This.NumberOfItems()) - n
		nRandom = AnyNumberIn(anPos)
		aResult = [ This.Number(nRandom), nRandom ]

		return aResult

		#< @FunctionAlternativeForms

		def ANumberOutsidePositionZ(n)
			return This.AnyNumberOutsidePositionZ(n)

		def NumberOutsidePositionZ(n)
			return This.AnyNumberOutsidePositionZ(n)

		#--

		def AnyNumberBeforeOrAfterPositionZ(n)
			return This.AnyNumberOutsidePositionZ(n)

		def AnyNumberAfterOrBeforePositionZ(n)
			return This.AnyNumberOutsidePositionZ(n)

		def ANumberBeforeOrAfterPositionZ(n)
			return This.AnyNumberOutsidePositionZ(n)

		def ANumberAfterOrBeforePositionZ(n)
			return This.AnyNumberOutsidePositionZ(n)

		def NumberBeforeOrAfterPositionZ(n)
			return This.AnyNumberOutsidePositionZ(n)

		def NumberAfterOrBeforePositionZ(n)
			return This.AnyNumberOutsidePositionZ(n)

		#--

		def ARandomNumberOutsidePositionZ(n)
			return This.AnyNumberOutsidePositionZ(n)

		def RandomNumberOutsidePositionZ(n)
			return This.AnyNumberOutsidePositionZ(n)

		def ARandomNumberBeforeOrAfterPositionZ(n)
			return This.AnyNumberOutsidePositionZ(n)

		def ARandomNumberAfterOrBeforePositionZ(n)
			return This.AnyNumberOutsidePositionZ(n)

		def RandomNumberBeforeOrAfterPositionZ(n)
			return This.AnyNumberOutsidePositionZ(n)

		def RandomNumberAfterOrBeforePositionZ(n)
			return This.AnyNumberOutsidePositionZ(n)

		#--

		def ARandomNumberNotAtPositionZ(n)
			return This.AnyNumberOutsidePositionZ(n)

		def RandomNumberNotAtPositionZ(n)
			return This.AnyNumberOutsidePositionZ(n)

		#--

		def ARandomNumberNotAtZ(n)
			return This.AnyNumberOutsidePositionZ(n)

		def RandomNumberNotAtZ(n)
			return This.AnyNumberOutsidePositionZ(n)

		#>

	  #------------------------------------------#
	 #  GETTING N RANDOM NUMBERS FROM THE LIST  #
	#------------------------------------------#

	def NRandomNumbers(n)

		# Checking param n and the size of the list of numbers

		if NOT isNumber(n)
			StzRaise("Incorrect param type! n must be a number.")
		ok
		if n <= 0
			StzRaise("Can't proceed because n must be a positive number greater then 0!")
		ok

		nLen = This.NumberOfNumbers()
		if nLen = 0
			StzRaise("Can't get random numbers because the list is empty!")
		ok

		if n > nLen
			StzRaise("Can't proceed because n must be a number equal or less then the size of the list ("+ nLen +")!")
		ok

		# Doing the job

		anResult = []

		for i = 1 to n
			anResult + ARandomNumberBetween(1, nLen)
		next

		return anResult

		#< @FunctionAlternativeForms

		def RandomNNumbers(n)
			return This.NRandomNumbers(n)

		def NNumbers(n)
			return This.NRandomNumbers(n)

		#>

	# Z/EXTENDED FORM

	def NRandomNumbersZ(n)

		# Checking param n and the size of the list of numbers

		if NOT isNumber(n)
			StzRaise("Incorrect param type! n must be a number.")
		ok
		if n <= 0
			StzRaise("Can't proceed because n must be a positive number greater then 0!")
		ok

		nLen = This.NumberOfNumbers()
		if nLen = 0
			StzRaise("Can't get random numbers because the list is empty!")
		ok

		if n > nLen
			StzRaise("Can't proceed because n must be a number equal or less then the size of the list ("+ nLen +")!")
		ok

		# Doing the job

		aResult = []

		for i = 1 to n
			aResult + ARandomNumberBetweenZ(1, nLen)
		next

		return aResult

		#< @FunctionAlternativeForms

		def RandomNNumbersZ(n)
			return This.NRandomNumbersZ(n)

		def NNumbersZ(n)
			return This.NRandomNumbersZ(n)

		#>

	# U/EXTENDED FORM (TODO)

	
	# UZ/EXTENDED FORM (TODO)


	  #------------------------------------------------------#
	 #  GETTING N RANDOM NUMBERS OTHER THEN A GIVEN NUMBER  #
	#------------------------------------------------------#

	def NNumbersOtherThan(n, nNumber)
		if isList(n)
			if Q(n).IsPositionNamedParam()
				return This.NNumbersOutSidePosition(n[2], nNumber)

			but Q(n).IsPositionsNamedParam()
				return This.NNumbersOutsidePositions(n[2], nNumber)

			else
				return This.NNumbersOutsidePositions(n, nNumber)
			ok
		ok

		anPos = This.Find(n)
		anPos = Q( 1 : This.NumberOfNumbers() ) - These(anPos)
		anRandoms = NRandomNumbersIn(anPos)
		anResult = This.ItemsAtPositions(anRandoms)

		return anResult

	#-- Z/EXTENDED FORM

	def NNumbersOtherThanZ(n, nNumber)
		if isList(n)
			if Q(n).IsPositionNamedParam()
				return This.NNumbersOutSidePosition(n[2], nNumber)

			but Q(n).IsPositionsNamedParam()
				return This.NNumbersOutsidePositions(n[2], nNumber)

			else
				return This.NNumbersOutsidePositions(n, nNumber)
			ok
		ok

		anPos = This.Find(n)
		anPos = Q( 1 : This.NumberOfNumbers() ) - These(anPos)
		anRandoms = NRandomNumbersIn(anPos)
		nLen = len(anRandoms)

		aResult = []

		for i = 1 to nLen
			aResult + [ This.ItemAtPosition(anRandoms[i]), anRandoms[i] ]
		next

		return aResult

	# U/EXTENDED FORM (TODO)

	
	# UZ/EXTENDED FORM (TODO)

	  #-----------------------------------------------------#
	 #  GETTING N RANDOM NUMBERS LESS THEN A GIVEN NUMBER  #
	#-----------------------------------------------------#

	def NNumbersLessThan(n, nNumber)
		anResult = This.NumbersLessThanQ(nNumber).NRandomNumbers(n)
		return anResult

		#< @FunctionAlternativeForms

		def NRandomNumbersLessThan(n, nNumber)
			return This.NNumbersLessThan(n, nNumber)

		def NNumbersSmallerThan(n, nNumber)
			return This.NNumbersLessThan(n, nNumber)

		def NRandomNumbersSmallerThan(n, nNumber)
			return This.NNumbersLessThan(n, nNumber)

		#>

	#-- Z/EXTENDED FORM

	def NNumbersLessThanZ(n, nNumber)
		aResult = This.NumbersLessThanQ(nNumber).NRandomNumbersZ(n)
		return anResult

		#< @FunctionAlternativeForms

		def NRandomNumbersLessThanZ(n, nNumber)
			return This.NNumbersLessThanZ(n, nNumber)

		def NNumbersSmallerThanZ(n, nNumber)
			return This.NNumbersLessThanZ(n, nNumber)

		def NRandomNumbersSmallerThanZ(n, nNumber)
			return This.NNumbersLessThanZ(n, nNumber)

		#>

	# U/EXTENDED FORM (TODO)

	
	# UZ/EXTENDED FORM (TODO)

	  #--------------------------------------------------------#
	 #  GETTING N RANDOM NUMBERS GREATER THEN A GIVEN NUMBER  #
	#--------------------------------------------------------#

	def NNumbersGreaterThan(n, nNumber)
		anResult = This.NumbersGreaterThanQ(nNumber).NRandomNumbers(n)
		return anResult

		#< @FunctionAlternativeForms

		def NRandomNumbersGreaterThan(n, nNumber)
			return This.NNumbersLessThan(n, nNumber)

		def NNumbersBiggerThan(n, nNumber)
			return This.NNumbersLessThan(n, nNumber)

		def NRandomNumbersBiggerThan(n, nNumber)
			return This.NNumbersLessThan(n, nNumber)

		def NNumbersMoreThan(n, nNumber)
			return This.NNumbersLessThan(n, nNumber)

		def NRandomNumbersMoreThan(n, nNumber)
			return This.NNumbersLessThan(n, nNumber)

		#>

	#-- Z/EXTENDED FORM

	def NNumbersGreaterThanZ(n, nNumber)
		aResult = This.NumbersGreaterThanQ(nNumber).NRandomNumbersZ(n)
		return aResult

		#< @FunctionAlternativeForms

		def NRandomNumbersGreaterThanZ(n, nNumber)
			return This.NNumbersLessThanZ(n, nNumber)

		def NNumbersBiggerThanZ(n, nNumber)
			return This.NNumbersLessThanZ(n, nNumber)

		def NRandomNumbersBiggerThanZ(n, nNumber)
			return This.NNumbersLessThanZ(n, nNumber)

		def NNumbersMoreThanZ(n, nNumber)
			return This.NNumbersLessThanZ(n, nNumber)

		def NRandomNumbersMoreThanZ(n, nNumber)
			return This.NNumbersLessThanZ(n, nNumber)

		#>

	# U/EXTENDED FORM (TODO)

	
	# UZ/EXTENDED FORM (TODO)

	  #---------------------------------------------------------#
	 #  GETTING N RANDOM NUMBERS OTHER THEN THE GIVEN NUMBERS  #
	#---------------------------------------------------------#
	
	#TODO: Add alternatives of (DifferentTo / Of / From / With) all over the library!

	def NNumbersOtherThanMany(n, anNumbers)
		anPos = Q( 1 : This.NumberOfItems() ) - These(This.Find(anNumbers))
		anRandoms = NRandomNumbersIn(anPos)
		aResult = This.ItemsAtPositions(anRandoms)

		return anResult

		#< @FunctionAlternativeForms

		def NNumbersDifferentFromMany(n, anNumbers)
			return This.NNumbersOtherThanMany(n, anNumbers)

		def NNumbersDifferentToMany(n, anNumbers)
			return This.NNumbersOtherThanMany(n, anNumbers)

		def NNumbersDifferentWithMany(n, anNumbers)
			return This.NNumbersOtherThanMany(n, anNumbers)

		def NNumbersDifferentOfMany(n, anNumbers)
			return This.NNumbersOtherThanMany(n, anNumbers)

		#--

		def NRandomNumbersOtherThanMany(n, anNumbers)
			return This.NNumbersOtherThanMany(n, anNumbers)

		def NRandomNumbersDifferentFromMany(n, anNumbers)
			return This.NNumbersOtherThanMany(n, anNumbers)

		def NRandomNumbersDifferentToMany(n, anNumbers)
			return This.NNumbersOtherThanMany(n, anNumbers)

		def NRandomNumbersDifferentWithMany(n, anNumbers)
			return This.NNumbersOtherThanMany(n, anNumbers)

		def NRandomNumbersDifferentOfMany(n, anNumbers)
			return This.NNumbersOtherThanMany(n, anNumbers)

		#>

	#-- Z/EXTENDED FORM

	def NNumbersOtherThanManyZ(n, anNumbers)
		anPos = Q( 1 : This.NumberOfItems() ) - These(This.Find(anNumbers))
		anRandoms = NRandomNumbersIn(anPos)
		nLen = len(aRandoms)
		
		aResult = []

		for i = 1 to nLen
			aResult + [ This.ItemAtPosition(anRandoms[i]), anRandoms[i] ]
		next

		return aResult

		#< @FunctionAlternativeForms

		def NNumbersDifferentFromManyZ(n, anNumbers)
			return This.NNumbersOtherThanManyZ(n, anNumbers)

		def NNumbersDifferentToManyZ(n, anNumbers)
			return This.NNumbersOtherThanManyZ(n, anNumbers)

		def NNumbersDifferentWithManyZ(n, anNumbers)
			return This.NNumbersOtherThanManyZ(n, anNumbers)

		def NNumbersDifferentOfManyZ(n, anNumbers)
			return This.NNumbersOtherThanManyZ(n, anNumbers)

		#--

		def NRandomNumbersOtherThanManyZ(n, anNumbers)
			return This.NNumbersOtherThanManyZ(n, anNumbers)

		def NRandomNumbersDifferentFromManyZ(n, anNumbers)
			return This.NNumbersOtherThanManyZ(n, anNumbers)

		def NRandomNumbersDifferentToManyZ(n, anNumbers)
			return This.NNumbersOtherThanManyZ(n, anNumbers)

		def NRandomNumbersDifferentWithManyZ(n, anNumbers)
			return This.NNumbersOtherThanManyZ(n, anNumbers)

		def NRandomNumbersDifferentOfManyZ(n, anNumbers)
			return This.NNumbersOtherThanManyZ(n, anNumbers)

		#>

	# U/EXTENDED FORM (TODO)

	
	# UZ/EXTENDED FORM (TODO)


	  #--------------------------------------------------------------------#
	 #  GETTING N RANDOM NUMBERS FROM THE LIST BETWEEN TWO GIVEN NUMBERS  #
	#--------------------------------------------------------------------#

	def NNumbersBetween(n, nMin, nMax)
		anNumbers = This.NumbersBetween(nMin, nMax)
		anResult = NRandomNumbersIn(n, anNumbers)

		return anResult

		def NRandomNumbersBetween(nMin, nMax)
			return This.NNumbersBetween(nMin, nMax)

	#-- Z/EXTENDED FORM

	def NNumbersBetweenZ(n, nMin, nMax)
		anNumbers = This.NumbersBetween(nMin, nMax)
		aResult = NRandomNumbersInZ(n, anNumbers)

		return aResult

		def NRandomNumbersBetweenZ(nMin, nMax)
			return This.NNumbersBetweenZ(nMin, nMax)

	#-- U/EXTENDED FORM (TODO)

	#-- UZ/EXTENDED FORM (TODO)


	  #-----------------------------------------------------------------------------------#
	 #  GETTING N RANDOM NUMBERS FROM THE LIST BETWEEN TWO GIVEN NUMBERS -- IB/EXTENDED  #
	#-----------------------------------------------------------------------------------#

	def NNumbersBetweenIB(n, nMin, nMax)
		anNumbers = This.NumbersBetweenIB(nMin, nMax)
		anResult = NRandomNumbersIn(n, anNumbers)

		return anResult

		def NRandomNumbersBetweenIB(nMin, nMax)
			return This.NNumbersBetweenIB(nMin, nMax)

	# Z/EXTENDED FORM

	def NNumbersBetweenIBZ(n, nMin, nMax)
		anNumbers = This.NumbersBetweenIB(nMin, nMax)
		aResult = NRandomNumbersInZ(n, anNumbers)

		return anResult

		def NRandomNumbersBetweenIBZ(nMin, nMax)
			return This.NNumbersBetweenIBZ(nMin, nMax)


	# U/EXTENDED FORM (TODO)

	
	# UZ/EXTENDED FORM (TODO)


	  #------------------------------------------------------------------------#
	 #  GETTING N RANDOM NUMBERS FROM THE LIST NOT BETWEEN TWO GIVEN NUMBERS  #
	#------------------------------------------------------------------------#

	def NNumbersNotBetween(n, nMin, nMax)
		anNumbers = This.NumbersNotBetween(nMin, nMax)
		anResult = NRandomNumbersIn(n, anNumbers)

		return anResult

		def NRandomNumbersNotBetween(nMin, nMax)
			return This.NNumbersNotBetween(nMin, nMax)

	# Z/EXTENDED FORM

	def NNumbersNotBetweenZ(n, nMin, nMax)
		anNumbers = This.NumbersNotBetween(nMin, nMax)
		aResult = NRandomNumbersInZ(n, anNumbers)

		return aResult

		def NRandomNumbersNotBetweenZ(nMin, nMax)
			return This.NNumbersNotBetweenZ(nMin, nMax)

	# U/EXTENDED FORM (TODO)

	
	# UZ/EXTENDED FORM (TODO)


	  #---------------------------------------------------------------------------------------#
	 #  GETTING N RANDOM NUMBERS FROM THE LIST NOT BETWEEN TWO GIVEN NUMBERS -- IB/EXTENDED  #
	#---------------------------------------------------------------------------------------#

	def NNumbersNotBetweenIB(n, nMin, nMax)
		anNumbers = This.NumbersNotBetweenIB(nMin, nMax)
		anResult = NRandomNumbersIn(n, anNumbers)

		return anResult

		def NRandomNumbersNotBetweenIB(nMin, nMax)
			return This.NNumbersNotBetweenIB(nMin, nMax)

	# Z/EXTENDED FORM

	def NNumbersNotBetweenIBZ(n, nMin, nMax)
		anNumbers = This.NumbersNotBetweenIB(nMin, nMax)
		aResult = NRandomNumbersInZ(n, anNumbers)

		return aResult

		def NRandomNumbersNotBetweenIBZ(nMin, nMax)
			return This.NNumbersNotBetweenIBZ(nMin, nMax)

	# U/EXTENDED FORM (TODO)

	
	# UZ/EXTENDED FORM (TODO)

	  #-----------------------------------------------------#
	 #  GETTING N RANDOM NUMBERS OUTSIDE A GIVEN POSITION  #
	#=====================================================#

	def NNumbersOutsidePosition(nPos)
		return This.NItemsOutsidePosition(nPos)

	#-- 2/EXTENDED FORM

	def NNumbersOutsidePositionsZ(panPos)
		return This.NItemsOutsidePositionsZ(panPos)

	# U/EXTENDED FORM (TODO)

	
	# UZ/EXTENDED FORM (TODO)

	  #--------------------------------------------------------#
	 #  GETTING N RANDOM NUMBERS OUTSIDE THE GIVEN POSITIONS  #
	#--------------------------------------------------------#

	def NNumbersOutsidePositions(panPos)
		return This.NItemsOutsidePositions(panPos)

	# Z/EXTENDED FORM

	def NItemsOutsidePositionZ(anPos)
		return This.NItemsOutsidePositionZ(anPos)

	# U/EXTENDED FORM (TODO)

	
	# UZ/EXTENDED FORM (TODO)

	  #---------------------------------------------#
	 #  GETTING SOME RANDOM NUMBERS FROM THE LIST  #
	#=============================================#

	def SomeRandomNumbers()
		anPos = SomeRandomNumbersIn(1 : This.NumberOfItems())
		anResult = This.ItemsAtPositions(anPos)

		return anResult

		def SomeNumbers()
			return This.SomeRandomNumbers()

	# Z/EXTENDED FORM

	def SomeRandomNumbersZ()
		anPos = SomeRandomNumbersIn(1 : This.NumberOfItems())
		nLen  = len(anPos)

		aResult = []

		for i = 1 to nLen
			aResult + [ This.Number(i), anPos[i] ]
		next

		return aResult

	# U/EXTENDED FORM (TODO)

	
	# UZ/EXTENDED FORM (TODO)

	  #---------------------------------------------------------#
	 #  GETTING SOME RANDOM NUMBERS OTHER THEN A GIVEN NUMBER  #
	#---------------------------------------------------------#

	def SomeNumbersOtherThan(n, nNumber)
		if isList(n)
			if Q(n).IsPositionNamedParam()
				return This.SomeNumbersOutSidePosition(n[2], nNumber)

			but Q(n).IsPositionsNamedParam()
				return This.SomeNumbersOutsidePositions(n[2], nNumber)

			else
				return This.SomeNumbersOutsidePositions(n, nNumber)
			ok
		ok

		anPos = This.Find(n)
		anPos = Q( 1 : This.NumberOfNumbers() ) - These(anPos)
		anRandoms = SomeRandomNumbersIn(anPos)
		anResult = This.ItemsAtPositions(anRandoms)

		return anResult

	  #--------------------------------------------------------#
	 #  GETTING SOME RANDOM NUMBERS LESS THEN A GIVEN NUMBER  #
	#--------------------------------------------------------#

	def SomeNumbersLessThan(n, nNumber)
		anNumbers = This.NumbersLessThan(nNumber)
		anResult = StzListOfNumbers(anNumbers).SomeRandomNumbers()

		return anResult

	#-- Z/EXTENDED FORM

	def SomeNumbersLessThanZ(n, nNumber)
		anNumbers = This.NumbersLessThan(nNumber)
		aResult = StzListOfNumbers(anNumbers).SomeRandomNumbersZ()

		return aResult

	  #----------------------------------------------------------#
	 #  GETTING SOME RANDOM NUMBERS GRATER THEN A GIVEN NUMBER  #
	#----------------------------------------------------------#

	def SomeNumbersGreaterThan(n, nNumber)
		anNumbers = This.NumbersGreaterThan(nNumber)
		anResult = StzListOfNumbers(anNumbers).SomeRandomNumbers()

		return anResult

	#-- Z/EXTENDED FORM

	def SomeNumbersGreaterThanZ(n, nNumber)
		anNumbers = This.NumbersGreaterThan(nNumber)
		aResult = StzListOfNumbers(anNumbers).SomeRandomNumbersZ()

		return aResult

	  #------------------------------------------------------------#
	 #  GETTING SOME RANDOM NUMBERS OTHER THEN THE GIVEN NUMBERS  #
	#------------------------------------------------------------#

	def SomeNumbersOtherThanMany(paNumbers)
		anNumbers = This.NumbersOtherThanMany(paNumbers)
		anResult  = StzListOfNumbers(anNumbers).SomeRandomNumbers()

		return anResult

	#-- Z/EXTENDED FORM

	def SomeNumbersOtherThanManyZ(paNumbers)
		anNumbers = This.NumbersOtherThanMany(nNumber)
		aResult   = StzListOfNumbers(anNumbers).SomeRandomNumbersZ()

		return aResult

	  #---------------------------------------------------------#
	 #  GETTING SOME RANDOM NUMBERS BETWEEN TWO GIVEN NUMBERS  #
	#---------------------------------------------------------#

	func SomeNumbersBetween(nMin, nMax)
		anNumbers = This.NumbersBetween(nMin, nMax)
		anResult  = StzListOfNumbers(anNumbers).SomeRandomNumbers()

		return anResult

	#-- Z/EXTENDED FORM

	def SomeNumbersBetweenZ(nMin, nMax)
		anNumbers = This.NumbersBetween(nMin, nMax)
		aResult   = StzListOfNumbers(anNumbers).SomeRandomNumbersZ()

		return aResult

	  #-------------------------------------------------------------#
	 #  GETTING SOME RANDOM NUMBERS NOT BETWEEN TWO GIVEN NUMBERS  #
	#-------------------------------------------------------------#

	func SomeNumbersNotBetween(nMin, nMax)
		anNumbers = This.NumbersNotBetween(nMin, nMax)
		anResult  = StzListOfNumbers(anNumbers).SomeRandomNumbers()

		return anResult

	#-- Z/EXTENDED FORM

	def SomeNumbersNotBetweenZ(nMin, nMax)
		anNumbers = This.NumbersNotBetween(nMin, nMax)
		aResult   = StzListOfNumbers(anNumbers).SomeRandomNumbersZ()

		return aResult

	  #------------------------------------------------------------------------#
	 #  GETTING SOME RANDOM NUMBERS BETWEEN TWO GIVEN NUMBERS -- IB/EXTENDED  #
	#------------------------------------------------------------------------#

	func SomeNumbersBetweenIB(nMin, nMax)
		anNumbers = This.NumbersBetweenIB(nMin, nMax)
		anResult  = StzListOfNumbers(anNumbers).SomeRandomNumbers()

		return anResult

	#-- Z/EXTENDED FORM

	def SomeNumbersBetweenIBZ(nMin, nMax)
		anNumbers = This.NumbersBetweenIB(nMin, nMax)
		aResult   = StzListOfNumbers(anNumbers).SomeRandomNumbersZ()

		return aResult

	  #----------------------------------------------------------------------------#
	 #  GETTING SOME RANDOM NUMBERS NOT BETWEEN TWO GIVEN NUMBERS -- IB/EXTENDED  #
	#----------------------------------------------------------------------------#

	func SomeNumbersNotBetweenIB(nMin, nMax)
		anNumbers = This.NumbersNotBetween(nMin, nMax)
		anResult  = StzListOfNumbers(anNumbers).SomeRandomNumbers()

		return anResult

	#-- Z/EXTENDED FORM

	def SomeNumbersNotBetweenIBZ(nMin, nMax)
		anNumbers = This.NumbersNotBetween(nMin, nMax)
		aResult   = StzListOfNumbers(anNumbers).SomeRandomNumbersZ()

		return aResult

	  #===================================================#
	 #  GETTING THE NUMBERS SMALLER THAN A GIVEN NUMBER  #
	#===================================================#

	def NumbersSmallerThan(n)
		anContent = This.Content()
		nLen = len(anContent)

		anResult = []

		for i = 1 to nLen
			if anContent[i] < n
				anResult + anContent[i]
			ok
		next

		return anResult

		#< @FunctionFluentForms

		def NumbersSmallerThanQ(n)
			return This.NumbersSmallerThanQR(n, :stzList)

		def NumbersSmallerThanQR(n, pcReturnType)
			switch pcReturnType
			on :stzList
				return new stzList( This.NumbersSmallerThan(n) )

			on :stzListOfNumbers
				return new stzListOfNumbers( This.NumbersSmallerThan(n) )

			other
				StzRaise("Unsupported return type!")
			off

		#>

		#< @FunctionAlternativeForm

		def NumbersLessThan(n)
			return This.NumbersSmallerThan(n)

			def NumbersLessThanQ(n)
				return This.NumbersSmallerThanQ(n)

			def NumbersLessThanQR(n, pcReturnType)
				return This.NumbersSmallerThanQR(n, pcReturnType)

		#>

	#-- Z/EXTENDED FORM

	def NumbersSmallerThanZ(n)
		anContent = This.Content()
		nLen = len(anContent)

		anResult = []

		for i = 1 to nLen
			if anContent[i] < n
				aResult + [ anContent[i], i ]
			ok
		next

		return aResult

		#< @FunctionAlternativeForm

		def NumbersLessThanZ(n)
			return This.NumbersSmallerThanZ(n)

		#>

	  #---------------------------------------------------#
	 #  GETTING THE NUMBERS GREATER THAN A GIVEN NUMBER  #
	#---------------------------------------------------#

	def NumbersGreaterThan(n)
		if NOT This.Contains(n)
			return []
		ok
	
		anContent = This.Content()
		nLen = len(anContent)

		anResult = []

		for i = 1 to nLen
			if anContent[i] > n
				anResult + anContent[i]
			ok
		next

		return anResult

		#< @FunctionFluentForms

		def NumbersGreaterThanQ(n)
			return This.NumbersGreaterThanQR(n, :stzList)

		def NumberGreaterThanQR(n, pcReturnType)
			switch pcReturnType
			on :stzList
				return new stzList( This.NumbersGreaterThan(n) )

			on :stzListOfNumbers
				return new stzListOfNumbers( This.NumbersGreaterThan(n) )

			other
				StzRaise("Unsupported return type!")
			off

		#>

		#< @FunctionAlternativeForms

		def NumbersLargerThan(n)
			return This.NumberSmallerThan(n)

			def NumbersLargerThanQ(n)
				return This.NumberSmallerThanQ(n)

			def NumbersLargerThanQR(n, pcReturnType)
				return This.NumberSmallerThanQ(n, pcReturnType)

		def NumbersBiggerThan(n)
			return This.NumberSmallerThan(n)

			def NumbersBiggerThanQ(n)
				return This.NumberSmallerThanQ(n)

			def NumbersBiggerThanQR(n, pcReturnType)
				return This.NumberSmallerThanQ(n, pcReturnType)

		def NumbersMoreThan(n)
			return This.NumberSmallerThan(n)

			def NumbersMoreThanQ(n)
				return This.NumberSmallerThanQ(n)

			def NumbersMoreThanQR(n, pcReturnType)
				return This.NumberSmallerThanQ(n, pcReturnType)

		#>

	#-- Z/EXTENDED FORM

	def NumbersGreaterThanZ(n)
		if NOT This.Contains(n)
			return []
		ok
	
		anContent = This.Content()
		nLen = len(anContent)

		aResult = []

		for i = 1 to nLen
			if anContent[i] > n
				aResult + [ aContent[i], i ]
			ok
		next

		return aResult

		#< @FunctionAlternativeForms

		def NumbersLargerThanZ(n)
			return This.NumberSmallerThan(n)

		def NumbersBiggerThanZ(n)
			return This.NumberSmallerThan(n)

		def NumbersMoreThanZ(n)
			return This.NumberSmallerThan(n)

		#>

	  #-------------------------------------------------#
	 #  GETTING THE NUMBERS OTHER THAN A GIVEN NUMBER  #
	#-------------------------------------------------#

	def NumbersOtherThan(n)
		if isList(n)
			return This.NumbersOtherThanMany(n)
		ok

		anContent = This.Content()
		nLen = len(anContent)

		anResult = []

		for i = 1 to nLen
			if anContent[i] != n
				anResult + anContent[i]
			ok
		next

		return anResult

		#< @FunctionFluentForms

		def NumbersOtherThanQ(n)
			return new NumbersOtherThanQR(n, :stzList)

		def NumbersOtherThanQR(n, pcReturnType)
			switch pcReturnType
			on :stzList
				return new stzList( This.NumbersOtherThan(n) )

			on :stzListOfNumbers
				return new stzListOfNumbers( This.NumbersOtherThan(n) )

			other
				StzRaise("Unsupported return type!")
			off

		#>

		#< @FunctionAlternativeForms

		def NumbersDifferentFrom(n)
			return This.NumbersOtherThan(n)

			def NumbersDifferentFromQ(n)
				return This.NumbersOtherThanQ(n)

			def NumbersDifferentFromQR(n, pcReturnType)
				return This.NumbersOtherThanQR(n, pcReturnType)

		def NumbersDifferentOf(n)
			return This.NumbersOtherThan(n)

			def NumbersDifferentOfQ(n)
				return This.NumbersOtherThanQ(n)

			def NumbersDifferentOfQR(n, pcReturnType)
				return This.NumbersOtherThanQR(n, pcReturnType)

		def NumbersDifferentTo(n)
			return This.NumbersOtherThan(n)

			def NumbersDifferentToQ(n)
				return This.NumbersOtherThanQ(n)

			def NumbersDifferentToQR(n, pcReturnType)
				return This.NumbersOtherThanQR(n, pcReturnType)

		#>

	#-- Z/EXTENDED FORM

	def NumbersOtherThanZ(n)
		if isList(n)
			return This.NumbersOtherThanMany(n)
		ok

		anContent = This.Content()
		nLen = len(anContent)

		aResult = []

		for i = 1 to nLen
			if anContent[i] != n
				aResult + [ aContent[i], i ]
			ok
		next

		return aResult

		#< @FunctionAlternativeForms

		def NumbersDifferentFromZ(n)
			return This.NumbersOtherThanZ(n)

		def NumbersDifferentOfZ(n)
			return This.NumbersOtherThanZ(n)

		def NumbersDifferentToZ(n)
			return This.NumbersOtherThanZ(n)

		#>

	  #-----------------------------------------------------#
	 #  GETTING THE NUMBERS OTHER THAN MANY GIVEN NUMBERS  #
	#-----------------------------------------------------#

	def NumbersOtherThanMany(anNumbers)
		if NOT (isList(anNumbers) and Q(anNumbers).IsListOfNumbers())
			StzRaise("Incorrect param type! anNumbers must be a list of numbers.")
		ok

		anContent = This.Content()
		nLen = len(aContent)

		anResult = []

		for i = 1 to nLen
			if NOT ring_find(anNumbers, anContent[i])
				anResult + aContent[i]
			ok
		next

		return anResult

		#< @FunctionAlternativeForms

		def NumbersDifferentFromMany(anNumbers)
			return This.NumbersOtherThanMany(anNumbers)

		def NumbersDifferentOfMany(anNumbers)
			return This.NumbersOtherThanMany(anNumbers)

		def NumbersDifferentToMany(anNumbers)
			return This.NumbersOtherThanMany(anNumbers)

		#--

		def NumbersOtherThanThese(anNumbers)
			return This.NumbersOtherThanMany(anNumbers)

		def NumbersDifferentFromThese(anNumbers)
			return This.NumbersOtherThanMany(anNumbers)

		def NumbersDifferentOfThese(anNumbers)
			return This.NumbersOtherThanMany(anNumbers)

		def NumbersDifferentThese(anNumbers)
			return This.NumbersOtherThanMany(anNumbers)

		#>

	#-- Z/EXTENDED FORM

	def NumbersOtherThanManyZ(anNumbers)
		if NOT (isList(anNumbers) and Q(anNumbers).IsListOfNumbers())
			StzRaise("Incorrect param type! anNumbers must be a list of numbers.")
		ok

		anContent = This.Content()
		nLen = len(aContent)

		aResult = []

		for i = 1 to nLen
			if NOT ring_find(anNumbers, anContent[i])
				aResult + [ aContent[i], i ]
			ok
		next

		return aResult

		#< @FunctionAlternativeForms

		def NumbersDifferentFromManyZ(anNumbers)
			return This.NumbersOtherThanManyZ(anNumbers)

		def NumbersDifferentOfManyZ(anNumbers)
			return This.NumbersOtherThanManyZ(anNumbers)

		def NumbersDifferentToManyZ(anNumbers)
			return This.NumbersOtherThanManyZ(anNumbers)

		#--

		def NumbersOtherThanTheseZ(anNumbers)
			return This.NumbersOtherThanManyZ(anNumbers)

		def NumbersDifferentFromTheseZ(anNumbers)
			return This.NumbersOtherThanManyZ(anNumbers)

		def NumbersDifferentOfTheseZ(anNumbers)
			return This.NumbersOtherThanManyZ(anNumbers)

		def NumbersDifferentTheseZ(anNumbers)
			return This.NumbersOtherThanManyZ(anNumbers)

		#>

	  #--------------------------------------------#
	 #  GETTING NUMBERS OUTSIDE A GIVEN POSITION  #
	#--------------------------------------------#

	def NumbersOutsidePosition(n)
		anPos = Q( 1 : This.NumberOfItems() ) - n
		anResult = This.ItemsAtPositions(anPos)

		return anResult

		#< @FunctionAlternativeForms

		def NumbersBeforeAndAfterPosition(n)
			return This.NumbersOutsidePosition(n)

		def NumbersAfterAndBeforePosition(n)
			return This.NumbersOutsidePosition(n)

		def NumbersBeforeOrAfterPosition(n)
			return This.NumbersOutsidePosition(n)

		def NumbersAfterOrBeforePosition(n)
			return This.NumbersOutsidePosition(n)

		#>

	#-- Z/EXTENDED FORM

	def NumbersOutsidePositionZ(n)
		anPos = Q( 1 : This.NumberOfItems() ) - n
		nLen = len(anPos)

		aResult = []

		for i = 1 to nLen
			aResult + [ This.Item(anPos[i]), anPos[i] ]
		next

		return nResult

		#< @FunctionAlternativeForms

		def NumbersBeforeAndAfterPositionZ(n)
			return This.NumbersOutsidePositionZ(n)

		def NumbersAfterAndBeforePositionZ(n)
			return This.NumbersOutsidePositionZ(n)

		def NumbersBeforeOrAfterPositionZ(n)
			return This.NumbersOutsidePositionZ(n)

		def NumbersAfterOrBeforePositionZ(n)
			return This.NumbersOutsidePositionZ(n)

		#>

	  #----------------------------------------------------------#
	 #  GETTING NUMNBERS IN THE LIST BETWEEN TWO GIVEN NUMBERS  #
	#==========================================================#

	def NumbersBetween(nMin, nMax)
		anContent = This.Content()
		nLen = len(anContent)

		anResult = []

		for i = 1 to nLen
			if anContent[i] > nMin and anContent[i] < nMax
				anResult + anContent[i]
			ok
		next

		return anResult

	#-- Z/EXTENDED FORM

	def NumbersBetweenZ(nMin, nMax)
		anContent = This.Content()
		nLen = len(anContent)

		aResult = []

		for i = 1 to nLen
			if anContent[i] > nMin and anContent[i] < nMax
				aResult + [ anContent[i], i ]
			ok
		next

		return aResult

	  #------------------------------------------------------------------------#
	 #  GETTING NUMNBERS IN THE LIST BETWEEN TWO GIVEN NUMBERS -- IB/EXTENDED  #
	#------------------------------------------------------------------------#

	def NumbersBetweenIB(nMin, nMax)
		anContent = This.Content()
		nLen = len(anContent)

		anResult = []

		for i = 1 to nLen
			if anContent[i] >= nMin and anContent[i] <= nMax
				anResult + anContent[i]
			ok
		next

		return anResult

	#-- Z/EXTENDED FORM

	def NumbersBetweenIBZ(nMin, nMax)
		anContent = This.Content()
		nLen = len(anContent)

		aResult = []

		for i = 1 to nLen
			if anContent[i] >= nMin and anContent[i] <= nMax
				aResult + [ anContent[i], i ]
			ok
		next

		return aResult

	  #--------------------------------------------------------------#
	 #  GETTING NUMNBERS IN THE LIST NOT BETWEEN TWO GIVEN NUMBERS  #
	#===============================================================#

	def NumbersNotBetween(nMin, nMax)
		anContent = This.Content()
		nLen = len(anContent)

		anResult = []

		for i = 1 to nLen
			if NOT( anContent[i] > nMin and anContent[i] < nMax )
				anResult + anContent[i]
			ok
		next

		return anResult

	#-- Z/EXTENDED FORM

	def NumbersNotBetweenZ(nMin, nMax)
		anContent = This.Content()
		nLen = len(anContent)

		aResult = []

		for i = 1 to nLen
			if NOT ( anContent[i] > nMin and anContent[i] < nMax )
				aResult + [ anContent[i], i ]
			ok
		next

		return aResult

	  #-----------------------------------------------------------------------------#
	 #  GETTING NUMNBERS IN THE LIST NOT BETWEEN TWO GIVEN NUMBERS -- IB/EXTENDED  #
	#-----------------------------------------------------------------------------#

	def NumbersNotBetweenIB(nMin, nMax)
		anContent = This.Content()
		nLen = len(anContent)

		anResult = []

		for i = 1 to nLen
			if NOT ( anContent[i] >= nMin and anContent[i] <= nMax )
				anResult + anContent[i]
			ok
		next

		return anResult

	#-- Z/EXTENDED FORM

	def NumbersNotBetweenIBZ(nMin, nMax)
		anContent = This.Content()
		nLen = len(anContent)

		aResult = []

		for i = 1 to nLen
			if NOT ( anContent[i] >= nMin and anContent[i] <= nMax )
				aResult + [ anContent[i], i ]
			ok
		next

		return aResult

	  #==============================#
	 #     OPERATORS OVERLOADING    # 
	#==============================#

	/*
		TODO: Operators should carry same semantics in all classes...
	*/

	def operator(pcOp, pValue)
		
		if pcOp = "[]"

			if isNumber(pValue)
				return This.NumberAt(pValue)

			ok

		but pcOp = "="
			return This.ToStzList().IsEqualTo(value)

		but pcOp = "=="
			return This.ToStzList().IsStrictlyEqualTo(value)
		

		but pcOp = "/"

			if ring_type(pValue) = "NUMBER"
				// Divides the list on pValue sublists (a list of lists)
				return This.ToStzList().SplitToNParts(pValue)

			but @IsStzNumber(pValue)
				return Q(This.ToStzList().SplitToNParts(pValue))
			ok

		but pcOp = "-"
			if isNumber(pValue)
				anResult = This.ToStzList().RemoveNthQ( ring_find(This.ListOfStrings(), pValue) ).Content()
				return anResult

			but @IsNumber(pValue)
				anResult = This.ToStzList().RemoveNthQ( ring_find(This.ListOfStrings(), pValue) ).Content()
				This.Update( anResult )
			
			but isList(pValue) and Q(pValue).IsListofNumbers()
				if len(pValue) > 0
					oStzList = This.ToStzList()
					anPos = oStzList.FindMany(pValue)
					oStzList.RemoveItemsAtPositions(anPos)
					anResult = oStzList.Content()
					return anResult
				ok

			but @IsStzList(pValue) and pValue.IsListOfNumbers()
				if len(pValue.Content()) > 0
					oStzList = This.ToStzList()
					anPos = oStzList.FindMany(pValue.Content())
					oStzList.RemoveItemsAtPositions(anPos)
					anResult = oStzList.Content()
					This.UpdateWith(anResult)
				ok
			ok

		but pcOp = "*"
			anTemp = This.ToStzList().MultiplyByQ(pValue).Content()
			This.Update( anTemp )

		but pcOp = "+"
			anTemp = This.ToStzList().AddItemQ(pValue).Content()
			This.Update( anTemp )
		ok

	def AreNegative()
		
		anContent = This.Content()
		nLen = len(anContent)

		bResult = TRUE

		for i = 1 to nLen
			if NOT (0+ anContent[i]) < 0
				bResult = FALSE
				exit
			ok
		next

		return bResult

		def AreNegativeQ()
			if This.AreNegative()
				return This
			else
				return AFalseObject()
			ok

		def Nagative()
			return This.AreNagative()

			def NegaiveQ()
				return This.AreNegativeQ()

	def ArePositive()
		
		anContent = This.Content()
		nLen = len(anContent)

		bResult = TRUE

		for i = 1 to nLen
			if NOT (0+ anContent[i]) > 0
				bResult = FALSE
				exit
			ok
		next

		return bResult

		def ArePositiveQ()
			if This.ArePositive()
				return This
			else
				return AFalseObject()
			ok

		def Positive()
			return This.ArePositive()

			def PositiveQ()
				return This.ArePositiveQ()

	def IsDividableBy(n)
		
		anContent = This.Content()
		nLen = len(anContent)

		bResult = TRUE

		for i = 1 to nLen
			if NOT ( (0+ anContent[i]) % n = 0 )
				bResult = FALSE
				exit
			ok
		next

		return bResult

		#< @FunctionFluentForm

		def IsDividableByQ(n)
			if This.IsDividableBy(n)
				return This
			else
				return AFalseObject()
			ok

		#>

		#< @FunctionAlternativeForms

		def DividableBy(n)
			return This.IsDividableBy(n)

			def DividableByQ(n)
				return This.IsDividableByQ(n)

		#--

		def IsDivisibleBy(n)
			return This.IsDividableBy(n)

			def IsDivisibleByD(n)
				return This.IsDividableByQ(n)

		#==

		def CanBeDividedBy(n)
			return This.IsDividableBy(n)

			def CanBiDividedByQ(n)
				return This.IsDividableByQ(n)

		def CanBeDivisedBy(n)
			return This.IsDividableBy(n)

			def CanBeDivisedByQ(n)
				return This.IsDividableByQ(n)	

	  #==================================================+===============#
	 #  JSUTIFYING THE LIST OF NUMBERS (RETURNED AS A LIST OF STRINGS)  #
	#=================================================+================#

	def Adjust()
		acResult = This.AdjustUsing(" ")
		return acResult

		#< @FunctionFluentForm

		def AdjustQ()
			return new stzList( This.Adjust() )

		def AdjustQR(pcReturnType)
			switch pcReturnType
			on :stzList
				return new stzList( This.Adjust() )

			on :stzListOfStrings
				return new stzListOfStrings( This.Adjust() )

			other
				StzRaise("Unsupported return type!")
			off

		#>

		#< @FunctionAlternativeForms

		def Adjusted()
			return This.Adjust()

			def AdjustedQ()
				return This.AdjustQ()

			def AdjustedQR(pcReturnType)
				return This.AdjustQR(pcReturnType)

		def Justified()
			return This.Adjust()

			def JustifiedQ()
				return This.AdjustQ()

			def JustifiedQR(pcReturnType)
				return This.AdjustQR(pcReturnType)

		def Justify()
			return This.Adjust()

			def JustifyQ()
				return This.AdjustQ()

			def JustifyQR(pcReturnType)
				return This.AdjustQR(pcReturnType)
		#>

	  #---------------------------------------------------------#
	 #  JSUTIFYING THE NUMBERS IN THE LIST USING A GIVEN CHAR  #
	#---------------------------------------------------------#

	def AdjustUsing(c)
		if CheckParams()
			if NOT (isString(c) and @IsChar(c))
				StzRaise("Incorrect param type! c must be a char.")
			ok
		ok

		aContent = This.Content()
		nLen = len(aContent)

		nMaxSize = 0
		nMaxLeft = 0
		nMaxRight = 0

		for i = 1 to nLen

			cNumber = ""+ aContent[i]

			nSize = len(cNumber)
			if nSize > nMaxSize
				nMaxSize = nSize
			ok

			nDotPos = substr( cNumber, "." )

			if nDotPos = 0
				nLenLeft = nSize
				nLenRight = 0

			else
				nLenLeft = nDotPos - 1
				nLenRight = nSize - nDotPos

			ok

			if nLenLeft > nMaxLeft
				nMaxLeft = nLenLeft
			ok

			if nLenRight > nMaxRight
				nMaxRight = nLenRight
			ok

		next

		# The number without decimal part are adjusted
		# first, by adding a dot and some 0s to them

		for i = 1 to nLen

			cNumber = ""+ aContent[i]
			nLenNumber = len(cNumber)
			nPosDot = substr(cNumber, ".")
			
			if nPosDot = 0
				
				nAddLeft = nMaxLeft - nLenNumber
				nAddRight = nMaxRight

				cExtLeft = ""
				cExtRight = ""

				for j = 1 to nAddLeft
					cExtLeft += c
				next

				for j = 1 to nAddRight
					cExtRight += "0"
				next

				cNumber = cExtLeft + cNumber + "." + cExtRight

			else
				nAddLeft = nMaxLeft - (nPosDot - 1)
				nAddRight = nMaxRight - (nLenNumber - nPosDot)

				cExtLeft = ""
				cExtRight = ""

				for j = 1 to nAddLeft
					cExtLeft += c
				next

				for j = 1 to nAddRight
					cExtRight += "0"
				next

				cNumber = cExtLeft + cNumber + cExtRight

			ok

			aContent[i] = cNumber

		next

		return aContent

		#< @FunctionFluentForm

		def AdjustUsingQ(c)
			return new stzList( This.AdjustUsing(c) )

		def AdjustUsingQR(c, pcReturnType)
			switch pcReturnType
			on :stzList
				return new stzList( This.AdjustUsing(c) )

			on :stzListOfStrings
				return new stzListOfStrings( This.AdjustUsing(c) )

			other
				StzRaise("Unsupported return type!")
			off

		#>

		#< @FunctionAlternativeForms

		def AdjustedUsing(c)
			return This.AdjustUsing(c)

			def AdjustedUsingQ(c)
				return This.AdjustUsingQ(c)

			def AdjustedUsingQR(c, pcReturnType)
				return This.AdjustUsingQR(c, pcReturnType)

		def JustifiedUsing(c)
			return This.AdjustUsing(c)

			def JustifiedUsingQ(c)
				return This.AdjustUsingQ(c)

			def JustifiedUsingQR(c, pcReturnType)
				return This.AdjustUsingQR(c, pcReturnType)

		def JustifyUsing(c)
			return This.AdjustUsing(c)

			def JustifyUsingQ(c)
				return This.AdjustUsingQ(c)

			def JustifyUsingQR(c, pcReturnType)
				return This.AdjustUsingQR(c, pcReturnType)

		#>

	  #-------------------------------------------------------#
	 #  JSUTIFYING THE NUMBERS IN THE LIST -- EXTENDED FORM  #
	#-------------------------------------------------------#

	def AdjustXT()
		acResult = This.AdjustUsing("0")
		return acResult

		#< @FunctionFluentForm

		def AdjustXTQ()
			return new stzList( This.AdjustXT() )

		def AdjustXTQR(pcReturnType)
			switch pcReturnType
			on :stzList
				return new stzList( This.AdjustXT() )

			on :stzListOfStrings
				return new stzListOfStrings( This.AdjustXT() )

			other
				StzRaise("Unsupported return type!")
			off

		#>

		#< @FunctionAlternativeForms

		def AdjustedXT()
			return This.AdjustXT()

			def AdjustedXTQ()
				return This.AdjustXTQ()

			def AdjustedXTQR(pcReturnType)
				return This.AdjustXTQR(pcReturnType)

		def JustifiedXT()
			return This.AdjustXT()

			def JustifiedXTQ()
				return This.AdjustXTQ()

			def JustifiedXTQR(pcReturnType)
				return This.AdjustXTQR(pcReturnType)

		def JustifyXT()
			return This.AdjustXT()

			def JustifyXTQ()
				return This.AdjustXTQ()

			def JustifyXTQR(pcReturnType)
				return This.AdjustXTQR(pcReturnType)
		#>

	  #====================================#
	 #  SORTING THE NUMBERS IN ASCENDING  #
	#====================================#

	def SortInAscending()
		aResult = @Sort(This.Content())
		This.UpdateWith(aResult)

		#< @FunctionAlternativeForms

		def SortInAscendingQ()
			This.SortInAscending()
			return This

		def SortUp()
			This.SortInAscending()

			def SortUpQ()
				return This.SortInAscendingQ()

		#>

	def SortedInAscending()
		aResult = This.Copy().SortInAscendingQ().Content()
		return aResult

		def SortedUp()
			return This.SortedInAscending()

	  #-------------------------------------#
	 #  SORTING THE NUMBERS IN DESCENDING  #
	#-------------------------------------#

	def SortInDescending()
		aResult = ring_reverse( @Sort(This.Content()) )
		return aResult

		def SortInDescendingQ()
			This.SortInDescending()
			return This

		def SortDown()
			This.SortInDesending()

			def SortDownQ()
				return This.SortInDescendingQ()

	def SortedInDescending()
		acResult = This.Copy().SortInDescendingQ().Content()
		return acResult

		def SortedDown()
			return This.SortedInDescending()
 
	  #-----------------------------------------------------------------#
	 #  SORTING THE STRINGS BY AN EVALUATED EXPRESSION - IN ASCENDING  #
	#=================================================================#
 
	def SortBy(pcExpr)

		if NOT (isString(pcExpr) and Q(pcExpr).ContainsCS("@number", :CS = FALSE))
			StzRaise("Incorrect param! pcExpr must be a string containing @number keyword.")
		ok

		pcExpr = Q(pcExpr).ReplaceQ("@number", "@item").Content()

		aContent = This.ToStzList().SortedBy(pcExpr)
		This.UpdateWith(aContent)

		#< @FunctionFluentForm

		def SortByQ(pcExpr)
			This.SortBy(pcExpr)
			return This

		#>

		#< @FunctionAlternativeForms

		def SortByInAscending(pcExpr)
			This.SortBy(pcExpr)

			def SortByInAscendingQ(pcExpr)
				return This.SortByQ(pcExpr)

		def SortByUp(pcExpr)
			This.SortBy(pcExpr)

			def SortByUpQ(pcExpr)
				return This.SortByQ(pcExpr)

		#>

	def SortedBy(pcExpr)
		aResult = This.Copy().SortByQ(pcExpr).Content()
		return aResult

		def SortedByInAscending(pcExpr)
			return This.SortedBy(pcExpr)

		def SortedByUp(pcExpr)
			return This.SortedBy(pcExpr)

	  #--------------------------------------------------------#
	 #  SORTING THE NUMBERS BY AN EXPRESSION - IN DESCENDING  #
	#--------------------------------------------------------#
 
	def SortByInDescending(pcExpr)
		aResult = ring_reverse( This.SortedByInAscending(pcExpr) )
		This.UpdateWith(aResult)

		def SortByInDescendingQ(pcExpr)
			This.SortByInDescending(pcExpr)
			return This

		def SortByDown(pcExpr)
			This.SortByInDescending(pcExpr)

			def SortByDownQ(pcExpr)
				return This.SortByInDescendingQ(pcExpr)

	def SortedByInDescending(pcExpr)
		aResult = This.Copy().SortByInDescendingQ(pcExpr).Content()
		return aResult

		def SortedByDown(pcExpr)
			return This.SortedByInDescending(pcExpr)
