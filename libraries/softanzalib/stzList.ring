#---------------------------------------------------------------------------#
# 		    SOFTANZA LIBRARY (V1.0) - STZITEM			    #
#		An accelerative library for Ring applications		    #
#---------------------------------------------------------------------------#
#									    #
# 	Description	: The core class for managing lists in Softanza     #
#	Version		: V1.0 (2020-2022)				    #
#	Author		: Mansour Ayouni (kalidianow@gmail.com)		    #
#									    #
#---------------------------------------------------------------------------#

  /////////////////////
 ///   FUNCTIONS   ///
/////////////////////

func StzListQ(paList)
	return new stzList(paList)

func StzListMethods()
	return Stz(:List, :Methods)

func StzListAttributes()
	return Stz(:List, :Attributes)

func StzListClassName()
	return "stzlist"

	func StzListClass()
		return "stzlist"

func L(p)

	if isList(p)
		return p

	but isString(p)

		if Q(p).IsListInString()
			return Q(p).ToList()

		but Q(p).ContainsNoSpaces()
			return Q(p).Chars()

		but Q(p).ContainsSpaces()
			return Q(p) / " "
		ok

	but isObject(p)
		return StzObject(p).ObjectAttributesAndValues()

	but isNumber(p)
		aResult = []
		for i = 1 to p
			aResult + NULL
		next

		return aResult

	else
		StzRaise("Incorrect param! Can't tranform param to list.")
	ok

	func LQ(p)
		return new stzList(L(p))

func ListIsListOfStzNumbers(paList)
	return StzListQ(paList).IsListOfStzNumbers()

func ListIsListOfStzStrings(paList)
	return StzListQ(paList).IsListOfStzStrings()

func ListIsListOfStzLists(paList)
	return StzListQ(paList).IsListOfStzLists()

func ListIsListOfStzObjects(paList)
	return StzListQ(paList).IsListOfStzObjects()

func ListReverse(paList)
	return reverse(paList) # Here we rely on the native Ring reverse() function

func ListFirstItem(paList)
	return paList[1]

	#< @AlternativeFunctionNames

	func FirstItemInList(paList)
		return ListFirstItem(paList)

	#>

func ListLastItem(paList)
	return paList[ len(paList) ]

	#< @AlternativeFunctionNames

	func LastItemInList(paList)
		return ListLastItem(paList)

	#>

func UpdateLastItem(paList, pValue)
	oTempList = new stzList(paList)
	return oTempList.UpdateLastItem(pValue)

func LastItemIn(paList)
	return paList( len(paList) )

func FirstListIn(paList)
	oTempList = new stzList(paList)
	return LastItemIn( oTempList.WalkUntilItemIsList() )

func GenerateListAccessCode_FromNameAndPath(pcListName, paPath)
	// Warining: aPath must contain only numbers!!!
	cCode = pcListName
	for n in paPath
		cCode += ("["+ n + ']')
	next

	return cCode
		
func ListIsSet(paList)
	oList = new stzList(paList)
	return oList.IsSet()

func ListIsListOfNumbers(paList)
	return StzListQ(paList).IsListOfNumbers()

func ListItemsAreAllStrings(paList)
	oTempList = new stzList(paList)
	return oTempList.ItemsAreAllStrings()

func ListIsHashList(paList)
	oTempList = new stzList(paList)
	return oTempList.IsHashList()

func ListIsListOfLists(paList)
	return StzListQ(paList).IsListOfLists()

func ListIsListOfSets(paList)
	return StzListQ(paList).IsListOfSets()



func ListIsListOfLetters(paList)
	return StzListQ(paList).IsListOfLetters()

func ListIsListOfHashLists(paList)
	return StzListQ(paList).IsListOfHashLists()

func ListIsListOfZerosAndOnes(paList)
	return StzListQ(paList).IsListOfZerosAndOnes()

func ListIsLocaleList(paList)
	return StzListQ(paList).IsLocaleList()

func CallMethod( pcMethod, paOnObjects )

	if NOT ( paOnObjects[1] = "on" and StzListQ(paOnObjects[2]).IsListOfStrings() )
		StzRaise(stzObjectError(:CanNotProcessMethodCall))
	ok

	aResult = []
	for cObjName in paOnObjects[2]
		cCode = "aResult + " + cObjName + "." + pcMethod
		eval(cCode)
	next
	return aResult

func AreChars(paChars)
	bResult = TRUE
	for c in paChars
		if NOT ( isString(c) and StringIsChar(c) )
			bResult = FALSE
			exit
		ok
	next
	return bResult

func AreBothChars(p1, p2)
	return AreChars([ p1, p2 ])

	func BothAreChars(p1, p2)
		return AreBothChars(p1, p2)
	
func AreBothAsciiChars(p1, p2)
	if IsAsciiChar(p1) and IsAsciiChar(p2)
		return TRUE
	else
		return FALSE
	ok

	func BothAreAsciiChars(p1, p2)
		return AreBothAsciiChars(p1, p2)

func AreBothEqual(p1, p2)
	return AreEqual([ p1, p2 ])

	func BothAreEqual(p1, p2)
		return AreEqual([ p1, p2 ])
	
		def BothAreNotEqual(p1, p2)
			return NOT BothAreEqual(p1, p2)

func AreEqual(paItems)
	return StzListQ(paItems).NumberOfOccurrence(paItems[1]) = len(paItems)

func HaveSameType(paItems)
	bResult = TRUE
	for i = 2 to len(paItems)
		if ring_type( paItems[i] ) != ring_type( paItems[i] )
			bResult = FALSE
			exit
		ok
	next
	return bResult

func BothHaveSameType(p1, p2)
	return ring_type(p1) = ring_type(p2)

func HaveSameContent(paItems)
	/* Two items have same content when:
	 if they are stringified they are equal strings.

	Stringifying number 12 generate string "12"
	*/
	if NOT isList(paItems)
		StzRaise("Incorrect param type! paItems must be a list.")
	ok

	if len(paItems) = 1
		return TRUE
	ok

	bResult = TRUE
	for i = 2 to len(paItems)
		bOk = Q( @@S( paItems[i] ) ).IsEqualTo( @@S( paItems[1] ) )
		if NOT bOk
			bResult = FALSE
			exit
		ok
	next
	return bResult

func HaveBothSameType(p1, p2)
	return ring_type(p1) = ring_type(p2)

func IsEmptyList(paList)
	return StzListQ(paList).IsEmpty()
		
	def IsAnEmptyList(paList)

func ListShow(paList)
	StzListQ(paList).Show()

func AreNumbers(paList)
	return StzListQ(paList).ContainsOnlyNumbers()

	def AllAreNumbers(paList)
		return AreNumbers(paList)

	def AreAllNumbers(paList)
		return AreNumbers(paList)

	def TheseAreNumbers(paList)
		return AreNumbers(paList)

	def AllTheseAreNumbers(paList)
		return AreNumbers(paList)

func AreStrings(paList)
	return StzListQ(paList).ContainsOnlyStrings()

	def AllAreStrings(paList)
		return AreStrings(paList)

	def AreAllStrings(paList)
		return AreStrings(paList)

	def TheseAreStrings(paList)
		return AreStrings(paList)

	def AllTheseAreStrings(paList)
		return AreStrings(paList)

func AreLists(paList)
	return StzListQ(paList).ContainsOnlyLists()

	def AllAreLists(paList)
		return AreLists(paList)

	def AreAllLists(paList)
		return AreLists(paList)

	def TheseAreLists(paList)
		return AreLists(paList)

func AreObjects(paList)
	return StzListQ(paList).ContainsOnlyObjects()

	def AllAreObjects(paList)
		return AreObjects(paList)

	def AreAllObjects(paList)
		return AreObjects(paList)

	def TheseAreObjects(paList)
		return AreObjects(paList)

func ListIsListOfStrings(paList)
	return StzListQ(paList).IsListOfStrings()

	func IsListOfStrings(paList)
		return ListIsListOfStrings(paList)

func IsRangeNamedParamList(paList)
	return StzListQ(paList).IsRangeNamedParam()

	func ListIsRangeNamedParamList(paList)
		return This.IsRangeNamedParamList(paList)

func ListToCode(paList)
	return StzListQ( paList ).ToCode()


func AllTheseAreNull(paList)
	return StzListQ(paList).AllItemsAreNull()

	func AllOfTheseAreNull(paList)
		return AllTheseAreNull(paList)

	func TheseAreNull(paList)
		return AllTheseAreNull(paList)

func AllOfTheseAreNotNull(paList)
	bResult = TRUE
	for item in paList
		if isString(item) and isNull(item)
			bResult = FALSE
			exit
		ok
	next

	return bResult

	func NoOneOfTheseIsNull(paList)
		return AllOfTheseAreNotNull(paList)

	func TheseAreNotNull(paList)
		return AllOfTheseAreNotNull(paList)

func BothAreNull(p1, p2)
	return TheseAreNull([ p1, p2 ])

func BothAreNotNull(p1, p2)
	return TheseAreNotNull([ p1, p2 ])

func NoOneOfTheseIsAString(paList)
	bResult = TRUE
	for item in paList
		if isString(item)
			bResult = FALSE
			exit
		ok
	next
	
	return bResult


func List@(paList)
	if isList(paList)
		return ComputableForm(paList)
	ok

func ListFindAll(paList, p)
	return StzListQ(paList).FindAll(p)

func ListOfNTimes(n, pItem)
	aResult = []
	for i = 1 to n
		aResult + pItem
	next
	return aResult

func ContiguousListOfChars(cChar1, cChar2)
	anUnicodes = []
	for i = CharUnicode(cChar1) to CharUnicode(cChar2)
		anUnicodes + i
	next

	aResult = []

	if StzListOfNumbersQ(anUnicodes).IsContiguous()

		for n in anUnicodes
			aResult + StzCharQ(n).Content()
		next
	
		return aResult

	else
		StzRaise( "The chars you privided don't form a contiguous list!")
	ok

	func ContiguousList(cChar1, cChar2)
		return ContinuousListOfChars(cChar1, cChar2)

	func ContinuousListOfChars(cChar1, cChar2)
		return ContiguousListOfChars(cChar1, cChar2)

	func ContinuousList(cChar1, cChar2)
		return ContiguousList(cChar1, cChar2)

func ListXT(p)

	if isList(p)
		return p

	but isString(p) and StzStringQ(p).IsListInShortForm()
		aResult = StzStringQ(p).ToList()
		return aResult

	else
		StzRaise("Can't process the param you provided! It must be a list or a list in string.")
	ok

func List(pFrom, pTo)
	/* EXAMPLE

	? ListXT( :From = "A", :To = "D" )
	#--> [ "A", "B", "C", "D" ]

	*/

	if isList(pFrom) and Q(pFrom).IsFromNamedParam()
		pFrom = pFrom[2]
	ok

	if isList(pTo) and Q(pTo).IsToNamedParam()
		pTo = pto[2]
	ok

	if NOT BothAreChars(pFrom, pTo)
		StzRaise("Incorrect params! Bonth pFrom and pTo must be chars.")
	ok

	return ContiguousList(pFrom, pto)

  /////////////////
 ///   CLASS   ///
/////////////////

class stzList from stzObject
	@aContent = []

	@aWalkers = []

	  #--------------#
	 #     INIT     #
	#--------------#

	def init(paList)
		if isList(paList)
			@aContent = paList

		but isString(paList)
			try
				@aContent = StzStringQ(paList).ToList()
			catch
				StzRaise("Can't transform the string to a list!")
			done

		else
			StzRaise("Can't create the stzList object!")
		ok

	  #---------------------#
	 #     CONSTRAINTS     #
	#---------------------#
	// TODO: Finish stzConstraint --> Finsh Constraints section here and
	// in other classes (StzString...)
/*
	def MustBe(pcIsMethod)


	def CanNotBe(pcIsMethod)
*/

	  #-----------------#
	 #     GENERAL     #
	#-----------------#

	def Content()
		return @aContent

	def List()
		return Content()

		def ListQ() # Same as Copy()
			return new stzList( This.List() )

	def Copy()
		return new stzList( This.List() )

	def ReversedCopy()
		return This.ReverseQ()

	def NumberOfItems()
		return len(This.Content())

		def NumberOfItemsQ()
			return new stzNumber(This.NumberOfItems())

		def Size()
			return This.NumberOfItems()

		def Length()
			return This.NumberOfItems()

		def CountItems()
			return This.NumberOfItems()

		def HowManyItems()
			return This.NumberOfItems()
	
	def Items()
		return This.Content()

		#< @FunctionFluentForm

		def ItemsQ()
			return This

		#>

	def Item(n)

		if isString(n)
			if Q(n).Lowercased() = "first"
				n = 1

			but Q(n).Lowercased() = "last"
				n = This.NumberOfItems()

			ok
		ok

		if NOT isNumber(n)
			StzRaise("Incorrect param type! n should be a number.")
		ok

		return This.Content()[n]

		def ItemQ(n)
			return Q(This.Item(n))

		#< @AlternativeFunctionNames

		def NthItem(n)
			return This.Item(n)

			def NthItemQ(n)
				return Q(This.NthItem(n))

		def ItemAtPosition(n)
			return This.Item(n)

		def ItemAt(n)
			return This.Item(n)

		#>

	def FirstItem()
		return This.NthItem(1)

		def FirstItemQ()
			return Q(This.FirstItem())

	def LastItem()
		return This.NthItem( This.NumberOfItems() )

		def LastItemQ()
			return Q(This.LastItem())
		
	def CentralPosition()
		oTemp = new stzNumber( (This.NumberOfItems()/2) )
		n = oTemp.IntegerPartValue()
		return n

		def CentralItemPosition()
			return This.CentralPosition()

	def CentralItem()
		return This[CentralPosition()]

		def CentralItemQ()
			return Q(This.CentralItem())

	def HasCentralItem()
		return This.NumberOfItemsQ().IsNotEven()

	def NFirstItems(n)
		return This.Section(1, n)
		
		def NFirstItemsQ(n)
			return NFirstItemsQR(n, :stzList)

		def NFirstItemsQR(n, pcReturnType)
			if isList(pcReturnType) and
			   Q(pcReturnType).IsReturnedAsNamedParam()

				pcReturnType = pcReturnType[2]
			ok

			if NOT isString(pcReturnType)
				StzRaise("Incorrect param type! pcReturnType must be a string.")
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.NFirstItems(n) )

			on :stzListOfStrings
				return new stzListOfStrings( This.NFirstItems(n) )

			on :stzListOfNumbers
				return new stzListOfNumbers( This.NFirstItems(n) )

			other
				StzRaise("Unsupported return type!")
			off

		def FirstNItems(n)
			return This.NFirstItems(n)

			def FirstNItemsQ(n)
				return This.NFirstItemsQ(n)

			def FirstNItemsQR(n, pcReturnType)
				return This.NFirstItemsQR(n, pcReturnType)

	def NLastItems(n)
		return This.Section( This.NumberOfItems() - n + 1, :LastItem)

		def NLastItemsQ(n)
			return NLastItemsQR(n, :stzList)

		def NLastItemsQR(n, pcReturnType)
			if isList(pcReturnType) and
			   Q(pcReturnType).IsReturnedAsNamedParam()
				pcReturnType = pcReturnType[2]
			ok

			if NOT isString(pcReturnType)
				StzRaise("Incorrect param type! pcReturnType must be a string.")
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.NLastItems(n) )

			on :stzListOfStrings
				return new stzListOfStrings( This.NLastItems(n) )

			on :stzListOfNumbers
				return new stzListOfNumbers( This.NLastItems(n) )

			other
				StzRaise("Unsupported return type!")
			off

		def LastNItems(n)
			return This.NLastItems(n)

			def LastNItemsQ(n)
				return This.NLastItemsQ(n)

			def LastNItemsQR(n, pcReturnType)
				return This.NLastItemsQR(n, pcReturnType)

	  #---------------------------------------------#
	 #  NEXT N ITEMS STARTING AT A GIVEN POSITION  #
	#---------------------------------------------#

	def NextNItems(n, pnStartingAt)

		# Checking params

		if NOT isNumber(n)
			StzRaise("Incorrect param type! n must be a number.")
		ok

		if isList(pnStartingAt) and Q(pnStartingAt).IsStartingAtNamedParam()
			pnStartingAt = pnStartingAt[2]
		ok

		if isString(pnStartingAt)
			if pnStartingAt = :First or pnStartingAt = :FirstItem
				pnStartingAt = 1

			but pnStartingAt = :Last or pnStartingAt = :LastItem
				pnStartingAt = This.NumberOfItems()
			ok
		ok

		if NOT isNumber(pnStartingAt)
			StzRaise("Incorrect param type! pnStartingAt must be a number.")
		ok

		if pnStartingAt < 0
			pnStartingAt = This.NumberOfItems() - Abs(pnStartingAt) + 1
		ok

		# Doing the job

		acResult = This.SectionQ(pnStartingAt, pnStartingAt + n - 1).Items()

		return acResult

		#< @FunctionFluentForm

		def NextNItemsQ(n, pnStartingAt)
			return This.NextNItemsQR(n, pnStartingAt, :stzList)

		def NextNItemsQR(n, pnStartingAt, pcReturnType)
			switch pcReturnType
			on :stzList
				return new stzList( This.NextNItems(n, pnStartingAt) )

			on :stzListOfStrings
				return new stzListOfStrings( This.NextNItems(n, pnStartingAt) )

			on :stzListOfChars
				return new stzListOfChars( This.NextNItems(n, pnStartingAt) )

			on :stzListOfNumbers
				return new stzListOfNumbers( This.NextNItems(n, pnStartingAt) )

			on :stzListOfLists
				return new stzListOfLists( This.NextNItems(n, pnStartingAt) )

			on :stzListOfPairs
				return new stzListOfPairs( This.NextNItems(n, pnStartingAt) )

			on :stzListOfObjects
				return new stzListOfObjects( This.NextNItems(n, pnStartingAt) )

			other
				StzRaise("Unsupported return type!")
			off

		#>

	  #-------------------------------------------------#
	 #  PREVIOUS N CHARS STARTING AT A GIVEN POSITION  #
	#-------------------------------------------------#

	def PreviousNItems(n, pnStartingAt)

		# Checking params

		if NOT isNumber(n)
			StzRaise("Incorrect param type! n must be a number.")
		ok

		if isList(pnStartingAt) and Q(pnStartingAt).IsStartingAtNamedParam()
			pnStartingAt = pnStartingAt[2]
		ok

		if isString(pnStartingAt)
			if pnStartingAt = :First or pnStartingAt = :FirstItem
				pnStartingAt = 1

			but pnStartingAt = :Last or pnStartingAt = :LastItem
				pnStartingAt = This.NumberOfItems()
			ok
		ok

		if NOT isNumber(pnStartingAt)
			StzRaise("Incorrect param type! pnStartingAt must be a number.")
		ok

		if pnStartingAt < 0
			pnStartingAt = This.NumberOfItems() - Abs(pnStartingAt) + 1
		ok

		# Doing the job

		acResult = This.SectionQ(pnStartingAt - n + 1, pnStartingAt).Items()

		return acResult


		#< @FunctionFluentForm

		def PreviousNItemsQ(n, pnStartingAt)
			return This.PreviousNItemsQR(n, pnStartingAt, :stzList)

		def PreviousNItemsQR(n, pnStartingAt, pcReturnType)
			switch pcReturnType
			on :stzList
				return new stzList( This.PreviousNItems(n, pnStartingAt) )

			on :stzListOfStrings
				return new stzListOfStrings( This.PreviousNItems(n, pnStartingAt) )

			on :stzListOfChars
				return new stzListOfChars( This.PreviousNItems(n, pnStartingAt) )

			on :stzListOfNumbers
				return new stzListOfNumbers( This.PreviousNItems(n, pnStartingAt) )

			on :stzListOfLists
				return new stzListOfLists( This.PreviousNItems(n, pnStartingAt) )

			on :stzListOfPairs
				return new stzListOfPairs( This.PreviousNItems(n, pnStartingAt) )

			on :stzListOfObjects
				return new stzListOfObjects( This.PreviousNItems(n, pnStartingAt) )

			other
				StzRaise("Unsupported return type!")
			off

		#>

	  #--------------------#
	 #      UPDATING      #
	#--------------------#

	/*
	Semantic Note:
		Update	-> Assigning a hole new list to the list
		Replace	-> Replacing items or sections of items
	*/

	def Update(paNewList)
		if isList(paNewList) and
		   ( StzListQ(paNewList).IsWithNamedParam() or StzListQ(paNewList).IsUsingNamedParam() )

			paNewList = paNewList[2]

		ok

		@aContent = paNewList

		#< @FunctionAlternativeForm

		def UpdateWith(paNewList)
			This.Update(paNewList)

		#>

	def UpdateQ(paNewList)
		This.Update(paNewList)
		return This

		#< @FunctionAlternativeForm

		def UpdateWithQ(paNewList)
			return This.UpdateQ(paNewList)

		#>

	  #----------------------#
	 #     ADDING ITEMS     #
	#----------------------#

	def SetNumberOfItems(n)
		nCurrentLen = This.NumberOfItems()
		nNewLen = n

		aResult = []
		if nNewLen = nCurrentLen
			// Do nothing

		but nNewLen > nCurrentLen
			This.AddItemAt(n)

		but nNewLen < nCurrentLen
			This.Section(1, nNewLen)
		ok

		#< @FunctionFluentForm

		def SetNumberOfItemsQ(n)
			This.SetNumberOfItems(n)
			return This

		#>

	def AddItem(pItem)
		@aContent + pItem

		#< @FunctionAlternativeForm

		def Add(pItem)
			This.AddItem(pItem)

		#>

	def AddItemQ(pItem)
		This.AddItem(pItem)
		return This

		#< @FunctionFluentForm

		def AddQ(pItem)
			This.Add(pItem)
			return This

		#>

	def AddItemAt(n, pItem)

		aResult = []
		// Items can be added only at a position bigger then NumberOfItems()
		if n < This.NumberOfItems() + 1
			StzRaise("Can't add the item at this position! n must be bigger than NumberOfItems()")
		else
			/*
			If we add an item at a position bigger then NumberOfItems()
			then the list is extended and the positions in between are filled
			with NULL or 0s, depending on wether the list IsHybrid() or it
			ContainsOnlyNumbers()
			*/
			aResult = This.ExtendtoPositionQ(n).Content()
			aResult + pItem
		ok

		This.Update( aResult )

		#< @FunctionFluentForm

		def AddItemAtQ(n, pItem)
			This.AddItem(n, pItem)
			return This

		#>

		#< @FunctionAlternativeForms

		def AddItemAtPosition(n, pItem)
			This.AddItemAt(n, pItem)

			def AddItemAtPositionQ(n, pItem)
				This.AddItemAtPosition(n, pItem)
				return This

		def AddAt(n, pItem)
			This.AddItem(n, pItem)

			def AddAtQ(n, pItem)
				This.AddAt(n, pItem)
				return This
	
		def AddAnNthItem(n, pItem)
			This.AddItem(n, pItem)

			def AddAnNthItemQ(n, pItem)
				This.AddAnNthItem(n, pItem)
				return This

		#>

	  #===================================================#
	 #     INSERTING AN ITEM BEFORE A GIVEN POSITION     #
	#===================================================#

	def Insert(pItem, pWhere)

		if isList(pItem) and Q(pItem).IsItemNamedParam()
			pItem = pItem[2]
		ok

		if isList(pWhere)
			if Q(pWhere).IsOneOfTheseNamedParams([
				:At, :AtPosition, :Before, :BeforePosition ])

				This.InsertBefore(pWhere[2], pItem)
				return

			but Q(pWhere).IsOneOfTheseNamedParams([ :After, :AfterPosition ])

				This.InsertAfter(pWhere[2], pItem)
				return
			ok
		else
			This.InsertBefore(pWhere, pItem)
		ok

		#< @FunctionFluentForm

		def InsertQ(pItem, pWhere)
			This.Insert( pItem, pWhere )
			return This

		#>

		#< @FunctionAlternativeForm

		def InsertItem(pItem, pWhere)
			This.Insert(pItem, pWhere)

			def InsertItemQ(pItem, pWhere)
				This.InsertItem(pItem, pWhere)
				return This
		#>

	def InsertBeforePosition(n, pItem)
		if isList(n) and Q(n).IsPositionNamedParam()
			n = n[2]
		ok

		if isList(n) and Q(n).IsListOfNumbers()
			This.InsertBeforePositions(n, pItem)
			return
		ok

		if isList(pItem) and Q(pItem).IsItemNamedParam()
			pItem = pItem[2]
		ok

		if n >= 1 and n <= This.NumberOfItems()
			ring_insert(This.List(), n-1, pItem)

		but n > This.NumberofItems()
			This.ExtendToN(n)
			ring_insert(This.List(), n-1, pItem)
			# Using Ring native insert function here
		ok

		#< @FunctionFluentForm

		def InsertBeforePositionQ(n, pItem)
			This.InsertBeforePosition(n, pItem)
			return This

		#>

		#< @FunctionAlternativeForm

		def InsertBefore(n, pItem)
			if isList(n) and Q(n).IsOneOfTheseNamedParams([ :Position, :ItemAt, :ItemAtPosition ])
				n = n[2]
			ok

			This.InsertBeforePosition(n, pItem)

			def InsertBeforeQ(n, pItem)
				This.InsertBefore(n, pItem)
				return This

		def InsertAt(n, pItem)
			if isList(n) and Q(n).IsOneOfTheseNamedParams([ :Position, :ItemAt, :ItemAtPosition ])
				n = n[2]
			ok

			This.InsertBeforePosition(n, pItem)

			def InsertAtQ(n, pItem)
				This.InsertAt(n, pItem)
				return This

		#>
		
	  #----------------------------------------------------#
	 #     INSERTING AN ITEM AFTER A GIVEN POSITION      #
	#----------------------------------------------------#

	def InsertAfterPosition(n, pItem)

		if isList(n) and Q(n).IsListOfNumbers()
			This.InsertAfterPositions(n, pItem)
			return
		ok

		if n > 0 and n < This.NumberOfItems()
			ring_insert(This.List(), n, pItem)

		ok

		#< @FunctionFluentForm

		def InserAfterPositionQ(n, pItem)
			This.InsertAfterPosition(n, pItem)
			return This

		#>

		#< @FunctionAlternativeForm

		def InsertAfter(n, pItem)
			if isList(n) and Q(n).IsOneOfTheseNamedParams([ :Position, :ItemAt, :ItemAtPosition ])
				n = n[2]
			ok

			This.InsertAfterPosition(n, pItem)

			def InsertAfterQ(n, pItem)
				This.InsertAfter(n, pItem)
				return This

		#>

	#---------------------------------------#
	# TODO: Add same functions as stzString #
	#---------------------------------------#
	
	/*
	INSERTING BEFORE/AFTER THE NTH OCCURRENCE OF AN ITEM
		INSERTING BEFORE/AFTER THE FIRST OCCURRENCE OF AN ITEM
		INSERTING BEFORE/AFTER THE LAST OCCURRENCE OF AN ITEM
	
	INSERTING BEFORE THE NEXT NTH OCCURRENCE OF AN ITEM STARTING AT
		INSERTING BEFORE/AFTER THE NEXT OCCURRENCE OF AN ITEM STARTING AT
	
	INSERTING BEFORE THE PREVIOUS NTH OCCURRENCE OF AN ITEM STARTING AT
		INSERTING BEFORE/AFTER THE PREVIOUS OCCURRENCE OF AN ITEM STARTING AT
	*/

	  #--------------------------------#
	 #     OTHER INSERTING FORMS      # TODO
	#--------------------------------#

	def InsertAfterEachNumberOfSteps(n, pItem) // TODO
		/* Example : InsertAfterEachNumberOfSteps(2, "*")
		a = [ "A" , "B" , "C"  , "D" , "E" , "F" , "G" ]
		-->
		a = [ "A" , "B" , "*" , "D" , "E" , "*" , "F" , "G" ]
		*/

	def InsertAfterEachSequenceOfSteps(paSteps, pItem) // TODO
		/* Example : InsertAfterEachSequenceOfSteps([2,1], pcStr)
		a = [ "A" , "B" , "C"  , "D" , "E" , "F" , "G" ]
		-->
		a = [ "A" , "B" , "*" , "D" , "*" "E" , "F" , "*" , "G" , "*" ]
		*/

	def InsertRandomlyBefore(pItem)
		n = random( This.NumberOfItems() )
		This.InsertBefore(n, pItem)

		#< @FunctionFluentForm

		def InsertRandomlyBeforeQ(pItem)
			This.InsertRandomlyBefore(pItem)
			return This

		#>

	def InsertRandomlyAfter(pItem)
		n = random( This.NumberOfItems() )
		This.InsertAfter(n, pItem)

		#< @FunctionFluentForm

		def InsertRandomlyAfterQ(pItem)
			This.InsertRandomlyAfter(pItem)
			return This

		#>

	  #---------------------------------------------#
	 #  MOVING ITEM AT POSITION N1 TO POSITION N2  #
	#---------------------------------------------#

	def Move(n1, n2)

		# Checking params correctness

		if isList(n1) and
		   Q(n1).IsOneOfTheseNamedParams([
			:From, :FromPosition,
			:At, :AtPosition,
			:Item, :ItemAt, :ItemAtPosition,
			:FromItemAt, :FromItemAtPosition,
			:ItemFrom, :ItemFromPosition
		   ])

			n1 = n1[2]
		ok

		if isList(n2) and
		   Q(n2).IsOneOfTheseNamedParams([
			:To, :ToPosition, :ToItem, :ToItemAt,
			:ToItemAtPosition, :ToPositionOfItem ])

			n2 = n2[2]
		ok

		if isString(n1) and
		   Q(n1).IsOneOfThese([ :First, :FirstPosition, :FirstItem ])
				    
			n1 = 1
		ok

		if isString(n2) and
		   Q(n1).IsOneOfThese([ :Last, :LastPosition, :LastItem ])

			n2 = This.NumberOfItems()
		ok

		if NOT BothAreNumbers(n1, n2)
			StzRaise("Incorrect param type! n1 and n2 must be numbers.")
		ok

		# Doing the job
		
		if n1 > n2
		# . . . 2 . . 1 . .
		#       ^     |
		#       |_____|

			TempItem = This[n1]
			This.RemoveAt(n1)
			This.InsertBefore(n2, TempItem)

		but n1 < n2
		# . . . 1 . . 2 . .
		#       |     ^
		#       |_____|

			TempItem = This[n1]

			if n2 = This.NumberOfItems()
				This.AddItem(TempItem)
			else
				This.InSertAfter(n2, TempItem)
			ok

			This.RemoveAt(n1)
		ok

		#< @FunctionAlternativeForm

		def MoveItem(n1, n2)
			This.Move(n1, n2)

		#>

	  #-----------------------------------------#
	 #  SWAPPING ITEMS AT TWO GIVEN POSITIONS  #
	#-----------------------------------------#

	def Swap(n1, n2)
		if isList(n1) and
		   Q(n1).IsOneOfTheseNamedPArams([
			:Between, :BetweenPosition, :BetweenPositions,
			:BetweenItem, :BetweenItems,
			:BetweenItemAt, :BetweenItemAtPosition, :BetweenItemAtPositions,
			:Position, :Positions, :ItemAt, :ItemAtPosition, :ItemAtPositions,
			:Items, :ItemsAt, :ItemsAtPosition, :ItemsAtPositions
		   ])

			n1 = n1[2]
		ok

		if isList(n2) and
		   Q(n2).IsOneOfTheseNamedPArams([
			:And, :AndPosition, :AndItemAt, :AndItemAtPosition, :AndItem ])

			n2 = n2[2]
		ok

		copy = This[n2]
		This.ReplaceNth(n2, :By = This[n1])
		This.ReplaceNth(n1, :By = copy)

		#< @FunctionAlternativeForms

		def SwapBetween(n1, n2)
			This.Swap(n1, n2)

		def SwapBetweenPositions(n1, n2)
			This.Swap(n1, n2)

		def SwapItems(n1, n2)
			if isList(n1) and
			   Q(n1).IsOneOfTheseNamedParams([ :At, :AtPosition, :AtPositions ])
				n1 = n1[2]
			ok
	
			if isList(n2) and
			   Q(n2).IsOneOfTheseNamedParams([ :And, :AndPosition ])
				n2 = n2[2]
			ok
	
			This.Swap(n1, n2)

		def SwapItem(n1, n2)
			if isList(n1) and
			   Q(n1).IsOneOfTheseNamedParams([ :At, :AtPosition ])
				n1 = n1[2]
			ok
	
			if isList(n2) and
			   Q(n2).IsOneOfTheseNamedParams([
				:And, :AndPosition, :AndItemAt, :AndItemAtPosition ])

				n2 = n2[2]
			ok
	
			This.Swap(n1, n2)
		#>

	  #=========================================#
	 #   REPLACING ALL ITEMS WITH A NEW ITEM   #
	#=========================================#

	def ReplaceAllItems(pNewItem)

		for i = 1 to This.NumberOfItems()
			This.ReplaceItemAtPosition(i, pNewItem)
		next

		#< @FunctionFluentForm

		def ReplaceAllItemsQ(pNewItem)
			This.ReplaceAllItems(pNewItem)
			return This
		#>

	  #-------------------------------------------#
	 #   REPLACING ALL OCCURRENCES OF AN ITEM    # TODO: Add Case Sensitivity
	#-------------------------------------------#

	def ReplaceAllOccurrences(pItem, pNewItem)
			
		if isList(pItem) and StzListQ(pItem).IsOfNamedParam()
			pItem = pItem[2]
		ok

		anPositions = This.FindAll(pItem)

		for n in anPositions
			This.ReplaceItemAtPosition(n, pNewItem)
		next

		#< @FunctionFluentForm

		def ReplaceAllOccurrencesQ(pItem, pNewIteme)
			This.ReplaceAllOccurrences(pItem, pNewItem)
			return This
		#>

		#< @FunctionAlternativeForms

		def ReplaceItem(pItem, pNewItem)
			This.ReplaceAllOccurrences(pItem, pNewItem)

			def ReplaceItemQ(pItem, pNewItem)
				This.ReplaceItem(pItem, pNewIteme)
				return This

		def ReplaceAll(pItem, pNewItem)
			This.ReplaceAllOccurrences(pItem, pNewItem)

			def ReplaceAllQ(pItem, pNewItem)
				This.ReplaceAll(pItem, pNewIteme)
				return This

		def Replace(pItem, pNewItem)
			This.ReplaceAllOccurrences(pItem, pNewItem)

			def ReplaceQ(pItem, pNewIteme)
				This.Replace(pItem, pNewItem)
				return This

		#>

	def ItemReplacedBy(pItem, pNewItem)

		aResult =  This.Copy().
				ReplaceItemQ(pItem, pNewItem).
				Content()

		return aResult

		def AllOccurrencesOfItemReplacedBy(pItem, pNewItem)
			return ItemReplacedBy(pItem, pNewItem)

	  #------------------------------------------------#
	 #   REPLACING SOME OCCURRENCES OF A GIVEN ITEM   #
	#------------------------------------------------#

	def ReplaceTheseOccurrences(panOccurr, pItem, pNewItem)

		anPositions = This.FindAllQ(pItem).ItemsAt(panOccurr)
		This.ReplaceItemsAtPositions(anPositions, pNewItem)

		def ReplaceTheseOccurrencesQ(panOccurr, pItem, pNewItem)
			This.ReplaceTheseOccurrences(panOccurr, pItem, pNewItem)
			return This

		def ReplaceOccurrences(panOccurr, pItem, pNewItem)
			This.ReplaceTheseOccurrences(panOccurr, pItem, pNewItem)

			def ReplaceOccurrencesQ(panOccurr, pItem, pNewItem)
				This.ReplaceOccurrences(panOccurr, pItem, pNewItem)
				return This


	def TheseOccurrencesReplaced(panOccurr, pItem, pNewItem)
		This.ReplaceTheseOccurrencesQ(panOccurr, pItem, pNewItem)
		return This

		def OccurrencesReplaced(panOccurr, pItem, pNewItem)
			return This.TheseOccurrencesReplaced(panOccurr, pItem, pNewItem)

	  #----------------------------------------------#
	 #   REPLACING FIRST N OCCURRENCES OF AN ITEM   #
	#----------------------------------------------#

	def ReplaceFirstNOccurrences(n, pItem, pNewItem)
		This.ReplaceTheseOccurrences( 1 : n, pItem, pNewItem )

		def ReplaceFirstNOccurrencesQ(n, pItem, pNewItem)
			This.ReplaceFirstNOccurrences(n, pItem, pNewItem)
			return This

		def ReplaceNFirstOccurrences(n, pItem, pNewItem)
			This.ReplaceFirstNOccurrences(n, pItem, pNewItem)

			def ReplaceNFirstOccurrencesQ(n, pItem, pNewItem)
				This.ReplaceNFirstOccurrences(n, pItem, pNewItem)

	def FirstNOccurrencesReplaced(n, pItem, pNewItem)
		return This.Copy().ReplaceFirstNOccurrencesQ(n, pItem, pNewItem).Content()

		def NFirstOccurrencesReplaced(n, pItem, pNewItem)
			return This.FirstNOccurrencesReplaced(n, pItem, pNewItem)

	  #---------------------------------------------#
	 #   REPLACING LAST N OCCURRENCES OF AN ITEM   #
	#---------------------------------------------#

	def ReplaceLastNOccurrences(n, pItem, pNewItem)
		nNumberOfOccurr = This.NumberOfOccurrences(pItem)
		n1 = nNumberOfOccurr - n + 1
		This.ReplaceTheseOccurrences( n1 : nNumberOfOccurr, pItem, pNewItem )

		def ReplaceLastNOccurrencesQ(n, pItem, pNewItem)
			This.ReplaceLastNOccurrences(n, pItem, pNewItem)
			return This

		def ReplaceNLastOccurrences(n, pItem, pNewItem)
			This.ReplaceLastNOccurrences(n, pItem, pNewItem)

			def ReplaceNLastOccurrencesQ(n, pItem, pNewItem)
				This.ReplaceNLastOccurrences(n, pItem, pNewItem)

	def LastNOccurrencesReplaced(n, pItem, pNewItem)
		return This.Copy().ReplaceLastNOccurrencesQ(n, pItem, pNewItem).Content()

		def NLastOccurrencesReplaced(n, pItem, pNewItem)
			return This.LastNOccurrencesReplaced(n, pItem, pNewItem)

	  #---------------------------------------------#
	 #    REPLACING MANY ITEMS AT THE SAME TIME    #
	#---------------------------------------------#

	def ReplaceManyItems(pacItems, pNewItem)

		for item in pacItems
			This.ReplaceAllOccurrences(item, pNewItem)
		next

		#< @FunctionFluentForm

		def ReplaceManyItemsQ(pacItems, pNewItem)
			This.ReplaceManyItems(pacItems, pNewItem)
			return This

		#>

		#< @FunctionAlternativeForms

		def ReplaceMany(pacItems, pNewItem)
			This.ReplaceManyItems(pacItems, pNewItem)

			def ReplaceManyQ(pacItems, pNewItem)
				This.ReplaceMany(pacItems, pNewItem)
				return This

		def ReplaceAllOfThese(pacItems, pNewItem)
			This.ReplaceManyItems(pacItems, pNewItem)

			def ReplaceAllOfTheseQ(pacItems, pNewItem)
				This.ReplaceAllOfThese(pacItems, pNewItem)
				return This

		#--

		def ReplaceTheseItems(pacItems, pNewItem)
			This.ReplaceManyItems(pacItems, pNewItem)

			def ReplaceTheseItemsQ(pacItems, pNewItem)
				This.ReplaceTheseItems(pacItems, pNewItem)
				return This

		#>

	def ManyItemsReplaced(pacItems, pNewItem)

		aResult  = This.Copy().
				ReplaceTheseItemsQ(pacItems, pNewItem).
				Content()

		return aResult

		def TheseItemsReplaced(pacItems, pNewItem)
			return This.ManyItemsReplaced(pacItems, pNewItem)
	
	  #------------------------------------------------------#
	 #    REPLACING MANY ITEMS BY MANY OTHERS ONE BY ONE    #
	#------------------------------------------------------#

	def ReplaceManyByMany(pacItems, pacNewItems)
		if NOT isList(pacItems)
			StzRaise("Uncorrect param! pacItems must be a list.")
		ok

		if isList(pacNewItems) and Q(pacNewItems).IsWithOrByNamedParam()
			pacNewItems = pacNewItems[2]
		ok

		if NOT isList(pacNewItems)
			StzRaise("Uncorrect param! pacNewItems must be a list.")
		ok

		i = 0
		for item in pacItems

			i++
			cNewStr = NULL

			if i <= len(pacNewItems)
				cNewStr = pacNewItems[i]
			ok

			This.Replace(item, cNewStr)

		next

		def ReplaceManyByManyQ(pacItems, pacNewItems)
			This.ReplaceManyByMany(pacItems, pacNewItems)
			return This

		def ReplaceManyOneByOne(pacItems, pacNewItems)
			This.ReplaceManyByMany(pacItems, pacNewItems)

			def ReplaceManyOneByOneQ(pacItems, pacNewItems)
				This.ReplaceManyOneByOne(pacItems, pacNewItems)
				return This

	  #------------------------------------#
	 #   REPLACING AN ITEM BY ALTERNANCE  #
	#------------------------------------#

	def ReplaceItemByAlternance(pItem, paOtherItems)
		/*
		StzListQ([ "A", "A", "A", "A", "A" ]) {
			ReplaceItemByAlternance("A", :With = [ "#1", "#2" ])
			? Content()

		}
		# --> [ "#1", "#2", "#1", "#2", "#1" ]
		*/

		if isList(paOtherItems) and
		   StzListQ(paOtherItems).IsWithOrByNamedParam()
		
			paOtherItems = paOtherItems[2]
		ok

		if NOT isList(paOtherItems)
			StzRaise("Incorrect param type! paOtherItems must be a list.")
		ok

		anPositions = This.FindAll(pItem)

		i = 0
		for nPos in anPositions
			i++
			if i > len(paOtherItems)
				i = 1
			ok
			This.ReplaceItemAtPosition(nPos, paOtherItems[i])
			
		next

		#< @FunctionFluentForm

		def ReplaceItemByALternanceQ(pItem, paOtherItems)
			This.ReplaceItemByALternance(pItem, paOtherItems)
			return This

		#>

	def ItemReplacedByAlternance(pItem, paOtherItems)

		aResult  = This.Copy().
				ReplaceItemByALternanceQ(pItem, paOtherItems).
				Content()

		return aResult
	
	   #------------------------------------------------#
	  #   REPLACING THE NEXT OCCURRENCES OF AN ITEM    #
         #   STARTING AT A GIVEN POSITION                 #
	#------------------------------------------------#

	def ReplaceNextOccurrencesCS(pItem, pOtherItem, pnStartingAt, pCaseSensitive)

		anPositions = This.FindNextOccurrencesCS(pItem, pnStartingAt, pCaseSensitive)
		This.ReplaceItemsAtPositions(anPositions, pOtherItem)

		def ReplaceNextOccurrencesCSQ(pItem, pOtherItem, pnStartingAt, pCaseSensitive)
			This.ReplaceNextOccurrencesCS(pItem, pOtherItem, pnStartingAt, pCaseSensitive)
			return This

		def ReplaceNextCS(pItem, pOtherItem, pnStartingAt, pCaseSensitive)
			This.ReplaceNextOccurrencesCS(pItem, pOtherItem, pnStartingAt, pCaseSensitive)

			def ReplaceNextCSQ(pItem, pOtherItem, pnStartingAt, pCaseSensitive)
				This.ReplaceNextCS(pItem, pOtherItem, pnStartingAt, pCaseSensitive)
				return This

	def NextOccurrencesReplacedCSQ(pItem, pOtherItem, pnStartingAt, pCaseSensitive)

		acResult = This.Copy().
				ReplaceNextOccurrencesCSQ(pItem, pOtherItem, pnStartingAt, pCaseSensitive).
				Content()
		return acResult

	#-- WITHOUT CASESENSITIVITY

	def ReplaceNextOccurrences(pItem, pOtherItem, pnStartingAt)
		This.ReplaceNextOccurrencesCS(pItem, pOtherItem, pnStartingAt, :CaseSensitive = TRUE)

		def ReplaceNextOccurrencesQ(pItem, pOtherItem, pnStartingAt)
			This.ReplaceNextOccurrences(pItem, pOtherItem, pnStartingAt)
			return This

		def ReplaceNext(pItem, pOtherItem, pnStartingAt)
			This.ReplaceNextOccurrences(pItem, pOtherItem, pnStartingAt)

			def ReplaceNextQ(pItem, pOtherItem, pnStartingAt)
				This.ReplaceNext(pItem, pOtherItem, pnStartingAt)
				return This

	def NextOccurrencesReplacedQ(pItem, pOtherItem, pnStartingAt)

		acResult = This.Copy().
				ReplaceNextOccurrencesQ(pItem, pOtherItem, pnStartingAt).
				Content()

		return acResult

	   #--------------------------------------------------#
	  #   REPLACING THE PREVIOUS OCCURRENCES OF AN ITEM  #
         #   STARTING AT A GIVEN POSITION                   #
	#--------------------------------------------------#

	def ReplacePreviousOccurrencesCS(pItem, pOtherItem, pnStartingAt, pCaseSensitive)

		anPositions = This.FindPreviousOccurrencesCS(pItem, pnStartingAt, pCaseSensitive)
		This.ReplaceItemsAtPositions(anPositions, pOtherItem)

		def ReplacePreviousOccurrencesCSQ(pItem, pOtherItem, pStartingAt, pCaseSensitive)
			This.ReplacePreviousOccurrencesCS(pItem, pOtherItem, pnStartingAt, pCaseSensitive)
			return This

		def ReplacePreviousCS(pItem, pOtherItem, pnStartingAt, pCaseSensitive)
			This.ReplacePreviousOccurrencesCS(pItem, pOtherItem, pnStartingAt, pCaseSensitive)

			def ReplacePreviousCSQ(pItem, pOtherItem, pnStartingAt, pCaseSensitive)
				This.ReplacePreviousCS(pItem, pOtherItem, pnStartingAt, pCaseSensitive)
				return This

	def PreviousOccurrencesReplacedCSQ(pItem, pOtherItem, pnStartingAt, pCaseSensitive)

		acResult = This.Copy().
				ReplacePreviousOccurrencesCSQ(pItem, pOtherItem, pnStartingAt, pCaseSensitive).
				Content()
		return acResult

	#-- WITHOUT CASESENSITIVITY

	def ReplacePreviousOccurrences(pItem, pOtherItem, pnStartingAt)
		This.ReplacePreviousOccurrencesCS(pItem, pOtherItem, pnStartingAt, :CaseSensitive = TRUE)

		def ReplacePreviousOccurrencesQ(pItem, pOtherItem, pStartingAt)
			This.ReplacePreviousOccurrences(pItem, pOtherItem, pnStartingAt)
			return This

		def ReplacePrevious(pItem, pOtherItem, pnStartingAt)
			This.ReplacePreviousOccurrences(pItem, pOtherItem, pnStartingAt)

			def ReplacePreviousQ(pItem, pOtherItem, pnStartingAt)
				This.ReplacePrevious(pItem, pOtherItem, pnStartingAt)
				return This

	def PreviousOccurrencesReplacedQ(pItem, pOtherItem, pnStartingAt)

		acResult = This.Copy().
				ReplacePreviousOccurrencesQ(pItem, pOtherItem, pnStartingAt).
				Content()
		return acResult

	  #-----------------------------------------#
	 #   REPLACING NTH OCCURRENCE OF AN ITEM   #
	#-----------------------------------------#

	def ReplaceNthOccurrenceCS(n, pItem, pOtherItem, pCaseSensitive)
		if isList(pItem) and StzListQ(pItem).IsOfNamedParam()
			pItem = pItem[2]
		ok

		if isList(pOtherItem) and
		   StzListQ(pOtherItem).IsWithOrByNamedParam()
		
			pOtherItem = pOtherItem[2]
		ok

		nItemPosition = This.FindNthOccurrenceCS(n, pItem, pCaseSensitive)
		This.ReplaceItemAtPositionCS(nItemPosition, pOtherItem, pCaseSensitive)

		#< @FunctionFluentForm

		def ReplaceNthOccurrenceCSQ(n, pItem, pOtherItem, pCaseSensitive)
			This.ReplaceNthOccurrenceCS(n, pItem, pOtherItem, pCaseSensitive)
			return This

		#>

		#< @FunctionAlternativeForms

		def ReplaceNthCS(n, pItem, pOtherItem, pCaseSensitive)
			This.ReplaceNthOccurrenceCS(n, pItem, pOtherItem, pCaseSensitive)

			def ReplaceNthCSQ(n, pItem, pOtherItem, pCaseSensitive)
				This.ReplaceNthCS(n, pItem, pOtherItem, pCaseSensitive)
				return This
			
		#>

	def NthOccurrenceReplacedCS(n, pItem, pOtherItem, pCaseSensitive)

		aResult  = This.Copy().
				ReplaceNthOccurrenceCSQ(n, pItem, pOtherItem, pCaseSensitive).
				Content()

		return aResult

		def NthReplacedCS(n, pItem, pOtherItem, pCaseSensitive)
			return This.NthOccurrenceReplacedCS(n, pItem, pOtherItem, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def ReplaceNthOccurrence(n, pItem, pOtherItem)
		This.ReplaceNthOccurrenceCS(n, pItem, pOtherItem, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def ReplaceNth(n, pItem, pOtherItem)
			This.ReplaceNthOccurrence(n, pItem, pOtherItem)

			def ReplaceNthQ(n, pItem, pOtherItem)
				This.ReplaceNth(n, pItem, pOtherItem)
				return This
			
		#>

	def NthOccurrenceReplaced(n, pItem, pOtherItem)

		aResult  = This.Copy().
				ReplaceNthOccurrenceQ(n, pItem, pOtherItem).
				Content()

		return aResult

		def NthReplaced(n, pItem, pOtherItem)
			return This.NthOccurrenceReplaced(n, pItem, pOtherItem, pCaseSensitive)

	  #--------------------------------------------#
	 #   REPLACING FIRST OCCURRENCE OF AN ITEM    #
	#--------------------------------------------#

	def ReplaceFirstOccurrenceCS(pItem, pOtherItem, pCaseSensitive)
		This.ReplaceNthOccurrenceCS(1, pItem, pOtherItem, pCaseSensitive)

		def ReplaceFirstOccurrenceCSQ(pItem, pOtherItem, pCaseSensitive)
			This.ReplaceFirstOccurrenceCS(pItem, pOtherItem, pCaseSensitive)
			return This

		#< @FunctionAlternativeForm

		def ReplaceFirstCS(pItem, pOtherItem, pCaseSensitive)
			This.ReplaceFirstOccurrenceCS(pItem, pOtherItem, pCaseSensitive)

			def ReplaceFirstCSQ(pItem, pOtherItem, pCaseSensitive)
				This.ReplaceFirstCS(pItem, pOtherItem, pCaseSensitive)
				return This
		#>

	def FirstOccurrenceReplacedCS(pItem, pOtherItem, pCaseSensitive)
		aResult  = This.Copy().
				ReplaceFirstOccurrenceCSQ(pItem, pOtherItem, pCaseSensitive).
				Content()

		return aResult

		def FirstReplacedCS(pItem, pOtherItem, pCaseSensitive)
			return This.FirstOccurrenceReplacedCS(pItem, pOtherItem, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def ReplaceFirstOccurrence(pItem, pOtherItem)
		This.ReplaceFirstOccurrenceCS(pItem, pOtherItem, :CaseSensitive = TRUE)

		def ReplaceFirstOccurrenceQ(pItem, pOtherItem)
			This.ReplaceFirstOccurrence(pItem, pOtherItem)
			return This

		#< @FunctionAlternativeForm

		def ReplaceFirst(pItem, pOtherItem)
			This.ReplaceFirstOccurrence(pItem, pOtherItem)

			def ReplaceFirstQ(pItem, pOtherItem)
				This.ReplaceFirst(pItem, pOtherItem)
				return This
		#>

	def FirstOccurrenceReplaced(pItem, pOtherItem)
		aResult  = This.Copy().
				ReplaceFirstOccurrenceQ(pItem, pOtherItem).
				Content()

		return aResult

		def FirstReplaced(pItem, pOtherItem)
			return This.FirstOccurrenceReplaced(pItem, pOtherItem)

	  #-----------------------------------------#
	 #   REPLACING LAST OCCURRENCE OF AN ITEM  #
	#-----------------------------------------#

	def ReplaceLastOccurrenceCS(pItem, pOtherItem, pCaseSensitive)
		n = This.FindLastOccurrenceCS(pItem, pCaseSensitive)

		This.ReplaceItemAtPosition(n, pOtherItem)

		def ReplaceLastOccurrenceCSQ(pItem, pOtherItem, pCaseSensitive)
			This.ReplaceLastOccurrenceCS(pItem, pOtherItem, pCaseSensitive)
			return This

		#< @FunctionAlternativeForms

		def ReplaceLastCS(pItem, pOtherItem, pCaseSensitive)
			This.ReplaceLastOccurrenceCS(pItem, pOtherItem, pCaseSensitive)

			def ReplaceLastCSQ(pItem, pOtherItem, pCaseSensitive)
				This.ReplaceLastCS(pItem, pOtherItem, pCaseSensitive)
				return This

		#>

	def LastOccurrenceReplacedCS(pItem, pOtherItem, pCaseSensitive)

		aResult  = This.Copy().
				ReplaceLastOccurrenceCSQ(pItem, pOtherItem, pCaseSensitive).
				Content()

		return aResult

		def LastReplacedCS(pItem, pOtherItem, pCaseSensitive)
			return This.LastOccurrenceReplacedCS(pItem, pOtherItem, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def ReplaceLastOccurrence(pItem, pOtherItem)
		n = This.FindLastOccurrence(pItem)

		This.ReplaceItemAtPosition(n, pOtherItem)

		def ReplaceLastOccurrenceQ(pItem, pOtherItem)
			This.ReplaceLastOccurrence(pItem, pOtherItem)
			return This

		#< @FunctionAlternativeForms

		def ReplaceLast(pItem, pOtherItem)
			This.ReplaceLastOccurrence(pItem, pOtherItem)

			def ReplaceLastQ(pItem, pOtherItem)
				This.ReplaceLast(pItem, pOtherItem)
				return This

		#>

	def LastOccurrenceReplaced(pItem, pOtherItem)

		aResult  = This.Copy().
				ReplaceLastOccurrenceQ(pItem, pOtherItem).
				Content()

		return aResult

		def LastReplaced(pItem, pOtherItem)
			return This.LastOccurrenceReplaced(pItem, pOtherItem)

	   #-----------------------------------------------#
	  #    REPLACING NEXT NTH OCCURRENCE OF AN ITEM   #
	 #    STARTING AT A GIVEN POSITION IN THE LIST   #
	#-----------------------------------------------#

	def ReplaceNextNthOccurrenceCS(n, pItem, pNewItem, pnStartingAt, pCaseSensitive)

		# Checking params correctness

		if NOT isNumber(n)
			StzRaise("Incorrect param! n must be a number.")
		ok

		if isList(pItem) and StzListQ(pItem).IsOfNamedParam()
			pItem = pItem[2]
		ok

		if isList(pNewItem) and
		   StzListQ(pNewItem).IsWithOrByNamedParam()

			if Q(pNewItem[1]).LastChar() = "@"
				
				cCode = 'pNewtItem = ' + Q(pNewItem[2]).
								RemoveSpacesQ().
								RemoveBoundsQ(["{","}"]).
								Content()
				eval(cCode)
			else
				pNewItem = pNewItem[2]
			ok
		ok

		if isList(pnStartingAt) and StzListQ(pnStartingAt).IsStartingAtNamedParam()
			pnStartingAt = pnStartingAt[2]
		ok

		if isString(pnStartingAt)
			if Q(pnStartingAt).IsOneOfThese([
				:First, :FirstPosition, :FirstItem ], :CS = FALSE)

				pnStartingAt = 1
			
			but Q(pnStartingAt).IsOneOfThese([
				:Last, :LastPosition, :LastItem ], :CS = FALSE)

				pnStartingAt = This.NumberOfItems()
			ok
		ok

		if NOT isNumber(pnStartingAt)
			StzRaise("Incorrect param! pnStartingAt must be a number.")
		ok

		# Doing the job

		oSection   = This.SectionQR(pnStartingAt, This.NumberOfItems(), :stzList)
		anPositions = oSection.FindAllCS(pItem, pCaseSensitive)

		anPositions = StzListOfNumbersQ(anPositions).AddToEachQ(pnStartingAt - 1).Content()
		nPosition = anPositions[n]

		This.ReplaceItemAtPosition(nPosition, pNewItem)

		#< @FunctionFluentForm

		def ReplaceNextNthOccurrenceCSQ(n, pItem, pnStartingAt, pNewItem, pCaseSensitive)
			This.ReplaceNextNthOccurrenceCS(n, pItem, pnStartingAt, pNewItem, pCaseSensitive)
			return This

		#>

		#< @FunctionAlternativeForms

		def ReplaceNthNextOccurrenceCS(n, pItem, pnStartingAt, pNewItem, pCaseSensitive)
			This.ReplaceNextNthOccurrenceCS(n, pItem, pnStartingAt, pNewItem, pCaseSensitive)

			def ReplaceNthNextOccurrenceCSQ(n, pItem, pnStartingAt, pNewItem, pCaseSensitive)
				This.ReplaceNthNextOccurrenceCS(n, pItem, pnStartingAt, pNewItem, pCaseSensitive)
				return This

		#>

	def NextNthOccurrenceReplacedCS(n, pItem, pnStartingAt, pNewItem, pCaseSensitive)

		aResult  = This.Copy().
				ReplaceNthNextOccurrenceCSQ(n, pItem, pnStartingAt, pNewItem, pCaseSensitive).
				Content()
		return aResult

		def NthNextOccurrenceReplacedCS(n, pItem, pnStartingAt, pNewItem, pCaseSensitive)
			return This.NextNthOccurrenceReplaced(n, pItem, pnStartingAt, pNewItem)

	#-- WITHOUT CASESENSITIVITY

	def ReplaceNextNthOccurrence(n, pItem, pNewItem, pnStartingAt, pCaseSensitive)
		return This.ReplaceNextNthOccurrenceCS(n, pItem, pNewItem, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionFluentForm

		def ReplaceNextNthOccurrenceQ(n, pItem, pnStartingAt, pNewItem)
			This.ReplaceNextNthOccurrence(n, pItem, pnStartingAt, pNewItem)
			return This

		#>

		#< @FunctionAlternativeForms

		def ReplaceNthNextOccurrence(n, pItem, pnStartingAt, pNewItem)
			This.ReplaceNextNthOccurrence(n, pItem, pnStartingAt, pNewItem)

			def ReplaceNthNextOccurrenceQ(n, pItem, pnStartingAt, pNewItem)
				This.ReplaceNthNextOccurrence(n, pItem, pnStartingAt, pNewItem)
				return This

		#>

	def NextNthOccurrenceReplaced(n, pItem, pnStartingAt, pNewItem)

		aResult  = This.Copy().
				ReplaceNthNextOccurrenceQ(n, pItem, pnStartingAt, pNewItem).
				Content()

		return aResult

		def NthNextOccurrenceReplaced(n, pItem, pnStartingAt, pNewItem)
			return This.NextNthOccurrenceReplaced(n, pItem, pnStartingAt, pNewItem)

	   #------------------------------------------------#
	  #    REPLACING NEXT OCCURRENCE OF AN ITEM        #
	 #    STARTING AT A GIVEN POSITION IN THE LIST    #
	#------------------------------------------------#

	def ReplaceNextOccurrenceCS(pItem, pNewItem, pnStartingAt, pCaseSensitive)
		This.ReplaceNextNthOccurrenceCS(1, pItem, pNewItem, pnStartingAt, pCaseSensitive)

		def ReplaceNextOccurrenceCSQ(pItem, pNewItem, pnStartingAt, pCaseSensitive)
			This.ReplaceNextOccurrenceCS(pItem, pNewItem, pnStartingAt, pCaseSensitive)
			return This

	def NextOccurrenceReplacedCS(pItem, pNewItem, pnStartingAt, pCaseSensitive)

		aResult =  This.Copy().
				ReplaceNextOccurrenceCSQ(pItem, pNewItem, pnStartingAt, pCaseSensitive).
				Content()

		return aResult

	#-- WITHOUT CASESENSITIVITY

	def ReplaceNextOccurrence(pItem, pNewItem, pnStartingAt)
		This.ReplaceNextNthOccurrenceCS(1, pItem, pNewItem, pnStartingAt, pCaseSensitive)

		def ReplaceNextOccurrenceQ(pItem, pNewItem, pnStartingAt)
			This.ReplaceNextOccurrence(pItem, pNewItem, pnStartingAt)
			return This

	def NextOccurrenceReplaced(pItem, pNewItem, pnStartingAt)

		aResult  = This.Copy().
				ReplaceNextOccurrenceQ(pItem, pNewItem, pnStartingAt).
				Content()

		return aResult

	   #-----------------------------------------------------#
	  #    REPLACING MANY NEXT NTH OCCURRENCES OF AN ITEM   #
	 #    STARTING AT A GIVEN POSITION IN THE LIST         #
	#-----------------------------------------------------#

	def ReplaceNextNthOccurrencesCS(panList, pItem, pNewItem, pnStartingAt, pCaseSensitive)
		/* Example

		StzListOfQ([ "A" , "B", "A", "C", "A", "D", "A" ]) {
			ReplaceNextNthOccurrences([2, 3], :of = "A", :with = "*",  :StartingAt = 3)
			? Content() # !--> [ "A" , "B", "A", "C", "*", "D", "*" ]
		}		

		*/

		if NOT (isList(panList) and StzListQ(panList).IsListOfNumbers() and
		        StzListQ(panList).NumberOfItemsW("StzNumberQ(@item).IsBetween(1, " + This.NumberOfItems() + ")") = len(panList) )

			StzRaise("Incorrect param! panList must be a list of numbers between 1 and This.NumberOfItems().")
		ok

		if isList(pItem) and StzListQ(pItem).IsOfNamedParam()
			pItem = pItem[2]
		ok

		if isList(pNewItem) and
		   StzListQ(pNewItem).IsWithOrByNamedParam()
			if Q(pNewItem[1]).LastChar() = "@"
				cCode = 'pNewtItem = ' + pNewItem[2]
				eval(cCode)
			else
				pNewItem = pNewItem[2]
			ok
		ok

		if isList(pnStartingAt) and StzListQ(pnStartingAt).IsStartingAtNamedParam()
			pnStartingAt = pnStartingAt[2]
		ok

		if isString(pnStartingAt)
			if Q(pnStartingAt).IsOneOfThese([
				:First, :FirstPosition, :FirstItem ], :CS = FALSE)

				pnStartingAt = 1
			
			but Q(pnStartingAt).IsOneOfThese([
				:Last, :LastPosition, :LastItem ], :CS = FALSE)

				pnStartingAt = This.NumberOfItems()
			ok
		ok

		if NOT isNumber(pnStartingAt)
			StzRaise("Incorrect param! pnStartingAt must be a number.")
		ok
			
		oSection = This.SectionQ(pnStartingAt, :LastItem)

		anPositions = oSection.
			      FindAllCSQR(pItem, pCaseSensitive, :stzListOfNumbers).
			      AddToEachQ(pnStartingAt-1).
			      Content()

		anPositionsToBeReplaced = []

		nLen = len(panList)
		nLenPos = len(anPositions)

		for i = 1 to nLen
			if i <= nLenPos
				anPositionsToBeReplaced +  anPositions[panList[i]]
			ok
		next

		This.ReplaceAllItemsAtThesePositions(anPositionsToBeReplaced, pNewItem)

		#< @FunctionFluentForm

		def ReplaceNextNthOccurrencesCSQ(panList, pItem, pNewItem, pnStartingAt, pCaseSensitive)
			This.ReplaceNextNthOccurrencesCS(panList, pItem, pNewItem, pnStartingAt, pCaseSensitive)
			return This

		#>

		#< @FunctionAlternativeForm

		def ReplaceNthNextOccurrencesCS(panList, pItem, pNewItem, pnStartingAt, pCaseSensitive)
			This.ReplaceNextNthOccurrences(panList, pItem, pNewItem, pnStartingAt)

			def ReplaceNthNextOccurrencesCSQ(panList, pItem, pNewItem, pnStartingAt, pCaseSensitive)
				This.ReplaceNthNextOccurrencesCS(panList, pItem, pNewItem, pnStartingAt, pCaseSensitive)
				return This
		#>

	def NextNthOccurrencesReplacedCS(panList, pItem, pNewItem, pnStartingAt, pCaseSensitive)

		aResult = This.
			  ReplaceNextNthOccurrencesCSQ(panList, pItem, pNewItem, pnStartingAt, pCaseSensitive).
			  Content()

		return aResult

		def NthNextOccurrencesReplacedCS(panList, pItem, pNewItem, pnStartingAt, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def ReplaceNextNthOccurrences(panList, pItem, pNewItem, pnStartingAt)
		return This.ReplaceNextNthOccurrencesCS(panList, pItem, pNewItem, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionFluentForm

		def ReplaceNextNthOccurrencesQ(panList, pItem, pNewItem, pnStartingAt)
			This.ReplaceNextNthOccurrences(panList, pItem, pNewItem, pnStartingAt)
			return This

		#>

		#< @FunctionAlternativeForm

		def ReplaceNthNextOccurrences(panList, pItem, pNewItem, pnStartingAt)
			This.ReplaceNextNthOccurrences(panList, pItem, pNewItem, pnStartingAt)

			def ReplaceNthNextOccurrencesQ(panList, pItem, pNewItem, pnStartingAt)
				This.ReplaceNthNextOccurrences(panList, pItem, pNewItem, pnStartingAt)
				return This
		#>

	def NextNthOccurrencesReplaced(panList, pItem, pNewItem, pnStartingAt)

		aResult = This.
			  ReplaceNextNthOccurrencesQ(panList, pItem, pNewItem, pnStartingAt).
			  Content()

		return aResult

		def NthNextOccurrencesReplaced(panList, pItem, pNewItem, pnStartingAt)
			return This.NextNthOccurrencesReplaced(panList, pItem, pNewItem, pnStartingAt)

	   #---------------------------------------------------#
	  #    REPLACING PREVIOUS NTH OCCURRENCE OF AN ITEM   #
	 #    STARTING AT A GIVEN POSITION IN THE LIST       #
	#---------------------------------------------------#

	def ReplacePreviousNthOccurrenceCS(n, pItem, pNewItem, pnStartingAt, pCaseSensitive)
		if isList(pItem) and StzListQ(pItem).IsOfNamedParam()
			pItem = pItem[2]
		ok

		if isList(pNewItem) and
		   StzListQ(pNewItem).IsWithOrByNamedParam()

			if Q(pNewItem[1]).LastChar() = "@"
				cCode = 'pNewtItem = ' + pNewItem[2]
				eval(cCode)

			else
				pNewItem = pNewItem[2]
			ok
		ok

		if isList(pnStartingAt) and StzListQ(pnStartingAt).IsStartingAtNamedParam()
			pnStartingAt = pnStartingAt[2]
		ok

		if isString(pnStartingAt)
			if Q(pnStartingAt).IsOneOfThese([
				:First, :FirstPosition, :FirstItem ], :CS = FALSE)

				pnStartingAt = 1
			
			but Q(pnStartingAt).IsOneOfThese([
				:Last, :LastPosition, :LastItem ], :CS = FALSE)

				pnStartingAt = This.NumberOfItems()
			ok
		ok

		if NOT isNumber(pnStartingAt)
			StzRaise("Incorrect param! pnStartingAt must be a number.")
		ok

		oSection   = This.SectionQR(1, pnStartingAt, :stzList)
		aPositions = oSection.FindAllCS(pItem, pCaseSensitive)

		nPosition = aPositions[ len(aPositions) - n + 1 ]

		This.ReplaceItemAtPositionCS(nPosition, pNewItem, pCaseSensitive)

		def ReplacePreviousNthOccurrenceCSQ(n, pItem, pNewItem, pnStartingAt, pCaseSensitive)
			This.ReplacePreviousNthOccurrenceCS(n, pItem, pNewItem, pnStartingAt, pCaseSensitive)
			return This

		def ReplaceNthPreviousOccurrenceCS(n, pItem, pNewItem, pnStartingAt, pCaseSensitive)
			This.ReplacePreviousNthOccurrenceCS(n, pItem, pNewItem, pnStartingAt, pCaseSensitive)

			def ReplaceNthPreviousOccurrenceCSQ(n, pItem, pNewItem, pnStartingAt, pCaseSensitive)
				This.ReplaceNthPreviousOccurrenceCS(n, pItem, pNewItem, pnStartingAt, pCaseSensitive)
				return This

	def NthPreviousOccurrenceReplacedCS(n, pItem, pNewItem, pnStartingAt, pCaseSensitive)

		aResult =  This.Copy().
				ReplaceNthPreviousOccurrenceCSQ(n, pItem, pNewItem, pnStartingAt, pCaseSensitive).
				Content()

		return aResult

		def PreviousNthOccurrenceReplacedCS(n, pItem, pNewItem, pnStartingAt, pCaseSensitive)
			return This.NthPreviousOccurrenceReplacedCS(n, pItem, pnStartingAt, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

		def ReplacePreviousNthOccurrenceQ(n, pItem, pNewItem, pnStartingAt)
			This.ReplacePreviousNthOccurrence(n, pItem, pNewItem, pnStartingAt)
			return This

		def ReplaceNthPreviousOccurrence(n, pItem, pNewItem, pnStartingAt)
			This.ReplacePreviousNthOccurrence(n, pItem, pNewItem, pnStartingAt)

			def ReplaceNthPreviousOccurrenceQ(n, pItem, pNewItem, pnStartingAt)
				This.ReplaceNthPreviousOccurrence(n, pItem, pNewItem, pnStartingAt)
				return This

	def NthPreviousOccurrenceReplaced(n, pItem, pNewItem, pnStartingAt)

		aResult =  This.Copy().
				ReplaceNthPreviousOccurrenceQ(n, pItem, pNewItem, pnStartingAt).
				Content()

		return aResult

		def PreviousNthOccurrenceReplaced(n, pItem, pNewItem, pnStartingAt)
			return This.NthPreviousOccurrenceReplaced(n, pItem, pnStartingAt)

	   #-----------------------------------------------#
	  #    REPLACING PREVIOUS OCCURRENCE OF AN ITEM   #
	 #    STARTING AT A GIVEN POSITION IN THE LIST   #
	#-----------------------------------------------#

	def ReplacePreviousOccurrenceCS(pItem, pNewItem, pnStartingAt, pCaseSensitive)
		This.ReplacePreviousNthOccurrenceCS(1, pItem, pNewItem, pnStartingAt, pCaseSensitive)

		def ReplacePreviousOccurrenceCSQ(pItem, pNewItem, pnStartingAt, pCaseSensitive)
			This.ReplacePreviousOccurrenceCS(pItem, pNewItem, pnStartingAt, pCaseSensitive)
			return This

	def PreviousOccurrenceReplacedCS(pItem, pNewItem, pnStartingAt, pCaseSensitive)

		aResult =  This.Copy().
				ReplacePreviousOccurrenceCSQ(pItem, pNewItem, pnStartingAt, pCaseSensitive).
				Content()
		return aResult

	#-- WITHOUT CASESENSITIVITY

	def ReplacePreviousOccurrence(pItem, pNewItem, pnStartingAt)
		This.ReplacePreviousOccurrenceCS(pItem, pNewItem, pnStartingAt, :CaseSensitive = TRUE)

		def ReplacePreviousOccurrenceQ(pItem, pNewItem, pnStartingAt)
			This.ReplacePreviousOccurrence(pItem, pNewItem, pnStartingAt)
			return This

	def PreviousOccurrenceReplaced(pItem, pNewItem, pnStartingAt)

		aResult =  This.Copy().
				ReplacePreviousOccurrenceQ(pItem, pNewItem, pnStartingAt).
				Content()
		return aResult

	   #---------------------------------------------------------#
	  #     REPLACING MANY PREVIOUS NTH OCCURRENCES OF AN ITEM  #
	 #    STARTING AT A GIVEN POSITION IN THE LIST             #
	#---------------------------------------------------------#

	def ReplacePreviousNthOccurrencesCS(panList, pItem, pNewItem, pnStartingAt, pCaseSensitive)
		/* Example

		StzListQ([ "A" , "B", "A", "C", "A", "D", "A" ]) {
			ReplacePreviousNthOccurrences([2, 3], :of = "A", :with = "*",  :StartingAt = 5)
			? Content() # !--> [ "*" , "B", "*", "C", "A", "D", "A" ]
		}		

		*/

		if NOT ( isList(panList) and StzListQ(panList).IsListOfNumbers() and

		         StzListQ(panList).NumberOfItemsW("StzNumberQ(@item).IsBetween(1, " + This.NumberOfItems() + ")") = len(panList) )

			StzRaise("Incorrect param! panList must be a list of numbers between 1 and This.NumberOfItems().")
		ok

		if isList(pItem) and StzListQ(pItem).IsOfNamedParam()
			pItem = pItem[2]
		ok

		if isList(pNewItem) and
		   ( StzListQ(pNewItem).IsWithNamedParam() or StzListQ(pNewItem).IsByNamedParam() )

			if Q(pNewItem[1]).LastChar() = "@"
				cCode = 'pNewtItem = ' + pNewItem[2]
				eval(cCode)

			else
				pNewItem = pNewItem[2]
			ok
		ok

		if isList(pnStartingAt) and StzListQ(pnStartingAt).IsStartingAtNamedParam()
			pnStartingAt = pnStartingAt[2]
		ok

		if isString(pnStartingAt)
			if Q(pnStartingAt).IsOneOfThese([
				:First, :FirstPosition, :FirstItem ], :CS = FALSE)

				pnStartingAt = 1
			
			but Q(pnStartingAt).IsOneOfThese([
				:Last, :LastPosition, :LastItem ], :CS = FALSE)

				pnStartingAt = This.NumberOfItems()
			ok
		ok

		if NOT isNumber(pnStartingAt)
			StzRaise("Incorrect param! pnStartingAt must be a number.")
		ok
			
		oSection = This.SectionQ(1, pnStartingAt)

		anPositions = oSection.FindAllCSQ(pItem, pCaseSensitive).ItemsReversed()

		anPositionsToBeReplaced = []
		nLen = len(panList)
		nLenPos = len(anPositions)

		for i = 1 to nLen
			if i <= nLenPos
				anPositionsToBeReplaced +  anPositions[panList[i]]
			ok
		next

		This.ReplaceAllItemsAtThesePositionsCS(anPositionsToBeReplaced, pNewItem, pCaseSensitive)

		#< @FunctionFluentForm

		def ReplacePreviousNthOccurrencesCSQ(panList, pItem, pNewItem, pnStartingAt, pCaseSensitive)
			This.ReplacePreviousNthOccurrencesCS(panList, pItem, pNewItem, pnStartingAt, pCaseSensitive)
			return This

		#>

		#< @FunctionAlternativeForm

		def ReplaceNthPreviousOccurrencesCS(panList, pItem, pNewItem, pnStartingAt, pCaseSensitive)
			This.ReplacePreviousNthOccurrencesCS(panList, pItem, pNewItem, pnStartingAt, pCaseSensitive)

			def ReplaceNthPreviousOccurrencesCSQ(panList, pItem, pNewItem, pnStartingAt, pCaseSensitive)
				This.ReplaceNthPreviousOccurrencesCS(panList, pItem, pNewItem, pnStartingAt, pCaseSensitive)
				return This
		#>

	def PreviousNthOccurrencesReplacedCS(panList, pItem, pNewItem, pnStartingAt, pCaseSensitive)
		aResult =  This.
			   ReplacePreviousNthOccurrencesCSQ(panList, pItem, pNewItem, pnStartingAt, pCaseSensitive).
			   Content()

		return aResult

		def NthPreviousOccurrencesReplacedCS(panList, pItem, pNewItem, pnStartingAt, pCaseSensitive)
			return This.PreviousNthOccurrencesReplacedCS(panList, pItem, pNewItem, pnStartingAt, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def ReplacePreviousNthOccurrences(panList, pItem, pNewItem, pnStartingAt)
		This.ReplacePreviousNthOccurrencesCS(panList, pItem, pNewItem, pnStartingAt, pCaseSensitive)

		#< @FunctionFluentForm

		def ReplacePreviousNthOccurrencesQ(panList, pItem, pNewItem, pnStartingAt)
			This.ReplacePreviousNthOccurrences(panList, pItem, pNewItem, pnStartingAt)
			return This

		#>

		#< @FunctionAlternativeForm

		def ReplaceNthPreviousOccurrences(panList, pItem, pNewItem, pnStartingAt)
			This.ReplacePreviousNthOccurrences(panList, pItem, pNewItem, pnStartingAt)

			def ReplaceNthPreviousOccurrencesQ(panList, pItem, pNewItem, pnStartingAt)
				This.ReplaceNthPreviousOccurrences(panList, pItem, pNewItem, pnStartingAt)
				return This
		#>

	def PreviousNthOccurrencesReplaced(panList, pItem, pNewItem, pnStartingAt)

		aResult =  This.
			   ReplacePreviousNthOccurrencesQ(panList, pItem, pNewItem, pnStartingAt).
			   Content()

		return aResult

		def NthPreviousOccurrencesReplaced(panList, pItem, pNewItem, pnStartingAt)
			return This.PreviousNthOccurrencesReplaced(panList, pItem, pNewItem, pnStartingAt)


	  #==============================================#
	 #  REPLACING AN ITEM AT ONE OR MORE POSITIONS  #
	#==============================================#

	def ReplaceAt(n, pOtherItem)
		if isList(n) and Q(n).IsListOfNumbers()
			This.ReplaceItemsAtPositions(n, pOtherItem)

		but isNumber(n)
			This.ReplaceItemAtPosition(n, pOtherItem)

		else
			StzRaise("Incorrect param type! n must be a number or a list of numbers.")
		ok

		def ReplaceAtQ(n, pOtherItem)
			This.ReplaceAt(n, pOtherItem)
			return This

	  #----------------------------------------#
	 #   REPLACING ITEM AT A GIVEN POSITION   #
	#----------------------------------------#

	def ReplaceItemAtPosition(n, pcOtherItem)

		/* Example 1:

			o1 = new stzList([ "ONE", "two" ])
			o1.ReplaceItemAtPosition(2, :With = "TWO")
			? o1.Content	# --> [ "ONE", "TWO" ]

		Example 2:

			o1 = new stzList([ "A", "b", "C" ])
			o1.ReplaceItemAtPosition(2, :With@ = "upper(@item)")
			? o1.Content()	# --> [ "A", "B", "C" ]
		*/

		if NOT IsNumberOrString(n)
			StzRaise("Invalid param type! n must be a number.")
		ok

		if isString(n)
			if Q(n).IsOneOfThese([
				:First, :FirstPosition, :FirstItem ])
				  
				n = 1

			but Q(n).IsOneOfThese([
				:Last, :LastPosition, :LastItem ])

				n = This.NumberOfItems()
			ok
		ok

		if n < 1 or n > This.NumberOfItems()
			StzRaise("the Nth position you provided is out of range!")
		ok

		if isList(pcOtherItem) and
		   Q(pcOtherItem).IsWithOrByNamedParam()

			if Q(pcOtherItem[1]).LastChar() = "@" and
		  	   isString(pcOtherItem[2])

				cCode = "pcOtherItem = " + StzCCodeQ(pcOtherItem[2]).Transpiled()
				@item = This.ItemAtPosition(n)	
				@position = n
				@i = n

				eval(cCode)
			else

				pcOtherItem = pcOtherItem[2]
			ok
		ok

		# Doing the job

		This.List()[n] = pcOtherItem

		#< @FunctionFluentForm

		def ReplaceItemAtPositionQ(n, pOtherItem)
			This.ReplaceItemAtPosition(n, pOtherItem)
			return This

		#>

		#< @FunctionAlternativeForm

		def ReplaceAtPosition(n, pOtherItem)
			This.ReplaceItemAtPosition(n, pOtherItem)

			def ReplaceAtPositionQ(n, pOtherItem)
				This.ReplaceAtPosition(n, pOtherItem)
				return This

		def ReplaceItemAt(n, pOtherItem)
			This.ReplaceItemAtPosition(n, pOtherItem)

			def ReplaceItemAtQ(n, pOtherItem)
				This.ReplaceItemAt(n, pOtherItem)
				return This

		def ReplaceNthItem(n, pOtherItem)
			This.ReplaceItemAtPosition(n, pOtherItem)

			def ReplaceNthItemQ(n, pOtherItem)
				This.ReplaceNthItem(n, pOtherItem)
				return This

		#>
	
	def ItemAtPositionNReplaced(n, pOtherItem)
		aResult = This.Copy().ReplaceItemAtPositionQ( n, pOtherItem ).Content()
		return aResult

		def ItemAtPositionNReplacedWith(n, pOtherItem)
			return This.ItemAtPositionNReplaced(n, pOtherItem)

		def NthItemReplacedWith(n, pOtherItem)
			return This.ItemAtPositionNReplacedWith(n, pOtherItem)

			def NthItemReplaced(n, pOtherItem)
				return This.NthItemReplacedWith(n, pOtherItem)

	  #------------------------------#
	 #   REPLACING THE FIRST ITEM   #
	#------------------------------#

	def ReplaceFirstItem(pOtherItem)
		This.ReplaceNthItem(1, pOtherItem)

		def ReplaceFirstItemQ(pOtherItem)
			This.ReplaceFirstItem(pOtherItem)
			return This

	def FirstItemReplaced(pOtherItem)
		aResult = This.Copy().ReplaceFirstItemQ(pOtherItem).Content()
		return aResult

		def FirstItemReplacedWith(pOtherItem)
			return This.FirstItemReplaced(pOtherItem)

	  #-----------------------------#
	 #   REPLACING THE LAST ITEM   #
	#-----------------------------#

	def ReplaceLastItem(pOtherItem)
		This.ReplaceNthItem(:LastItem, pOtherItem)

		def ReplaceLastItemQ(pOtherItem)
			This.ReplaceLastItem(pOtherItem)
			return This

	def LastItemReplaced(pOtherItem)
		aResult = This.Copy().ReplaceLastItemQ(pOtherItem).Content()
		return aResult

		def LastItemReplacedWith(pOtherItem)
			return This.LastItemReplaced(pOtherItem)

	  #--------------------------------------------#
	 #   REPLACING ITEMS AT THE GIVEN POSITIONS   #
	#--------------------------------------------#

	def ReplaceItemsAtPositions(panPositions, pOtherItem)

		if NOT ( isList(panPositions) and Q(panPositions).IsListOfNumbers() )
			StzRaise("Incorrect param type! panPositions must be a list of numbers.")
		ok

		nLen = len(panPositions)

		if isList(pOtherItem) and
		   Q(pOtherItem).IsWithOrByNamedParam() and
		   Q(pOtherItem[1]).LastChar() = "@"

			cCode = '@cNewItem = ( ' + StzCCodeQ(pOtherItem[2]).Transpiled() + ' )'
			
			for i = 1 to nLen
				@Position = panPositions[i]
				@i = @Position
				@item = This[i]

				eval(cCode)
				This.ReplaceItemAtPosition(@Position, @cNewItem)
			next
		else

			for i = 1 to nLen
				This.ReplaceItemAtPosition(panPositions[i], pOtherItem)
			next
		ok
	
		#< @FunctionFluentForm

		def ReplaceItemsAtPositionsQ(panPositions, pOtherItem)
			This.ReplaceItemsAtPositions(panPositions, pOtherItem)
			return This

		#>

		#< @FunctionAlternativeForms

		def ReplaceAtPositions(panPositions, pOtherItem)
			This.ReplaceItemsAtPositions(panPositions, pOtherItem)

			def ReplaceAtPositionsQ(panPositions, pOtherItem)
				This.ReplaceAtPositions(panPositions, pOtherItem)
				return This

		def ReplaceManyAt(panPositions, pOtherItem)
			This.ReplaceItemsAtPositions(panPositions, pOtherItem)

			def ReplaceManyAtQ(panPositions, pOtherItem)
				This.ReplaceManyAt(panPositions, pOtherItem)
				return This

		def ReplaceManyAtPositions(panPositions, pOtherItem)
			This.ReplaceItemsAtPositions(panPositions, pOtherItem)

			def ReplaceManyAtPositionsQ(panPositions, pOtherItem)
				This.ReplaceManyAtPositions(panPositions, pOtherItem)
				return This

		def ReplaceManyItemsAt(panPositions, pOtherItem)
			This.ReplaceItemsAtPositions(panPositions, pOtherItem)

			def ReplaceManyItemsAtQ(panPositions, pOtherItem)
				This.ReplaceManyItemsAt(panPositions, pOtherItem)
				return This

		def ReplaceManyItemsAtPositions(panPositions, pOtherItem)
			This.ReplaceItemsAtPositions(panPositions, pOtherItem)

			def ReplaceManyItemsAtPositionsQ(panPositions, pOtherItem)
				This.ReplaceManyItemsAtPositions(panPositions, pOtherItem)
				return This

		def ReplaceManyAtThesePositions(panPositions, pOtherItem)
			This.ReplaceItemsAtPositions(panPositions, pOtherItem)

			def ReplaceManyAtThesePositionsQ(panPositions, pOtherItem)
				This.ReplaceManyAtThesePositions(panPositions, pOtherItem)
				return This

		def ReplaceManyItemsAtThesePositions(panPositions, pOtherItem)
			This.ReplaceItemsAtPositions(panPositions, pOtherItem)

			def ReplaceManyItemsAtThesePositionsQ(panPositions, pOtherItem)
				This.ReplaceManyItemsAtThesePositions(panPositions, pOtherItem)
				return This

		#--

		def ReplaceItemsAtThesePositions(panPositions, pOtherItem)
			This.ReplaceItemsAtPositions(panPositions, pOtherItem)
		
			def ReplaceItemsAtThesePositionsQ(panPositions, pOtherItem)
				This.ReplaceItemsAtThesePositions(panPositions, pOtherItem)
				return This

		#--

		def ReplaceAllItemsAtPositions(panPositions, pOtherItem)
			This.ReplaceItemsAtPositions(panPositions, pOtherItem)
		
			def ReplaceAllItemsAtPositionsQ(panPositions, pOtherItem)
				This.ReplaceAllItemsAtPositions(panPositions, pOtherItem)
				return This

		#--

		def ReplaceAllItemsAtThesePositions(panPositions, pOtherItem)
			This.ReplaceItemsAtPositions(panPositions, pOtherItem)
		
			def ReplaceAllItemsAtThesePositionsQ(panPositions, pOtherItem)
				This.ReplaceAllItemsAtThesePositions(panPositions, pOtherItem)
				return This

		#--

		def ReplaceTheseItemsAtPositions(panPositions, pOtherItem)
			This.ReplaceItemsAtPositions(panPositions, pOtherItem)

			def ReplaceTheseItemsAtPositionsQ(panPositions, pOtherItem)
				This.ReplaceTheseItemsAtPositions(panPositions, pOtherItem)
				return This

		#--

		def ReplaceTheseItemsAtThesePositions(panPositions, pOtherItem)
			This.ReplaceItemsAtPositions(panPositions, pOtherItem)

			def ReplaceTheseItemsAtThesePositionsQ(panPositions, pOtherItem)
				This.ReplaceTheseItemsAtThesePositions(panPositions, pOtherItem)
				return This

		#--

		def ReplaceAllTheseItemsAtPositions(panPositions, pOtherItem)
			This.ReplaceItemsAtPositions(panPositions, pOtherItem)

			def ReplaceAllTheseItemsAtPositionsQ(panPositions, pOtherItem)
				This.ReplaceAllTheseItemsAtPositions(panPositions, pOtherItem)
				return This

		#--

		def ReplaceAllTheseItemsAtThesePositions(panPositions, pOtherItem)
			This.ReplaceItemsAtPositions(panPositions, pOtherItem)

			def ReplaceAllTheseItemsAtThesePositionsQ(panPositions, pOtherItem)
				This.ReplaceAllTheseItemsAtThesePositions(panPositions, pOtherItem)
				return This

		#>

	def ItemsAtThesePositionsRplaced(panPositions, pOtherItem)
		aResult = This.Copy().ReplaceItemsAtPositionsQ(panPositions, pOtherItem).Content()
		return aResult

		def ItemsAtThesePositionsRplacedWith(panPositions, pOtherItem)
			return This.ItemsAtThesePositionsRplaced(panPositions, pOtherItem)

	  #---------------------------------------------------#
	 #    REPLACING A SECTION OF ITEMS BY A GIVEN ITEM   #
	#---------------------------------------------------#

	def ReplaceSection(n1, n2, pNewItem)
		/* EXAMPLE 1

		o1 = new stzList([ "A", "B", "_", "_", "_", "D" ])
		o1.ReplaceSection(3, 5, "C")
		? o1.Content() #--> [ "A", "B", "C", "D" ]

		EXAMPLE 2 (Using :By@)

		o1 = new stzList([ "A", "B", "c", "d", "e", "F" , "G" ])
		
		o1.ReplaceSection(3, 5, :By@ = '{ @EachItemQ.Uppercased() }')
		? o1.Content()
		#--> [ "A", "B", "C", "D", "E", "F", "G" ]

		*/

		# Checking the pcNewSubStr param

		if isList(pNewItem) and Q(pNewItem).IsWithOrByNamedParam()

			if Q(pNewItem[1]).LastChar() = "@"

				pNewItem = eval@( pNewItem[2], :On = This.Section(n1, n2) )

			else
				pNewItem = pNewItem[2]
			ok
		ok

		This.RemoveSectionQ(n1, n2)
		This.InsertBefore(n1, pNewItem)

		def ReplaceSectionQ(n1, n2, pNewItem)
			This.ReplaceSection(n1, n2, pNewItem)
			return This

	def SectionReplaced(n1, n2, pNewItem)
		aResult = This.Copy().ReplaceSectionQ(n1, n2, pNewItem).Content()
		return aResult

		def SectionReplacedWith(n1, n2, pNewItem)
			return This.SectionReplaced(n1, n2, pNewItem)
	
	  #----------------------------------------------#
	 #    REPLACING MANY SECTIONS BY A GIVEN ITEM   #
	#----------------------------------------------#

	def ReplaceManySections(panSections, pNewItem)
		for anSection in panSections
			This.ReplaceSection(anSection, pNewItem)
		next

		def ReplaceManySectionsQ(panSections, pNewItem)
			This.ReplaceManySections(panSections, pNewItem)
			return This
		
	def ManySectionsReplaced(panSections, pNewItem)
		aResult = This.Copy().ReplaceManySectionsQ(panSections, pNewItem).Content()
		return aResult

		def ManySectionsReplacedWith(panSections, pNewItem)
			return This.ManySectionsReplaced(panSections, pNewItem)

	  #------------------------------------------------------#
	 #   REPLACING EACH ITEM IN SECTION BY ONE GIVEN ITEM   #
	#------------------------------------------------------#

	def ReplaceEachItemInSection(n1, n2, pNewItem)
		/* EXAMPLE

		o1 = new stzList([ "A", "B", "_", "_", "_", "D" ])
		o1.ReplaceEachItemInSection(3, 5, "C")
		? o1.Content() #--> [ "A", "B", "C", "C", "C", "D" ]

		*/

		This.ReplaceItemsAtThesePositions(n1 : n2, pNewItem)

		def ReplaceEachItemInSectionQ(n1, n2, pNewItem)
			This.ReplaceEachItemInSection(n1, n2, pNewItem)
			return This

	def EachItemInSectionReplaced(n1, n2, pNewItem)
		acResult = This.Copy().ReplaceEachItemInSectionQ(n1, n2, pNewItem).Content()
		return acResult

		def EachItemInSectionReplacedWith(n1, n2, pNewItem)
			return This.EachItemInSectionReplaced(n1, n2, pNewItem)

		def EachItemReplacedInSection(n1, n2, pNewItem)
			return This.EachItemInSectionReplaced(n1, n2, pNewItem)

		def EachItemReplacedInSectionWith(n1, n2, pNewItem)
			return This.EachItemReplacedInSection(n1, n2, pNewItem)
	
	  #----------------------------------------------------------#
	 #   REPLACING EACH ITEM IN MANY SECTIONS BY A GIVEN ITEM   #
	#----------------------------------------------------------#

	def ReplaceEachItemInManySections(panSections, pNewItem)
		for anSection in panSections
			n1 = anSection[1]
			n2 = anSection[2]
			This.ReplaceEachItemInSection(n1, n2, pNewItem)
		next

		def ReplaceEachItemInManySectionsQ(panSections, pNewItem)
			This.ReplaceEachItemInManySections(panSections, pNewItem)
			return This

	def EachItemInManySectionsReplaced(panSections, pNewItem)

		acResult = This.Copy().
				ReplaceEachItemInManySectionsQ(panSections, pNewItem).
				Content()

		return acResult

	   #-----------------------------------------------#
	  #   REPLACING A SECTION OF ITEMS IN THE LIST    #
	 #   BY MANY ITEMS ONE BY ONE    	         #
	#-----------------------------------------------#

	def ReplaceSectionByMany(n1, n2, paOtherListOfItems)
		/* EXAMPLE

		o1 = new stzList([ "A", "B", "_", "_", "_", "F" ])
		o1.ReplaceSectionByMany(3, 5, [ "C", "D", "F" ])
		? o1.Content() #--> [ "A", "B", "C", "D", "E", "F" ]

		*/
		i = 0

		for n = n1 to n2
			i++
			if i <= len(paOtherListOfItems)
				item = paOtherListOfItems[i]
			else
				item = NULL
			ok

			This.ReplaceItemAtPosition(n, item)
		next

		def ReplaceSectionByManyQ(n1, n2, paOtherListOfItems)
			This.ReplaceSectionByMany(n1, n2, paOtherListOfItems)
			return This

	def SectionReplacedByMany(n1, n2, paOtherListOfItems)
		aResult = This.ReplaceSectionByManyQ(n1, n2, paOtherListOfItems).Content()
		return aResult

	   #---------------------------------------------------#
	  #   REPLACING MANY SECTIONS OF ITEMS IN THE LIST    #
	 #   BY MANY ITEMS ONE BY ONE                        #
	#---------------------------------------------------#

	def ReplaceManySectionsByMany(panSections, paOtherListOfItems)
		for anSection in panSections
			n1 = panSections[1]
			n2 = panSections[2]
			This.ReplaceSectionByMany(n1, n2, paOtherListOfItems)
		next

		def ReplaceManySectionsByManyQ(panSections, paOtherListOfItems)
			This.ReplaceManySectionsByMany(panSections, paOtherListOfItems)
			return This

	def ManySectionsReplacedByMany(panSections, paOtherListOfStr)
		acResult = This.Copy().
				ReplaceManySectionsByManyQ(panSections, paOtherListOfItems).
				Content()

		return acResult

	  #--------------------------------------------#
	 #   REPLACING A RANGE OF ITEMS IN THE LIST   #
	#--------------------------------------------#

	def ReplaceRange(n, nRange, pNewItem)

		anSection = RangeToSection([ n, nRange ])
		n1 = anSection[1]
		n2 = anSection[2]

		This.ReplaceSection(n1, n2, pNewItem)

		def ReplaceRangeQ(n, nRange, pNewItem)
			This.ReplaceRange(n, nRange, pNewItem)
			return This

	def RangeReplaced(n, nRange, pNewItem)
		acResult = This.Copy().ReplaceRangeQ(n, nRange, pNewItem).Content()
		return acResult

	  #------------------------------------------------#
	 #   REPLACING MANY RANGES OF ITEMS IN THE LIST   #
	#------------------------------------------------#

	def ReplaceRanges(panRanges, pNewItem)
		for anRange in panRanges
			n = anRange[1]
			nRange = anRange[2]
			This.ReplaceRange(n, nRange, pNewItem)
		next

		def ReplaceRangesQ(panRanges, pNewItem)
			This.ReplaceManyRanges(panRanges, pNewItem)
			return This

		def ReplaceManyRanges(panRanges, pNewItem)
			This.ReplaceRanges(panRanges, pNewItem)

			def ReplaceManyRangesQ(panRanges, pNewItem)
				This.ReplaceManyRanges(panRanges, pNewItem)
				return This

	def RangesReplaced(panRanges, pNewItem)
		acResult = This.Copy().ReplaceManyRangesQ(panRanges, pNewItem).Content()
		return acResult

		def ManyRangesReplaced(panRanges, pNewItem)
			return This.RangesReplaced(panRanges, pNewItem)

	  #-----------------------------------------------------------#		
	 #   REPLACING EACH ITEM IN A RANGE BY THE SAME GIVEN ITEM   #
	#-----------------------------------------------------------#

	def ReplaceEachItemInRange(n, nRange, pNewItem)

		anSection = RangeToSection([ n, nRange ])
		anPositions = ring_sort( StzListOfPairsQ(anSection).ExpandedIfPairsOfNumbers() )

		This.ReplaceItemsAtThesePositions(anPositions, pNewItem)

		def ReplaceEachItemInRangeQ(n, nRange, pNewItem)
			This.ReplaceEachItemInRange(n, nRange, pNewItem)
			return This

	def EachItemInRangeReplaced(n, nRange, pNewItem)

		acResult = This.Copy().ReplaceEachItemInRangeQ(n, nRange, pNewItem).Content()
		return acResult

		def EachItemReplacedInRange(n, nRange, pNewItem)
			return This.EachItemInRangeReplaced(n, nRange, pNewItem)
		
	  #---------------------------------------------------------------#		
	 #   REPLACING EACH ITEM IN MANY RANGES BY THE SAME GIVEN ITEM   #
	#---------------------------------------------------------------#

	def ReplaceEachItemInManyRanges(panRanges, pNewItem)

		for anRange in panRanges
			anSection = RangeToSection(anRange)
			n1 = anSection[1]
			n2 = anSection[2]
			This.ReplaceEachItemInSection(n1, n2, pNewItem)
		next

		def ReplaceEachItemInManyRangesQ(panRanges, pNewItem)
			This.ReplaceEachItemInManyRanges(panRanges, pNewItem)
			return This

	def EachItemInManyRangesReplaced(panRanges, pNewItem)

		acResult =  This.Copy().
				ReplaceEachItemInManyRangesQ(panRanges, pNewItem).
				Content()

		return acResult

		def EachItemReplacedInManyRanges(panRanges, pNewItem)
			return This.EachItemInManyRangesReplaced(panRanges, pNewItem)
	
	   #--------------------------------------------#
	  #   REPLACING A RANGE OF ITEMS IN THE LIST   #
	 #   WITH MANY ITEMS ONE BY ONE               #
	#--------------------------------------------#

	def ReplaceRangeByMany(n, nRange, paOtherListOfItems)

		anSection = RangeToSection([ n, nRange ])
		n1 = anSection[1]
		n2 = anSection[2]

		i = 0
		for n = n1 to n2
			i++
			if i <= len(paOtherListOfItems)
				item = paOtherListOfItems[i]
			else
				item = NULL
			ok

			This.ReplaceItemAtPosition(n, item)
		next

		def ReplaceRangeByManyQ(n, nRange, paOtherListOfItems)
			This.ReplaceRangeByMany(n, nRange, paOtherListOfItems)
			return This

	def RangeReplacedByMany(n, nRange, paOtherListOfItems)
		aResult = This.ReplaceRangeByManyQ(n, nRange, paOtherListOfItems).Content()
		return aResult

	   #------------------------------------------------#
	  #   REPLACING MANY RANGES OF ITEMS IN THE LIST   #
	 #   WITH MANY ITEMS ONE BY ONE                   #
	#------------------------------------------------#

	def ReplaceManyRangesByMany(panRanges, paOtherListOfItems)
		for anRange in panRanges
			anSection = RangeToSection(anRange)
			n1 = anSections[1]
			n2 = anSections[2]
			This.ReplaceRangeByMany(n, nRange, paOtherListOfItems)
		next

		def ReplaceManyRangesByManyQ(panRanges, paOtherListOfItems)
			This.ReplaceManyRangesByMany(panRanges, paOtherListOfItems)
			return This

	def RangesReplacedByMany(panRanges, paOtherListOfItems)
		
		acResult = This.Copy().
				ReplaceManyRangesByManyQ(panRanges, paOtherListOfItems).
				Content()

		return acResult

	  #-----------------------------------------------------------#
	 #   REPLACING ALL ITEMS IN THE LIST WITH A GIVEN NEW ITEM   #
	#-----------------------------------------------------------#

	def ReplaceAllItemsWith(pOtherItem)
		aResult = []
		for i = 1 to This.NumberOfItems()
			aResult + pOtherItem
		next

		This.Update( aResult )

		#< @FunctionFluentForm

		def ReplaceAllItemsWithQ(pOtherItem)
			This.ReplaceAllItemsWith(pOtherItem)
			return This

		#>

		#< @FunctionAlternativeForms

		def ReplaceAllWith(pOtherItem)
			This.ReplaceAllItemsWith(pOtherItem)

			def ReplaceAllWithQ(pOtherItem)
				This.ReplaceAll(pOtherItem)
				return This

		def ReplaceWith(pOtherItem)
			This.ReplaceAllItemsWith(pOtherItem)

			def ReplaceWithQ(pOtherItem)
				This.ReplaceWith(pOtherItem)
				return This

		#>

	def AllItemsReplacedWith(pOtherItem)
		aResult = This.Copy().ReplaceAllItemsWith(pOtherItem)
		return aResult

	  #----------------------------------------------#
	 #   REPLACING ITEMS UNDER A GIVEN CONDITION    #
	#----------------------------------------------#

	def ReplaceItemsW(pCondition, pOtherItem)

		anPositions = This.FindItemsW(pCondition)
		This.ReplaceItemsAtPositions(anPositions, pOtherItem)

		#< @FunctionFluentForm

		def ReplaceItemsWQ(pCondition, pOtherItem)
			This.ReplaceItemsW(pCondition, pOtherItem)
			return This

		#>

		#< @FunctionAlternativeForm

		def ReplaceW(pCondition, pOtherItem)
			This.ReplaceItemsW(pCondition, pOtherItem)

			def ReplaceWQ(pCondition, pOtherItem)
				This.ReplaceW(pCondition, pOtherItem)
				return This

		#>

	def ItemsReplacedW(pCondition, pOtherItem)
		aResult = This.Copy().ReplaceItemsW(pCondition, pOtherItem)
		return aResult

	  #----------------------------------#
	 #  REPLACING AN ITEM AT ANY LEVEL  #
	#----------------------------------#

	// Replaces an item at any nested level of the list by a new value
	def DeepReplaceCS(pItem, pByValue, pCaseSensitive)
		/* EXAMPLE

		o1 = new stzList([
			"me",
			"other",
			[ "other", "me", [ "me" ], "other" ],
			"other"
		])
		
		o1.DeepReplace("me", :By = "you")
		? o1.Content()
		#--> [
		#	"you",
		#	"other",
		#	[ "other", "me", [ "you" ], "other" ],
		#	"other"
		#    ]
		
		*/

		if isList(pByValue) and Q(pByValue).IsByOrWithNamedParam()
			pByValue = pByValue[2]
		ok

		cValue = @@(pItem)
		cByValue = @@(pByValue)

		cCode = This.ToCodeQ().ReplaceCSQ( cValue, cByValue, pCaseSensitive ).Content()
		cCode = ' aResult = ' + cCode

		eval(cCode)
		This.Update( aResult )

		def DeepReplaceCSQ(pItem, pByValue, pCaseSensitive)
			This.DeepReplaceCS(pItem, pByValue, pCaseSensitive)
			return This

	#-- WITHOUT CASESENSITIVITY

	def DeepReplace(pItem, pByValue)
		This.DeepReplaceCS(pItem, pByValue, :CaseSensitive = TRUE)

		def DeepReplaceQ(pItem, pByValue)
			This.DeepReplace(pItem, pByValue)
			return This

	  #=========================================================#
	 #   REMOVING ALL OCCURRENCE OF A GIVEN ITEM IN THE LIST   #
	#=========================================================#

	def RemoveAllCS(pItem, pCaseSensitive)
		if isList(pItem) and Q(pItem).IsOfNamedParam()
			pItem = pItem[2]
		ok

		anPositions = This.FindAllCS(pItem, pCaseSensitive)
		nLenPos = len(anPositions)

		for i = nLenPos to 1 step -1
			This.RemoveItemAtPosition(anPositions[i])
		next

		#< @FunctionFluentForm

		def RemoveAllCSQ(pItem, pCaseSensitive)
			This.RemoveAllCS(pItem, pCaseSensitive)
			return This
	
		#>

		#< @FunctionAlternativeForms

		def RemoveAllOccurrencesCS(pItem, pCaseSensitive)
			This.RemoveAllCS(pItem, pCaseSensitive)

			def RemoveAllOccurrencesCSQ(pItem, pCaseSensitive)
				This.RemoveAllOccurrencesCS(pItem, pCaseSensitive)
				return This

		def RemoveCS(pItem, pCaseSensitive)
			This.RemoveAllCS(pItem, pCaseSensitive)

			def RemoveCSQ(pItem, pCaseSensitive)
				This.RemoveCS(pItem, pCaseSensitive)
				return This

		def RemoveItemCS(pItem, pCaseSensitive)
			This.RemoveAllCS(pItem, pCaseSensitive)

			def RemoveItemCSQ(pItem, pCaseSensitive)
				This.RemoveItemCS(pItem, pCaseSensitive)
				return This

		#>

	def AllOccurrencesOfThisItemRemovedCS(pItem, pCaseSensitive)
		aResult = This.Copy().RemoveAllOccurrencesCSQ(pItem, pCaseSensitive).Content()
		return aResult

		def AllOccurrencesRemovedCS(pItem, pCaseSensitive)
			return This.AllOccurrencesOfThisItemRemovedCS(pItem, pCaseSensitive)

		def ItemRemovedCS(pItem, pCaseSensitive)
			return This.AllOccurrencesOfThisItemRemovedCS(pItem, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def RemoveAll(pItem)
		This.RemoveAllCS(pItem, :CaseSensitive = TRUE)

		#< @FunctionFluentForm

		def RemoveAllQ(pItem)
			This.RemoveAll(pItem)
			return This
	
		#>

		#< @FunctionAlternativeForms

		def RemoveAllOccurrences(pItem)
			This.RemoveAll(pItem)

			def RemoveAllOccurrencesQ(pItem)
				This.RemoveAllOccurrences(pItem)
				return This

		def Remove(pItem)
			This.RemoveAll(pItem)

			def RemoveQ(pItem)
				This.Remove(pItem)
				return This

		def RemoveItem(pItem)
			This.RemoveAll(pItem)

			def RemoveItemQ(pItem)
				This.RemoveItem(pItem)
				return This

	def AllOccurrencesOfThisItemRemoved(pItem)
		aResult = This.Copy().RemoveAllOccurrencesQ(pItem).Content()
		return aResult

		def AllOccurrencesRemoved(pItem)
			return This.AllOccurrencesOfThisItemRemoved(pItem)

		def ItemRemoved(pItem)
			return This.AllOccurrencesOfThisItemRemoved(pItem)

	  #-------------------------------------------------------#
	 #   REMOVING GIVEN OCCURRENCES OF AN ITEM IN THE LIST   # TODO: Add CASESENSITIVITY
	#-------------------------------------------------------#

	def RemoveOccurrences(panOccurrences, pItem)
		for n in panOccurrences
			This.RemoveNthOccurrence(n, pItem)
		next

		#< @FunctionFluentForm

		def RemoveOccurrencesQ(panOccurrences, pItem)
			This.RemoveOccurrences(panOccurrences, pItem)
			return This

		#>

		#< @FunctionAlternativeForm

		def RemoveManyOccurrences(paOccurrences, pItem)
			This.RemoveOccurrences(panOccurrences, pItem)

			def RemoveManyOccurrencesQ(paOccurrences, pItem)
				This.RemoveManyOccurrences(paOccurrences, pItem)
				return This

		def RemoveTheseOccurrences(panOccurrences, pItem)
			This.RemoveOccurrences(panOccurrences, pItem)

			def RemoveTheseOccurrencesQ(panOccurrences, pItem)
				This.RemoveTheseOccurrences(panOccurrences, pItem)
				return This

		#>

	def OccurrencesRemoved(panOccurrences, pItem)
		aResult = This.Copy.RemoveOccurrencesQ(panOccurrences, pItem).Content()
		return aResult

		def TheseOccurrencesRemoved(panOccurrences, pItem)
			return This.OccurrencesRemoved(panOccurrences, pItem)

		def TheseOccurrencesOfThisItemRemoved(panOccurrences, pItem)
			return This.OccurrencesRemoved(panOccurrences, pItem)

		def ManyOccurrencesOfThisItemRemoved(panOccurrences, pItem)
			return This.OccurrencesRemoved(panOccurrences, pItem)

		def ManyOccurrencesRemoved(panOccurrences, pItem)
			return This.OccurrencesRemoved(panOccurrences, pItem)

	  #------------------------------------------#
	 #   REMOVING MANY ITEMS AT THE SAME TIME   #
	#------------------------------------------#

	def RemoveManyCS(paItems, pCaseSensitive)

		nLen = len(paItems)

		for i = 1 to nLen
			This.RemoveAllCS(paItems[i], pCaseSensitive)
		next

		#< @FunctionFluentForm

		def RemoveManyCSQ(pacItems, pCaseSensitive)
			This.RemoveManyCS(pacItems, pCaseSensitive)
			return This

		#>

		#< @FunctionAlternativeForms

		def RemoveAllOfTheseCS(pacItems, pCaseSensitive)
			This.RemoveManyCS(pacItems, pCaseSensitive)

			def RemoveAllOfTheseCSQ(pacItems, pCaseSensitive)
				This.RemoveAllOfTheseCS(pacItems, pCaseSensitive)
				return This

		def RemoveTheseCS(pacItems, pCaseSensitive)
			This.RemoveManyCS(pacItems, pCaseSensitive)

			def RemoveTheseCSQ(pacItems, pCaseSensitive)
				This.RemoveTheseCS(pacItems, pCaseSensitive)
				return This

		def RemoveTheseItemsCS(pacItems, pCaseSensitive)
			This.RemoveManyCS(pacItems, pCaseSensitive)

			def RemoveTheseItemsCSQ(pacItems, pCaseSensitive)
				This.RemoveTheseItemsCS(pacItems, pCaseSensitive)
				return This

		#>

	def TheseItemsRemovedCS(pacItems, pCaseSensitive)

		aResult =  This.Copy().
				RemoveTheseItemsCSQ(pacItems, pCaseSensitive).
				Content()

		return aResult

		#< @FunctionAlternativeForms

		def AllOfTheseItemsRemovedCS(pacItems, pCaseSensitive)
			return This.TheseItemsRemovedCS(pacItems, pCaseSensitive)

		def ManyItemsRemovedCS(pacItems, pCaseSensitive)
			return This.TheseItemsRemovedCS(pacItems, pCaseSensitive)

		def ManyRemovedCS(pacItems, pCaseSensitive)
			return This.TheseItemsRemovedCS(pacItems, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def RemoveMany(pacItems)
		This.RemoveManyCS(pacItems, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def RemoveAllOfThese(pacItems)
			This.RemoveMany(pacItems)

			def RemoveAllOfTheseQ(pacItems)
				This.RemoveAllOfThese(pacItems)
				return This

		def RemoveThese(pacItems)
			This.RemoveMany(pacItems)

			def RemoveTheseQ(pacItems)
				This.RemoveThese(pacItems)
				return This

		def RemoveTheseItems(pacItems)
			This.RemoveMany(pacItems)

			def RemoveTheseItemsQ(pacItems)
				This.RemoveTheseItems(pacItems)
				return This

		#>

	def TheseItemsRemoved(pacItems)

		aResult =  This.Copy().
				RemoveTheseItemsQ(pacItems).
				Content()

		return aResult

		#< @FunctionAlternativeForms

		def AllOfTheseItemsRemoved(pacItems)
			return This.TheseItemsRemoved(pacItems)

		def ManyItemsRemoved(pacItems)
			return This.TheseItemsRemoved(pacItems)

		def ManyRemoved(pacItems)
			return This.TheseItemsRemoved(pacItems)

		#>

	  #-------------------------------------------------#
	 #   REMOVING THE NTH OCCURRENCE OF A GIVEN ITEM   #
	#-------------------------------------------------#

	def RemoveNthOccurrenceCS(n, pItem, pCaseSensitive)
		n = This.FindNthOccurrenceCS(n, pItem, pCaseSensitive)
		This.RemoveItemAtPosition( n )

		#< @FunctionFluentForm

		def RemoveNthOccurrenceCSQ(n, pItem, pCaseSensitive)
			This.RemoveNthOccurrenceCS(n, pItem, pCaseSensitive)
			return This
	
		#>

		#< @FunctionAlternativeForms

		def RemoveNthCS(n, pItem, pCaseSensitive)
			This.RemoveNthOccurrenceCS(n, pItem, pCaseSensitive)

			def RemoveNthCSQ(n, pItem, pCaseSensitive)
				This.RemoveNthCS(n, pItem, pCaseSensitive)
				return This

		def RemoveOccurrenceCS(n, pItem, pCaseSensitive)
			This.RemoveNthOccurrenceCS(n, pItem, pCaseSensitive)

			def RemoveOccurrenceCSQ(n, pItem, pCaseSensitive)
				This.RemoveOccurrenceCS(n, pItem, pCaseSensitive)
				return This

		#>

	def NthOccurrenceRemovedCS(n, pItem, pCaseSensitive)
		aResult = This.Copy().RemoveNthOccurrencesCSQ(n, pItem, pCaseSensitive).Content()
		return aResult

		def NthRemovedCS(n, pItem, pCaseSensitive)
			return This.NthOccurrenceRemovedCS(n, pItem, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def RemoveNthOccurrence(n, pItem)
		This.RemoveNthOccurrenceCS(n, pItem, :CaseSensitive = TRUE)

		#< @FunctionFluentForm

		def RemoveNthOccurrenceQ(n, pItem)
			This.RemoveNthOccurrence(n, pItem)
			return This
	
		#>

		#< @FunctionAlternativeForms

		def RemoveNth(n, pItem)
			This.RemoveNthOccurrence(n, pItem)

			def RemoveNthQ(n, pItem)
				This.RemoveNth(n, pItem)
				return This

		def RemoveOccurrence(n, pItem)
			This.RemoveNth(n, pItem)

			def RemoveOccurrenceQ(n, pItem)
				This.RemoveOccurrence(n, pItem)
				return This
		#>

	def NthOccurrenceRemoved(n, pItem)
		aResult = This.Copy().RemoveNthOccurrencesQ(n, pItem).Content()
		return aResult

		def NthRemoved(n, pItem)
			return This.NthOccurrenceRemoved(n, pItem)

	  #----------------------------------------------#
	 #   REMOVING THE FIRST OCCURRENCE OF AN ITEM   #
	#----------------------------------------------#

	def RemoveFirstOccurrenceCS(pItem, pCaseSensitive)

		This.RemoveItemAtPosition( This.FindFirstOccurrenceCS(pItem, pCaseSensitive) )


		#< @FunctionFluentForm

		def RemoveFirstOccurrenceCSQ(pItem, pCaseSensitive)
			This.RemoveFirstOccurrenceCS(pItem, pCaseSensitive)
			return This
	
		#>

		#< @FunctionAlternativeForm

		def RemoveFirstCS(pItem, pCaseSensitive)
			This.RemoveFirstOccurrenceCS(pItem, pCaseSensitive)

			def RemoveFirstCSQ(pItem, pCaseSensitive)
				This.RemoveFirstCS(pItem, pCaseSensitive)
				return This

		#>

	def FirstOccurrenceRemovedCS(pItem, pCaseSensitive)
		aResult = This.Copy().RemoveFirstOccurrenceCSQ(pItem, pCaseSensitive).Content()
		return aResult

		def FirstRemovedCS(pItem, pCaseSensitive)
			return This.FirstOccurrenceRemovedCS(pItem, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def RemoveFirstOccurrence(pItem)
		This.RemoveFirstOccurrenceCS(pItem, :CaseSensitive = TRUE)


		#< @FunctionFluentForm

		def RemoveFirstOccurrenceQ(pItem)
			This.RemoveFirstOccurrence(pItem)
			return This
	
		#>

		#< @FunctionAlternativeForm

		def RemoveFirst(pItem)
			This.RemoveFirstOccurrence(pItem)

			def RemoveFirstQ(pItem)
				This.RemoveFirst(pItem)
				return This

		#>

	def FirstOccurrenceRemoved(pItem)
		aResult = This.Copy().RemoveFirstOccurrenceQ(pItem).Content()
		return aResult

		def FirstRemoved(pItem)
			return This.FirstOccurrenceRemoved(pItem)

	  #--------------------------------------------------#
	 #   REMOVING THE LAST OCCURRENCE OF A GIVEN ITEM   #
	#--------------------------------------------------#

	def RemoveLastOccurrenceCS(pItem, pCaseSensitive)
		n = This.FindLastOccurrenceCS(pItem, pCaseSensitive)

		if n <= This.NumberOfItems()
			This.RemoveItemAtPosition( n )
		ok

		#< @FunctionFluentForm

		def RemoveLastOccurrenceCSQ(pItem, pCaseSensitive)
			This.RemoveLastOccurrenceCS(pItem, pCaseSensitive)
			return This
	
		#>

		#< @FunctionAlternativeForm

		def RemoveLastCS(pItem, pCaseSensitive)
			This.RemoveLastOccurrenceCS(pItem, pCaseSensitive)

			def RemoveLastCSQ(pItem, pCaseSensitive)
				This.RemoveLastCS(pItem, pCaseSensitive)
				return This

		#>

	def LastOccurrenceRemovedCS(pItem, pCaseSensitive)
		aResult = This.Copy().RemoveLastOccurrenceCSQ(pItem, pCaseSensitive).Content()
		return aResult

		def LastRemovedCS(pItem, pCaseSensitive)
			return This.LastOccurrenceRemovedCS(pItem, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def RemoveLastOccurrence(pItem)
		n = This.FindLastOccurrence(pItem)

		if n <= This.NumberOfItems()
			This.RemoveItemAtPosition( n )
		ok

		#< @FunctionFluentForm

		def RemoveLastOccurrenceQ(pItem)
			This.RemoveLastOccurrence(pItem)
			return This
	
		#>

		#< @FunctionAlternativeForm

		def RemoveLast(pItem)
			This.RemoveLastOccurrence(pItem)

			def RemoveLastQ(pItem)
				This.RemoveLast(pItem)
				return This

		#>

	def LastOccurrenceRemoved(pItem)
		aResult = This.Copy().RemoveLastOccurrenceQ(pItem).Content()
		return aResult

		def LastRemoved(pItem)
			return This.LastOccurrenceRemoved(pItem)

	   #----------------------------------------------#
	  #   REMOVING NEXT NTH OCCURRENCE OF AN ITEM    #
	 #   STARTING AT A GIVEN POSITION IN THE LIST   #
	#----------------------------------------------#

	def RemoveNextNthOccurrenceCS(n, pItem, pnStartingAt, pCaseSensitive)
		if isList(pItem) and StzListQ(pItem).IsOfNamedParam()
			pItem = pItem[2]
		ok

		if isList(pnStartingAt) and Q(pnStartingAt).IsStartingAtNamedParam()
			pnStartingAt = pnStartingAt[2]
		ok

		if isString(pnStartingAt)
			if Q(pnStartingAt).IsOneOfTheseCS([
				:First, :FirstPosition, :FirstItem, :FirstItem ], :CS = FALSE)

				pnStartingAt = 1
			
			but Q(pnStartingAt).IsOneOfTheseCS([
				:Last, :LastPosition, :LastItem, :LastItem ], :CS = FALSE)

				pnStartingAt = This.NumberOfItems()
			ok
		ok

		if NOT isNumber(pnStartingAt)
			StzRaise("Incorrect param! pnStartingAt must be a number.")
		ok

		oSection   = This.SectionQ(pnStartingAt, :LastItem)
		aPositions = oSection.FindAllCS(pItem, pCaseSensitive)

		aPositions = StzListOfNumbersQ(aPositions).AddToEachQ(pnStartingAt - 1).Content()
		nPosition = aPositions[n]

		This.RemoveItemAtPosition(nPosition)

		#< @FuntionFluentForm

		def RemoveNextNthOccurrenceCSQ(n, pItem, pnStartingAt, pCaseSensitive)
			This.RemoveNextNthOccurrenceCS(n, pItem, pnStartingAt, pCaseSensitive)
			return This

		#<

		#< @FunctionAlternativeForm

		def RemoveNthNextOccurrenceCS(n, pItem, pnStartingAt, pCaseSensitive)
			This.RemoveNextNthOccurrenceCS(n, pItem, pnStartingAt, pCaseSensitive)

			def RemoveNthNextOccurrenceCSQ(n, pItem, pnStartingAt, pCaseSensitive)
				This.RemoveNthNextOccurrenceCS(n, pItem, pnStartingAt, pCaseSensitive)
				return This

		#>

	def NthNextOccurrenceRemovedCS(n, pItem, pnStartingAt, pCaseSensitive)

		aResult  = This.Copy().
				RemoveNthNextOccurrenceCSQ(n, pItem, pnStartingAt, pCaseSensitive).
				Content()

		return aResult

		def NextNthOccurrenceRemovedCS(n, pItem, pnStartingAt, pCaseSensitive)
			return This.NthNextOccurrenceRemovedCS(n, pItem, pnStartingAt, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def RemoveNextNthOccurrence(n, pItem, pnStartingAt)
		This.RemoveNextNthOccurrenceCS(n, pItem, pnStartingAt, :CaseSensitive = TRUE)

		#< @FuntionFluentForm

		def RemoveNextNthOccurrenceQ(n, pItem, pnStartingAt)
			This.RemoveNextNthOccurrence(n, pItem, pnStartingAt)
			return This

		#<

		#< @FunctionAlternativeForm

		def RemoveNthNextOccurrence(n, pItem, pnStartingAt)
			This.RemoveNextNthOccurrence(n, pItem, pnStartingAt)

			def RemoveNthNextOccurrenceQ(n, pItem, pnStartingAt)
				This.RemoveNthNextOccurrence(n, pItem, pnStartingAt)
				return This

		#>

	def NthNextOccurrenceRemoved(n, pItem, pnStartingAt)

		aResult  = This.Copy().
				RemoveNthNextOccurrenceQ(n, pItem, pnStartingAt).
				Content()

		return aResult

		def NextNthOccurrenceRemoved(n, pItem, pnStartingAt)
			return This.NthNextOccurrenceRemoved(n, pItem, pnStartingAt)

	   #-----------------------------------------------#
	  #   REMOVING NEXT OCCURRENCE OF AN ITEM         #
	 #   STARTING AT A GIVEN POSITION IN THE LIST    #
	#-----------------------------------------------#

	def RemoveNextOccurrenceCS(pItem, pnStartingAt, pCaseSensitive)
		This.RemoveNextNthOccurrenceCS(1, pItem, pnStartingAt, pCaseSensitive)

		def RemoveNextOccurrenceCSQ(pItem, pnStartingAt, pCaseSensitive)
			This.RemoveNextOccurrenceCS(pItem, pnStartingAt, pCaseSensitiy)
			return This

		def RemoveNextCS(pItem, pnStartingAt, pCaseSensitive)
			This.RemoveNextOccurrenceCS(pItem, pnStartingAt, pCaseSensitive)

			def RemoveNextCSQ(pItem, pnStartingAt, pCaseSensitive)
				This.RemoveNextCS(pItem, pnStartingAt, pCaseSensitive)
				return This

	def NextOccurrenceRemovedCS(pItem, pnStartingAt, pCaseSensitive)
		aRresult =  This.Copy().
				RemoveNextOccurrenceCSQ(pItem, pnStartingAt, pCaseSensitive).
				Content()
		return aResult

		def NextRemovedCS(pItem, pnStartingAt, pCaseSensitive)
			return This.NextOccurrenceRemovedCS(pItem, pnStartingAt, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def RemoveNextOccurrence(pItem, pnStartingAt)
		This.RemoveNextNthOccurrence(1, pItem, pnStartingAt)

		def RemoveNextOccurrenceQ(pItem, pnStartingAt)
			This.RemoveNextOccurrence(pItem, pnStartingAt)
			return This

		def RemoveNext(pItem, pnStartingAt)
			This.RemoveNextOccurrence(pItem, pnStartingAt)

			def RemoveNextQ(pItem, pnStartingAt)
				This.RemoveNext(pItem, pnStartingAt)
				return This

	def NextOccurrenceRemoved(pItem, pnStartingAt)
		aRersult =  This.Copy().
				RemoveNextOccurrenceQ(pItem, pnStartingAt).
				Content()
		return aRersult

		def NextRemoved(pItem, pnStartingAt)
			return This.NextOccurrenceRemoved(pItem, pnStartingAt)

	   #----------------------------------------------------#
	  #   REMOVING MANY NEXT NTH OCCURRENCES OF AN ITEM    #
	 #   STARTING AT A GIVEN POSITION IN THE LIST         #
	#----------------------------------------------------#

	def RemoveNextNthOccurrencesCS(panList, pItem, pnStartingAt, pCaseSensitive)
		/* Example

		StzListQ([ "A" , "B", "A", "C", "A", "D", "A" ]) {
			RemoveNexNthOccurrences([2, 3], :of = "A", :StartingAt = 3)
			? Content() # !--> [ "A" , "B", "A", "C", "D" ]
		}		

		*/

		if NOT (isList(panList) and StzListQ(panList).IsListOfNumbers() and
		        StzListQ(panList).NumberOfItemsW("StzNumberQ(@item).IsBetween(1, " + This.NumberOfItems() + ")") = len(panList) )

			StzRaise("Incorrect param! panList must be a list of numbers between 1 and This.NumberOfItems().")
		ok

		if isList(pItem) and StzListQ(pItem).IsOfNamedParam()
			pItem = pItem[2]
		ok

		if isList(pnStartingAt) and StzListQ(pnStartingAt).IsStartingAtNamedParam()
			pnStartingAt = pnStartingAt[2]
		ok

		if isString(pnStartingAt)
			if Q(pnStartingAt).IsOneOfTheseCS([
				:First, :FirstPosition, :FirstItem, :FirstItem ], :CS = FALSE)

				pnStartingAt = 1
			
			but Q(pnStartingAt).IsOneOfTheseCS([
				:Last, :LastPosition, :LastItem, :LastItem ], :CS = FALSE)

				pnStartingAt = This.NumberOfItems()
			ok
		ok

		if NOT isNumber(pnStartingAt)
			StzRaise("Incorrect param! pnStartingAt must be a number.")
		ok
			
		oSection = This.SectionQ(pnStartingAt, :LastItem)

		anPositions  = 	oSection.
				FindAllCSQR(pItem, pCaseSensitive, :stzListOfNumbers).
				AddToEachQ(pnStartingAt-1).
				Content()

		anPositionsToBeRemoved = []
		nLen = len(panList)
		nLenPos = len(anPositions)

		for i = 1 to nLen
			if i <= nLenPos
				anPositionsToBeRemoved +  anPositions[panList[i]]
			ok
		next

		This.RemoveItemsAtThesePositionsCS(anPositionsToBeRemoved, pCaseSensitive)

		#< @FunctionFluentForm

		def RemoveNextNthOccurrencesCSQ(panList, pItem, pnStartingAt, pCaseSensitive)
			This.RemoveNextNthOccurrencesCS(panList, pItem, pnStartingAt, pCaseSensitive)
			return This

		#>

		#< @FunctionAlternativeForm

		def RemoveNthNextOccurrencesCS(panList, pItem, pnStartingAt, pCaseSensitive)
			This.RemoveNextNthOccurrencesCS(panList, pItem, pnStartingAt, pCaseSensitive)

			def RemoveNthNextOccurrencesCSQ(panList, pItem, pnStartingAt, pCaseSensitive)
				This.RemoveNthNextOccurrencesCS(panList, pItem, pnStartingAt, pCaseSensitive)
				return This

		def RemoveNextOccurrencesCS(panList, pItem, pnStartingAt, pCaseSensitive)
			This.RemoveNextNthOccurrencesCS(panList, pItem, pnStartingAt, pCaseSensitive)

			def RemoveNextOccurrencesCSQ(panList, pItem, pnStartingAt, pCaseSensitive)
				This.RemoveNthNextOccurrencesCS(panList, pItem, pnStartingAt, pCaseSensitive)
				return This
		#>

	def NextNthOccurrencesRemovedCS(panList, pItem, pnStartingAt, pCaseSensitive)

		aResult =  This.
			   RemoveNextNthOccurrencesCSQ(panList, pItem, pnStartingAt, pCaseSensitive).
			   Content()

		return aResult

		def NthNextOccurrencesRemovedCS(panList, pItem, pnStartingAt, pCaseSensitive)
			return This.NextNthOccurrencesRemovedCS(panList, pItem, pnStartingAt, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def RemoveNextNthOccurrences(panList, pItem, pnStartingAt)
		This.RemoveNextNthOccurrencesCS(panList, pItem, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionFluentForm

		def RemoveNextNthOccurrencesQ(panList, pItem, pnStartingAt)
			This.RemoveNextNthOccurrences(panList, pItem, pnStartingAt)
			return This

		#>

		#< @FunctionAlternativeForm

		def RemoveNthNextOccurrences(panList, pItem, pnStartingAt)
			This.RemoveNextNthOccurrences(panList, pItem, pnStartingAt)

			def RemoveNthNextOccurrencesQ(panList, pItem, pnStartingAt)
				This.RemoveNthNextOccurrences(panList, pItem, pnStartingAt)
				return This

		def RemoveNextOccurrences(panList, pItem, pnStartingAt)
			This.RemoveNextNthOccurrences(panList, pItem, pnStartingAt)

			def RemoveNextOccurrencesQ(panList, pItem, pnStartingAt)
				This.RemoveNthNextOccurrences(panList, pItem, pnStartingAt)
				return This
		#>

	def NextNthOccurrencesRemoved(panList, pItem, pnStartingAt)

		aResult =  This.
			   RemoveNextNthOccurrencesQ(panList, pItem, pnStartingAt).
			   Content()

		return aResult

		def NthNextOccurrencesRemoved(panList, pItem, pnStartingAt)
			return This.NextNthOccurrencesRemoved(panList, pItem, pnStartingAt)

	   #--------------------------------------------------#
	  #   REMOVING PREVIOUS NTH OCCURRENCE OF AN ITEM    #
	 #   STARTING AT A GIVEN POSITION IN THE LIST       #
	#--------------------------------------------------#

	def RemovePreviousNthOccurrenceCS(n, pItem, pnStartingAt, pCaseSensitive)
		if isList(pItem) and StzListQ(pItem).IsOfNamedParam()
			pItem = pItem[2]
		ok

		if isList(pnStartingAt) and StzListQ(pnStartingAt).IsStartingAtNamedParam()
			pnStartingAt = pnStartingAt[2]
		ok

		if isString(pnStartingAt)
			if Q(pnStartingAt).IsOneOfTheseCS([
				:First, :FirstPosition, :FirstItem, :FirstItem ], :CS = FALSE)

				pnStartingAt = 1
			
			but Q(pnStartingAt).IsOneOfTheseCS([
				:Last, :LastPosition, :LastItem, :LastItem ], :CS = FALSE)

				pnStartingAt = This.NumberOfItems()
			ok
		ok

		if NOT isNumber(pnStartingAt)
			StzRaise("Incorrect param! pnStartingAt must be a number.")
		ok

		oSection   = This.SectionQ(1, pnStartingAt)
		aPositions = oSection.FindAllCS(pItem, pCaseSensitive)

		nPosition = aPositions[ len(aPositions) - n + 1 ]

		This.RemoveItemAtPosition(nPosition)

		def RemovePreviousNthOccurrenceCSQ(n, pItem, pnStartingAt, pCaseSensitive)
			This.RemovePreviousNthOccurrenceCS(n, pItem, pnStartingAt, pCaseSensitive)
			return This

		def RemoveNthPreviousOccurrenceCS(n, pItem, pnStartingAt, pCaseSensitive)
			This.RemovePreviousNthOccurrenceCS(n, pItem, pnStartingAt, pCaseSensitive)

			def RemoveNthPreviousOccurrenceCSQ(n, pItem, pnStartingAt, pCaseSensitive)
				This.RemoveNthPreviousOccurrenceCS(n, pItem, pnStartingAt, pCaseSensitive)
				return This

	def NthPreviousOccurrenceRemovedCS(n, pItem, pnStartingAt, pCaseSensitive)

		aResult =  This.Copy().
				RemoveNthPreviousOccurrenceCSQ(n, pItem, pnStartingAt, pCaseSensitive).
				Content()

		return This

		def PreviousNthOccurrenceRemovedCS(n, pItem, pnStartingAt, pCaseSensitive)
			return This.NthPreviousOccurrenceRemovedCS(n, pItem, pnStartingAt, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def RemovePreviousNthOccurrence(n, pItem, pnStartingAt)
		This.RemovePreviousNthOccurrenceCS(n, pItem, pnStartingAt, :CaseSensitive = TRUE)

		def RemovePreviousNthOccurrenceQ(n, pItem, pnStartingAt)
			This.RemovePreviousNthOccurrence(n, pItem, pnStartingAt)
			return This

		def RemoveNthPreviousOccurrence(n, pItem, pnStartingAt)
			This.RemovePreviousNthOccurrence(n, pItem, pnStartingAt)

			def RemoveNthPreviousOccurrenceQ(n, pItem, pnStartingAt)
				This.RemoveNthPreviousOccurrence(n, pItem, pnStartingAt)
				return This

	def NthPreviousOccurrenceRemoved(n, pItem, pnStartingAt)

		aResult =  This.Copy().
				RemoveNthPreviousOccurrenceQ(n, pItem, pnStartingAt).
				Content()

		return This

		def PreviousNthOccurrenceRemoved(n, pItem, pnStartingAt)
			return This.NthPreviousOccurrenceRemoved(n, pItem, pnStartingAt)

	   #----------------------------------------------#
	  #   REMOVING PREVIOUS OCCURRENCE OF AN ITEM    #
	 #   STARTING AT A GIVEN POSITION IN THE LIST   #
	#----------------------------------------------#

	def RemovePreviousOccurrenceCS(pItem, pnStartingAt, pCaseSensitive)
		This.RemovePreviousNthOccurrenceCS(1, pItem, pnStartingAt, pCaseSensitive)

		def RemovePreviousOccurrenceCSQ(pItem, pnStartingAt, pCaseSensitive)
			This.RemovePreviousOccurrenceCS(pItem, pnStartingAt, pCaseSensitive)
			return This

		def RemovePreviousCS(pItem, pnStartingAt, pCaseSensitive)
			This.RemovePreviousOccurrenceCS(pItem, pnStartingAt, pCaseSensitive)

	def PreviousOccurrenceRemovedCS(pItem, pnStartingAt, pCaseSensitive)
		aResult =  This.Copy().
				RemovePreviousOccurrenceCSQ(pItem, pnStartingAt, pCaseSensitive).
				Content()
		return This

		def PreviousRemovedCS(pItem, pnStartingAt, pCaseSensitive)
			return This.PreviousOccurrenceRemovedCS(pItem, pnStartingAt, pCaseSensitive)

	# WITHOUT CASESENSITIVITY

	def RemovePreviousOccurrence(pItem, pnStartingAt)
		This.RemovePreviousOccurrenceCS(pItem, pnStartingAt, :CaseSensitive = TRUE)

		def RemovePreviousOccurrenceQ(pItem, pnStartingAt)
			This.RemovePreviousOccurrence(pItem, pnStartingAt)
			return This

		def RemovePrevious(pItem, pnStartingAt)
			This.RemovePreviousOccurrence(pItem, pnStartingAt)

	def PreviousOccurrenceRemoved(pItem, pnStartingAt)
		aResult =  This.Copy().
				RemovePreviousOccurrenceQ(pItem, pnStartingAt).
				Content()
		return This

		def PreviousRemoved(pItem, pnStartingAt)
			return This.PreviousOccurrenceRemoved(pItem, pnStartingAt)

	   #--------------------------------------------------------#
	  #   REMOVING MANY PREVIOUS NTH OCCURRENCES OF AN ITEM    #
	 #   STARTING AT A GIVEN POSITION IN THE LIST             #
	#--------------------------------------------------------#

	def RemovePreviousNthOccurrencesCS(panList, pItem, pnStartingAt, pCaseSensitive)
		/* Example

		StzListQ([ "A" , "B", "A", "C", "A", "D", "A" ]) {
			RemovePreviousNthOccurrences([2, 3], :of = "A", :StartingAt = 5)
			? Content() # --> [ "A" , "B", "C", "D", "A" ]
		}		

		*/

		if NOT (isList(panList) and StzListQ(panList).IsListOfNumbers() and
		        StzListQ(panList).NumberOfItemsW("StzNumberQ(@item).IsBetween(1, " + This.NumberOfItems() + ")") = len(panList) )

			StzRaise("Incorrect param! panList must be a list of numbers between 1 and This.NumberOfItems().")
		ok

		if isList(pItem) and StzListQ(pItem).IsOfNamedParam()
			pItem = pItem[2]
		ok

		if isList(pnStartingAt) and StzListQ(pnStartingAt).IsStartingAtNamedParam()
			pnStartingAt = pnStartingAt[2]
		ok

		if isString(pnStartingAt)
			if Q(pnStartingAt).IsOneOfTheseCS([
				:First, :FirstPosition, :FirstItem, :FirstItem ], :CS = FALSE)

				pnStartingAt = 1
			
			but Q(pnStartingAt).IsOneOfTheseCS([
				:Last, :LastPosition, :LastItem, :LastItem ], :CS = FALSE)

				pnStartingAt = This.NumberOfItems()
			ok
		ok

		if NOT isNumber(pnStartingAt)
			StzRaise("Incorrect param! pnStartingAt must be a number.")
		ok
			
		oSection = This.SectionQ(1, pnStartingAt)

		anPositions = oSection.FindAllCSQ(pItem, pCaseSensitive).ItemsReversed()

		anPositionsToBeRemoved = []
		nLen = len(panList)
		nLenPositions = len(anPositions)

		for i = 1 to nLen
			if i <= nLenPso
				anPositionsToBeRemoved + anPositions[panList[i]]
			ok
		next

		This.RemoveItemsAtThesePositionsCS(anPositionsToBeRemoved, pCaseSensitive)

		#< @FunctionFluentForm

		def RemovePreviousNthOccurrencesCSQ(panList, pItem, pnStartingAt, pCaseSensitive)
			This.RemovePreviousNthOccurrencesCS(panList, pItem, pnStartingAt, pCaseSensitive)
			return This

		#>

		#< @FunctionAlternativeForm

		def RemovePreviousOccurrencesCS(panList, pItem, pnStartingAt, pCaseSensitive)
			This.RemovePreviousNthOccurrencesCS(panList, pItem, pnStartingAt, pCaseSensitive)

			def RemovePreviousOccurrencesCSQ(panList, pItem, pnStartingAt, pCaseSensitive)
				This.RemovePreviousOccurrencesCS(panList, pItem, pnStartingAt, pCaseSensitive)
				return This

		def RemoveNthPreviousOccurrencesCS(panList, pItem, pnStartingAt, pCaseSensitive)
			This.RemovePreviousNthOccurrencesCS(panList, pItem, pnStartingAt, pCaseSensitive)

			def RemoveNthPreviousOccurrencesCSQ(panList, pItem, pnStartingAt, pCaseSensitive)
				This.RemoveNthPreviousOccurrencesCS(panList, pItem, pnStartingAt, pCaseSensitive)
				return This
		#>

	def PreviousNthOccurrencesRemovedCS(panList, pItem, pnStartingAt, pCaseSensitive)

		aResult = This.
			  RemovePreviousNthOccurrencesCSQ(panList, pItem, pnStartingAt, pCaseSensitive).
			  Content()

		return aResult

		def NthPreviousOccurrencesRemovedCS(panList, pItem, pnStartingAt, pCaseSensitive)
			return This.PreviousNthOccurrencesRemovedCS(panList, pItem, pnStartingAt, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def RemovePreviousNthOccurrences(panList, pItem, pnStartingAt)
		This.RemovePreviousNthOccurrencesCS(panList, pItem, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionFluentForm

		def RemovePreviousNthOccurrencesQ(panList, pItem, pnStartingAt)
			This.RemovePreviousNthOccurrences(panList, pItem, pnStartingAt)
			return This

		#>

		#< @FunctionAlternativeForm

		def RemovePreviousOccurrences(panList, pItem, pnStartingAt)
			This.RemovePreviousNthOccurrences(panList, pItem, pnStartingAt)

			def RemovePreviousOccurrencesQ(panList, pItem, pnStartingAt)
				This.RemovePreviousOccurrences(panList, pItem, pnStartingAt)
				return This

		#--

		def RemoveNthPreviousOccurrences(panList, pItem, pnStartingAt)
			This.RemovePreviousNthOccurrences(panList, pItem, pnStartingAt)

			def RemoveNthPreviousOccurrencesQ(panList, pItem, pnStartingAt)
				This.RemoveNthPreviousOccurrences(panList, pItem, pnStartingAt)
				return This
		#>

	def PreviousNthOccurrencesRemoved(panList, pItem, pnStartingAt)

		aResult = This.
			  RemovePreviousNthOccurrencesQ(panList, pItem, pnStartingAt).
			  Content()

		return aResult

		def NthPreviousOccurrencesRemoved(panList, pItem, pnStartingAt)
			return This.PreviousNthOccurrencesRemoved(panList, pItem, pnStartingAt)

	  #---------------------------------------------------#
	 #   REMOVING AN ITEM BY SPECIFYING ITS POSITION    #
	#---------------------------------------------------#

	def RemoveItemAtPosition(n)

		# Checking param correctness

		if isString(n)
			if Q(n).IsOneOfThese([
				:First, :FirstPosition,
			      	:FirstItem, :FirstItem ])
				  
				n = 1

			but Q(n).IsOneOfThese([
				:Last, :LastPosition,
			     	:LastItem, :LastItem ])

				n = This.NumberOfItems()
			ok
		ok

		if NOT isNumber(n)
			StzRaise("Incorrect param! n must be a number.")
		ok

		# Doing the job

		if n <= This.NumberOfItems()
			aTempList = This.Content()
			ring_del( aTempList, n )
			This.Update(aTempList)

		ok

		#< @FunctionFluentForm

		def RemoveItemAtPositionQ(n)
			This.RemoveItemAtPosition(n)
			return This

		#>

		#< @FunctionAlternativeForms

		def RemoveAt(n)
			This.RemoveItemAtPosition(n)

			def RemoveAtQ(n)
				This.RemoveAt(n)
				return This

		def RemoveAtPosition(n)
			This.RemoveItemAtPosition(n)

			def RemoveAtPositionQ(n)
				This.RemoveAtPosition(n)
				return This

		def RemoveItemAt(n)
			This.RemoveItemAtPosition(n)

			def RemoveItemAtQ(n)
				This.RemoveItemAt(n)
				return This

		#--

		def RemoveNthItem(n)
			This.RemoveItemAtPosition(n)

			def RemoveNthItemQ(n)
				This.RemoveNthItem(n)
				return This

		#>

	def ItemAtPositionNRemoved(n)
		aResult = This.Copy().RemoveItemAtPositionQ(n).Content()
		return This

		def NthItemRemoved(n)
			return This.ItemAtPositionNRemoved(n)

	  #--------------------------------------#
	 #    REMOVING FIRST ITEM IN THE LIST   #
	#--------------------------------------#

	def RemoveFirstItem()
		This.RemoveItemAtPosition(1)

		#< @FunctionFluentForm

		def RemoveFirstItemQ()
			This.RemoveFirstItem()
			return This

		#>

	def FirstItemRemoved()
		aResult = This.Copy().RemoveFirstItemQ().Content()
		return aResult

	  #-------------------------------------#
	 #    REMOVING LAST ITEM IN THE LIST   #
	#-------------------------------------#

	def RemoveLastItem()
		This.RemoveItemAtPosition( This.NumberOfItems() )

		#< @FunctionFluentForm

		def RemoveLastItemQ()
			This.RemoveLastItem()
			return This

		#>

	def LastItemRemoved()
		aResult = This.Copy().RemoveLastItemQ().Content()
		return aResult

	  #----------------------------------#
	 #   REMOVING FIRST AND LAST ITEMS  #
	#----------------------------------#

	def RemoveFirstAndLastItems()
		This.RemoveFirstItem()
		This.RemoveLastItem()

		#< @FunctionFluentForm

		def RemoveFirstAndLastItemsQ()
			This.RemoveFirstAndLastItems()
			return This

		#>

		#< @FunctionAlternativeForms

		def RemoveLastAndFirstItems()
			This.RemoveFirstAndLastItems()

			def RemoveLastAndFirstItemsQ()
				This.RemoveLastAndFirstItems()
				return This

		def RemoveFirstAndLast()
			This.RemoveFirstAndLastItems()

			def RemoveFirstAndLastQ()
				This.RemoveFirstAndLast()

		def RemoveLastAndFirst()
			This.RemoveFirstAndLastItems()

			def RemoveLastAndFirstQ()
				This.RemoveFirstAndLast()

		#--

		def RemoveFirstItemAndLastItem()
			This.RemoveFirstAndLastItems()

			def RemoveFirstItemAndLastItemQ()
				This.RemoveFirstItemAndLastItem()
				return This

		def RemoveLastItemAndFirstItem()
			This.RemoveFirstAndLastItems()

			def RemoveLastItemAndFirstItemQ()
				This.RemoveLastItemAndFirstItem()
				return This

		#>

	def FirstAndLastItemsRemoved()
		return This.Copy().RemoveFirstAndLastItemsQ().Content()

		def LastAndFirstItemsRemoved()
			return This.FirstAndLastItemsRemoved()

		def FirstAndLastRemoved()
			return This.FirstAndLastItemsRemoved()

		def LastAndFirstRemoved()
			return This.FirstAndLastItemsRemoved()

		#--

		def FirstItemAndLastItemRemoved()
			return This.FirstAndLastItemsRemoved()

		def LastItemAndFirstItemRemoved()
			return This.FirstAndLastItemsRemoved()

	  #--------------------------------------#
	 #  REMOVING A GIVEN NTH ITEM (IF ANY)  #
	#--------------------------------------#

	def RemoveThisNthItemCS(n, pItem, pCaseSensitive)
		NthItem = This.NthItem(n)
		bItemExists = FALSE

		if isString( pItem )
			if Q(NthItem).IsEqualToCS(pItem, pCaseSensitive)
				bItemExists = TRUE
			ok

		else
			if Q(NthItem).IsEqualTo(pItem)
				bItemExists = TRUE
			ok
		ok

		if bItemExists
			This.RemoveNthItem(n)
		ok

		def RemoveThisNthItemCSQ(n, pItem, pCaseSensitive)
			This.RemoveThisNthItemCS(n, pItem, pCaseSensitive)
			return This

	def ThisNthItemRemovedCS(n, pItem, pCaseSensitive)
		return This.RemoveThisNthItemCSQ(n, pItem, pCaseSensitive).Content()

	#-- WITHOUT CASESENSITIVITY

	def RemoveThisNthItem(n, pItem)
		This.RemoveThisNthItemCS(n, pItem, :CaseSensitive = TRUE)
			
		def RemoveThisNthItemQ(n, pItem)
			This.RemoveThisNthItemCS(n, pItem)
			return This

	def ThisNthItemRemoved(n, pItem)
		return This.RemoveThisNthItemQ(n, pItem).Content()

	  #------------------------------------------------------#
	 #  REMOVING THE GIVEN FIRST ITEM (IA ANY) IN THE LIST  #
	#------------------------------------------------------#

	def RemoveThisFirstItemCS(pItem, pCaseSensitive)
		This.RemoveThisNthItemCS(1, pItem, pCaseSensitive)

		def RemoveThisFirstItemCSQ(pItem, pCaseSensitive)
			This.RemoveThisFirstItemCS(pItem, pCaseSensitive)
			return This

	def ThisFirstItemRemovedCS(pItem, pCaseSensitive)
		return This.Copy().RemoveThisFirstItemCSQ(pItem, pCaseSensitive).Content()

	#-- WITHOUT CASESENSITIVITY

	def RemoveThisFirstItem(pItem)
		This.RemoveThisNthItemCS(1, pItem, :CaseSensitive = TRUE)

		def RemoveThisFirstItemQ(pItem)
			This.RemoveThisFirstItem(pItem)
			return This

	def ThisFirstItemRemoved(pItem)
		return This.Copy().RemoveThisFirstItemQ(pItem, pCaseSensitive).Content()

	  #-----------------------------------------------------#
	 #  REMOVING THE GIVEN LAST ITEM (IA ANY) IN THE LIST  #
	#-----------------------------------------------------#

	def RemoveThisLastItemCS(pItem, pCaseSensitive)
		This.RemoveThisNthItemCS(This.NumberOfItems(), pItem, pCaseSensitive)

		def RemoveThisLastItemCSQ(pItem, pCaseSensitive)
			This.RemoveThisLastItemCS(pItem, pCaseSensitive)
			return This

	def ThisLastItemRemovedCS(pItem, pCaseSensitive)
		return This.Copy().RemoveThisLastItemCSQ(pItem, pCaseSensitive).Content()

	#-- WITHOUT CASESENSITIVITY

	def RemoveThisLastItem(pItem)
		This.RemoveThisNthItemCS(1, pItem, :CaseSensitive = TRUE)

		def RemoveThisLastItemQ(pItem)
			This.RemoveThisLastItem(pItem)
			return This

	def ThisLastItemRemoved(pItem)
		return This.Copy().RemoveThisLastItemQ(pItem, pCaseSensitive).Content()

	  #=====================================================#
	 #  REMOVING MANY ITEMS BY SPECIFYING THEIR POSITIONS  #
	#=====================================================#

	def RemoveItemsAtPositions(panPositions)

		anPositions = StzListQ(panPositions).SortedInDescending()

		for i = 1 to len( anPositions )
			n = anPositions[i]
			This.RemoveItemAtPosition(n)

		next

		#< @FunctionFluentForm

		def RemoveItemsAtPositionsQ(panPositions)
			This.RemoveItemsAtPositions(panPositions)
			return This

		#>

		#< @FunctionAlternativeForms

		def RemoveManyAt(panPositions)
			This.RemoveItemsAtPositions(panPositions)

			def RemoveManyAtQ(panPositions)
				This.RemoveManyAt(panPositions)
				return This

		def RemoveManyAtPositions(panPositions)
			This.RemoveItemsAtPositions(panPositions)

			def RemoveManyAtPositionsQ(panPositions)
				This.RemoveManyAtPositions(panPositions)
				return This

		def RemoveManyItemsAt(panPositions)
			This.RemoveItemsAtPositions(panPositions)

			def RemoveManyItemsAtQ(panPositions)
				This.RemoveManyItemsAt(panPositions)
				return This

		def RemoveManyItemsAtPositions(panPositions)
			This.RemoveItemsAtPositions(panPositions)

			def RemoveManyItemsAtPositionsQ(panPositions)
				This.RemoveManyItemsAtPositions(panPositions)
				return This

		def RemoveManyAtThesePositions(panPositions)
			This.RemoveItemsAtPositions(panPositions)

			def RemoveManyAtThesePositionsQ(panPositions)
				This.RemoveManyAtThesePositions(panPositions)
				return This

		def RemoveManyItemsAtThesePositions(panPositions)
			This.RemoveItemsAtPositions(panPositions)

			def RemoveManyItemsAtThesePositionsQ(panPositions)
				This.RemoveManyItemsAtThesePositions(panPositions)
				return This

		#--

		def RemoveItemsAtThesePositions(panPositions)
			This.RemoveItemsAtPositions(panPositions)

			def RemoveItemsAtThesePositionsQ(panPositions)
				This.RemoveItemsAtThesePositions(panPositions)
				return This

		def RemoveAtPositions(panPositions)
			This.RemoveItemsAtPositions(panPositions)

			def RemoveAtPositionsQ(panPositions)
				This.RemoveAtPositions(panPositions)
				return This

		#>
		
	def ItemsAtThesePositionsRemoved(panPositions)
		aResult = This.Copy().RemoveItemsAtThesePositionsQ(panPositions).Content()
		return aResult

	  #-------------------------------#
	 #   REMOVING A RANGE OF ITEMS   #
	#-------------------------------#

	def RemoveRange(pnStart, pnRange)
	
		# Checking the correctness of the pnStart param

		if isList(pnStart) and Q(pnStart).IsFromNamedParam()
			pnStart = pnStart[2]
		ok

		if isString(pnStart)
			if Q(pnStart).IsOneOfThese([
					:First, :FirstPosition,
				      	:FirstItem, :FirstItem ])
				  
				pnStart = 1

			but Q(pnStart).IsOneOfThese([
					:Last, :LastPosition,
				      	:LastItem, :LastItem ])

				n = This.NumberOfItems()
			ok
		ok

		if NOT isNumber(pnStart)
			StzRaise("Incorrect param! n must be a number.")
		ok

		# Checking the correctness of the pnRange param

		if isList(pnRange) and
		   isItem(pnRange[1]) and

		   ( Q(pnRange[1]).IsOneOfTheseCS([ :UpToN, :UpToNItems, :UpToNItems ]) )

		   	pnRange = pnRange[2]
		ok
	
		if NOT isNumber(pnRange)
			StzRaise("Incorrect param type! pnRange must be a number.")
		ok

		# Checking the correctness of the range of the two params

		nLen = This.NumberOfItems()

		if (pnStart < 1) or (pnStart + pnRange -1 > nLen) or
		   ( pnStart = nLen and pnRange != 1 )
			StzRaise("Out of range!")
		ok

		# Doing the job

		if pnStart = 1
			aResult = This[1]
		else
			aResult = This.Section(1, pnstart-1)
		ok

		for item in This.Section(pnStart + pnRange, nLen)
			aResult + item
		next		
		  
		This.Update( aResult )

		#< @FunctionFluentForm

		def RemoveRangeQ(pnStart, pnRange)
			This.RemoveRange(pnStart, pnRange)
			return This
		#>

	def RangeRemoved(pnStart, pnRange)
		aResult = This.Copy().RemoveRangeQ(pnStart, pnRange)
		return aResult

	  #-----------------------------------#
	 #   REMOVING MANY RANGES OF ITEMS   #
	#-----------------------------------#

	def RemoveManyRanges(panRanges)

		anSections = []
		for anRange in panRanges
			anSections + RangeToSection(anRange)
		next

		This.RemoveManySections(anSections)

		def RemoveManyRangesQ(paRanges)
			This.RemoveManyRanges(paRanges)
			return This

	def ManyRangesRemoved(paRanges)
		aResult = This.Copy().RemoveManyRangesQ(paRanges).Content()
		return aResult

	  #---------------------------------#
	 #   REMOVING A SECTION OF ITEMS   #
	#---------------------------------#

	def RemoveSection(n1, n2)

		# Checking params correctness

		if isList(n1) and
			( Q(n1).IsFromNamedParam() or Q(n1).IsFromNamedParam()  or
			  Q(n1).IsFromPositionNamedParam() )

			n1 = n1[2]
		ok

		if isList(n2) and ( Q(n2).IsToNamedParam() or Q(n2).IsToPositionNamedParam() )
			n2 = n2[2]
		ok

		if isString(n1) and
			( Q(n1).IsOneOfThese([
				:First, :FirstPosition,
				:FirstItem, :FirstItem ]) )

			n1 = 1
		ok

		if isString(n2) and
			( Q(n2).IsOneOfThese([
				:Last, :LastPosition,
				:LastItem, :LastItem ]) )
 
			n2 = This.NumberOfItems()
		ok

		if NOT ( isNumber(n1) and isNumber(n2) )
			StzRaise("Incorrect param type! n1 and n2 must be numbers.")
		ok

		if NOT  ( StzNumberQ(n1).IsBetween(1, This.NumberOfItems() ) and
			  StzNumberQ(n2).IsBetween(1, This.NumberOfItems() ) )

			StzRaise("Out of range!")
		ok

		# Doing the job (Qt-side)

		This.RemoveRange( n1, n2 - n1 + 1 )

		#< @FunctionFluentForm

		def RemoveSectionQ(n1, n2)
			This.RemoveSection(n1, n2)
			return This

		#>

	def SectionRemoved(n1, n2)
		aResult = This.Copy().RemoveSectionQ(n1, n2)
		return aResult

	  #-------------------------------------#
	 #   REMOVING MANY SECTIONS OF ITEMS   #
	#-------------------------------------#

	def RemoveManySections(paSections)

		if NOT ( isList(paSections) and
			 Q(paSections).IsListOfPairs() and
			 Q(paSections).MergeQ().AllItemsAreNumbers() )

			StzRaise("Incorrect param! paSections must be a list of pairs of numbers.")
		ok

		anPositions = StzListOfPairsQ(paSections).
				ExpandedIfPairsOfNumbersQ().
				MergeQ().RemoveDuplicatesQ().Content()


		This.RemoveItemsAtPositions(anPositions)

		def RemoveManySectionsQ(paSections)
			This.RemoveManySections(paSections)
			return This

		def RemoveSections(paSections)
			This.RemoveManySections(paSections)

	def ManySectionsRemoved(paSections)
		aResult = This.Copy().RemoveManySectionsQ(paSections).Content()
		return aResult

		def SectionsRemoved(paSections)

	  #------------------------------------#
	 #   REMOVING ALL ITEMS IN THE LIST   #
	#------------------------------------#
	
	def RemoveAllItems()
		@aContent = []

		#< @FunctionFluentForm

		def RemoveAllItemsQ()
			This.RemoveAllItems()
			return This

		#>

		#< @FunctionAlternativeForm

		def Clear()
			This.RemoveAllItems()

			def ClearQ()
				This.Clear()
				return This

		#>

	def AllItemsRemoved()
		return []

	  #--------------------------------------------#
	 #   REMOVING ITEMS UNDER A GIVEN CONDITION   #
	#--------------------------------------------#

	def RemoveW(pCondition)
		/*
		Example:

		o1 = new stzList([ "1", "a", "2", "b", "3", "c" ])
		o1.RemoveAllItemsW(:Where = '{ StzCharQ(@item).IsANumber() }')
		? o1.Content()

		# --> Gives: [ "a", "b", "c" ]
		*/

		# Checking the provided param for the pCondition

		anPos = This.FindW(pCondition)

		This.RemoveItemsAtThesePositions(anPos)

		#< @FunctionFluentForm

		def RemoveWQ(pCondition)
			This.RemoveW(pCondition)
			return This

		#>

		#< @FunctionAlternativeForm

		def RemoveItemsW(pCondition)
			This.RemoveW(pCondition)

			def RemoveItemsWQ(pCondition)
				This.RemoveItemsW(pCondition)
				return This

		#>

	def ItemsRemovedW(pCondition)
		aResult = This.Copy().RemoveItemsWQ(pCondition).Content()
		return aResult

	  #====================================#
	 #  EXTRACTING AN ITEM FROM THE LIST  #
	#====================================#

	def ExtractCS(pItem, pCaseSensitive)
		if NOT This.ContainsCS(pItem, pCaseSensitive)
			StzRaise("Can't extract the item! It does not exist in the list.")
		ok

		This.RemoveCS(pItem, pCaseSensitive)
		return pItem

	#-- WITHOUT CASESENSITIVITY

	def Extract(pItem)
		return This.ExtractCS(pItem, :CaseSensitive = TRUE)

	  #---------------------------------------#
	 #  EXTRACTING MANY ITEMS FROM THE LIST  #
	#---------------------------------------#

	def ExtractManyCS(paItems, pCaseSensitive)
		if NOT This.ContainsManyCS(paItems, pCaseSensitive)
			StzRaise("Can't extract the items! Items in paItems do not exist in the list.")
		ok

		This.RemoveManyCS(paItems, pCaseSensitive)
		return paItems

	#-- WITHOUT CASESENSITIVITY

	def ExtractMany(paItems)
		return This.ExtractManyCS(paItems, :pCaseSensitive = TRUE)

	  #------------------------------------------#
	 #  EXTRACTING ALL THE ITEMS FROM THE LIST  #
	#------------------------------------------#

	def ExtractAll()
		aResult = This.Content()
		This.Clear()
		return aResult

	  #---------------------------#
	 #  EXTRACTING THE NTH ITEM  #
	#---------------------------#

	def ExtractAt(n)
		if isString(n) and ( n = :Last or n = :LastItem )
			n = This.NumberOfItems()
		ok

		if NOT isNumber(n) and Q(n).IsBetween(1, This.NumberOfItems())
			StzRaise("Can't extract! n outside of range.")
		ok

		TempItem = This.ItemAt(n)

		This.RemoveAt(n)

		return TempItem

		def ExtractNthItem(n)
			return This.ExtractAt(n)

	  #-----------------------------#
	 #  EXTRACTING THE FIRST ITEM  #
	#-----------------------------#

	def ExtractFirstItem()
		return This.ExtractAt(1)
 
	  #----------------------------#
	 #  EXTRACTING THE LAST ITEM  #
	#----------------------------#

	def ExtractLastItem()
		return This.ExtractAt(:Last)

	  #--------------------------------------------#
	 #  EXTRACTING THE NTH OCCURRENCE OF AN ITEM  #
	#--------------------------------------------#

	def ExtractNthOccurrenceCS(n, pItem, pCaseSensitive)
		if This.FindNthOccurrenceCS(n, pItem, pCaseSensitive) > 0
			This.RemoveNthOccurrenceCS(n, pItem, pCaseSensitive)
			return pItem
		else
			StzRaise("Can't extract! The list does not contain n occurrences of pItem.")
		ok

		def ExtractNthCS(n, pItem, pCaseSensitive)
			return This.ExtractNthOccurrenceCS(n, pItem, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def ExtractNthOccurrence(n, pItem)
		return This.ExtractNthOccurrenceCS(n, pItem, :CaseSensitive = TRUE)

		def ExtractNth(n, pItem)
			return This.ExtractNthOccurrence(n, pItem)

	  #----------------------------------------------#
	 #  EXTRACTING THE FIRST OCCURRENCE OF AN ITEM  #
	#----------------------------------------------#

	def ExtractFirstCS(pItem, pCaseSensitive)
		return This.ExtractNthOccurrenceCS(1, pItem, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def ExtractFirst(pItem)
		return This.ExtractFirstCS(pItem, :CaseSensitive = TRUE)

	  #----------------------------------------------#
	 #  EXTRACTING THE LAST OCCURRENCE OF AN ITEM  #
	#----------------------------------------------#

	def ExtractLastCS(pItem, pCaseSensitive)
		return This.ExtractNthOccurrenceCS(:Last, pItem, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def ExtractLast(pItem)
		return This.ExtractLastCS(pItem, :CaseSensitive = TRUE)

	  #------------------------------------------------#
	 #  EXTRACTING ITEMS VERIFYING A GIVEN CONDITION  #
	#------------------------------------------------#

	def ExtractW(pcCondition)
		aResult = This.ItemsW(pcCondition)
		if len(aResult) = 0
			StzRaise("Can't extract! The condition returns no values at all.")
		ok

		This.RemoveW(pcCondition)
		return aResult

	  #--------------------------------------#
	 #  EXTRACTING A SECTION FROM THE LIST  #
	#--------------------------------------#

	def ExtractSection(n1, n2)
		if NOT BothAreNumbers(n1, n2) and
		   Q(n1).IsBetween(1, This.NumberOfItems()) and
		   Q(n2).IsBetween(1, This.NumberOfItems())

			StzRaise("Can't extract! The section is outside the list.")
		ok

		aResult = This.Section(n1, n2)
		This.RemoveSection(n1, n2)
		return aResult

	  #------------------------------------#
	 #  EXTRACTING A RANGE FROM THE LIST  #
	#------------------------------------#

	def ExtractRange(nStart, nRange)
		return This.ExtractSection(nStart, nStart + nRange - 1)

	  #-----------------------------------------------------#
	 #  EXTRACTING NEXT ITEM STARTING AT A GIVEN POSITION  #
	#-----------------------------------------------------#

	def ExtractNextCS(pItem, pnStartingAt, pCaseSensitive)
		if This.FindNextCS(pItem, pnStartingAt, pCaseSensitive) = 0
			StzRaise("Can't extract! pItem does not exist at the specified position.")
		ok

		This.RemoveNextCS(pItem, pnStartingAt, pCaseSensitive)
		return pItem

	#-- WITHOUT CASESENSITIVITY

	def ExtractNext(item, pnStartingAt)
		return This.ExtractNextCS(item, pnStartingAt, :CaseSensitive = TRUE)

	  #---------------------------------------------------------#
	 #  EXTRACTING PREVIOUS ITEM STARTING AT A GIVEN POSITION  #
	#---------------------------------------------------------#

	def ExtractPreviousCS(item, pnStartingAt, pCaseSensitive)
		if This.FindPreviousCS(item, pnStartingAt, pCaseSensitive) = 0
			StzRaise("Can't extract! pItem does not exist at the specified position.")
		ok

		This.RemovePreviousCS(item, pnStartingAt, pCaseSensitive)
		return item

	#-- WITHOUT CASESENSITIVITY

	def ExtractPrevious(item, pnStartingAt)
		return This.ExtractPreviousCS(item, pnStartingAt, :CaseSensitive = TRUE)

	  #============================#
	 #     BOUNDS OF THE LIST     #
	#============================#

	  #--------------------------------------------#
	 #  BOUNDS OF AN ITEM UP TO N NEIGHBOR ITEMS  #
	#--------------------------------------------#

	def BoundsOfCS(pItem, pnUpToNItems, pCaseSensitive)
		if isList(pnUpToNItems) and
		   Q(pnUpToNItems).IsOneOfTheseNamedParams([
			:UpTo, :UpToN, :UpToNItems
		   ])
			pnUpToNItems = pnUpToNItems[2]
		ok
		
		# { o1 = new stzList([ 1, 2, "*", 4, 5, 6, "*", 8, 9 ]) }
		# { o1.BoundsOf("*", :UpToNItems = 2) }

		anPos = ListsMerge([ [0], This.FindAllCS(pItem, pCaseSensitive), [This.NumberOfItems()] ])
		#--> [0, 3, 7, 9]
		nLen = len(anPos)
		if NOT nLen > 2
			return [] # No bounds
		ok

		aResult = []

		for i = 2 to nLen - 1

			nCurrentPos  = anPos[i]
			nPreviousPos = anPos[i-1]
			nNextPos     = anPos[i+1]

			bHasLetfBound  = FALSE
			if (nCurrentPos - pnUpToNItems) >= nPreviousPos
				bHasLeftBound = TRUE
			ok

			bHasRightBound = FALSE
			if (nCurrentPos + pnUpToNItems) <= nNextPos
				bHasRightBound = TRUE
			ok


			if bHasLeftBound and bHasRightBound
				aLeftSection  = This.Section( (nCurrentPos - pnUpToNItems), (nCurrentPos - 1) )
				aRightSection = This.Section( (nCurrentPos + 1), (nCurrentPos + pnUpToNItems) )

				if len(aLeftSection) > 0 and len(aRightSection) > 0
					aResult + [ aLeftSection, aRightSection ]
				ok
			ok
		next

		return aResult

	#-- WITHOUT CASESENSITIVITY

	def BoundsOf(pItem, pnUpToNItems)
		return This.BoundsOfCS(pItem, pnUpToNItems, :CaseSensitive = TRUE)

	  #-----------------------------------------------------------------------------------#
	 #  CHECKING IF THE 2 ITEMS OF THE LIST ARE BOUNDS OF A SUBSTRING IN A GIVEN STRING  #
	#-----------------------------------------------------------------------------------#

	def AreBoundsOfCS(pItem, pIn, pCaseSensitive)

		/* EXAMPLE 1

		o1 = new stzList([ "<<", ">>" ])
		? o1.AreBoundsOf("word", :In = "<<word>> and __word__")
		#--> TRUE

		EXAMPLE 2

		o1 = new stzList([ [ "<<", ">>" ], [ "__", "__" ] ])
		? o1.AreBoundsOf("word", :In = "<<word>> and __word__")
		#--> TRUE

		*/

		if NOT ( This.IsPair() or This.IsListOfPairs() )
			StzRaise("Can't check bounds! List must be a pair or a list of pairs.")
		ok

		if isList(pIn) and Q(pIn).IsInNamedParam()
			pIn = pIn[2]
		ok

		anUpToNChars = []
		if This.IsPair() and NOT This.IsListOfPairs()
			anUpToNChars = [ len(This[1]), len(This[2]) ]
			aThis = [ This.Content() ]

		else
			for aPair in This.Content()
				anUpToNChars + [ len(aPair[1]), len(aPair[2]) ]
			next
			aThis = This.Content()
		ok

		aBounds = Q(pIn).BoundsOfCS(pItem, anUpToNChars, pCaseSensitive)
	
		bResult = Q(aThis).AllItemsExistInCS(aBounds, pCaseSensitive)
		return bResult

	#-- WITHOUT CASESENSITIVITY

	def AreBoundsOf(pItem, pIn)
		return This.AreBoundsOfCS(pItem, pIn, :CaseSensitive = TRUE)

	  #----------------------------------------------------------#
	 #  CHECKING IF THE LIST IS BOUNDED BY THE GIVEN TWO ITEMS  #
	#----------------------------------------------------------#

	def IsBoundedBy(paBounds)
		if isList(paBounds) and Q(paBounds).IsPair()
			pItem1 = paBounds[1]
			pItem2 = paBounds[2]

		else
			pItem1 = paBounds
			pItem2 = paBounds
		ok
	
		if This.FirstItem() = pItem1 and This.LastItem() = pItem2
			return TRUE
		else
			return FALSE
		ok

	  #--------------------------------------------#
	 #  GETTING BOUNDS OF THE LIST UP TO N ITEMS  #
	#--------------------------------------------#

	def BoundsUpToNItems(n)
		return [ This.NFirstItems(n), This.NLastItems(n) ] # TODO add them

		#< @FunctionFluentForm
	
		def BoundsUpToNItemsQ(n)
			return new stzList( This.BoundsUpToNItems(n) )

		#>

	  #-------------------------#
	 #     REMOVING BOUNDS     #
	#-------------------------#

	def RemoveBoundsCS(paBounds, pCaseSensitive)
		if This.IsBoundedByCS(paBounds, pCaseSensitive)
			This.RemoveFirstItem()
			This.RemoveLastItem()
		ok

		def RemoveBoundsCSQ(paBounds, pCaseSensitive)
			This.RemoveBoundsCS(paBounds, pCaseSensitive)
			return This

	def BoundsRemovedCS(paBounds, pCaseSensitive)

		aResult = This.Copy().RemoveBoundsCSQ(paBounds, pCaseSensitive).Content()
		return aResult

		/* WARNING: Subtle bug in Ring (Show to Mahmoud)

		In the function above, if we write the expression that returns
		the result directly after the keyword 'return', like this:

		return This.Copy().RemoveBoundsQ([pItem1, pItem2]).Content()

		Then nothing is returned, altough the result should be a list!

		I don't know why this happens. But I found that the solution is
		to avoid writing any expression after return. Instead, let's always
		compute the result in a variable, and then return it (see code above).

		--> TODO: Check the occurrence this pattern all over the library!
		*/
		
	#-- WIHTOUT CASESENSITIVITY

	def RemoveBounds(paBounds)
		This.RemoveBoundsCS(paBounds, :CaseSensitive = TRUE)

		def RemoveBoundsQ(paBounds)
			This.RemoveBounds(paBounds)
			return This

	def BoundsRemoved(paBounds)

		aResult = This.Copy().RemoveBoundsQ(paBounds).Content()
		return aResult

	  #------------------------------#
	 #     REMOVING MANY BOUNDS     #
	#------------------------------#

	def RemoveManyBoundsCS(paPairsOfBounds, pCaseSensitive)
		nLen = len(paPairsOfBounds)
		for i = 1 to nLen
			This.RemoveBoundsCS(paPairsOfBounds[i], pCaseSensitive)
		next

		def RemoveManyBoundsCSQ(paPairsOfBounds, pCaseSensitive)
			This.RemoveManyBoundsCS(paPairsOfBounds, pCaseSensitive)
			return This

	def ManyBoundsRemovedCS(paPairsOfBounds, pCaseSensitive)
		aResult = This.Copy().RemoveManyBoundsCSQ(paPairsOfBounds, pCaseSensitive).Content()
		return aResult

	#-- WITHOUT CASESENSITIVITY

	def RemoveManyBounds(paPairsOfBounds)
		This.RemoveManyBoundsCS(paPairsOfBounds, :CaseSensitive = TRUE)

		def RemoveManyBoundsQ(paPairsOfBounds)
			This.RemoveManyBounds(paPairsOfBounds)
			return This

	def ManyBoundsRemoved(paPairsOfBounds)
		aResult = This.Copy().RemoveManyBoundsQ(paPairsOfBounds).Content()
		return aResult

	  #----------------------------------#
	 #   REMOVING ZEROS FROM THE LIST   #
	#----------------------------------#

	def RemoveZeros()
		This.RemoveItem(0)

		def RemoveZerosQ()
			This.RemoveZeros()
			return This

	def ZerosRemoved()
		aResult = This.Copy().RemoveZerosQ().Content()
		return aResult

	  #-------------------------------------#
	 #    CHECKINK LIST CHARACTERISTICS    #
	#-------------------------------------#

	def IsUnaryList()
		if This.NumberOfItems() = 1
			return TRUE
		else
			return FALSE
		ok

	def IsEmpty()
		if len(This.List()) = 0
			return TRUE
		else
			return FALSE
		ok

	def IsDeepList()	// Contains at least an inner list
		If This.Depth() > 1
			return TRUE
		else
			return FALSE
		ok

		def IsADeepList()
			return This.ISDeepList()

		def IsDeep()
			return This.ISDeepList()

	def IsHybridList()	// Contains items of different types
		if NOT This.ContainsOnlyNumbers() or
		   NOT This.ContainsOnlyStrings() or
		   NOT This.ContainsOnlyLists() or
		   NOT This.ContainsOnlyObjects()
			return TRUE
		else
			return FALSE
		ok

		def IsAHybridList()
			return This.IsHybridList()

	def IsPureList()	// Contains items of the same type
		if This.ContainsOnlyNumbers() or
		   This.ContainsOnlyStrings() or
		   This.ContainsOnlyLists() or
		   This.ContainsOnlyObjects()
			return TRUE
		else
			return FALSE
		ok

		def IsAPureList()
			return This.IsPureList()

	def IsOddList()
		oTempNumber = new stzNumber( This.NumberOfItems() )
		if oTempNumber.IsOdd()
			return TRUE
		else
			return FALSE
		ok

		def IsAnOddList()
			return This.IsOddList()

	def IsEvenList()
		if NOT This.IsOddList()
			return TRUE
		else
			return FALSE
		ok

		def IsAnEvenList()
			return This.IsEvenList()

	// TODO: Maybe we should design a stzListOfBits class...
	def IsListOfBits()
		if This.NumberOfItems() = 0
			return FALSE
		ok

		if This.IsListOfNumbers()
			for n in This.List()
				if NOT IsBit(n)
					return FALSE
				ok
			end
		ok

		return TRUE

		def IsAListOfBits()
			return This.IsListOfBits()

	def IsListOfZerosAndOnes()
		if This.NumberOfItems() = 0
			return FALSE
		ok

		return This.IsListOfBits()

		def IsAListOfZerosAndOnes()
			return This.IsListOfZerosAndOnes()

	def IsGrid()
		return This.AllItemsAre('{ isList(@item) and len(@item) = len(This[1]) }')

		def IsAGrid()
			return This

	def IsHashList()
		/*
		A hash list is a grid of 2 vlines.

		The items of the 1st vline are all strings.
		And they are all unique (form a Set).

		When stzGrid class is fully tested we can use this code:	
		
		oTempGrid = new stzGrid( This.List() )
		bResult = FALSE

		if oTempGrid.NumberOfVLines() = 2

			aFirstVLine = oTempGrid.VLine(1)

			if ListIsSet(aFirstVLine) and ListItemsAreAllStrings(aFirstVLine)
				bResult = TRUE
			ok
		ok
		return bResult
		*/

		# All items are list of 2 items, where the 1st beeing string
		# TODO: The strings in the 1st column (keys of the hashlist) must be unique

		bResult = TRUE
		aTempKeys = []

		for i = 1 to len(This.List())

			if NOT ( isList(This[i]) and len(This[i]) = 2 and
				 isString(This[i][1]) )

				bResult = FALSE
				exit
			else
				if ring_find(aTempKeys, This[i][1]) > 0
					bResult = FALSE
					exit
				ok

				aTempKeys + This[i][1]
			ok
		next

		return bResult

		def IsAHashList()
			return This.IsHashList()

		def IsNotHashList()
			return NOT This.IsHashList()

		def IsNotAHashList()
			return This.IsHashList()
	
	def AllItemsAreHashLists()
		if This.NumberOfItems() = 0
			return FALSE
		ok

		bResult = TRUE
		for item in This.List()
			if NOT isList(item)
				bResult = FALSE
				exit
			ok

			if NOT StzListQ(item).IsHashList()
				bResult = FALSE
				exit
			ok
		next
		return bResult

		#< @FunctionAlternativeForms

		def ContainsOnlyHashLists()
			return This.AllItemsAreHashLists()
	
		def IsListOfHashLists()
			return This.AllItemsAreHashLists()

		#>

	def ItemsAreListsOfSameSize()
		if This.NumberOfItems() = 0
			return FALSE
		ok

		bResult = FALSE

		if This.AllItemsAreLists()
			bSame = TRUE
			for i = 2 to This.NumberOfItems()
				if len(Item(i)) != len(Item(i-1))
					bSame = FALSE
				ok
			next
			if bSame
				bResult = TRUE
			ok
		ok

		return bResult

		def AllItemsAreListsOfSameSize()
			return This.ItemsAreListsOfSameSize()

	def ItemsAreSets()
		if This.NumberOfItems() = 0
			return FALSE
		ok

		bResult = TRUE

		for item in This.List()
			if NOT ListIsSet(item)
				bResult = FALSE
				exit
			ok
		end

		return bResult

		def AllItemsAreSets()
			return This.ItemsAreSets()

	def IsListOfStrings()
		if This.NumberOfItems() = 0
			return FALSE
		ok

		bResult = TRUE
		aTempList = This.List()
		nLen = len(aTempList)

		for i = 1 to nLen
			if NOT isString(aTempList[i])
				bResult = FALSE
				exit
			ok
		next

		return bResult

		def IsAListOfStrings()
			return This.IsListOfStrings()

	def IsListOfChars()
		if This.NumberOfItems() = 0
			return FALSE
		ok

		bResult = TRUE

		for item in This.List()
			if NOT ( isString(item) and
			   	 StzStringQ(item).NumberOfChars() = 1 )

				bResult = FALSE
				exit
			ok
		next

		return bResult

		def IsAListOfChars()
			return This.IsListOfChars()

	def IsListOfLetters()
		if This.NumberOfItems() = 0
			return FALSE
		ok

		bResult = TRUE

		for item in This.List()
			if NOT ( isString(item) and
				 StzStringQ(item).IsLetter() )

				bResult = FALSE
				exit
			ok
		next

		return bResult

		def IsAListOfLetters()
			return This.IsListOfLetters()

	def IsListOfNumbers()
		if This.NumberOfItems() = 0
			return FALSE
		ok

		return This.AllItemsAreNumbers()

		def IsAListOfNumbers()
			return This.IsListOfNumbers()

	def IsListOfNumbersInStrings()
		bResult = TRUE

		for item in This.List()
			if NOT ( isString(item) and Q(item).IsNumberInString() )
				bResult = FALSE
				exit
			ok
		next

		return bResult

	def IsListOfLists()
		if This.NumberOfItems() = 0
			return FALSE
		ok

		return This.AllItemsAreLists()

		def IsAListOfLists()
			return This.IsListOfLists()

	def IsListOfSets()
		if This.NumberOfItems() = 0
			return FALSE
		ok

		return This.AllItemsAreSets()

		def IsAListOfSets()
			return This.IsAListOfSets()

	def IsListOfNumbersOrStrings()
		if This.IsListOfNumbers() or
		   This.IsListOfStrings() or
		   This.ISListOfNumbersAndStrings()

			return TRUE
		else
			return FALSE
		ok

		def IsListOfStringsOrNumbers()
			return This.IsListOfNumbersOrStrings()

		def IsAListOfNumbersOrStrings()
			return This.IsListOfNumbersOrStrings()

		def IsAListOfStringsOrNumbers()
			return This.IsListOfNumbersOrStrings()

	def IsListOfNumbersAndStrings()
		bResult = TRUE
		for item in This.List()
			if NOT (isString(item) or isNumber(item))
				bResult = FALSE
				exit
			ok
		next

		return bResult

		def IsListOfStringsAndNumbers()
			return This.IsListOfNumbersAndStrings()

		def IsAListOfNumbersAndStrings()
			return This.IsListOfNumbersAndStrings()

		def IsAListOfStringsAndNumbers()
			return This.IsListOfNumbersAndStrings()

	def IsListOfEitherNumbersOrStrings()
		if This.IsListOfNumbers() or This.IsListOfStrings()
			return TRUE
		else
			return FALSE
		ok

		def IsListOfEitherStringsOrNumbers()
			return This.IsListOfEitherNumbersOrStrings()

		def IsAListOfEitherNumbersOrStrings()
			return This.IsListOfEitherNumbersOrStrings()

		def IsAListOfEitherStringsOrNumbers()
			return This.IsListOfEitherNumbersOrStrings()

	def IsListOfNumbersAndPairsOfNumbers()
		bResult = TRUE

		for item in This.List()
			if NOT 	( isNumber(item) or
					( isList(item) and Q(item).IsPairOfNumbers() )
				)
				bResult = FALSE
				exit
			ok
		next

		return bResult

		def IsAListOfNumbersAndPairsOfNumbers()
			return This.IsListOfNumbersAndPairsOfNumbers()

	def IsPair()
		return This.NumberOfItems() = 2

		def IsPairQ()
			if This.IsPair()
				return This
			else
				return StzFalseObjectQ()
			ok

		def IsAPair()
			return This.IsPair()

			def IsAPairQ()
				return This.IsPairQ()

	def IsPairOfStrings()
		return This.IsPair() and This.IsListOfStrings()

		def IsAPairOfStrings()
			return This.IsPairOfStrings()

	def IsListOfPairsOfStrings()
		/*
		Coud be solved nicely like this:

			if This.IsListOfPairs() and
			   Check('Q(@EachItem).IsPairOfStrings()' ) = TRUE
	
				return TRUE
			else
				return FALSE
			ok

		But the following solution is more performant...
		*/

		bResult = TRUE

		for item in This.List()
			if NOT ( isList(item) and Q(item).IsPairOfStrings() )
				bResult = FALSE
				exit
			ok
		next

		return bResult

		def IsAListOfPairsOfStrings()
			return This.IsListOfPairsOfStrings()

	def IsPairOfNumbers()
		return This.IsPair() and This.IsListOfNumbers()

		def IsAPairOfNumbers()
			return This.IsPairOfNumbers()

	def IsListOfPairsOfNumbers()

		bResult = TRUE

		for item in This.List()
			if NOT ( isList(item) and Q(item).IsPairOfNumbers() )
				bResult = FALSE
				exit
			ok
		next

		return bResult

		def IsAListOfPairsOfNumbers()
			return This.IsListOfPairsOfNumbers()

	def IsPairOfLists()
		return This.IsPair() and This.IsListOfLists()

		def IsAPairOfLists()
			return This.IsPairOfLists()

	def IsListOfPairsOfLists()

		bResult = TRUE

		for item in This.List()
			if NOT ( isList(item) and Q(item).IsPairOfLists() )
				bResult = FALSE
				exit
			ok
		next

		return bResult

		def IsAListOfPairsOfLists()
			return This.IsListOfPairsOfLists()

	def IsPairOfObjects()
		return This.IsPair() and This.IsListOfObjects()

		def IsAPairOfObjects()
			return This.IsPairOfObjects()

	def IsListOfPairsOfObjects()

		bResult = TRUE

		for item in This.List()
			if NOT ( isList(item) and Q(item).IsPairOfObjects() )
				bResult = FALSE
				exit
			ok
		next

		return bResult

		def IsAListOfPairsOfObjects()
			return This.IsListOfPairsOfObjects()

	def IsPairAndKeyIsString()
		return This.IsPair() and isString(This[1])

		def IsAPairAndKeyIsString()
			return IsPairAndKeyIsString()

		def IsPairAndKeyIsAString()
			return This.IsPairAndKeyIsString()

		def IsAPairAndKeyIsAString()
			return This.IsPairAndKeyIsString()

	def IsListOfObjects()
		bResult = TRUE
		for item in This.List()
			if NOT isObject(item)
				bREsult = FALSE
				exit
			ok
		next

		return bResult

		def IsAListOfObjects()
			return This.IsListOfObjects()

	def IsPairStzObjects()
		return This.IsPair() and This.IsListOfStzObjects()

		def IsAPairStzObjects()
			return This.IsPairStzObjects()

	def IsListOfStzObjects()
		bResult = TRUE
		for item in This.List()
			if NOT IsStzObjet(item)
				bREsult = FALSE
				exit
			ok
		next

		return bResult

		def IsAListOfStzObjects()
			return This.IsListOfStzObjects()

	def IsPairOfStzNumbers()
		return This.IsPair() and This.IsListOfStzNumbers()

		def IsAPairOfStzNumbers()
			return This.IsPairOfStzNumbers()

	def IsListOfStzNumbers()
		bResult = TRUE
		for item in This.List()
			if NOT IsStzNumber(item)
				bResult = FALSE
				exit
			ok
		next

		return bResult

		def IsAListOfStzNumbers()
			return This.IsListOfStzNumbers()

	def IsPairOfStzStrings()
		return This.IsPair() and This.IsListOfStzStrings()

	def IsListOfStzStrings()
		bResult = TRUE
		for item in This.List()
			if NOT IsStzString(item)
				bREsult = FALSE
				exit
			ok
		next

		return bResult

		def IsAListOfStzStrings()
			return This.IsListOfStzStrings()

	def IsPairOfStzLists()
		return This.IsPair() and This.IsListOfStzLists()

		def IsAPairOfStzLists()
			return This.IsPairOfStzLists()

	def IsListOfStzLists()
		bResult = TRUE
		for item in This.List()
			if NOT IsStzList(item)
				bREsult = FALSE
				exit
			ok
		next

		return bResult

		def IsAListOfStzLists()
			return This.IsListOfStzLists()

	def IsPairOfStzObjects()
		return This.IsPair() and This.IsListOfStzObjects()

		def IsAPairOfStzObjects()
			return This.IsPairOfStzObjects()

	def IsPairOfChars()
		return This.IsPair() and This.IsListOf(:Chars)

		def IsAPairOfChars()
			return This.IsPairOfChars()

	def IsPairOf(pcType)
		return This.IsPair() and This.IsListOf(pcType)

		def IsAPairOf(pcType)
			return This.IsPairOf(pcType)

	def IsListOf(pcType)
		/* EXAMPLES

			Q([ 1, 2, 3 ]).IsListOf(:Number)	# --> TRUE

			pcType should be a string containing the name of:
				- a string containing one of the 4 Ring types (given by RingTypes() )
				- a Softanza type ( given by StzTypes() )

			For the sake of expressiveness, pcType can be in plural form:

			Q([ 1, 2, 3 ]).IsListOf(:Numbers)

		*/

		pcType = Q(pcType).InfereType()

		cCode1 = 'bOk = item.IsA' + pcType + '()'
		cCode2 = 'bOk = ( ring_type(item) = "' + upper(pcType) + '" )'

		bResult = TRUE
		aList = This.List()
		nLen = len(aList)

		for i = 1 to nLen
			item = aList[i]

			if isObject(item) and Q( ring_classname(item) ).IsStzClassName()
				eval(cCode1)

			else
				eval(cCode2)
			ok

			if NOT bOk
				bResult = FALSE
				exit
			ok
		next

		return bResult


		def IsAListOf(pcType)
			return This.IsListOf(pcType)
		
	def IsListOfPairs()
		/* NOTE

		Could be solved nicely like this:

		bResult = This.Check( :That = 'isList(@item) and Q(@item).IsPair()' )
		return bResult

		But the following solution is more performant:
		*/

		bResult = TRUE
		nLen = This.NumberOfItems()

		for i = 1 to nLen
			item = This[i]

			if NOT ( isList(item) and len(item) = 2 )
				bResult = FALSE
				exit
			ok
		next

		return bResult

		def IsAListOfPairs()
			return This.IsListOfPairs()

	def IsTree()
		if NOT This.IsEmpty()
			return TRUE

		else
			return FALSE
		ok

		def IsATree()
			return This.IsTree()

	def IsStzTree()
		if This.StzClassName() = "stztree"
			return TRUE
		else
			return FALSE
		ok

		def IsAStzTree()
			return This.IsStzTree()

	def IsTable() # TODO: Review this solution
		try
			new stzTable(This.List())
			return TRUE
		catch
			return FALSE
		done

	def IsPivotTable() # TODO
		/* ... */

		def IsAPivotTable()
			return This.IsPivotTable()

	def IsGraph() # TODO
		/* ... */

	  #----------------------------#
	 #   SAME TYPE & SAME VALUE   #
	#----------------------------#

	def ItemsHaveSameType()
		return This.IsPureList()

	def ItemsHaveSameValue()
		bResult = TRUE
		if This.ItemsHaveSameType()
			if This.ItemsAreAllNumbers() or This.ItemsAreAllStrings()
				for i = 2 to This.NumberOfItems()		
					if This.Item(i) != This.Item(i-1)
						bResult = FALSE
						exit
					ok
				next

			but This.ItemsAreAllLists()
				for i=2 to This.NumberOfItems()
					oTempList = new stzList(Item(i))
					if oTempList.IsEqualTo(Item(i-1))
						bResult = FALSE
						exit
					ok
				next

			but ItemsAreAllObjects()
				StzRaise("Can't compare between objects!")
			
			else
				StzRaise("Unsupported type!")
			ok
		else
			bResult = FALSE
		ok

		return bResult

	  #----------------------#
	 #     LIST CONTENT     #
	#----------------------#

	/* NOTE

	All the functions in this section could be implemented easily
	using Condition-Coding. So for example, ContainsOnlyNumbers()
	can be solved like this:

		This.Check( :That = 'type(@item) = "NUMBER"' )

	Despite of this, we provide them here, because they are implemented
	in brute Ring code, and not in run-time evaluated code like in Check(),
	which is better for performance (especially when these functions are
	used in large lists and in deep for-loops.

	*/

	def ContainsOnlyNumbers()
		if len(This.OnlyNumbers()) = This.NumberOfItems()
			return TRUE
		else
			return FALSE
		ok

		def ItemsAreAllNumbers()
			return This.ContainsOnlyNumbers()

		def AllItemsAreNumbers()
			return This.ContainsOnlyNumbers()

		def IsMadeOfNumbers()
			return This.ContainsOnlyNumbers()

	def ContainsOnlyOddNumbers()
		
		bResult = TRUE
		for item in This.Content()
			oTempNumber = new stzNumber(item)
			if NOT oTempNumber.IsOdd()
				bResult = FALSE
				exit
			ok
		next
		return bResult

		def ItemsAreAllOddNumbers()
			return This.ContainsOnlyOddNumbers()

		def AllItemsAreOddNumbers()
			return This.ContainsOnlyOddNumbers()

		def IsMadeOfOddNumbers()
			return This.ContainsOnlyOddNumbers()

	def ContainsOnlyEvenNumbers()

		bResult = TRUE
		for item in This.Content()
			oTempNumber = new stzNumber(item)
			if NOT oTempNumber.IsEven()
				bResult = FALSE
				exit
			ok
		next
		return bResult

		def ItemsAreAllEvenNumbers()
			return This.ContainsOnlyEvenNumbers()

		def AllItemsAreEvenNumbers()
			return This.ContainsOnlyEvenNumbers()

		def IsMadeOfEvenNumbers()
			return This.ContainsOnlyEvenNumbers()

	def ContainsOnlyDigits()

		aDigits = 0:9
		oTempList = new stzList(aDigits)

		bResult = TRUE
		
		for item in This.Content()
			if NOT oTempList.Contains(item)
				bResult = FALSE
				exit
			ok
		next

		return bResult

		def ItemsAreAllDigits()
			return This.ContainsOnlyDigits()

		def AllItemsAreDigits()
			return This.ContainsOnlyDigits()

		def IsMadeOfDigits()
			return This.ContainsOnlyDigits()

	def ContainsOnlyStrings()

		bResult = TRUE

		for item in This.List()
			if NOT isString(item)
				bResult = FALSE
				exit
			ok
		next

		return bResult


		def ItemsAreAllStrings()
			return This.ContainsOnlyStrings()

		def AllItemsAreStrings()
			return This.ContainsOnlyStrings()

		def IsMadeOfStrings()
			return This.ContainsOnlyStrings()

	def ItemsAreAllEqualTo(pValue)
		bResult = TRUE
		for item in This.List()
			if item != pValue
				bResult = FALSE
				exit
			ok
		next
		return bResult

		def AllItemsAreEqualTo(pValue)
			return This.AllItemsAreEqualTo(pValue)

		def IsMadeOfItemsEqualTo(pValue)
			return This.AllItemsAreEqualTo(pValue)

	def ContainsOnlyNullStrings()
		bResult = TRUE
		for item in This.Content()
			if NOT (isString(item) and item = NULL)
				bResult = FALSE
				exit
			ok
		next
		return bResult

		def ContainsOnlyEmptyStrings()
			return This.ContainsOnlyNullStrings()

		def ItemsAreAllNullStrings()
			return This.ContainsOnlyNullStrings()

		def ItemsAreAllEmptyStrings()
			return This.ContainsOnlyNullStrings()

		def AllItemsAreNullStrings()
			return This.ContainsOnlyNullStrings()

		def AllItemsAreNull()
			return This.ContainsOnlyNullStrings()

		def AllItemsAreEmptyStrings()
			return This.ContainsOnlyNullStrings()

		def ItemsAreNull()
			return This.ContainsOnlyNullStrings()

		def ItemsAreNullStrings()
			return This.ContainsOnlyNullStrings()

		def IsMadeOfNullStrings()
			return This.ContainsOnlyNullStrings()

		def IsMadeOfEmptyStrings()
			return This.ContainsOnlyNullStrings()

	def ContainsOnlyLists()
		bResult = TRUE

		for item in This.Content()
			if NOT isList(item)
				bResult = FALSE
				exit
			ok
		next

		return bResult

		def ItemsAreAllLists()
			return This.ContainsOnlyLists()

		def AllItemsAreLists()
			return This.ContainsOnlyLists()

		def IsMadeOfLists()
			return This.ContainsOnlyLists()

	def AllItemsArePairs()
		bResult = TRUE

		for item in This.List()
			if NOT ( isList(item) and Q(item).IsPair() )
				bResult = FALSE
				exit
			ok
		next

		return bResult

		def IsMadeOfPairs()
			return This.AllItemsArePairs()

	def AllItemsArePairsOfNumbers()
		bResult = TRUE

		for item in This.List()
			if NOT ( isList(item) and Q(item).IsPairOfNumbers() )
				bResult = FALSE
				exit
			ok
		next

		return bResult

		def IsMadeOfPairsOfNumbers()
			return This.AllItemsArePairsOfNumbers()

	def AllItemsArePairsOfStrings()
		bResult = TRUE

		for item in This.List()
			if NOT ( isList(item) and Q(item).IsPairOfStrings() )
				bResult = FALSE
				exit
			ok
		next

		return bResult

		def IsMadeOfPairsOfStrings()
			return This.AllItemsArePairsOfStrings()

	def AllItemsArePairsOfLists()
		bResult = TRUE

		for item in This.List()
			if NOT ( isList(item) and Q(item).IsPairOfLists() )
				bResult = FALSE
				exit
			ok
		next

		return bResult

		def IsMadeOfPairsOfLists()
			return This.AllItemsArePairsOfLists()

	def AllItemsArePairsOfObjects()
		bResult = TRUE

		for item in This.List()
			if NOT ( isList(item) and Q(item).IsPairOfObjects() )
				bResult = FALSE
				exit
			ok
		next

		return bResult

		def IsMadeOfPairsOfObjects()
			return This.AllItemsArePairsOfObjects()

	def ContainsOnlyEmptyLists()
		bResult = TRUE
		for item in This.Content()
			if NOT (isList(item) and len(item) = 0)
				bResult = FALSE
				exit
			ok
		next
		return bResult

		def ItemsAreAllEmptyLists()
			return This.ContainsOnlyEmptyLists()

		def AllItemsAreEmptyLists()
			return This.ContainsOnlyEmptyLists()

		def MadeOfEmptyLists()
			return This.ContainsOnlyEmptyLists()

	def ContainsOnlyListsWithSameNumberOfItems()
		bResult = TRUE
		if This.ContainsOnlyLists()
			for i=2 to This.NumberOfItems()
				if len(This[i-1]) != len(This[i])
					bResult = FALSE
					exit
				ok
			next
		else
			bResult = FALSE
		ok
		return bResult

		def ItemsAreAllListsWithSameNumberOfItems()
			return This.ContainsOnlyListsWithSameNumberOfItems()

		def AllItemsAreListsWithSameNumberOfItems()
			return This.ContainsOnlyListsWithSameNumberOfItems()

		def IsMadeOfListsWithSameNumberOfItems()
			return This.ContainsOnlyListsWithSameNumberOfItems()

	def ContainsOnlyObjects()
		bResult = TRUE

		for item in This.List()
			if NOT isObject(item)
				bResult = FALSE
				exit
			ok
		next

		return bResult

		def ItemsAreAllObjects()
			return This.ContainsOnlyObjects()

		def AllItemsAreObjects()
			return This.ContainsOnlyObjects()

		def IsMadeOfObjects()
			return This.ContainsOnlyObjects()

	def ContainsOnlyValidRingCodes()
		bResult = TRUE

		for item in This.List()
			if NOT( isString(item) and Q(@item).IsValidRingCode() )
				bResult = FALSE
				exit
			ok
		next

		return bResult

		def AllItemsAreValidRingCodes()
			return This.ContainsOnlyValidRingCodes()

		def ItemsAreAllValidRingCodes()
			return This.ContainsOnlyValidRingCodes()

		def IsMadeOfValidRingCodes()
			return This.ContainsOnlyValidRingCodes()

	def ContainsOnlyStzCalssNames()
		bResult = TRUE

		for item in This.List()
			if NOT( isString(item) and Q(@item).IsStzClassName() )
				bResult = FALSE
				exit
			ok
		next

		return bResult

		def AllItemsAreStzClassNames()
			return This.ContainsOnlyStzCalssNames()

		def ItemsAreAllStzClassNames()
			return This.ContainsOnlyStzCalssNames()

		def IsMadeOfStzClassNames()
			return This.ContainsOnlyStzCalssNames()

	  #======================#
	 #   MANAGING WALKERS   # TODO
	#======================#

	def AddWalker(pcName, pnStart, pnEnd, panStepping)

		if NOT ( StzNumberQ(pnStart).IsBetween(1, This.NumberOfItems()) and
		         StzNumberQ(pnEnd).IsBetween(1, This.NumberOfItems()) )

			StzRaise("Start or end of walker outside list range!")
		ok

		bNewName = TRUE
		for aWalk in This.Walkers()
			if aWalk[1] = pcName
				bNewName = FALSE
				exit
			ok
		next

		if NOT bNewName
			StzRaise(stzListError(:CanNotAddWalkerAlreadyExistant))
		else
			oWalk = new stzWalker(pnStart, pnEnd, panStepping)
			@aWalkers + [ pcName, oWalk.Content() ]
		ok

	def Walkers()
		return @aWalkers

	def Walker(pcWalker)
		return This.Walkers()[pcWalker]

	def FindWalker(pcWalker) # TODO
		/* ... */

	def RemoveWalker(pcWalker)
		del( @aWalkers, This.FindWalker(pcWalker) )

	def RemoveTheseWalkers(pacNames) # TODO
		/* ... */

	def RemoveWalkers()
		@aWalkers = []

		def RemoveAllWalkers()
			This.RemoveWalkers()

	def CombineTheseWalkers(pacNames) # TODO
		/* ... */

		def ComposeTheseWalkers(pacNames)
			return This.CombineTheseWalkers(pacNames)

	def CombineWalkers()
		/* ... */

		def CombineAllWalkers()
			This.CombineWalkers()

		def ComposeWalkers()
			This.CombineWalkers()

		def ComposeAllWalkers()
			This.CombineWalkers()

	def CombinedWalkers() # TODO
		/* ... */

		def ComposedWalkers()
			return This.CombinedWalkers()

	  #=================#
	 #  WALKING WHERE  #
	#=================#

	def WalkWhere(pcCondition)
		return This.WalkWhereXT(pcCondition, :Forward, :Return = :WalkedPositions)

		def WalkW(pcCondition)
			if isList(pcCondition) and Q(pcCondition).IsWhereNamedParam()
				pcCondition = pcCondition[2]
			ok

			return This.WalkWhere(pcCondition)

	def WalkWhereXT(pcCondition, pcDirection, pReturn)
		/*
		o1 = new stzList([ 1, "A", 3, "B", "_", 6 ])

		? WalkWhere("isNumber(@item)")
		# --> [1, 3, 6]
		*/

		# Checking params

		if NOT isString(pcCondition)
			StzRaise("Incorrect param type! pcCondition must be a string.")
		ok

		if isList(pReturn) and
		   Q(pReturn).IsOneOfTheseNamedParams([ :Return, :AndReturn ])

			pReturn = pReturn[2]
		ok

		if NOT ( isString(pReturn) and

			 Q(pReturn).IsOneOfThese([
				:WalkedPositions, :WalkedItems,
				:LastPosition, :LastWalkedPosition,
				:LastItem, :LastWalkedItem,
				:Default
			]) )

			StzRaise("Incorrect param! pReturn must be a string. Allowed values are " +
				 ":WalkedPositions, :WalkedItems, :LastWalkedPosition, :LastWalkedItem, and :Default." )
		ok

		if pReturn = :Default
			pReturn = :WalkedPositions
		ok

		if isList(pcDirection) and Q(pcDirection).IsDirectionNamedParam()
			pcDirection = pcDirection[2]
		ok

		if NOT ( isString(pcDirection) and
			 Q(pcDirection).IsOneOfThese([ :Forward, :Backward, :Default ]) )

			StzRaise("Incorrect param type! pcDirection must be one of these strings [ :Forward, :Backward, :Default ].")
		ok

		if pcDirection = :Default
			pcDirection = :Forward
		ok

		# Doing the job

		anPositions = []

		cCode = 'bOk = (' + StzCCodeQ(pcCondition).Transpiled() + ' )'

		anPositions = []
		nLen = This.NumberOfItems()

		nStart = 1
		nEnd   = nLen
		nStep  = 1

		if pcDirection = :Backward
			nStart = nLen
			nEnd   = 1
			nStep  = -1
		ok

		for @i = nStart to nEnd step nStep
			
			eval(cCode)

			if bOk
				anPositions + @i
			ok
	
		next

		if pReturn = :WalkedItems
			return This.ItemsAt(anPositions)

		but pReturn = :WalkedPositions
			return anPositions

		but pReturn = :LastItem or pReturn = :LastWalkedItem
			return This.ItemAt(len(anPositions))

		but pReturn = :LastPosition or pReturn = :LastWalkedPosition
			return anPositions[len(anPositions)]

		else
			return anPositions
		end

		def WalkWXT(pcCondition, pReturn)
			if isList(pcCondition) and Q(pcCondition).IsWhereNamedParam()
				pcCondition = pcCondition[2]
			ok

			return This.WalkWhereXT(pcCondition, pReturn)

	  #============================================#
	 #  WALKING UNTIL (AND WALKING UNTIL BEFORE)  #
	#============================================#

	def WalkUntil(pcCondition)
		return This.WalkUntilXT(pcCondition, :Forward, :WalkedPositions)

	def WalkUntilBefore(pcCondition)
		return This.WalkUntil( :Before = pcCondition )

	def WalkUntilXT(pcCondition, pcDirection, pReturn)
		/*
		[ "A", "B", 12, "C", "D", "E", 4, "F", 25, "G", "H" ]

		WalkUntil("@item = 'D'", :Return = :WalkedPositions  )  # --> 1:5
		WalkUntil("@item = 'D'", :Return = :LastPosition )  # --> 5

		WalkUntil("@item = 'D'", :Return = :WalkedItems )
		# --> [ "A", "B", 12, "C", "D" ]

		WalkUntil("@item = 'D'", :Return = :LastItem ) # --> "D"


		WalkUntil("isNumber(@item)") # --> 1:3
		WalkUntil("isNumber(@item) and @item > 20") # --> 1:9
		*/

		bWalkBefore = FALSE

		# Checking the params

		if isList(pcCondition) and Q(pcCondition).IsBeforeNamedParam()
			bWalkBefore = TRUE
			pcCondition = pcCondition[2]
		ok

		if NOT isString(pcCondition)
			StzRaise("Incorrect param type! pcCondition must be a string.")
		ok

		if isList(pReturn) and
		   Q(pReturn).IsOneOfTheseNamedParams([ :Return, :AndReturn ])

			pReturn = pReturn[2]
		ok

		if NOT ( isString(pReturn) and

			 Q(pReturn).IsOneOfThese([
				:WalkedPositions, :WalkedItems,
				:LastPosition, :LastWalkedPosition,
				:LastItem, :LastWalkedItem,
				:Default
			]) )

			StzRaise("Incorrect param! pReturn must be a string. Allowed values are " +
				 ":WalkedPositions, :WalkedItems, :LastWalkedPosition, :LastWalkedItem, and :Default." )
		ok

		if pReturn = :Default
			pReturn = :WalkedPositions
		ok

		if isList(pcDirection) and Q(pcDirection).IsDirectionNamedParam()
			pcDirection = pcDirection[2]
		ok

		if NOT ( isString(pcDirection) and
			 Q(pcDirection).IsOneOfThese([ :Forward, :Backward, :Default ]) )

			StzRaise("Incorrect param type! pcDirection must be one of these strings [ :Forward, :Backward, :Default ].")
		ok

		if pcDirection = :Default
			pcDirection = :Forward
		ok
		# Doing the job

		cCode = 'bOk = ( ' +  StzCCodeQ(pcCondition).Transpiled() + ' )'

		bFound = FALSE
		aList = This.Content()
		nLen = This.NumberOfItems()

		anPositions = []

		nStart = 1
		nEnd   = nLen
		nStep  = 1

		if pcDirection = :Backward
			nStart = nLen
			nEnd   = 1
			nStep  = -1
		ok

		for @i = nStart to nEnd step nStep
			eval(cCode)

			if bOk
				if bWalkBefore = FALSE
					anPositions + @i
				ok

				exit
			ok

			anPositions + @i
			
		next

		if pReturn = :WalkedItems
			return This.ItemsAt(anPositions)

		but pReturn = :WalkedPositions
			return anPositions

		but pReturn = :LastItem or pReturn = :LastWalkedItem
			return This.ItemAt(len(anPositions))

		but pReturn = :LastPosition or pReturn = :LastWalkedPosition
			return anPositions[len(anPositions)]

		else
			return anPositions
		end

	def WalkUntilBeforeXT(pcCondition, pReturn)
		return This.WalkUntilXT( :Before = pcCondition, pReturn)

	  #=================#
	 #  WALKING WHILE  #
	#=================#

	def WalkWhile(pcCondition)
		return This.WalkWhileXT(pcCondition, :Forward, :WalkedPositions)

	def WalkWhileXT(pcCondition, pcDirection, pReturn)
		/*
		o1 = new stzList([ "A", "B", "_", "*", 12, "C", "D", 4 ])

		? WalkWhile("Q(@item).IsNotNumber()")
		# --> 1:4
		*/

		# Checking params

		if NOT isString(pcCondition)
			StzRaise("Incorrect param type! pcCondition must be a string.")
		ok

		if isList(pReturn) and
		   Q(pReturn).IsOneOfTheseNamedParams([ :Return, :AndReturn ])

			pReturn = pReturn[2]
		ok

		if NOT ( isString(pReturn) and

			 Q(pReturn).IsOneOfThese([
				:WalkedPositions, :WalkedItems,
				:LastPosition, :LastWalkedPosition,
				:LastItem, :LastWalkedItem,
				:Default
			]) )

			StzRaise("Incorrect param! pReturn must be a string. Allowed values are " +
				 ":WalkedPositions, :WalkedItems, :LastWalkedPosition, :LastWalkedItem, and :Default." )
		ok

		if pReturn = :Default
			pReturn = :WalkedPositions
		ok

		if isList(pcDirection) and Q(pcDirection).IsDirectionNamedParam()
			pcDirection = pcDirection[2]
		ok

		if NOT ( isString(pcDirection) and
			 Q(pcDirection).IsOneOfThese([ :Forward, :Backward, :Default ]) )

			StzRaise("Incorrect param type! pcDirection must be one of these strings [ :Forward, :Backward, :Default ].")
		ok

		if pcDirection = :Default
			pcDirection = :Forward
		ok

		# Doing the job

		cCode = 'bOk = (' + StzCCodeQ(pcCondition).Transpiled() + ' )'

		anPositions = []
		nLen = This.NumberOfItems()

		nStart = 1
		nEnd   = nLen
		nStep  = 1

		if pcDirection = :Backward
			nStart = nLen
			nEnd   = 1
			nStep  = -1
		ok

		for @i = nStart to nEnd step nStep
			
			eval(cCode)

			if NOT bOk
				exit
			ok

			anPositions + @i
		next

		if pReturn = :WalkedItems
			return This.ItemsAt(anPositions)

		but pReturn = :WalkedPositions
			return anPositions

		but pReturn = :LastItem or pReturn = :LastWalkedItem
			return This.ItemAt(len(anPositions))

		but pReturn = :LastPosition or pReturn = :LastWalkedPosition
			return anPositions[len(anPositions)]

		else
			return anPositions
		end

	  #================#
	 #  WALKING WHEN  #
	#================#

	def WalkWhen(pcCondition)
		return This.WalkWhenXT(pcCondition, :Forward, :WalkedPositions)

	def WalkWhenXT(pcCondition, pcDirection, pReturn)

		# Checking params

		if NOT isString(pcCondition)
			StzRaise("Incorrect param type! pcCondition must be a string.")
		ok

		if isList(pReturn) and
		   Q(pReturn).IsOneOfTheseNamedParams([ :Return, :AndReturn ])

			pReturn = pReturn[2]
		ok

		if NOT ( isString(pReturn) and

			 Q(pReturn).IsOneOfThese([
				:WalkedPositions, :WalkedItems,
				:LastPosition, :LastWalkedPosition,
				:LastItem, :LastWalkedItem,
				:Default
			]) )

			StzRaise("Incorrect param! pReturn must be a string. Allowed values are " +
				 ":WalkedPositions, :WalkedItems, :LastWalkedPosition, :LastWalkedItem, and :Default." )
		ok

		if pReturn = :Default
			pReturn = :WalkedPositions
		ok

		if isList(pcDirection) and Q(pcDirection).IsDirectionNamedParam()
			pcDirection = pcDirection[2]
		ok

		if NOT ( isString(pcDirection) and
			 Q(pcDirection).IsOneOfThese([ :Forward, :Backward, :Default ]) )

			StzRaise("Incorrect param type! pcDirection must be one of these strings [ :Forward, :Backward, :Default ].")
		ok

		if pcDirection = :Default
			pcDirection = :Forward
		ok

		# Doing the job

		cCode = 'bOk = (' + StzCCodeQ(pcCondition).Transpiled() + ' )'

		anPositions = []
		nLen = This.NumberOfItems()

		nStart = 1
		nEnd   = nLen
		nStep  = 1

		if pcDirection = :Backward
			nStart = nLen
			nEnd   = 1
			nStep  = -1
		ok

		for @i = nStart to nEnd step nStep
			
			eval(cCode)

			if bOk
				anPositions = @i : nEnd
				exit
			ok

			
		next

		if pReturn = :WalkedItems
			return This.ItemsAt(anPositions)

		but pReturn = :WalkedPositions
			return anPositions

		but pReturn = :LastItem or pReturn = :LastWalkedItem
			return This.ItemAt(len(anPositions))

		but pReturn = :LastPosition or pReturn = :LastWalkedPosition
			return anPositions[len(anPositions)]

		else
			return anPositions
		end

	  #===================#
	 #  WALKING BETWEEN  #
	#===================#

	def WalkBetween(n1, n2)
		return This.WalkBetweenXT(n1, n2, :WalkedPositions)

	def WalkBetweenXT(n1, n2, pReturn)

		# Checking params

		if isList(n1) and Q(n1).IsOneOfTheseNamedParams([ :Position, :Positions ])
			n1 = n1[2]
		ok

		if isList(n2) and Q(n2).IsOneOfTheseNamedParams([ :Position, :AndPosition, :And ])
			n2 = n2[2]
		ok

		if NOT BothAreNumbers(n1, n2)
			StzRaise("Incorrect param type! n1 and n2 must be numbers.")
		ok

		if isList(pReturn) and
		   Q(pReturn).IsOneOfTheseNamedParams([ :Return, :AndReturn ])

			pReturn = pReturn[2]
		ok

		if NOT ( isString(pReturn) and

			 Q(pReturn).IsOneOfThese([
				:WalkedPositions, :WalkedItems,
				:LastPosition, :LastWalkedPosition,
				:LastItem, :LastWalkedItem,
				:Default
			]) )

			StzRaise("Incorrect param! pReturn must be a string. Allowed values are " +
				 ":WalkedPositions, :WalkedItems, :LastWalkedPosition, :LastWalkedItem, and :Default." )
		ok

		if pReturn = :Default
			pReturn = :WalkedPositions
		ok

		# Doing the job

		anPositions = []
		nLen = This.NumberOfItems()

		anPositions = n1 : n2

		if pReturn = :WalkedItems
			return This.ItemsAt(anPositions)

		but pReturn = :WalkedPositions
			return anPositions

		but pReturn = :LastItem or pReturn = :LastWalkedItem
			return This.ItemAt(len(anPositions))

		but pReturn = :LastPosition or pReturn = :LastWalkedPosition
			return anPositions[len(anPositions)]

		else
			return anPositions
		end

	  #===================================#
	 #  WALKING THE LIST FORTH AND BACK  #
	#===================================#

	def WalkForthAndBack()
		return This.WalkForthAndBackXT(:Return = :WalkedPositions)

	def WalkForthAndBackXT(pReturn)

		# Checking pReturn param

		if isList(pReturn) and
		   Q(pReturn).IsOneOfTheseNamedParams([ :Return, :AndReturn ])

			pReturn = pReturn[2]
		ok

		if NOT ( isString(pReturn) and

			 Q(pReturn).IsOneOfThese([
				:WalkedPositions, :WalkedItems,
				:LastPosition, :LastWalkedPosition,
				:LastItem, :LastWalkedItem,
				:Default
			]) )

			StzRaise("Incorrect param! pReturn must be a string. Allowed values are " +
				 ":WalkedPositions, :WalkedItems, :LastWalkedPosition, :LastWalkedItem, and :Default." )
		ok

		# Doing the job

		anPositions = 1 : This.NumberOfItems()

		for i = This.NumberOfItems()-1 to 1 step -1
			anPositions + i
		next
		
		if pReturn = :WalkedItems
			return This.ItemsAt(anPositions)

		but pReturn = :WalkedPositions
			return anPositions

		but pReturn = :LastItem or pReturn = :LastWalkedItem
			return This.ItemAt(len(anPositions))

		but pReturn = :LastPosition or pReturn = :LastWalkedPosition
			return anPositions[len(anPositions)]

		else
			return anPositions
		end

	  #-----------------------------------#
	 #  WALKING THE LIST BACK AND FORTH  #
	#-----------------------------------#

	def WalkBackAndForth()
		return This.WalkBackAndForthXT(:Return = :WalkedPositions)

	def WalkBackAndForthXT(pReturn)

		# Checking pReturn param

		if isList(pReturn) and
		   Q(pReturn).IsOneOfTheseNamedParams([ :Return, :AndReturn ])

			pReturn = pReturn[2]
		ok

		if NOT ( isString(pReturn) and

			 Q(pReturn).IsOneOfThese([
				:WalkedPositions, :WalkedItems,
				:LastPosition, :LastWalkedPosition,
				:LastItem, :LastWalkedItem,
				:Default
			]) )

			StzRaise("Incorrect param! pReturn must be a string. Allowed values are " +
				 ":WalkedPositions, :WalkedItems, :LastWalkedPosition, :LastWalkedItem, and :Default." )
		ok

		# Doing the job

		anPositions = This.NumberOfItems() : 1

		for i = 2 to This.NumberOfItems()
			anPositions + i
		next

		if pReturn = :WalkedItems
			return This.ItemsAt(anPositions)

		but pReturn = :WalkedPositions
			return anPositions

		but pReturn = :LastItem or pReturn = :LastWalkedItem
			return This.ItemAt(len(anPositions))

		but pReturn = :LastPosition or pReturn = :LastWalkedPosition
			return anPositions[len(anPositions)]

		else
			return anPositions
		end

	  #===============================================#
	 #  WALKING THE LIST EACH TIME N ITEMS FORWARD   #
	#===============================================#

	def WalkNItemsForward(n)
		return This.WalkNItemsForwardXT(n, :Return = :WalkedPositions)

		#< @FunctionAlternativeForms

		def WalkNStepsForward(n)
			return This.WalkNItemsForward(n)

		def WalkForward(n)
			return This.WalkNItemsForward(n)

		def WalkNForward(n)
			return This.WalkNItemsForward(n)

		#--

		def WalkEachTimeNSItemsForward(n)
			return This.WalkNItemsForward(n)

		def WalkEachTimeNStepsForward(n)
			return This.WalkNItemsForward(n)

		#>

	def WalkNItemsForwardXT(n, pReturn)

		# Checking params

		if NOT isNumber(n)
			StzRaise("Incorrect param! n must be a number.")
		ok

		if isList(pReturn) and
		   Q(pReturn).IsOneOfTheseNamedParams([ :Return, :AndReturn ])

			pReturn = pReturn[2]
		ok

		if NOT ( isString(pReturn) and

			 Q(pReturn).IsOneOfThese([
				:WalkedPositions, :WalkedItems,
				:LastPosition, :LastWalkedPosition,
				:LastItem, :LastWalkedItem,
				:Default
			]) )

			StzRaise("Incorrect param! pReturn must be a string. Allowed values are " +
				 ":WalkedPositions, :WalkedItems, :LastWalkedPosition, :LastWalkedItem, and :Default." )
		ok

		# Doing the job

		anPositions = []

		for i = 1 to This.NumberOfItems() step n
			anPositions + i
		next

		if pReturn = :WalkedItems
			return This.ItemsAt(anPositions)

		but pReturn = :WalkedPositions
			return anPositions

		but pReturn = :LastItem or pReturn = :LastWalkedItem
			return This.ItemAt(len(anPositions))

		but pReturn = :LastPosition or pReturn = :LastWalkedPosition
			return anPositions[len(anPositions)]

		else
			return anPositions
		end

		#< @FunctionAlterntives

		def WalkNStepsForwardXT(n, pReturn)
			return This.WalkNItemsForwardXT(n, pReturn)

		def WalkForwardXT(n, pReturn)
			return This.WalkNItemsForwardXT(n, pReturn)

		def WalkNForwardXT(n, pReturn)
			return This.WalkNItemsForwardXT(n, pReturn)

		#--

		def WalkEachTimeNSItemsForwardXT(n, pReturn)
			return This.WalkNItemsForwardXT(n, pReturn)

		def WalkEachTimeNStepsForwardXT(n, pReturn)
			return This.WalkNItemsForwardXT(n, pReturn)

		#>

	  #-----------------------------------------------#
	 #  WALKING THE LIST EACH TIME N ITEMS BACKWARD  #
	#-----------------------------------------------#

	def WalkNItemsBackward(n)
		return This.WalkNItemsBackwardXT(n, :Return = :WalkedPositions)

		#< @FunctionAlternativeForms

		def WalkNStepsBackward(n)
			return This.WalkNItemsBackward(n)

		def WalkNBackward(n)
			return This.WalkNItemsBackward(n)

		def WalkBackward(n)
			return This.WalkNItemsBackward(n)

		#--

		def WalkEachTimeNItemsBackward(n)
			return This.WalkNItemsBackward(n)

		def WalkEachTimeNStepsBackward(n)
			return This.WalkNItemsBackward(n)

		#>

	def WalkNItemsBackwardXT(n, pReturn)

		# Checking params

		if NOT isNumber(n)
			StzRaise("Incorrect param! n must be a number.")
		ok

		if isList(pReturn) and
		   Q(pReturn).IsOneOfTheseNamedParams([ :Return, :AndReturn ])

			pReturn = pReturn[2]
		ok

		if NOT ( isString(pReturn) and

			 Q(pReturn).IsOneOfThese([
				:WalkedPositions, :WalkedItems,
				:LastPosition, :LastWalkedPosition,
				:LastItem, :LastWalkedItem,
				:Default
			]) )

			StzRaise("Incorrect param! pReturn must be a string. Allowed values are " +
				 ":WalkedPositions, :WalkedItems, :LastWalkedPosition, :LastWalkedItem, and :Default." )
		ok

		# Doing the job

		anPositions = []

		for i = This.NumberOfItems() to 1 step -n
			anPositions + i
		next

		if pReturn = :WalkedItems
			return This.ItemsAt(anPositions)

		but pReturn = :WalkedPositions
			return anPositions

		but pReturn = :LastItem or pReturn = :LastWalkedItem
			return This.ItemAt(len(anPositions))

		but pReturn = :LastPosition or pReturn = :LastWalkedPosition
			return anPositions[len(anPositions)]

		else
			return anPositions
		end

		#< @FunctionAlternativeForms

		def WalkNStepsBackwardXT(n, pReturn)
			return This.WalkNItemsBackwardXT(n, pReturn)

		def WalkNBackwardXT(n, pReturn)
			return This.WalkNItemsBackwardXT(n, pReturn)

		def WalkBackwardXT(n, pReturn)
			return This.WalkNItemsBackwardXT(n, pReturn)

		#--

		def WalkEachTimeNItemsBackwardXT(n, pReturn)
			return This.WalkNItemsBackwardXT(n, pReturn)

		def WalkEachTimeNStepsBackwardXT(n, pReturn)
			return This.WalkNItemsBackwardXT(n, pReturn)

		#>

	  #===========================================================#
	 #  WALKING THE LIST EACH TIME N MORE ITEMS FORWARD   #
	#===========================================================#

	def WalkNProgressiveItemsForward(n)
		return This.WalkNProgressiveItemsForwardXT(n, :Return = :WalkedPositions)

		#< @FunctionAlternativeForms

		def WalkEachTimeNProgressiveItemsForward(n)
			return This.WalkNProgressiveItemsForward(n)

		def WalkProgressiveNItemsForward(n)
			return This.WalkNProgressiveItemsForward(n)

		#--

		def WalkNProgressiveStepsForward(n)
			return This.WalkNProgressiveItemsForward(n)

		def WalkEachTimeNProgressiveStepsForward(n)
			return This.WalkNProgressiveItemsForward(n)


		def WalkProgressiveNStepsForward(n)
			return This.WalkNProgressiveItemsForward(n)

		#--

		def WalkNMoreItemsForward(n)
			return This.WalkNProgressiveItemsForward(n)

		def WalkEachTimeNMoreItemsForward(n)
			return This.WalkNProgressiveItemsForward(n)


		def WalkNMoreStepsForward(n)
			return This.WalkNProgressiveItemsForward(n)

		def WalkEachTimeNMoreStepsForward(n)
			return This.WalkNProgressiveItemsForward(n)


		def WalkMoreNItemsForward(n)
			return This.WalkNProgressiveItemsForward(n)


		def WalkMoreStepsForward(n)
			return This.WalkNProgressiveItemsForward(n)

		def WalkEachTimeMoreStepsForward(n)
			return This.WalkNProgressiveItemsForward(n)

		def WalkNMoreForward(n)
			return This.WalkNProgressiveItemsForward(n)

		#--

		def WalkMoreForward(n)
			return This.WalkNProgressiveItemsForward(n)

		#==

		def WalkNCumulativeItemsForward(n)
			return This.WalkNProgressiveItemsForward(n)

		def WalkEachTimeNCumulativeItemsForward(n)
			return This.WalkNProgressiveItemsForward(n)


		def WalkCumulativeNItemsForward(n)
			return This.WalkNCumulativeItemsForward(n)

		#--

		def WalkNCumulativeStepsForward(n)
			return This.WalkNCumulativeItemsForward(n)

		def WalkEachTimeNCumulativeStepsForward(n)
			return This.WalkNProgressiveItemsForward(n)


		def WalkCumulativeNStepsForward(n)
			return This.WalkNCumulativeItemsForward(n)

		#>

	def WalkNProgressiveItemsForwardXT(n, pReturn)

		# Checking params

		if NOT isNumber(n)
			StzRaise("Incorrect param! n must be a number.")
		ok

		if isList(pReturn) and
		   Q(pReturn).IsOneOfTheseNamedParams([ :Return, :AndReturn ])

			pReturn = pReturn[2]
		ok

		if NOT ( isString(pReturn) and

			 Q(pReturn).IsOneOfThese([
				:WalkedPositions, :WalkedItems,
				:LastPosition, :LastWalkedPosition,
				:LastItem, :LastWalkedItem,
				:Default
			]) )

			StzRaise("Incorrect param! pReturn must be a string. Allowed values are " +
				 ":WalkedPositions, :WalkedItems, :LastWalkedPosition, :LastWalkedItem, and :Default." )
		ok

		# Doing the job

		anPositions = []

		if n < 0

			StzRaise("Can't proceed. n must be positive!")
		but n = 0
			anPositions = [1]

		else
			anPositions = [1]
			nstep = 1
			i = 0
			
			while nStep <= This.NumberOfItems()
				i++
				nStep += (n * i)
				if nStep <= This.NumberOfItems()
					anPositions + nStep
				ok
			end

		ok

		if pReturn = :WalkedItems
			return This.ItemsAt(anPositions)

		but pReturn = :WalkedPositions
			return anPositions

		but pReturn = :LastItem or pReturn = :LastWalkedItem
			return This.ItemAt(len(anPositions))

		but pReturn = :LastPosition or pReturn = :LastWalkedPosition
			return anPositions[len(anPositions)]

		else
			return anPositions
		end

		#< @FunctionAlternativeForms

		def WalkEachTimeNProgressiveItemsForwardXT(n, pReturn)
			return This.WalkNProgressiveItemsForwardXT(n, pReturn)

		def WalkProgressiveNItemsForwardXT(n, pReturn)
			return This.WalkNProgressiveItemsForwardXT(n, pReturn)

		#--

		def WalkNProgressiveStepsForwardXT(n, pReturn)
			return This.WalkNProgressiveItemsForwardXT(n, pReturn)

		def WalkEachTimeNProgressiveStepsForwardXT(n, pReturn)
			return This.WalkNProgressiveItemsForwardXT(n, pReturn)


		def WalkProgressiveNStepsForwardXT(n, pReturn)
			return This.WalkNProgressiveItemsForwardXT(n, pReturn)

		#--

		def WalkNMoreItemsForwardXT(n, pReturn)
			return This.WalkNProgressiveItemsForwardXT(n, pReturn)

		def WalkEachTimeNMoreItemsForwardXT(n, pReturn)
			return This.WalkNProgressiveItemsForwardXT(n, pReturn)


		def WalkNMoreStepsForwardXT(n, pReturn)
			return This.WalkNProgressiveItemsForwardXT(n, pReturn)

		def WalkEachTimeNMoreStepsForwardXT(n, pReturn)
			return This.WalkNProgressiveItemsForwardXT(n, pReturn)


		def WalkMoreNItemsForwardXT(n, pReturn)
			return This.WalkNProgressiveItemsForwardXT(n, pReturn)


		def WalkMoreStepsForwardXT(n, pReturn)
			return This.WalkNProgressiveItemsForwardXT(n, pReturn)

		def WalkEachTimeMoreStepsForwardXT(n, pReturn)
			return This.WalkNProgressiveItemsForwardXT(n, pReturn)

		def WalkNMoreForwardXT(n, pReturn)
			return This.WalkNProgressiveItemsForwardXT(n, pReturn)

		#--

		def WalkMoreForwardXT(n, pReturn)
			return This.WalkNProgressiveItemsForwardXT(n, pReturn)

		#==

		def WalkNCumulativeItemsForwardXT(n, pReturn)
			return This.WalkNProgressiveItemsForwardXT(n, pReturn)

		def WalkEachTimeNCumulativeItemsForwardXT(n, pReturn)
			return This.WalkNProgressiveItemsForwardXT(n, pReturn)


		def WalkCumulativeNItemsForwardXT(n, pReturn)
			return This.WalkNCumulativeItemsForwardXT(n, pReturn)

		#--

		def WalkNCumulativeStepsForwardXT(n, pReturn)
			return This.WalkNCumulativeItemsForwardXT(n, pReturn)

		def WalkEachTimeNCumulativeStepsForwardXT(n, pReturn)
			return This.WalkNProgressiveItemsForwardXT(n, pReturn)


		def WalkCumulativeNStepsForwardXT(n, pReturn)
			return This.WalkNCumulativeItemsForwardXT(n, pReturn)

		#>

	  #------------------------------------------------------------#
	 #  WALKING THE LIST EATCH TIME N PROGRESSIVE ITEMS BACKWARD  #
	#------------------------------------------------------------#

	def WalkNProgressiveItemsBackward(n)
		return This.WalkNProgressiveItemsBackwardXT(n, :Return = :WalkedPositions)

		#< @FunctionAlternativeForms

		def WalkEachTimeNProgressiveItemsBackward(n)
			return This.WalkNProgressiveItemsBackward(n)

		def WalkProgressiveNItemsBackward(n)
			return This.WalkNProgressiveItemsBackward(n)

		#--

		def WalkNProgressiveStepsBackward(n)
			return This.WalkNProgressiveItemsBackward(n)

		def WalkEachTimeNProgressiveStepsBackward(n)
			return This.WalkNProgressiveItemsBackward(n)


		def WalkProgressiveNStepsBackward(n)
			return This.WalkNProgressiveItemsBackward(n)

		#--

		def WalkNMoreItemsBackward(n)
			return This.WalkNProgressiveItemsBackward(n)

		def WalkEachTimeNMoreItemsBackward(n)
			return This.WalkNProgressiveItemsBackward(n)


		def WalkNMoreStepsBackward(n)
			return This.WalkNProgressiveItemsBackward(n)

		def WalkEachTimeNMoreStepsBackward(n)
			return This.WalkNProgressiveItemsBackward(n)


		def WalkMoreNItemsBackward(n)
			return This.WalkNProgressiveItemsBackward(n)

		def WalkMoreStepsBackward(n)
			return This.WalkNProgressiveItemsBackward(n)

		def WalkNMoreBackward(n)
			return This.WalkNProgressiveItemsBackward(n)

		#--

		def WalkMoreBackward(n)
			return This.WalkNProgressiveItemsBackward(n)

		#==

		def WalkNCumulativeItemsBackward(n)
			return This.WalkNProgressiveItemsBackward(n)

		def WalkEachTimeNCumulativeItemsBackward(n)
			return This.WalkNProgressiveItemsBackward(n)


		def WalkCumulativeNItemsBackward(n)
			return This.WalkNCumulativeItemsBackward(n)

		#--

		def WalkNCumulativeStepsBackward(n)
			return This.WalkNCumulativeItemsBackward(n)

		def WalkEachTimeNCumulativeStepsBackward(n)
			return This.WalkNCumulativeItemsBackward(n)


		def WalkCumulativeNStepsBackward(n)
			return This.WalkNCumulativeItemsBackward(n)

		#>

	def WalkNProgressiveItemsBackwardXT(n, pReturn)

		# Checking params

		if NOT isNumber(n)
			StzRaise("Incorrect param! n must be a number.")
		ok

		if isList(pReturn) and
		   Q(pReturn).IsOneOfTheseNamedParams([ :Return, :AndReturn ])

			pReturn = pReturn[2]
		ok

		if NOT ( isString(pReturn) and

			 Q(pReturn).IsOneOfThese([
				:WalkedPositions, :WalkedItems,
				:LastPosition, :LastWalkedPosition,
				:LastItem, :LastWalkedItem,
				:Default
			]) )

			StzRaise("Incorrect param! pReturn must be a string. Allowed values are " +
				 ":WalkedPositions, :WalkedItems, :LastWalkedPosition, :LastWalkedItem, and :Default." )
		ok

		# Doing the job

		anPositions = []

		if n < 0
			StzRaise("Can't proceed. n must be positive!")

		but n = 0
			anPositions = [ This.NumberOfItems() ]

		else
			anPositions = [ This.NumberOfItems() ]
			nStep = This.NumberOfItems()
			i = 0
			
			while nStep > 0
				i++
				nStep -= (n * i)
				if nStep > 0
					anPositions + nStep
				ok
			end
	
		ok

		if pReturn = :WalkedItems
			return This.ItemsAt(anPositions)

		but pReturn = :WalkedPositions
			return anPositions

		but pReturn = :LastItem or pReturn = :LastWalkedItem
			return This.ItemAt(len(anPositions))

		but pReturn = :LastPosition or pReturn = :LastWalkedPosition
			return anPositions[len(anPositions)]

		else
			return anPositions
		end

		#< @FunctionAlternativeForms

		def WalkEachTimeNProgressiveItemsBackwardXT(n, pReturn)
			return This.WalkNProgressiveItemsBackwardXT(n, pReturn)

		def WalkProgressiveNItemsBackwardXT(n, pReturn)
			return This.WalkNProgressiveItemsBackwardXT(n, pReturn)

		#--

		def WalkNProgressiveStepsBackwardXT(n, pReturn)
			return This.WalkNProgressiveItemsBackwardXT(n, pReturn)

		def WalkEachTimeNProgressiveStepsBackwardXT(n, pReturn)
			return This.WalkNProgressiveItemsBackwardXT(n, pReturn)


		def WalkProgressiveNStepsBackwardXT(n, pReturn)
			return This.WalkNProgressiveItemsBackwardXT(n, pReturn)

		#--

		def WalkNMoreItemsBackwardXT(n, pReturn)
			return This.WalkNProgressiveItemsBackwardXT(n, pReturn)

		def WalkEachTimeNMoreItemsBackwardXT(n, pReturn)
			return This.WalkNProgressiveItemsBackwardXT(n, pReturn)


		def WalkNMoreStepsBackwardXT(n, pReturn)
			return This.WalkNProgressiveItemsBackwardXT(n, pReturn)

		def WalkEachTimeNMoreStepsBackwardXT(n, pReturn)
			return This.WalkNProgressiveItemsBackwardXT(n, pReturn)


		def WalkMoreNItemsBackwardXT(n, pReturn)
			return This.WalkNProgressiveItemsBackwardXT(n, pReturn)

		def WalkMoreStepsBackwardXT(n, pReturn)
			return This.WalkNProgressiveItemsBackwardXT(n, pReturn)

		def WalkNMoreBackwardXT(n, pReturn)
			return This.WalkNProgressiveItemsBackwardXT(n, pReturn)

		#--

		def WalkMoreBackwardXT(n, pReturn)
			return This.WalkNProgressiveItemsBackwardXT(n, pReturn)

		#==

		def WalkNCumulativeItemsBackwardXT(n, pReturn)
			return This.WalkNProgressiveItemsBackwardXT(n, pReturn)

		def WalkEachTimeNCumulativeItemsBackwardXT(n, pReturn)
			return This.WalkNProgressiveItemsBackwardXT(n, pReturn)


		def WalkCumulativeNItemsBackwardXT(n, pReturn)
			return This.WalkNCumulativeItemsBackwardXT(n, pReturn)

		#--

		def WalkNCumulativeStepsBackwardXT(n, pReturn)
			return This.WalkNCumulativeItemsBackwardXT(n, pReturn)

		def WalkEachTimeNCumulativeStepsBackwardXT(n, pReturn)
			return This.WalkNCumulativeItemsBackwardXT(n, pReturn)


		def WalkCumulativeNStepsBackwardXT(n, pReturn)
			return This.WalkNCumulativeItemsBackwardXT(n, pReturn)

		#>

	  #================================================#
	 #  WALKING N ITEMS FORWARD AND N ITEMS BACKWARD  #
	#================================================#

	def WalkNItemsForwardNItemsBackward(pnForward, pnBackward)
		return This.WalkNItemsForwardNItemsBackwardXT(pnForward, pnBackward, :Return = :WalkedPositions)

		#< @FunctionAlternativeForm

		def WalkEachTimeNItemsForwardNItemsBackward(pnForward, pnBackward)
			return This.WalkNItemsForwardNItemsBackward(pnForward, pnBackward)


		def WalkNStepsForwardNStepsBackward(pnForward, pnBackward)
			return This.WalkNITemsForwardNItemsBackward(pnForward, pnBackward)

		def WalkEachTimeNStepsForwardNStepsBackward(pnForward, pnBackward)
			return This.WalkNITemsForwardNItemsBackward(pnForward, pnBackward)


		def WalkNForwardNBackward(pnForward, pnBackward)
			return This.WalkNITemsForwardNItemsBackward(pnForward, pnBackward)

		def WalkForwardBackward(pnForward, pnBackward)
			return This.WalkNITemsForwardNItemsBackward(pnForward, pnBackward)

		#>

	def WalkNItemsForwardNItemsBackwardXT(pnForward, pnBackward, pReturn)

		# Checking params

		if NOT BothAreNumbers(pnForward, pnBackward)
			StzRaise("Incorrect param type! Both pnForward and pnBackward must be numbers.")
		ok

		if isList(pReturn) and
		   Q(pReturn).IsOneOfTheseNamedParams([ :Return, :AndReturn ])

			pReturn = pReturn[2]
		ok

		if NOT ( isString(pReturn) and

			 Q(pReturn).IsOneOfThese([
				:WalkedPositions, :WalkedItems,
				:LastPosition, :LastWalkedPosition,
				:LastItem, :LastWalkedItem,
				:Default
			]) )

			StzRaise("Incorrect param! pReturn must be a string. Allowed values are " +
				 ":WalkedPositions, :WalkedItems, :LastWalkedPosition, :LastWalkedItem, and :Default." )
		ok

		if pReturn = :Default
			pReturn = :WalkedPositions
		ok

		# Doing the job

		aList = This.List()
		nLen = len(aList)

		if pnForward = pnBackward
			return []
		ok

		if pnBackward > pnForward
			nStart = pnBackward - pnForward + 1
		else
			nStart = 1
		ok

		i = nStart
		anPositions = [ i ]

		while Q(i + pnForward).IsBetween(1, nLen) and
		      Q(i + pnForward - pnBackward).IsBetween(1, nLen)

			i = i + pnForward
			anPositions + i

			i = i - pnBackward
			anPositions + i

		end

		if pReturn = :WalkedItems
			return This.ItemsAt(anPositions)

		but pReturn = :WalkedPositions
			return anPositions

		but pReturn = :LastItem or pReturn = :LastWalkedItem
			return This.ItemAt(len(anPositions))

		but pReturn = :LastPosition or pReturn = :LastWalkedPosition
			return anPositions[len(anPositions)]

		else
			return anPositions
		end
	
		#< @FunctionAlternativeForm

		def WalkEachTimeNItemsForwardNItemsBackwardXT(pnForward, pnBackward, pReturn)
			return This.WalkNItemsForwardNItemsBackwardXT(pnForward, pnBackward, pReturn)


		def WalkNStepsForwardNStepsBackwardXT(pnForward, pnBackward, pReturn)
			return This.WalkNITemsForwardNItemsBackwardXT(pnForward, pnBackward, pReturn)

		def WalkEachTimeNStepsForwardNStepsBackwardXT(pnForward, pnBackward, pReturn)
			return This.WalkNITemsForwardNItemsBackwardXT(pnForward, pnBackward, pReturn)

		def WalkNForwardNBackwardXT(pnForward, pnBackward, pReturn)
			return This.WalkNITemsForwardNItemsBackwardXT(pnForward, pnBackward, pReturn)

		def WalkForwardBackwardXT(pnForward, pnBackward, pReturn)
			return This.WalkNITemsForwardNItemsBackwardXT(pnForward, pnBackward, pReturn)

		#>

	  #------------------------------------------------#
	 #  WALKING N ITEMS FORWARD AND N ITEMS BACKWARD  #
	#------------------------------------------------#

	def WalkNItemsBackwardNItemsForward(pnBackward, pnForward)
		return This.WalkNItemsBackwardNItemsForwardXT(pnBackward, pnForward, :Return = :WalkedPositions)

		#< @FunctionAlternativeForm

		def WalkEachTimeNItemsBackwardNItemsForward(pnForward, pnBackward)
			return This.WalkNItemsBackwardNItemsForward(pnForward, pnBackward)


		def WalkNStepsBackwardNStepsForward(pnForward, pnBackward)
			return This.WalkNItemsBackwardNItemsForward(pnForward, pnBackward)

		def WalkEachTimeNStepsBackwardNStepsForward(pnForward, pnBackward)
			return This.WalkNItemsBackwardNItemsForward(pnForward, pnBackward)


		def WalkNBackwardNForward(pnForward, pnBackward)
			return This.WalkNITemsBackwardNItemsForward(pnForward, pnBackward)

		def WalkBackwardForward(pnForward, pnBackward)
			return This.WalkNItemsBackwardNItemsForward(pnForward, pnBackward)

		#>

	def WalkNItemsBackwardNItemsForwardXT(pnBackward, pnForward, pReturn)

		# Checking params

		if NOT BothAreNumbers(pnBackward, pnForward)
			StzRaise("Incorrect param type! Both pnForward and pnBackward must be numbers.")
		ok

		if isList(pReturn) and
		   Q(pReturn).IsOneOfTheseNamedParams([ :Return, :AndReturn ])

			pReturn = pReturn[2]
		ok

		if NOT ( isString(pReturn) and

			 Q(pReturn).IsOneOfThese([
				:WalkedPositions, :WalkedItems,
				:LastPosition, :LastWalkedPosition,
				:LastItem, :LastWalkedItem,
				:Default
			]) )

			StzRaise("Incorrect param! pReturn must be a string. Allowed values are " +
				 ":WalkedPositions, :WalkedItems, :LastWalkedPosition, :LastWalkedItem, and :Default." )
		ok

		if pReturn = :Default
			pReturn = :WalkedPositions
		ok

		# Doing the job

		aList = This.List()
		nLen = len(aList)

		if pnForward = pnBackward
			return []
		ok

		if pnForward > pnBackward
			nStart = nLen - pnBackward
		else
			nStart = nLen
		ok

		i = nStart
		anPositions = [ nStart ]

		while Q(i - pnBackward).IsBetween(1, nLen) and
		      Q(i - pnBackward + pnForward ).IsBetween(1, nLen)

			i = i - pnBackward
			anPositions + i

			i = i + pnForward
			anPositions + i

		end

		if pReturn = :WalkedItems
			return This.ItemsAt(anPositions)

		but pReturn = :WalkedPositions
			return anPositions

		but pReturn = :LastItem or pReturn = :LastWalkedItem
			return This.ItemAt(len(anPositions))

		but pReturn = :LastPosition or pReturn = :LastWalkedPosition
			return anPositions[len(anPositions)]

		else
			return anPositions
		end

		#< @FunctionAlternativeForm

		def WalkEachTimeNItemsBackwardNItemsForwardXT(pnBackward, pnForward, pReturn)
			return This.WalkNItemsBackwardNItemsForwardXT(pnBackward, pnForward, pReturn)


		def WalkNStepsBackwardNStepsForwardXT(pnBackward, pnForward, pReturn)
			return This.WalkNItemsBackwardNItemsForwardXT(pnBackward, pnForward, pReturn)

		def WalkEachTimeNStepsBackwardNStepsForwardXT(pnBackward, pnForward, pReturn)
			return This.WalkNItemsBackwardNItemsForwardXT(pnBackward, pnForward, pReturn)


		def WalkNBackwardNForwardXT(pnBackward, pnForward, pReturn)
			return This.WalkNITemsBackwardNItemsForwardXT(pnBackward, pnForward, pReturn)

		def WalkBackwardForwardXT(pnBackward, pnForward, pReturn)
			return This.WalkNItemsBackwardNItemsForwardXT(pnBackward, pnForward, pReturn)

		#>

	  #===================================================#
	 #  WALKING N STEPS FROM START AND N STEPS FROM END  #
	#===================================================#

	def WalkNItemsFromStartNItemsFromEnd(nFromStart, nFromEnd)
		return This.WalkNItemsFromStartNItemsFromEndXT(nFromStart, nFromEnd, :Return = :WalkedPositions)

		#< @FunctionAlternativeForm

		def WalkEachTimeNItemsFromStartNItemsFromEnd(pnFromStart, pnFromEnd)
			return This.WalkNItemsFromStartNItemsFromEnd(pnFromStart, pnFromEnd)


		def WalkNStepsFromStartNStepsFromEnd(pnFromStart, pnFromEnd)
			return This.WalkNITemsFromStartNItemsFromEnd(pnFromStart, pnFromEnd)

		def WalkEachTimeNStepsFromStartNStepsFromEnd(pnFromStart, pnFromEnd)
			return This.WalkNITemsFromStartNItemsFromEnd(pnFromStart, pnFromEnd)


		def WalkNFromStartNFromEnd(pnFromStart, pnFromEnd)
			return This.WalkNITemsFromStartNItemsFromEnd(pnFromStart, pnFromEnd)

		def WalkFromStartFromEnd(pnFromStart, pnFromEnd)
			return This.WalkNITemsFromStartNItemsFromEnd(pnFromStart, pnFromEnd)

		def WalkNStartNEnd(pnFromStart, pnFromEnd)
			return This.WalkNITemsFromStartNItemsFromEnd(pnFromStart, pnFromEnd)

		def WalkStartEnd(pnFromStart, pnFromEnd)
			return This.WalkNITemsFromStartNItemsFromEnd(pnFromStart, pnFromEnd)

		#>

	def WalkNItemsFromStartNItemsFromEndXT(pnFromStart, pnFromEnd, pReturn)

		# Checking params

		if NOT BothAreNumbers(pnFromStart, pnFromEnd)
			StzRaise("Incorrect param type! Both pnFromStart and pnFromEnd must be numbers.")
		ok

		if isList(pReturn) and
		   Q(pReturn).IsOneOfTheseNamedParams([ :Return, :AndReturn ])

			pReturn = pReturn[2]
		ok

		if NOT ( isString(pReturn) and

			 Q(pReturn).IsOneOfThese([
				:WalkedPositions, :WalkedItems,
				:LastPosition, :LastWalkedPosition,
				:LastItem, :LastWalkedItem,
				:Default
			]) )

			StzRaise("Incorrect param! pReturn must be a string. Allowed values are " +
				 ":WalkedPositions, :WalkedItems, :LastWalkedPosition, :LastWalkedItem, and :Default." )
		ok

		if pReturn = :Default
			pReturn = :WalkedPositions
		ok

		# Doing the job

		aList = This.List()
		nLen = len(aList)

		anPositions = [ 1 ]

		for i = 1 to nLen
			nPosFromStart = i + pnFromStart
			nPosFromEnd   = nLen - i - pnFromEnd + 1

			if nPosFromEnd >= nPosFromStart
				anPositions + nPosFromStart
				if nPosFromEnd != nPosFromStart
					anPositions + nPosFromEnd
				ok
			ok
		next

		if pReturn = :WalkedItems
			return This.ItemsAt(anPositions)

		but pReturn = :WalkedPositions
			return anPositions

		but pReturn = :LastItem or pReturn = :LastWalkedItem
			return This.ItemAt(len(anPositions))

		but pReturn = :LastPosition or pReturn = :LastWalkedPosition
			return anPositions[len(anPositions)]

		else
			return anPositions
		end
	
		#< @FunctionAlternativeForm

		def WalkEachTimeNItemsFromStartNItemsFromEndXT(pnFromStart, pnFromEnd, pReturn)
			return This.WalkNItemsFromStartNItemsFromEndXT(pnFromStart, pnFromEnd, pReturn)


		def WalkNStepsFromStartNStepsFromEndXT(pnFromStart, pnFromEnd, pReturn)
			return This.WalkNITemsFromStartNItemsFromEndXT(pnFromStart, pnFromEnd, pReturn)

		def WalkEachTimeNStepsFromStartNStepsFromEndXT(pnFromStart, pnFromEnd, pReturn)
			return This.WalkNITemsFromStartNItemsFromEndXT(pnFromStart, pnFromEnd, pReturn)

		def WalkNFromStartNFromEndXT(pnFromStart, pnFromEnd, pReturn)
			return This.WalkNITemsFromStartNItemsFromEndXT(pnFromStart, pnFromEnd, pReturn)

		def WalkFromStartFromEndXT(pnFromStart, pnFromEnd, pReturn)
			return This.WalkNITemsFromStartNItemsFromEndXT(pnFromStart, pnFromEnd, pReturn)

		def WalkNStartNEndXT(pnFromStart, pnFromEnd, pReturn)
			return This.WalkNITemsFromStartNItemsFromEndXT(pnFromStart, pnFromEnd, pReturn)

		def WalkStartEndXT(pnFromStart, pnFromEnd, pReturn)
			return This.WalkNITemsFromStartNItemsFromEndXT(pnFromStart, pnFromEnd, pReturn)

		#>

	  #---------------------------------------------------#
	 #  WALKING N ITEMS FROM END AND N ITEMS FROM START  #
	#---------------------------------------------------#

	def WalkNItemsFromEndNItemsFromStart(pnFromEnd, pnFromStart)
		return This.WalkNItemsFromEndNItemsFromStartXT(pnFromEnd, pnFromStart, :Return = :WalkedPositions)

		#< @FunctionAlternativeForm

		def WalkEachTimeNItemsFromEndNItemsFromStart(pnFromStart, pnFromEnd)
			return This.WalkNItemsFromEndNItemsFromStart(pnFromStart, pnFromEnd)


		def WalkNStepsFromEndNStepsFromStart(pnFromStart, pnFromEnd)
			return This.WalkNItemsFromEndNItemsFromStart(pnFromStart, pnFromEnd)

		def WalkEachTimeNStepsFromEndNStepsFromStart(pnFromStart, pnFromEnd)
			return This.WalkNItemsFromEndNItemsFromStart(pnFromStart, pnFromEnd)


		def WalkNFromEndNFromStart(pnFromStart, pnFromEnd)
			return This.WalkNITemsFromEndNItemsFromStart(pnFromStart, pnFromEnd)

		def WalkFromEndFromStart(pnFromStart, pnFromEnd)
			return This.WalkNItemsFromEndNItemsFromStart(pnFromStart, pnFromEnd)

		def WalkNEndNStart(pnFromStart, pnFromEnd)
			return This.WalkNItemsFromEndNItemsFromStart(pnFromStart, pnFromEnd)

		def WalkEndStart(pnFromStart, pnFromEnd)
			return This.WalkNItemsFromEndNItemsFromStart(pnFromStart, pnFromEnd)

		#>

	def WalkNItemsFromEndNItemsFromStartXT(pnFromEnd, pnFromStart, pReturn)

		# Checking params

		if NOT BothAreNumbers(pnFromEnd, pnFromStart)
			StzRaise("Incorrect param type! Both pnFromStart and pnFromEnd must be numbers.")
		ok

		if isList(pReturn) and
		   Q(pReturn).IsOneOfTheseNamedParams([ :Return, :AndReturn ])

			pReturn = pReturn[2]
		ok

		if NOT ( isString(pReturn) and

			 Q(pReturn).IsOneOfThese([
				:WalkedPositions, :WalkedItems,
				:LastPosition, :LastWalkedPosition,
				:LastItem, :LastWalkedItem,
				:Default
			]) )

			StzRaise("Incorrect param! pReturn must be a string. Allowed values are " +
				 ":WalkedPositions, :WalkedItems, :LastWalkedPosition, :LastWalkedItem, and :Default." )
		ok

		if pReturn = :Default
			pReturn = :WalkedPositions
		ok

		# Doing the job

		aList = This.List()
		nLen = len(aList)

		anPositions = [ 7 ]

		for i = nLen to 1 step -1

			nPosFromEnd   = i - pnFromEnd
			nPosFromStart = nLen - i + 1

			if nPosFromEnd >= nPosFromStart
				anPositions + nPosFromEnd
				
				if nPosFromStart != nPosFromEnd
					anPositions + nPosFromStart
				ok
			ok
		next

		if pReturn = :WalkedItems
			return This.ItemsAt(anPositions)

		but pReturn = :WalkedPositions
			return anPositions

		but pReturn = :LastItem or pReturn = :LastWalkedItem
			return This.ItemAt(len(anPositions))

		but pReturn = :LastPosition or pReturn = :LastWalkedPosition
			return anPositions[len(anPositions)]

		else
			return anPositions
		end

		#< @FunctionAlternativeForm

		def WalkEachTimeNItemsFromEndNItemsFromStartXT(pnFromEnd, pnFromStart, pReturn)
			return This.WalkNItemsFromEndNItemsFromStartXT(pnFromEnd, pnFromStart, pReturn)


		def WalkNStepsFromEndNStepsFromStartXT(pnFromEnd, pnFromStart, pReturn)
			return This.WalkNItemsFromEndNItemsFromStartXT(pnFromEnd, pnFromStart, pReturn)

		def WalkEachTimeNStepsFromEndNStepsFromStartXT(pnFromEnd, pnFromStart, pReturn)
			return This.WalkNItemsFromEndNItemsFromStartXT(pnFromEnd, pnFromStart, pReturn)


		def WalkNFromEndNFromStartXT(pnFromEnd, pnFromStart, pReturn)
			return This.WalkNITemsFromEndNItemsFromStartXT(pnFromEnd, pnFromStart, pReturn)

		def WalkFromEndFromStartXT(pnFromEnd, pnFromStart, pReturn)
			return This.WalkNItemsFromEndNItemsFromStartXT(pnFromEnd, pnFromStart, pReturn)

		def WalkNEndNStartXT(pnFromEnd, pnFromStart, pReturn)
			return This.WalkNItemsFromEndNItemsFromStartXT(pnFromEnd, pnFromStart, pReturn)

		def WalkEndStartXT(pnFromEnd, pnFromStart, pReturn)
			return This.WalkNItemsFromEndNItemsFromStartXT(pnFromEnd, pnFromStart, pReturn)

		#>

	  #===========================================#
	 #   EXPANDING THE LIST OF PAIR OF NUMBERS   #
	#===========================================#

	/* Example
		o1 = new stzList([ 12, 7 ])
		? o1.ExpandedIfPairOfNumbers() #--> [ 12, 11, 10, 9, 8, 7 ]
	*/

	def ExpandIfPairOfNumbers() # TODO: Should be delegated to stzPairOfNumbers
		if This.IsPairOfNumbers()
			n1 = This[1]
			n2 = This[2]

			anResult = n1 : n2

			This.UpdateWith( anResult )
		ok

		def ExpandIfPairOfNumbersQ()
			This.ExpandIfPairOfNumbers()
			return This

	def ExpandedIfPairOfNumbers()
		bResult = This.Copy().ExpandIfPairOfNumbersQ().Content()
		return bResult

	  #========================================================#
	 #   CHECKING IF ALL THE ITEMS VERIFY A GIVEN CONDITION   #
	#========================================================#

	def CheckW(pcCondition)
		#< @MotherFunction = CheckOnPositionsW > @RingBased #>

		/* EXAMPLE

		o1 = new stzList([ "BING", "BINGO", "BINGOO", "BINGOOO", "BINGOOOO" ])
		? o1.CheckW( :That = '{ @NextItem = @item + "O" }' )	#--> TRUE

		*/

		bResult = This.CheckOnPositionsW(1:This.NumberOfItems(), pcCondition)
		return bResult

		#< @FunctionAlternativeForms

		def Check(pcCondition)
			return This.CheckW(pcCondition)

		def Verify(pcCondition)
			return This.CheckW(pcCondition)

		def EachItemVerifyW(pcCondition)
			return This.CheckW(pcCondition)

		def EachItemVerify(pcCondition)
			return This.CheckW(pcCondition)

		def AllItemsVerifyW(pcCondition)
			return This.CheckW(pcCondition)

		def AllItemsVerify(pcCondition)
			return This.CheckW(pcCondition)

		def ItemsVerify(pcCondition)
			return This.CheckW(pcCondition)

		def ItemsVerifyW(pcCondition)
			return This.CheckW(pcCondition)

		#>

	  #-------------------------------------------------------------------#
	 #   CHECKING IF ITEMS AT GIVEN POSITIONS VERIFY A GIVEN CONDITION   #
	#-------------------------------------------------------------------#

	def CheckOnW(panPositions, pcCondition)
		#< @MotherFunction = YES | @RingBased #>

		/* EXAMPLE

		o1 = new stzList([ "Word1", "كلمة 2", "Word3", "كلمة 4", "Word5", "كلمة 6" ])
		? o1.CheckOnW([1, 3, 5], :That = 'Q(@item).IsLeftToRight()' ) #--> TRUE

		*/
		if This.IsEmpty()
			return FALSE
		ok

		if NOT ( isList(panPositions) and Q(panPositions).IsListOfNumbers() )
			StzRaise("Invalid param type! panPositions must be a list of numbers.")
		ok

		if len(panPositions) = 0
			return FALSE
		ok

		if isList(pcCondition) and Q(pcCondition).IsThatOrWhereNamedParam()
			pcCondition = pcCondition[2]
		ok

		if NOT isString(pccondition)
			StzRaise("Incorrect param! pcCondition must be a string.")
		ok

		pcCode = Q(pcCondition).
			 TrimQ().
			 RemoveBoundsQ([ "{", "}" ]).
			 Content()

		cCode = "bOk = ( " + pcCode + " )"
		oCode = StzStringQ(cCode)
		
		nLenPositions = len(panPositions)
		bResult = TRUE

		for n = 1 to nLenPositions
			@i = panPositions[n]
			@item = This[ @i ]
			bEval = TRUE

			if @i = This.NumberOfItems() and
			   oCode.Copy().RemoveSpacesQ().ContainsCS("This[@i+1]", :CS=FALSE)

				bEval = FALSE

			but @i = 1 and
			    oCode.Copy().RemoveSpacesQ().ContainsCS("This[@i-1]", :CS=FALSE)

				bEval = FALSE
			ok

			if bEval

				eval(cCode)

				if bOk = FALSE
					bResult = FALSE
					exit
				ok
			ok

		next

		return bResult

		#< @FunctionAlternativeForms

		def CheckOn(panPositions, pcCondition)
			return This.CheckOnW(panPositions, pcCondition)

		def CheckOnPositionsW(panPositions, pcCondition)
			return This.CheckOnW(panPositions, pcCondition)

		def CheckOnThesePositionsW(panPositions, pcCondition)
			return This.CheckOnW(panPositions, pcCondition)

		def CheckOnPositions(panPositions, pcCondition)
			return This.CheckOnW(panPositions, pcCondition)


		def VerifyOn(panPositions, pcCondition)
			return This.CheckOnW(panPositions, pcCondition)

		def VerifyOnPositionsW(panPositions, pcCondition)
			return This.CheckOnW(panPositions, pcCondition)

		def VerifyOnThesePositionsW(panPositions, pcCondition)
			return This.CheckOnW(panPositions, pcCondition)

		def VerifyOnPositions(panPositions, pcCondition)
			return This.CheckOnW(panPositions, pcCondition)

		#>

	  #------------------------------------------------------------------------------#
	 #   CHECKING IF ITEMS AT GIVEN POSITIONS VERIFY A GIVEN CONDITION -- EXTENDED  #
	#------------------------------------------------------------------------------#

	def CheckOnWXT(panPositions, pcCondition)
		#< @MotherFunction = YES | @RingBased #>

		if This.IsEmpty()
			return FALSE
		ok

		if NOT ( isList(panPositions) and Q(panPositions).IsListOfNumbers() )
			StzRaise("Invalid param type! panPositions must be a list of numbers.")
		ok

		if len(panPositions) = 0
			return FALSE
		ok

		if isList(pcCondition) and Q(pcCondition).IsThatOrWhereNamedParam()
			pcCondition = pcCondition[2]
		ok

		if NOT isString(pccondition)
			StzRaise("Incorrect param! pcCondition must be a string.")
		ok

		oCCode = StzCCodeQ(pcCondition)
		cCode = 'bOk = ( ' + oCCode.TranspiledFor(:stzList) + ' )'
		oCode = StzStringQ(cCode)
		
		nLenPositions = len(panPositions)
		bResult = TRUE

		for n = 1 to nLenPositions
			@i = panPositions[n]
			@item = This[ @i ]
			bEval = TRUE

			if @i = This.NumberOfItems() and
			   oCode.Copy().RemoveSpacesQ().ContainsCS("This[@i+1]", :CS=FALSE)

				bEval = FALSE

			but @i = 1 and
			    oCode.Copy().RemoveSpacesQ().ContainsCS("This[@i-1]", :CS=FALSE)

				bEval = FALSE
			ok

			if bEval

				eval(cCode)

				if bOk = FALSE
					bResult = FALSE
					exit
				ok
			ok

		next

		return bResult

		#< @FunctionAlternativeForms

		def CheckOnXT(panPositions, pcCondition)
			return This.CheckOnWXT(panPositions, pcCondition)

		def CheckOnPositionsWXT(panPositions, pcCondition)
			return This.CheckOnWXT(panPositions, pcCondition)

		def CheckOnThesePositionsWXT(panPositions, pcCondition)
			return This.CheckOnW(panPositions, pcCondition)

		def CheckOnPositionsXT(panPositions, pcCondition)
			return This.CheckOnWXT(panPositions, pcCondition)


		def VerifyOnXT(panPositions, pcCondition)
			return This.CheckOnWXT(panPositions, pcCondition)

		def VerifyOnPositionsWXT(panPositions, pcCondition)
			return This.CheckOnWXT(panPositions, pcCondition)

		def VerifyOnThesePositionsWXT(panPositions, pcCondition)
			return This.CheckOnWXT(panPositions, pcCondition)

		def VerifyOnPositionsXT(panPositions, pcCondition)
			return This.CheckOnWXT(panPositions, pcCondition)

		#>

	  #------------------------------------------------------------------#
	 #   CHECKING IF ITEMS AT GIVEN SECTIONS VERIFY A GIVEN CONDITION   #
	#------------------------------------------------------------------#

	def CheckOnSectionsW(paSections, pcCondition)
		#< @MotherFunction = CheckOnPositionsW > @RingBased #>


		# Checking correctness of paSections param

		if NOT ( isList(paSections) and
			 Q(paSections).IsListOfPairsOfNumbers() )

			StzRaise("Incorrect param! paSections must be a list of pairs of numbers.")
		ok

		if len(paSections) = 0
			return FALSE
		ok

		# Getting all the positions from the provided sections
		# Example: [ [2,5], [7,9 ] --> [ 2, 3, 4, 5, 7, 8, 9 ]

		aSectionsExpanded = []
		for aPair in paSections
			aSectionsExpanded + StzListQ(aPair).ExpandedIfPairOfNumbers()
		next

		anPositionsMerged = ListsMerge( aSectionsExpanded )

		anPositions = StzListQ(anPositionsMerged).ToSet()

		bResult = This.CheckOnW(anPositions, pcCondition)
		return bResult

		#< @FunctionAlternativeForm

		def CheckOnSections(paSections, pcCondition)
			return This.CheckOnSectionsW(paSections, pcCondition)

		def CheckOnTheseSectionsW(paSections, pcCondition)
			return This.CheckOnSectionsW(paSections, pcCondition)

		def CheckOnTheseSections(paSections, pcCondition)
			return This.CheckOnSectionsW(paSections, pcCondition)

		def VerifyOnSections(paSections, pcCondition)
			return This.CheckOnSectionsW(paSections, pcCondition)

		def VerifyOnTheseSectionsW(paSections, pcCondition)
			return This.CheckOnSectionsW(paSections, pcCondition)

		def VerifyOnTheseSections(paSections, pcCondition)
			return This.CheckOnSectionsW(paSections, pcCondition)

		#>

	  #----------------------------------------------------------------------------#
	 #  CHECKING IF ITEMS AT GIVEN SECTIONS VERIFY A GIVEN CONDITION -- EXTENDED  #
	#----------------------------------------------------------------------------#

	def CheckOnSectionsWXT(paSections, pcCondition)
		#< @MotherFunction = CheckOnPositionsW > @RingBased #>


		# Checking correctness of paSections param

		if NOT ( isList(paSections) and
			 Q(paSections).IsListOfPairsOfNumbers() )

			StzRaise("Incorrect param! paSections must be a list of pairs of numbers.")
		ok

		if len(paSections) = 0
			return FALSE
		ok

		# Getting all the positions from the provided sections
		# Example: [ [2,5], [7,9 ] --> [ 2, 3, 4, 5, 7, 8, 9 ]

		aSectionsExpanded = []
		for aPair in paSections
			aSectionsExpanded + StzListQ(aPair).ExpandedIfPairOfNumbers()
		next

		anPositionsMerged = ListsMerge( aSectionsExpanded )

		anPositions = StzListQ(anPositionsMerged).ToSet()

		bResult = This.CheckOnWXT(anPositions, pcCondition)
		return bResult

		#< @FunctionAlternativeForm

		def CheckOnSectionsXT(paSections, pcCondition)
			return This.CheckOnSectionsWXT(paSections, pcCondition)

		def CheckOnTheseSectionsWXT(paSections, pcCondition)
			return This.CheckOnSectionsWXT(paSections, pcCondition)

		def CheckOnTheseSectionsXT(paSections, pcCondition)
			return This.CheckOnSectionsWXT(paSections, pcCondition)

		def VerifyOnSectionsXT(paSections, pcCondition)
			return This.CheckOnSectionsWXT(paSections, pcCondition)

		def VerifyOnTheseSectionsWXT(paSections, pcCondition)
			return This.CheckOnSectionsWXT(paSections, pcCondition)

		def VerifyOnTheseSectionsXT(paSections, pcCondition)
			return This.CheckOnSectionsWXT(paSections, pcCondition)

		#>

	  #=========================================#
	 #   YIELDING INFORMATION FROM EACH ITEM   #
	#=========================================#

	/* NOTE:

	This function is more performant then its extended version
	YieldXT(), that it relies on the user to provide it
	with a correct formed condition containing only @i, @item,
	and @list keywords.

	All other keywords should be expressed using the @i keyword.

	For example, @CurrentItem should be expressed using simply This[@i],
	@PreviousItem should be expressed using This[@-1] and so on...

	*/

	def Yield(pcCode)
		aSection = StzCCodeQ(pcCode).ExecutableSection()
		n1 = aSection[1]
		n2 = aSection[2] + 1
		if n2 < 0
			n2 += This.NumberOfItems()
		ok

		return This.YieldFrom( n1 : n2, pcCode )

		#< @FunctionFluentForm

		def YieldQ(pcCode)
			return This.YieldQR(pcCode, :stzList)
	
		def YieldQR(pcCode, pcReturnType)
			if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.Yield(pcCode) )
	
			on :stzListOfStrings
				return new stzListOfStrings( This.Yield(pcCode) )
				
			on :stzListOfNumbers
				return new stzListOfNumbers( This.Yield(pcCode) )

			on :stzHashList
				return new stzHashList( This.Yield(pcCode) )

			on :stzListOfLists
				return new stzListOfLists( This.Yield(pcCode) )
		
		other
				StzRaise("Unsupported return type!")
		off

		#>

		#< @FunctionAlternativeForms

		def YieldFromEachItem(pcCode)
			return This.Yield(pcCode)

			def YieldFromEachItemQ(pcCode)
				return This.YieldFromEachItemQR(pcCode, :stzList)
		
			def YieldFromEachItemQR(pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok
	
				switch pcReturnType
				on :stzList
					return new stzList( This.YieldFromEachItem(pcCode) )
		
				on :stzListOfStrings
					return new stzListOfStrings( This.YieldFromEachItem(pcCode) )
					
				on :stzListOfNumbers
					return new stzListOfNumbers( This.YieldFromEachItem(pcCode) )
	
				on :stzHashList
					return new stzHashList( This.YieldFromEachItem(pcCode) )
			
			other
					StzRaise("Unsupported return type!")
			off

		def Harvest(pcCode)
			return This.Yield(pcCode)

			def HervestQ(pcCode)
				return This.YieldFromEachItemQR(pcCode, :stzList)
		
			def HarvestQR(pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok
	
				switch pcReturnType
				on :stzList
					return new stzList( This.Harvest(pcCode) )
		
				on :stzListOfStrings
					return new stzListOfStrings( This.Harvest(pcCode) )
					
				on :stzListOfNumbers
					return new stzListOfNumbers( This.Harvest(pcCode) )
	
				on :stzHashList
					return new stzHashList( This.Harvest(pcCode) )
			
			other
					StzRaise("Unsupported return type!")
			off

		def HarvestFromEachItem(pcCode)
			return This.Yield(pcCode)

			def HarvestFromEachItemQ(pcCode)
				return This.HarvestFromEachItemQR(pcCode, :stzList)
		
			def HarvestFromEachItemQR(pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok
	
				switch pcReturnType
				on :stzList
					return new stzList( This.HarvestFromEachItem(pcCode) )
		
				on :stzListOfStrings
					return new stzListOfStrings( This.HarvestFromEachItem(pcCode) )
					
				on :stzListOfNumbers
					return new stzListOfNumbers( This.HarvestFromEachItem(pcCode) )
	
				on :stzHashList
					return new stzHashList( This.HarvestFromEachItem(pcCode) )
			
			other
					StzRaise("Unsupported return type!")
			off
		#>

		#< @FunctionMisspelledForm

		def Yiled(pcCode)
			return This.Yield(pcCode)

		#>

	  #----------------------------------------------------#
 	 #   YIELDING INFORMATION FROM EACH ITEM -- EXTENDED  #
	#----------------------------------------------------#

	/* NOTE

	This function is less performan then it's simplest form Yield(),
	because it takes time to analyze the conditional code provided,
	spacify it, transile it for :stzList, so a keyword like @PrecedentItem
	for example, can be used, and the function will transpile it to
	"This[@i-1]" automatically.

	If performance is critical to you, don't use it.

	*/

	def YieldXT(pcCode)

		return This.YieldFromXT( 1:This.NumberOfItems(), pcCode )

		#< @FunctionFluentForm

		def YieldXTQ(pcCode)
			return This.YieldXTQR(pcCode, :stzList)
	
		def YieldXTQR(pcCode, pcReturnType)
			if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.YieldXT(pcCode) )
	
			on :stzListOfStrings
				return new stzListOfStrings( This.YieldXT(pcCode) )
				
			on :stzListOfNumbers
				return new stzListOfNumbers( This.YieldXT(pcCode) )

			on :stzHashList
				return new stzHashList( This.YieldXT(pcCode) )

			on :stzListOfLists
				return new stzListOfLists( This.YieldXT(pcCode) )
		
		other
				StzRaise("Unsupported return type!")
		off

		#>

		#< @FunctionAlternativeForms

		def YieldFromEachItemXT(pcCode)
			return This.YieldXT(pcCode)

			def YieldFromEachItemXTQ(pcCode)
				return This.YieldFromEachItemXTQR(pcCode, :stzList)
		
			def YieldFromEachItemXTQR(pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok
	
				switch pcReturnType
				on :stzList
					return new stzList( This.YieldFromEachItemXT(pcCode) )
		
				on :stzListOfStrings
					return new stzListOfStrings( This.YieldFromEachItemXT(pcCode) )
					
				on :stzListOfNumbers
					return new stzListOfNumbers( This.YieldFromEachItemXT(pcCode) )
	
				on :stzHashList
					return new stzHashList( This.YieldFromEachItemXT(pcCode) )
			
			other
					StzRaise("Unsupported return type!")
			off

		def HarvestXT(pcCode)
			return This.YieldXT(pcCode)

			def HervestXTQ(pcCode)
				return This.YieldFromEachItemXTQR(pcCode, :stzList)
		
			def HarvestXTQR(pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok
	
				switch pcReturnType
				on :stzList
					return new stzList( This.HarvestXT(pcCode) )
		
				on :stzListOfStrings
					return new stzListOfStrings( This.HarvestXT(pcCode) )
					
				on :stzListOfNumbers
					return new stzListOfNumbers( This.HarvestXT(pcCode) )
	
				on :stzHashList
					return new stzHashList( This.HarvestXT(pcCode) )
			
			other
					StzRaise("Unsupported return type!")
			off

		def HarvestFromEachItemXT(pcCode)
			return This.YieldXT(pcCode)

			def HarvestFromEachItemXTQ(pcCode)
				return This.HarvestFromEachItemXTQR(pcCode, :stzList)
		
			def HarvestFromEachItemXTQR(pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok
	
				switch pcReturnType
				on :stzList
					return new stzList( This.HarvestFromEachItemXT(pcCode) )
		
				on :stzListOfStrings
					return new stzListOfStrings( This.HarvestFromEachItemXT(pcCode) )
					
				on :stzListOfNumbers
					return new stzListOfNumbers( This.HarvestFromEachItemXT(pcCode) )
	
				on :stzHashList
					return new stzHashList( This.HarvestFromEachItemXT(pcCode) )
			
			other
					StzRaise("Unsupported return type!")
			off
		#>

		#< @FunctionMisspelledForm

		def YiledXT(pcCode)
			return This.YieldXT(pcCode)

		#>

	  #========================================================#
	 #   YIELDING INFORMATION FROM ITEMS AT GIVEN POSITIONS   #
	#========================================================#

	/* NOTE:
		This function is more performant then its extended version
		YieldFromXT(), that it relies on the user to provide it
		with a correct formed condition containing only @i, @item,
		and @list keywords.

		All other keywords should be expressed using the @i keyword.

		For example, @CurrentItem should be expressed using simply This[@i],
		@PreviousItem should be expressed using This[@-1] and so on...
	*/

	def YieldFrom(panPositions, pcCode)

		#< @MotherFunction #>

		if NOT ( isList(panPositions) and Q(panPositions).IsListOfNumbers() )
			StzRaise("Incorrect param! paPositions must be a list of numbers.")
		ok

		if len(panPositions) = 0
			return []
		ok

		panPositions = ring_sort(panPositions)
		nLenPositions = len(panPositions)

		if NOT isString(pcCode)
			StzRaise("Invalid param type! Condition must be a string.")
		ok

		if StzStringQ(pcCode).WithoutSpaces() = 0
			aTemp = []
			
			for i = 1 to nLenPositions
				aTemp + NULL
			next

			return aTemp
		ok

		pcCode = Q(pcCode).
			 TrimQ().
			 RemoveBoundsQ([ "{", "}" ]).
			 ReplaceCSQ("@list", "This.Content()", :CS = FALSE).
			 Content()

		cCode = "aResult + ( " + pcCode + " )"
		oCode = StzStringQ(cCode)
		
		aResult = []
		nLenList = This.NumberOfItems()

		for i = 1 to nLenPositions
			@i = panPositions[i]
			@item = This[ @i ]

			bEval = TRUE

			oCodeWS = Q( oCode.WithoutSpaces() )
			bContainsIPlus1  = oCodeWS.ContainsCS( "This[@i+1]", :CS=FALSE )
			bContainsIMinus1 = oCodeWS.ContainsCS( "This[@i-1]", :CS=FALSE )

			if @i = nLenList and bContainsIPlus1
				bEval = FALSE

			but @i = 1 and bContainsIMinus1
				bEval = FALSE
			
			ok

			if bEval

				eval(cCode) # Populates aResult with the yielded information

			ok

		next

		return aResult


		#< @FunctionFluentForm

		def YieldFromQ(paPositions, pcCode)
			return This.YieldFromQR(paPositions, pcCode, :stzList)
	
		def YieldFromQR(paPositions, pcCode, pcReturnType)
			if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.YieldFrom(paPositions, pcCode) )
	
			on :stzListOfStrings
				return new stzListOfStrings( This.YieldFrom(paPositions, pcCode) )
				
			on :stzListOfNumbers
				return new stzListOfNumbers( This.YieldFrom(paPositions, pcCode) )
		
			other
				StzRaise("Unsupported return type!")
			off

		#>

		#< @FunctionAlternativeForms

		def YieldFromPositions(panPositions, pcCode)
			return This.YieldFrom(panPositions, pcCode)

			def YieldFromPositionsQ(paPositions, pcCode)
				return This.YieldFromPositionsQR(paPositions, pcCode, :stzList)
		
			def YieldFromPositionsQR(paPositions, pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok
	
				switch pcReturnType
				on :stzList
					return new stzList( This.YieldFromPositions(paPositions, pcCode) )
		
				on :stzListOfStrings
					return new stzListOfStrings( This.YieldFromPositions(paPositions, pcCode) )
					
				on :stzListOfNumbers
					return new stzListOfNumbers( This.YieldFromPositions(paPositions, pcCode) )
	
				other
					StzRaise("Unsupported return type!")
				off

		def YieldFromItemsAt(panPositions, pcCode)
			return This.YieldFrom(panPositions, pcCode)

			def YieldFromItemsAtQ(paPositions, pcCode)
				return This.YieldFromItemsAtQR(paPositions, pcCode, :stzList)
		
			def YieldFromItemsAtQR(paPositions, pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok
	
				switch pcReturnType
				on :stzList
					return new stzList( This.YieldFromItemsAt(paPositions, pcCode) )
		
				on :stzListOfStrings
					return new stzListOfStrings( This.YieldFromItemsAt(paPositions, pcCode) )
					
				on :stzListOfNumbers
					return new stzListOfNumbers( This.YieldFromItemsAt(paPositions, pcCode) )
	
				other
					StzRaise("Unsupported return type!")
				off

		def YieldFromItemsAtPositions(panPositions, pcCode)
			return This.YieldOn(panPositions, pcCode)

			def YieldFromItemsAtPositionsQ(paPositions, pcCode)
				return This.YieldFromItemsAtPositionsQR(paPositions, pcCode, :stzList)
		
			def YieldFromItemsAtPositionsQR(paPositions, pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok
	
				switch pcReturnType
				on :stzList
					return new stzList( This.YieldFromItemsAtPositions(paPositions, pcCode) )
		
				on :stzListOfStrings
					return new stzListOfStrings( This.YieldFromItemsAtPositions(paPositions, pcCode) )
					
				on :stzListOfNumbers
					return new stzListOfNumbers( This.YieldFromItemsAtPositions(paPositions, pcCode) )
	
				on :stzHashList
					return new stzHashList( This.YieldFromItemsAtPositions(paPositions, pcCode) )
			
			other
					StzRaise("Unsupported return type!")
			off

		def HarvestFrom(panPositions, pcCode)
			return This.HarvestFrom(panPositions, pcCode)

			def HarvestFromQ(paPositions, pcCode)
				return This.HarvestFromQR(paPositions, pcCode, :stzList)
		
			def HarvestFromQR(paPositions, pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok
	
				switch pcReturnType
				on :stzList
					return new stzList( This.HarvestFrom(paPositions, pcCode) )
		
				on :stzListOfStrings
					return new stzListOfStrings( This.HarvestFrom(paPositions, pcCode) )
					
				on :stzListOfNumbers
					return new stzListOfNumbers( This.HarvestFrom(paPositions, pcCode) )
	
				other
					StzRaise("Unsupported return type!")
				off

		def HarvestFromPositions(panPositions, pcCode)
			return This.HarvestFrom(panPositions, pcCode)

			def HarvestFromPositionsQ(paPositions, pcCode)
				return This.HarvestFromPositionsQR(paPositions, pcCode, :stzList)
		
			def HarvestFromPositionsQR(paPositions, pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok
	
				switch pcReturnType
				on :stzList
					return new stzList( This.HarvestFromPositions(paPositions, pcCode) )
		
				on :stzListOfStrings
					return new stzListOfStrings( This.HarvestFromPositions(paPositions, pcCode) )
					
				on :stzListOfNumbers
					return new stzListOfNumbers( This.HarvestFromPositions(paPositions, pcCode) )
	
				other
					StzRaise("Unsupported return type!")
				off

		def HarvestFromItemsAt(panPositions, pcCode)
			return This.HarvestFrom(panPositions, pcCode)

			def HarvestFromItemsAtQ(paPositions, pcCode)
				return This.HarvestFromItemsAtQR(paPositions, pcCode, :stzList)
		
			def HarvestFromItemsAtQR(paPositions, pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok
	
				switch pcReturnType
				on :stzList
					return new stzList( This.HarvestFromItemsAt(paPositions, pcCode) )
		
				on :stzListOfStrings
					return new stzListOfStrings( This.HarvestFromItemsAt(paPositions, pcCode) )
					
				on :stzListOfNumbers
					return new stzListOfNumbers( This.HarvestFromItemsAt(paPositions, pcCode) )
	
				other
					StzRaise("Unsupported return type!")
				off

		def HarvestFromItemsAtPositions(panPositions, pcCode)
			return This.HarvestOn(panPositions, pcCode)

			def HarvestFromItemsAtPositionsQ(paPositions, pcCode)
				return This.HarvestFromItemsAtPositionsQR(paPositions, pcCode, :stzList)
		
			def HarvestFromItemsAtPositionsQR(paPositions, pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok
	
				switch pcReturnType
				on :stzList
					return new stzList( This.HarvestFromItemsAtPositions(paPositions, pcCode) )
		
				on :stzListOfStrings
					return new stzListOfStrings( This.HarvestFromItemsAtPositions(paPositions, pcCode) )
					
				on :stzListOfNumbers
					return new stzListOfNumbers( This.HarvestFromItemsAtPositions(paPositions, pcCode) )
	
				other
					StzRaise("Unsupported return type!")
				off
		#>

		#< @FunctionMisspelledForm

		def YiledFrom(paPostions, pcCode)
			return This.YieldFrom(paPositons, pcCode)

		#>

	  #---------------------------------------------------------#
	 #  YIELDING INFORMATION FROM GIVEN POSITIONS -- EXTENDED  #
	#---------------------------------------------------------#

	/* NOTE

	This function is less performan then it's simplest form YieldFrom(),
	because it takes time to analyze the conditional code provided, spacify it,
	transile it for :stzList, so a keyword like @PrecedentItem for example, can
	be used, and the function will transpile it to "This[@i-1]" automatically.

	If performance is critical, don't use it.

	*/

	def YieldFromXT(panPositions, pcCode)
		if NOT ( isList(panPositions) and Q(panPositions).IsListOfNumbers() )
			StzRaise("Incorrect param! paPositions must be a list of numbers.")
		ok

		if len(panPositions) = 0
			return []
		ok

		panPositions = ring_sort(panPositions)
		nLenPositions = len(panPositions)

		if NOT isString(pcCode)
			StzRaise("Invalid param type! Condition must be a string.")
		ok

		if StzStringQ(pcCode).WithoutSpaces() = 0
			aTemp = []
			
			for i = 1 to nLenPositions
				aTemp + NULL
			next

			return aTemp
		ok

		pcCode = StzCCodeQ(pcCode).TranspiledFor(:stzList)

		cCode = "aResult + ( " + pcCode + " )"
		oCode = StzStringQ(cCode)
		
		aResult = []
		nLenList = This.NumberOfItems()

		for i = 1 to nLenPositions
			@i = panPositions[i]
			@item = This[ @i ]

			bEval = TRUE

			oCodeWS = Q( oCode.WithoutSpaces() )
			bContainsIPlus1  = oCodeWS.ContainsCS( "This[@i+1]", :CS=FALSE )
			bContainsIMinus1 = oCodeWS.ContainsCS( "This[@i-1]", :CS=FALSE )

			if @i = nLenList and bContainsIPlus1
				bEval = FALSE

			but @i = 1 and bContainsIMinus1
				bEval = FALSE
			
			ok

			if bEval

				eval(cCode) # Populates aResult with the yielded information

			ok

		next

		return aResult

		#< @FunctionFluentForm

		def YieldFromXTQ(paPositions, pcCode)
			return This.YieldFromXTQR(paPositions, pcCode, :stzList)
	
		def YieldFromXTQR(paPositions, pcCode, pcReturnType)
			if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.YieldFromXT(paPositions, pcCode) )
	
			on :stzListOfStrings
				return new stzListOfStrings( This.YieldFromXT(paPositions, pcCode) )
				
			on :stzListOfNumbers
				return new stzListOfNumbers( This.YieldFromXT(paPositions, pcCode) )
		
			other
				StzRaise("Unsupported return type!")
			off

		#>

		#< @FunctionAlternativeForms

		def YieldFromPositionsXT(panPositions, pcCode)
			return This.YieldFromXT(panPositions, pcCode)

			def YieldFromPositionsXTQ(paPositions, pcCode)
				return This.YieldFromPositionsXTQR(paPositions, pcCode, :stzList)
		
			def YieldFromPositionsXTQR(paPositions, pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok
	
				switch pcReturnType
				on :stzList
					return new stzList( This.YieldFromPositionsXT(paPositions, pcCode) )
		
				on :stzListOfStrings
					return new stzListOfStrings( This.YieldFromPositionsXT(paPositions, pcCode) )
					
				on :stzListOfNumbers
					return new stzListOfNumbers( This.YieldFromPositionsXT(paPositions, pcCode) )
	
				other
					StzRaise("Unsupported return type!")
				off

		def YieldFromItemsAtXT(panPositions, pcCode)
			return This.YieldFromXT(panPositions, pcCode)

			def YieldFromItemsAtXTQ(paPositions, pcCode)
				return This.YieldFromItemsAtXTQR(paPositions, pcCode, :stzList)
		
			def YieldFromItemsAtXTQR(paPositions, pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok
	
				switch pcReturnType
				on :stzList
					return new stzList( This.YieldFromItemsAtXT(paPositions, pcCode) )
		
				on :stzListOfStrings
					return new stzListOfStrings( This.YieldFromItemsAtXT(paPositions, pcCode) )
					
				on :stzListOfNumbers
					return new stzListOfNumbers( This.YieldFromItemsAtXT(paPositions, pcCode) )
	
				other
					StzRaise("Unsupported return type!")
				off

		def YieldFromItemsAtPositionsXT(panPositions, pcCode)
			return This.YieldOnXT(panPositions, pcCode)

			def YieldFromItemsAtPositionsXTQ(paPositions, pcCode)
				return This.YieldFromItemsAtPositionsXTQR(paPositions, pcCode, :stzList)
		
			def YieldFromItemsAtPositionsXTQR(paPositions, pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok
	
				switch pcReturnType
				on :stzList
					return new stzList( This.YieldFromItemsAtPositionsXT(paPositions, pcCode) )
		
				on :stzListOfStrings
					return new stzListOfStrings( This.YieldFromItemsAtPositionsXT(paPositions, pcCode) )
					
				on :stzListOfNumbers
					return new stzListOfNumbers( This.YieldFromItemsAtPositionsXT(paPositions, pcCode) )
	
				on :stzHashList
					return new stzHashList( This.YieldFromItemsAtPositionsXT(paPositions, pcCode) )
			
			other
					StzRaise("Unsupported return type!")
			off

		def HarvestFromXT(panPositions, pcCode)
			return This.HarvestFromXT(panPositions, pcCode)

			def HarvestFromXTQ(paPositions, pcCode)
				return This.HarvestFromXTQR(paPositions, pcCode, :stzList)
		
			def HarvestFromXTQR(paPositions, pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok
	
				switch pcReturnType
				on :stzList
					return new stzList( This.HarvestFromXT(paPositions, pcCode) )
		
				on :stzListOfStrings
					return new stzListOfStrings( This.HarvestFromXT(paPositions, pcCode) )
					
				on :stzListOfNumbers
					return new stzListOfNumbers( This.HarvestFromXT(paPositions, pcCode) )
	
				other
					StzRaise("Unsupported return type!")
				off

		def HarvestFromPositionsXT(panPositions, pcCode)
			return This.HarvestFromXT(panPositions, pcCode)

			def HarvestFromPositionsXTQ(paPositions, pcCode)
				return This.HarvestFromPositionsXTQR(paPositions, pcCode, :stzList)
		
			def HarvestFromPositionsXTQR(paPositions, pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok
	
				switch pcReturnType
				on :stzList
					return new stzList( This.HarvestFromPositionsXT(paPositions, pcCode) )
		
				on :stzListOfStrings
					return new stzListOfStrings( This.HarvestFromPositionsXT(paPositions, pcCode) )
					
				on :stzListOfNumbers
					return new stzListOfNumbers( This.HarvestFromPositionsXT(paPositions, pcCode) )
	
				other
					StzRaise("Unsupported return type!")
				off

		def HarvestFromItemsAtXT(panPositions, pcCode)
			return This.HarvestFromXT(panPositions, pcCode)

			def HarvestFromItemsAtXTQ(paPositions, pcCode)
				return This.HarvestFromItemsAtXTQR(paPositions, pcCode, :stzList)
		
			def HarvestFromItemsAtXTQR(paPositions, pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok
	
				switch pcReturnType
				on :stzList
					return new stzList( This.HarvestFromItemsAtXT(paPositions, pcCode) )
		
				on :stzListOfStrings
					return new stzListOfStrings( This.HarvestFromItemsAtXT(paPositions, pcCode) )
					
				on :stzListOfNumbers
					return new stzListOfNumbers( This.HarvestFromItemsAtXT(paPositions, pcCode) )
	
				other
					StzRaise("Unsupported return type!")
				off

		def HarvestFromItemsAtPositionsXT(panPositions, pcCode)
			return This.HarvestOnXT(panPositions, pcCode)

			def HarvestFromItemsAtPositionsXTQ(paPositions, pcCode)
				return This.HarvestFromItemsAtPositionsXTQR(paPositions, pcCode, :stzList)
		
			def HarvestFromItemsAtPositionsXTQR(paPositions, pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok
	
				switch pcReturnType
				on :stzList
					return new stzList( This.HarvestFromItemsAtPositionsXT(paPositions, pcCode) )
		
				on :stzListOfStrings
					return new stzListOfStrings( This.HarvestFromItemsAtPositionsXT(paPositions, pcCode) )
					
				on :stzListOfNumbers
					return new stzListOfNumbers( This.HarvestFromItemsAtPositionsXT(paPositions, pcCode) )
	
				other
					StzRaise("Unsupported return type!")
				off
		#>

		#< @FunctionMisspelledForm

		def YiledFromXT(paPostions, pcCode)
			return This.YieldFromXT(paPositons, pcCode)

		#>

	  #======================================================#
	 #   YIELDING INFORMATION ON ITEMS IN GIVEN SECTIONS    #
	#======================================================#

	def YieldFromSections(paSections, pcCode)
		if NOT ( isList(paSections) and Q(paSections).IsListOfPairsOfNumbers() )
			StzRaise("Incorrect param! paSections must be a list of pairs of numbers.")
		ok

		# Getting all the positions from the provided sections
		# Example: [ [2,5], [7,9 ] ] --> [ 2, 3, 4, 5, 7, 8, 9 ]

		anSectionsExpanded = StzListQ(paSections).PerformQ('{
			@item = Q(@item).ExpandedIfPairOfNumbers()
		}').Content()
	
		anPositions = ListsMergeQ( anSectionsExpanded ).DuplicatesRemoved()

		return This.YieldFrom(anPositions, pcCode)

		#< @FunctionFluentForm

		def YieldFromSectionsQ(paSections, pcCode)
			return This.YieldFromSectionsQR(paPositions, pcCode, :stzList)
	
		def YieldFromSectionsQR(paPositions, pcCode, pcReturnType)
			if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.YieldFromSections(paPositions, pcCode) )
	
			on :stzListOfStrings
				return new stzListOfStrings( This.YieldFromSections(paPositions, pcCode) )
				
			on :stzListOfNumbers
				return new stzListOfNumbers( This.YieldFromSections(paPositions, pcCode) )
		
			other
				StzRaise("Unsupported return type!")
			off			

		#>

		#< @FunctionAlternativeForms

		def HarvestFromSections(paSections, pcCode)
			return This.YieldFromSections(paSections, pcCode)

			def HarvestFromSectionsQ(paSections, pcCode)
				return This.HarvestFromSectionsQR(paSections, pcCode, :stzList)

			def HarvestFromSectionsQR(paSections, pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsReturnedTypeNamedParam()
					pcReturnType = pcReturnType[2]
				ok
	
				if NOT isString(pcReturnType)
					StzRaise("Incorrect param! pcReturnType must be a string.")
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.HarvestFromSections(paSections, pcCode) )

				on :stzListOfLists
					return new stzListOfLists( This.HarvestFromSections(paSections, pcCode) )
	
				other
					StzRaise("Unsupported param type!")
				off
	
		def YieldSections(paSections, pcCode)
			return This.YieldFromSections(paSections, pcCode)

			def YieldSectionsQ(paSections, pcCode)
				return This.YieldSectionsQR(paSections, pcCode, :stzList)

			def YieldSectionsQR(paSections, pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsReturnedTypeNamedParam()
					pcReturnType = pcReturnType[2]
				ok
	
				if NOT isString(pcReturnType)
					StzRaise("Incorrect param! pcReturnType must be a string.")
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.YieldSections(paSections, pcCode) )

				on :stzListOfLists
					return new stzListOfLists( This.YieldSections(paSections, pcCode) )
	
				other
					StzRaise("Unsupported param type!")
				off

		def HarvestSections(paSections, pcCode)
			return This.YieldFromSections(paSections, pcCode)

			def HarvestSectionsQ(paSections, pcCode)
				return This.HarvestSectionsQR(paSections, pcCode, :stzList)

			def HarvestSectionsQR(paSections, pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsReturnedTypeNamedParam()
					pcReturnType = pcReturnType[2]
				ok
	
				if NOT isString(pcReturnType)
					StzRaise("Incorrect param! pcReturnType must be a string.")
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.HarvestSections(paSections, pcCode) )

				on :stzListOfLists
					return new stzListOfLists( This.HarvestSections(paSections, pcCode) )
	
				other
					StzRaise("Unsupported param type!")
				off
		#>

	def YieldFromSectionsOneByOne(paSections, pcCode)
		if NOT ( isList(paSections) and Q(paSections).IsListOfPairsOfNumbers() )
			StzRaise("Incorrect param! paSections must be a list of pairs of numbers.")
		ok

		aResult = []

		anSectionsExpanded = []
		for aSection in paSections
			anSectionsExpanded + Q(aSection).ExpandedIfPairOfNumbers()
		next

		for anPositions in anSectionsExpanded
			aResult + This.YieldFromPositions(anPositions, pcCode)
		next

		return aResult

		#< @FunctionFluentForm

		def YieldFromSectionsOneByOneQ(paSections, pcCode)
			return This.YieldFromSectionsOneByOneQR(paSections, pcCode, :stzList)

		def YieldFromSectionsOneByOneQR(paSections, pcCode, pcReturnType)
			if isList(pcReturnType) and Q(pcReturnType).IsReturnedTypeNamedParam()
				pcReturnType = pcReturnType[2]
			ok

			if NOT isString(pcReturnType)
				StzRaise("Incorrect param! pcReturnType must be a string.")
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.YieldFromSectionsOneByOneQ(paSections, pcCode) )

			on :stzListOfLists
				return new stzListOfLists( This.YieldFromSectionsOneByOneQ(paSections, pcCode) )

			other
				StzRaise("Unsupported param type!")
			off

		#>

		#< @FunctionAlternativeForms

		def HarvestFromSectionsOneByOne(paSections, pcCode)
			return This.YieldFromSections(paSections, pcCode)

			def HarvestFromSectionsOneByOneQ(paSections, pcCode)
				return This.HarvestFromSectionsOneByOneQR(paSections, pcCode, :stzList)

			def HarvestFromSectionsOneByOneQR(paSections, pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsReturnedTypeNamedParam()
					pcReturnType = pcReturnType[2]
				ok
	
				if NOT isString(pcReturnType)
					StzRaise("Incorrect param! pcReturnType must be a string.")
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.HarvestFromSectionsOneByOne(paSections, pcCode) )

				on :stzListOfLists
					return new stzListOfLists( This.HarvestFromSectionsOneByOne(paSections, pcCode) )
	
				other
					StzRaise("Unsupported param type!")
				off
				
		def HarvestSectionsOneByOne(paSections, pcCode)
			return This.YieldFromSections(paSections, pcCode)

			def HarvestSectionsOneByOneQ(paSections, pcCode)
				return This.HarvestSectionsOneByOneQR(paSections, pcCode, :stzList)

			def HarvestSectionsOneByOneQR(paSections, pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsReturnedTypeNamedParam()
					pcReturnType = pcReturnType[2]
				ok
	
				if NOT isString(pcReturnType)
					StzRaise("Incorrect param! pcReturnType must be a string.")
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.HarvestSectionsOneByOne(paSections, pcCode) )

				on :stzListOfLists
					return new stzListOfLists( This.HarvestSectionsOneByOne(paSections, pcCode) )
	
				other
					StzRaise("Unsupported param type!")
				off

		def YieldSectionsOneByOne(paSections, pcCode)
			return This.YieldFromSections(paSections, pcCode)

			def YieldSectionsOneByOneQ(paSections, pcCode)
				return This.YieldSectionsOneByOneQR(paSections, pcCode, :stzList)

			def YieldSectionsOneByOneQR(paSections, pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsReturnedTypeNamedParam()
					pcReturnType = pcReturnType[2]
				ok
	
				if NOT isString(pcReturnType)
					StzRaise("Incorrect param! pcReturnType must be a string.")
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.YieldSectionsOneByOne(paSections, pcCode) )

				on :stzListOfLists
					return new stzListOfLists( This.YieldSectionsOneByOne(paSections, pcCode) )
	
				other
					StzRaise("Unsupported param type!")
				off

		#>

	  #================================================================#
	 #   YIELDING INFORMATION ON ITEMS IN GIVEN SECTIONS -- EXTENDED  #
	#================================================================#

	def YieldFromSectionsXT(paSections, pcCode)
		if NOT ( isList(paSections) and Q(paSections).IsListOfPairsOfNumbers() )
			StzRaise("Incorrect param! paSections must be a list of pairs of numbers.")
		ok

		# Getting all the positions from the provided sections
		# Example: [ [2,5], [7,9 ] ] --> [ 2, 3, 4, 5, 7, 8, 9 ]

		anSectionsExpanded = StzListQ(paSections).PerformQ('{
			@item = Q(@item).ExpandedIfPairOfNumbers()
		}').Content()
	
		anPositions = ListsMergeQ( anSectionsExpanded ).DuplicatesRemoved()

		return This.YieldFromXT(anPositions, pcCode)

		#< @FunctionFluentForm

		def YieldFromSectionsXTQ(paSections, pcCode)
			return This.YieldFromSectionsXTQR(paPositions, pcCode, :stzList)
	
		def YieldFromSectionsXTQR(paPositions, pcCode, pcReturnType)
			if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.YieldFromSectionsXT(paPositions, pcCode) )
	
			on :stzListOfStrings
				return new stzListOfStrings( This.YieldFromSectionsXT(paPositions, pcCode) )
				
			on :stzListOfNumbers
				return new stzListOfNumbers( This.YieldFromSectionsXT(paPositions, pcCode) )
		
			other
				StzRaise("Unsupported return type!")
			off			

		#>

		#< @FunctionAlternativeForms

		def HarvestFromSectionsXT(paSections, pcCode)
			return This.YieldFromSectionsXT(paSections, pcCode)

			def HarvestFromSectionsXTQ(paSections, pcCode)
				return This.HarvestFromSectionsXTQR(paSections, pcCode, :stzList)

			def HarvestFromSectionsXTQR(paSections, pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsReturnedTypeNamedParam()
					pcReturnType = pcReturnType[2]
				ok
	
				if NOT isString(pcReturnType)
					StzRaise("Incorrect param! pcReturnType must be a string.")
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.HarvestFromSectionsXT(paSections, pcCode) )

				on :stzListOfLists
					return new stzListOfLists( This.HarvestFromSectionsXT(paSections, pcCode) )
	
				other
					StzRaise("Unsupported param type!")
				off
	
		def YieldSectionsXT(paSections, pcCode)
			return This.YieldFromSectionsXT(paSections, pcCode)

			def YieldSectionsXTQ(paSections, pcCode)
				return This.YieldSectionsXTQR(paSections, pcCode, :stzList)

			def YieldSectionsXTQR(paSections, pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsReturnedTypeNamedParam()
					pcReturnType = pcReturnType[2]
				ok
	
				if NOT isString(pcReturnType)
					StzRaise("Incorrect param! pcReturnType must be a string.")
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.YieldSectionsXT(paSections, pcCode) )

				on :stzListOfLists
					return new stzListOfLists( This.YieldSectionsXT(paSections, pcCode) )
	
				other
					StzRaise("Unsupported param type!")
				off

		def HarvestSectionsXT(paSections, pcCode)
			return This.YieldFromSectionsXT(paSections, pcCode)

			def HarvestSectionsXTQ(paSections, pcCode)
				return This.HarvestSectionsXTQR(paSections, pcCode, :stzList)

			def HarvestSectionsXTQR(paSections, pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsReturnedTypeNamedParam()
					pcReturnType = pcReturnType[2]
				ok
	
				if NOT isString(pcReturnType)
					StzRaise("Incorrect param! pcReturnType must be a string.")
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.HarvestSectionsXT(paSections, pcCode) )

				on :stzListOfLists
					return new stzListOfLists( This.HarvestSectionsXT(paSections, pcCode) )
	
				other
					StzRaise("Unsupported param type!")
				off
		#>

	def YieldFromSectionsOneByOneXT(paSections, pcCode)
		if NOT ( isList(paSections) and Q(paSections).IsListOfPairsOfNumbers() )
			StzRaise("Incorrect param! paSections must be a list of pairs of numbers.")
		ok

		aResult = []

		anSectionsExpanded = []
		for aSection in paSections
			anSectionsExpanded + Q(aSection).ExpandedIfPairOfNumbers()
		next

		for anPositions in anSectionsExpanded
			aResult + This.YieldFromPositionsXT(anPositions, pcCode)
		next

		return aResult

		#< @FunctionFluentForm

		def YieldFromSectionsOneByOneXTQ(paSections, pcCode)
			return This.YieldFromSectionsOneByOneXTQR(paSections, pcCode, :stzList)

		def YieldFromSectionsOneByOneXTQR(paSections, pcCode, pcReturnType)
			if isList(pcReturnType) and Q(pcReturnType).IsReturnedTypeNamedParam()
				pcReturnType = pcReturnType[2]
			ok

			if NOT isString(pcReturnType)
				StzRaise("Incorrect param! pcReturnType must be a string.")
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.YieldFromSectionsOneByOneXTQ(paSections, pcCode) )

			on :stzListOfLists
				return new stzListOfLists( This.YieldFromSectionsOneByOneXTQ(paSections, pcCode) )

			other
				StzRaise("Unsupported param type!")
			off

		#>

		#< @FunctionAlternativeForms

		def HarvestFromSectionsOneByOneXT(paSections, pcCode)
			return This.YieldFromSectionsXT(paSections, pcCode)

			def HarvestFromSectionsOneByOneXTQ(paSections, pcCode)
				return This.HarvestFromSectionsOneByOneXTQR(paSections, pcCode, :stzList)

			def HarvestFromSectionsOneByOneXTQR(paSections, pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsReturnedTypeNamedParam()
					pcReturnType = pcReturnType[2]
				ok
	
				if NOT isString(pcReturnType)
					StzRaise("Incorrect param! pcReturnType must be a string.")
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.HarvestFromSectionsOneByOneXT(paSections, pcCode) )

				on :stzListOfLists
					return new stzListOfLists( This.HarvestFromSectionsOneByOneXT(paSections, pcCode) )
	
				other
					StzRaise("Unsupported param type!")
				off
				
		def HarvestSectionsOneByOneXT(paSections, pcCode)
			return This.YieldFromSectionsXT(paSections, pcCode)

			def HarvestSectionsOneByOneXTQ(paSections, pcCode)
				return This.HarvestSectionsOneByOneXTQR(paSections, pcCode, :stzList)

			def HarvestSectionsOneByOneXTQR(paSections, pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsReturnedTypeNamedParam()
					pcReturnType = pcReturnType[2]
				ok
	
				if NOT isString(pcReturnType)
					StzRaise("Incorrect param! pcReturnType must be a string.")
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.HarvestSectionsOneByOneXT(paSections, pcCode) )

				on :stzListOfLists
					return new stzListOfLists( This.HarvestSectionsOneByOneXT(paSections, pcCode) )
	
				other
					StzRaise("Unsupported param type!")
				off

		def YieldSectionsOneByOneXT(paSections, pcCode)
			return This.YieldFromSectionsXT(paSections, pcCode)

			def YieldSectionsOneByOneXTQ(paSections, pcCode)
				return This.YieldSectionsOneByOneXTQR(paSections, pcCode, :stzList)

			def YieldSectionsOneByOneXTQR(paSections, pcCode, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsReturnedTypeNamedParam()
					pcReturnType = pcReturnType[2]
				ok
	
				if NOT isString(pcReturnType)
					StzRaise("Incorrect param! pcReturnType must be a string.")
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.YieldSectionsOneByOneXT(paSections, pcCode) )

				on :stzListOfLists
					return new stzListOfLists( This.YieldSectionsOneByOneXT(paSections, pcCode) )
	
				other
					StzRaise("Unsupported param type!")
				off

		#>

	  #================================================================#
	 #   YIELDING INFORMATION ON ITEMS VERIFYiNG A GIVEN CONDITION    #
	#================================================================#

	def YieldW(pcCode, pcCondition)
		/*
		o1 = new stzList([ 1, 2, 3, 4, 5, 6, 7 ])
		? o1.YieldW('@NextItem', :if = 'StzNumberQ(@item).IsMultipleOf(2)')
		*/
		if NOT isString(pcCode)
			StzRaise("Incorrect param! pcCode must be a string.")
		ok

		if isList(pcCondition) and Q(pcCondition).IsWhereOrIfNamedParam()
			pcCondition = pccondition[2]
		ok

		if NOT isString(pcCondition)
			StzRaise("Incorrect param! pcCondition must be astring.")
		ok

		anPositions = This.FindW(pcCondition)

		aResult = This.YieldFrom(anPositions, pcCode)

		return aResult

		#< @FunctionFluentForm

		def YieldWQ(pcCode, pcCondition)
				return This.YieldWQR(paPositions, pcCode, :stzList)
		
			def YieldWQR(pcCode, pcCondition, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok
	
				switch pcReturnType
				on :stzList
					return new stzList( This.YieldW(pcCode, pcCondition) )
		
				on :stzListOfStrings
					return new stzListOfStrings( This.YieldW(pcCode, pcCondition) )
					
				on :stzListOfNumbers
					return new stzListOfNumbers( This.YieldW(pcCode, pcCondition) )
	
				on :stzHashList
					return new stzHashList( This.YieldW(pcCode, pcCondition) )
			
			other
					StzRaise("Unsupported return type!")
			off

		#>

		#> @FunctionAlternativeForm

		def HarvestW(pcCode, pcCondition)
			return This.YieldW(pcCode, pcCondition)

			def HervestWQ(pcCode, pcCondition)
				return This.HarvestWQR(pcCode, pcCondition, :stzList)

			def HervestWQR(pcCode, pcCondition, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok

				if NOT isString(pcReturnType)
					StzRaise("IncorrectType! pcReturnType must be a string.")
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.HarvestW(pcCode, pcCondition) )

				on :stzListOfLists
					return new stzListOfLists( This.HarvestW(pcCode, pcCondition) )

				other
					StzRaise("Unsupported return type!")
				off
		#>

		#< @FunctionMisspelledForm

		def YiledW(pcCode, pcCondition)
			return This.YieldW(pcCode, pcCondition)

		#>

	  #---------------------------------------------------------------------------#
	 #   YIELDING INFORMATION ON ITEMS VERIFYiNG A GIVEN CONDITION -- EXTENDED   #
	#---------------------------------------------------------------------------#

	def YieldWXT(pcCode, pcCondition)

		if NOT isString(pcCode)
			StzRaise("Incorrect param! pcCode must be a string.")
		ok

		if isList(pcCondition) and Q(pcCondition).IsWhereOrIfNamedParam()
			pcCondition = pccondition[2]
		ok

		if NOT isString(pcCondition)
			StzRaise("Incorrect param! pcCondition must be astring.")
		ok

		anPositions = This.FindWXT(pcCondition)
		aResult = This.YieldFromXT(anPositions, pcCode)

		return aResult

		#< @FunctionFluentForm

		def YieldWXTQ(pcCode, pcCondition)
				return This.YieldWXTQR(paPositions, pcCode, :stzList)
		
			def YieldWXTQR(pcCode, pcCondition, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok
	
				switch pcReturnType
				on :stzList
					return new stzList( This.YieldWXT(pcCode, pcCondition) )
		
				on :stzListOfStrings
					return new stzListOfStrings( This.YieldWXT(pcCode, pcCondition) )
					
				on :stzListOfNumbers
					return new stzListOfNumbers( This.YieldWXT(pcCode, pcCondition) )
	
				on :stzHashList
					return new stzHashList( This.YieldWXT(pcCode, pcCondition) )
			
			other
					StzRaise("Unsupported return type!")
			off

		#>

		#> @FunctionAlternativeForm

		def HarvestWXT(pcCode, pcCondition)
			return This.YieldWXT(pcCode, pcCondition)

			def HervestWXTQ(pcCode, pcCondition)
				return This.HarvestWXTQR(pcCode, pcCondition, :stzList)

			def HervestWXTQR(pcCode, pcCondition, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok

				if NOT isString(pcReturnType)
					StzRaise("IncorrectType! pcReturnType must be a string.")
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.HarvestWXT(pcCode, pcCondition) )

				on :stzListOfLists
					return new stzListOfLists( This.HarvestWXT(pcCode, pcCondition) )

				other
					StzRaise("Unsupported return type!")
				off
		#>

	  #===============================================#
	 #  YIELDING AND CUMULATING VALUES ON EACH ITEM  #
	#===============================================#

	def YieldAndCumulate(pcCode, paReturnLast)
		/* EXAMPLE
			o1 = new stzList([ 1, 2, 3 ])
			? o1.YieldAndCumulate("@item", :ReturnEach)
			#--> [ 1, 3, 6 ]

			? o1.YieldAndCumulate("@item", :ReturnLast)
			#--> 6
		*/

		bReturnLast = FALSE

		if isList(paReturnLast)
			if len(paReturnLast) = 2 and
			   isString(paReturnLast[1]) and
			   paReturnLast[1] = :ReturnLast and
			   isNumber(paReturnLast[2]) and
			   Q(paReturnLast[2]).IsEither(TRUE, :Or = FALSE)
				bReturnLast = paReturnLast[2]
			ok

		but isString(paReturnLast)
			if paReturnLast = :ReturnLast
				bReturnLast = TRUE
			ok	
		ok

		if NOT (This.IsListOfNumbers() or This.IsListOfStrings())
			StzRaise("Can't cumulate! The list must b a list of numbers or a list of strings.")
		ok

		if NOT isString(pcCode)
			StzRaise("Incorrect param type! pcCode must be a string.")
		ok

		aYielded = This.Yield(pcCode)
		nLenYielded = len(aYielded)

		if nLenYielded > 0
			aCumulated = [ aYielded[1] ]

			if nLenYielded > 1
				for i = 2 to nLenYielded
					aCumulated + ( aCumulated[i-1] + aYielded[i] )
				next
			ok
		ok

		nLenCumulated = len(aCumulated)

		if bReturnLast
			return aCumulated[ nLenCumulated ]
		else
			return aCumulated
		ok

		#< @FunctionFluentForm

		def YieldAndCumulateQ(pcAction, paReturnLast)
			return Q(This.YieldAndCumulate(pcAction, paReturnLast))

		#>

		#< @FunctionAlternativeForm

		def HarvestAndCumulate(pcAction, paReturnLast)
			return This.YieldAndCumulate(pcAction, paReturnLast)

			def HarvestAndCumulateQ(pcAction, paReturnLast)
				This.YieldAndCumulateQ(pcAction, paReturnLAst)

		#>

	  #-----------------------------------------------------------#
	 #  YIELDING AND CUMULATING VALUES ON EACH ITEM -- EXTENDED  #
	#-----------------------------------------------------------#

	def YieldAndCumulateXT(pcCode, paReturnLast)

		bReturnLast = FALSE

		if isList(paReturnLast)
			if len(paReturnLast) = 2 and
			   isString(paReturnLast[1]) and
			   paReturnLast[1] = :ReturnLast and
			   isNumber(paReturnLast[2]) and
			   Q(paReturnLast[2]).IsEither(TRUE, :Or = FALSE)
				bReturnLast = paReturnLast[2]
			ok

		but isString(paReturnLast)
			if paReturnLast = :ReturnLast
				bReturnLast = TRUE
			ok	
		ok

		if NOT ( This.IsListOfNumbers() or This.IsListOfStrings() )
			StzRaise("Can't cumulate! The list must b a list of numbers or a list of strings.")
		ok

		if NOT isString(pcCode)
			StzRaise("Incorrect param type! pcCode must be a string.")
		ok

		aYielded = This.YieldXT(pcCode)
		nLenYielded = len(aYielded)

		if nLenYielded > 0
			aCumulated = [ aYielded[1] ]

			if nLenYielded > 1
				for i = 2 to nLenYielded
					aCumulated + ( aCumulated[i-1] + aYielded[i] )
				next
			ok
		ok

		nLenCumulated = len(aCumulated)

		if bReturnLast
			return aCumulated[ nLenCumulated ]
		else
			return aCumulated
		ok

		#< @FunctionFluentForm

		def YieldAndCumulateXTQ(pcCode, paReturnLast)
			return Q(This.YieldAndCumulateXT(pcCode, paReturnLast))

		#>

		#< @FunctionAlternativeForm

		def HarvestAndCumulateXT(pcCode, paReturnLast)
			return This.YieldAndCumulateXT(pcCode, paReturnLast)

			def HarvestAndCumulateXTQ(pcCode, paReturnLast)
				This.YieldAndCumulateXTQ(pcCode, paReturnLAst)

		#>

	  #=======================================#
	 #   PERFORMING AN ACTION ON EACH ITEM   #
	#=======================================#

	def Perform(pcAction)
		# Must begin with '@item ='

		/* Example

		aWhatIs = [ :Ring = "programming language", :Softanza = "Ring library", :Qt = "C++ framework" ]
		
		o1 = new stzList([ "Ring", "Softanza", "Qt" ])
		o1.Perform('{ @item += " is a " + aWhatIs[@item] }')
		
		? o1.Content()
		# ---> [ "Ring is a programming language", "Softanza is a Ring library", "Qt is a C++ framework" ]

		*/

		if isList(pcAction) and Q(pcAction).IsDoNamedParam()
			pcAction = pcAction[2]
		ok

		This.PerformOnThesePositions(1:This.NumberOfItems(), pcAction)

		#< @FunctionfluentForm

		def PerformQ(pcAction)
			This.Perform(pcAction)
			return This

		def PerformQR(pcAction, pcReturnType)
			if IsList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			if NOT isString(pcReturnType)
				StzRaise("Incorrect param! pcReturnType must be a string.")
			ok

			switch pcReturnType
			on :stzList
				return This

			on :stzListOfStrings
				return new stzListOfStrings( This.Perform(pcAction) )

			on :stzListOfNumbers
				return new stzListOfNumbers( This.Perform(pcAction) )

			on :stzListOfLists
				return new stzListOfLists( This.Perform(pcAction) )

			on :stzListOfPairs
				return new stzListOfPairs( This.Perform(pcAction) )

			other
				StzRaise("Unsupported return type!")
			off

		#>

		#< @FunctionAlternativeForm

		def Doo(pcAction) # We can't use do() because it is reserved keyword by Ring
			This.Perform(pcAction)

			def DooQ(pcAction)
				return This.PerformQ(pcAction)

			def DooQR(pcAction, pcReturnType)
				return This.PerformQR(pcAction, pcReturnType)

			def DoQ(pcAction)
				return This.PerformQ(pcAction)

			def DoQR(pcAction, pcReturnType)
				return This.PerformQR(pcAction, pcReturnType)

		def Do_(pcAction) # We can't use do() because it is reserved keyword by Ring
			This.Perform(pcAction)

			def Do_Q(pcAction)
				return This.PerformQ(pcAction)

			def Do_QR(pcAction, pcReturnType)
				return This.PerformQR(pcAction, pcReturnType)

		#>

	  #---------------------------------------------------#
	 #   PERFORMIN ACTIONS ON CHARS IN GIVEN POSITIONS   #
	#---------------------------------------------------#

	def PerformOn(panPositions, pcCode)
		#< @MotherFunction > ReplaceItemAtPosition() | @RingBased #>

		if NOT ( isList(panPositions) and (Q(panPositions).IsListOfNumbers() or len(panPositions) = 0) )
			StzRaise("Invalid param type! panPositions must be a list of numbers.")
		ok

		if len(panPositions) = 0
			return
		ok

		if NOT isString(pcCode)
			StzRaise("Invalid param type! pcCode must be a string.")
		ok

		oCode = new stzString( StzCCodeQ(pcCode).Transpiled() )
		
		if oCode.WithoutSpaces() = ''
			return
		ok

		if NOT oCode.BeginsWithOneOfTheseCS(
			[ "@item =", "@item=",
			  "@item +=", "@item+=",
			  "@item -=", "@item-=",
			  "@item *=", "@item*=",
			  "@item /=", "@item/="
			],

			:CaseSensitive = FALSE )

			StzRaise("Syntax error! pcCode must begin with '@item ='.")
		ok

		cCode = oCode.Content()
		oCode = StzStringQ(cCode)

		@i = 0
		
		for @i in panPositions

			bEval = TRUE

			if @i = This.NumberOfItems() and
			   oCode.Copy().RemoveSpacesQ().ContainsCS( "This[@i+1]", :CS=FALSE )

				bEval = FALSE

			but @i = 1 and
			    oCode.Copy().RemoveSpacesQ().ContainsCS( "This[@i-1]", :CS=FALSE )

				bEval = FALSE
			
			ok

			if bEval

			eval(cCode)
				This.ReplaceItemAtPosition(@i, @item)
			ok

		next

		#--

		def PerformOnQ(panPositions, pcCode)
			This.PerformOn(panPositions, pcCode)
			return This

		def PerformOnQR(panPositions, pcCode)
			if IsList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			if NOT isString(pcReturnType)
				StzRaise("Incorrect param! pcReturnType must be a string.")
			ok

			switch pcReturnType
			on :stzList
				return This

			on :stzListOfStrings
				return new stzListOfStrings( This.PerformOn(panPositions, pcCode) )

			on :stzListOfNumbers
				return new stzListOfNumbers( This.PerformOn(panPositions, pcCode) )

			on :stzListOfLists
				return new stzListOfLists( This.PerformOn(panPositions, pcCode) )

			on :stzListOfPairs
				return new stzListOfPairs( This.PerformOn(panPositions, pcCode) )

			other
				StzRaise("Unsupported return type!")
			off

		#--

		def PerformOnPositions(panPositions, pcCode)
			This.PerformOn(panPositions, pcCode)

			def PerformOnPositionsQ(panPositions, pcCode)
				This.PerformOnPositions(panPositions, pcCode)
				return This
	
			def PerformOnPositionsQR(panPositions, pcCode, pcReturnType)
				if IsList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok
	
				if NOT isString(pcReturnType)
					StzRaise("Incorrect param! pcReturnType must be a string.")
				ok
	
				switch pcReturnType
				on :stzList
					return This
	
				on :stzListOfStrings
					return new stzListOfStrings( This.PerformOnPositions(panPositions, pcCode) )
	
				on :stzListOfNumbers
					return new stzListOfNumbers( This.PerformOnPositions(panPositions, pcCode) )
	
				on :stzListOfLists
					return new stzListOfLists( This.PerformOnPositions(panPositions, pcCode) )
	
				on :stzListOfPairs
					return new stzListOfPairs(This.PerformOnPositions(panPositions, pcCode) )
	
				other
					StzRaise("Unsupported return type!")
				off

		#--

		def PerformOnThesePositions(panPositions, pcCode)
			This.PerformOn(panPositions, pcCode)

			def PerformOnThesePositionsQ(panPositions, pcCode)
				This.PerformOnThesePositions(panPositions, pcCode)
				return This

			def PerformOnThesePositionsQR(panPositions, pcCode, pcReturnType)
				if IsList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok
	
				if NOT isString(pcReturnType)
					StzRaise("Incorrect param! pcReturnType must be a string.")
				ok
	
				switch pcReturnType
				on :stzList
					return This
	
				on :stzListOfStrings
					return new stzListOfStrings( This.PerformOnThesePositions(panPositions, pcCode) )
	
				on :stzListOfNumbers
					return new stzListOfNumbers( This.PerformOnThesePositions(panPositions, pcCode) )
	
				on :stzListOfLists
					return new stzListOfLists( This.PerformOnThesePositions(panPositions, pcCode) )
	
				on :stzListOfPairs
					return new stzListOfPairs( This.PerformOnThesePositions(panPositions, pcCode) )
	
				other
					StzRaise("Unsupported return type!")
	
				off

	  #------------------------------------------------------#
	 #   PERFORMING AN ACTION ON ITEMS AT GIVEN SECTIONS    #
	#------------------------------------------------------#

	def PerformOnSections(paSections, pcCode)

		# Checking correctness of paSections param

		If NOT isString(pcCode)
			StzRaise("Incorrect param! pcCode must be a string.")
		ok

		if NOT ( isList(paSections) and

			 Q(paSections).EachItemVerifyW(
				:That = 'isList(@item) and Q(@item).IsPairOfNumbers()' ) )

			StzRaise("Incorrect param! paSections must be a list of pairs of numbers.")
		ok

		# Getting all the positions from the provided sections
		# Example: [ [2,5], [7,9 ] ] --> [ 2, 3, 4, 5, 7, 8, 9 ]

		anSectionsExpanded = StzListQ(paSections).PerformQ('{
			@item = Q(@item).ExpandedIfPairOfNumbers()
		}').Content()
	
		anPositions = ListsMergeQ( anSectionsExpanded ).DuplicatesRemoved()

		This.PerformOn(anPositions, pcCode)

		#--

		def PerformOnSectionsQ(paSections, pcCode)
			This.PerformOnSections(paSections, pcCode)
			return This

		def PerformOnSectionsQR(paSections, pcCode, pcReturnType)
			if IsList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			if NOT isString(pcReturnType)
				StzRaise("Incorrect param! pcReturnType must be a string.")
			ok

			switch pcReturnType
			on :stzList
				return This

			on :stzListOfStrings
				return new stzListOfStrings( This.PerformOnSections(paSections, pcCode) )

			on :stzListOfNumbers
				return new stzListOfNumbers( This.PerformOnSections(paSections, pcCode) )

			on :stzListOfLists
				return new stzListOfLists( This.PerformOnSections(paSections, pcCode) )

			on :stzListOfPairs
				return new stzListOfPairs( This.PerformOnSections(paSections, pcCode) )

			other
				StzRaise("Unsupported return type!")
			off

		#--

		def PerformOnTheseSections(paSections, pcCode)
			This.PerformOnSections(paSections, pcCode)

			def PerformOnTheseSectionsQ(paSections, pcCode)
				This.PerformOnTheseSections(paSections, pcCode)
				return This

			def PerformOnTheseSectionsQR(paSections, pcCode, pcReturnType)
				if IsList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok
	
				if NOT isString(pcReturnType)
					StzRaise("Incorrect param! pcReturnType must be a string.")
				ok
	
				switch pcReturnType
				on :stzList
					return This
	
				on :stzListOfStrings
					return new stzListOfStrings( This.PerformOnTheseSections(paSections, pcCode) )
	
				on :stzListOfNumbers
					return new stzListOfNumbers( This.PerformOnTheseSections(paSections, pcCode) )
	
				on :stzListOfLists
					return new stzListOfLists( This.PerformOnTheseSections(paSections, pcCode) )
	
				on :stzListOfPairs
					return new stzListOfPairs( This.PerformOnTheseSections(paSections, pcCode) )
	
				other
					StzRaise("Unsupported return type!")
				off
	
	  #---------------------------------------------------------------#
	 #   PERFORMING AN ACTION ON ITEMS VERIFYING A GIVEN CONDITION   #
	#---------------------------------------------------------------#

	def PerformW(pcAction, pcCondition)
		
		if isList(pcAction) and Q(pcAction).IsDoNamedParam()
			pcAction = pcAction[2]
		ok

		if NOT isString(pcAction)
			StzRaise("Incorrect type! pcAction must be a string.")
		ok
		
		if isList(pcCondition) and Q(pcCondition).IsIfOrWhereNamedParam()

			pcCondition = pcCondition[2]
		ok

		if NOT isString(pcCondition)
			StzRaise("Incorrect type! pcCondition must be a string.")
		ok

		# No need to purify the pcCondition code here,
		# FindItemsW() will do it

		anPositions = This.FindItemsW(pcCondition)

		# Do not purify pcAction code here,
		# PerformOn() will do it

		This.PerformOn(anPositions, pcAction)

		#< @FunctionFluentForm

		def PerformWQ(pcAction, pcCondition)
			This.PerformW(pcAction, pcCondition)
			return This

		def PerformWQR(pcAction, pcCondition, pcReturnType)
			if IsList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			if NOT isString(pcReturnType)
				StzRaise("Incorrect param! pcReturnType must be a string.")
			ok

			switch pcReturnType
			on :stzList
				return This

			on :stzListOfStrings
				return new stzListOfStrings( This.PerformW(pcAction, pcCondition) )

			on :stzListOfNumbers
				return new stzListOfNumbers( This.PerformW(pcAction, pcCondition) )

			on :stzListOfLists
				return new stzListOfLists( This.PerformW(pcAction, pcCondition) )

			on :stzListOfPairs
				return new stzListOfPairs( This.PerformW(pcAction, pcCondition) )

			other
				StzRaise("Unsupported return type!")
			off
		#>

		#< @AlternativeForm

		def DoW( pcAction, pcCondition )
			This.PerformW( pcAction, pcCondition )

			def DoWQ( pcAction, pcCondition )
				return This.PerformWQ( pcAction, pcCondition )

			def DoWQR( pcAction, pcCondition, pcReturnType )
				return This.PerformWQR( pcAction, pcCondition, pcReturnType )
		#>

	  #==================================================#
	 #  CHECKING IF THE LIST IS EQUAL TO AN OTHER LIST  #
	#==================================================#

	def IsEqualToCS(paOtherList, pCaseSensitive)
		/*
		Two lists are equal when they have:
			1. same type
			2. same number of items AND
			3. same content
		*/

		# Doublechecking for potential performance gain

		if This.NumberOfItems() != len(paOtherList)
			return FALSE
		ok

		if isList(paOtherList) and
		   len(paOtherList) = len(This.List()) and
		   This.HasSameContentAsCS(paOtherList, pCaseSensitive)

			return TRUE
		else
			return FALSE
		ok

		def IsEqualCS(paOtherList, pCaseSensitive)
			return This.IsEqualToCS(paOtherList, pCaseSensitive)

		def IsNotEqualToCS(paOtherList, pCaseSensitive)
			return NOT This.IsEqualToCS(paOtherList, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def IsEqualTo(paOtherList)
		/*
		Two lists are equal when they have:
			1. same type
			2. same number of items AND
			3. same content
		*/

		if isList(paOtherList) and
		   len(paOtherList) = len(This.List()) and
		   This.HasSameContentAs(paOtherList)

			return TRUE
		else
			return FALSE
		ok

		def IsEqual(paOtherList)
			return This.IsEqualTo(paOtherList)

		def IsNotEqualTo(paOtherList)
			return NOT This.IsEqualTo(paOtherList)

	  #-----------------------------------------------------------#
	 #  CHECKING IF THE LIST IS STRICTLY EQUAL TO AN OTHER LIST  #
	#-----------------------------------------------------------#

	def IsStrictlyEqualTo(paOtherList)

		/*
		Tow lists are striclty equal when:
			1. they are equal (in the sense of IsEqualTo() method)
			2. they have same order of items (ItemsHaveSameOrder())
		*/
		
		if This.IsEqualTo(paOtherList) and
		   This.HasSameSortingOrderAs(paOtherList)
			return TRUE
		else
			return FALSE
		ok

		def IsStrictlyEqual(paOtherList)
			return This.IsStrictlyEqualTo(paOtherList)

	  #--------------------------------------------------------#
	 #  CHECKING IF THE LIST IS QUEIT EQUAL TO AN OTHER LIST  #
	#--------------------------------------------------------#

	def IsQuietEqualTo(paOtherList)

		if This.IsEqualTo(paOtherList)
			return TRUE
		ok

		nDif = abs(This.NumberOfItems() - StzListQ(paOtherList).NumberOfItems())
		n = nDif / This.NumberOfItems()
		
		if n < QuietEqualityRatio() # 0.09 by default, can be changed with SetQuietEqualityRatio(n)
			return TRUE
		ok

		return FALSE

		def IsQuietEqual(paOtherList)
			return This.IsQuietEqualTo(paOtherList)

	  #--------------------------------------------------------#
	 #  CHECKING IF THE LIST HAS SAME ORDER AS AN OTHER LIST  #
	#--------------------------------------------------------#

	def ItemsHaveSameOrderAs(paOtherList)
		bResult = TRUE

		for i = 1 to min([ len(This.List()), len(paOtherList) ])
			if Q(This[i]).IsNotEqualTo(paOtherList[i])
				bResult = FALSE
				exit
			ok
		next

		return bResult
	
		def ItemsHaveSameOrder(paOtherList)
			return This.ItemsHaveSameOrderAs(paOtherList)

	  #------------------------------------------------------------#
	 #  CHECKING IF ALL THE ITEMS ARE EIGTHER NUMBERS OR ITEMS  #
	#------------------------------------------------------------#

	def AllItemsAreNumbersOrStrings()
		bResult = TRUE
		for item in This.List()
			if NOT (isNumber(item) or isString(item))
				bResult = FALSE
				exit
			ok
		next
		return bResult

		def ItemsAreNumbersOrStrings()
			return This.AllItemsAreNumbersOrStrings()

		def AllItemsAreStringsOrNumbers()
			return This.AllItemsAreNumbersOrStrings()

		def ItemsAreStringsOrNumbers()
			return This.AllItemsAreNumbersOrStrings()

	  #--------------------------------------------------------#
	 #  CHECKING IF THE LIST IS THE REVERSE OF AN OTHER LIST  #
	#--------------------------------------------------------#

	def IsReverseOf(paOtherList)
		bResult = TRUE
		if This.NumberOfItems() != len(paOtherList)
			return FALSE
		ok

		for i = 1 to This.NumberOfItems()
			if _(This[i]).@.IsDifferentFrom( paOtherList[ len(paOtherList) - i + 1 ] )
				bResult = FALSE
				exit
			ok
		next i

		return bResult

		def IsReverse(paOtherList)
			return This.IsReverseOf(paOtherList)

	  #-------------------------------------#
	 #  REVERSING ITEMS ORDER IN THE LIST  #
	#-------------------------------------#

	def Reverse()

		aResult = ring_reverse( This.List() )
		This.Update( aResult )

		def ReverseQ()
			This.Reverse()
			return This

		#< @FunctionAlternativeForms

		def ReverseOrder()
			This.Reverse()

			def ReverseOrderQ()
				This.ReverseOrder()
				return This

		def ReverseItems()
			This.Reverse()

			def ReverseItemsQ()
				This.ReverseItems()
				return This

		def ReverseItemsOrder()
			This.Reverse()

			def ReverseItemsOrderQ()
				This.ReverseItemsOrder()
				return This

		#>

	def Reversed()
		aResult = This.Copy().ReverseQ().Content()
		return aResult

		#< @FunctionAlternativeForms

		def ItemsReversed()
			return This.Reversed()

		def ItemsOrderReversed()
			return This.Reversed()

		def OrderReversed()
			return This.Reversed()

		#>

	  #----------------------------------------------------------#
	 #  CHECKING IF THE LIST HAS MORE ITEMS THAN AN OTHER LIST  #
	#----------------------------------------------------------#

	def HasMoreNumberOfItems(paOtherList)
		if isList(paOtherList) and Q(paOtherList).IsThenNamedParam()
			paOtherList = paOtherList[2]
		ok

		if This.NumberOfItems() > len(paOtherList)
			return TRUE
		else
			return FALSE
		ok

		def HasMoreNumberOfItemsThen(paOtherList)
			return This.HasMoreNumberOfItems(paOtherList)

		def HasMoreItems(paOtherList)
			return This.HasMoreNumberOfItems(paOtherList)

		def HasMoreItemsThen(paOtherList)
			return This.HasMoreNumberOfItems(paOtherList)

		def IsLarger(paOtherList)
			return This.HasMoreNumberOfItems(paOtherList)

		def IsLargerThen(panOtherList)
			return This.HasMoreNumberOfItems(paOtherList)
	
	  #----------------------------------------------------------#
	 #  CHECKING IF THE LIST HAS LESS ITEMS THAN AN OTHER LIST  #
	#----------------------------------------------------------#

	def HasLessNumberOfItems(paOtherList)
		if isList(paOtherList) and Q(paOtherList).IsThenNamedParam()
			paOtherList = paOtherList[2]
		ok

		if This.NumberOfItems() < len(paOtherList)
			return TRUE
		else
			return FALSE
		ok

		def HasLessNumberOfItemsThen(paOtherList)
			return This.HasLessNumberOfItems(paOtherList)

		def HasLessItems(paOtherList)
			return This.HasLessNumberOfItems(paOtherList)

		def HasLessItemsThen(paOtherList)
			return This.HasLessNumberOfItems(paOtherList)

		def IsSmaller(paOtherList)
			return This.HasLessNumberOfItems(paOtherList)

		def IsSmallerThen(panOtherList)
			return This.HasLessNumberOfItems(paOtherList)
	
	  #--------------------------------------------#
	 #  CHECKING IF A GIVEN VALUE IS ALSO A LIST  #
	#--------------------------------------------#

	def HasSameTypeAs(p)
		return isList(p)

		def HasSameType(p)
			return This.HasSameTypeAs(p)

	  #--------------------------------------------------------------------#
	 #  CHECKING IF LIST HAS THE SAME CONTENT AS AN OTHER LIST OR ITEM  #
	#--------------------------------------------------------------------#

	def HasSameContentCS(paOtherList, pCaseSensitive)
		if isList(paOtherList) and Q(paOtherList).IsAsNamedParam()
			paOtherList = paOtherList[2]
		ok

		if NOT isList(paOtherList)
			StzRaise("Invalid param type! paOtherList should be a list.")
		ok

		# The two lists must have same number of items

		If  This.NumberOfItems() != len(paOtherList)
			return FALSE
		ok

		bResult = TRUE

		for item in paOtherList
			if NOT This.ContainsCS(item, pCaseSensitive)
				bResult = FALSE
				exit
			ok
		next
			
		return bResult
	
		def HasSameContentAsCS(paOtherList, pCaseSensitive)
			return This.HasSameContentCS(paOtherList, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def HasSameContent(paOtherList)
		return This.HasSameContentCS(paOtherList, :CaseSensitive = TRUE)

		def HasSameContentAs(paOtherList)
			return This.HasSameContent(paOtherList)

	  #=====================================#
	 #    CLASSIFYING (OR CATEGORIZING)    #
	#=====================================#

	def AllItemsAreContiguousLists()
		bResult = TRUE

		for item in This.List()
			if NOT ( isList(item) and StzListQ(item).IsContiguous() )
				bResult = FALSE
				exit
			ok
		next

		return bResult

		def AllItemsAreContinuousLists()
			return This.AllItemsAreContiguousLists()

	def Classify()

		/* EXAMPLE

		aList = [
			:Arabic,
			:Arabic,
			:French,
			:English,
			:Spanish,
			:Spanish,
			:English,
			:Arabic
		]
		
		StzListQ(aList) {
		 	? Classify()
			#--> [
			# 	:Arabic  = [ 1, 2, 8 ],
			# 	:French  = [ 3 ],
			# 	:Enslish = [ 4, 7 ],
			#    	:Spanish = [ 5, 6 ]
			#    ]
		}
		*/

		aClasses = This.UniqueItems()

		cClass   = ""
		aResult  = []

		for pClass in aCLasses
			anPositions = This.FindAll(pClass)

			cClass = @@S( pClass )

			aResult + [ cClass, anPositions ]

		next

		return aResult

		#< @FunctionFluentForm

		def ClassifyQ()
			return This.ClassifyQR(:stzList)

		def ClassifyQR(pcReturnType)
			if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.Classify() )

			on :stzHashList
				return new stzHashList( This.Classify() )

			other
				StzRaise("Unssupported return type!")

			off
		#>

		#< @FunctionAlternativeForms

		def Categorize()
			return This.Classify()

			def CategorizeQ()
				return This.CategorizeQR(:stzList)
	
			def CategorizeQR(pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.Categorize() )
	
				on :stzHashList
					return new stzHashList( This.Categorize() )
	
				other
					StzRaise("Unssupported return type!")
	
				off

		def Categorise()
			return This.Classify()

			def CategoriseQ()
				return This.CategoriseQR(:stzList)
	
			def CategoriseQR(pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.Categorise() )
	
				on :stzHashList
					return new stzHashList( This.Categorise() )
	
				other
					StzRaise("Unssupported return type!")
	
				off

		#>

	#--

	def Classes()

		aClasses = StzHashListQ( This.Classify() ).Keys()
		return aClasses


		#< @FunctionFluentForm

		def ClassesQ()
			return This.ClassesQR(:stzList)

		def ClassesQR(pcReturnType)
			if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.Classes() )

			on :stzListOfStrings
				return new stzListOfStrings( This.Classes() )

			other
				StzRaise("Unsupported return type!")
			off
		#>

		#< @FunctionAlternativeForm

		def Categories()
			return This.Classes()

			def CategoriesQ()
				return This.ClassesQR(:stzList)
	
			def CategoriesQR(pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.Categories() )
	
				on :stzListOfStrings
					return new stzListOfStrings( This.Categories() )
	
				other
					StzRaise("Unsupported return type!")
				off

	#--

	def NumberOfClasses()
		return len( This.Classes() )

		def NumberOfClassesQ()
			return new stzNumber( This.NumberOfClasses() )

		def NumberOfCategories()
			return This.NumberOfClasses()

			def NumberOfCategoriesQ()
				return new stzNumber( This.NumberOfCategories() )

		def CuontClasses()
			return This.NumberOfClasses()

		def HowManyClasses()
			return This.NumberOfClasses()

	def Klass(pcClass)
		return This.Classify()[pcClass]

		def KlassQ(pcClass)
			return new stzString(This.Klass(pcClass))

		def Category(pcClass)
			return This.Klass(pcClass)

			def CategoryQ(pcClass)
				return new stzString(This.Category(pcClass))

	def NumberOfOccurrenceOfClass(pcClass)
		nResult = StzListQ( This.Classes() ).NumberOfOccurrence( pcClass )
		return nResult

		def CountClass(pcClass)
			return This.NumberOfOccurrenceOfClass(pcClass)

		def HowManyClass(pcClass)
			return This.NumberOfOccurrenceOfClass(pcClass)

		def CountOccurrencesOfClass(pcClass)
			return This.NumberOfOccurrenceOfClass(pcClass)

		def HowManyOccurrencesOfClass(pcClass)
			return This.NumberOfOccurrenceOfClass(pcClass)

	def ClassFrequency(pcClass)
		nResult = This.NumberOfOccurrenceOfClass(pcClass) / This.NumberOfClasses()

		def ClassFreq(pcClass)

	def ClassesFrequencies()
		anResult = []
		for cClass in This.Classes()
			anResult + This.ClassFrequency(pcClass)
		next
		return anResult

		def ClassesFreq()
			return This.ClassesFrequencies()

	def ClassesAndTheirFrequencies()
		acClasses 	= This.Classes()
		anFrequencies 	= This.ClassesFrequencies()

		aResult = StzLisQ( acClasses ).AssociatedWith( anFrequencies )

		return aResult

		def ClassesAndTheirFreq()
			return This.ClassesAndTheirFrequencies()

		def ClassesXT()
			return This.ClassesAndTheirFrequencies()

	   #--------------------------------------------------------#
	  #   CLASSIFYING: SPECIEFIC CASE OF LISTS MADE OF LISTS   #
	 #   OF NUMBERS IN WHICH THE _:_ SYNTAX IS PREFERRED      #
	#--------------------------------------------------------#

	# @C prefix is used to say this function returns its result with
	# list of numbers in the _:_ Contiguous List syntax
	# provided by Ring. See example hereafter.

	def ClassifySF()	# Specific for lists of lists of numbers
				# Returs classes in the "_:_" syntax
				# @C for Continuous lists
	
		/* EXAMPLE
		o1 = new stzList([
			1:5, 3:9, 1:5, 10:15, 3:9, 12:20, 10:15, 1:5, 12:20
		])
		
		? o1.ClassifySF()	# Same as Categorize()
		#--> [
		#	[ "1:5",   [1, 3, 8 ] ],	
		#	[ "3:9",   [2, 5 ] ],
		#	[ "10:15", [4, 7 ] ],
		#	[ "12:20", [6, 9 ]
		#    ]

		*/

		acClasses@C = This.ClassesSF()

		aPositions = StzHashListQ( This.Classify() ).Values()

		aResult = StzListQ(acClasses@C).AssociatedWith(aPositions)

		return aResult

		#< @FunctionFluentForm

		def Classify@CQ()
			return This.Classify@CQR(:stzList)

		def Classify@CQR(pcReturnType)
			if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.ClassifySF() )

			on :stzHashList
				return new stzHashList( This.ClassifySF() )

			other
				StzRaise("Unssupported return type!")

			off
		#>

		#< @FunctionAlternativeForms

		def CategorizeSF()
			return This.ClassifySF()

			def Categorize@CQ()
				return This.Categorize@CQR(:stzList)
	
			def Categorize@CQR(pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.CategorizeSF() )
	
				on :stzHashList
					return new stzHashList( This.CategorizeSF() )
	
				other
					StzRaise("Unssupported return type!")
	
				off

		def CategoriseSF()
			return This.ClassifySF()

			def Categorise@CQ()
				return This.Categorise@CQR(:stzList)
	
			def Categorise@CQR(pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok
	
				switch pcReturnType
				on :stzList
					return new stzList( This.CategoriseSF() )
	
				on :stzHashList
					return new stzHashList( This.CategoriseSF() )
	
				other
					StzRaise("Unssupported return type!")
	
				off

		#>

	def ClassesSF()
		acClasses = This.Classes()

		for cClass in acClasses
			cClass = StzStringQ(cClass).ToListInShortForm()
		next

		return acClasses

		#< @FunctionFluentForm

		def Classes@CQ()
			return This.Classes@CQR(:stzList)

		def Classes@CQR(pcReturnType)
			if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.ClassesSF() )

			on :stzListOfStrings
				return new stzListOfStrings( This.ClassesSF() )

			other
				StzRaise("Unsupported return type!")
			off
		#>

		#< @FunctionAlternativeForm

		def CategoriesSF()
			return This.ClassesSF()

			def Categories@CQ()
				return This.Classes@CQR(:stzList)
	
			def Categories@CQR(pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.CategoriesSF() )
	
				on :stzListOfStrings
					return new stzListOfStrings( This.CategoriesSF() )
	
				other
					StzRaise("Unsupported return type!")
				off

	def KlassSF(pcClass)
		aResult = []

		if isString(pcClass) and StzStringQ(pcClass).IsListInShortForm()
			cClass =Q(pcClass).WithoutSpaces()
			aResult = This.ClassifySF()[cClass]
		ok

		return aResult

		def Klass@CQ(pcClass)
			return new stzString( This.KlassSF(pcClass) )

		def CategorySF(pcClass)
			return This.KlassSF(pcClass)

			def Category@CQ(pcClass)
				return new stzString( This.CategorySF(pcClass) )

	def NumberOfOccurrenceOfClassSF(pcClass)
		nResult = StzListQ( This.ClassesSF() ).NumberOfOccurrence( pcClass )
		return nResult

		def CountClassSF(pcClass)
			return This.NumberOfOccurrenceOfClassSF(pcClass)

		def HowManyClassSF(pcClass)
			return This.NumberOfOccurrenceOfClassSF(pcClass)

		def CountOccurrencesOfClassSF(pcClass)
			return This.NumberOfOccurrenceOfClassSF(pcClass)

		def HowManyOccurrencesOfClassSF(pcClass)
			return This.NumberOfOccurrenceOfClassSF(pcClass)
		
	def ClassFrequencySF(pcClass)
		nResult = This.NumberOfOccurrenceOfClassSF(pcClass) / This.NumberOfClasses()
		return nResult

		def ClassFreqSF(pcClass)
			return This.ClassFrequencySF(pcClass)

	def ClassesFrequenciesSF()
		anResult = []
		for cClass in This.ClassesSF()
			anResult + This.ClassFrequencySF(pcClass)
		next
		return anResult

		def ClassesFreqSF()
			return This.ClassesFrequenciesSF()

	def ClassesAndTheirFrequenciesSF()
		acClasses 	= This.ClassesSF()
		anFrequencies 	= This.ClassesFrequencies()

		aResult = StzLisQ( acClasses ).AssociatedWith( anFrequencies )

		return aResult

		def ClassesAndTheirFreqSF()
			return This.ClassesAndTheirFrequenciesSF()

		def ClassesXTSF()
			return This.ClassesAndTheirFrequenciesSF()

	  #-----------------------------------------------------#
	 #   THE LIST IS MADE OF CONTIGUOUS CHARS OR NUMBERS   #
	#-----------------------------------------------------#

	def IsContiguous()
		bResult = FALSE

		if This.IsListOfNumbers()

			bResult = This.ToStzListOfNumbers().IsContiguous()

		but This.IsListOfChars()

			bResult = This.ToStzListOfChars().IsContiguous()

		ok

		return bResult

		def IsContinuous()
			return IsContiguous()

	  #==================================#
	 #  BISECTING THE LIST INTO HALVES  #
	#==================================#

	#-- FIRST HALF

	def FirstHalf()

		nPos = floor(This.NumberOfItems() / 2)
		acResult = This.Section(1, nPos)

		return acResult

	def FirstHalfAndPosition()
		aResult = [ This.FirstHalf(), 1 ]
		return aResult

		def FirstHalfAndItsPosition()
			return This.FirstHalfAndPosition()

	def FirstHalfAndSection()
		aResult = [ This.FirstHalf(), [1, floor(This.NumberOfItems() / 2)] ]
		return aResult

		def FirstHalfAndItsSection()
			return This.FirstHalfAndSection()
		
	def FirstHalfXT()

		nPos = ceil(This.NumberOfItems() / 2)
		acResult = This.Section(1, nPos)

		return acResult
		
	def FirstHalfAndPositionXT()
		aResult = [ This.FirstHalfXT(), 1 ]
		return aResult

		def FirstHalfAndItsPositionXT()
			return This.FirstHalfAndPositionXT()

	def FirstHalfAndSectionXT()
		aResult = [ This.FirstHalfXT(), [1, ceil(This.NumberOfItems() / 2)] ]
		return aResult

		def FirstHalfAndItsSectionXT()
			return This.FirstHalfAndSectionXT()

	#-- SECOND HALF

	def SecondHalf()
		nLen = This.NumberOfItems()
		nPos = floor(nLen / 2) + 1
		acResult = This.Section(nPos, nLen)

		return acResult

	def SecondHalfAndPosition()
		nLen = This.NumberOfItems()
		nPos = floor(nLen / 2) + 1
		aResult = [ This.SecondHalf(), nPos ]
		return aResult

		def SecondHalfAndItsPosition()
			return This.SecondHalfAndPosition()

	def SecondHalfAndSection()
		nLen = This.NumberOfItems()
		nPos = floor(nLen / 2) + 1
		aResult = [ This.SecondHalf(), [ nPos, nLen ] ]
		return aResult

		def SecondHalfAndItsSection()
			return This.SecondHalfAndSection()

	def SecondHalfXT()
		nLen = This.NumberOfItems()
		nPos = ceil(nLen / 2) + 1
		acResult = This.Section(nPos, nLen)

		return acResult

	def SecondHalfAndPositionXT()
		nLen = This.NumberOfItems()
		nPos = ceil(nLen / 2) + 1
		aResult = [ This.SecondHalfXT(), nPos ]
		return aResult

		def SecondHalfAndItsPositionXT()
			return This.SecondHalfAndPositionXT()

	def SecondHalfAndSectionXT()
		nLen = This.NumberOfItems()
		nPos = ceil(nLen / 2) + 1
		aResult = [ This.SecondHalfXT(), [ nPos, nLen ] ]
		return aResult

		def SecondHalfAndItsSectionXT()
			return This.SecondHalfAndSectionXT()

	#-- THE TWO HALVES

	def Halves()
		acResult = []
		acResult + This.FirstHalf() + This.SecondHalf()

		return acResult

		def Bisect()
				return This.Halves()

	def HalvesXT()
		acResult = []
		acResult + This.FirstHalfXT() + This.SecondHalfXT()

		return acResult

		def BisectXT()
			return This.Halves()

	def HalvesAndPositions()
		aResult = [ This.FirstHalfAndPosition(), This.SecondHalfAndPosition() ]
		return aResult

		def HalvesAndTheirPositions()
			return This.HalvesAndPositions()

	def HalvesAndPositionsXT()
		aResult = [ This.FirstHalfAndPositionXT(), This.SecondHalfAndPositionXT() ]
		return aResult

		def HalvesAndTheirPositionsXT()
			return This.HalvesAndPositionsXT()

	def HalvesAndSections()
		aResult = [ This.FirstHalfAndSection(), This.SecondHalfAndSection() ]
		return aResult

		def HalvesAndTheirSections()
			return This.HalvesAndSections()

	def HalvesAndSectionsXT()
		aResult = [ This.FirstHalfAndSectionXT(), This.SecondHalfAndSectionXT() ]
		return aResult

		def HalvesAndTheirSectionsXT()
			return This.HalvesAndSectionsXT()

	  #============================================================#
	 #  INDEXING THE LIST BY POSITION OR BY NUMBER OF OCCURRENCE  #
	#============================================================#

	def Index()
		return IndexBy(:Position)

	def Indexed()
		return This.Index()

	#--

	def IndexXT(pBy)
		cBy = ""

		if isList(paBy) and
		   Q(paBy).IsOneOfTheseNamedParams([ :By, :On ])

			pBy = pBy[2]
		ok

		if NOT isString(pBy)
			StzRaise("Incorrect param type! pBy must be a string.")
		ok

		if pBy = :Position
			return This.IndexByPosition()

		but pBy = :NumberOfOccurrence or :NumberOfOccurrences
			return This.IndexByNumberOfOccurrence()

		else
			StzRaise("Unsupported indexing type! Allowed types are by :Positon and by :NumberOfOccurrences.")
		ok
	
	def IndexedXT(pBy)
		return This.IndexXT(pBy)

	#--

	def IndexBy(pcBy)
		if NOT isString(pcBy)
			StzRaise("Incorrect param type! pcBy must be a string.")
		ok

		if NOT Q(pcBy).IsOneOfThese([ :Position, :NumberOfOccurrence, :NumberOfOccurrences ])
			StzRaise("Incorrect value of pcBy! Allowed values are :Position and :NumberOfOccurrence.")
		ok

		aResult = []
		if pcBy = :Position
			aUniqueItems = This.DuplicatesRemoved()
			nLen = len(aUniqueItems)

			for i = 1 to nLen
				item = aUniqueItems[i]
				anPos = This.Positions(item)
				aResult + [ item, anPos ]
			next
	
		but pcBy = :NumberOfOccurrence or pcBy = :NumberOfOccurrences
			/* Index( [ "A", "A", "B", "C" ] --> [ :A = 2, :B = 1, :C = 1 ] */
			
			aUniqueItems = This.DuplicatesRemoved()
			nLen = len(aUniqueItems)

			for i = 1 to nLen
				item = aUniqueItems[i]
				n =  This.NumberOfOccurrence(item)
				aResult + [ item, n ]
			next	
		else
			StzRaise("Unsupported indexing paramater!")
		ok

		return aResult

		def IndexOn(pcOn)
			return This.IndexBy(pcOn)

	def IndexedBy(pcBy)
		return This.IndexBy(pcBy)

		def IndexedOn(pcOn)
			return This.IndexedBy(pcOn)

	#--
	
	def IndexByPosition()
		return IndexBy(:Position)

		def IndexOnPosition()
			return This.IndexByPosition()

	def IndexedByPosition()
		return This.IndexByPosition()

		def IndexedOnPosition()
			return This.IndexedByPostion()

	#--

	def IndexByNumberOfOccurrence()
		return IndexBy(:NumberOfOccurrence)

		def IndexByNumberOfOccurrences()
			return This.IndexByNumberOfOccurrence()

		def IndexOnNumberOfOccurrence()
			return This.IndexByNumberOfOccurrence()

		def IndexOnNumberOfOccurrences()
			return This.IndexByNumberOfOccurrence()

	def IndexedByNumberOfOccurrence()
		return This.IndexByNumberOfOccurrence()

		def IndexedByNumberOfOccurrences()
			return This.IndexedByNumberOfOccurrence()

		def IndexedOnNumberOfOccurrence()
			return This.IndexedByNumberOfOccurrence()

		def IndexedOnNumberOfOccurrences()
			return This.IndexedByNumberOfOccurrence()

	  #========================================#
	 #     COMPARAISON WITH AN OTHER LIST     #
	#========================================#

	  #-------------------------------------------------------------#
	 #  CHECKING IF THE LIST CONTAINS SAME ITEMS AS AN OTHER LIST  #
	#-------------------------------------------------------------#

	def ContainsSameItemsAsCS(paOtherList, pCaseSensitive)
		if len( This.DifferentItemsWithCS(paOtherList, pCaseSensitive) ) = 0
			return TRUE
		else
			return FALSE
		ok

	#-- WITHOUT CASESENSITIVITY

	def ContainsSameItemsAs(paOtherList)
		return This.ContainsSameItemsAsCS(paOtherList, :CaseSensitive = TRUE)

	   #------------------------------------------------------------#
	  #  GETTING THE LIST OF ITEMS FORMING THE DIFFERENCE BETWEEN  #
	 #  THE MAIN LIST AND AND OTHER GIVEN LIST                    #
	#------------------------------------------------------------#

	def DifferenceWithCS(paOtherList, pCaseSensitive)
		/*
		Returns a list composed of two hashlists:
			[
			:SURPLUS = [ "A", "B", ... ],
			:LACKING = [ "X", "Y", ... ]
			]
		*/
		aResult = [
				:SURPLUS = This.OverItemsComparedToCS(paOtherList, pCaseSensitive),
				:LACKING = This.LackingItemsComparedToCS(paOtherList, pCaseSensitive)
			  ]

		return aResult

	#-- WITHOUT CASESENSITIVITY

	def DifferenceWith(paOtherList)
		return This.DifferenceWithCS(paOtherList, :CaseSensitive = TRUE)

	   #---------------------------------------------------------#
	  #  GETTING THE LIST OF ITEMS WHICH ARE DIFFERENT BETWEEN  #
	 #  THE MAIN LIST AND AND OTHER GIVEN LIST                 #
	#---------------------------------------------------------#

	def DifferentItemsWithCS(paOtherList, pCaseSensitive)
		aResult = This.OverItemsComparedToCS(paOtherList, pCaseSensitive)
		acLackingItems = This.LackingItemsComparedToCS(paOtherList, pCaseSensitive)
		nLen = len(acLackingItems)

		for i = 1 to nLen
			aResult + This[i]
		next
	
		return aResult

		def DifferentItemsWithCSQ(paOtherList, pCaseSensitive)
			return new stzList( This.DifferentItemsWithCS(paOtherList, pCaseSensitive) )

	#-- WITHOUT CASESENSITIVITY

	def DifferentItemsWith(paOtherList)
		aResult = This.OverItemsComparedTo(paOtherList)
		for item in This.LackingItemsComparedTo(paOtherList)
			aResult + item
		next
	
		return aResult

		def DifferentItemsWithQ(paOtherList)
			return new stzList( This.DifferentItemsWith(paOtherList) )

	  #--------------------------------------------------------------------#
	 #  GETTING THE OVER-ITEMS IN A GIVEN LIST COMPARED TO THE MAIN LIST  #
	#--------------------------------------------------------------------#

	def OverItemsComparedToCS(paOtherList, pCaseSensitive)
		aResult = []

		oOtherList = new stzList(paOtherList)
		nLen = This.NumberOfItems()

		for i = 1 to nLen
			item = This[i]
			if NOT oOtherList.ContainsCS(item, pCaseSensitive)
				aResult + item
			ok
		next

		return aResult

		def OverItemsComparedToCSQ(paOtherList, pCaseSensitive)
			return new stzList( This.OverItemsComparedToCS(paOtherList, pCaseSensitive) )

	#-- WITHOUT CASESENSITIVITY

	def OverItemsComparedTo(paOtherList)
		return This.OverItemsComparedToCS(paOtherList, :CaseSensitive = TRUE)

		def OverItemsComparedToQ(paOtherList)
			return new stzList( This.OverItemsComparedTo(paOtherList) )

	  #-------------------------------------------------------------------------#
	 #  GETTING THE LACKING-ITEMS IN THE LIST COMPARED TO AN OTHER GIVEN LIST  #
	#-------------------------------------------------------------------------#

	def LackingItemsComparedToCS(paOtherList, pCaseSensitive)
		aResult = []
		nLen = len(paOtherList)

		for i = 1 to nLen
			item = paOtherList[i]

			if NOT This.ContainsCS(item, pCaseSensitive)
				aResult + item
			ok
		next

		return aResult

		def LackingItemsComparedToCSQ(paOtherList, pCaseSensitive)
			return new stzList( This.LackingItemsComparedToCS(paOtherList, pCaseSensitive) )	

	#-- WITHOUT CASESENSITIVITY

	def LackingItemsComparedTo(paOtherList)
		return This.LackingItemsComparedToCS(paOtherList, :CaseSensitive = TRUE)

		def LackingItemsComparedToQ(paOtherList)
			return new stzList( This.LackingItemsComparedTo(paOtherList) )	

	  #------------------------------------------------------------------------#
	 #  CHECKING IF THE LIST HAS SAME NUMBER OF ITEMS AS AN OTHER GIVEN LIST  #
	#------------------------------------------------------------------------#

	def HasSameNumberOfItemsAsCS(paOtherList, pCaseSensitive)
		If len(paOtherList) = This.NumberOfItems()
			return TRUE
		else
			return FALSE
		ok

		def HasSameWidthAsCS(paOtherList, pCaseSensitive)
			return HasSameNumberOfItemsAsCS(paOtherList, pCaseSensitive)

		def HasSameSizeAsCS(paOtherList, pCaseSensitive)
			return HasSameNumberOfItemsAsCS(paOtherList, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def HasSameNumberOfItemsAs(paOtherList)
		return This.HasSameNumberOfItemsAsCS(paOtherList, :CaseSensitive = TRUE)

		def HasSameWidthAs(paOtherList)
			return HasSameNumberOfItemsAs(paOtherList)

		def HasSameSizeAs(paOtherList)
			return HasSameNumberOfItemsAs(paOtherList)

	  #-------------------------------------------------------------------------------------#
	 #  GETTING THE COMMON-ITEMS (INTERSECTION) BETWEEN THE MAIN LIST AN OTHER GIVEN LIST  #
	#-------------------------------------------------------------------------------------#

	def CommonItemsWithCS(paOtherList, pCaseSensitive)

		if isList(paOtherList) and Q(paOtherList).IsListOfLists()
			return This.CommonItemsWithManyCS(paListOfLists, pCaseSensitive)
		ok

		if This.NumberOfItems() <= len(paOtherList)
			aMainList  = This.List()
			aOtherList = paOtherList
		else
			aMainList  = paOtherList
			aOtherList = This.List()
		ok

		aResult = []
		nLen = len(aTempList)

		for i = 1 to nLen
			item = aMainList[i]
			if Q(aOtherList).FindFirstCS( item, pCaseSensitive ) > 0
				aResult + item
			ok
		next

		return aResult

		def CommonItemsWithCSQ(paOtherList, pCaseSensitive)
			return new stzlist( This.CommonItemsWithCS(paOtherList, pCaseSensitive) )

		def IntersectionWithCS(paOtherList, pCaseSensitive)
			return This.CommonItemsWithCS(paOtherList, pCaseSensitive)

			def IntersectionWithCSQ(paOtherList, pCaseSensitive)
				return This.CommonItemsWithCSQ(paOtherList, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def CommonItemsWith(paOtherList)
		oTempSet = new stzSet(This.List())
		return oTempSet.IntersectionWith(paOtherList)

		def CommonItemsWithQ(paOtherList)
			return new stzlist( This.CommonItemsWith(paOtherList) )

		def IntersectionWith(paOtherList)
			return This.CommonItemsWith(paOtherList)

			def IntersectionWithQ(paOtherList)
				return This.CommonItemsWithQ(paOtherList, pCaseSensitive)

	  #------------------------------------------------------------------------------------#
	 #  GETTING THE ITEMS FORMING THE INTERSECTION BETWEEN THE LIST AND MANY OTHER LISTS  #
	#------------------------------------------------------------------------------------#

	def CommonItemsWithManyCS(paListOfLists, pCaseSensitive)

		aMerged = Q(paListOfLists).Merged()
		aResult = This.CommonItemsWithCS(aMerged, pCaseSensitive)
		return aResult

		def CommonItemsWithManyCSQ(paListOfLists, pCaseSensitive)
			return new stzlist( This.CommonItemsWithManyCS(paListOfLists, pCaseSensitive) )

		def IntersectionWithManyCS(paListOfLists, pCaseSensitive)
			return This.CommonItemsWithManyCS(paListOfLists, pCaseSensitive)

			def IntersectionWithManyCSQ(paListOfLists, pCaseSensitive)
				return This.CommonItemsWithCSQ(paListOfLists, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def CommonItemsWithMany(paListOfLists)
		return This.CommonItemsWithManyCS(paListOfLists, :CaseSensitive = TRUE)

		def CommonItemsWithManyQ(paListOfLists)
			return new stzlist( This.CommonItemsWithMany(paListOfLists) )

		def IntersectionWithMany(paListOfLists)
			return This.CommonItemsWithMany(paListOfLists)

			def IntersectionWithManyQ(paListOfLists)
				return This.CommonItemsWithManyQ(paListOfLists, pCaseSensitive)

	  #------------------------------------------------------------------------#
	 #  NUMBER OF COMMON ITEMS BETWEEN THE MAIN LIST AND AN OTHER GIVEN LIST  #
	#------------------------------------------------------------------------#

	def NumberOfCommonItemsWithCS(paItems, pCaseSensitive)
		return len(This.CommonItemsWithCS(paItems, pCaseSensitive))

		def SizeOfIntersectionWithCS(paItems, pCaseSensitive)
			return NumberOfCommonItemsWithCS(paItems, pCaseSensitive)

		def CountCommonItemsWithCS(paItem, pCaseSensitive)
			return This.NumberOfCommonItemsWithCS(paItems, pCaseSensitive)

		def HowManyCommonItemsWithCS(paItem, pCaseSensitive)
			return This.NumberOfCommonItemsWithCS(paItems, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def NumberOfCommonItemsWith(paItems)
		return This.NumberOfCommonItemsWithCS(paItems, :CaseSensitive = TRUE)

		def SizeOfIntersectionWith(paItems)
			return NumberOfCommonItemsWith(paItems)

		def CountCommonItemsWith(paItem)
			return This.NumberOfCommonItemsWith(paItems)

		def HowManyCommonItemsWith(paItem)
			return This.NumberOfCommonItemsWith(paItems)

	  #---------------------------------------------------------------------------#
	 #  NUMBER OF DIFFERENT ITEMS BETWEEN THE MAIN LIST AND AN OTHER GIVEN LIST  #
	#---------------------------------------------------------------------------#

	def NumberOfDifferentItemsWithCS(paItems, pCaseSensitive)
		return len(This.DifferentItemsWithCS(paItems, pCaseSensitive))

		def CountDifferentItemsWithCS(paItem, pCaseSensitive)
			return This.NumberOfDifferentItemsWithCS(paItems, pCaseSensitive)

		def HowManyDifferentItemsWithCS(paItem, pCaseSensitive)
			return This.NumberOfDifferentItemsWithCS(paItems, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def NumberOfDifferentItemsWith(paItems)
		return This.NumberOfDifferentItemsWithCS(paItems, :CaseSensitive = TRUE)

		def CountDifferentItemsWith(paItem)
			return This.NumberOfDifferentItemsWith(paItems)

		def HowManyDifferentItemsWith(paItem)
			return This.NumberOfDifferentItemsWith(paItems)

	  #=============================#
	 #  SORTING ORDER OF THE LIST  #
	#=============================#

	def SortingOrder()
		cResult = :Unsorted

		if This.IsSorted()
			if This.IsSortedInAscending()
				cResult = :Ascending
			else
				cResult = :Descending
			ok
		ok

		return cResult

	def HasSameSortingOrderAs(paOtherList)

		oTemp = new stzList(paOtherList)
		if oTemp.SortingOrder() = This.SortingOrder()
			return TRUE
		else
			return FALSE
		ok

		def HasSameOrderAs(paOtherList)
			return This.HasSameSortingOrderAs(paOtherList)

	  #-----------------------------------#
	 #  IS THE LIST SORTED OR UNSORTED?  #
	#-----------------------------------#
 
	def IsSorted()
		if This.IsSortedInAscending() or
		   This.IsSortedInDescending()
			return TRUE
		else
			return FALSE
		ok

		def ItemsAreSorted()
			return This.IsSorted()

	def IsSortedInAscending()
		/*
		The idea is to sort a copy of the list in ascending order
		and then compare the copy to the original list...
		If they are identical, then the list is sorted in ascending order!
		*/

		oSortedInAscending = This.Copy().SortInAscendingQ()

		for i = 1 to This.NumberOfItems()
			if NOT AreEqual([ oSortedInAscending[i] , This[i] ])
				return FALSE
			ok
		next

		return TRUE

		def ItemsAreSortedInAscending()
			return This.IsSortedInAscending()

	def IsSortedInDescending()
		/*
		The idea is to reverse the list, and check if its reversed
		copy is sorted in ASCENDING order. If so, then the list itself
		is actually sorted in DESCENDING order!
		*/
		oTemp = new stzlist( This.ReversedItems() )
		if oTemp.IsSortedInAscending()
			return TRUE
		else
			return FALSE
		ok

		def ItemsAreSortedInDescending()
			return This.IsSortedInDescending()

	def IsUnsorted()
		return NOT This.IsSorted()

		def ItemsAreUnSorted()
			return This.IsUnsorted()

		def IsNotSorted()
			return NOT This.IsUnsorted()

		def ItemsAreNotSorted()
			return NOT This.IsUnsorted()

	  #-------------------------------------#
	 #  SORTABLE ITEMS & UNSORTABLE ITEMS  #
	#-------------------------------------#
 
	def SortableItems()
		/*
		Only numbers, strings, stzNumbers, and stzStrings are sortable.

		Means that lists and objects (other then stzNumber and stzString objects)
		are not sortable!

		NB: This may change in the future and other types become sortable.

		*/
		aResult = []
		for item in Content()
			if isNumber(item) or isString(item) or
			   isStzNumber(item) or isStzString(item)
				aResult + item
			ok
		next
		return aResult

	def UnsortableItems()
		/* Should be resolved by saying:
			return (This - SortableItems()).Content()

		   but this yields an error (check it!)

		  That's why, we used a more secure code, in anology to
		  the code of SortableItems()
		*/
		aResult = []
		for item in Content()
			if isNumber(item) or isString(item) or
			   isStzNumber(item) or isStzString(item)
				// do nothing, skip!
			else
				aResult + item
			ok
		next
		return aResult

	  #------------------------------------#
	 #  SORTING THE ITEM IN ASSCENDING  #
	#------------------------------------#
 
	def SortInAscending()
		/*
		Ring native sort() function can sort a list made:
			- only of numbers
			- or only of strings.

		In sofanza a list is sorted by applying 4 steps:
			1- numbers are sorted first and put at the beginning
			2- then strings are sorted and put after numbers
			3- then lists are added after strings (if any) in
			  their order of appearance
			4- then objects are added after lists (if any) in
			  their order of appearance

			NOTE: 3 and 4 steps could change in the future when
			Softanza becomes able to sort even lists  and objects!
		*/

		aNumbers = ring_sort( This.OnlyNumbers() )

		aStrings = ring_sort( This.OnlyStrings() )

		aLists = This.OnlyLists()

		aObjects = This.OnlyObjects()

		aResult = ListsMerge([ aNumbers, aStrings, aLists, aObjects ])

		This.Update( aResult )

		def SortInAscendingQ()
			This.SortInAscending()
			return This
		
		def Sort()
			This.SortInAscending()

			def SortQ()
				return This.SortInAscendingQ()

	def SortedInAscending()
		aResult = This.Copy().SortInAscendingQ().Content()
		return aResult

		def Sorted()
			return This.SortedInAscending()

	  #------------------------------------#
	 #  SORTING THE ITEM IN DESCENDING  #
	#------------------------------------#

	def SortInDescending()
 		aResult = This.SortInAscendingQ().Content()
		This.Update( ListReverse(aResult) )

		def SortInDescendingQ()
			This.SortInDescending()
			return This
			
	def SortedInDescending()
		aResult = This.Copy().SortInDescendingQ().Content()
		return aResult

	  #-------------------------------------------#
	 #  SORTING THE ITEM IN THE REVERSE ORDER  #
	#-------------------------------------------#
 
	def SortInReverseOrder()
		switch This.SortingOrder()
		on :Ascending
			This.SortInDescending()

		on: Descending
			This.SortInAscending()
		off

		def SortInReverseOrderQ()
			This.SortInReverse()
			return This

		def SortInReverse()
			This.SortInReverseOrder()

			def SortInReverseQ()
				This.SortInReverse()
				return This

	def SortedInReverse()
		aResult = This.Copy().SortInReverseQ().Content()
		return aResult

		def SortedInReverseOrder()
			return This.SortedInReverse()

	  #---------------------------------------#
	 #  SORTING THE ITEM BY - IN ASCENDING  #
	#--------------------------------------#
 
	def SortBy(pcExpr)  // TODO: TEST IT!
		/* EXAMPLE
		o1 = new stzList([ "a", "abcde", "abc", "ab", "abcd" ])
		o1.SortUsing('len(@item)')
		? o1.Content()

		#--> [ "a", "ab", "abc", "abcd", "abcde" ]

		*/
//? o1.Content()
		cCode = "value = " + StzCCodeQ(pcExpr).Transpiled()

		oTable = new stzTable([2, This.NumberOfItems()])
//oTable.Show() + NL
		
		aList = This.List()
		nLen = len(aList)

		for @i = 1 to nLen
			@item = aList[@i]
			eval(cCode)
			oTable.ReplaceRow(@i, [ @item, value ])
		next
//oTable.Show() + NL

		oTable.SortInAscending( :By = oTable.ColName(2) )
//oTable.Show() + NL
//sdsd
		aSortedList = oTable.Col(1)

		This.UpdateWith( aSortedList )

		#< @FunctionFluentForm

		def SortByQ(pcExpr)
			This.SortBy(pcExpr)
			return This

		#>

		#< @FunctionAlternativeForm

		def SortInAscendingBy(pcExpr)
			This.SortBy(pcExpr)

			def SortInAscendingByQ(pcExpr)
				This.SortInAscendingBy(pcExpr)
				return This

		#>

	def SortedBy(pcExpr)
		aResult = This.Copy().SortByQ(pcExpr).Content()
		return aResult

		def SortedInAscendingBy(pcExpr)
			return This.SortedBy(pcExpr)

	  #-----------------------------------------#
	 #  SORTING THE ITEM BY - IN DESCENDING  #
	#-----------------------------------------#
 
	def SortInDescendingBy(pcExpr)
		This.SortInAscendingBy(pcExpr)
		This.ReverseQ()

		def SortInDescendingByQ(pcExpr)
			This.SortInDescendingBy(pcExpr)
			return This

	def SortedInDescendingBy(pcExpr)
		aResult = This.Copy().SortInDescendingByQ(pcExpr).Content()
		return aResult

		def SortedInDescendingByQ(pcExpr)
			return This.SortedInDescendingBy(pcExpr)

	  #---------------------------------------#
	 #     ASSOCIATE WITH AN ANOTHER LIST    #
	#---------------------------------------#

	// Returns an Associative List (HashList) from the main list and an other list

	def AssociateWith(paOtherList)
		/* EXAMPLE

		o1 = new stzList([ "Name", "Age", "Job" ])
		o1.AssociateWith([ "Ali", 24, "Programmer" ])
		? o1.Content()

		#--> [ ["Name", "Ali"], ["Age", 24], ["Job", "Programmer"] ]

		*/

		aResult = []
		nLenThisList  = This.NumberOfItems()
		nLenOtherList = len(paOtherList)

		for i = 1 to nLenThisList
			OtherItem = NULL
			if i <= nLenOtherList
				OtherItem = paOtherList[i]
			ok

			aResult + [ This[i], OtherItem ]
		next

		This.Update( aResult )

		def AssociateWithQ(paOtherList)
			This.AssociateWith(paOtherList)
			return This

	def AssociatedWith(paOtherList)
		aResult = This.Copy().AssociateWithQ(paOtherList).Content()
		return aResult

	  #----------------------------#
	 #   REPEATED LEADING ITEMS   #
	#----------------------------#

	def HasRepeatedLeadingItems()
		if StzListQ(This.RepeatedLeadingItems()).IsEmpty()
			return FALSE
		else
			return TRUE
		ok

		def HasLeadingRepeatedItems()
			return This.HasRepeatedLeadingItems()

		def HasLeadingItems()
			return This.HasRepeatedLeadingItems()
	
	def HasRepeatedTrailingItems()
		if StzListQ(This.RepeatedTrailingItems()).IsEmpty()
			return FALSE
		else
			return TRUE
		ok

		def HasTrailingRepeatedItems()
			return This.HasRepeatedTrailingItems()

		def HasTrailingItems()
			return This.HasRepeatedTrailingItems()
	
	def RepeatedLeadingItems() # Same item is repeated at the start of the list

		/* Example:
			[ 'e', 'e', 'e', 'T', 'U', 'N', 'I', 'S' ]
			--> ['e','e','e']

			[ 'e', 'x', 'e', 'e', 'e', 'T', 'U', 'N', 'I', 'S' ]
			--> []
		*/

		if NOT This.IsEmpty()
			cResult = ""
	
			i = 1
			while This[i] = This[1] and i <= This.NumberOfItems()
				i++
			end

			if i > 2
				return This.NFirstItems(i-1)
			ok
		ok

		def RepeatedLeadingItemsQ()
			return new stzList( This.RepeatedLeadingItems() )
	
		def LeadingRepeatedItems()
			return This.RepeatedLeadingItems()

			def LeadingRepeatedItemsQ()
				return new stzList( This.LeadingRepeatedItems() )
	
		def LeadingItems()
			return This.RepeatedLeadingItems()

			def LeadingItemsQ()
				return new stzList( This.LeadingItems() )
	
	def RepeatedLeadingItem()
		if This.HasRepeatedLeadingItems()
			return This[1]
		ok

		def RepeatedLeadingItemQ()
			return Q(This.RepeatedLeadingItem())
	
		def LeadingRepeatedItem()
			return This.RepeatedLeadingItem()

			def LeadingRepeatedItemQ()
				return Q(This.LeadingRepeatedItem())
	
		def LeadingItem()
			return This.RepeatedLeadingItem()

			def LeadingItemQ()
				return Q(This.LeadingItem())
	
	def NumberOfRepeatedLeadingItems()
		if This.HasRepeatedLeadingItems()
			return StzListQ( This.RepeatedLeadingItems() ).NumberOfItems()
		else
			return 0
		ok

		#< @FunctionAlternativeForms

		def NumberOfLeadingRepeatedItems()
			return This.NumberOfRepeatedLeadingItems()

		def NumberOfLeadingItems()
			return This.NumberOfRepeatedLeadingItems()

		def CountRepeatedLeadingItems()
			return This.NumberOfRepeatedLeadingItems()

		def CountLeadingRepeatedItems()
			return This.NumberOfRepeatedLeadingItems()

		def CountLeadingItems()
			return This.NumberOfRepeatedLeadingItems()

		def HowManyRepeatedLeadingItems()
			return This.NumberOfRepeatedLeadingItems()

		def HowManyLeadingRepeatedItems()
			return This.NumberOfRepeatedLeadingItems()

		def HowmanyLeadingItems()
			return This.NumberOfRepeatedLeadingItems()

		#>

	def RepeatedLeadingItemIs(pItem)
		if This.HasRepeatedLeadingItems() and This.FirstItemQ().IsEqualTo(pItem)
			return TRUE
		else
			return FALSE
		ok

		def LeadingRepeatedItemIs(pItem)
			return This.RepeatedLeadingItemIs(pItem)

		def LeadingItemIs(pItem)
			return This.RepeatedLeadingItemIs(pItem)
	
	  #-----------------------------#
	 #   REPEATED TRAILING ITEMS   #
	#-----------------------------#

	def RepeatedTrailingItem()
		if This.HasRepeatedTrailingItems()
			return This.LastItem()
		ok

		def RepeatedTrailingItemQ()
			return Q(This.RepeatedTrailingItem())

		def TrailingRepeadtedItem()
			return This.RepeatedTrailingItem()

			def TrailingRepeatedItemQ()
				return Q(This.TrailingRepeadtedItem())

		def TrailingItem()
			return This.RepeatedTrailingItem()

			def TrailingItemQ()
				return Q(This.TrailingItem())
	
	def RepeatedTrailingItems()
		aResult = This.Copy().ReverseQ().RepeatedLeadingItems()
		return aResult

		def RepeatedTrailingItemsQ()
			return new stzList(This.RepeatedTrailingItems())
	
		def TrailingRepeatedItems()
			return This.RepeatedTrailingItems()

			def TrailingRepeatedItemsQ()
				return new stzList(This.TrailingRepeatedItems())
	
		def TrailingItems()
			return This.RepeatedTrailingItems()

			def TrailingItemsQ()
				return new stzList(This.TrailingItems())

	def NumberOfRepeatedTrailingItems()
		if This.HasRepeatedTrailingItems()
			return stzListQ( This.RepeatedTrailingItems() ).NumberOfItems()
		else
			return 0
		ok

		#< @FunctionAlternativeForms

		def NumberOfTrailingRepeatedItems()
			return This.NumberOfRepeatedTrailingItems()

		def NumberOfTrailingItems()
			return This.NumberOfRepeatedTrailingItems()

		def CountRepeatedTrailingItems()
			return This.NumberOfRepeatedTrailingItems()

		def CountTrailingRepeatedItems()
			return This.NumberOfRepeatedTrailingItems()

		def CountTrailingItems()
			return This.NumberOfRepeatedTrailingItems()

		def HowManyRepeatedTrailingItems()
			return This.NumberOfRepeatedTrailingItems()

		def HowManyTrailingRepeatedItems()
			return This.NumberOfRepeatedTrailingItems()

		def HowmanyTrailingItems()
			return This.NumberOfRepeatedTrailingItems()

		#>
	
	def RepeatedTrailingItemIs(pItem)
		if This.HasRepeatedLeadingItems() and This.LastItemQ().IsEqualTo(pItem)
			return TRUE
		else
			return FALSE
		ok

		def TrailingRepeatedItemIs(pItem)
			return This.RepeatedTrailingItemIs(pItem)

		def TrailingItemIs(pItem)
			return This.RepeatedTrailingItemIs(pItem)
	
	  #-------------------------------------#
	 #   REMOVING REPEATED LEADING ITEMS   #
	#-------------------------------------#

	def RemoveRepeatedLeadingItems()
		if This.HasRepeatedLeadingItems()
			This.RemoveFirstNItems( This.NumberOfRepeatedLeadingItems() )
		ok

		def RemoveRepeatedLeadingItemsQ()
			This.RemoveRepeatedLeadingItems()
			return This

		def RemoveLeadingRepeatedItems()
			This.RemoveRepeatedLeadingItems()

			def RemoveLeadingRepeatedItemsQ()
				This.RemoveLeadingRepeatedItems()
				return This
	
		def RemoveLeadingItems()
			This.RemoveRepeatedLeadingItems()

			def RemoveLeadingItemsQ()
				This.RemoveLeadingItems()
				return This
	
	def RepeatedLeadingItemsRemoved()
		aResult = This.Copy().RemoveRepeatedLeadingItemsQ().Content()
		return aResult

		def LeadingRepeatedItemsRemoved()
			return This.RepeatedLeadingItemsRemoved()

		def LeadingItemsRemoved()
			return This.RepeatedLeadingItemsRemoved()
	
	def RemoveRepeatedLeadingItem(pItem)
		if This.RepeatedLeadingItemQ().IsEqualTo(pItem)
			return This.RemoveRepeatedLeadingItems()
		ok

		def RemoveRepeatedLeadingItemQ(pItem)
			This.RemoveRepeatedLeadingItem(pItem)
			return This

		def RemoveLeadingRepeatedItem(pItem)
			This.RemoveRepeatedLeadingItem(pItem)

			def RemoveLeadingRepeatedItemQ(pItem)
				This.RemoveLeadingRepeatedItem(pItem)
				return This
	
		def RemoveLeadingItem(pItem)
			This.RemoveRepeatedLeadingItem(pItem)

			def RemoveLeadingItemQ(pItem)
				This.RemoveLeadingItem(pItem)
				return This
	
	def RepeatedLeadingItemRemoved(pItem)
		aResult = This.Copy().RemoveRepeatedLeadingItemQ(pItem).Content()
		return aResult

		def LeadingRepeatedItemRemoved(pItem)
			return This.RepeatedLeadingItemRemoved(pItem)

		def LeadingItemRemoved(pItem)
			return This.RepeatedLeadingItemRemoved(pItem)

	  #--------------------------------------#
	 #   REMOVING REPEATED TRAILING ITEMS   #
	#--------------------------------------#

	def RemoveRepeatedTrailingItems()
		if This.HasRepeatedTrailingItems()
			This.RemoveLastNItems( This.NumberOfRepeatedTrailingItems() )
		ok

		def RemoveRepeatedTrailingItemsQ()
			This.RemoveRepeatedTrailingItems()
			return This
	
		def RemoveTrailingRepeatedItems()
			This.RemoveRepeatedTrailingItems()

			def RemoveTrailingRepeatedItemsQ()
				This.RemoveTrailingRepeatedItems()
				return This
	
		def RemoveTrailingItems()
			This.RemoveRepeatedTrailingItems()

			def RemoveTrailingItemsQ()
				This.RemoveTrailingItems()
				return This
	
	def RepeatedTrailingItemsRemoved()
		aResult = This.Copy().RemoveRepeatedTrailingItemsQ().Content()
		return aResult

		def TrailingRepeatedItemsRemoved()
			This.RepeatedTrailingItemsRemoved()

		def TrailingItemsRemoved()
			This.RepeatedTrailingItemsRemoved()
	
	def RemoveRepeatedTrailingItem(pItem)
		if This.RepeatedTrailingItemQ().IsEqualTo(pItem)
			This.RemoveRepeatedTrailingItems()
		ok

		def RemoveRepeatedTrailingItemQ(pItem)
			This.RemoveRepeatedTrailingItem(pItem)
			return This
	
		def RemoveTrailingRepeatedItem(pItem)
			This.RemoveRepeatedTrailingItem(pItem)

			def RemoveTrailingRepeatedItemQ(pItem)
				This.RemoveTrailingRepeatedItem(pItem)
				return This
	
		def RemoveTrailingItem(pItem)
			This.RemoveRepeatedTrailingItem(pItem)

			def RemoveTrailingItemQ(pItem)
				This.RemoveTrailingItem(pItem)
				return This
	
	def RepeatedTrailingItemRemoved(pItem)
		aResult = This.Copy().RemoveRepeatedTrailingItemQ(pItem).Content()
		return aResult

		def TrailingRepeatedItemRemoved(pItem)
			return This.RepeatedTrailingItemRemoved(pItem)

		def TrailingItemRemoved(pItem)
			return This.RepeatedTrailingItemRemoved(pItem)
	
	  #--------------------------------------------------#
	 #   REMOVING REPEATED LEADING AND TRAILING ITEMS   #
	#--------------------------------------------------#

	def RemoveRepeatedLeadingItemAndTrailingItem(pItem1, pItem2)
		This.RemoveRepeatedLeadingItem(pItem1)
		This.RemoveRepeatedTrailingItem(pItem2)

		def RemoveRepeatedLeadingcharAndTrailingItemQ(pItem1, pItem2)
			This.RemoveRepeatedLeadingItemAndTrailingItem(pItem1, pItem2)
			return This

		def RemoveLeadingItemAndTrailingItem(pItem1, pItem2)
			This.RemoveRepeatedLeadingItemAndTrailingItem(pItem1, pItem2)

			def RemoveLeadingItemAndTrailingItemQ(pItem1, pItem2)
				This.RemoveLeadingItemAndTrailingItem(pItem1, pItem2)
				return This
	
		def RemoveTrailingItemAndLeadingItem(pItem1, pItem2)
			This.RemoveRepeatedLeadingItemAndTrailingItem(pItem1, pItem2)

			def RemoveTrailingItemAndLeadingItemQ(pItem1, pItem2)
				This.RemoveTrailingItemAndLeadingItem(pItem1, pItem2)
				return This
	
	def RepeatedLeadingItemAndTrailingItemRemoved(pItem1, pItem2)
		aResult = This.Copy().RemoveRepeatedLeadingItemAndTrailingItemQ(pItem1, pItem2).Content()
		return aResult

		def RepeatedTrailingItemAndLeadingItemRemoved(pItem1, pItem2)
			return This.RepeatedLeadingItemAndTrailingItemRemoved(pItem1, pItem2)

		def LeadingItemAndTrailingItemRemoved(pItem1, pItem2)
			return This.RepeatedLeadingItemAndTrailingItemRemoved(pItem1, pItem2)

		def TrailingItemAndLeadingItemRemoved(pItem1, pItem2)
			return This.RepeatedLeadingItemAndTrailingItemRemoved(pItem1, pItem2)
	
	def RemoveRepeatedLeadingAndTrailingItems()
		This.RemoveRepeatedLeadingItems()
		This.RemoveRepeatedTrailingItems()

		def RemoveRepeatedLeadingAndTrailingItemsQ()
			This.RemoveRepeatedLeadingAndTrailingItems()
			return This
	
		def RemoveLeadingAndTrailingRepeatedItems()
			This.RemoveRepeatedLeadingAndTrailingItems()

			def RemoveLeadingAndTrailingRepeatedItemsQ()
				This.RemoveLeadingAndTrailingRepeatedItems()
				return This
	
	def RepeadtedLeadingAndTrailingItemsRemoved()
		aResult = This.Copy().RemoveRepeatedLEadingAndTrailingItems()
		return aResult

		def RepeadtedTrailingAndLeadingItemsRemoved()
			return This.RepeadtedLeadingAndTrailingItemsRemoved()

		def LeadingAndTrailingItemsRemoved()
			return This.RepeadtedLeadingAndTrailingItemsRemoved()

		def TrailingAndLeadingItemsRemoved()
			return This.RepeadtedLeadingAndTrailingItemsRemoved()
	
	  #-----------------------------#
	 #   REPLACING LEADING ITEMS   #
	#-----------------------------#

	def ReplaceRepeatedLeadingItem(pItem)
		/* Example:

		StzListQ([ '_', '_', '_', 'V', 'A', 'R', '-', '-', '-' ]).ReplaceRepeatedLeadingItem(:With = "-")

		--> Gives: [ '-', '-', '-', 'V', 'A', 'R', '-', '-', '-' ]
		*/

		if isList(pItem) and Q(pItem).IsWithOrByNamedParam()
			pItem = pItem[2]
		ok

		if This.HasRepeatedLeadingItems()
			n = This.NumberOfRepeatedLeadingItems()

			for i = 1 to n
				This.ReplaceItemAtPosition(i, pItem)
			next

		ok

		#< @FunctionFluentForm

		def ReplaceRepeatedLeadingItemQ(pItem)
			This.ReplaceRepeatedLeadingItem(pItem)
			return This
			
		#>
	
		#< @FunctionAlternativeForms
	
		def ReplaceLeadingRepeatedItem(pItem)
			This.ReplaceRepeatedLeadingItem(pItem)

			def ReplaceLeadingRepeatedItemQ(pItem)
				This.ReplaceLeadingRepeatedItem(pItem)
				return This
	
		def ReplaceLeadingItem(pItem)
			This.ReplaceRepeatedLeadingItem(pItem)

			def ReplaceLeadingItemQ(pItem)
				This.ReplaceLeadingItem(pItem)
				return This

		#-- Same functions with ...Items in plural

		def ReplaceRepeatedLeadingItems(pItem)
			This.ReplaceRepeatedLeadingItem(pItem)

			def ReplaceRepeatedLeadingItemsQ(pItem)
				This.ReplaceRepeatedLeadingItems(pItem)
				return This

		def ReplaceLeadingRepeatedItems(pItem)
			This.ReplaceRepeatedLeadingItem(pItem)

			def ReplaceLeadingRepeatedItemsQ(pItem)
				This.ReplaceLeadingRepeatedItems(pItem)
				return This
	
		def ReplaceLeadingItems(pItem)
			This.ReplaceRepeatedLeadingItem(pItem)

			def ReplaceLeadingItemsQ(pItem)
				This.ReplaceLeadingItems(pItem)
				return This

		#>

	def RepeatedLeadingItemReplaced(pItem)
		aResult = This.Copy().ReplaceRepeatedLeadingItemQ(pItem).Content()
		return aResult

		#< @FunctionAlternativeForms
	
		def LeadingRepeatedItemReplaced(pItem)
			return This.RepeatedLeadingItemReplaced(pItem)
	
		def LeadingItemReplaced(pItem)
			return This.RepeatedLeadingItemReplaced(pItem)

		#-- Same functions with ...Items in plural

		def RepeatedLeadingItemsReplaced(pItem)
			return This.RepeatedLeadingItemReplaced(pItem)

		def LeadingRepeatedItemsReplaced(pItem)
			return This.RepeatedLeadingItemReplaced(pItem)
	
		def LeadingItemsReplaced(pItem)
			return This.RepeatedLeadingItemReplaced(pItem)

		#>
				
	  #------------------------------#
	 #   REPLACING TRAILING ITEMS   #
	#------------------------------#

	def ReplaceRepeatedTrailingItem(pItem)
		/* Example:

		stzListQ([ "_","_","_","V","A","R","-","-","-" ]).ReplaceRepeatedTrailingItemBy("_")

		Gives --> [ "_","_","_","V","A","R","_","_","_" ]
		*/

		if isList(pItem) and Q(pItem).IsWithOrByNamedParam()
			pItem = pItem[2]
		ok

		if This.HasRepeatedTrailingItems()
			n = This.NumberOfRepeatedTrailingItems()

			n = This.NumberOfItems() - n + 1
			for i = n to This.NumberOfItems()
				This.ReplaceItemAtPosition(i, pItem)
			next

		ok

		#< @FunctionFluentForm

		def ReplaceRepeatedTrailingItemQ(pItem)
			This.ReplaceRepeatedTrailingItem(pItem)
			return This
			
		#>
	
		#< @FunctionAlternativeForms
	
		def ReplaceTrailingRepeatedItem(pItem)
			This.ReplaceRepeatedTrailingItem(pItem)

			def ReplaceTrailingRepeatedItemQ(pItem)
				This.ReplaceTrailingRepeatedItem(pItem)
				return This
	
		def ReplaceTrailingItem(pItem)
			This.ReplaceRepeatedTrailingItem(pItem)

			def ReplaceTrailingItemQ(pItem)
				This.ReplaceTrailingItem(pItem)
				return This

		#-- Same functions with ...Items in plural

		def ReplaceRepeatedTrailingItems(pItem)
			This.ReplaceRepeatedTrailingItem(pItem)

			def ReplaceRepeatedTrailingItemsQ(pItem)
				This.ReplaceRepeatedTrailingItems(pItem)
				return This

		def ReplaceTrailingRepeatedItems(pItem)
			This.ReplaceRepeatedTrailingItem(pItem)

			def ReplaceTrailingRepeatedItemsQ(pItem)
				This.ReplaceTrailingRepeatedItems(pItem)
				return This
	
		def ReplaceTrailingItems(pItem)
			This.ReplaceRepeatedTrailingItem(pItem)

			def ReplaceTrailingItemsQ(pItem)
				This.ReplaceTrailingItems(pItem)
				return This

		#>

	def RepeatedTrailingItemReplaced(pItem)
		aResult = This.Copy().ReplaceRepeatedTrailingItemQ(pItem).Content()
		return aResult

		#< @FunctionAlternativeForms
	
		def TrailingRepeatedItemReplaced(pItem)
			return This.RepeatedTrailingItemReplaced(pItem)
	
		def TrailingItemReplaced(pItem)
			return This.RepeatedTrailingItemReplaced(pItem)

		#-- Same functions with ...Items in plural

		def RepeatedTrailingItemsReplaced(pItem)
			return This.RepeatedTrailingItemReplaced(pItem)

		def TrailingRepeatedItemsReplaced(pItem)
			return This.RepeatedTrailingItemReplaced(pItem)
	
		def TrailingItemsReplaced(pItem)
			return This.RepeatedTrailingItemReplaced(pItem)

		#>
	
	  #---------------------------------------------------#
	 #   REPLACING REPEATED LEADING AND TRAILING ITEMS   #
	#---------------------------------------------------#

	def ReplaceRepeatedLeadingItemAndTrailingItem(pItem1, pItem2)
		This.ReplaceRepeatedLeadingItemWith(pItem1)
		This.ReplaceRepeatedTrailingItemWith(pItem2)

		def ReplaceRepeatedLeadingItemAndTrailingItemQ(pItem1, pItem2)
			This.ReplaceRepeatedLeadingItemAndTrailingItem(pItem1, pItem2)
			return This

		def ReplaceRepeatedTrailingItemAndLeadingItem(pItem1, pItem2)
			This.ReplaceRepeatedLeadingItemAndTrailingItem(pItem1, pItem2)

			def ReplaceRepeatedTrailingItemAndLeadingItemQ(pItem1, pItem2)
				This.ReplaceRepeatedTrailingItemAndLeadingItem(pItem1, pItem2)
				return This
	
		def ReplaceLeadingItemAndTrailingItem(pItem1, pItem2)
			This.ReplaceRepeatedLeadingItemAndTrailingItem(pItem1, pItem2)

			def ReplaceLeadingItemAndTrailingItemQ(pItem1, pItem2)
				This.ReplaceLeadingItemAndTrailingItem(pItem1, pItem2)
				return This
	
		def ReplaceTrailingItemAndLeadingItem(pItem1, pItem2)
			This.ReplaceRepeatedLeadingItemAndTrailingItem(pItem1, pItem2)

			def ReplaceTrailingItemAndLeadingItemQ(pItem1, pItem2)
				This.ReplaceTrailingItemAndLeadingItem(pItem1, pItem2)
				return This
	
	def RepeatedLeadingcharAndTrailingItemReplaced(pItem1, pItem2)
		aResult = This.Copy().ReplaceRepeatedLeadingItemAndTrailingItemQ(pItem1, pItem2).Content()
		return aResult
	
		def RepeadtedTrailingItemAndLeadingItemReplaced(pItem1, pItem2)
			This.RepeatedLeadingcharAndTrailingItemReplaced(pItem1, pItem2)
	
		def TrailingItemAndLeadingItemReplaced(pItem1, pItem2)
			This.RepeatedLeadingcharAndTrailingItemReplaced(pItem1, pItem2)
	
	def ReplaceRepeatedLeadingAndTrailingItems(pItem)
		This.ReplaceRepeatedLeadingItem(pItem)
		This.ReplaceRepeatedTrailingItem(pItem)

		def ReplaceRepeatedLeadingAndTrailingItemsQ(pItem)
			This.ReplaceRepeatedLeadingAndTrailingItems(pItem)
			return This
	
		def ReplaceLeadingAndTrailingItems(pItem)
			This.ReplaceRepeatedLeadingAndTrailingItems(pItem)

			def ReplaceLeadingAndTrailingItemsQ(pItem)
				This.ReplaceLeadingAndTrailingItems(pItem)
				return This
	
		def ReplaceRepeatedTrailingAndLeadingItems(pItem)
			This.ReplaceRepeatedLeadingAndTrailingItems(pItem)

			def ReplaceRepeatedTrailingAndLeadingItemQ(pItem)
				This.ReplaceRepeatedTrailingAndLeadingItems(pItem)
				return This
	
		def ReplaceTrailingAndLeadingItems(pItem)
			This.ReplaceRepeatedLeadingAndTrailingItems(pItem)

			def ReplaceTrailingAndLeadingItemsQ(pItem)
				This.ReplaceTrailingAndLeadingItems(pItem)
				return This
	
	def RepeatedLeadingAndTrailingItemsReplaced(pItem)
		aResult = This.Copy().ReplaceRepeatedLeadingAndTrailingItemsQ(pItem).Content()
		return aResult

		def RepeatedTrailingAndLeadingItemsReplaced(pItem)
			return This.RepeatedLeadingAndTrailingItemsReplaced(pItem)

		def LeadingAndTrailingItemsReplaced(pItem)
			return This.RepeatedLeadingAndTrailingItemsReplaced(pItem)
	
		def TrailingAndLeadingItemsReplaced(pItem)
			return This.RepeatedLeadingAndTrailingItemsReplaced(pItem)

	  #==============================#
	 #     OPERATORS OVERLOADING    #
	#==============================#

	/*
		TODO: Operators should adopt same semantics in all classes...
	*/

	def operator(pcOp, pValue)
		
		if pcOp = "[]"

			if isNumber(pValue)
				return This.Item(pValue)

			but isString(pValue) and
			    StzStringQ(pValue).TrimQ().IsBoundedBy([ "{", "}" ])

				pcCondition = StzStringQ(pValue).TrimQ().BoundsRemoved([ "{", "}" ])
				anResult = []

				@i = 0
				for @item in This.List()
					@i++
					cCode = 'if ( ' + pcCondition + ' )' + NL +
						'	anResult + @i' + NL +
						'ok'
					eval(cCode)
				next

				return anResult
			else
				return This.FindAll(pValue)
			ok	
			
		// Add an item at the beginning of the list
		but pcOp = "<<"
			This.InsertBeforePosition(1)

		// Add an item at the end of the list
		but pcOp = ">>"
			This.Add(pValue)

		but pcOp = "="
			return This.IsEqualTo(pValue)

		but pcOp = "=="
			return This.IsStrictlyEqualTo(pValue)

		// Divides the list on pValue sublists (a list of lists)
		but pcOp = "/" 

			if isNumber(pValue)
				return This.SplitToNParts(pValue)

			but isList(pValue)
				return This.DistributeOver(pValue)
			ok

		but pcOp = "-"
			if isList(pValue) and This.ContainsNo(pValue)
				This.RemoveMany(pValue)
			
			else	
				anPositions = This.FindAll(pValue)
				This.RemoveItemsAtPositions(anPositions)
			ok
	
		but pcOp = "*"
			This.MultiplyBy(pValue)

		but pcOp = "+"
			This.AddItem(pValue)
		ok

	  #------------------------------#
	 #     CALCULATION OPERATORS    #
	#------------------------------#

	def MultiplyBy(p)	// TODO
		switch ring_type(p)
		on "NUMBER"
			aResult = []

			for i = 1 to p
				aResult + This.List()
			next

			This.Update( aResult )

		on "STRING"
			for item in This.List()
				if isString(item)
					item += p

				but isNumber(item)
					for i = 1 to p-1
						item += item
					next

				but isList(item)
					item = StzListQ(item) * p
				ok
			next

		on "LIST"
			// TODO

		other
			// TODO
		off

		#< @FunctionFluentForm

		def MultiplyByQ(p)
			This.MultiplyBy(p)
			return This

		#>

		#< @FunctionAlternativeForm

		def Multiply(p)
			This.MultiplyWith(p)

		#>

	def ItemsInPositions(panPositions)
		aResult = []
		for n in panPositions
			aResult + This.Item(n)
		next

		return aResult

		def ItemsInPositionsQ(panPositions)
			return new stzList( This.ItemsInPositions(panPositions) ) 

	def Minus(paOtherList)
		/*
		Example:
		o1 = new stzList([ "a", "b", "b", "b", "c" ])
		? o1 - [ "b", "b" ] -->  [ "a", "b", "c" ]
		*/
		aTempList = This.List()
		for item in paOtherList
			del(aTempList, ring_find(aTempList, item))
		next

		This.Update( aTempList )

		def MinusQ(paOtherList)
			This.Minus(paOtherList)
			return This

	  #----------------------------------------------#
	 #     EXTENDING THE LIST TO A GIVEN PSOTION    #
	#----------------------------------------------#

	def ExtendToPosition(n)
		if This.IsListOfNumbers()
			This.ExtendToPositionXT(n, :With = 0)

		else
			This.ExtendToPositionXT(n, :With = "")
		ok

		def ExtendToPositionQ(n)
			This.ExtendToPosition(n)
			return This

		def ExtendToPositionN(n)
			This.ExtendToPosition(n)
			
			def ExtendToPositionNQ(n)
				This.ExtendToPositionN(n)
				return This

		def ExtendTo(n)
			This.ExtendToPosition(n)
			
			def ExtendToQ(n)
				This.ExtendTo(n)
				return This

		def ExtendToN(n)
			This.ExtendToPosition(n)
			
			def ExtendToNQ(n)
				This.ExtendToN(n)
				return This

	def ExtendedToPosition(n)
		aResult = This.Copy().ExtendToPositionQ(n).Content()
		return aResult

		def ExtendedToPositionN(n)
			return This.ExtendedToPosition(n)

		def ExtendedTo(n)
			return This.ExtendedToPosition(n)

		def ExtendedToN(n)
			return This.ExtendedToPosition(n)

	  #------------------------------------------------------------------#
	 #  EXTENDING THE LIST TO A GIVEN PSOTION (XT) WITH A GIVEN VALUE   #
	#------------------------------------------------------------------#

	def ExtendToPositionXT(n, pWith)
		if NOT isNumber(n)
			StzRaise("Incorrect param! n must be a number.")
		ok

		bDynamic = FALSE

		if isList(pWith) and
		   Q(pWith).IsOneOfTheseNamedParams([ :With, :By, :Using ])

			if Q(pWith[1]).LastChar() = "@"
				bDynamic = TRUE
			ok

			pWith = pWith[2]
		ok

		if n <= This.NumberOfItems()
			StzRaise(stzListError(:CanNotExtendTheList))
		ok

		if NOT bDynamic
			for i = This.NumberOfItems() + 1 to n
				This + pWith
			next
		else
			if isString(pWith) and Q(pWith).WithoutSpaces() = "@items"

				u = 0
				for i = This.NumberOfItems() + 1 to n
					u++
					This + This[u]
				next

			but isList(pWith)

				u = 0
				for i = This.NumberOfItems() + 1 to n
					u++

					if u <= len(pWith)
						This + pWith[u]
					else
						if Q(pWith).IsListOfNumbers()
							This + 0
						else
							This + NULL
						ok
					ok
				next
			ok
		ok
	
		def ExtendToPositionXTQ(n, pWith)
			This.ExtendToPositionXT(n, pWith)
			return This

		def ExtendToPositionNXT(n, pWith)
			This.ExtendToPositionXT(n, pWith)
			
			def ExtendToPositionNXTQ(n, pWith)
				This.ExtendToPositionNXT(n, pWith)
				return This

		def ExtendToXT(n, pWith)
			This.ExtendToPositionXT(n, pWith)
			
			def ExtendToXTQ(n, pWith)
				This.ExtendToXT(n, pWith)
				return This

		def ExtendToNXT(n, pWith)
			This.ExtendToPositionXT(n, pWith)
			
			def ExtendToNXTQ(n, pWith)
				This.ExtendToNXT(n, pWith)
				return This

	def ExtendedToPositionXT(n, pWith)
		aResult = This.Copy().ExtendToPositionXTQ(n, pWith).Content()
		return aResult

		def ExtendedToPositionNXT(n, pWith)
			return This.ExtendedToPositionXT(n, pWith)

		def ExtendedToXT(n, pWith)
			return This.ExtendedToPositionXT(n, pWith)

		def ExtendedToNXT(n, pWith)
			return This.ExtendedToPositionXT(n, pWith)

	  #----------------------------------------------------#
	 #     MERGING THE LIST - IF IT IS A LIST OF LISTS    #
	#----------------------------------------------------#

	def Merge()
		# TODO: Optimise for performance

		aMerged = []
		nLen = This.NumberOfItems()

		for i = 1 to nLen
			item = This[i]
			if NOT isList(item)
				aMerged + item

			else
				nLen2 = len(item)
				for j = 1 to nLen2
					aMerged + item[j]
				next
			ok

		next

		This.Update(aMerged)

		def MergeQ()
			This.Merge()
			return This

	def Merged()
		aResult = This.Copy().MergeQ().Content()
		return aResult

	  #-----------------------------------------#
	 #   MERGING THE LIST WITH AN OTHER LIST   #
	#-----------------------------------------#

	def MergeWith(paOtherList)
		if NOT isList(paOtherList)
			StzRaise("Incorrect param! paOtherList must be a list.")
		ok

		for item in paOtherList
			This.Add(item)
		next

		def MergeWithQ(paOtherList)
			This.MergeWith(paOtherList)
			return This

	def MergedWith(paOtherList)
		aResult = This.Copy().MergeWithQ(paOtherList).Content()
		return aResult

	  #----------------------------#
	 #     FLATTENING THE LIST    #
	#----------------------------#
	
	# Works if items are numbers, strings and lists (not for objects!)
	# --> TODO: make it for objects also after making equality

	# WARNING: This uses a risky implementation that it replaces empty
	# brackes in ListToCode() with a srambled text, and then this same
	# scrambled text is replaced with []...
	# --> TODO: think of a better implementation!

	def Flatten() 

		aResult = []
	
		cListInString = ""
	
		StzStringQ( listtocode(This.Content()) ) {
			Simplify()
			ReplaceMany([ "[]", "[ ]" ], :With = "#!9#!7#EMPTYLIST#!3#!#4")
			RemoveMany([ "[", "]" ])
			ReplaceAll("#!9#!7#EMPTYLIST#!3#!#4", :With = "[]")
	
			cListInString = Content()
		}
	
		cCode = "aResult = [" + cListInString + "]"
		eval(cCode)

		This.Update( aResult )

		#< @FunctionFluentForm

		def FlattenQ()
			This.Flatten()
			return This

		def FlattenQR(pcReturnType)
			if isList(pcReturnType) and Q(pcReturnType).IsReturnedAsNamedParam()
				pcReturnType = pcReturnType[2]
			ok

			if NOT ( isString(pcReturnType) and Q(pcReturnType).IsStzClassName() )
				StzRaise("Incorrect param type! pcReturnType must be a string containing a Softanza class name.")
			ok

			switch pcReturnType
				on :stzList
					return new stzList( This.Flattened() )
				on :stzListOfStrings
					return new stzListOfStrings( This.Flattened() )

				on :stzListOfNumbers
					return new stzListOfNumbers( This.Flattened() )

				on :stzListOfLists
					return new stzListOfLists( This.Flattened() )

				on :stzListOfPairs
					return new stzListOfPairs( This.Flattened() )

				on :stzListOfObjects
					return new stzListOfObjects( This.Flattened() )

				other
					StzRaise("Unsupported return type!")
				off
		#>
	
	def Flattened()
		aResult = This.Copy().FlattenQ().Content()
		return aResult

	  #----------------------#
	 #     FROM/TO LIST     #
	#----------------------#
	
	def ToStzSet()
		return new stzSet( This.ToSet() )

	def ToStzListOfNumbers()
		return new stzListOfNumbers( This.Content() )

	def ToStzListOfLists()
		if This.IsListOfLists()
			return new stzListOfLists(This.Content())
		ok

		def ToListOfListsQ()
			return This.ToStzListOfLists()
	
	def ToStzListOfStrings()
		return new stzListOfStrings(This.Content())

	def ToListOfStrings()
		aResult = []
		nLen = This.NumberOfItems()

		for i = 1 to nLen
			aResult + @@S( This[i] )
		next

		return aResult

		def ToListOfStringsQ()
			return new stzList( This.ToListOfStrings() )
	
	def ToStzHashList()
		return new stzHashList( This.List() )
	
		def ToHashListQ()
			return This.ToStzHashList()

	def IsSet()
		bIsSet = TRUE

		for item in This.Content()
			if This.NumberOfOccurrence(item) > 1
				bIsSet = FALSE
			ok
		next

		return bIsSet

	  #-----------------------------------------------------#
	 #     NUMBER OF OCCURRENCE OF AN ITEM IN THE LIST     #
	#-----------------------------------------------------#
	
	def NumberOfOccurrenceCS(pItem, pCaseSensitive)
		if isList(pItem) and StzListQ(pItem).IsOfNamedParam()
			pItem = pItem[2]
		ok

		cItem = Q(pItem).ToCodeQ().Simplified()

		nResult = -1 + This.ToCodeQ().SimplifyQ().SplitQ(cItem).Size()
		return nResult

		#< @FunctionAlternativeForms

		def NumberOfOccurrencesCS(pItem, pCaseSensitive)
			return This.NumberOfOccurrenceCS(pItem, pCaseSensitive)

		def CountCS(pItem, pCaseSensitive)
			return NumberOfOccurrenceCS(pItem, pCaseSensitive)

		def HowManyCS(pItem, pCaseSensitive)
			return NumberOfOccurrenceCS(pItem, pCaseSensitive)

		#>

		#< @FunctionMisspelledForm

		def NumberOfOccurenceCS(pItem, pCaseSensitive)
			return This.NumberOfOccurrenceCS(pItem, pCaseSensitive)

		#

	#-- WITHOUT CASESENSITIVITY

	def NumberOfOccurrence(pItem)
		return This.NumberOfOccurrenceCS(pItem, :CaseSensitive = TRUE)

		#< @FucntionAlternativeForms

		def NumberOfOccurrences(pItem)
			return This.NumberOfOccurrence(pItem)

		def Count(pItem)
			return NumberOfOccurrence(pItem)

		def HowMany(pItem)
			return NumberOfOccurrence(pItem)

		#>
	
		#< @FunctionMisspelledForm

		def NumberOfOccurence(pItem)
			return This.NumberOfOccurrence(pItem)

		#

	  #===============================#
	 #   FINDING DUPPLICATED ITEMS   #
	#===============================#

	def FindDuplicatedItemsCS(pItem, pCaseSensitive)

		if isList(pItem) and Q(pItem).IsOfNamedParam()
			pItem = pItem[2]
		ok

		aResult = []

		if NOT This.ItemIsDuplicatedCS(pItem, pCaseSensitive)
			StzRaise("This item ("+ pItem + ") is not duplicated!")
		ok

		aResult = This.FindAllExceptFirstCS(pItem, pCaseSensitive)
		
		return aResult

		def FindDuplicatedItemsCSQ(pItem, pCaseSensitive)
			return This.FindDuplicatedItemsCS(pItem, pCaseSensitive)

		def FindDuplicatedItemsCSQR(pItem, pCaseSensitive, pcReturnType)
			if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			if NOT isString(pcReturnType)
				StzRaise("Incorrect param type! pcReturnType must be a string.")
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.FindDuplicatedItemsCS(pItem, pCaseSensitive) )

			on :stzListOfNumbers
				return new stzListOfNumbers( This.FindDuplicatedItemsCS(pItem, pCaseSensitive) )

			other
				StzRaise("Unsupported return type!")
			off

	#-- WIHTOUT CASESENSITIVITY

	def FindDuplicatedItems(pItem)
		return This.FindDuplicatedItemsCS(pItem, :CaseSensitive = TRUE)

		def FindDuplicatedItemsQ(pItem)
			return This.DuplicatedItems

		def FindDuplicatedItemsQR(pItem, pcReturnType)
			if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			if NOT isString(pcReturnType)
				StzRaise("Incorrect param type! pcReturnType must be a string.")
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.FindDuplicatedItems(pItem) )

			on :stzListOfNumbers
				return new stzListOfNumbers( This.FindDuplicatedItems(pItem) )

			other
				StzRaise("Unsupported return type!")
			off

	  #----------------------------------#
	 #   DUPPLICATED ITEMS -- EXTENDED  #
	#----------------------------------#

	def DuplicatedItemsXTCS(pCaseSensitive)
		aResult = []
		/* aResult will take the form:
		[
			[ "A", [ 5, 8, 10] ], => A is duplicated at positions 5, 8, and 10
			[ "B", [ 3 ] ],	  => B is duplicated at position 3
		 	[ ... ]
		]
		*/
		acDuplicates = This.This.DuplicatedItemsCS(pCaseSensitive)
		nLen = len(acDuplicates)

		for i = 1 to nLen
			item = acDuplicates[i]
			aResult + [ item, This.DuplicatesOfItemCS(item, pCaseSensitive) ]
		next

		return aResult

		def DuplicatesXTCS(pCaseSensitive)
			return This.DuplicatedItemsXTCS(pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def DuplicatedItemsXT()
		return This.DuplicatedItemsXTCS(:CaseSensitive = TRUE)

		return aResult

		def DuplicatesXT()
			return This.DuplicatedItemsXT()

	  #----------------------------------------#
	 #   CHECHKING IF AN ITEM IS DUPLICATED   #
	#----------------------------------------#

	def ItemIsDuplicatedCS(pItem, pCaseSensitive)
		bResult = FALSE
		nPos = This.FindFirstCS(pItem, pCaseSensitive)
		if nPos > 0
			nPos = This.FindNextCS(pItem, :StartingAt = nPos, pCaseSensitive)
			if nPos > 0
				bRersult = TRUE
			ok
		ok
		return bResult

		def ThisItemIsDuplicatedCS(pItem, pCaseSensitive)
			return This.ItemIsDuplicatedCS(pItem, pCaseSensitive)

		def ContainsThisDuplicatedItemCS(pItem, pCaseSensitive)
			return This.ItemIsDuplicatedCS(pItem, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def ItemIsDuplicated(pItem)
		return This.ItemIsDuplicatedCS(pItem, :CaseSensitive = TRUE)

		def ThisItemIsDuplicated(pItem)
			return This.ItemIsDuplicated(pItem)
	
		def ContainsThisDuplicatedItem(pItem)
			return This.ItemIsDuplicated(pItem)

	  #------------------------#
	 #   LIST OF DUPLICATES   #
	#------------------------#

	def DuplicatesCS(pCaseSensitive)

		aDuplicates = This.DuplicatesRemovedCS(pCaseSensitive)

		nLen = len(aDuplicates)
		aResult = []

		for i = 1 to nLen
			tempItem = aDuplicates[i]

			nPos1 = This.FindFirstCS(tempItem, pCaseSensitive)
			nPos2 = This.FindNextCS(tempItem, :StartingAt = nPos1, pCaseSensitive)

			if nPos2 > 0
				aResult + tempItem
			ok
		next

		return aResult

	#-- WITHOUT CASESENSITIVITY

	def Duplicates()
		return This.DuplicatesCS(:CaseSensitive = TRUE)

	  #--------------------------#
	 #   NUMBER OF DUPLICATES   #
	#--------------------------#

	def NumberOfDuplicatesCS(pCaseSensitive)
		nResult = len(This.DuplicatesCS(pCaseSensitive))

		def CountDuplicatesCS(pCaseSensitive)
			return This.NumberOfDuplicatesCS(pCaseSensitive)

		def HowManyDuplicatesCS(pCaseSensitive)
			return This.NumberOfDuplicatesCS(pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def NumberOfDuplicates()
		return This.NumberOfDuplicatesCS(:CaseSensitive = TRUE)

		def CountDuplicates()
			return This.NumberOfDuplicates()

		def HowManyDuplicates()
			return This.NumberOfDuplicates()

	  #--------------------------------------------#
	 #   CHECHKING THE LIST CONTAINS DUPLICATES   #
	#--------------------------------------------#

	def ContainsDuplicatesCS(pCaseSensitive)

		acWithoutDuplicates = This.DuplicatesRemovedCS(pCaseSensitive)

		if len(acWithoutDuplicates) != This.NumberOfItems()
			return TRUE
		else
			return FALSE
		ok

		def ContainsDuplicatedItemCS(pCaseSensitive)
			return This.ContainsDuplicatesCS(pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def ContainsDuplicates()
		return This.ContainsDuplicatesCS(:CaseSensitive = TRUE)

		def ContainsDuplicatedItem()
			return This.ContainsDuplicates(pCaseSensitive)

	  #------------------------------------------------#
	 #   CHECHKING IF AN ITEM IS DUPLICATED N TIMES   #
	#------------------------------------------------#

	def IsDuplicatedNTimesCS(n, pItem, pCaseSensitive)
		if This.NumberOfDuplicatesCS(pItem) = n
			return TRUE

		else
			return FALSE
		ok

		def ContainsNDuplicatesCS(n, pItem, pCaseSensitive)
			if isList(pItem) and Q(pItem).IsOfNamedParam()
				pItem = pItem[2]
			ok

			return This.ItemIsDuplicatedNTimesCS(n, pItem, pCaseSensitive)


	#-- WITHOUT CASESENSITIVITY

	def IsDuplicatedNTimes(n, pItem)
		return This.ItemIsDuplicatedNTimesCS(n, pItem, :CaseSensitive = TRUE)
	
		def ContainsNDuplicates(n, pItem)
			return This.ContainsNDuplicatesCS(n, pItem, :CaseSensitive = TRUE)

	  #--------------------------------------------#
	 #   HOW MANY TIMES AN ITEM IS DUPLICATED ?   #
	#--------------------------------------------#

	def NumberOfDuplicationsOfItemCS(pItem, pCaseSensitive)
		if This.ContainsCS(pItem, pCaseSensitive)
			return This.NumberOfOccurrenceCS(pItem, pCaseSensitive) - 1
		else
			return 0
		ok

		#< @FunctionAlternativeForms

		def NumberOfDuplicationsCS(pItem, pCaseSensitive)
			return This.NumberOfDuplicationsOfItemCS(pItem, pCaseSensitive)

		def CountDuplicationsCS(pItem, pCaseSensitive)
			return This.NumberOfDuplicationsOfItemCS(pItem, pCaseSensitive)

		def CountDuplicationsOfItemCS(pItem, pCaseSensitive)
			return This.NumberOfDuplicationsOfItemCS(pItem, pCaseSensitive)

		def HowManyDuplicationsCS(pItem, pCaseSensitive)
			return This.NumberOfDuplicationsOfItemCS(pItem, pCaseSensitive)

		def HowManyDuplicationsOfItemCS(pItem, pCaseSensitive)
			return This.NumberOfDuplicationsOfItemCS(pItem, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def NumberOfDuplicationsOfItem(pItem)
		return This.NumberOfDuplicationsOfItemCS(pItem, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def NumberOfDuplications(pItem)
			return This.NumberOfDuplicationsOfItem(pItem)

		def CountDuplications(pItem)
			return This.NumberOfDuplicationsOfItem(pItem)

		def CountDuplicationsOfItem(pItem)
			return This.NumberOfDuplicationsOfItem(pItem)

		def HowManyDuplications(pItem)
			return This.NumberOfDuplicationsOfItem(pItem)

		def HowManyDuplicationsOfItem(pItem)
			return This.NumberOfDuplicationsOfItem(pItem)

		#>

	  #-------------------------------#
	 #   REMOVING DUPLICATED ITEMS   #
	#-------------------------------#

	def RemoveDuplicatesCS(pCaseSensitive)
		aResult = []

		if This.IsListOfStrings()
			aResult = This.ToStzListOfStrings().
			     	       RemoveDuplicatesCSQ(pCaseSensitive).
			    	       Content()

		else
			aResult = []
			nLen = This.NumberOfItems()

			for i = 1 to nLen
				item = This.Item(i)
				if NOT Q(aResult).ContainsCS(item, pCaseSensitive)
					aResult + item
				ok
			next

		ok

		This.Update(aResult)

		def RemoveDuplicatesCSQ(pCaseSensitive)
			This.RemoveDuplicatesCS(pCaseSensitive)
			return This

		def RemoveDuplicatedItemsCS(pCaseSensitive)
			This.RemoveDuplucatesCS(pCaseSensitive)

			def RemoveDuplicatedItemsCSQ(pCaseSensitive)
				This.RemoveDuplicatedItemsCS(pCaseSensitive)
				return This

	def DuplicatesRemovedCS(pCaseSensitive)
		aResult = This.Copy().RemoveDuplicatesCSQ(pCaseSensitive).Content()
		return aResult

		def DuplicatedItemsRemovedCS(pCaseSensitive)
			return This.DuplicatesRemovedCS(pCaseSensitive)

		def UniqueItemsCS(pCaseSensitive)
			return This.DuplicatesRemovedCS(pCaseSensitive)

		def ToSetCS(pCaseSensitive)
			return This.DuplicatesRemovedCS(pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def RemoveDuplicates()
		This.RemoveDuplicatesCS(:CaseSensitive = TRUE)

		def RemoveDuplicatesQ()
			This.RemoveDuplicates()
			return This

		def RemoveDuplicatedItems()
			This.RemoveDuplucates()

			def RemoveDuplicatedItemsQ()
				This.RemoveDuplicatedItems()
				return This

	def DuplicatesRemoved()
		aResult = This.Copy().RemoveDuplicatesQ().Content()
		return aResult

		def DuplicatedItemsRemoved()
			return This.DuplicatesRemoved()

		def UniqueItems()
			return This.DuplicatesRemoved()

		def ToSet()
			return This.DuplicatesRemoved()

	  #====================#
	 #     CONTAINMENT    #
	#====================#
	/*
		Review the function namings and make the same semantics
		here and in stzString class.
	*/

	  #----------------------------------------------#
	 #  CHECKING IF THE LIST CONTAINS A GIVEN ITEM  #
	#----------------------------------------------#

	def ContainsCS(pItem, pCaseSensitive)

		if This.FindFirstCS(pItem, pCaseSensitive) > 0
			return TRUE
		else
			return FALSE
		ok

		#< @FunctionAlternativeForm

		def ContainsItemCS(pItem, pCaseSensitive)
			return This.ContainsCS(pItem, pCaseSensitive)

			def ContainsNoItemCS(pItem, pCaseSensitive)
				return NOT This.ContainsItemCS(pItem, pCaseSensitive)
	
		#>

		#< @FunctionNegativeForm
	
		def ContainsNoCS(pItem, pCaseSensitive)
			return NOT This.ContainsCS(pItem, pCaseSensitive)

		def ContainsNoneOfTheseCS(paItems, pCaseSensitive)
			bResult = TRUE
			nLen = len(paItems)
			for i = 1 to nLen
				if This.ContainsCS(paItems[i], pCaseSensitive)
					bResult = FALSE
					exit
				ok
			next
			return bRersult

		def ContainsNeitherCS(pItem1, pItem2, pCaseSensitive)
			if isList(pItem2) and Q(pItem2).IsNorNamedParam()
				pItem2 = pItem2[2]
			ok

			return This.ContainsNoneOfTheseCS([pItem1, pItem2], pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def Contains(pItem)
		return This.ContainsCS(pItem, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForm

		def ContainsItem(pItem)
			return This.Contains(pItem)

			def ContainsNoItem(pItem)
				return NOT This.ContainsItem(pItem)
	
		#>

		#< @FunctionNegativeForm
	
		def ContainsNo(pItem)
			return NOT This.Contains(pItem)

		def ContainsNoneOfThese(paItems)
			bResult = TRUE
			nLen = len(paItems)
			for i = 1 to nLen
				if This.Contains(paItems[i])
					bResult = FALSE
					exit
				ok
			next
			return bRersult

		def ContainsNeither(pItem1, pItem2)
			if isList(pItem2) and Q(pItem2).IsNorNamedParam()
				pItem2 = pItem2[2]
			ok

			return This.ContainsNoneOfThese([pItem1, pItem2])

		#>

	  #---------------------------#
	 #  CONDITIONAL CONTAINMENT  #
	#---------------------------#

	def ContainsW(pcCondition)

		cCode = 'bOk = (' + StzCCodeQ(pcCondition).Transpiled() + ')'
		nLen = This.NumberOfItems()

		bResult = FALSE

		for @i = 1 to nLen
			eval(cCode)
			if bOk
				bResult = TRUE
				exit
			ok
		next

		return bResult

	  #-------------------------------------------------------------#
	 #  CHECKING IF THE LIST IS CONTAINED IN A GIVEN LIST OR ITEM  #
	#-------------------------------------------------------------#

	def IsContainedInCS(p, pCaseSensitive)

		bResult = FALSE

		switch ring_type(p)
		on "LIST"	
			bResult = Q(p).ContainsCS( This.List(), pCaseSensitive )

		on "STRING"
			cListStringified = This.Stringified()
			bResult = StzStringQ(p).ContainsCS(cListStringified, pCaseSensitive)

		other
			# For now, number and object type are not concerned
			StzRaise("Unsupported type!")
		off

		return bResult

		#< @FunctionAlternativeForm

		def ExistsInCS(p, pCaseSensitive)
			return This.IsContainedInCS(p, pCaseSensitive)

		def IsIncludedInCS(p, pCaseSensitive)
			return This.IsContainedInCS(p, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def IsContainedIn(p)
		return This.IsContainedInCS(p, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def ExistsIn(p)
			return This.IsContainedIn(p)

		def IsIncludedIn(p)
			return This.IsContainedIn(p)

		#>

	  #--------------------------------------------------#
	 #  CHECKING IF THE LIST CONTAINS BOTH GIVEN ITEMS  #
	#--------------------------------------------------#

	def ContainsBothCS(pItem1, pItem2, pCaseSensitive)
		if isList(pItem2) and Q(pItem2).IsAndNamedParam()
			pItem2 = pItem2[2]
		ok

		return This.ContainsEachCS( [pItem1, pItem2], pCaseSensitive )

	#-- WITHOUT CASESENSITIVITY

	def ContainsBoth(pItem1, pItem2)
		return This. ContainsBothCS(pItem1, pItem2, :CaseSensitive = TRUE)

	  #--------------------------------------------------------------------#
	 #  CHECKING IF EACH ONE OF THE GIVEN ITEMS EXISTS IN THE GIVEN LIST  #
	#--------------------------------------------------------------------#
	
	def EachItemExistsInCS(paOtherList, pCaseSensitive)

		bResult = StzListQ(paOtherList).ContainsEachCS(This.List(), pCaseSensitive)

		return bResult

		def ItemsExistInCS(paOtherList, pCaseSensitive)
			return This.EachItemExistsInCS(paOtherList, pCaseSensitive)

		def AllItemsExistInCS(paOtherList, pCaseSensitive)
			return This.EachItemExistsIn(paOtherList, pCaseSensitive)

	#-- WITHOUT CASESENSITIVI

	def EachItemExistsIn(paOtherList)
		return This.EachItemExistsInCS(paOtherList, :CaseSensitive = TRUE)

		def ItemsExistIn(paOtherList)
			return This.EachItemExistsIn(paOtherList)

		def AllItemsExistIn(paOtherList)
			return This.EachItemExistsIn(paOtherList)

	  #------------------------------------------------------------#
	 #  CHECKING IF THE LIST IS ONE OF THE ITEMS OF A GIVEN LIST  #
	#------------------------------------------------------------#

	def IsOneOfTheseCS(paOtherList, pCaseSensitive)
		bResult = StzListQ(paOtherList).ContainsCS( This.List(), pCaseSensitive )
		return bResult

		def IsNotOneOfTheseCS(paOtherList, pCaseSensitive)
			return NOT This.IsOneOfTheseCS(paOtherList, pCaseSensitive)
	
	#-- WITHOUT CASESENSITIVITY

	def IsOneOfThese(paOtherList)
		return This.IsOneOfTheseCS(paOtherList, :CaseSensitive = TRUE)

		def IsNotOneOfThese(paOtherList)
			return NOT This.IsOneOfThese(paOtherList)

	  #------------------------------------------------------------#
	 #  CHECKING IF THE LIST CONTAINS EACH OF THE PROVIDED ITEMS  #
	#------------------------------------------------------------#

	def ContainsManyCS(paSetOfItems, pCaseSensitive)
		
		if NOT isList(paSetOfItems)
			StzRaise("Incorrect param type! You must provide a list.")
		ok

		bResult = TRUE

		for item in paSetOfItems
			if This.ContainsNoCS(item, pCaseSensitive)
				bResult = FALSE
				exit
			ok
		end

		return bResult

		#< @FunctionAlternativeForms

		def IsMadeOfCS(paSetOfItems, pCaseSensitive)
			return This.ContainsManyCS(paSetOfItems, pCaseSensitive)

		def IsMadeOfTheseCS(paSetOfItems, pCaseSensitive)
			return This.ContainsManyCS(paSetOfItems, pCaseSensitive)

		def ContainsEachCS(paSetOfItems, pCaseSensitive)
			return This.ContainsManyCS(paSetOfItems, pCaseSensitive)

		def ContainsEachOneOfTheseCS(paItems, pCaseSensitive)
			return This.ContainsManyCS(paSetOfItems, pCaseSensitive)

		def ContainsAllCS(paItems, pCaseSensitive)
			return This.ContainsManyCS(paSetOfItems, pCaseSensitive)

		#>

		#< @FunctionNagationForm

		def ContainsNoOneCS(paItems, pCaseSensitive)
			return NOT This.ContainsEachCS(paItems, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def ContainsMany(paSetOfItems)
		return This.ContainsManyCS(paSetOfItems, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def IsMadeOf(paSetOfItems)
			return This.ContainsMany(paSetOfItems)

		def IsMadeOfThese(paSetOfItems)
			return This.ContainsMany(paSetOfItems)

		def ContainsEach()
			return This.ContainsMany(paSetOfItems)

		def ContainsEachOneOfThese(paItems)
			return This.ContainsMany(paSetOfItems)

		def ContainsAll(paItems)
			return This.ContainsMany(paSetOfItems)

		#>

		#< @FunctionNagationForm

		def ContainsNoOne()
			return NOT This.ContainsEach(paItems)

		#>

	  #------------------------------------------------------------#
	 #  CHECKING IF THE LIST CONTAINS SOME OF THE PROVIDED ITEMS  #
	#------------------------------------------------------------#

	def ContainsSomeCS(paItems, pCaseSensitive)
		bResult = FALSE

		for item in paItems
			if This.ContainsCS(item, pCaseSensitive)
				bResult = TRUE
				exit
			ok
		next

		return bResult

		#< @FunctionAlternativeForms

		def IsMadeOfSomeCS(paSetOfItems, pCaseSensitive)
			return This.ContainsSomeCS(paSetOfItems, pCaseSensitive)

		def IsMadeOfSomeOfTheseCS(paSetOfItems, pCaseSensitive)
			return This.ContainsSomeCS(paSetOfItems, pCaseSensitive)

		def IsMadeOfOneOrMoreOfTheseCS(paSetOfItems, pCaseSensitive)
			return This.ContainsSomeCS(paSetOfItems, pCaseSensitive)

		def IsMadeOfOneOrMoreOfCS(paSetOfItems, pCaseSensitive)
			return This.ContainsSomeCS(paSetOfItems, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def ContainsSome(paSetOfItems)
		return This.ContainsSomeCS(paSetOfItems, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def IsMadeOfSome(paSetOfItems)
			return This.ContainsSome(paSetOfItems)

		def IsMadeOfSomeOfThese(paSetOfItems)
			return This.ContainsSome(paSetOfItems)

		def IsMadeOfOneOrMoreOfThese(paSetOfItems)
			return This.ContainsSome(paSetOfItems)

		def IsMadeOfOneOrMoreOf(paSetOfItems)
			return This.ContainsSome(paSetOfItems)

		#>

	  #-----------------------------------------------------------#
	 #  CHECKING IF THE LIST CONTAINS ANY OF THE PROVIDED ITEMS  #
	#-----------------------------------------------------------#

	def ContainsAnyCS(pSetOfItems, pCaseSensitive)
		/*
		Example:

		o1 = new stzList([ :monday, :monday, :monday ])
		? o1.ContainsAny([ :sunday, :monday, :saturday, :wednesday, :thirsday, :friday, :saturday ])
		#--> TRUE

		*/

		bResult = FALSE

		for item in pSetOfItems
			if This.NumberOfOccurrenceCS(item, pCaseSensitive) = This.NumberOfItems()
				bResult = TRUE
				exit
			ok
		next

		return bResult

		#< @FunctionAlternativeForms

		def ContainsOneOfTheseCS(pSetOfItems, pCaseSensitive)
			return This.ContainsAnyCS(pSetOfItems, pCaseSensitive)

		def ContainsAnyOneOfTheseCS(pSetOfItems, pCaseSensitive)
			return This.ContainsAnyCS(pSetOfItems, pCaseSensitive)

		def IsMadeOfOneOfTheseCS(pSetOfItems, pCaseSensitive)
			return This.ContainsAnyCS(pSetOfItems, pCaseSensitive)

		def ContainsOneCS(pSetOfItems, pCaseSensitive)
			return This.ContainsAnyCS(pSetOfItems, pCaseSensitive)

		def ContainsOneOfTheCS(pSetOfItems, pCaseSensitive)
			return This.ContainsAnyCS(pSetOfItems, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def ContainsAny(pSetOfItems)
		return This.ContainsAnyCS(pSetOfItems, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def ContainsOneOfThese(pSetOfItems)
			return This.ContainsAny(pSetOfItems)

		def ContainsAnyOneOfThese(pSetOfItems)
			return This.ContainsAny(pSetOfItems)

		def IsMadeOfOneOfThese(pSetOfItems)
			return This.ContainsAny(pSetOfItems)

		def ContainsOne(pSetOfItems)
			return This.ContainsAny(pSetOfItems)

		def ContainsOneOfThe(pSetOfItems)
			return This.ContainsAny(pSetOfItems)

		#>

	  #----------------------------------------------------------------#
	 #  CHECKING IF THE LIST CONTAINS ONLY ONE OF THE PROVIDED ITEMS  #
	#----------------------------------------------------------------#

	def ContainsOnlyOneCS(paItems, pCaseSensitive)
		bResult = FALSE
		for item in paItems
			if This.IsMadeOfItemCS(item, pCaseSensitive)
				bResult = TRUE
				exit
			ok
		next
		return bResult

		#< @FunctionAlternativeForms

		def ContainsOnlyOneOfTheseCS(paItems, pCaseSensitive)
			return This.ContainsOnlyOneCS(paItems, pCaseSensitive)

		def IsMadeOfOnlyOneOfTheseCS(paItems, pCaseSensitive)
			return This.ContainsOnlyOneCS(paItems, pCaseSensitive)

		def ContainsAnItemFromCS(paItems, pCaseSensitive)
			return This.ContainsOnlyOneCS(paItems, pCaseSensitive)

		def ContainsAnItemFromTheseCS(paItems, pCaseSensitive)
			return This.ContainsOnlyOneCS(paItems, pCaseSensitive)

		def ContainsOneItemFromCS(paItems, pCaseSensitive)
			return This.ContainsOnlyOneCS(paItems, pCaseSensitive)

		def ContainsOneItemFromTheseCS(paItems, pCaseSensitive)
			return This.ContainsOnlyOneCS(paItems, pCaseSensitive)

		def ContainsOnlyOneOfTheCS(paItems, pCaseSensitive)
			return This.ContainsOnlyOneCS(paItems, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def ContainsOnlyOne(paItems)
		return This.ContainsOnlyOneCS(paItems, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def ContainsOnlyOneOfThese(paItems)
			return This.ContainsOnlyOne(paItems)

		def IsMadeOfOnlyOneOfThese(paItems)
			return This.ContainsOnlyOne(paItems)

		def ContainsAnItemFrom(paItems)
			return This.ContainsOnlyOne(paItems)

		def ContainsAnItemFromThese(paItems)
			return This.ContainsOnlyOne(paItems)

		def ContainsOneItemFrom(paItems)
			return This.ContainsOnlyOne(paItems)

		def ContainsOneItemFromThese(paItems)
			return This.ContainsOnlyOne(paItems)

		def ContainsOnlyOneOfThe(paItems)
			return This.ContainsOnlyOne(paItems)

		#>

	  #---------------------------------------------------------#
	 #  CHECKING IF THE LIST CONTAINS N OF THE PROVIDED ITEMS  #
	#---------------------------------------------------------#

	def ContainsNCS(n, paItems, pCaseSensitive)
		bResult = FALSE
		m = 0
		for pItem in paItems
			if This.ContainsCS(pItem, pCaseSensitive)
				m++
				if n = m
					bResult = TRUE
					exit
				ok
			ok
		next

		return bResult

		def ContainsNOfCS(n, paItems, pCaseSensitive)
			return This.ContainsNCS(n, paItems, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def ContainsN(n, paItems)
		return This.ContainsNCS(n, paItems, :CaseSensitive = TRUE)

		def ContainsNOf(n, paItems)
			return This.ContainsN(n, paItems)

	  #-----------------------------------------#
	 #  CHECKING IF THE LIST CONTAINS NUMBERS  #
	#-----------------------------------------#

	def ContainsNumbers()
		bResult = FALSE

		for item in This.List()
			if isNumber(item)
				bResult = TRUE
				exit
			ok
		next

		return bResult

		def ContainsNoNumbers()
			return NOT This.ContainsNumbers()

	  #-----------------------------------------#
	 #  CHECKING IF THE LIST CONTAINS STRINGS  #
	#-----------------------------------------#

	def ContainsStrings()
		bResult = FALSE

		for item in This.List()
			if isString(item)
				bResult = TRUE
				exit
			ok
		next

		return bResult

		def ContainsNoStrings()
			return NOT This.ContainsStrings()

	  #---------------------------------------#
	 #  CHECKING IF THE LIST CONTAINS LISTS  #
	#---------------------------------------#

	def ContainsLists()
		bResult = FALSE

		for item in This.List()
			if isList(item)
				bResult = TRUE
				exit
			ok
		next

		return bResult

		def ContainsNoLists()
			return NOT This.ContainsLists()

	  #-----------------------------------------#
	 #  CHECKING IF THE LIST CONTAINS OBJECTS  #
	#-----------------------------------------#

	def ContainsObjects()
		for item in This.List()
			if isObject(item)
				return TRUE
			ok
		next

	def ContainsNoObjects()
		return NOT This.ContainsObjects()

	def ContainsObjectsAtSomeLevel() // TODO: Review this risky implementation!
		/*
		This solution is build upon the observation that
		list2code() Ring functions generates empty string
		for objects.

		Hence, list2Code([ 1, 2, "C"]) generates '[1,2,"C"]'
		but:
			o1 = new stzString("C")
			? list2code([ 1, 2, o1, "C"]) generates:

			'[1,2,,"C"]'

		As you can see, we can know that an object exists by
		analyzing list2code() for any generated empty string!

		WARNING: if Ring enhances this function to generate the
		name of the object, for example, then the logic used
		here must change accordingly...
		*/

		oCode = StzStringQ( list2code( This.List() ) )

		if oCode[4] = "," or
		   oCode[ oCode.NumberOfChars()-3 ] = "," or
		   oCode.Contains(",,") or
		   oCode.Contains("[,") or
		   oCode.Contains(",]")

			return TRUE
		else
			return FALSE
		ok
	
	def ContainsNoObjectsAtAnyLevel()
		return NOT This.ContainsObjectsAtSomeLevel()

	def ContainsAtAnyLevel(pItem) # TODO
		// TODO

	  #======================#
	 #    LIST STRUCTURE    #
	#======================#

	/*
	TODO:

	- Reveiew this section (its functions and its semantics)
	- Avoid using _ in names of functions

	- Merge with the next sections:
		LEVELS OF THE LIST, and
		SUBLISTS OF THE LIST --> LISTS IN LEVEL 1 OF THE LIST

	- Insure they are all consistent and correct

	*/

	def ContainsOneOrMoreLists()
		if This.WalkUntilItemIsList() != NULL
			return TRUE
		else
			return FALSE
		ok

	def FirstList()
		If This.WalkUntilItemIsList() != NULL
			return This.LastItemIn( This.WalkUntilItemIsList() )
		ok

		def FirstListQ()
			return new stzList( This.FirstList() )

	def ListsPaths()
		return This.ItemsThatAreLists_AtAnyLevel_TheirPaths() # TODO: Refactor this!

		def ListsPathsQ()
			return new stzList( This.ListsPaths() )

	def ItemsThatAreLists_AtAnyLevel_TheirPaths()
		aResult = []
		aInfo = This.ItemsThatAreLists_AtAnyLevel_XT()
		for info in aInfo
			aResult + info[1][2]	// GetItemByPath(x,y) : Generalize!!!
		next
		
		return aResult

		def ItemsThatAreLists_AtAnyLevel_TheirPathsQ()
			return new stzList( This.ItemsThatAreLists_AtAnyLevel_TheirPaths() )

	def ItemByPath(panPath)
		if This.ContainsItemOnPath(panPath)
			cCode = "Result = "
			cCode += GenerateListAccessCode_FromNameAndPath("This.Content()", panPath)
			eval(cCode)
			return Result
		ok

		def ItemByPathQ(panPath)
			item = This.ItemByPath(panPath)
			switch ring_type( item )
			on "NUMBER"
				return new stzNumer(""+ item)

			on "STRING"
				return new stzString(item)

			on "LIST"
				return new stzList(item)

			on "OBJECT"
				return new stzObject(item)

			other
				StzRaise("Unsupported type!")
			off

	def Paths()
		// TODO

	def ItemsAndTheirPaths()
		// TODO

	def IncludesPath(panPath)
		return StzListQ( This.Paths() ).Contains(panPath)

	def ContainsItemOnPath(panPath)
		# TODO

	def ContainsListOnPath(panPath)
		try
			cCode = "TempItem = "
			cCode += GenerateListAccessCode_FromNameAndPath("This.Content()",panPath)
	
			eval(cCode)
			if isList(TempItem)
				return TRUE
			else
				return FALSE
			ok
		catch
			return FALSE
			// Report Ring bug: catch region does not consider more then 1 line!
		done

		
	def NumberOfLists_AtAnyLevel()
		return len( This.ItemsThatAreLists_AtAnyLevel_XT() )

	def ItemsThatAreLists_AtAnyLevel()
		aResult = []
		
		for anPath in This.ItemsThatAreLists_AtAnyLevel_TheirPaths()
			
			cPath = "aTempList = "
			cPath += GenerateListAccessCode_FromNameAndPath("This.Content()", anPath)

			eval(cPath)
			aResult + aTempList
		next
		return aResult


	def ItemsThatAreLists_InLevel(n)
		// TODO

	def ItemsThatAreLists_InPositionN_AtAnyLevel(n)
		// TODO

	def ItemsInLevel(n)
		// TODO

	def ItemsInPositionN_AtAnyLevel(n)
		// TODO

	// Returns a stzListOfHashlists:
	// for each list: its path, level and position.
	def ItemsThatAreLists_AtAnyLevel_XT()
		
		aResult = []
		aPath = []

		nLevel = -1
		nPosition = -1

		for c in list2code(This.Content())
			if c = "["
				nLevel++
				if nPosition > -1
					aPath + (nPosition+1)
				else
					aPath = []
				ok
				aResult + [ :Path = aPath, :Level = nLevel, :Position = nPosition+1 ]
				
				nPosition = 0

			but c = "]"
				nLevel--
				if len(aPath) > 0
					del(aPath, len(aPath))
				ok

			but c = ","
				nPosition++
				
			ok
			
		next
		oResult = new stzList(aResult)
		return oResult.Section(2, oResult.NumberOfItems())

		def ItemsThatAreLists_AtAnyLevel_XTQ()
			return new stzList( This.ItemsThatAreLists_AtAnyLevel_XT() )

	def NumberOfLevels()
				
		oCopy = @@SQ( This.Content() ).RemoveSectionsBetweenXTQ("]","[")
		nResult = oCopy.NumberOfOccurrence("[")

		return nResult

		def CountLevels()
			return This.NumberOfLevels()

		def HowManyLevels()
			return This.NumberOfLevels()

	def Depth()
		return This.NumberOfLevels()

	def ItemsThatAre_Lists_AtAnyLevel()
		aResult = []
		n = 0
		n1 = 0
		n2 = 0

		oListInString = StzStringQ( list2code(This.Content()) )

		bInsideList = FALSE
		for i = 2 to oListInString.NumberOfChars() - 1

			c = oListInString[i]

			if c = "["
				bInsideList = TRUE
				n1 = i
			ok

			if c = "]" and bInsideList = TRUE
				n2 = i
				cCode = oListInString.Section(n1, n2)
				eval("aTempList = " + cCode)

				aResult + aTempList
				bInsideList = FALSE
			ok
			
		next

		return aResult

		def ItemsThatAre_Lists_AtAnyLevelQ()
			return new stzListOfLists( This.ItemsThatAre_Lists_AtAnyLevel() )
			
	def ListsAtAnyLevel()
		return This.ItemsThatAre_Lists_AtAnyLevel()

		def ListsAtAnyLevelQ()
			return new stzListOfLists( This.ListsAtAnyLevel() )
	
	def SublistsAtAnyLevel()
		return ListsAtAnyLevel()

		def SublistsAtAnyLevelQ()
			return This.ListsAtAnyLevelQ()
	
	def Structure()
		// TODO
		
	def ShowStructure()
		/* Generates a treeview like this:
			LIST[]
			|
			+-- cItem1
			|
			+-- Item2[]
			| |
			| +-- nItem2.1
			| |
                        | +-- oItem2.2
			|
			+-- nItem3
		*/

	def Show()
		if This.IsHashList()
			StzHashListQ( This.List() ).Show()

		but This.IsListOfHashLists()
			StzListOfHashListsQ( This.List() ).Show()

		other
			? @@S( This.Content() )
		ok

	  #---------------------------#
	 #     LEVELS OF THE LIST    #
	#---------------------------#

	def Levels()
		// TODO

	def NthLevel(n)
		// TODO

	def ContentOfLevel(n)
		// TODO

		def ItemsOfLevel(n)
			return This.ContentOfLevel(n)

	def LevelsAndTheirItems()
		// TODO

	  #-----------------------------------------------------------#
	 #   SUBLISTS OF THE LIST --> LISTS IN LEVEL 1 OF THE LIST   #
	#-----------------------------------------------------------#

	def Sublists()
		aResult = []
		for item in This.List()
			if isList(item)
				aResult + item
			ok
		next
		return aResult

		#< @FunctionFluentForm

		def SubListsQ()
			return new stzList( This.Sublists() )

		#>

	def SublistsNumberOfItems()
		aResult = []
		for item in This.List()
			if isList(item)
				aResult + len(item)
			ok
		next
		return aResult
		
	def SublistsHaveSameNumberOfItems()
		bResult = TRUE
		for i=2 to len( This.Sublists() )
			if len( This.Sublists()[i] ) != len( This.Sublists()[i-1] )
				bResult = FALSE
			ok
		next
		return bResult

	def SublistsAtAnyLevelHaveSameNumberOfItems()
		bResult = TRUE
		for i=2 to len( This.SublistsAtAnyLevel() )
			if len( This.SublistsAtAnyLevel()[i] ) != len( This.SublistsAtAnyLevel()[i-1] )
				bResult = FALSE
			ok
		next
		return bResult
		
	  #--------------------------------------#
	 #  FINDING ALL OCCURRENCES OF AN ITEM  #
	#--------------------------------------#

	def FindAllOccurrencesCS(pItem, pCaseSensitive)

		if isList(pItem) and StzListQ(pItem).IsOfNamedParam()
			pItem = pItem[2]
		ok
	
		if NOT This.ContainsCS(pItem, pCaseSensitive)
			return []
		ok

		nLen = This.NumberOfItems()
		anResult = []

		# Managing the first item apart

		firstItem = This.FirstItem()

		if isNumber(firstItem) or isObject(firstItem)
		# they do not support case sensitivity --> use IsEqualTo()

			if This.FirstItemQ().IsEqualTo(pItem)
				anResult + 1
			ok

		else # isList or isString
		# they do support case sensitivity --> use IsEqualToCS()

			if This.FirstItemQ().IsEqualToCS(pItem, pCaseSensitive)
				anResult + 1
			ok
		ok

		# Managing the rest of the list

		nPos = 1
		n = 0
		nMax = This.NumberOfOccurrenceCS(pItem, pCaseSensitive)

		while TRUE
			n++
			if n > nLen or len(anResult) = nMax
				exit
			ok

			nPos = This.FindNextCS(pItem, :StartingAt = nPos, pCaseSensitive)

			if nPos != 0
				anResult + nPos

			else
				exit
			ok
		end

		return anResult

		#< @FunctionFluentForm

		def FindAllOccurrencesCSQ(pItem, pCaseSensitive)
			return This.FindAllOccurrencesCSQR(pItem, pCaseSensitive, :stzList)

		def FindAllOccurrencesCSQR(pItem, pCaseSensitive, pcReturnType)
			if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.FindAllCS(pItem, pCaseSensitive) )

			on :stzListOfNumbers
				return new stzListOfNumbers( This.FindAllCS(pItem, pCaseSensitive) )

			on :stzListOfUnicodes
				return new stzListOfUnicodes( This.FindAllCS(pItem, pCaseSensitive) )

			on :stzListOfStrings
				return new stzListOfStrings( This.FindAllCS(pItem, pCaseSensitive) )

			on :stzListOfChars
				return new stzListOfChars( This.FindAllCS(pItem, pCaseSensitive) )

			on :stzListOfLists
				return new stzListOfLists( This.FindAllCS(pItem, pCaseSensitive) )

			on :stzListOfPairs
				return new stzListOfPairs( This.FindAllCS(pItem, pCaseSensitive) )

			on :stzListOfSets
				return new stzListOfSets( This.FindAllCS(pItem, pCaseSensitive) )

			on :stzListOfHashLists
				return new stzListOfHashLists( This.FindAllCS(pItem, pCaseSensitive) )

			on :stzListOfGrids
				return new stzListOfGrids( This.FindAllCS(pItem, pCaseSensitive) )

			on :stzListOfTables
				return new stzListOfTables( This.FindAllCS(pItem, pCaseSensitive) )

			on :stzListOfEntities
				return new stzListOfEntities( This.FindAllCS(pItem, pCaseSensitive) )

			on :stzListOfBytes
				return new stzListOfBytes( This.FindAllCS(pItem, pCaseSensitive) )

			on :stzListOfObjects
				return new stzListOfObjects( This.FindAllCS(pItem, pCaseSensitive) )

			other
				StzRaise("Unsupported type!")
			off

		#>

		#< @FunctionAlternativeForms

		def FindAllCS(pItem, pCaseSensitive)
			return This.FindAllOccurrencesCS(pItem, pCaseSensitive)

			#< @FunctionFluentForm

			def FindAllCSQ(pItem, pCaseSensitive)
				return This.FindAllCSQR(pItem, pCaseSensitive, :stzList)
	
			def FindAllCSQR(pItem, pCaseSensitive, pcReturnType)
				return This.FindAllOccurrencesCSQR(pItem, pCaseSensitive, pcReturnType)
			#>

		def FindItemCS(pItem, pCaseSensitive)
			return This.FindAllOccurrencesCS(pItem, pCaseSensitive)

			#< @FunctionFluentForm

			def FindItemCSQ(pItem, pCaseSensitive)
				return This.FindItemCSQR(pItem, pCaseSensitive, :stzList)
	
			def FindItemCSQR(pItem, pCaseSensitive, pcReturnType)
				return This.FindAllCSQR(pItem, pCaseSensitive, pcReturnType)
			#>

		def PositionsCS(pItem, pCaseSensitive)
			return This.FindAllOccurrencesCS(pItem, pCaseSensitive)

			#< @FunctionFluentForm

			def PositionsCSQ(pItem, pCaseSensitive)
				return This.PositionsCSQR(pItem, pCaseSensitive, :stzList)
	
			def PositionsCSQR(pItem, pCaseSensitive, pcReturnType)
				return This.FindAllCSQR(pItem, pCaseSensitive, pcReturnType)
			#>

		def OccurrencesCS(pItem, pCaseSensitive)
			return This.FindAllOccurrencesCS(pItem, pCaseSensitive)

			#< @FunctionFluentForm

			def OccurrencesCSQ(pItem, pCaseSensitive)
				return This.OccurrencesCSQR(pItem, pCaseSensitive, :stzList)
	
			def OccurrencesCSQR(pItem, pCaseSensitive, pcReturnType)
				return This.FindAllCSQR(pItem, pCaseSensitive, pcReturnType)
			#>

		def FindCS(pItem, pCaseSensitive)
			if isList(pItem) and Q(pItem).IsItemNamedParam()
				pItem = pItem[2]
			ok

			return This.FindAllOccurrencesCS(pItem, pCaseSensitive)

			def FindCSQ(pItem, pCaseSensitive)
				return This.FindCSQR(pItem, pCaseSensitive, pcReturnType)

			def FindCSQR(pItem, pCaseSensitive, pcReturnType)
				return This.FindAllCSQR(pItem, pCaseSensitive, pcReturnType)

		#>
	

	#-- WITHOUT CASESENSITIVITY

	def FindAllOccurrences(pItem)

		return This.FindAllOccurrencesCS(pItem, :CaseSensitive = TRUE)

		#< @FunctionFluentForm

		def FindAllOccurrencesQ(pItem)
			return This.FindAllOccurrencesQR(pItem, :stzList)

		def FindAllOccurrencesQR(pItem, pcReturnType)
			return This.FindAllOccurrencesCSQR(pItem, :CS = TRUE, pcReturnType)
		#>

		#< @FunctionAlternativeForms

		def FindAll(pItem)
			return This.FindAllOccurrences(pItem)

			#< @FunctionFluentForm

			def FindAllQ(pItem)
				return This.FindAllQR(pItem, :stzlist)
	
			def FindAllQR(pItem, pcReturnType)
				return This.FindAllOccurrencesQR(pItem, pcReturnType)
	
			#>

		def FindItem(pItem)
			return This.FindAllOccurrences(pItem)

			#< @FunctionFluentForm

			def FindItemQ(pItem)
				return This.FindItemQR(pItem, :stzList)
	
			def FindItemQR(pItem, pcReturnType)
				return This.FindAllOccurrencesQR(pItem, pcReturnType)
			#>

		def Positions(pItem)
			return This.FindAllOccurrences(pItem)

			#< @FunctionFluentForm

			def PositionsQ(pItem)
				return This.PositionsQR(pItem, :stzList)
	
			def PositionsQR(pItem, pcReturnType)
				return This.FindAllOccurrencesQR(pItem, pcReturnType)
			#>

		def Occurrences(pItem)
			return This.FindAllOccurrences(pItem)

			#< @FunctionFluentForm

			def OccurrencesQ(pItem)
				return This.OccurrencesQR(pItem, :stzList)
	
			def OccurrencesQR(pItem, pcReturnType)
				return This.FindAllOccurrencesQR(pItem, pcReturnType)
			#>

		def Find(pItem)
			if isList(pItem) and Q(pItem).IsItemNamedParam()
				pItem = pItem[2]
			ok

			return This.FindAllOccurrences(pItem)

			#< @FunctionFluentForm

			def FindQ(pItem)
				return This.FindQR(pItem, :stzList)
	
			def FindQR(pItem, pcReturnType)
				return This.FindAllOccurrencesQR(pItem, pcReturnType)
			#>
		#>

	  #-------------------------------------------------------#
	 #    FINDING N OCCURRENCES OF AN ITEM INSIDE THE LIST   #
	#-------------------------------------------------------#

	# Finding works only for numbers and strings

	# TODO : Lists and objects will become findable after
	# designing an overall solution of the Equality problem
	# in SoftanzaLib

	# UPDATE: Lists are now findable (only objects are left for future)

	def FindNthOccurrenceCS(n, pItem, pCaseSensitive)
		/* EXAMPLE

		o1 = new stzList([ 1, 2, "*", 4, 5, "*", 7, 8, "*", 10 ])
		? o1.FindNth(3, "*")
		#--> 9

		*/

		if isObject(pItem)
			StzRaise("Can't process! Objects can not be found yet.")
		ok

		if isString(n)
			if n = :First or n = :FirstOccurrence
				return This.FindFirstCS(pItem, pCaseSensitive)

			but n = :Last or n = :LastOccurrence
				return This.FindLastCS(pItem, pCaseSensitive)
			ok

		but isNumber(n) and n = 1
			return This.FindFirstCS(pItem, pCaseSensitive)

		ok

		if NOT This.ContainsCS(pItem, pCaseSensitive)
			return 0
		ok

		if NOT isNumber(n)
			StzRaise("Incorrect param type! n must be a number.")
		ok

		if n > This.NumberOfOccurrenceCS(pItem, pCaseSensitive)
			return 0
		ok

		#-- Doing the job

		cType = ring_type(pItem)

		if cType = "STRING" or cType = "NUMBER"
			
			nLenList = This.NumberOfItems()
			nStart = 1
			nTimes = 0
			nResult = 0

			bContinue = TRUE
			while bContinue
				aSection = This.Section(nStart, nLenList)
			
				nPos = ring_find( aSection, pItem )
				nPos += nStart - 1
				if nPos = 0
					exit
				ok

				nTimes++

				if nTimes = n
					nResult = nPos - 1
					return nPos	
				else
					nStart = nPos + 1
				ok
			end

		but cType = "LIST"

			# Turning the pItem to a string
			# (we use stzString for better performance)

			cPItem = Q(pItem).ToCodeQ().Simplified()
		
			# Parsing the list. When an item is
			# a list, then check if it could be
			# equal to pItem

			aList = This.List()
			nLen = This.NumberOfItems()
			nResult = 0
			
			nTimes = 0

			for i = 1 to nLen
				
				item = aList[i]
						
				if isList(item)

					cItem = Q(item).ToCodeQ().Simplified()
	
					if cItem = cPItem
						nTimes++
	
						if nTimes = n
							return i
						ok
					ok

				ok
		
			next
		ok

		return FALSE

		#< @FunctionAlternativeForms

		def FindNthItemCS(n, pItem, pCaseSensitive)
			return This.FindNthOccurrenceCS(n, pItem, pCaseSensitive)

		def FindNthCS(n, pItem, pCaseSensitive)
			return This.FindNthOccurrenceCS(n, pItem, pCaseSensitive)

		def NthCS(n, pItem, pCaseSensitive)
			return This.FindNthOccurrenceCS(n, pItem, pCaseSensitive)

		def NthOccurrenceCS(n, pItem, pCaseSensitive)
			return This.FindNthOccurrenceCS(n, pItem, pCaseSensitive)

		def ItemPositionByOccurrenceCS(n, pItem, pCaseSensitive)
			return This.FindNthOccurrenceCS(n, pItem, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindNthOccurrence(n, pItem) 
		return This.FindNthOccurrenceCS(n, pItem, :CaseSensitive = TRUE) 

		#< @FunctionAlternativeForms

		def FindNthItem(n, pItem)
			return This.FindNthOccurrence(n, pItem)

		def FindNth(n, pItem)
			return This.FindNthOccurrence(n, pItem)

		def Nth(n, pItem)
			return This.FindNthOccurrence(n, pItem)

		def NthOccurrence(n, pItem)
			return This.FindNthOccurrence(n, pItem)

		def ItemPositionByOccurrence(n, pItem)
			return This.FindNthOccurrence(n, pItem)

		#>

	  #---------------------------------------------------------------#
	 #  CHECKING IF THE LIST CONTAINS N OCCURRENCES OF A GIVEN ITEM  #
	#---------------------------------------------------------------#

	def ContainsNOccurrencesCS(n, pItem, pCaseSensitive)
		if This.NumberOfOccurrenceCS(pItem, pCaseSensitive) = n
			return TRUE
		else
			return FALSE
		ok

	def ContainsNOccurrences(n, pItem)
		return This.ContainsNOccurrences(n, pItem, :CaseSensitive = TRUE)

	  #----------------------------------------------------------------#
	 #    FINDING NTH TO LAST OCCURRENCE OF AN ITEM INSIDE THE LIST   #
	#----------------------------------------------------------------#

	def NthToLast(n)
		return This.ItemAtPosition( This.NumberOfItems() - n )

	  #----------------------------------------------------------------#
	 #    FINDING NTH TO LAST OCCURRENCE OF AN ITEM INSIDE THE LIST   #
	#----------------------------------------------------------------#

	def NthToFirst(n)
		return This.ItemAtPosition(n + 1)

	  #---------------------------------------------------#
	 #  FINDING FIRST OCCURRENCE OF AN ITEM IN THE LIST  #
	#---------------------------------------------------#

	def FindFirstOccurrenceCS(pItem, pCaseSensitive)
		if isList(pItem) and Q(pItem).IsOfNamedParam()
			pItem = pItem[2]
		ok

		if isObject(pItem)
			StzRaise("Can't process! Objects can not be found yet.")
		ok

		cItem = Q(pItem).Stringified()

		acSplitted = This.ToCodeQ().SplitCS(cItem, pCaseSensitive)

		nResult = 0

		if len(acSplitted) > 1

			nResult = Q(acSplitted[1]).
				  NumberOfOccurrence(",") + 1
		ok

		return nResult

		#< @FunctionAlternativeForms

		def FindFirstCS(pItem, pCaseSensitive)
			return This.FindFirstOccurrenceCS(pItem, pCaseSensitive)

		def FirstOccurrenceCS(pItem, pCaseSensitive)
			return This.FindFirstOccurrenceCS(pItem, pCaseSensitive)

		def FirstCS(pItem, pCaseSensitive)
			return This.FindFirstOccurrenceCS(pItem, pCaseSensitive)

		def PositionOfFirstCS(pItem, pCaseSensitive)
			return This.FindFirstOccurrenceCS(pItem, pCaseSensitive)

		def PositionOfFirstOccurrenceCS(pItem, pCaseSensitive)
			return This.FindFirstOccurrenceCS(pItem, pCaseSensitive)
	
		#>

	#-- WITHOUT CASESENSITIVITY

	def FindFirstOccurrence(pItem)
		return This.FindFirstOccurrenceCS(pItem, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindFirst(pItem)
			return This.FindFirstOccurrence(pItem)

		def FirstOccurrence(pItem)
			return This.FindFirstOccurrence(pItem)

		def First(pItem)
			return This.FindFirstOccurrence(pItem)

		def PositionOfFirst(pItem)
			return This.FindFirstOccurrence(pItem)

		def PositionOfFirstOccurrence(pItem)
			return This.FindFirstOccurrence(pItem)
	
		#>

	  #--------------------------------------------------#
	 #  FINDING LAST OCCURRENCE OF AN ITEM IN THE LIST  #
	#--------------------------------------------------#

	def FindLastOccurrenceCS(pItem, pCaseSensitive)

		if isObject(pItem)
			StzRaise("Can't process! Objects can not be found yet.")
		ok

		if NOT This.ContainsCS(pItem, pCaseSensitive)
			return 0
		ok

		cType = ring_type(pItem)

		if cType = "STRING" or cType = "NUMBER"

			n = ring_find( ring_reverse(This.List()), pItem )

			if n = 0
				return 0
			else
				nResult = (1 - n) + This.NumberOfItems()
				return nResult
			ok

		but cType = "LIST"
			# For performance reasons, we rely on stzString

			# Turning the pItem to a string

			cPItem = Q(pItem).ToCodeQ().Simplified()
			
			aList = This.List()
			nLen = This.NumberOfItems()
			nResult = 0
			n = 0

			for i = nLen to 1 step -1
				n++
				item = aList[i]
				cItem = ""
			
				if isList(item)
					cItem = Q(item).ToCodeQ().Simplified()
				
					if cItem = cPItem
						nResult = nLen - n + 1
						return nResult
					ok
				ok
			
			next
		ok

		return FALSE

		#< @FunctionAlternativeForms

		def FindLastCS(pItem, pCaseSensitive)
			return This.FindLastOccurrenceCS(pItem, pCaseSensitive)

		def LastOccurrenceCS(pItem, pCaseSensitive)
			return This.FindLastOccurrenceCS(pItem, pCaseSensitive)

		def LastCS(pItem, pCaseSensitive)
			return This.FindLastOccurrenceCS(pItem, pCaseSensitive)

		def PositionOfLastCS(pItem, pCaseSensitive)
			return This.FindLastOccurrenceCS(pItem, pCaseSensitive)

		def PositionOfLastOccurrenceCS(pItem, pCaseSensitive)
			return This.FindLastOccurrenceCS(pItem, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindLastOccurrence(pItem)
		return This.FindLastOccurrenceCS(pItem, :CaseSensitiv = TRUE)

		#< @FunctionAlternativeForms

		def FindLast(pItem)
			return This.FindLastOccurrence(pItem)

		def LastOccurrence(pItem)
			return This.FindLastOccurrenceCS(pItem)

		def Last(pItem)
			return This.FindLastOccurrenceCS(pItem)

		def PositionOfLast(pItem)
			return This.FindLastOccurrence(pItem)

		def PositionOfLastOccurrence(pItem)
			return This.FindLastOccurrence(pItem)

		#>

	  #------------------------------------------#
	 #   FINDING GIVEN OCCURRENCES OF AN ITEM   #
	#------------------------------------------#

	def FindTheseOccurrencesCS(panOccurr, pItem, pCaseSensitive)
		anPositions = This.FindAllCS(pItem, pCaseSensitive)
		return Q(anPositions).ItemsAt(panOccurr)

		def FindOccurrencesCS(panOccurr, pItem, pCaseSensitive)
			return This.FindTheseOccurrencesCS(panOccurr, pItem, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def FindTheseOccurrences(panOccurr, pItem)
		return This.FindTheseOccurrencesCS(panOccurr, pItem, :CaseSensitive = TRUE)

		def FindOccurrences(panOccurr, pItem)
			return This.FindTheseOccurrences(panOccurr, pItem)

	  #-------------------------------------------------------#
	 #   FINDING THE OCCURRENCES OF MANY ITEMS IN THE LIST   #
	#-------------------------------------------------------#
	
	def FindManyCS(paItems, pCaseSensitive)
		/*
		o1 = new stzList([ :one, :two, :one, :three, :one, :four ])
		? o1.FindMany([ :one, :two, :four ])
		# --> [ 1, 2, 3, 5, 6 ]
		*/

		aResult = []

		for item in paItems
			anPositions = This.FindAllCS(item, pCaseSensitive)
			if len(anPositions) > 0
				aResult + anPositions
			ok
		next

		aResult = StzListQ(aResult).RemoveQ([]).FlattenQ().SortedInAscending()

		return aResult

		#< @FunctionFluentForm

		def FindManyCSQ(paItems, pCaseSensitive)
			return This.FindManyCSQR(paItems, pCaseSensitive, :stzListOfNumbers)

		def FindManyCSQR(paItems, pCaseSensitive, pcReturnType)
			if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.FindManyCS(paItems, pCaseSensitive) )

			on :stzListOfNumbers
				return new stzListOfNumbers( This.FindManyCS(paItems, pCaseSensitive) )

			other
				StzRaise("Unsupported return type!")
			off

		#

	#-- WITHOUT CASESENSITIVITY

	def FindMany(paItems)
		return This.FindManyCS(paItems, :CaseSensitive = TRUE)

		#< @FunctionFluentForm

		def FindManyQ(paItems)
			return This.FindManyQR(paItems, :stzListOfNumbers)

		def FindManyQR(paItems, pcReturnType)
			return This.FindManyCSQR(paItems, :CaseSensitive = TRUE, pcReturnType)

		#>

	  #------------------------------------------------------------------#
	 #   FINDING THE OCCURRENCES OF MANY ITEMS IN THE LIST -- EXTENDED  #
	#------------------------------------------------------------------#
	
	def FindManyXTCS(paItems, pCaseSensitive)
		/*
		o1 = new stzList([ :one, :two, :one, :three, :one, :four ])
		? o1.FindManyXT([ :one, :two, :four ])
		# --> [ :one = [1, 3, 5], :two = [2], :three = [6] ]
		*/

		aResult = []

		for item in paItems
			aResult + [ item, This.FindAllCS(item, pCaseSensitive) ]
		next

		return aResult

		#< @FunctionFluentForm

		def FindManyXTCSQ(paItems)
			return new stzList( This.FindManyXTCS(paItems, pCaseSensitive) )

		#

	#-- CASESENSITIVITY

	def FindManyXT(paItems)
		return This.FindManyXTCS(paItems, :CaseSensitive = TRUE)

		#< @FunctionFluentForm

		def FindManyXTQ(paItems)
			return new stzList( This.FindManyXT(paItems) )

		#

	  #-------------------------------------------------------------------#
	 #  FINDING ALL OCCURRENCES OF AN ITEM, EXCEPT THE FIRST OCCURRENCE  #
	#-------------------------------------------------------------------#

	def FindAllExceptFirstCS(pItem, pCaseSensitive)
		anResult = This.FindAllCSQ(pItem, pCaseSensitive).Section(2, :LastItem)
		return anResult

		#< @FunctionFluentForm

		def FindAllExceptFirstCSQR(pItem, pcReturnType, pCaseSensitive)
			if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.FindAllExceptFirstCS(pItem, pCaseSensitive) )

			on :stzListOfNumbers
				return new stzListOfNumbers( This.FindAllExceptFirstCS(pItem, pCaseSensitive) )

			other
				StzRaise("Unsupported return type!")
			off

		def FindAllExceptFirstCSQ(pItem, pCaseSensitive)
			return This.FindAllExceptFirstCSQR(pItem, pCaseSensitive, :stzListOfNumbers)

		#

		#< @FunctionAlternativeForm

		def FindExceptFirstCS(pItem, pCaseSensitive)
			return This.FindAllExceptFirstCS(pItem, pCaseSensitive)

			#< @FunctionFluentForm
	
			def FindExceptFirstCSQR(pItem, pCaseSensitive, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.FindExceptFirstCS(pItem, pCaseSensitive) )

				on :stzListOfNumbers
					return new stzListOfNumbers( This.FindExceptFirstCS(pItem, pCaseSensitive) )
				other
					StzRaise("Unsupported return type!")
				off
	
			def FindExceptFirstCSQ(pItem, pCaseSensitive)
				return This.FindAllExceptFirstCSQR(pItem, pCaseSenstive, :stzListOfNumbers)
	
		#>

	#-- WITHoUT CASESENSITIVITY

	def FindAllExceptFirst(pItem)
		return This.FindAllExceptFirstCS(pItem, pCaseSensitive)

		#< @FunctionFluentForm

		def FindAllExceptFirstQR(pItem, pcReturnType)
			if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.FindAllExceptFirst(pItem) )

			on :stzListOfNumbers
				return new stzListOfNumbers( This.FindAllExceptFirst(pItem) )
			other
				StzRaise("Unsupported return type!")
			off

		def FindAllExceptFirstQ(pItem)
			return This.FindAllExceptFirstQR(pItem, :stzListOfNumbers)

		#

		#< @FunctionAlternativeForm

		def FindExceptFirst(pItem)
			return This.FindAllExceptFirst(pItem)

			#< @FunctionFluentForm
	
			def FindExceptFirstQR(pItem, pcReturnType)
				if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.FindExceptFirst(pItem) )

				on :stzListOfNumbers
					return new stzListOfNumbers( This.FindExceptFirst(pItem) )
				other
					StzRaise("Unsupported return type!")
				off
	
			def FindExceptFirstQ(pItem)
				return This.FindAllExceptFirstQR(pItem, :stzListOfNumbers)
	
		#>

	  #------------------------------------------------------------------#
	 #  FINDING ALL OCCURRENCES OF AN ITEM, EXCEPT THE LAST OCCURRENCE  #
	#------------------------------------------------------------------#

	def FindAllExceptLastCS(pItem, pCaseSensitive)
		oTemp = new stzList( This.FindAllCS(pItem, pCaseSensitive) )
		return oTemp.Section( 1, oTemp.NumberOfItems()-1 )

		#< @FunctionFluentForm

		def FindAllExceptLastCSQR(pItem, pCaseSensitive, pcReturnType)
			if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.FindAllExceptLastCS(pItem, pCaseSensitive) )

			on :stzListOfNumbers
				return new stzListOfNumbers( This.FindAllExceptLastCS(pItem, pCaseSensitive) )
			other
				StzRaise("Unsupported return type!")
			off

		def FindAllExceptLastCSQ(pItem, pCaseSensitive)
			return This.FindAllExceptLastCSQR(pItem, pCaseSensitive, :stzListOfNumbers)

		#

		#< @FunctionAlternativeForm

		def FindExceptLastCS(pItem, pCaseSensitive)
			return This.FindAllExceptLastCS(pItem, pCaseSensitive)

			#< @FunctionFluentForm
	
			def FindExceptLastCSQR(pItem, pCaseSensitive, pcReturnType)
				if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.FindExceptLastCS(pItem, pCaseSensitive) )

				on :stzListOfNumbers
					return new stzListOfNumbers( This.FindExceptLastCS(pItem, pCaseSensitive) )

				other
					StzRaise("Unsupported param type!")
				off
	
			def FindExceptLastCSQ(pItem)
				return This.FindAllExceptLastQR(pItem, pCaseSensitive, :stzListOfNumbers)
	
			#>
		#>
		
	#-- WITHOUT CASESENSITIVITY

	def FindAllExceptLast(pItem)
		return This.FindAllExceptLastCS(pItem, pCaseSensitive)

		#< @FunctionFluentForm

		def FindAllExceptLastQR(pItem, pcReturnType)
			if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.FindAllExceptLast(pItem) )

			on :stzListOfNumbers
				return new stzListOfNumbers( This.FindAllExceptLast(pItem) )
			other
				StzRaise("Unsupported return type!")
			off

		def FindAllExceptLastQ(pItem)
			return This.FindAllExceptLastQR(pItem, :stzListOfNumbers)

		#

		#< @FunctionAlternativeForm

		def FindExceptLast(pItem)
			return This.FindAllExceptLast(pItem)

			#< @FunctionFluentForm
	
			def FindExceptLastQR(pItem, pcReturnType)
				if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.FindExceptLast(pItem) )

				on :stzListOfNumbers
					return new stzListOfNumbers( This.FindExceptLast(pItem) )

				other
					StzRaise("Unsupported param type!")
				off
	
			def FindExceptLastQ(pItem)
				return This.FindAllExceptLastQR(pItem, :stzListOfNumbers)
	
			#>
		#>

  	  #----------------------------#
	 #   FINDING ALL DUPLICATES   #
	#----------------------------#

	def FindDuplicatesCS(pCaseSensitive)

		acUniqueItems = This.RemoveDuplicates()
		nLenUniq = len(acUniqueItems)

		anPositions = []
		anResult = []

		for i = 1 to nLenUniq

			anPos = This.FindAllCSQ( acUniqueItems[i], pCaseSensitive)

			if len(anPos) > 1
				del(anPos, 1)
				nLen = len(anPos)
				for i = 1 to nLen
					anResult + anPos[i]
				next
			ok
		next

		return anResult

		anResult = ring_sort(anResult)

		return anResult

		#< @FunctionFluentForm

		def FindDuplicatesCSQ(pCaseSensitive)
			return This.FindDuplicatesCSQR(pCaseSensitive, :stzList)

		def FindDuplicatesCSQR(pCaseSensitive, pcReturnType)
			if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok
	
			if NOT isString(pcReturnType)
				StzRaise("Incorrect param type! pcReturnType must be a string.")
			ok
	
			switch pcReturnType
			on :stzList
				return new stzList( This.FindDuplicatesCS(pCaseSensitive) )
	
			on :stzListOfNumbers
				return new stzListOfNumbers( This.FindDuplicatesCS(pCaseSensitive) )
	
			other
				StzRaise("Unsupported return type!")
			off
		#>

		#< @FunctionAlternativeForms

		def PositionsOfDuplicatesCS(pCaseSensitive)
			return This.FindDuplicatesCS(pCaseSensitive)

			def PositionsOfDuplicatesCSQ(pCaseSensitive)
				return This.PositionsOfDuplicatesCSQR(pCaseSensitive, :stzList)

			def PositionsOfDuplicatesCSQR(pCaseSensitive, pcReturnType)
				return This.FindDuplicatesCSQR(pCaseSensitive, pcReturnType)

		def DuplicatesPositionsCS(pCaseSensitive)
			return THis.FindDuplicatesCS(pCaseSensitive)

			def DuplicatesPositionsCSQ(pCaseSensitive)
				return This.DuplicatesPositionsCSQR(pCaseSensitive, :stzList)

			def DuplicatesPositionsCSQR(pCaseSensitive, pcReturnType)
				return This.FindDuplicatesCSQR(pCaseSensitive, pcReturnType)

		#>

	##-- WITHOUT CASESENSITIVITY

	def FindDuplicates()
				
		return This.FindDuplicatesCS( :CaseSensitive = TRUE )

		#< @FunctionFluentForm

		def FindDuplicatesQ()
			return This.FindDuplicatesQR(:stzList)

		def FindDuplicatesQR(pcReturnType)
			if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok
	
			if NOT isString(pcReturnType)
				StzRaise("Incorrect param type! pcReturnType must be a string.")
			ok
	
			switch pcReturnType
			on :stzList
				return new stzList( This.FindDuplicates() )
	
			on :stzListOfNumbers
				return new stzListOfNumbers( This.FindDuplicates() )
	
			other
				StzRaise("Unsupported return type!")
			off
		#>

		#< @FunctionAlternativeForms

		def PositionsOfDuplicates()
			return This.FindDuplicates()

			def PositionsOfDuplicatesQ()
				return This.PositionsOfDuplicatesQR(:stzList)

			def PositionsOfDuplicatesQR(pCaseSensitive, pcReturnType)
				return This.FindDuplicatesQR(pcReturnType)

		def DuplicatesPositions()
			return THis.FindDuplicates()

			def DuplicatesPositionsQ()
				return This.DuplicatesPositionsQR(:stzList)

			def DuplicatesPositionsQR(pcReturnType)
				return This.FindDuplicatesQR(pcReturnType)

		#>

	  #======================================================#
	 #  CHECKING IF THE LIST CONTAINS AN ITEM AT ANY LEVEL  #
	#======================================================#

	def DeepContainsCS(pItem, pCaseSensitive)
		
		cList = @@S(This.List())

		cItem = @@S(pItem)
		if isString(pItem)
			cItem = Q(cItem).FirstAndLastCharsRemoved()
		ok

		bResult = Q(cList).ContainsCS(cItem, pCaseSensitive)

		return bResult

	#-- WITHOUT CASESENSITIVITY

	def DeepContains(pItem)
		return This.DeepContainsCS(pItem, :CaseSensitive = TRUE)

	  #-----------------------------------------------------------------------------#
	 #  CHECKING IF THE PROVIDED ITEMS ARE ALL CONTAINED IN THE LIST AT ANY LEVEL  #
	#-----------------------------------------------------------------------------#

	def DeepContainsManyCS(paItems, pCaseSensitive)
		bResult = TRUE
		nLen = len(paItems)

		for i = 1 to nLen

			if NOT This.DeepContainsCS(paItems[i], pCaseSensitive)
				bResult = FALSE
				exit
			ok

		next

		return bResult

		def DeepContainsEachCS(paItems, pCaseSensitive)
			return This.DeepContainsManyCS(paItems, pCaseSensitive)

		def DeepContaisEachOneOfTheseCS(paItems, pCaseSensitive)
			return This.DeepContainsManyCS(paItems, pCaseSensitive)

		def DeepContaisEachOfTheseCS(paItems, pCaseSensitive)
			return This.DeepContainsManyCS(paItems, pCaseSensitive)

		def DeepContaisAllOfTheseCS(paItems, pCaseSensitive)
			return This.DeepContainsManyCS(paItems, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def DeepContainsMany(paItems)
		return This.DeepContainsManyCS(paItems, :CaseSensitive = TRUE)

		def DeepContainsEach(paItems)
			return This.DeepContainsMany(paItems)

		def DeepContaisEachOneOfThese(paItems)
			return This.DeepContainsMany(paItems)

		def DeepContaisEachOfThese(paItems)
			return This.DeepContainsMany(paItems)

		def DeepContaisAllOfThese(paItems)
			return This.DeepContainsMany(paItems)

	  #-------------------------------------------------------------------------#
	 #  CHECKING IF THE LIST CONTAINS BOTH OF THE PROVIDED ITEMS AT ANY LEVEL  #
	#-------------------------------------------------------------------------#

	def DeepContainsBothCS(pItem1, pItem2, pCaseSensitive)
		if isList(pItem2) and Q(pItem2).IsAndNamedParam()
			pItem2 = pItem2[2]
		ok

		return This.DeepContainsEachCS([ pItem1, pItem2 ], pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def DeepContainsBoth(pItem1, pItem2)
		return This.DeepContainsBothCS(pItem1, pItem2, :CaseSensitive = TRUE)

	  #--------------------------------------------------------------------------------#
	 #  CHECKING IF THE LIST CONTAINS AT LEAST ONE OF THE PROVIDED ITEMS AT ANY LEVEL  #
	#--------------------------------------------------------------------------------#

	def DeepContainsOneOfTheseCS(paItems, pCaseSensitive)
		bResult = FALSE

		for i = 1 to len(paItems)
			if This.DeepContainsCS(paItems[i], pCaseSensitive)
				bResult = TRUE
				exit
			ok
		next

		return bResult

	#-- WITHOUT CASESENSITIVITY

	def DeepContainsOneOfThese(paItems)
		return This.DeepContainsOneOfTheseCS(paItems, :CaseSensitive = TRUE)

	  #--------------------------------------------------------------------------------#
	 #  CHECKING IF THE LIST CONTAINS AT LEAST N OF THE PROVIDED ITEMS AT ANY LEVEL  #
	#--------------------------------------------------------------------------------#

	def DeepContainsNOfTheseCS(n, paItems, pCaseSensitive)
		bResult = FALSE
		v = 0

		for i = 1 to len(paItems)
			if This.DeepContainsCS(paItems[i], pCaseSensitive)
				v++
				if v = n
					bResult = TRUE
					exit
				ok
			ok
		next

		return bResult

		def DeepContainsNItemsOfTheseCS(n, paItems, pCaseSensitive)
			return This.DeepContainsNOfTheseCS(n, paItems, pCaseSensitive)


	#-- WITHOUT CASESENSITIVITY

	def DeepContainsNOfThese(n, paItems)
		return This.DeepContainsNOfTheseCS(n, paItems, :CaseSensitive = TRUE)

		def DeepContainsNItemsOfThese(n, paItems)
			return This.DeepContainsNOfThese(n, paItems)

	  #================================#
	 #  FINDING AN ITEM AT ANY LEVEL  #
	#================================#

	/*
	TODO: Harmonize this section with  "LIST STRUCTURE" section
	--> There are some TODOs their, review them.
	*/

	// Finding pItem at any level of the list
	def DeepFindCS(pItem, pCaseSensitive)
		/* EXAMPLE

		o1 = new stzList([
			"you",
			"other",
			[ "other", "you", [ "you" ], "other" ],
			"other",
			"you"
		])

		o1.DeepFind("you")
		#--> "you" is found in the following positions
		[
			[ [1, 1], [1, 5] ],	# positions 1 and 5 in the level [1, 1]
			[ [3, 1], [ 2 ]  ],	# positon 2 in the level [3, 1]
			[ [3, 2], [ 1 ]  ],	# position 1 in the level [3, 2]
		]
		*/

		oListStr = @@SQ( This.Content() )
		cItem = @@SQ(pItem).FirstAndLastCharsRemoved()

		anPos = oListStr.FindCS(cItem, pCaseSensitive) #--> [21, 52]
		nLenPos = len(anPos)
	
		aResult = []

		for i = 1 to nLenPos
			nPos = anPos[i]
		
			oSection = oListStr.SectionQ(1, nPos)
		
			anPosBound1 = oSection.Find("[")
			anPosBound2 = oSection.Find("]")
		
			nLevel = len(anPosBound1) - len(anPosBound2)
		
			n1 = oListStr.FindFirstPrevious("[", :StartingAt = nPos)
			n2 = oListStr.FindFirstNext("]", :StartingAt = nPos)
		
			nPosition = oListStr.SectionQ(n1, nPos).NumberOfOccurrence(",") + 1
			
			aResult + [nLevel, nPosition]
		next

		return aResult

	#-- WITHOUT CASESENSITIVITY

	def DeepFind(pItem)
		return This.DeepFindCS(pItem, :CaseSensitive = TRUE)

	  #-----------------------------------------------------#
	 #  FINDING THE LIST ITEMS IN AN OTHER LIST OR ITEM  #
	#-----------------------------------------------------#

	def FindInCS(pOtherListOrStr, pCaseSensitive)
		/* 
		EXAMPLE 1:

		o1 = new stzList([ "11", "22", "33" ])
		? o1.FindIn([ "11", "_", "22", "_", "33" ])
		#--> [ 1, 3, 4 ]

		EXAMPLE 2:

		o1 = new stzList([ "11", "22", "33" ])
		? o1.FindIn("**11**22**33**")
		#--> [ 3, 7, 11 ]

		*/

		if isList(pOtherListOrStr) and Q(pOtherListOrStr).IsListNamedParam()
			pOtherListOrStr = pOtherListOrStr[2]

			if NOT isList(paOtherListOrStr)
				StzRaise("Incorrect param type! pOtherListOrStr must be a list.")
			ok
		ok

		if isList(pOtherListOrStr) and Q(pOtherListOrStr).IsStringNamedParam()
			pOtherListOrStr = pOtherListOrStr[2]

			if NOT isString(paOtherListOrStr)
				StzRaise("Incorrect param type! pOtherListOrStr must be a string.")
			ok
		ok

		if NOT (isList(pOtherListOrStr) or isString(pOtherListOrStr))
			StzRaise("Incorrect param type! pOtherListOrStr must be a list or string.")
		ok

		anResult = Q(pOtherListOrStr).FindManyCS(This.Content(), pCaseSensitive)
		return anResult

		#< @FunctionAlternativeForm

		def FindItemsInCS(pOtherListOrStr, pCaseSensitive)
			return This.FindInCS(pOtherListOrStr, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindIn(pOtherListOrStr)
		return FindInCS(pOtherListOrStr, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForm

		def FindItemsIn(pOtherListOrStr)
			return FindIn(pOtherListOrStr)

		#>

	  #-------------------------------------------#
	 #  FINDING THE LIST ITEMS IN AN OTHER LIST  #
	#-------------------------------------------#

	def FindInListCS(paOtherList, pCaseSensitive)
		if NOT isList(paOtherList)
			StzRaise("Incorrect param type! paOtherList must be a list.")
		ok

		return This.FindInCS(paOtherList, pCaseSensitive)

		#< @FunctionAlternativeForm

		def FindItemsInListCS(paOtherList, pCaseSensitive)
			return This.FindInListCS(paOtherList, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindInList(paOtherList)
		return This.FindInListCS(paOtherList, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForm

		def FindItemsInList(paOtherList)
			return This.FindInList(paOtherList)

		#>

	  #---------------------------------------------#
	 #  FINDING THE LIST ITEMS IN AN GIVEN ITEM  #
	#---------------------------------------------#

	def FindInStringCS(pcStr, pCaseSensitive)
		if NOT isString(pcStr)
			StzRaise("Incorrect param type! pcStr must be a string.")
		ok

		return This.FindInCS(pcStr, pCaseSensitive)

		#< @FunctionAlternativeForm

		def FindItemsInStringCS(pcStr, pCaseSensitive)
			return This.FindInStringCS(pcStr, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindInString(pcStr)
		return This.FindInStringCS(pcStr, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForm

		def FindItemsInString(pcStr)
			return This.FindInString(pcStr)

		#>

	  #=======================================================#
	 #    VISUALLY FINDING ALL OCCURRENCES OF A GIVEN ITEM   #
	#=======================================================#

	# NOTE: Works only if items are chars (string of 1 char each)
	# TODO: Implement a more general solution for longer items

	def VizFindAllOccurrencesCS(pItem, pCaseSensitive)
		
		cResult = This.ToCodeQ().Simplified()
		anPositions = Q(cResult).FindAllCS( @@(pItem), pCaseSensitive )

		nLen = StzStringQ(cResult).NumberOfChars()

		cViz = " "
		for i = 1 to nLen - 2
			
			if StzNumberQ(i).IsOneOfThese(anPositions)
				cViz += "^"
			else
				cViz += "-"
			ok

		next

		cResult += (NL + cViz)

		return cResult

		#< @FunctionFluentForm

		def VizFindAllOccurrencesCSQ(pItem, pCaseSensitive)
			return new stzString( This.VizFindAllOccurrencesCS(pItem, pCaseSensitive) )

		#>

		#< @FunctionAlternativeForms

		def VizFindAllCS(pItem, pCaseSensitive)
			return This.VizFindAllOccurrencesCS(pItem, pCaseSensitive)

			def VizFindAllCSQ(pItem, pCaseSensitive)
				return new stzString(This.VizFindAllCS(pItem, pCaseSensitive))
	

		def VizFindCS(pItem, pCaseSensitive)
			return This.VizFindAllOccurrencesCS(pItem, pCaseSensitive)

			def VizFindCSQ(pItem, pCaseSensitive)
				return new stzString(This.VizFindCS(pItem, pCaseSensitive))
		#>

	#-- WITHOUT CASESENSITIVITY

	def VizFindAllOccurrences(pItem)
		return This.VizFindAllOccurrencesCS(pItem, :CaseSensitive = TRUE)

		#< @FunctionFluentForm

		def VizFindAllOccurrencesQ(pItem)
			return new stzString( This.VizFindAllOccurrences(pItem) )

		#>

		#< @FunctionAlternativeForms

		def VizFindAll(pItem)
			return This.VizFindAllOccurrences(pItem)

			def VizFindAllQ(pItem)
				return new stzString(This.VizFindAll(pItem))
	

		def VizFind(pItem)
			return This.VizFindAllOccurrences(pItem)

			def VizFindQ(pItem)
				return new stzString(This.VizFind(pItem))
		#>

	   #-------------------------------------------------#
	  #      FINDING NTH NEXT OCCURRENCE OF AN ITEM     #
	 #      STARTING AT A GIVEN POSITION               #
	#-------------------------------------------------#

	def FindNthNextOccurrenceCS( n, pItem, nStart, pCaseSensitive )

		if (isString(n) and (n = :First or n = :FirstOccurrence)) or
		   (isNumber(n) and n = 1)

			return This.FindNextOccurrenceCS(pItem, nStart, pCaseSensitive)

		ok

		if (isString(n) and (n = :Last or n = :LastOccurrence))

			return This.FindLastOccurrenceCS(pItem, nStart, pCaseSensitive)

		ok

		if isList(pItem) and Q(pItem).IsOfNamedParam()
			pItem = pItem[2]
		ok

		if isList(nStart) and Q(nStart).IsStartingAtNamedParam()
			nStart = nStart[2]
		ok

		if NOT BothAreNumbers(n, nStart)
			StzRaise("Incorrect param type! n and nStart must be numbers.")
		ok


		# Early checks (gains performance for large strings)

		if NOT This.ContainsCS(pItem, pCaseSensitive)
			return 0
		ok

		nLen = This.NumberOfItems()

		if (NOT Q(n).IsBetween(1, nLen - nStart)) or
		   (NOT Q(nStart).IsBetween(1, nLen - n))

			return 0
		ok

		if n = nLen and
		   This.LastItemQ().IsEqualToCS(pItem, pCaseSensitive)
			return nLen
		ok

		# Doing the job

		nResult  = This.SectionQ(nStart+1, nLen).
				FindNthCS(n, pItem, pCaseSensitive)

		if nResult != 0
			nResult += nStart
		ok

		return nResult

		#< @FunctionAlternativeForms

		def FindNextNthOccurrenceCS( n, pItem, nStart, pCaseSensitive )
			return This.FindNthNextOccurrenceCS( n, pItem, nStart, pCaseSensitive )

		def NthNextOccurrenceCS( n, pItem, nStart, pCaseSensitive )
			return This.FindNthNextOccurrenceCS( n, pItem, nStart, pCaseSensitive )

		def NextNthOccurrenceCS( n, pItem, nStart, pCaseSensitive )
			return This.FindNthNextOccurrenceCS( n, pItem, nStart, pCaseSensitive )

		def FindNextNthCS( n, pItem, nStart, pCaseSensitive )
			return This.FindNthNextOccurrenceCS( n, pItem, nStart, pCaseSensitive )

		def FindNthNextCS( n, pItem, nStart, pCaseSensitive )
			return This.FindNthNextOccurrenceCS( n, pItem, nStart, pCaseSensitive )

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindNthNextOccurrence( n, pItem, nStart )
		return This.FindNthNextOccurrenceCS( n, pItem, nStart, :CaseSensitive = TRUE )

		#< @FunctionAlternativeForms

		def FindNextNthOccurrence( n, pItem, nStart )
			return This.FindNthNextOccurrence( n, pItem, nStart )

		def NthNextOccurrence( n, pItem, nStart )
			return This.FindNthNextOccurrence( n, pItem, nStart )

		def NextNthOccurrence( n, pItem, nStart )
			return This.FindNthNextOccurrence( n, pItem, nStart )

		def FindNextNth( n, pItem, nStart )
			return This.FindNthNextOccurrence( n, pItem, nStart )

		def FindNthNext( n, pItem, nStart )
			return This.FindNthNextOccurrence( n, pItem, nStart )

		#>

	   #-----------------------------------------------------#
	  #      FINDING NTH PREVIOUS OCCURRENCE OF AN ITEM     #
	 #      STARTING AT A GIVEN POSITION                   #
	#-----------------------------------------------------#

	def FindNthPreviousOccurrenceCS(n, pItem, nStart, pCaseSensitive)

		# Resolving params

		if isList(pItem) and Q(pItem).IsOfNamedParam()
			pItem = pItem[2]
		ok

		if isList(nStart) and Q(nStart).IsStartingAtNamedParam()
			nStart = nStart[2]
		ok

	# Resolving params

		if isList(pItem) and Q(pItem).IsOfNamedParam()
			pItem = pItem[2]
		ok

		if isList(nStart) and Q(nStart).IsStartingAtNamedParam()
			nStart = nStart[2]
		ok

		if NOT BothAreNumbers(n, nStart)
			StzRaise("Incorrect param type! n and nStart must be numbers.")
		ok

		# Early checks (gains performance for large strings)
		# Very quick on small to medium lists (thousands of item)
		# Takes half a second on a list of +150K hybrid items

		if NOT This.ContainsCS(pItem, pCaseSensitive)
			return 0
		ok

		nLen = This.NumberOfItems()

		if (NOT Q(n).IsBetween(1, nLen - 1)) or
		   (NOT Q(nStart).IsBetween(n + 1, nLen))

			return 0
		ok

		# The following check is very quick, even for
		# large lists (less then 0.01s)

		if n = nLen and
		   This.FirstItemQ().IsEqualToCS(pItem, pCaseSensitive)
			return nLen
		ok

		# Doing full check

		# Until this point, elapsed time approches 0.80 second
		# in parsing a list of +150K hynrid items

		# For the same list, the following check take about 2.76 second

		nPos = This.SectionQ(nStart, 1).
			    FindNthCS(n, pItem, pCaseSensitive)

		if nPos != 0
			nResult = (1 + nStart) - nPos
		else
			nResult = 0
		ok

		return nResult

		#< @FunctionAlternativeForms

		def FindPreviousNthOccurrenceCS( n, pItem, nStart, pCaseSensitive )
			return This.FindNthPreviousOccurrenceCS( n, pItem, nStart, pCaseSensitive )
	
		def PreviousNthOccurrenceCS( n, pItem, nStart, pCaseSensitive )
			return This.FindNthPreviousOccurrenceCS( n, pItem, nStart, pCaseSensitive )
	
		def NthPreviousOccurrenceCS( n, pItem, nStart, pCaseSensitive )
			return This.FindNthPreviousOccurrenceCS( n, pItem, nStart, pCaseSensitive )

		def FindPreviousNthCS( n, pItem, nStart, pCaseSensitive )
			return This.FindNthPreviousOccurrenceCS( n, pItem, nStart, pCaseSensitive )

		def FindNthPreviousCS( n, pItem, nStart, pCaseSensitive )
			return This.FindNthPreviousOccurrenceCS( n, pItem, nStart, pCaseSensitive )

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindNthPreviousOccurrence(n, pItem, nStart)
		return This. FindNthPreviousOccurrenceCS(n, pItem, nStart, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def FindPreviousNthOccurrence( n, pItem, nStart )
			return This.FindNthPreviousOccurrence( n, pItem, nStart )
	
		def PreviousNthOccurrence( n, pItem, nStart )
			return This.FindNthPreviousOccurrence( n, pItem, nStart )
	
		def NthPreviousOccurrence( n, pItem, nStart )
			return This.FindNthPreviousOccurrence( n, pItem, nStart )

		def FindPreviousNth( n, pItem, nStart )
			return This.FindNthPreviousOccurrence( n, pItem, nStart )

		def FindNthPrevious( n, pItem, nStart )
			return This.FindNthPreviousOccurrence( n, pItem, nStart )

		#>

	   #---------------------------------------------#
	  #      FINDING NEXT OCCURRENCE OF AN ITEM     #
	 #      STARTING AT A GIVEN POSITION           #
	#---------------------------------------------#

	def FindNextOccurrenceCS(pItem, pnStartingAt, pCaseSensitive)
		/* EXAMPLE

		o1 = new stzList([ 1, 2, 3, "*", 5, 6, "*", 8, 9 ])
		? o1.FindNext("*", :StartingAt = 4)
		#--> 7

		*/

		if isList(pItem) and Q(pItem).IsOfNamedParam()
			pItem = pItem[2]
		ok

		if isList(pnStartingAt) and Q(pnStartingAt).IsStartingAtNamedParam()
			pnStartingAt = pnStartingAt[2]
		ok

		nResult = This.SectionQ(pnStartingAt + 1, This.NumberOfItems()).
			FindFirstCS(pItem, pCaseSensitive) + pnStartingAt

		return nResult

		#< @FunctionAlternativeForms

		def FindNextCS( pItem, nStart, pCaseSensitive )
			return This.FindNextOccurrenceCS(pItem, nStart, pCaseSensitive)

		def NextOccurrenceCS( pItem, nStart, pCaseSensitive )
			return This.FindNextOccurrenceCS(pItem, nStart, pCaseSensitive)

		#>

	#-- WITHOUT CASESENSITIVITY

	def FindNextOccurrence(pItem, nStart)
		return This.FindNextOccurrenceCS(pItem, nStart, :CaseSensitive = TRUE)
	
		#< @FunctionAlternativeForms

		def FindNext( pItem, nStart )
			return This.FindNextOccurrence(pItem, nStart)

		def NextOccurrence( pItem, nStart )
			return This.FindNextOccurrence(pItem, nStart)

		#>

	   #-------------------------------------------------#
	  #      FINDING PREVIOUS OCCURRENCE OF AN ITEM     #
	 #      STARTING FROM A GIVEN POSITION N           #
	#-------------------------------------------------#

	def FindPreviousOccurrenceCS(pItem, pnStartingAt, pCaseSensitive)

		/* EXAMPLE

		o1 = new stzList([ 1, 2, 3, "*", 5, 6, "*", 8, 9 ])
		? o1.FindPrevious("*", :StartingAt = 7)
		#--> 7

		*/


		if isList(pItem) and Q(pItem).IsOfNamedParam()
			pItem = pItem[2]
		ok

		if isList(pnStartingAt) and Q(pnStartingAt).IsStartingAtNamedParam()
			pnStartingAt = pnStartingAt[2]
		ok

		nResult = This.SectionQ(1, pnStartingAt - 1).
			FindLastCS(pItem, pCaseSensitive)

		return nResult

/*
		if isList(pnStartingAt) and Q(pnStartingAt).IsStartingAtNamedParam()
			pnStartingAt = pnStartingAt[2]
		ok

		cItem = Q(pItem).Stringified()
		if cItem = ""
			return 0
		ok

		if NOT This.ContainsCS(pItem, pCaseSensitive)
			return 0
		ok

		acItemsAsStrings = This.SectionQ(1, pnStartingAt-1).
				  StringifyQ().Content()
		
		if NOT Q(acItemsAsStrings).ContainsCS(cItem, pCaseSensitive)
			return 0
		ok

		nLen = len(acItemsAsStrings)
		i = nLen + 1

		while TRUE
			i--

			if i = 0
				exit
			ok

			if Q(acItemsAsStrings[i]).IsEqualToCS(cItem, pCaseSensitive)
				return i
			ok
		end

		return 0
	*/
		def FindPreviousCS( pItem, nStart, pCaseSensitive )
			return This.FindPreviousOccurrenceCS(pItem, nStart, pCaseSensitive)

		def PreviousOccurrenceCS( pItem, nStart, pCaseSensitive )
			return This.FindPreviousOccurrenceCS(pItem, nStart, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def FindPreviousOccurrence(pItem, nStart)
		return This.FindPreviousOccurrenceCS(pItem, nStart, :CaseSensitive = TRUE)

		def FindPrevious( pItem, nStart )
			return This.FindPreviousOccurrence(pItem, nStart)

		def PreviousOccurrence( pItem, nStart )
			return This.FindPreviousOccurrence(pItem, nStart)

	   #-----------------------------------------#
	  #   FINDING NEXT OCCURRENCES OF AN ITEM   #
	 #   STARTING AT A GIVEN POSITION          #
	#-----------------------------------------#

	def FindNextOccurrencesCS(pItem, pnStartingAt, pCaseSensitive)
		if isList(pnStartingAt) and Q(pnStartingAt).IsStartingAtNamedParam()
			pnStartingAt = pnStartingAt[2]
		ok

		if isString(pnStartingAt)
			if Q(pnStartingAt).IsOneOfTheseCS([
				:First, :FirstItem ], :CS = FALSE)

				pnStartingAt = 1
			
			but Q(pnStartingAt).IsOneOfTheseCS([
				:Last, :LastItem ], :CS = FALSE)

				pnStartingAt = This.NumberOfItems()
			ok
		ok

		if NOT isNumber(pnStartingAt)
			StzRaise("Incorrect param! pnStartingAt must be a number.")
		ok

		oSection = This.SectionQ(pnStartingAt, :LastItem)

		anPositions = oSection.FindAllCS(pItem, pCaseSensitive)
		
		anResult = StzListOfNumbersQ(anPositions).
			   AddToEachQ(pnStartingAt - 1 ).
			   Content()

		return anResult

		#< @FunctionAlternativeForms

		def NextOccurrencesCS(pItem, pnStartingAt, pCaseSensitive)
			return This.FindNextOccurrencesCS(pItem, pnStartingAt, pCaseSensitive)

		#>
		
	#-- WITHOUT CASESENSITIVITY

	def FindNextOccurrences(pItem, pnStartingAt)
		return This.FindNextOccurrencesCS(pItem, pnStartingAt, :CaseSensitive = TRUE)

		#< @FunctionAlternativeForms

		def NextOccurrences(pItem, pnStartingAt)
			return This.FindNextOccurrences(pItem, pnStartingAt)

		#>

	   #---------------------------------------------#
	  #   FINDING PREVIOUS OCCURRENCES OF AN ITEM   #
	 #   STARTING AT A GIVEN POSITION              #
	#---------------------------------------------#

	def FindPreviousOccurrencesCS(pcSubStr, pnStartingAt, pCaseSensitive)
		if isList(pnStartingAt) and StzListQ(pnStartingAt).IsStartingAtNamedParam()
			pnStartingAt = pnStartingAt[2]
		ok

		if isString(pnStartingAt)
			if Q(pnStartingAt).IsOneOfTheseCS([
				:First, :FirstItem ], :CS = FALSE)

				pnStartingAt = 1
			
			but Q(pnStartingAt).IsOneOfTheseCS([
				:Last, :LastItem ], :CS = FALSE)

				pnStartingAt = This.NumberOfItems()
			ok
		ok

		if NOT isNumber(pnStartingAt)
			StzRaise("Incorrect param! pnStartingAt must be a number.")
		ok

		oSection = This.SectionQ(1, pnStartingAt)

		anPositions = oSection.FindAllCS(pcSubStr, pCaseSensitive)
		
		return anPositions

	def FindPreviousOccurrences(pcSubStr, pnStartingAt)
		return This.FindPreviousOccurrencesCS(pcSubStr, pnStartingAt, :CaseSensitive = TRUE)

	  #===================================================#
	 #   FINDING ALL ITEMS VERIFYING A GIVEN CONDITION   #
	#===================================================#

	def FindAllItemsW(pcCondition)
		/* WARNING

		We can't use this solution:

			anPositions = This.YieldW('@position', pcCondition)
			return anPositions

		because YieldW() uses the current function FindW() --> Stackoverfolw!
		*/
		
		# Managing params

		if isList(pcCondition) and Q(pcCondition).IsWhereNamedParam()
			pcCondition = pcCondition[2]
		ok

		if NOT isString(pcCondition)
			StzRaise("Incorrect param! pcCondition must be a string.")
		ok

		# Identifying the executable section
		nLen = This.NumberOfItems()
		aExecutableSection = StzCCodeQ(pcCondition).ExecutableSection()

		nStart = aExecutableSection[1]
		nEnd   = aExecutableSection[2]

		if nEnd < 0
			nEnd += nLen
		but nEnd = :Last
			nEnd = nLen
		ok

		cCode = 'bOk = (' + Q(pcCondition).TrimQ().BoundsRemoved(["{","}"]) + ')'

		anResult = []

		for @i = nStart to nEnd
			eval(cCode)
			if bOk
				anResult + @i
			ok
		next

		return anResult
		
		#< @FunctionAlternativeForms

		def FindAllW(pCondition)
			return This.FindAllItemsW(pCondition)

		def FindW(pCondition)
			aResult = This.FindAllItemsW(pCondition)
			return aResult

		def FindWhere(pCondition)
			return This.FindAllItemsW(pCondition)

		def FindAllWhere(pCondition)
			return This.FindAllItemsW(pCondition)

		def FindAllItemsWhere(pCondition)
			return This.FindAllItemsW(pCondition)

		def FindItemsW(pCondition)
			return This.FindAllItemsW(pCondition)

		def FindItemsWhere(pCondition)
			return This.FindAllItemsW(pCondition)

		def ItemsPositionsW(pCondition)
			return This.FindAllItemsW(pCondition)

		def ItemsPositionsWhere(pCondition)
			return This.FindAllItemsW(pCondition)

		def PositionsW(pCondition)
			return This.FindAllItemsW(pCondition)

		def PositionsOfItemsW(pCondition)
			return This.FindAllItemsW(pCondition)

		def PositionsWhere(pCondition)
			return This.FindAllItemsW(pCondition)

		def PositionsOfItemsWhere(pCondition)
			return This.FindAllItemsW(pCondition)

	#>

	  #--------------------------------------------------------------#
	 #  FINDING FIRST ITEM VERIFYING A GIVEN CONDITION -- EXTENDED  #
	#--------------------------------------------------------------#
	# Condditional code can contains keuwords other then This[@i] and cie,
	# like @NextItem, @PreviousItem etc.

	def FindAllItemsWXT(pcCondition)
		
		# Managing params

		if isList(pcCondition) and Q(pcCondition).IsWhereNamedParam()
			pcCondition = pcCondition[2]
		ok

		if NOT isString(pcCondition)
			StzRaise("Incorrect param! pcCondition must be a string.")
		ok

		# Identifying the executable section

		nLen = This.NumberOfItems()
		cCode = StzCCodeQ(pcCondition).Transpiled()

		aExecutableSection = StzCCodeQ(cCode).ExecutableSection()

		nStart = aExecutableSection[1]
		nEnd   = aExecutableSection[2]

		if nEnd < 0
			nEnd += nLen
		but nEnd = :Last
			nEnd = nLen
		ok

		cCode = 'bOk = (' + Q(cCode).TrimQ().BoundsRemoved(["{","}"]) + ')'

		anResult = []

		for @i = nStart to nEnd
			eval(cCode)
			if bOk
				anResult + @i
			ok
		next

		return anResult
		
		#< @FunctionAlternativeForms

		def FindAllWXT(pCondition)
			return This.FindAllItemsWXT(pCondition)

		def FindWXT(pCondition)
			return This.FindAllItemsWXT(pCondition)

		def FindWhereXT(pCondition)
			return This.FindAllItemsWXT(pCondition)

		def FindAllWhereXT(pCondition)
			return This.FindAllItemsWXT(pCondition)

		def FindAllItemsWhereXT(pCondition)
			return This.FindAllItemsWXT(pCondition)

		def FindItemsWXT(pCondition)
			return This.FindAllItemsWXT(pCondition)

		def FindItemsWhereXT(pCondition)
			return This.FindAllItemsWXT(pCondition)

		def ItemsPositionsWXT(pCondition)
			return This.FindAllItemsWXT(pCondition)

		def ItemsPositionsWhereXT(pCondition)
			return This.FindAllItemsWXT(pCondition)

		def PositionsWXT(pCondition)
			return This.FindAllItemsWXT(pCondition)

		def PositionsOfItemsWXT(pCondition)
			return This.FindAllItemsWXT(pCondition)

		def PositionsWhereXT(pCondition)
			return This.FindAllItemsWXT(pCondition)

		def PositionsOfItemsWhereXT(pCondition)
			return This.FindAllItemsWXT(pCondition)

	#>

	  #--------------------------------------------------#
	 #  FINDING FIRST ITEM VERIFYING A GIVEN CONDITION  #
	#--------------------------------------------------#

	def FindFirstW(pcCondition)
		return This.FindNthW(1, pcCondition)

		def FindFirstItemW(pcCondition)
			return This.FindFirstW(pcCondition)

		def FindFirstOccurrenceW(pcCondition)
			return This.FindFirstW(pcCondition)

	  #-------------------------------------------------#
	 #  FINDING LAST ITEM VERIFYING A GIVEN CONDITION  #
	#-------------------------------------------------#

	def FindLastW(pcCondition)
		return FindNthW(:LastOccurrence, pcCondition)

		def FindLastItemW(pcCondition)
			return This.FindLastW(pcCondition)

		def FindLastOccurrenceW(pcCondition)
			return This.FindLastW(pcCondition)

	  #------------------------------------------------#
	 #  FINDING NTH ITEM VERIFYING A GIVEN CONDITION  #
	#------------------------------------------------#

	def FindNthW(n, pcCondition)

		anTemp = This.FindW(pcCondition)
		nLen = len(anTemp)

		if isString(n)
			if ( n = :First or n = :FirstOccurrence )
				n = 1

			but ( n = :Last or n = :LastOccurrence )
				n = nLen
			ok
		ok

		nResult = 0

		if nLen > 0
			nResult = anTemp[n]
		ok

		return nResult

		def FindNthItemW(pcCondition)
			return This.FindNthW(n, pcCondition)

		def FindNthOccurrenceW(pcCondition)
			return This.FindNthW(n, pcCondition)

	  #------------------------------------------------------------#
	 #  FINDING NTH ITEM VERIFYING A GIVEN CONDITION -- EXTENDED  #
	#------------------------------------------------------------#

	def FindNthWXT(n, pcCondition)

		anTemp = This.FindWXT(pcCondition)
		nLen = len(anTemp)

		if isString(n)
			if ( n = :First or n = :FirstOccurrence )
				n = 1

			but ( n = :Last or n = :LastOccurrence )
				n = nLen
			ok
		ok

		nResult = 0

		if nLen > 0
			nResult = anTemp[n]
		ok

		return nResult

		def FindNthItemWXT(pcCondition)
			return This.FindNthWXT(n, pcCondition)

		def FindNthOccurrenceWXT(pcCondition)
			return This.FindNthWXT(n, pcCondition)

	  #--------------------------------------------------------------#
	 #  FINDING FIRST ITEM VERIFYING A GIVEN CONDITION -- EXTENDED  #
	#--------------------------------------------------------------#

	def FindFirstWXT(pcCondition)
		return This.FindNthWXT(1, pcCondition)

		def FindFirstItemWXT(pcCondition)
			return This.FindFirstWXT(pcCondition)

		def FindFirstOccurrenceWXT(pcCondition)
			return This.FindFirstWXT(pcCondition)

	  #-------------------------------------------------------------#
	 #  FINDING LAST ITEM VERIFYING A GIVEN CONDITION -- EXTENDED  #
	#-------------------------------------------------------------#

	def FindLastWXT(pcCondition)
		return FindNthWXT(:LastOccurrence, pcCondition)

		def FindLastItemWXT(pcCondition)
			return This.FindLastWXT(pcCondition)

		def FindLastOccurrenceWXT(pcCondition)
			return This.FindLastWXT(pcCondition)

	  #===================================================#
	 #  INFERING SECTION'S ITEMS FROM THE PROVIDED FORM  #
	#===================================================#

	/* NOTE

	For the mean time, this function is used to translate the section
	returned from the StzCCodeQ().ExecutableSection method, to fill
	it with the actual values of the current list.

	So, for example, if the lists has 10 items:

		--> [ 1, :Last ] is transformed to [ 1, 10 ]
		--> [ 2, -3 ] is transformed to [ 2, 7)
		--> Etc.

	TODO: In the future, it can be used to tranform all other forms used
	to create a section, sutch as [ :From = ..., :To = ... ].

	*/
	
	def InfereSection(paSection)
		aResult = []
		nStart = paSection[1]
		
		if nStart < 0
			nStart = This.NumberOfItems() - Abs(nStart) + 1
		ok

		nEnd = paSection[2]
		if isString(nEnd) and nEnd = :Last
			nEnd = This.NumberOfItems()
		ok

		if nEnd < 0
			nEnd = This.NumberOfItems() - Abs(nEnd) + 1
		ok

		aResult = [nStart, nEnd]
		return aResult

  	  #======================================#
	 #   GETTING ITEMS AT GIVEN POSITIONS   #
	#======================================#

	def ItemsAtPositions(panPositions)

		aResult = []
		nLen = len(panPositions)

		for i = 1 to nLen
			n = panPositions[i]
			aResult + This.ItemAtPosition(n)
		next

		return aResult

		def ItemsAtThesePositions(panPositions)
			return This.ItemsAtPositions(panPositions)

		def ItemsAt(panPositions)
			return This.ItemsAtPositions(panPositions)


	  #===============================================#
	 #   GETTING ITEMS VERIFYING A GIVEN CONDITION   #
	#===============================================#

	/*
	Note the semantic difference between "Getting" items, and "Finding" items.
		-> Getting items return the items themselves, while
		-> Finding items return their positions as numbers
		-> Their sections can also be found using FindAsSection()
	*/

	def ItemsW(pcCondition)
		/* WARNING

		Do not use this solution:

			return This.YieldW('@item', pcCondition)

		--> Stackoverflow!
		*/

		anPositions = This.FindAllItemsW(pcCondition)
		aResult = This.ItemsAtThesePositions(anPositions)

		return aResult

		def ItemsWQ(pcCondition)
			return ItemsWQR(pcCondition, :stzList)

		def ItemsWQR(pcCondition, pcReturnType)
			if isList(pcCondition) and Q(pcCondition).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			if NOT (isString(pcReturnType) and Q(pcReturnType).IsStzType() )
				StzRaise("Incorrect param type! pcCondition must be a string containing a Softanza type.")
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.ItemsW(pcCondition) )

			on :stzListOfStrings
				return new stzListOfStrings( This.ItemsW(pcCondition) )

			on :stzListOfNumbers
				return new stzListOfNumbers( This.ItemsW(pcCondition) )
			
			on :stzListOfLists
				return new stzListOfLists( This.ItemsW(pcCondition) )

			on :stzListOfObjects
				return new stzListOfObjects( This.ItemsW(pcCondition) )

			on :stzListOfPairs
				return new stzListOfPairs( This.ItemsW(pcCondition) )

			on :stzListOfHashLists
				return new stzListOfHashLists( This.ItemsW(pcCondition) )

			other
				StzRaise("Unsupported return type!")
			off

			def OnlyW(pcCondition)
				return This.ItemsW(pcCondition)

			def OnlyWhere(pcCondition)
				return This.ItemsW(pcCondition)

	  #-----------------------------------------------------------------#
	 #  GETTINIG THE NTH ITEM IN THE LIST VERIFYING A GIVEN CONDITION  #
	#-----------------------------------------------------------------#

	def NthItemW(n, pcCondition)

		cResult = ItemsW(pcCondition)[n]
		return cResult

		#< @FunctionFluentForm

		def NthItemWQ(n, pCondition)
			item = This.NthItemW(n, pCondition)

			switch ring_type(item)
			on "NUMBER"
				return new stzNumber(item)

			on "STRING"
				return new stzString(item)

			on "LIST"
				return new stzList(item)

			on "OBJECT"
				return new stzObject(item)

			other
				StzRaise("Unsupported type!")
			off

		#>

		#< @FunctionAlternativeForm

		def NthItemWhere(n, pcCondition)
			return This.NthItemW(n, pcCondition)

			def NthItemWhereQ(n, pcCondition)
				return This.NthItemWQ(n, pCondition)

		#>
		
	  #-------------------------------------------------------------------#
	 #  GETTINIG THE FIRST ITEM IN THE LIST VERIFYING A GIVEN CONDITION  #
	#-------------------------------------------------------------------#

	def FirstItemW(pCondition)
		return This.NthItemWhere(1, pCondition)

		#< @FunctionFluentForm

		def FirstItemWQ(pCondition)
			item = This.FirstItemW(pCondition)

			switch ring_type(item)

			on "NUMBER"
				return new stzNumber(item)

			on "STRING"
				return new stzString(item)

			on "LIST"
				return new stzList(item)

			on "OBJECT"
				return new stzObject(item)

			other
				StzRaise("Unsupported type!")
			off

		#>

	  #------------------------------------------------------------------#
	 #  GETTINIG THE LAST ITEM IN THE LIST VERIFYING A GIVEN CONDITION  #
	#------------------------------------------------------------------#

	def LastItemW(pCondition)
		return This.ItemsW(pCondition)[ len(This.ItemsW(pCondition)) ]

		#< @FunctionFluentForm

		def LastItemWQ(pCondition)
			item = This.LastItemW(pCondition)

			switch ring_type(item)

			on "NUMBER"
				return new stzNumber(item)

			on "STRING"
				return new stzString(item)

			on "LIST"
				return new stzList(item)

			on "OBJECT"
				return new stzObject(item)

			other
				StzRaise("Unsupported type!")
			off

		#>

	  #----------------------------------------------------------#
	 #   GETTING ITEMS VERIFYING A GIVEN CONDITION -- EXTENDED  #
	#----------------------------------------------------------#

	/* NOTE
	A Less performant alternative to ItemsW() function.
	Provides transpiling and executable section features.

	UPDATE: I think this was fixed and the olny one to use is
	the normal ItemsW()..
	--> TODO: If so, remove this function!

	*/

	def ItemsWXT(pcCondition)
		/* WARNING

		Do not use this solution:

			return This.YieldWXT('@item', pcCondition)

		--> Stackoverflow!
		*/

		anPositions = This.FindAllItemsWXT(pcCondition)
		aResult = This.ItemsAtThesePositions(anPositions)

		return aResult

		def ItemsWXTQ(pcCondition)
			return ItemsWXTQR(pcCondition, :stzList)

		def ItemsWXTQR(pcCondition, pcReturnType)
			if isList(pcCondition) and Q(pcCondition).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			if NOT (isString(pcReturnType) and Q(pcReturnType).IsStzType() )
				StzRaise("Incorrect param type! pcCondition must be a string containing a Softanza type.")
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.ItemsWXT(pcCondition) )

			on :stzListOfStrings
				return new stzListOfStrings( This.ItemsWXT(pcCondition) )

			on :stzListOfNumbers
				return new stzListOfNumbers( This.ItemsWXT(pcCondition) )
			
			on :stzListOfLists
				return new stzListOfLists( This.ItemsWXT(pcCondition) )

			on :stzListOfObjects
				return new stzListOfObjects( This.ItemsWXT(pcCondition) )

			on :stzListOfPairs
				return new stzListOfPairs( This.ItemsWXT(pcCondition) )

			on :stzListOfHashLists
				return new stzListOfHashLists( This.ItemsWXT(pcCondition) )

			other
				StzRaise("Unsupported return type!")
			off

			def OnlyWXT(pcCondition)
				return This.ItemsWXT(pcCondition)

			def OnlyWhereXT(pcCondition)
				return This.ItemsWXT(pcCondition)

	def NthItemWXT(n, pcCondition)

		cResult = ItemsWXT(pcCondition)[n]
		return cResult

		#< @FunctionFluentForm

		def NthItemWXTQ(n, pCondition)
			item = This.NthItemWXT(n, pCondition)

			switch ring_type(item)
			on "NUMBER"
				return new stzNumber(item)

			on "STRING"
				return new stzString(item)

			on "LIST"
				return new stzList(item)

			on "OBJECT"
				return new stzObject(item)

			other
				StzRaise("Unsupported type!")
			off

		#>

		#< @FunctionAlternativeForm

		def NthItemWhereXT(n, pcCondition)
			return This.NthItemWXT(n, pcCondition)

			def NthItemWhereXTQ(n, pcCondition)
				return This.NthItemWXTQ(n, pCondition)

		#>
		
	def FirstItemWXT(pCondition)
		return This.NthItemWhereXT(1, pCondition)

		#< @FunctionFluentForm

		def FirstItemWXTQ(pCondition)
			item = This.FirstItemWXT(pCondition)

			switch ring_type(item)

			on "NUMBER"
				return new stzNumber(item)

			on "STRING"
				return new stzString(item)

			on "LIST"
				return new stzList(item)

			on "OBJECT"
				return new stzObject(item)

			other
				StzRaise("Unsupported type!")
			off

		#>

	def LastItemWXT(pCondition)
		return This.ItemsW(pCondition)[ len(This.ItemsWXT(pCondition)) ]

		#< @FunctionFluentForm

		def LastItemWXTQ(pCondition)
			item = This.LastItemWXT(pCondition)

			switch ring_type(item)

			on "NUMBER"
				return new stzNumber(item)

			on "STRING"
				return new stzString(item)

			on "LIST"
				return new stzList(item)

			on "OBJECT"
				return new stzObject(item)

			other
				StzRaise("Unsupported type!")
			off

		#>

	  #======================================================#
	 #   GETTING UNIQUE ITEMS VERIFYING A GIVEN CONDITION   #
	#======================================================#

	def UniqueItemsW(pCondition)

		aResult = This.ItemsWQ(pCondition).ToSet()
		return aResult

		def UniqueItemsWQ(pCondition)
			return new stzList( This.UniqueItemsW(pCondition) )

		def UniqueItemsWhere(pCondition)
			return This.UniqueItemsW(pCondition)

			def UniqueItemsWhereQ(pCondition)
				return new stzList( This.UniqueItemsWhere(pcCondition) )

	  #===============================================#
	 #   GETTING ALL ITEMS EXCEPT THE ONE PRPVIDED   #
	#===============================================#

	def AllItemsExceptCS(pItem, pCaseSensitive)
		aResult = This.ItemRemovedCS(pItem, pCaseSensitive)
		return aResult

	#-- WITHOUT CASESENSITIVITY

	def AllItemsExcept(pItem)
		return This.AllItemsExceptCS(pItem, :CaseSensitive = TRUE)

	  #================================================================================#
	 #   GETTING UNIQUE ITEMS VERIFYING A GIVEN CONDITION ALONG WITH THEIR POSITIONS  #
	#================================================================================#

	def ItemsAndTheirPositionsW(pcCondition)
		/* Example
		o1 = new stzList([ "A", "m", "n", "B", "A", "x", "C", "z", "B" ])
		
		? o1.ItemsW('Q(@item).IsUppercase()')
		# --> [ "A", "B", "A", "C", "B" ]
		
		? o1.ItemsPositionsW('Q(@item).IsUppercase()') # Say also o1.FindItemsW(...)
		# --> [ 1, 4, 5, 7, 9 ]
		
		? o1.ItemsAndTheirPositionsW('Q(@item).IsUppercase()')
		# --> [ "A" = [1, 5], "B" = [4, 9], "C" = [7] ]
		*/

		aItems = This.ItemsW(pcCondition)
		anPositions = This.FindItemsW(pcCondition)

		aPairs = StzListQ( aItems ).AssociatedWith( anPositions )
	
		aUniqueItems = StzListQ(aItems).ToSet()

		aResult = []
		anItemPositions = []
		nLenUniqueItems = len(aUniqueItems)

		nLenAPairs = len(aPairs)

		for i = 1 to nLenUniqueItems
			pItem = aUniqueItems[i]
			
			for v = 1 to nLenAPairs
				aPair = aPairs[v]

				if IsNumberOrString(pItem) and IsNumberOrString(aPair[1])

					if aPair[1] = pItem
						anItemPositions + aPair[2]
					ok

				else
					if Q(aPair[1]).IsStrictlyEqualTo(pItem)
						anItemPositions + aPair[2]
					ok
				ok
			next
			
			aResult + [ pItem, anItemPositions ]
			anItemPositions = []

		next

		return aResult

		def ItemsAndTheirPositionsWhere()
			return This.ItemsAndTheirPositionsW(pcCondition)

	   #======================================================#
	  #   GETTING UNIQUE ITEMS VERIFYING A GIVEN CONDITION 	 #
	 #   ALONG WITH THEIR POSITIONS -- EXTENDED             #
	#======================================================#

	def ItemsAndTheirPositionsWXT(pcCondition)
		/*
		This version is less performant then ItemsAndTheirPositionsW()
		but provides more features, like transpiling the conditional
		code for :stzList and idenfifying the executable section.
		*/

		aItems = This.ItemsWXT(pcCondition)
		anPositions = This.FindItemsWXT(pcCondition)

		aPairs = StzListQ( aItems ).AssociatedWith( anPositions )
	
		aUniqueItems = StzListQ(aItems).ToSet()

		aResult = []
		anItemPositions = []
		nLenUniqueItems = len(aUniqueItems)

		nLenAPairs = len(aPairs)

		for i = 1 to nLenUniqueItems
			pItem = aUniqueItems[i]
			
			for v = 1 to nLenAPairs
				aPair = aPairs[v]

				if IsNumberOrString(pItem) and IsNumberOrString(aPair[1])

					if aPair[1] = pItem
						anItemPositions + aPair[2]
					ok

				else
					if Q(aPair[1]).IsStrictlyEqualTo(pItem)
						anItemPositions + aPair[2]
					ok
				ok
			next
			
			aResult + [ pItem, anItemPositions ]
			anItemPositions = []

		next

		return aResult

		def ItemsAndTheirPositionsWhereXT()
			return This.ItemsAndTheirPositionsW(pcCondition)

	  #=================================#
	 #   GETTING ITEMS OF TYPE NUMBER  #
	#=================================#

	def NumberOfNumbers()
		return len( This.Numbers() )

		def CountNumbers()
			return This.NumberOfNumbers()

		def HowManyNumers()
			return This.NumberOfNumbers()

	def Numbers()
		/* WARNING

		Do not use this solution:

			return This.ItemsW('isNumber(@item)')

		#--> Stackovervlow!
		*/

		aResult = []

		for item in This.List()
			if isNumber(item)
				aResult + item
			ok
		next
		
		return aResult

		#< @FunctionFluentForm

		def NumbersQ()
			return This.NumbersQR(:stzList)

		def NumbersQR(pcReturnType)
			if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.Numbers() )

			on :stzListOfNumbers
				return new stzListOfNumbers( This.Numbers() )

			other
				StzRaise("Unsupported return type!")
			off

		#>

		#< @FunctionAlternativeForm

		def OnlyNumbers()
			return This.Numbers()

			def OnlyNumbersQ()
				return This.OnlyNumbersQR(:stzList)
	
			def OnlyNumbersQR(pcReturnType)
				if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.OnlyNumbers() )
	
				on :stzListOfNumbers
					return new stzListOfNumbers( This.OnlyNumbers() )
	
				other
					StzRaise("Unsupported return type!")
				off

		#>

	  #==================================#
	 #   REMOVING ITEMS OF TYPE NUMBER  #
	#==================================#

	def RemoveNumbers()
		anPositions = []

		i = 0
		for item in This.List()
			i++
			if isNumber(item)
				anPositions + i
			ok
		next

		This.RemoveItemsAtThesePositions(anPositions)

		def RemoveNumbersQ()
			This.RemoveNumbers()
			return This

		def RemoveOnlyNumbers()
			This.RemoveNumbers()

			def RemoveOnlyNumbersQ()
				This.RemoveOnlyNumbers()
				return This

	  #========================================#
	 #   GETTING ITEMS WHICH ARE NOT NUMBERS  #
	#========================================#

	def NonNumbers()

		aResult = []

		for item in This.List()
			if NOT isNumber(item)
				aResult + item
			ok
		next
		
		return aResult		

		def NonNumbersQ()
			return This.NonNumbersQR(:stzList)

		def NonNumbersQR(pcReturnType)
			if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.NonNumbers() )

			on :stzListOfNumbers
				return new stzListOfNumbers( This.NonNumbers() )

			other
				StzRaise("Unsupported return type!")
			off

		def OnlyNonNumbers()
			return This.NonNumbers()

			def OnlyNonNumbersQ()
				return This.OnlyNonNumbersQR(:stzList)
	
			def OnlyNonNumbersQR(pcReturnType)
				if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.OnlyNonNumbers() )
	
				on :stzListOfNumbers
					return new stzListOfNumbers( This.OnlyNonNumbers() )
	
				other
					StzRaise("Unsupported return type!")
				off

	  #=========================================#
	 #   REMOVING ITEMS WHICH ARE NOT NUMBERS  #
	#=========================================#

	def RemoveNonNumbers()
		anPositions = []

		i = 0
		for item in This.List()
			i++
			if NOT isNumber(item)
				anPositions + i
			ok
		next

		This.RemoveItemsAtThesePositions(anPositions)

		def RemoveNonNumbersQ()
			This.RemoveNonNumbers()
			return This

		def RemoveOnlyNonNumbers()
			This.RemoveNonNumbers()

			def RemoveOnlyNonNumbersQ()
				This.RemoveOnlyNonNumbers()
				return This

		def RemoveAllExceptNumbers()
			This.RemoveNonNumbers()

			def RemoveAllExceptNumbersQ()
				This.RemoveAllExceptNumbers()
				return This
		
	  #====================================#
	 #   GETTING ITEMS WHICH ARE ITEMS  #
	#====================================#

	def NumberOfStrings()
		return len( This.Strings() )

		def CountStrings()
			return This.NumberOfStrings()

		def HowManyStrings()
			return This.NumberOfStrings()

	def Strings()
		/* WARNING

		Do not use this solution:

			return This.ItemsW('isString(@item)')

		#--> Stackovervlow!
		*/

		aResult = []

		for item in This.List()
			if isString(item)
				aResult + item
			ok
		next
		
		return aResult

		#< @FunctionFluentForm

		def StringsQ()
			return This.StringsQR(:stzList)

		def StringsQR(pcReturnType)
			if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.Strings() )

			on :stzListOfStrings
				return new stzListOfStrings( This.Strings() )

			other
				StzRaise("Unsupported return type!")
			off

		#>

		#< @FunctionAlternativeForm

		def OnlyStrings()
			return This.Strings()

			def OnlyStringsQ()
				return This.OnlyStringsQR(:stzList)
	
			def OnlyStringsQR(pcReturnType)
				if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.OnlyStrings() )
	
				on :stzListOfStrings
					return new stzListOfStrings( This.OmlyStrings() )
	
				other
					StzRaise("Unsupported return type!")
				off

		#>

	  #=====================================#
	 #   REMOVING ITEMS WHICH ARE STRINGS  #
	#=====================================#

	def RemoveStrings()
		anPositions = []

		i = 0
		for item in This.List()
			i++
			if isString(item)
				anPositions + i
			ok
		next

		This.RemoveItemsAtThesePositions(anPositions)

		def RemoveStringsQ()
			This.RemoveStrings()
			return This

		def RemoveOnlyStrings()
			This.RemoveStrings()

			def RemoveOnlyStringsQ()
				This.RemoveOnlyStrings()
				return This

	  #========================================#
	 #   GETTING ITEMS WHICH ARE NOT STRING   #
	#========================================#

	def NonStrings()

		aResult = []

		for item in This.List()
			if NOT isString(item)
				aResult + item
			ok
		next
		
		return aResult		

		def NonStringsQ()
			return This.NonStringsQR(:stzList)

		def NonStringsQR(pcReturnType)
			if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.NonStrings() )

			on :stzListOfStrings
				return new stzListOfStrings( This.NonStrings() )

			other
				StzRaise("Unsupported return type!")
			off

		def OnlyNonStrings()
			return This.NonStrings()

			def OnlyNonStringsQ()
				return This.OnlyNonStringsQR(:stzList)
	
			def OnlyNonStringsQR(pcReturnType)
				if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.OnlyNonStrings() )
	
				on :stzListOfStrings
					return new stzListOfStrings( This.OnlyNonStrings() )
	
				other
					StzRaise("Unsupported return type!")
				off

	  #=========================================#
	 #   REMOVING ITEMS WHICH ARE NOT STRINGS  #
	#=========================================#

	def RemoveNonStrings()
		anPositions = []

		i = 0
		for item in This.List()
			i++
			if NOT isString(item)
				anPositions + i
			ok
		next

		This.RemoveItemsAtThesePositions(anPositions)

		def RemoveNonStringsQ()
			This.RemoveNonStrings()
			return This

		def RemoveOnlyNonStrings()
			This.RemoveNonStrings()

			def RemoveOnlyNonStringsQ()
				This.RemoveOnlyNonStrings()
				return This

		def RemoveAllExceptStrings()
			This.RemoveNonStrings()

			def RemoveAllExceptStringsQ()
				This.RemoveAllExceptStrings()
				return This

	def ListWithNonStringsRemoved()
		return This.Copy().RemoveNonStringsQ().Content()

	  #=================================================#
	 #  LOWERCASING THE STRINGS CONTAINED IN THE LIST  #
	#=================================================#

	def LowercaseStrings()
		for i = 1 to This.NumberOfItems()
			item = This[i]

			if isString(item)
				cStrLow = Q(item).Lowercased()
				This.ReplaceItemAtPosition(i, cStrLow)
			ok
		next

		def LowercaseStringsQ()
			This.LowercaseStrings()
			return This

		def Lowercase()
			This.LowercaseStrings()

			def LowercaseQ()
				This.Lowercase()
				return This

		def ApplyLowercase()
			This.LowercaseStrings()

			def ApplyLowercaseQ()
				This.ApplyLowercase()
				return This

	def ListWithStringsLowercased()
		aResult = This.Copy().LowercaseStringsQ().Content()
		return aResult

		def Lowercased()
			return This.ListWithStringsLowercased()

	def StringsLowercased()
		aResult = []

		for i = 1 to This.NumberOfItems()
			item = This[i]

			if isString(item)
				cStrLow = Q(item).Lowercased()
				aResult + cStrLow
			ok
		next

		return aResult

	  #=================================================#
	 #  UPPERCASING THE STRINGS CONTAINED IN THE LIST  #
	#=================================================#

	def UppercaseStrings()
		for i = 1 to This.NumberOfItems()
			item = This[i]

			if isString(item)
				cStrUpp = Q(item).Uppercased()
				This.ReplaceItemAtPosition(i, cStrUpp)
			ok
		next

		def UppercaseStringsQ()
			This.UppercaseStrings()
			return This

		def Uppercase()
			This.UppercaseStrings()

			def UppercaseQ()
				This.Uppercase()
				return This

		def ApplyUppercase()
			This.UppercaseStrings()

			def ApplyUppercaseQ()
				This.ApplyUppercase()
				return This

	def ListWithStringsUppercased()
		aResult = This.Copy().UppercaseStringsQ().Content()
		return aResult

		def Uppercased()
			return This.ListWithStringsUppercased()

	def StringsUppercased()
		aResult = []

		for i = 1 to This.NumberOfItems()
			item = This[i]

			if isString(item)
				cStrUpp = Q(item).Uppercased()
				aResult + cStrUpp
			ok
		next

		return aResult
	
	  #=================================================#
	 #  TITLECASING THE STRINGS CONTAINED IN THE LIST  #
	#=================================================#

	def TitlecaseStrings()
		for i = 1 to This.NumberOfItems()
			item = This[i]

			if isString(item)
				cStrTtl = Q(item).Titlecased()
				This.ReplaceItemAtPosition(i, cStrTtl)
			ok
		next

		def TitlecaseStringsQ()
			This.TitlecaseStrings()
			return This

		def Titlecase()
			This.TitlecaseStrings()

			def TitlecaseQ()
				This.Titlecase()
				return This

		def ApplyTitlecase()
			This.TitlecaseStrings()

			def ApplyTitlecaseQ()
				This.ApplyTitlecase()
				return This

	def ListWithStringsTitlecased()
		aResult = This.Copy().TitlecaseStringsQ().Content()
		return aResult

		def Titlecased()
			return This.ListWithStringsTitlecased()

	def StringsTitlecased()
		aResult = []

		for i = 1 to This.NumberOfItems()
			item = This[i]

			if isString(item)
				cStrTtl = Q(item).Titlecased()
				aResult + cStrTtl
			ok
		next

		return aResult

	  #==================================================#
	 #  CAPITALIZING THE STRINGS CONTAINED IN THE LIST  #
	#==================================================#

	def CapitaliseStrings()
		for i = 1 to This.NumberOfItems()
			item = This[i]

			if isString(item)
				cStrCap = Q(item).Capitalised()
				This.ReplaceItemAtPosition(i, cStrTtl)
			ok
		next

		def CapitaliseStringsQ()
			This.CapitaliseStrings()
			return This

		def CapitalizeStrings()
			This.CapitaliseStrings()

			def CapitalizeStringsQ()
				This.CapitalizeStrings()
				return This

		def Capitalise()
			This.CapitaliseStrings()

			def CapitaliseQ()
				This.CapitaliseStrings()
				return This

		def Capitalize()
			This.CapitalizeStrings()

			def CapitalizeQ()
				This.Capitalize()
				return This

		def ApplyCapitalcase()
			This.CapitalizeStrings()

			def ApplyCapitalcaseQ()
				This.ApplyCapitalcase()
				return This

	def ListWithStringsCapitalised()
		aResult = This.Copy().CapitaliseStringsQ().Content()
		return aResult

		def ListWithStringsCapitalized()
			return This.ListWithStringsCapitalised()

		def Capitalised()
			return This.ListWithStringsCapitalised()

		def Capitalized()
			return This.ListWithStringsCapitalised()

	def StringsCapitalised()
		aResult = []

		for i = 1 to This.NumberOfItems()
			item = This[i]

			if isString(item)
				cStrCap = Q(item).Capitalised()
				aResult + cStrTtl
			ok
		next

		return aResult

		def StringsCapitalized()
			return This.StringsCapitalised()

	  #=====================================#
	 #   ITEMS OF TYPE LISTS OF STRINGS    #
	#=====================================#

	def ListsOfStrings()
		aResult = []
		for item in this.List()
			if isList(item) and Q(item).IsListOfStrings()
				aResult + item
			ok
		next

		return aResult

	def NumberOfListsOfStrings()
		return len(This.ListsOfStrings())

		def CountListsOfStrings()
			return This.NumberOfListsOfStrings()

		def HowManyListsOfStrings()
			return This.NumberOfListsOfStrings()

	#----

	def LowercaseListsOfStrings()
		for item in This.List()
			if isList(item) and Q(item).IsListOfStrings()
				item = StzListOfStringsQ(item).Lowercased()
			ok
		next

		def LowercaseListsOfStringsQ()
			This.LowercaseListsOfStrings()
			return This

	def ListWithListsOfStringsLowercased()
		return This.Copy().LowercaseListsOfStringsQ().Content()

	def ListsOfStringsLowercased()

	#----

	def UppercaseListsOfStrings()
		for item in This.List()
			if isList(item) and Q(item).IsListOfStrings()
				item = StzListOfStringsQ(item).Uppercased()
			ok
		next

		def UppercaseListsOfStringsQ()
			This.LowercaseListsOfStrings()
			return This

	def ListWithListsOfStringsUppercased()
		return This.Copy().UppercaseListsOfStringsQ().Content()

	  #-----------------------------------------------#
	 #     GETTING & REMOVING ITEMS OF TYPE LIST     #
	#-----------------------------------------------#

	def NumberOfLists()
		return len( This.Lists() )

		def CountLists()
			return This.NumberOfLists()

		def HowManyLists()
			return This.NumberOfLists()

	def Lists()
		/* WARNING

		Do not use this solution:

			return This.ItemsW('isList(@item)')

		#--> Stackovervlow!
		*/

		aResult = []

		for item in This.List()
			if isList(item)
				aResult + item
			ok
		next
		
		return aResult

		#< @FunctionFluentForm

		def ListsQ()
			return This.ListsQR(:stzList)

		def ListsQR(pcReturnType)
			if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.Lists() )

			on :stzListOfLists
				return new stzListOfLists( This.Lists() )

			other
				StzRaise("Unsupported return type!")
			off

		#>

		#< @FunctionAlternativeForm

		def OnlyLists()
			return This.Lists()

			def OnlyListsQ()
				return This.OnlyListsQR(:stzList)
	
			def OnlyListsQR(pcReturnType)
				if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.OnlyLists() )
	
				on :stzListOfLists
					return new stzListOfLists( This.OnlyLists() )
	
				other
					StzRaise("Unsupported return type!")
				off

		#>

	def RemoveLists()
		anPositions = []

		i = 0
		for item in This.List()
			i++
			if isList(item)
				anPositions + i
			ok
		next

		This.RemoveItemsAtThesePositions(anPositions)

		def RemoveListsQ()
			This.RemoveLists()
			return This

		def RemoveOnlyLists()
			This.RemoveLists()

			def RemoveOnlyListsQ()
				This.RemoveOnlyLists()
				return This

	def NonLists()

		aResult = []

		for item in This.List()
			if NOT isList(item)
				aResult + item
			ok
		next
		
		return aResult		

		def NonListsQ()
			return This.NonListsQR(:stzList)

		def NonListsQR(pcReturnType)
			if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.NonLists() )

			on :stzListOfLists
				return new stzListOfLists( This.NonLists() )

			other
				StzRaise("Unsupported return type!")
			off

		def OnlyNonLists()
			return This.NonLists()

			def OnlyNonListsQ()
				return This.OnlyNonListsQR(:stzList)
	
			def OnlyNonListsQR(pcReturnType)
				if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.OnlyNonLists() )
	
				on :stzListOfLists
					return new stzListOfLists( This.OnlyNonLists() )
	
				other
					StzRaise("Unsupported return type!")
				off

	def RemoveNonLists()
		anPositions = []

		i = 0
		for item in This.List()
			i++
			if NOT isList(item)
				anPositions + i
			ok
		next

		This.RemoveItemsAtThesePositions(anPositions)

		def RemoveNonListsQ()
			This.RemoveNonLists()
			return This

		def RemoveOnlyNonLists()
			This.RemoveNonLists()

			def RemoveOnlyNonListsQ()
				This.RemoveOnlyNonLists()
				return This

		def RemoveAllExceptLists()
			This.RemoveNonLists()

			def RemoveAllExceptListsQ()
				This.RemoveAllExceptLists()
				return This

	  #-------------------------------------------------#
	 #     GETTING & REMOVING ITEMS OF TYPE OBJECT     #
	#-------------------------------------------------#

	def NumberOfObjects()
		return len( This.Objects() )

		def CountObjecs()
			return This.NumberOfObjects()

		def HowManyObjects()
			return This.NumberOfObjects()

	def Objects()
		/* WARNING

		Do not use this solution:

			return This.ItemsW('isObject(@item)')

		#--> Stackovervlow!
		*/

		aResult = []

		for item in This.Object()
			if isObject(item)
				aResult + item
			ok
		next
		
		return aResult

		#< @FunctionFluentForm

		def ObjectsQ()
			return This.ObjectsQR(:stzObject)

		def ObjectsQR(pcReturnType)
			if isObject(pcReturnType) and StzObjectQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzObject
				return new stzObject( This.Objects() )

			on :stzObjectOfObjects
				return new stzObjectOfObjects( This.Objects() )

			other
				StzRaise("Unsupported return type!")
			off

		#>

		#< @FunctionAlternativeForm

		def OnlyObjects()
			return This.Objects()

			def OnlyObjectsQ()
				return This.OnlyObjectsQR(:stzObject)
	
			def OnlyObjectsQR(pcReturnType)
				if isObject(pcReturnType) and StzObjectQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok

				switch pcReturnType
				on :stzObject
					return new stzObject( This.OnlyObjects() )
	
				on :stzObjectOfObjects
					return new stzObjectOfObjects( This.OnlyObjects() )
	
				other
					StzRaise("Unsupported return type!")
				off

		#>

	def RemoveObjects()
		anPositions = []

		i = 0
		for item in This.Object()
			i++
			if isObject(item)
				anPositions + i
			ok
		next

		This.RemoveItemsAtThesePositions(anPositions)

		def RemoveObjectsQ()
			This.RemoveObjects()
			return This

		def RemoveOnlyObjects()
			This.RemoveObjects()

			def RemoveOnlyObjectsQ()
				This.RemoveOnlyObjects()
				return This

	def NonObjects()

		aResult = []

		for item in This.Object()
			if NOT isObject(item)
				aResult + item
			ok
		next
		
		return aResult		

		def NonObjectsQ()
			return This.NonObjectsQR(:stzObject)

		def NonObjectsQR(pcReturnType)
			if isObject(pcReturnType) and StzObjectQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzObject
				return new stzObject( This.NonObjects() )

			on :stzObjectOfObjects
				return new stzObjectOfObjects( This.NonObjects() )

			other
				StzRaise("Unsupported return type!")
			off

		def OnlyNonObjects()
			return This.NonObjects()

			def OnlyNonObjectsQ()
				return This.OnlyNonObjectsQR(:stzObject)
	
			def OnlyNonObjectsQR(pcReturnType)
				if isObject(pcReturnType) and StzObjectQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok

				switch pcReturnType
				on :stzObject
					return new stzObject( This.OnlyNonObjects() )
	
				on :stzObjectOfObjects
					return new stzObjectOfObjects( This.OnlyNonObjects() )
	
				other
					StzRaise("Unsupported return type!")
				off

	def RemoveNonObjects()
		anPositions = []

		i = 0
		for item in This.Object()
			i++
			if NOT isObject(item)
				anPositions + i
			ok
		next

		This.RemoveItemsAtThesePositions(anPositions)

		def RemoveNonObjectsQ()
			This.RemoveNonObjects()
			return This

		def RemoveOnlyNonObjects()
			This.RemoveNonObjects()

			def RemoveOnlyNonObjectsQ()
				This.RemoveOnlyNonObjects()
				return This

		def RemoveAllExceptObjects()
			This.RemoveNonObjects()

			def RemoveAllExceptObjectsQ()
				This.RemoveAllExceptObjects()
				return This

	  #--------------------------------------------------#
	 #     COUNTING ITEMS VERIFYING A GIVEN CONDITION   #
	#--------------------------------------------------#

	def CountItemsW(pCondition)
		aItems = This.FindW(pCondition)

		nResult = len(aItems)

		return nResult
		
		#< @AlternativeFunctionNames

		def CountW(pCondition)
			return This.CountItemsW(pCondition)

		def NumberOfOccurrenceW(pCondition)
			return This.CountItemsW(pCondition)

		def NumberOfOccurrencesW(pCondition)
			return This.CountItemsW(pCondition)

		def NumberOfItemsW(pCondition)
			return This.CountItemsW(pCondition)

		def HowManyItemsW(pcCondition)
			return This.CountItemsW(pCondition)
		#>
			
	def NumberOfUniqueItemsW(pCondition)
		return len( This.UniqueItemsW(pCondition) )

		def CountUniqueItemsW(pccondition)
			return This.NumberOfUniqueItemsW(pCondition)

		def HowManyUniqueItemsW(pcCondition)
			return This.NumberOfUniqueItemsW(pCondition)

	  #--------------------------------------------------------------------#
	 #  INSERTING ITEM AFTER OR BEFORE ITEMS VERIFYING A GIVEN CONDITION  #
	#--------------------------------------------------------------------#

	def InsertAfterW( pcCondition, pNewItem )
		anPositions = This.FindItemsW(pcCondition)
		This.InsertAfterManyPositions( anPositions, pNewItem )

		#< @FunctionFluentForm

		def InsertAfterWQ( pcCondition, pNewItem )
			This.InsertAfterW( pCondition, pNewItem )
			return This

		#>

		def InsertAfterWhere(pcCondition, pNewItem)
			This.InsertAfterW(pCondition, pNewItem)

			def InsertAfterWhereQ(pcCondition, pNewItem)
				This.InsertAfterWhere(pcCondition, pNewItem)
				return This

	def InsertBeforeW(pcCondition, pNewItem)
		/*
		o1.InsertBeforeW( :Where = '{ StzStringQ(item).IsUppercase() }', "*" )
		*/

		anPositions = This.FindItemsW(pcCondition)
		This.InsertBeforeThesePositions(anPositions, pNewItem)

		#< @FunctionFluentForm

		def InsertBeforeWQ(pcCondition, pNewItem)
			This.InsertBeforeW(pcCondition, pNewItem)
			return This

		#>

		def InsertAtW(pcCondition, pNewItem)
			This.InsertBeforeW(pcCondition, pNewItem)

			def InsertAtWQ(pcCondition, pNewItem)
				This.InsertAt(pcCondition, pNewItem)
				return This

	  #-----------------------------------------------------------------#
	 #  INSERTING MANY ITEMS AFTER OR BEFORE A GIVEN SET OF POSITIONS  #
	#-----------------------------------------------------------------#

	def InsertAfterManyPositions(panPositions, pItem)

		for i = 1 to len(panPositions)
			n = panPositions[i] + i - 1
			This.InsertAfter(n, pItem)
		next

		#< @FunctionFluentForm

		def InsertAfterManyPositionsQ(panPositions, pItem)
			This.InsertAfterManyPositions(panPositions, pItem)
			return This

		#>

		#< @FunctionAlternativeForms

		def InsertAfterThesePositions(panPositions, pItem)
			This.InsertAfterManyPositions(panPositions, pItem)

			def InsertAfterThesePositionsQ(panPositions, pItem)
				This.InsertAfterThesePositions(panPositions, pItem)
				return This

		def InsertAfterPositions(panPositions, pItem)
			This.InsertAfterPositions(panPositions, pItem)

			def InsertAfterPositionsQ(panPositions, pItem)
				This.InsertAfterThesePositions(panPositions, pItem)
				return This

		#>

	def InsertBeforeManyPositions(panPositions, pItem)
		for i = 1 to len(panPositions)
			n = panPositions[i] + i - 1
			This.InsertBefore(n, pItem)
		next

		#< @FunctionFluentForm
		
		def InsertBeforeManyPositionsQ(panPositions, pItem)
			This.InsertBeforeManyPositions(panPositions, pItem)
			return This

		#>

		#< @FunctionAlternativeForms

		def InsertBeforeThesePositions(panPositions, pItem)
			This.InsertBeforeManyPositions(panPositions, pItem)

			def InsertBeforeThesePositionsQ(panPositions, pItem)
				This.InsertBeforeThesePositions(panPositions, pItem)
				return This

		def InsertBeforePositions(panPositions, pItem)
			This.InsertBeforeManyPositions(panPositions, pItem)

			def InsertBeforePositionsQ(panPositions, pItem)
				This.InsertBeforeThesePositions(panPositions, pItem)
				return This

		def InsertAtPositions(panPositions, pItem)
			This.InsertBeforeManyPositions(panPositions, pItem)

			def InsertAtPositionsQ(panPositions, pItem)
				This.InsertBeforeThesePositions(panPositions, pItem)
				return This

		#>

	  #----------------------------------------------#
	 #    SPLITTING THE LIST USING THE GIVEN ITEM   #
	#----------------------------------------------#

	def SplitCS(pItem, pCaseSensitive)
		if isList(pItem) and Q(pItem).IsUsingNamedParam()
			pItem = pItem[2]
		ok

		anPos = This.FindAllCS(pItem, pCaseSensitive)
		aResult = This.SplitAtPositions(anPos)

		return aResult

		#< @FunctionFluentForm

		def SplitCSQ(pItem, pCaseSensitive)
			return This.SplitCSQR(pItem, pCaseSensitive, :stzList)

		def SplitCSQR(pItem, pCaseSensitive, pcReturnType)
			if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.SplitCS(pItem, pCaseSensitive) )

			on :stzListOfLists
				return new stzListOfLists( This.SplitCS(pItem, pCaseSensitive) )

			on :stzListOfPairs
				return new stzListOfPairs( This.SplitCS(pItem, pCaseSensitive) )

			on :stzListOfStrings
				return new stzListOfStrings( This.SplitCS(pItem, pCaseSensitive) )
 
			on :stzListOfNumbers
				return new stzListOfNumbers( This.SplitCS(pItem, pCaseSensitive) )

			other
				StzRaise("Unsupported return type!")
			off

		#>

		#< @FunctionAlternativeNames

		def SplitUsingCS(pItem, pCaseSensitive)
			This.SplitCS(pItem, pCaseSensitive)

			def SplitUsingCSQ(pItem, pCaseSensitive)
				return This.SplitUsingCSQR(pItem, pCaseSensitive, pcReturnType)
	
			def SplitUsingCSQR(pItem, pCaseSensitive, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.SplitUsingCS(pItem, pCaseSensitive) )
	
				on :stzListOfLists
					return new stzListOfLists( This.SplitUsingCS(pItem, pCaseSensitive) )
	
				on :stzListOfPairs
					return new stzListOfPairs( This.SplitUsingCS(pItem, pCaseSensitive) )
	
				on :stzListOfStrings
					return new stzListOfStrings( This.SplitUsingCS(pItem, pCaseSensitive) )
	 
				on :stzListOfNumbers
					return new stzListOfNumbers( This.SplitUsingCs(pItem, pCaseSensitive) )
	
				other
					StzRaise("Unsupported return type!")
				off

		def SplitAtCS(pItem, pCaseSensitive)
			return This.SplitCS(pItem, pCaseSensitive)

			def SplitAtCSQ(pItem, pCaseSensitive)
				return This.SplitAtCSQR(pItem, pCaseSensitive, :stzList)

			def SplitAtCSQR(pItem, pCaseSensitive, pcReturnType)
				return This.SplitCSQR(pItem, pCaseSensitive, pcReturnType)

		#>

	#-- WITHOUT CASESENSITIVITY

	def Split(pItem)
		if isList(pItem) and Q(pItem).IsUsingNamedParam()
			pItem = pItem[2]
		ok

		anPos = This.FindAll(pItem)
		aResult = This.SplitAtPositions(anPos)

		return aResult

		#< @FunctionFluentForm

		def SplitQ(pItem)
			return This.SplitQR(pItem, :stzList)

		def SplitQR(pItem, pcReturnType)
			if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.Split(pItem) )

			on :stzListOfLists
				return new stzListOfLists( This.Split(pItem) )

			on :stzListOfPairs
				return new stzListOfPairs( This.Split(pItem) )

			on :stzListOfStrings
				return new stzListOfStrings( This.Split(pItem) )
 
			on :stzListOfNumbers
				return new stzListOfNumbers( This.Split(pItem) )

			other
				StzRaise("Unsupported return type!")
			off

		#>

		#< @FunctionAlternativeNames

		def SplitUsing(pItem)
			This.Split(pItem)

			def SplitUsingQ(pItem)
				return This.SplitUsingQR(pItem, pcReturnType)
	
			def SplitUsingQR(pItem, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok

				switch pcReturnType
				on :stzList
					return new stzList( This.SplitUsing(pItem) )
	
				on :stzListOfLists
					return new stzListOfLists( This.SplitUsing(pItem) )
	
				on :stzListOfPairs
					return new stzListOfPairs( This.SplitUsing(pItem) )
	
				on :stzListOfStrings
					return new stzListOfStrings( This.SplitUsing(pItem) )
	 
				on :stzListOfNumbers
					return new stzListOfNumbers( This.SplitUsing(pItem) )
	
				other
					StzRaise("Unsupported return type!")
				off

		def SplitAt(pItem)
			return This.Split(pItem)

			def SplitAtQ(pItem)
				return This.SplitAtQR(pItem, :stzList)

			def SplitAtQR(pItem, pcReturnType)
				return This.SplitQR(pItem, pcReturnType)

		#>

	  #----------------------------------------------------------------------#
	 #    SPLITTING THE LIST AT POSITIONS RETURNED BY THE GIVEN CONDITION   #
	#----------------------------------------------------------------------#

	def SplitW(pcCondition)
		anPos = FindW(pcCondition)
		aResult = SplitAtPositions(anPos)

		return aResult

		#< @FunctionFluentForm

		def SplitWQ(pcCondition)
			return This.SplitWQR(pcCondition, :stzList)

		def SplitWQR(pcCondition, pcReturnType)
			switch pcReturnType
			on :stzList
				return new stzList( This.SplitW(pcCondition) )

			/* ... */
			off

		#>

		#< @FunctionAlternativeForms

		def SplitAtW(pcCondition)
			return This.SplitW(pcCondition)

		#>

	  #---------------------------------------------------------------------------------#
	 #    SPLITTING THE LIST AT POSITIONS RETURNED BY THE GIVEN CONDITION -- EXTENDED  #
	#---------------------------------------------------------------------------------#

	def SplitWXT(pcCondition)
		anPos = This.FindWXT(pcCondition)

		aResult = This.SplitAtPositions(anPos)

		return aResult

		def SplitAtWXT(pcCondition)
			return This.SplitWXT(pcCondition)

	  #------------------------------------#
	 #    SPLITTING TO PARTS OF N ITEMS   #
	#------------------------------------#
	
	def SplitToPartsOfNItems(n)
		oSplitter = new stzSplitter(This.List())
		aSplitted = oSplitter.SplitToPartsOfNItems(n)

		if isString(aSplitted) and aSplitted = NULL
			return NULL

		but len(aSplitted) = 1
			aResult = []
			aResult + This.List()

		but len(aSplitted) = This.NumberOfItems()
			aResult = []

			for item in This.List()
				aResult + [ item ]
			next

		else
			# Tranforming the sections of positions contained in aSplitted
			# to sublists of the actual items corresponding to those sections
	
			aResult = []
	
			for aSection in aSplitted
				aResult + This.Section( aSection[1], aSection[2] )
			next
		ok

		return aResult

		#< @FunctionFluentForm

		def SplitToPartsOfNItemsQR(n, pcReturnType)
			if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.SplitToPartsOfNItems(n) )

			on :stzListOfLists
				return new stzListOfLists( This.SplitToPartsOfNItems(n) )

			on :stzListOfPairs
				return new stzListOfPairs( This.SplitToPartsOfNItems(n) )
	
			on :stzListOfStrings
				return new stzListOfStrings( This.SplitToPartsOfNItems(n) )
	
			on :stzListOfNumbers
				return new stzListOfNumbers( This.SplitToPartsOfNItems(n) )

			other
				StzRaise("Unsupported return type!")
			off


		def SplitToPartsOfNItemsQ(n)
			return This.SplitToPartsOfNItemsQR(n, :stzList)
	
		#< @FunctionAlternativeForms

		def SplitToPartsOfN(n)
			return This.SplitToPartsOfNItems(n)

			#< @FunctionFluentForm

			def SplitToPartsOfNQ(n)
				return This.SplitToPartsOfNItemsQR(n, :stzList)
	
			def SplitToPartsOfNQR(n, pcReturnType)
				if isList(pcReturnType) and Q(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok

				return This.SplitToPartsOfNItemsQR(n, pcReturnType)

			#>

		def SplitToPartsOf(n)
			return This.SplitToPartsOfNItems(n)

			#< @FunctionFluentForm

			def SplitToPartsOfQ(n)
				return This.SplitToPartsOfNItemsQR(n, :stzList)
	
			def SplitToPartsOfQR(n, pcReturnType)
				if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok

				return This.SplitToPartsOfNItemsQR(n, pcReturnType)

			#>

		def SplitToParts(n)
			if isList(n) and StzListQ(n).IsOfNamedParam()
				n = n[2]
			ok

			return This.SplitToPartsOf(n)

			def SplitToPartsQ(n)
				return This.SplitToPartsQR(n, :stzList)
	
			def SplitToPartsQR(n, pcReturnType)
				if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok

				return This.SplitToPartsOfNItemsQR(n, pcReturnType)
		#>

	  #-----------------------------------#
	 #    SPLITTING AT GIVEN POSITIONS   #
	#-----------------------------------#

	def SplitAtPositions(panPositions)
		oSplitter = new stzSplitter(This.NumberOfItems())
		aSections = oSplitter.SplitAtPositions(panPositions)
		aResult = This.Sections(aSections)

		return aResult

	  #-------------------------------------#
	 #  SPLITTING BEFORE A GIVEN POSITION  #
	#-------------------------------------#

	def SplitBeforePosition(n)
		oSplitter = new stzSplitter(This.NumberOfItems())
		aSections = This.SplitBeforePosition(n)
		aResult = This.Sections(aSections)

		return aResult

		#< @FunctionFluentForm

		def SplitBeforePositionQ(n)
			return new stzListOfLists( This.SplitBeforePosition(n) )

		#>

		#< @FunctionAlternativeForm

		def SplitBefore(n)
			return  This.SplitBeforePosition(n)

			#< @FunctionFluentForm

			def SplitBeforeQ(n)
				return new stzListOfLists( This.SplitBefore(n) )

			#>

		#>

	  #--------------------------------------#
	 #    SPLITTING BEFORE MANY POSITIONS   #
	#--------------------------------------#

	def SplitBeforePositions(panPositions)

		oSplitter = new stzSplitter(This.NumberOfItems())
		aSections = oSplitter.SplitBeforePositions(panPositions)

		aResult = This.Sections(aSections)
		return aResult

		#< @FunctionFluentForm

		def SplitBeforePositionsQ(panPositions)
			return new stzListOfLists( This.SplitBeforePositions(panPositions) )

		#>

	  #---------------------------------------#
	 #    SPLITTING AFTER A GIVEN POSITION   #
	#---------------------------------------#

	def SplitAfterPosition(n)
		return This.SplitAfterPosistions([n])

		#< @FunctionFluentForm

		def SplitAfterPositionQ(n)
			return new stzList( This.SplitAfterPosition(n) )

		#>

		#< @FunctionAlternativeForm

		def SplitAfter(n)
			return  This.SplitAfterPositions(n)

		#>

	  #-------------------------------------#
	 #    SPLITTING AFTER MANY POSITIONS   #
	#-------------------------------------#

	def SplitAfterPositions(panPositions)
		oSplitter = new stzSplitter(This.NumberOfItems())
		aSections = oSplitter.SplitAfterPositions(panPositions)

		aResult = This.Sections(aSections)
		return aResult

		#< @FunctionFluentForm

		def SplitAfterPositionsQ(panPositions)
			return new stzListOfLists( This.SplitAfterPositions(panPositions) )

		#>

	  #---------------------------#
	 #    SPLITTING TO N PARTS   # TODO: Should be deleagted to stzSplitter
	#---------------------------#

	def SplitToNParts(n)

		aResult = []
	
		nParts = ceil( This.NumberOfItems() / n )

		nLen = This.NumberOfItems()
		nMax = Max([ n, nLen ])

		for i = 1 to nMax step nParts
			
			if i <= nLen
				aTemp = This.Range(i, nParts)
			else
				aTemp = []
			ok

			aResult + aTemp	
		next

		return aResult

		#< @FunctionFluentForm

		def SplitToNPartsQ(n)
			return new stzList( This.SplitToNParts(n) )

		#>

	  #-----------------------------------------------------------#
	 #    SPLITTING BEFORE AN ITEM VERIFYING A GIVEN CONDITION   #
	#-----------------------------------------------------------#

	def SplitBeforeW(pCondition)
		anPositions = This.FindW(pcCondition)
		aResult = This.SplitBeforePositions(anPositions)

		return aResult	

		def SplitBeforeWQ(pCondition)
			return new stzList( This.SplitBeforeW(pCondition) )

		def SplittedBeforeW(pcCondition)
			return This.SplitBeforeW(pCondition)

		def SplitBeforeWhere(pCondition)
			return This.SplitBeforeW(pCondition)

		def SplittedBeforeWhere(pcCondition)
			return This.SplitBeforeW(pCondition)

	  #-----------------------------------------------------------#
	 #    SPLITTING AFTER AN ITEM VERIFYING A GIVEN CONDITION    #
	#-----------------------------------------------------------#

	def SplitAfterW(pCondition)
		anPositions = This.FindW(pcCondition)
		aResult = This.SplitAfterPositions(anPositions)

		return aResult	

		def SplitAfterWQ(pCondition)
			return new stzList( This.SplitAfterW(pCondition) )

		def SplittedAfterW(pcCondition)
			return This.SplitAfterW(pCondition)

		def SplitAfterWhere(pCondition)
			return This.SplitAfterW(pCondition)

		def SplittedAfterWhere(pcCondition)
			return This.SplitAfterW(pCondition)

	  #------------------------------------------------#
	 #    GETTING A SECTION (OR SLICE) OF THE LIST    #
	#------------------------------------------------#
	/*
	TODO: Think of a syntax that return the section withount the
	extremities, like for example:

	o1.Section(:@, ']5, 8]') --> [6, 7, 8]

	*/

	def Section(n1, n2)


		# Managing the use of :From and :To named params

		if isList(n1) and
		   StzListQ(n1).IsOneOfTheseNamedParams([
				:From, :FromPosition,
				:StartingAt, :StartingAtPosition
				])

			n1 = n1[2]
		ok

		if isList(n2) and
		   StzListQ(n2).IsOneOfTheseNamedParams([
				:To, :ToPosition,
				:Until, :UntilPosition,
				:UpTo, :UpToPosion
				])

			n2 = n2[2]
		ok

		# Managing the use of :NthToFirst named param

		if isList(n1) and Q(n1).IsOneOfTheseNamedParams([
					:NthToFirst, :NthToFirstItem ])

			n1 = n1[2] + 1
		ok

		if isList(n2) and Q(n2).IsOneOfTheseNamedParams([
					:NthToFirst, :NthToFirstItem ])

			n2 = n2[2] + 1
		ok

		# Managing the use of :NthToLast named param

		if isList(n1) and Q(n1).IsOneOfTheseNamedParams([
					:NthToLast, :NthToLastItem ])

			n1 = This.NumberOfItems() - n1[2]
		ok

		if isList(n2) and Q(n2).IsOneOfTheseNamedParams([
					:NthToLast, :NthToLastItem ])

			n2 = This.NumberOfItems() - n2[2]
		ok

		# Managing the case of :First and :Last keywords

		if isString(n1)
			if Q(n1).IsOneOfThese([ :First, :FirstItem, :StartOfList ])
				n1 = 1

			but Q(n1).IsOneOfThese([ :Last, :LastItem, :EndOfList ])
				n1 = This.NumberOfItems()

			but Q(n1) = :@
				n1 = n2
			ok
		ok
	
		if isString(n2)
			if Q(n2).IsOneOfThese([ :Last, :LastItem, :EndOfList ])
				n2 = This.NumberOfItems()

			but Q(n2).IsOneOfThese([ :First, :FirstItem, :StartOfList ])
				n2 = 1

			but Q(n2) = :@
				n2 = n1
			ok
		ok

		if n1 = :@ and n2 = :@
			n1 = 1
			n2 = This.NumberOfItems()
		ok

		if n1 < 0
			n1 = This.NumberOfItems() + n1 + 1
		ok

		if n2 < 0
			n2 = This.NumberOfItems() + n2 + 1
		ok

		# If the params are not numbers, so find them and take their positions
		# EXAMPLE:
		# 	? Q([ "S", "O", "F", "T", "A", "N", "Z", "A" ]).
		# 		Section(:From = "F", :To = "A") #--> [ "F", "T", "A" ]

		if NOT isNumber(n1)
			n1 = This.FindFirst(n1)
		ok

		if NOT isNumber(n2)
			n2 = This.FindFirst(n2)
		ok

		# Params must be numbers

		if NOT BothAreNumbers(n1, n2)
			StzRaise("Incorrect params! n1 and n2 must be numbers.")
		ok

		# If the params are given in inversed order, return reversed section

		if n1 > n2
			nTemp = n1
			n1 = n2
			n2 = nTemp

			return This.SectionQ(n1, n2).Reversed()
		ok
	
		# Managing out of range params

		if NOT 	( Q(n1).IsBetween(1, This.NumberOfItems()) and
			  Q(n2).IsBetween(1, This.NumberOfItems())
			)
			
			return []
		ok

		# Finally, we're ready to extract the section

		aResult = []
		for i = n1 to n2
			aResult + This.Content()[i]
		next i
		
		return aResult	

		#< @FunctionFluentForm

		def SectionQ(n1, n2)
			return This.SectionQR(n1, n2, :stzList)

		def SectionQR(n1, n2, pcReturntype)
			if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType

			on :stzList
				return new stzList( This.Section(n1, n2) )

			on :stzListOfStrings
				return new stzListOfStrings( This.Section(n1, n2) )

			on :stzListOfNumbers
				return new stzListOfNumbers( This.Section(n1, n2) )

			on :stzListOfLists
				return new stzListOfLists( This.Section(n1, n2) )

			on :stzListOfObjects
				return new stzListOfObjects( This.Section(n1, n2) )

			other
				StzRaise("Unsupported return type!")
			off
		#>

		#< @FunctionAlternativeForm

		def Slice(n1, n2)
			return This.Section(n1, n2)

			def SliceQ(n1, n2)
				return This.SliceQR(n1, n2, :stzList)
	
			def SliceQR(n1, n2, pcReturntype)
				if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
					pcReturnType = pcReturnType[2]
				ok
	
				switch pcReturnType
	
				on :stzList
					return new stzList( This.Slice(n1, n2) )
	
				on :stzListOfStrings
					return new stzListOfStrings( This.Slice(n1, n2) )
	
				on :stzListOfNumbers
					return new stzListOfNumbers( This.Slice(n1, n2) )
	
				on :stzListOfLists
					return new stzListOfLists( This.Slice(n1, n2) )
	
				on :stzListOfObjects
					return new stzListOfObjects( This.Slice(n1, n2) )
	
				other
					StzRaise("Unsupported return type!")
				off
		#>

	  #---------------------------------------#
	 #   GETIING MANY SECTIONS (OR SLICES)   #
	#---------------------------------------#

	def Sections(paSections)
		if NOT ( isList(paSections) and Q(paSections).IsListOfPairsOfNumbers() )

			StzRaise("Incorrect param type! paSections must be a list of pairs of numbers.")

		ok

		if len(paSections) = 0
			return []
		ok

		aResult = []

		for aSection in paSections
			aResult + This.Section( aSection[1], aSection[2] )
		next

		return aResult

		def ManySections(paSections)
			return This.Sections(paSections)

		def Slices(paSections)
			return This.Sections(paSections)

		def ManySlices(paSections)
			return This.Sections(paSections)

	  #---------------------------------------------------#
	 #   GETIING MANY SECTIONS (OR SLICES) -- EXTENDED   #
	#---------------------------------------------------#

	def SectionsXTCS(pItem1, pItem2, pCaseSensitive)
		/* EXAMPLE

		o1 = new stzList([ "T", "A", "Y", "O", "U", "B", "T", "A" ])
		? o1.SectionsXT( :From = "T", :To = "A" )
		#--> [ ["T", "A"], [ "T", "A", "Y", "O", "U", "B", "T", "A" ], ["T", "A"] ]

		*/

		if isList(pItem1) and Q(pItem1).IsFromNamedParam()
			pItem1 = pItem1[2]
		ok

		if isList(pItem2) and Q(pItem2).IsToNamedParam()
			pItem2 = pItem2[2]
		ok

		anSections = []

		anPos1 = This.FindAllCS(pItem1, pCaseSensitive) #--> [ 1, 7 ]
		anPos2 = This.FindAllCS(pItem2, pCaseSensitive) #--> [ 2, 8 ]

		for n1 in anPos1
			for n2 in anPos2
				if n1 < n2
					anSections + [ n1, n2 ]
				ok
			next
		next

		#--> [ [ 1, 2 ], [ 1, 8 ], [ 7, 8 ] ]

		acResult = This.Sections(anSections)
		return acResult

	#-- WTHOUT CASESENSITIVITY

	def SectionsXT(pItem1, pItem2)
		return This.SectionsXTCS(pItem1, pItem2, :CaseSensitive = TRUE)

	  #----------------------------------------------------------#
	 #   GETIING THE ANTI-SECTIONS OF A GIVEN SET OF SECTIONS   #
	#----------------------------------------------------------#

	def FindAntiSections(paSections)
		/* EXAMPLE
		o1 = new stzList("A":"J")
		? o1.AntiSections( :Of = [ [3,5], [7,8] ])
		#--> [ ["A", "B"], ["F"], ["I", "J"] ]

		? o1.FindAntiSections( :Of = [ [3,5], [7,8] ])
		#--> [ [1, 2], [6, 6], [9, 10] ]

		*/

		if isList(paSections) and Q(paSections).IsOfNamedParam()
			paSections = paSections[2]
		ok

		if isList(paSections) and len(paSections) = 0
			return []
		ok

		if NOT Q(paSections).IsListOfPairsOfNumbers()
			StzRaise("Incorrect param! paSections must be a list of pairs of numbers.")
		ok

		aSorted = StzListOfPairsQ(paSections).SortedInAscending()
		#--> [ [3,5], [7,8] ]

		aAntiSections = []
		n1 = 1

		i = 0
		bLastPair = FALSE

		for aPair in aSorted
			i++
			if i = len(aSorted)
				bLastPair = TRUE
			ok

			if aPair[1] > n1
				n2 =  aPair[1] - 1
				aAntiSections + [ n1, n2 ]
			ok

			if NOT bLastPair
				n1 = aPair[2] + 1
			ok
		next

		nLast = aSorted[ len(aSorted) ][2]
		nSize = This.NumberOfItems()

		if nLast < nSize
			aAntiSections + [ nLast + 1, nSize ]
		ok

		aResult = aAntiSections
		return aResult

		#< @FunctionFluentForm

		def FindAntiSectionsQ(paSections)
			return This.FindAntiSectionsQR(paSections, :stzList)

		def FindAntiSectionsQR(paSections, pcReturnType)
			if NOT isString(pcReturnType)
				StzRaise("Incorrect param type! pcReturnType must be a string.")
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.FindAntiSections(paSections) )

			on :stzListOfLists
				return new stzListOfLists( This.FindAntiSections(paSections) )

			on :stzListOfPairs
				return new stzListOfPairs( This.FindAntiSections(paSections) )

			other
				StzRaise("Unsupported return type!")
			off

		#>

	def AntiSections(paSections)
		/* EXAMPLE
		o1 = new stzList("A":"J")
		? o1.AntiSections( :Of = [ [3,5], [7,8] ])
		#--> [ ["A", "B"], ["F"], ["I", "J"] ]
		*/

		aResult = This.Sections(This.FindAntiSections(paSections))
		return aResult

		def SectionsOtherThan(paSections)
			return This.AntiSections(paSections)

		#< @FunctionFluentForm

		def AntiSectionsQ(paSections)
			return new stzList( This.AntiSections(paSections) )

		#>

	def FindAsSectionsAndAntiSections(paSections)
		aAntiSections = This.FindAntiSections(paSections)

		for aList in aAntiSections
			if len(aList) = 1
				aList + aList[1]

			but len(aList) > 2
				n1 = aList[1]
				n2 = aList[len(aList)]
				aList = [n1, n2]
			ok
		next

		aAllSections = aAntiSections
		for aPair in paSections
				aAllSections + aPair
		next

		aAllSections = StzListOfPairsQ(aAllSections).SortedInAscending()

		aResult = aAllSections
		return aResult

		#< @FunctionFluentForm

		def FindAsSectionsAndAntiSectionsQ(paSections)
			return This.FindAsSectionsAndAntiSectionsQR(paSections, :stzList)

		def FindAsSectionsAndAntiSectionsQR(paSections, pcReturnType)
			if NOT isString(pcReturnType)
				StzRaise("Incorrect param type! pcReturnType must be a string.")
			ok

			switch pcReturnType
			on :stzList
				return new stzList( This.FindAsSectionsAndAntiSections(paSections) )

			on :stzListOfLists
				return new stzListOfLists( This.FindAsSectionsAndAntiSections(paSections) )

			on :stzListOfPairs
				return new stzListOfPairs( This.FindAsSectionsAndAntiSectionss(paSections) )

			other
				StzRaise("Unsupported return type!")
			off

		#>

	def SectionsAndAntiSections(paSections)
		aAllSections = This.FindAsSectionsAndAntiSections(paSections)
		aResult = This.Sections(aAllSections)
		return aResult

		#< @FunctionFluentForm

		def SectionsAndAntiSectionsQ(paSections)
			return new stzList( This.SectionsAntiSections(paSections) )

		#>

		#< @FunctionAlternativeForm

		def AllSectionsIncluding(paSections)
			return This.SectionsAndAntiSections(paSections)

			def AllSectionsIncludingQ(paSections)
				return new stzList( This.AllSectionsIncluding(paSections) )
	
		#>

	  #-----------------------------------#
	 #    GETTING A RANGE OF THE LIST    #
	#-----------------------------------#

	def Range(pnStart, pnRange)
		return This.Section( pnStart, pnStart + pnRange - 1)

		def RangeQ(pnStart, pnRange)
			return This.RangeQR(pnStart, pnRange, :stzList)

		def RangeQR(pnStart, pnRange, pcReturntype)
			if isList(pcReturnType) and StzListQ(pcReturnType).IsOneOfTheseNamedParams([ :ReturnedAs, :ReturnAs ])
				pcReturnType = pcReturnType[2]
			ok

			switch pcReturnType

			on :stzList
				return new stzList( This.Range(pnStart, pnRange) )

			on :stzListOfStrings
				return new stzListOfStrings( This.Range(pnStart, pnRange) )

			on :stzListOfNumbers
				return new stzListOfNumbers( This.Range(pnStart, pnRange) )

			on :stzListOfLists
				return new stzListOfLists( This.Range(pnStart, pnRange) )

			on :stzListOfObjects
				return new stzListOfObjects( This.Range(pnStart, pnRange) )

			other
				StzRaise("Unsupported return type!")
			off

	  #------------------------------------#
	 #   GETTING MANY RANGES OF THE LIST  #
	#------------------------------------#

	def Ranges(paRanges)
		aResult = []

		for aRange in paRanges
			aResult + This.Range( aRange[1], aRange[2] )
		next

		return aResult

		def ManyRanges(paSections)
			return This.Ranges(paRanges)

	  #--------------------------------------------------------#
	 #   GETIING THE ANTI-RANGES OF A GIVEN SET OF SECTIONS   #
	#--------------------------------------------------------#

	def AntiRanges(paRanges)
		aSections = RangesToSections(paRanges)
		aResult = This.AntiSections(aSections)

		return aResult

		def RangesOtherThan(paRanges)
			return This.AntiRanges()

		#< @FunctionFluentForm

		def AntiRangesQ(paRanges)
			return new stzList( This.AntiRanges(paRanges) )

		#>

	def RangesAndAntiRanges(paRanges)
		aSections = SectionsToRanges(paRanges)
		aResult = This.SectionsAndAntiSections(aSections)
		
		return aResult

		#< @FunctionFluentForm

		def RangesAndAntiRangesQ(paRanges)
			return new stzList( This.RangesAndAntiRanges(paRanges) )

		#>

		#< @FunctionAlternativeForm

		def AllRangesIncluding(paRanges)
			return This.RangesAndAntiRanges(paRanges)

			def AllRangesIncludingQ(paRanges)
				return new stzList( This.AllRangesIncluding(paRanges) )
	
		#>

	  #===================#
	 #     MULTINGUAL    #
	#===================#

	def AllItemsAreLanguageAbbreviations()
		bResult = TRUE
		for item in This.List()
			if NOT StringIsLanguageAbbreviation(item)
				bResult = FALSE
				exit
			ok
		next
		return bResult

	func IsMultilingualString()
	     
		/* A multilingual string is a hashlist of the form:
			[
			:en = "house",
			:fr = "maison",
			:ar = "منزل"
		     	]

		The keys of the hashlit must be language abbreviations as
		defined by LocaleLanguageAbbreviations() in stzLocale
		*/

		# The MultilingualString must be a hashlist!
		if NOT This.IsHashlist()
			return FALSE
		ok

		# And the translations provided mus be all strings
		oHash = new stzHashList(This.List())
		aValues = oHash.Values()
		oList = new stzList(aValues)
		if NOT oList.AllItemsAreStrings()
			return FALSE
		ok

		# The keys of the hashlist are the language names or abbreviations
		# Let's check that they are well-formed
		aKeys = oHash.Keys()

		for str in aKeys
			oStr = new stzString(str)
			if NOT (oStr.IsLanguageName() or
				oStr.IsLanguageAbbreviation())
				
				return FALSE
			ok
		next
			
		# Otherwise, the list is a well-formed multilingual string
		return TRUE

	def IsLocaleList()

		if This.NumberOfItems() = 1 and isString(This[1]) and

		   Q(This[1]).IsOneOfThese([ :Default, :DefaultLocale,
				 :System, :SystemLocale, :c, "C", :CLocale
		   ])

			return TRUE
		ok

		# The list should not exceed 3 items

		if This.NumberOfItems() > 3
			return FALSE
		ok

		# It must be a hashlist

		if NOT This.IsHashList()
			return FALSE
		ok

		# The Hashlist must take the form:
		# 	[ :Language = "...", :Country = "...", ":Script = "..." ]
		# At least one item must be provided. And one, two, or three can
		# can be provided.

		oHash = new stzHashList(This.List())
		oKeys = new stzList(oHash.Keys())

		if NOT (oKeys.IsMadeOfSome([ :Language, :Script, :Country ]) ) 
				return FALSE
		ok

		cLanguage = This.List()[ :Language ]
		cScript   = This.List()[ :Script   ]
		cCountry  = This.List()[ :Country  ]

		if AllTheseAreNull([ cLanguage, cScript, cCountry ])
			return FALSE
		ok

		if NOT AllTheseAreStrings([ cLanguage, cScript, cCountry ])
			return FALSE
		ok
		
		if oKeys.Contains(:Language) and _(cLanguage).@.IsNotLanguageName()
			return FALSE
		ok

		if oKeys.Contains(:Script) and _(cScript).@.IsNotScriptName()
			return FALSE
		ok

		if oKeys.Contains(:Country) and _(cCountry).@.IsNotCountryName()
			return FALSE
		ok

		# At this level we are sure it is a language identification list
		return TRUE

	  #----------------------------------------#
	 #   DISTRIBUTING THE ITEMS OF THE LIST   #
	#----------------------------------------#

	def DistributeOverXT( acBeneficiaryItems, anShareOfEachItem )

		/* Explanation
	
		Distributes the items of the main list over the items of the
		provided list, called metaphorically 'Beneficiary Items'
		(anShareOfEachItem) here as they 'benfit' from that distribution).
		
		The distribution is defined by the share of each item.
		
		The share of each item, defined by a list of numbers (anShareOfEachItem),
		determines how many items should be given to the beneficiaries.
		
		--> The beneficiary items can be of any type. In practice, they are
		strings and hence the returned result is a hashlist as demonstrated by
		the following example:
	
		o1 = new stzList([ :water, :coca, :milk, :spice, :cofee, :tea, :honey ] )
		? o1.DistributeOverXT([ :arem, :mohsen, :hamma ], :Using = [ 2, 3, 2 ] )
	
		Gives:
	
		[
			:arem   = [ :water, :coca ],
			:mohsen = [ :milk, :spice, :cofee ],
			:hamma  = [ :tea, honey ]
		]
	
		*/

		if isList(anShareOfEachItem) and Q(anShareOfEachItem).IsUsingNamedParam()
			anShareOfEachItem = anShareOfEachItem[2]
		ok

		# The acBeneficiaryItems param should be non empty list of items:

		if NOT ( isList(acBeneficiaryItems) and  len( acBeneficiaryItems) > 0 )
			StzRaise(stzListError(:CanNoteDistributeItemsOverTheList1))
		ok

		# Controlling the validity of the syntax of anShareOfEachItem param

		if NOT ( isList(anShareOfEachItem) and
			 Q(anShareOfEachItem).IsListOfNumbers() and
			 len(anShareOfEachItem) > 0 )
			 StzRaise("Incorrect param! anShareOfEachItem must be a non empty list of numbers.")
		ok

		# The sum of numbers in anShareOfEachItem should be equal to the
		# number of items of the main list

		if NOT Sum(anShareOfEachItem) = This.NumberOfItems()
			StzRaise(stzListError(:CanNoteDistributeItemsOverTheList2))
		ok

		# Now, we can perform the distribution

		aResult = []
		i = 0
		n = 1
		for cBenef in acBeneficiaryItems
			i++
			aResult + [ cBenef, This.Range(n, anShareOfEachItem[i]) ]
			n += anShareOfEachItem[i]
		next

		return aResult
	
	def DistributeOver( acBeneficiaryItems )
		nLenList = This.NumberOfItems()
		nLenBenef = len(acBeneficiaryItems)

		anShare = []

		if nLenBenef >= nLenList
			for i = 1 to nLenList
				anShare + 1
			next

		else
			n = floor( nLenList / nLenBenef )

			for i = 1 to nLenBenef	
				anShare + n
			next

			nRest = nLenList - ( n * nLenBenef )

			if nRest > 0
				for i = 1 to nRest
					anShare[i]++
				next
			ok
			
		ok

		aResult = This.DistributeOverXT( acBeneficiaryItems, :Using = anShare)
		return aResult

	  #=======================#
	 #     GETTING TYPES     #
	#=======================#

	# Deeling wuth the list itself

	def IsStzList()
		return TRUE

	def stzType()
		return :stzList

	# Deeling with the items of the list

	def Types()
		aResult = []
		for item in This.List()
			aResult + Q(item).Type()
		next
		return aResult

	def TypesXT()
		aResult = This.ListQ().AssociatedWith( This.Types() )
		return aResult

	def UniqueTypes()
		aResult = []
		for item in This.List()
			if NOT StzListQ(aResult).Contains( ring_type(item) )
				aResult + ring_type(item)
			ok
		next
		return aResult

	  #-------------------------------------------------------------#
	 #  CHECKING IF THE LIST STARTS WITH A GIVEN SUBLIST OF ITEMS  #
	#-------------------------------------------------------------#

	def StartsWithCS(paItems, pCaseSensitive)
		if len(paItems) > This.NumberOfItems()
			return FALSE
		ok

		if This.IsStrictlyEqualToCS(paItems, pCaseSensitive)
			return TRUE
		ok

		bResult = TRUE
		nLen = len(paItems)

		for i = 1 to nLen
			if Q(This[i]).IsNotEqualToCS(paItems[i], pCaseSensitive)
				bResult = FALSE
				exit
			ok
		next

		return bResult

		def BeginsWithCS(paItems, pCaseSensitive)
			return This.StartsWithCS(paItems, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def StartsWith(paItems)
		return This.StartsWithCS(paItems, oCaseSensitive)

		def BeginsWith(paItems)
			return This.StartsWith()

	  #-----------------------------------------------------------#
	 #  CHECKING IF THE LIST ENDS WITH A GIVEN SUBLIST OF ITEMS  #
	#-----------------------------------------------------------#

	def EndsWithCS(paItems, pCaseSensitive)
		if len(paItems) > This.NumberOfItems()
			return FALSE
		ok

		if This.IsStrictlyEqualToCS(paItems, pCaseSensitive)
			return TRUE
		ok

		bResult = TRUE

		aLastItems = This.NLastItems( len(paItems) )
		nLen = len(aLastItems)

		for i = 1 to nLen

			if Q(This[i]).IsNotEqualToCS(aListItems[i], pCaseSensitive)
				bResult = FALSE
				exit
			ok
		next

		return bResult

		def FinishesWithCS(paItems, pCaseSensitive)
			return This.EndsWithCS(paItems, pCaseSensitive)

	#-- WITHOUT CASESENSITIVITY

	def EndsWith(paItems)
		if len(paItems) > This.NumberOfItems()
			return FALSE
		ok

		if This.IsStrictlyEqualTo(paItems)
			return TRUE
		ok

		bResult = TRUE

		i = 0
		for item in This.NLastItems( len(paItems) )
			i++
			if Q(This[i]).IsNotEqualTo(item)
				bResult = FALSE
				exit
			ok
		next

		return bResult

		def FinishesWith(paItems)
			return This.EndsWith(paItems)

	  #==========================================#
	 #  SMALLEST AND LARGEST ITEMS IN THE LIST  #
	#==========================================#

	def SmallestItem()

		if This.NumberOfItems() > 1
			aSorted = This.SortedInAscending()
			return aSorted[1]

		ok

		def Smallest()
			return This.SmallestItem()

	def LargestItem()
		if This.NumberOfItems() > 1
			aSorted = This.SortedInDescending()
			return aSorted[1]
		ok

		def Largest()
			return This.LargestItem()

		def GreatestItem()
			return This.LargestItem()

		def Greatest()
			return This.LargestItem()

	  #--------------------------------------------------#
	 #  FINDING SMALLEST AND LARGEST ITEMS IN THE LIST  #
	#--------------------------------------------------#

	def FindSmallestItem()
		return This.FindAll( This.SmallestItem() )

		def FindSmallest()
			return This.FindSmallestItem()

		def FindAllOccurrencesOfSmallestItem()
			return This.FindSmallestItem()

		def FindAllOccurrencesOfSmallest()
			return This.FindSmallestItem()

	def FindLargestItem()
		return This.FindAll( This.LargestItem() )

		def FindLargest()
			return This.FindLargestItem()

		def FindAllOccurrencesOfLargestItem()
			return This.FindLargestItem()

		def FindAllOccurrencesOfLargest()
			return This.FindLargestItem()

	  #-------------------------------------------------------------------#
	 #  NUMBER OF OCCURRENCES OF SMALLEST AND LARGEST ITEMS IN THE LIST  #
	#-------------------------------------------------------------------#

	def NumberOfOccurrencesOfSmallestItem()
		return len( This.FindAllOccurrencesOfSmallestItem() )

		def NumberOfOccurrenceOfSmallestItem()
			return This.NumberOfOccurrencesOfSmallestItem()

		def NumberOfOccurrencesOfSmallest()
			return This.NumberOfOccurrencesOfSmallestItem()

		def NumberOfOccurrenceOfSmallest()
			return This.NumberOfOccurrencesOfSmallestItem()

		def NumberOfSmallest()
			return This.NumberOfOccurrencesOfSmallestItem()

		def CoutOccurrencesOfSmallestItem()
			return This.NumberOfOccurrencesOfSmallestItem()

		def HowManyOccurrencesOfSmallestItem()
			return This.NumberOfOccurrencesOfSmallestItem()

	def NumberOfOccurrencesOfLargestItem()
		return len( This.FindAllOccurrencesOfLargestItem() )

		def NumberOfOccurrenceOfLargestItem()
			return This.NumberOfOccurrencesOfLargestItem()

		def NumberOfOccurrencesOfLargest()
			return This.NumberOfOccurrencesOfLargestItem()

		def NumberOfOccurrenceOfLargest()
			return This.NumberOfOccurrencesOfLargestItem()

		def NumberOfLargest()
			return This.NumberOfOccurrencesOfLargestItem()

		def CoutOccurrencesOfLargestItem()
			return This.NumberOfOccurrencesOfLargestItem()

		def HowManyOccurrencesOfLargestItem()
			return This.NumberOfOccurrencesOfLargestItem()

	  #--------------------------------------------------------------------#
	 #  FINDING NTH OCCURRENCE OF SMALLEST AND LARGEST ITEMS IN THE LIST  #
	#--------------------------------------------------------------------#

	def FindNthOccurrenceOfSmallestItem(n)
		if isString(n)
			if Q(n).IsEither(:First, :Or = :FirstItem)
				n = 1
			but Q(n).IsEither(:Last, :Or = :LastItem)
				n = This.NumberOfOccurrencesOfSmallestItem()
			ok
		ok

		return This.FindAll( This.SmallestItem() )[n]

		def FindNthOccurrenceOfSmallest(n)
			return This.FindNthSmallestItem(n)

	def FindNthOccurrenceOfLargestItem(n)
		if isString(n)
			if Q(n).IsEither(:First, :Or = :FirstItem)
				n = 1
			but Q(n).IsEither(:Last, :Or = :LastItem)
				n = This.NumberOfOccurrencesOfLargestItem()
			ok
		ok

		return This.FindAll( This.LargestItem() )[n]

		def FindNthOccurrenceOfLargest(n)
			return This.FindNthLargestItem(n)

		def FindNthOccurrenceOfGreatestItem(n)
			return This.FindNthLargestItem(n)

		def FindNthOccurrenceOfGreatest(n)
			return This.FindNthLargestItem(n)

	  #======================================================#
	 #  GETTING NTH SMALLEST AND LARGEST ITEMS IN THE LIST  #
	#======================================================#

	def NthSmallestItem(n)
		return This.Copy().RemoveDuplicatesQ().SortedInAscending()[n]

		def NthSmallest(n)
			return This.NthSmallestItem(n)

	def NthLargestItem(n)
		return This.Copy().RemoveDuplicatesQ().SortedInDescending()[n]

		def NthLargest(n)
			return This.NthLargestItem(n)

		def NthGreatestItem(n)
			return This.NthLargestItem(n)

		def NthGreatest(n)
			return This.NthLargestItem(n)

	  #------------------------------------------------------#
	 #  FINDING NTH SMALLEST AND LARGEST ITEMS IN THE LIST  #
	#------------------------------------------------------#

	def FindNthSmallestItem(n)
		return This.FindAll( This.NthSmallestItem(n) )

		def FindNthSmallest(n)
			return This.FindNthSmallestItem(n)

	def FindNthLargestItem(n)
		return This.FindAll( This.NthLargestItem(n) )

		def FindNthLargest(n)
			return This.FindNthLargestItem(n)

		def FindNthGreatestItem(n)
			return This.FindNthLargestItem(n)

		def FindNthGreatest(n)
			return This.FindNthLargestItem(n)

	  #-----------------------------------------------------------#
	 #  CHECKING IF THE LIST CONTAINS JUST STRINGS IN UPPERCASE  #
	#-----------------------------------------------------------#

	def IsUppercase()
		if This.IsListOfStrings() and
		   LSQ( This.String() ).IsUppercase()
		   # LSQ() --> abbreviation of StzListOfStringsQ()

			return TRUE

		else
			return FALSE
		ok

		def IsAnUppecase()
			return This.IsUppercase()

		def IsUppercased()
			return This.IsUppercase()

	  #------------------------------------------------------------#
	 #  TRANSFORMING THE LIST TO ITS REPRESENTATION IN RING CODE  #
	#------------------------------------------------------------#

	def ToCode()
		# NOTE: uses the same code as list2code() from Ring standard
		# library and enhances it for better performance

		# TODO: This code uses windowsnl() --> check if that works
		# on other operating systems as well

		# TODO: Ask Mahmoud: Is WindowsNL() multiplatform?

		cTabs = ring_copy( char(9), List2CodeTabsCounter )
		cCode = cTabs + "[" + Windowsnl()

		lStart = True
		List2CodeTabsCounter++

		cTabs = ring_copy( char(9), List2CodeTabsCounter )
	
		aList = This.List()
		nLen = This.NumberOfItems()

		for i = 1 to nLen
			item = aList[i]

			if !lStart 
				cCode += ( "," + Windowsnl() )
			else 
				lStart = False
			ok

			if isString(item)
				item2 = substr( item, '"','"+ char(34)+"')
				cCode += ( cTabs +'"' + item2 + '"'  )

			but isnumber(item)
				cCode += ( cTabs + "" + item )

			but islist(item)
				cCode += Q(item).ToCode() # Not this is a recursive call
			ok
		next

		List2CodeTabsCounter--
		cTabs = ring_copy(char(9), List2CodeTabsCounter)
		cCode += ( windowsnl() + cTabs + "]" )
		return cCode

		def ToCodeQ()
			return new stzString(This.ToCode())

	def ToCodeSimplified()
		return This.ToCodeQ().Simplified()

		return This.ToCodeSimplifiedQ()
			return new stzString( This.ToCodeSimplified() )

		def ToCodeSF()
			return This.ToCodeSimplified()

			def ToCodeSFQ()
				return This.ToCodeSimplified()

	  #--------------------------------------------------------------#
	 #  STRINGIFYING THE LIST (ALL ITEMS ARE FORCED TO BE STRINGS)  #
	#--------------------------------------------------------------#
	# TODO: Abstract this function in stzObject

	def Stringify()
		acResult = []
		nLen = This.NumberOfItems()
		cItem = ""

		for i = 1 to nLen
			item = This.Item(i)
			cType = ring_type(item)
			switch cType
			on "NUMBER"
				cItem = ""+ item

			on "STRING"
				cItem = item

			on "LIST"
				cItem = Q(item).ToCodeQ().Simplified()

			off

			acResult + cItem
		next

		This.Update( acResult )

		#< @FunctionFluentForm

		def StringifyQ()
			This.Stringify()
			return This

		def StringifyQR(pcReturnType)
			switch pcReturnType
			on :stzListOfStrings
				return new stzListOfstrings( This.Stringified() )
			other
				StzRaise("Unsupported return type!")
			off

		#>

	def Stringified()
		acResult = This.Copy().StringifyQ().Content()
		return acResult

	  #--------------------------------------------------#
	 #  TRANSFORMING THE ITEMS OF THE LIST TO A STRING  #
	#--------------------------------------------------#

	def ToString()
		return This.ToStringXT(:ConcatenatedUsing = NL)

		def ToStringQ()
			return new stzString( This.ToString() )

	def ToStringXT(pOption)
		if isString(pOption)
			if pOption = :AsCode
				return This.ToCode()

			but pOption = :Concatenated
				return This.StringifyQR(:stzListOfStrings).Concatenated()
			ok

		but isList(pOption) and
		    Q(pOption).IsOneOfTheseNamedParams([
			:Concatenated, :ConcatenatedUsing, :ConcatenatedWith ])

			if isList(pOption[2]) and
			   Q(pOption[2]).IsOneOfTheseNamedParams([ :Using, :With ])

				pOption[2] = pOption[2][2]
			ok

			return This.StringifyQR(:stzListOfStrings).ConcatenatedUsing(pOption[2])
		ok

		StzRaise("Unsupprorted syntax!")
			
		def ToStringXTQ(pOption)
			return new stzString( This.ToStringXT(pOption) )

	
	   #---------------------------------------------#
	  #  CHECKS IF THE LIST CONTAINS AT LEAST ONE   #
	 #  ITEM IN THE FORM OF A CONDITIONAL CODE     #
	#---------------------------------------------#

	def ContainsCCode()
		bResult = FALSE

		aTempList = This.List()
		nLen = len(aTempList)

		
		for i = 1 to nLen
			item = aTempList[i]

			if isList(item) and Q(item).IsWhereNamedParam()
				item = item[2]
			ok

			if isString(item) and
			   Q(item).TrimQ().IsBoundedBy(["{","}"])
				bResult = TRUE
				exit
			ok
		next

		return bResult

		def ContainsConditionalCode()
			return This.ContainsCCode()

	  #----------------------------------------#
	 #      CHECKING IF ALL ITEMS ARE ...     #
	#----------------------------------------#

	def AllItemsAre(p)
		/* EXAMPLE

		? Q([ "ONE", "ONE", "ONE" ]).AllItemsAre("ONE")
		#--> TRUE

		
		? Q([ "ONE", "TWO", "THREE" ]).AllItemsAre([ :Strings ])
		#--> TRUE
		
		? Q([ "ONE", "TWO", "THREE" ]).AllItemsAre([ :Uppercase, :Strings ])
		#--> TRUE
		
		? Q([ "ONE", "TWO", "THREE" ]).AllItemsAre([ :Uppercase, W('len(@item)=3'), :Strings ])
		
		*/

		# Q([ "ONE", "ONE", "ONE" ]).AllItemsHave('len(@item) = 3')

		nLen = This.NumberOfItems()

		if isList(p) and Q(p).IsWhereNamedParam()

			p = p[2]
		ok

		if isString(p) and Q(p).TrimQ().IsBoundedBy([ "{", "}" ])

			cCode = 'bOk = (' + Q(p).BoundsRemoved([ "{", "}" ]) + ')'

			bResult = TRUE
			for @i = 1 to nLen
				@item = This.Item(@i)
				eval(cCode)
				if NOT bOk
					bResult = FALSE
					exit
				ok
			next

			return bResult
			
		# ? Q([ "ONE", "TWO", "THREE" ]).AllItemsAre(:Strings)
		but isString(p) and
		    ( Q("stz" + p).IsStzClassName() or
		    Q("stz" + p).IsPluralOfStzClassName() )

			cMethod = ""

			if p = :Number or p = :Numbers
				cMethod = :IsANumber

			but p = :String or p = :Strings
				cMethod = :IsAString

			but p = :List or p = :Lists
				cMethod = :IsAList

			but p = :Object or p = :Objects
				cMethod = :IsAnObject
			
			else
				if Q('stz' + p).IsPluralOfAStzClass()
					p = PluralToStzClass('stz' + p)
				ok

				cMethod = 'Is' + Q(p).RemovedFromLeft("stz")

			ok

			# We could use this one line:
			# bResult = This.Check(:That = 'Q(@item).' + cMethod + '()')

			# But it should better for performance to make it manually

			cCode = 'bOk = ( Q(@item).' + cMethod + '() )'

			bResult = TRUE
			for @i = 1 to nLen
				@item = This.Item(@i)
				eval(cCode)
				if NOT bOk
					bResult = FALSE
					exit
				ok
			next

			return bResult

		# Q([ "ONE", "TWO", "THREE" ]).AllItemsAre([ :Uppercase, :Strings ])
		but isList(p) and Q(p).IsListOfStrings() and
		    Q("stz" + p[len(p)]).IsStzClassNameXT() # ..XT() --> in singular or plural form

			return This.AllItemsAreXT(p, :Default)

		but isList(p) and Q(p).ContainsCCode()

			return This.AllItemsAreXT(p, :Default)

		# ? Q([ "♥", "♥", "♥" ]).AllItemsAre("♥")
		else

			bResult = TRUE
			aItems = This.Content()
			nLen = len(aItems)

			for i = 1 to nLen
				if NOT Q(aItems[i]).IsEqualTo(p)
					bResult = FALSE
					exit
				ok
			next

			return bResult

		ok

		#< @FunctionAlternativeForms

		def ItemsAre(p)
			return This.AllItemsAre(p)

		def EachItemIs(p)
			return This.AllItemsAre(p)

		def EachItemIsA(p)
			return This.AllItemsAre(p)

		def EachItemIsAn(p)
			return This.AllItemsAre(p)

		def ItemsHave(p)
			return This.AllItemsAre(p)

		def AllItemsHave(p)
			return This.AllItemsAre(p)

		#>

	def AllItemsAreXT(p, paEvalDirection)

		if NOT isList(p)
			StzRaise("Incorrect param type! p must be a list.")
		ok

		if len(p) = 0
			return FALSE
		ok

		if isList(paEvalDirection) and
		   Q(paEvalDirection).IsOneOfTheseNamedParams([
			:Eval, :Evaluate,
			:EvalFrom, :EvaluateFrom,
			:EvalDirection, :EvaluationDirection
		   ])

			paEvalDirection = paEvalDirection[2]
		ok

		if NOT Q(paEvalDirection).IsOneOfTheseCS([
			:Default, :Nothing,
			:LeftToRight, :RightToLeft,
			:Left2Right, :Right2Left,
			:FromLeftToRight, :FromRightToLeft,
			:FromLeft2Right, :FromRight2Left,
			:LTR, :RTL, :L2R, :R2L,
			:FromLTR, :FromRTL, :FromL2R, :FromR2L
			], :CS = FALSE)

			StzRaise("Incorrect param value for paEvalDirection! Allowed values are :RightToLeft and :LeftToRight.")
		ok

		if Q(paEvalDirection).IsEither(:Default, :Or = :Nothing)
			paEvalDirection = :RightToLeft
		ok

		# Doing the job

		if Q(paEvalDirection).IsOneOfTheseCS([
			:RightToLeft,
			:Right2Left,
			:FromRightToLeft,
			:FromRight2Left,
			:RTL, :R2L,
			:FromRTL, :FromR2L
			], :CS = FALSE)

			p = Q(p).Reversed()
		ok

		if len(p) = 1 and isString(p[1])
			return This.AllItemsAre(p[1])

		but Q(p).IsWhereNamedParam()
			return This.AllItemsAre(p[1])

		else
			nLenMethods = len(p)
			for i = 2 to nLenMethods
				if isList(p[i]) and Q(p[i]).IsWhereNamedParam()
					p[i] = p[i][2]
				ok
			next

			cMainClass = 'stz' + Q(p[1]).InfereStzClass()
			cCode = 'oObj = new ' + cMainClass + '(@item)'

			bResult = TRUE
			nLenList = This.NumberOfItems()

			for i = 1 to nLenList
				@item = This.Item(i)
		
				for j = 2 to nLenMethods

					if Q(p[j]).TrimQ().IsBoundedBy(["{","}"])
						cCode = 'bOk = (' + Q(p[j]).TrimQ().BoundsRemoved(["{","}"]) + ')'
					else
						cCode = 'bOk = Q(@item).Is' + p[j] + '()'
					ok

					eval(cCode)
					if NOT bOk
						bResult = FALSE
						exit 2
					ok
				next j
			next i

			return bResult
		ok

		def ItemsAreXT(pacDescriptors, paEvalDirection)
			return This.AllItemsAreXT(pacDescriptors, paEvalDirection)

		def EachItemIsXT(pDescriptor, paEvalDirection)
			return This.AllItemsAreXT(pDescriptor, paEvalDirection)

	  #--------------------------------#
	 #    USUED FOR NATURAL-CODING    #
	#--------------------------------#

	def IsAString()
		return FALSE

		def IsNotAString()
			return TRUE

	def IsAList()
		return TRUE

		def IsNotAList()
			return FALSE

	def IsAnObject()
		return TRUE

		def IsNotAnObject()
			return FALSE

	#--- ITEM

	def IsItem()
		return TRUE

		def IsAnItem()
			return This.IsItem()

	def IsItemOf(paList)
		return StzListQ(paList).Contains(This.Content())
	
		def AsAnItemOf(paList)
			return This.IsItemOf(paList)
	
	def IsItemIn(paList)
		return This.IsItemOf(paList)
	
		def IsAnItemIn(paList)
			return This.IsItemOf(paList)

	#--

	def IsMember()
		return TRUE

		def IsAMember()
			return This.IsMember()

	def IsMemberOf(paList)
		return StzListQ(paList).Contains(This.Content())
	
		def AsAMemberOf(paList)
			return This.IsMemberOf(paList)
	
	def IsMemberIn(paList)
		return This.IsMemberOf(paList)
	
		def IsAMemberIn(paList)
			return This.IsMemberOf(paList)


	#--- NUMBER

	def IsANumber()
		return FALSE

		def IsNotANumber()
			return TRUE

	def IsNumberOf(paList)
		return FALSE

		def IsANumberOf(paList)
			return FALSE
	
	def IsNumberIn(paList)
		return FALSE
	
		def IsANumberIn(paList)
			return FALSE

	#--- ITEM

	def IsLetter()
		return FALSE

		def IsALetter()
			return FALSE
	
	def IsLetterOf(pStrOrListOfChars)
		return FALSE

		def IsALetterOf(pcStr)
			return FALSE
	
	def IsLetterIn(pcStr)
		return FALSE

		def IsALetterIn(pcStr)
			FALSE

	def IsCharOf(pStrOrListOfChars)
		return FALSE

		def IsACharOf(pcStr)
			return FALSE

	def IsCharIn(pcStr)
		return FALSE

		def IsACharIn(pcStr)
			return FALSE

	def Methods()
		return ring_methods(This)

	def Attributes()
		return ring_attributes(This)

	def ClassName()
		return "stzlist"

		def StzClassName()
			return This.ClassName()

		def StzClass()
			return This.ClassName()

	  #===========================================#
	 #   CHECKING IF THE LIST IS A NAMED PARAM   #
	#===========================================#
	# TODO: Add @ to all params, like this:
	# (This[1] = :ParamName or This[1] = :ParamName@ ) )

	def IsOnPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :OnPosition)

			return TRUE
		else
			return FALSE
		ok

	def IsOnPositionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :OnPositions)

			return TRUE
		else
			return FALSE
		ok

	def IsOnSectionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :OnSection)

			return TRUE
		else
			return FALSE
		ok

	def IsOnSectionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :OnSections)

			return TRUE
		else
			return FALSE
		ok

	def IsHarvestNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :Harvest)

			return TRUE
		else
			return FALSE
		ok

	def IsAndHarvestNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :AndHarvest)

			return TRUE
		else
			return FALSE
		ok

	def IsAndThenHarvestNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :AndThenHarvest)

			return TRUE
		else
			return FALSE
		ok

	def IsThenHarvestNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :ThenHarvest)

			return TRUE
		else
			return FALSE
		ok

	def IsYieldNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :Yield)

			return TRUE
		else
			return FALSE
		ok

	def IsAndYieldNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :AndYield)

			return TRUE
		else
			return FALSE
		ok

	def IsAndThenYieldNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :AndThenYield)

			return TRUE
		else
			return FALSE
		ok

	def IsThenYieldNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :ThenYield)

			return TRUE
		else
			return FALSE
		ok

	#--

	def IsHarvestSectionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :HarvestSection)

			return TRUE
		else
			return FALSE
		ok

	def IsAndHarvestSectionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :AndHarvestSection)

			return TRUE
		else
			return FALSE
		ok

	def IsAndThenHarvestSectionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :AndThenHarvestSection)

			return TRUE
		else
			return FALSE
		ok

	def IsThenHarvestSectionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :ThenHarvestSection)

			return TRUE
		else
			return FALSE
		ok

	def IsYieldSectionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :YieldSection)

			return TRUE
		else
			return FALSE
		ok

	def IsAndYieldSectionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :AndYieldSection)

			return TRUE
		else
			return FALSE
		ok

	def IsAndThenYieldSectionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :AndThenYieldSection)

			return TRUE
		else
			return FALSE
		ok

	def IsThenYieldSectionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :ThenYieldSection)

			return TRUE
		else
			return FALSE
		ok

	#--

	def IsHarvestSectionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :HarvestSections)

			return TRUE
		else
			return FALSE
		ok

	def IsAndHarvestSectionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :AndHarvestSections)

			return TRUE
		else
			return FALSE
		ok

	def IsAndThenHarvestSectionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :AndThenHarvestSections)

			return TRUE
		else
			return FALSE
		ok

	def IsThenHarvestSectionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :ThenHarvestSections)

			return TRUE
		else
			return FALSE
		ok

	def IsYieldSectionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :YieldSections)

			return TRUE
		else
			return FALSE
		ok

	def IsAndYieldSectionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :AndYieldSections)

			return TRUE
		else
			return FALSE
		ok

	def IsAndThenYieldSectionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :AndThenYieldSections)

			return TRUE
		else
			return FALSE
		ok

	def IsThenYieldSectionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :ThenYieldSections)

			return TRUE
		else
			return FALSE
		ok
	#--

	def IsNCharsBeforeNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :NCharsBefore)

			return TRUE
		else
			return FALSE
		ok

	def IsNCharsAfterNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :NCharsAfter)

			return TRUE
		else
			return FALSE
		ok

	def IsOneOfTheseNamedParams(pacParamNames)
		bResult = FALSE

		for cParamName in pacParamNames
			cCode = 'bFound = This.Is' + cParamName + 'NamedParam()'
			eval(cCode)
			if bFound
				bResult = TRUE
				exit
			ok
		next

		return bResult

	def IsRemoveAtOptionsNamedParam()
		bResult = FALSE

		if This.IsHashList() and

		   This.ToStzHashList().KeysQ().IsMadeOfSome([
			:RemoveNCharsBefore, :RemoveNCharsAfter,
			:RemoveThisSubStringBefore,:RemoveThisSubStringAfter,
			:RemoveThisCharBefore,:RemoveThisCharBefore,
			:RemoveThisBound, :RemoveThisBoundingSubString,
			:CaseSensitive, :CS ])
			# NOTE: I've decided to keep CS as a suffix in the function
			# name and never use it as an internal option...
			# --> more simple mental model to keep things memprable

			if This.ToStzHashList().
				KeysQR(:stzListOfStrings).
				ContainsBothCS(:CaseSensitive, :CS, :CS = FALSE)

				StzRaise("Incorrect format! :CaseSensitive and :CS can not be used both in the same time")
			ok

			if This.ToStzHashList().
				KeysQR(:stzListOfStrings).
				ContainsBothCS(:RemoveThisBound, :RemoveThisBoundingSubString, :CS = FALSE)

				StzRaise("Incorrect format! :RemoveThisBound and :RemoveThisBoundingSubString can not be used both in the same time")
			ok

			bOk1 = FALSE
			nRemoveNCharsBefore = This.Content()[ :RemoveNCharsBefore ]
			cType = ring_type(nRemoveNCharsBefore)
		   	if cType = "NUMBER" or ( cType = "STRING" and nRemoveNCharsBefore = NULL )
				bOk1 = TRUE
			ok

			bOk2 = FALSE
			nRemoveNCharsAfter = This.Content()[ :RemoveNCharsAfter ]
			cType = ring_type(nRemoveNCharsAfter)
		   	if cType = "NUMBER" or ( cType = "STRING" and nRemoveNCharsAfter = NULL )
				bOk2 = TRUE
			ok

			bOk3 = FALSE
			cRemoveSubStringBefore = This.Content()[ :RemoveSubStringBefore ]
			cType = ring_type(cRemoveSubStringBefore)
		   	if cType = "STRING"
				bOk3 = TRUE
			ok

			bOk4 = FALSE
			cRemoveSubStringAfter = This.Content()[ :RemoveSubStringAfter ]
			cType = ring_type(cRemoveSubStringAfter)
		   	if cType = "STRING"
				bOk4 = TRUE
			ok

			bOk5 = FALSE
			cRemoveThisBound = This.Content()[ :cRemoveThisBound ]
			cType = ring_type(cRemoveThisBound)
		   	if cType = "STRING"
				bOk5 = TRUE
			ok

			if bOk1 and bOk2 and bOk3 and bOk4 and bOk5
				bResult = TRUE
			ok
		ok

		return bResult

	def IsTextBoxedOptionsNamedParam()
		/*
		Example:

		? StzStringQ("TEXT1").BoxedXT([
			:Line = :Thin,	# or :Dashed
		
			:AllCorners = :Round # can also be :Rectangualr
			# :Corners = [ :Round, :Rectangular, :Round, :Rectangular ],
		
			:Width = 17,
			:TextAdjustedTo = :Center # or :Left or :Right or :Justified,
			
			:EachChar = FALSE # TRUE,
			:Hilighted = [ 1, 3 ] # Hilight the 1st and 3rd chars,

			:Numbered = TRUE
		])
		*/
		if This.IsEmpty()
			return TRUE
		ok

		aListOfBoxOptions = [
			:Line,
			:AllCorners,
			:Corners,
			:Width,
			:TextAdjustedTo,
			:EachChar,
			:EachWord,
			:Hilighted,
			:HilightedIf,
			:Numbered
		]

		if StzNumberQ(This.NumberOfItems()).IsBetween(1, len(aListOfBoxOptions)) and
		   This.IsHashList() and
		   StzHashListQ(This.Content()).KeysQ().IsMadeOfSome(aListOfBoxOptions)
		
			return TRUE

		else
			return FALSE
		ok

	def IsBoxOptionsNamedParam()

		if This.IsEmpty()
			return TRUE
		ok

		aListOfBoxOptions = [
			:Line,
			:AllCorners,
			:Corners,
			:Width,
			:TextAdjustedTo,
			:EachChar,

			:Casesensitive,
			:CS,

			:Numbered,
			:Spacified,

			:Shadowed,
			:ShadowChar,
			:ShadowOrientation
			
		]

		if StzNumberQ(This.NumberOfItems()).IsBetween(1, len(aListOfBoxOptions)) and
		   This.IsHashList() and
		   StzHashListQ(This.Content()).KeysQ().IsMadeOfSome(aListOfBoxOptions)
		
			return TRUE

		else
			return FALSE
		ok

	def IsConstraintsOptionsNamedParam()
		/* EXAMPLE
		[
			:OnStzString = [
				:MustBeUppercase 	= '{ Q(@str).IsUppercase() }',
				:MustNotExceed@n@Chars 	= '{ Q(@str).NumberOfChars() <= n }',
				:MustBeginWithLetter@c@	= '{ Q(@str).BeginsWithCS(c, :CS = FALSE) }'
			],
		
			:OnStzNumber = [
				:MustBeStrictlyPositive = '{ @number > 0 }'
			],
		
			:OnStzList = [
				:MustBeAHashList = '{ Q(@list).IsHashList() }'
			]
		]
		*/
		
		try
			VerifyConstraints([
				:MustBeAHashList,
				:KeysMustBeOnStzTypes,
				:ValuesMustBeRingCodeInStrings
			])

			return TRUE

		catch
			return FALSE
		done

	#--

	def IsCellNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :Cell)

			return TRUE
		else
			return FALSE
		ok

	def IsOfCellNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :OfCell)

			return TRUE
		else
			return FALSE
		ok

	def IsCellsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :Cells)

			return TRUE
		else
			return FALSE
		ok

	def IsOfCellsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :OfCells)

			return TRUE
		else
			return FALSE
		ok

	#--

	def IsSubValueNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :SubValue)

			return TRUE
		else
			return FALSE
		ok

	def IsOfSubValueNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :OfSubValue)

			return TRUE
		else
			return FALSE
		ok

	def IsSubValuesNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :SubValues)

			return TRUE
		else
			return FALSE
		ok

	def IsOfSubValuesNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :OfSubValues)

			return TRUE
		else
			return FALSE
		ok

	#--

	def IsColNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and (This[1] = :Col or This[1] = :Column) )

			return TRUE
		else
			return FALSE
		ok

		def IsColumnNamedParam()
			return This.IsColNamedParam()

	def IsOfColNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and (This[1] = :OfCol or This[1] = :OfColumn) )

			return TRUE
		else
			return FALSE
		ok

		def IsOfColumnNamedParam()
			return This.IsOfColNamedParam()

	def IsInColNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and (This[1] = :InCol or This[1] = :InColumn) )

			return TRUE
		else
			return FALSE
		ok

		def IsInColumnNamedParam()
			return This.IsInColNamedParam()

	def IsColsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and (This[1] = :Cols or This[1] = :Columns) )

			return TRUE
		else
			return FALSE
		ok

		def IsColumnsNamedParam()
			return This.IsColsNamedParam()

	def IsOfColsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and (This[1] = :OfCols or This[1] = :OfColumns) )

			return TRUE
		else
			return FALSE
		ok

		def IsOfColumnsNamedParam()
			return This.IsOfColsNamedParam()

	def IsInColsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and (This[1] = :InCols or This[1] = :InColumns) )

			return TRUE
		else
			return FALSE
		ok

		def IsInColumnsNamedParam()
			return This.IsInColsNamedParam()

	#--

	def IsRowNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :Row)

			return TRUE
		else
			return FALSE
		ok

	def IsOfRowNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :OfRow)

			return TRUE
		else
			return FALSE
		ok

	def IsInRowNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :InRow)

			return TRUE
		else
			return FALSE
		ok

	def IsRowsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :Rows)

			return TRUE
		else
			return FALSE
		ok

	def IsOfRowsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :OfRows)

			return TRUE
		else
			return FALSE
		ok

	def IsInRowsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :InRows)

			return TRUE
		else
			return FALSE
		ok

	#--

	def IsOccurrenceNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :Occurrence)

			return TRUE
		else
			return FALSE
		ok

	def IsNthNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :Nth)

			return TRUE
		else
			return FALSE
		ok

	def IsNthOccurrenceNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :NthOccurrence)

			return TRUE
		else
			return FALSE
		ok

	def IsNNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :N)

			return TRUE
		else
			return FALSE
		ok
	#--

	def IsCaseSensitiveNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and (This[1] = :Casesensitive or This[1] = :CS) ) and
		   IsBoolean(This[2])

			return TRUE
		else
			return FALSE
		ok

	def IsRangeNamedParam()

		if This.IsEmpty()
			return TRUE
		ok

		if NOT (This.IsHashList() and This.NumberOfItems() <= 2)
			return FALSE
		ok

		if This.NumberOfItems() = 1

			if This[1][1] = :Start or This[1][1] = :Range
				return TRUE
			ok
		ok

		if This.NumberOfItems() = 2

			if StzHashListQ( This.List() ).KeysQ().IsEqualTo([ :Start, :Range ]) and
			   StzHashListQ( This.List() ).ValuesQ().BothAreNumbers()

				return TRUE

			else

				return FALSE
			ok
		ok


	def IsStartingAtNamedParam()
		if This.NumberOfItems() = 2 and

		   ( isString(This[1]) and Q(This[1]).IsOneOfThese([
					:StartingAt, :StartingAtPosition,
					:StartingAtOccurrence ]) )

			return TRUE

		else
			return FALSE
		ok

	def IsInStringNNamedParam()
		if This.NumberOfItems() = 2 and

		   ( isString(This[1]) and Q(This[1]).IsOneOfThese([
					:InStringAt, :InStringItemAt,
					:inStringAtPosition, :InStringItemAtPosition,
					:InStringN, :InStringItemN ]) )

			return TRUE

		else
			return FALSE
		ok

		def IsInStringItemNNamedParam()
			return This.IsInStringNNamedParam()

		def IsInStringAtPositionNNamedParam()
			return This.IsInStringNNamedParam()

		def IsInStringAtPositionNamedParam()
			return This.IsInStringNNamedParam()

	def IsExceptNamedParam()
		# Used initially by ReplaceWordsWithMarquersExceptXT(pcByOption, paExcept)
		# TODO: generalize to all the functions we want to provide exceptions to it

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :Except )

			return TRUE

		else
			return FALSE
		ok

	def IsAsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :As )

			return TRUE

		else
			return FALSE
		ok

	def IsThenNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  (This[1] = :Then or This[1] = :Then@) )

			return TRUE

		else
			return FALSE
		ok

	def IsAndThenNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  (This[1] = :AndThen or This[1] = :AndThen@) )

			return TRUE

		else
			return FALSE
		ok

	def IsFromNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  (This[1] = :From or This[1] = :FromPosition)  )

			return TRUE

		else
			return FALSE
		ok

	def IsValueNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Value )

			return TRUE

		else
			return FALSE
		ok

	def IsOfValueNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :OfValue )

			return TRUE

		else
			return FALSE
		ok

	def IsValuesNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Values )

			return TRUE

		else
			return FALSE
		ok

	def IsStringOrSubStringNamedParam()
		if This.IsStringNamedPAram() or This.IsSubStringNamedParam()
			return TRUE
		else
			return FALSE
		ok

		def IsSubStringOrStringONamedParam()
			return This.IsStringOrSubStringNamedParam()

	#--

	def IsToNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :To )

			return TRUE

		else
			return FALSE
		ok

	def IsToPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ToPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsToPositionOfItemNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ToPositionOfItem )

			return TRUE

		else
			return FALSE
		ok

	def IsToPositionOfStringNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ToPositionOfString )

			return TRUE

		else
			return FALSE
		ok

	def IsToPositionOfStringItemNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ToPositionOfStringItem )

			return TRUE

		else
			return FALSE
		ok

	def IsToPositionOfCharNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ToPositionOfChar )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsFromPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsFromPositionOfItemNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromPositionOfItem )

			return TRUE

		else
			return FALSE
		ok

	def IsFromPositionOfStringNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromPositionOfString )

			return TRUE

		else
			return FALSE
		ok

	def IsFromPositionOfStringItemNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromPositionOfStringItem )

			return TRUE

		else
			return FALSE
		ok

	def IsFromPositionOfCharNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromPositionOfChar )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsOfNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Of )

			return TRUE

		else
			return FALSE
		ok

	def IsOnNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :On )

			return TRUE

		else
			return FALSE
		ok

	def IsInNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :In )

			return TRUE

		else
			return FALSE
		ok

	def IsInANamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :InA )

			return TRUE

		else
			return FALSE
		ok

	def IsInSideNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :InSide or This[1] = :Inside@) )

			return TRUE

		else
			return FALSE
		ok

	def IsInSideANamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and 
			(This[1] = :InSideA or This[1] = :InsideA@) )

			return TRUE

		else
			return FALSE
		ok

	def IsInOrInsideNamedParam()
		if This.IsInNamedParam() or This.IsInsideNamedParam()
			return TRUE

		else
			return FALSE
		ok

		def IsInsideOrInNamedParam()
			return This.IsInOrInsideNamedParam()

	def IsWhereNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Where ) and
		   isString( This[2] )

			return TRUE

		else
			return FALSE
		ok

	def IsThatNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :That ) and
		   isString( This[2] )

			return TRUE

		else
			return FALSE
		ok

	def IsThatOrWhereNamedParam()
		if This.IsThatNamedParam() or This.IsWhatNamedParam()
			return TRUE
		else
			return FALSE
		ok

		def IsWhereOrThatNamedParam()
			return This.IsThatOrWhereNamedParam()

	def IsPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Position )

			return TRUE

		else
			return FALSE
		ok

	def IsThisPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ThisPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsPositionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Positions )

			return TRUE

		else
			return FALSE
		ok

	def IsThesePositionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ThesePositions )

			return TRUE

		else
			return FALSE
		ok

	def IsAlongWithNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  (This[1] = :AlongWith or This[1] = :AlongWith@)  )

			return TRUE

		else
			return FALSE
		ok

	def IsAlongWithTheirNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  (This[1] = :AlongWithTheir or This[1] = :AlongWithTheir@)  )

			return TRUE

		else
			return FALSE
		ok

	def IsAndNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  (This[1] = :And or This[1] = :And@)  )

			return TRUE

		else
			return FALSE
		ok

	def IsAndTheirNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  (This[1] = :AndTheir or This[1] = :AndTheir@)  )

			return TRUE

		else
			return FALSE
		ok

	def IsAndItemNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :AndItem )

			return TRUE

		else
			return FALSE
		ok

	def IsAndStringNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :AndString )

			return TRUE

		else
			return FALSE
		ok

	def IsAndStringItemNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :AndStringItem )

			return TRUE

		else
			return FALSE
		ok

	def IsAndCharNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :AndChar )

			return TRUE

		else
			return FALSE
		ok

	def IsAndPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :AndPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsAndPositionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :AndPositions )

			return TRUE

		else
			return FALSE
		ok

	def IsAndItemAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :AndItemAt )

			return TRUE

		else
			return FALSE
		ok

	def IsAndItemAtPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :AndItemAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsAndStringAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :AndStringAt )

			return TRUE

		else
			return FALSE
		ok

	def IsAndStringAtPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :AndStringAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsAndStringItemAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :AndStringItemAt )

			return TRUE

		else
			return FALSE
		ok

	def IsAndStringItemAtPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :AndStringItemAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsOrNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Or )

			return TRUE

		else
			return FALSE
		ok

	def IsNorNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Nor )

			return TRUE

		else
			return FALSE
		ok

	def IsWhileNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :While )

			return TRUE

		else
			return FALSE
		ok

	def IsNotNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Not )

			return TRUE

		else
			return FALSE
		ok

	def IsIfNamedParam()
		if This.NumberOfItems() = 2 and
		   This[1] = :If and
		   isString(This[2])

			return TRUE

		else
			return FALSE
		ok

	def IsIfOrWhereNamedParam()
		return This.IsIfNamedParam() or This.IsWhereNamedParam()

		def IsWhereOrIfNamedParam()
			return This.IsIfOrWhereNamedParam()

	def IsWithNamedParam()
		if This.NumberOfItems() = 2 and

		   ( isString(This[1]) and Q(This[1]).IsOneOfThese([ :With, :With@ ]) )

			return TRUE

		else
			return FALSE
		ok

	def IsWithTheirNamedParam()
		if This.NumberOfItems() = 2 and

		   ( isString(This[1]) and Q(This[1]).IsOneOfThese([ :WithTheir, :WithTheir@ ]) )

			return TRUE

		else
			return FALSE
		ok

	def IsByNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  StzStringQ(This[1]).IsOneOfThese([ :By, :By@ ]) )
		  
			return TRUE

		else
			return FALSE
		ok

	def IsByColNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  StzStringQ(This[1]).IsOneOfThese([ :ByCol, :ByCol@ ]) )
		  
			return TRUE

		else
			return FALSE
		ok

	def IsByColumnNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  StzStringQ(This[1]).IsOneOfThese([ :ByColumn, :ByColumn@ ]) )
		  
			return TRUE

		else
			return FALSE
		ok

	def IsUsingColNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  StzStringQ(This[1]).IsOneOfThese([ :UsingCol, :UsingCol@ ]) )
		  
			return TRUE

		else
			return FALSE
		ok

	def IsUsingColumnNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  StzStringQ(This[1]).IsOneOfThese([ :UsingColumn, :UsingColumn@ ]) )
		  
			return TRUE

		else
			return FALSE
		ok

	def IsWithColNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  StzStringQ(This[1]).IsOneOfThese([ :WithCol, :WithCol@ ]) )
		  
			return TRUE

		else
			return FALSE
		ok

	def IsWithColumnNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  StzStringQ(This[1]).IsOneOfThese([ :WithColumn, :WithColumn@ ]) )
		  
			return TRUE

		else
			return FALSE
		ok

	def IsByRowNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ByRow )
		  
			return TRUE

		else
			return FALSE
		ok

	def IsWithRowNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :WithRow )
		  
			return TRUE

		else
			return FALSE
		ok

	def IsUsingRowNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :UsingRow )
		  
			return TRUE

		else
			return FALSE
		ok

	def IsByCellNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ByCell )
		  
			return TRUE

		else
			return FALSE
		ok

	def IsWithCellNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :WithCell )
		  
			return TRUE

		else
			return FALSE
		ok

	def IsUsingCellNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :UsingCell )
		  
			return TRUE

		else
			return FALSE
		ok

	def IsWithOrByNamedParam()
		return This.IsWithNamedParam() OR This.IsByNamedParam()

		def IsByOrWithNamedParam()
			return This.IsWithOrByNamedParam()

	def IsUsingNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Using )

			return TRUE

		else
			return FALSE
		ok

	def IsAtNamedParam()
		if This.NumberOfItems() = 2 and
		   isString(This[1]) and This[1] = :At
			return TRUE

		else
			return FALSE
		ok

	def IsAtOrUsingNamedParam()
		if This.IsAtNamedParam() or This.IsUsingNamedParam()
			return TRUE
		else
			return FALSE
		ok

		def IsUsingOrAtNamedParam()
			return This.IsAtOrUsingNamedParam()

	#--

	def IsAtPositionNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsAtThisPositionNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtThisPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsAtPositionsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtPositions )

			return TRUE

		else
			return FALSE
		ok

	def IsAtThesePositionsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtThesePositions )

			return TRUE

		else
			return FALSE
		ok

	def IsAtManyPositionsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtManyPositions )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsAtOrAtPositionNamedParam()
		if This.IsAtNamedParam() or
		   This.IsAtPositionNamedParam()

			return TRUE

		else
			return FALSE
		ok

		def IsAtPositionOrAtNamedParam()
			return This.IsAtOrAtPositionNamedParam()

	def IsAtOrAtPositionsNamedParam()
		if This.IsAtNamedParam() or
		   This.IsAtPositionsNamedParam()

			return TRUE

		else
			return FALSE
		ok

		def IsAtPositionsOrAtNamedParam()
			return This.IsAtOrAtPositionsNamedParam()

	#==

	def IsAtItemNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtItem )

			return TRUE

		else
			return FALSE
		ok

	def IsAtThisItemNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtThisItem )

			return TRUE

		else
			return FALSE
		ok

	def IsAtItemsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtItems )

			return TRUE

		else
			return FALSE
		ok

	def IsAtTheseItemsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtTheseItems )

			return TRUE

		else
			return FALSE
		ok

	def IsAtManyItemsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtManyItems )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsAtStringNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtString )

			return TRUE

		else
			return FALSE
		ok

	def IsAtThisStringNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtThisString )

			return TRUE

		else
			return FALSE
		ok

	def IsAtStringsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtStrings )

			return TRUE

		else
			return FALSE
		ok

	def IsAtTheseStringsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtTheseStrings )

			return TRUE

		else
			return FALSE
		ok

	def IsAtManyStringsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtManyStrings )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsAtStringItemNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtStringItem )

			return TRUE

		else
			return FALSE
		ok

	def IsAtThisStringItemNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtThisStringItem )

			return TRUE

		else
			return FALSE
		ok

	def IsAtStringItemsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtStringItems )

			return TRUE

		else
			return FALSE
		ok

	def IsAtTheseStringItemsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtTheseStringItems )

			return TRUE

		else
			return FALSE
		ok

	def IsAtManyStringItemsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtManyStringItems )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsAtSubStringNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtSubString )

			return TRUE

		else
			return FALSE
		ok

	def IsAtThisSubStringNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtThisSubString )

			return TRUE

		else
			return FALSE
		ok

	def IsAtSubStringsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtSubStrings )

			return TRUE

		else
			return FALSE
		ok

	def IsAtTheseSubStringsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtTheseSubStrings )

			return TRUE

		else
			return FALSE
		ok

	def IsAtManySubStringsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtManySubStrings )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsAtCharNamedParam()
		if This.NumberOfItems() = 2 and
			( isChar(This[1]) and  This[1] = :AtChar )

			return TRUE

		else
			return FALSE
		ok

	def IsAtThisCharNamedParam()
		if This.NumberOfItems() = 2 and
			( isChar(This[1]) and  This[1] = :AtThisChar )

			return TRUE

		else
			return FALSE
		ok

	def IsAtCharsNamedParam()
		if This.NumberOfItems() = 2 and
			( isChar(This[1]) and  This[1] = :AtChars )

			return TRUE

		else
			return FALSE
		ok

	def IsAtTheseCharsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtTheseChars )

			return TRUE

		else
			return FALSE
		ok

	def IsAtManyCharsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtManyChars )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsAtNumberNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtNumber )

			return TRUE

		else
			return FALSE
		ok

	def IsAtThisNumberNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtThisNumber )

			return TRUE

		else
			return FALSE
		ok

	def IsAtNumbersNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtNumbers )

			return TRUE

		else
			return FALSE
		ok

	def IsAtTheseNumbersNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtTheseNumbers )

			return TRUE

		else
			return FALSE
		ok

	def IsAtManyNumbersNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtManyNumbers )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsAtListNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtList )

			return TRUE

		else
			return FALSE
		ok

	def IsAtThisListNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtThisList )

			return TRUE

		else
			return FALSE
		ok

	def IsAtListsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtLists )

			return TRUE

		else
			return FALSE
		ok

	def IsAtTheseListsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtTheseLists )

			return TRUE

		else
			return FALSE
		ok

	def IsAtManyListsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtManyLists )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsAtSubListNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtSubList )

			return TRUE

		else
			return FALSE
		ok

	def IsAtThisSubListNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtThisSubList )

			return TRUE

		else
			return FALSE
		ok

	def IsAtSubListsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtSubLists )

			return TRUE

		else
			return FALSE
		ok

	def IsAtTheseSubListsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtTheseSubLists )

			return TRUE

		else
			return FALSE
		ok

	def IsAtManySubListsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtManySubLists )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsAtPairNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtPair )

			return TRUE

		else
			return FALSE
		ok

	def IsAtThisPairNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtThisPair )

			return TRUE

		else
			return FALSE
		ok

	def IsAtPairsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtPairs )

			return TRUE

		else
			return FALSE
		ok

	def IsAtThesePairsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtThesePairs )

			return TRUE

		else
			return FALSE
		ok

	def IsAtManyPairsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtManyPairs )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsAtListOfNumbersNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtListOfNumbers )

			return TRUE

		else
			return FALSE
		ok

	def IsAtThisListOfNumbersNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtThisListOfNumbers )

			return TRUE

		else
			return FALSE
		ok

	def IsAtListsOfNumbersNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtListsOfNumbers )

			return TRUE

		else
			return FALSE
		ok

	def IsAtTheseListsOfNumbersNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtTheseListsOfNumbers )

			return TRUE

		else
			return FALSE
		ok

	def IsAtManyListsOfNumbersNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtManyListsOfNumbers )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsAtListOfCharsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtListOfChars )

			return TRUE

		else
			return FALSE
		ok

	def IsAtThisListOfCharsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtThisListOfChars )

			return TRUE

		else
			return FALSE
		ok

	def IsAtListsOfCharsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtListsOfChars )

			return TRUE

		else
			return FALSE
		ok

	def IsAtTheseListsOfCharsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtTheseListsOfChars )

			return TRUE

		else
			return FALSE
		ok

	def IsAtManyListsOfCharsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtManyListsOfChars )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsAtListOfStringsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtListOfStrings )

			return TRUE

		else
			return FALSE
		ok

	def IsAtThisListOfStringsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtThisListOfStrings )

			return TRUE

		else
			return FALSE
		ok

	def IsAtListsOfStringsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtListsOfStrings )

			return TRUE

		else
			return FALSE
		ok

	def IsAtTheseListsOfStringsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtTheseListsOfStrings )

			return TRUE

		else
			return FALSE
		ok

	def IsAtManyListsOfStringsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtManyListsOfStrings )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsAtListOfStringItemsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtListOfStringItems )

			return TRUE

		else
			return FALSE
		ok

	def IsAtThisListOfStringItemsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtThisListOfStringItems )

			return TRUE

		else
			return FALSE
		ok


	def IsAtListsOfStringItemsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtListsOfStringItems )

			return TRUE

		else
			return FALSE
		ok

	def IsAtTheseListsOfStringItemsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtTheseListsOfStringItems )

			return TRUE

		else
			return FALSE
		ok

	def IsAtManyListsOfStringItemsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtManyListsOfStringItems )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsAtListOfListsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtListOfLists )

			return TRUE

		else
			return FALSE
		ok

	def IsAtThisListOfListsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtThisListOfLists )

			return TRUE

		else
			return FALSE
		ok

	def IsAtListsOfListsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtListsOfLists )

			return TRUE

		else
			return FALSE
		ok

	def IsAtTheseListsOfListsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtTheseListsOfLists )

			return TRUE

		else
			return FALSE
		ok

	def IsAtManyListsOfListsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtManyListsOfLists )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsAtListOfSubListsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtListOfSubLists )

			return TRUE

		else
			return FALSE
		ok

	def IsAtThisListOfSubListsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtThisListOfSubLists )

			return TRUE

		else
			return FALSE
		ok

	def IsAtListsOfSubListsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtListsOfSubLists )

			return TRUE

		else
			return FALSE
		ok

	def IsAtTheseListsOfSubListsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtTheseListsOfSubLists )

			return TRUE

		else
			return FALSE
		ok

	def IsAtManyListsOfSubListsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtManyListsOfSubLists )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsAtListOfPairsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtListOfPairs )

			return TRUE

		else
			return FALSE
		ok

	def IsAtThisListOfPairsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtThisListOfPairs )

			return TRUE

		else
			return FALSE
		ok
	def IsAtListsOfPairsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtListsOfPairs )

			return TRUE

		else
			return FALSE
		ok

	def IsAtTheseListsOfPairsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtTheseListsOfPairs )

			return TRUE

		else
			return FALSE
		ok

	def IsAtManyListsOfPairsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtManyListsOfPairs )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsAtListOfHashListsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtListOfHashLists )

			return TRUE

		else
			return FALSE
		ok

	def IsAtThisListOfHashListsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtThisListOfHashLists )

			return TRUE

		else
			return FALSE
		ok

	def IsAtListsOfHashListsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtListsOfHashLists )

			return TRUE

		else
			return FALSE
		ok

	def IsAtTheseListsOfHashListsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtTheseListsOfHashLists )

			return TRUE

		else
			return FALSE
		ok

	def IsAtManyListsOfHashListsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtManyListsOfHashLists )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsAtObjectNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtObject )

			return TRUE

		else
			return FALSE
		ok

	def IsAtThisObjectNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtThisObject )

			return TRUE

		else
			return FALSE
		ok

	def IsAtObjectsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtObjects )

			return TRUE

		else
			return FALSE
		ok

	def IsAtTheseObjectsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtTheseObjects )

			return TRUE

		else
			return FALSE
		ok

	def IsAtManyObjectsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtManyObjects )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsAtSectionNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtSection )

			return TRUE

		else
			return FALSE
		ok

	def IsAtThisSectionNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtThisSection )

			return TRUE

		else
			return FALSE
		ok

	def IsAtSectionsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtSections )

			return TRUE

		else
			return FALSE
		ok

	def IsAtTheseSectionsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtTheseSections )

			return TRUE

		else
			return FALSE
		ok

	def IsAtManySectionsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtManySections )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsAtListOfSectionsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtListOfSections )

			return TRUE

		else
			return FALSE
		ok

	def IsAtThisListOfSectionsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtThisListOfSections )

			return TRUE

		else
			return FALSE
		ok

	def IsAtListsOfSectionsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtListsOfSections )

			return TRUE

		else
			return FALSE
		ok

	def IsAtTheseListsOfSectionsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtTheseListsOfSections )

			return TRUE

		else
			return FALSE
		ok

	def IsAtManyListsOfSectionsNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtManyListsOfSections )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsAtRangeNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtRange )

			return TRUE

		else
			return FALSE
		ok

	def IsAtThisRangeNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtThisRange )

			return TRUE

		else
			return FALSE
		ok

	def IsAtRangesNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtRanges )

			return TRUE

		else
			return FALSE
		ok

	def IsAtTheseRangesNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtTheseRanges )

			return TRUE

		else
			return FALSE
		ok

	def IsAtManyRangesNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtManyRanges )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsAtListOfRangesNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtListOfRanges )

			return TRUE

		else
			return FALSE
		ok

	def IsAtThisListOfRangesNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtThisListOfRanges )

			return TRUE

		else
			return FALSE
		ok

	def IsAtListsOfRangesNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtListsOfRanges )

			return TRUE

		else
			return FALSE
		ok

	def IsAtTheseListsOfRangesNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtTheseListsOfRanges )

			return TRUE

		else
			return FALSE
		ok

	def IsAtManyListsOfRangesNamedParam()
		if This.NumberOfItems() = 2 and
			( isString(This[1]) and  This[1] = :AtManyListsOfRanges )

			return TRUE

		else
			return FALSE
		ok


	#==

	def IsUsingOrAtOrWhereNamedParam()
		# Use IsOneOfTheseNamedParams([ ..., ..., ... ]) instead

		if This.IsUsingNamedParam() or
		   This.IsAtNamedParam() or
		   This.IsWhereNamedParam()

			return TRUE
		else
			return FALSE
		ok

		def IsUsingOrWhereOrAtNamedParam()
			return This.IsUsingOrAtOrWhereNamedParam()
		
		def IsAtOrUsingOrWhereNamedParam()
			return This.IsUsingOrAtOrWhereNamedParam()
	
		def IsAtOrWhereOrUsingNamedParam()
			return This.IsUsingOrAtOrWhereNamedParam()

		def IsWhereOrAtOrUsingNamedParam()
			return This.IsUsingOrAtOrWhereNamedParam()
	
		def IsWhereOrUsingOrAtNamedParam()
			return This.IsUsingOrAtOrWhereNamedParam()

	def IsStepNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  Q(This[1]).IsOneOfThese([ :Step, :Steps ]) ) and
		   isNumber( This[2] )
		  
			return TRUE

		else
			return FALSE
		ok

	def IsNameNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Name ) and
		   isString(This[2])
		  
			return TRUE

		else
			return FALSE
		ok

	def IsNamedNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Named ) and
		   isString(This[2])
		  
			return TRUE

		else
			return FALSE
		ok

	def IsNamedAsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :NamedAs ) and
		   isString(This[2])
		  
			return TRUE

		else
			return FALSE
		ok

	def IsRaiseNamedParam()
		if This.NumberOfItems() <= 4 and
		   This.IsHashList() and
		   This.ToStzHashList().KeysQ().IsMadeOfSome([ :Where, :What, :Why, :Todo ]) and
		   This.ToStzHashList().ValuesQ().AllItemsVerifyW("isString(@item) and @item != NULL")

			return TRUE

		else
			return FALSE
		ok

	def IsReturnedAsNamedParam()

		if This.NumberOfItems() = 2 and This[1] = :ReturnedAs

			return TRUE

		else
			return FALSE
		ok

	def IsAndReturnedAsNamedParam()

		if This.NumberOfItems() = 2 and This[1] = :AndReturnedAs

			return TRUE

		else
			return FALSE
		ok

	def IsReturnNamedParam()
		if This.NumberOfItems() = 2 and
		   isString(This[1]) and This[1] = :Return

			return TRUE

		else
			return FALSE
		ok

	def IsReturnAsNamedParam()
		if This.NumberOfItems() = 2 and
		   isString(This[1]) and This[1] = :ReturnAs

			return TRUE

		else
			return FALSE
		ok

	def IsAndReturnAsNamedParam()
		if This.NumberOfItems() = 2 and
		   isString(This[1]) and This[1] = :AndReturnAs

			return TRUE

		else
			return FALSE
		ok

	def IsReturnItAsNamedParam()
		if This.NumberOfItems() = 2 and
		   isString(This[1]) and This[1] = :ReturnItAs

			return TRUE

		else
			return FALSE
		ok

	def IsAndReturnItAsNamedParam()
		if This.NumberOfItems() = 2 and
		   isString(This[1]) and This[1] = :AndReturnItAs

			return TRUE

		else
			return FALSE
		ok

	def IsReturnThemAsNamedParam()
		if This.NumberOfItems() = 2 and
		   isString(This[1]) and This[1] = :ReturnThemAs

			return TRUE

		else
			return FALSE
		ok

	def IsAndReturnThemAsNamedParam()
		if This.NumberOfItems() = 2 and
		   isString(This[1]) and This[1] = :AndReturnThemAs

			return TRUE

		else
			return FALSE
		ok

	def IsReturningNamedParam()
		if This.NumberOfItems() = 2 and
		   isString(This[1]) and Q(This[1]).IsEqualToCS(:Returning, :CS = FALSE)

			return TRUE

		else
			return FALSE
		ok

	def IsAndReturnNamedParam()
		if This.NumberOfItems() = 2 and
		   isString(This[1]) and Q(This[1]).IsEqualToCS(:AndReturn, :CS = FALSE)

			return TRUE

		else
			return FALSE
		ok

	def IsAndReturningNamedParam()
		if This.NumberOfItems() = 2 and
		   isString(This[1]) and Q(This[1]).IsEqualToCS(:AndReturning, :CS = FALSE)

			return TRUE

		else
			return FALSE
		ok

	def IsReturnNthNamedParam()
		if This.NumberOfItems() = 2 and
		   isString(This[1]) and Q(This[1]).IsEqualToCS(:ReturnNth, :CS = FALSE)

			return TRUE

		else
			return FALSE
		ok

	def IsReturningNthNamedParam()
		if This.NumberOfItems() = 2 and
		   isString(This[1]) and Q(This[1]).IsEqualToCS(:ReturningNth, :CS = FALSE)

			return TRUE

		else
			return FALSE
		ok

	def IsAndReturnNthNamedParam()
		if This.NumberOfItems() = 2 and
		   isString(This[1]) and Q(This[1]).IsEqualToCS(:AndReturnNth, :CS = FALSE)

			return TRUE

		else
			return FALSE
		ok

	def IsAndReturningNthNamedParam()
		if This.NumberOfItems() = 2 and
		   isString(This[1]) and Q(This[1]).IsEqualToCS(:AndReturningNth, :CS = FALSE)

			return TRUE

		else
			return FALSE
		ok

	def IsDirectionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Direction ) and
		   ( isString( This[2] ) and Q(This[2]).IsOneOfThese([
			:Forward, :Backward, :Left, :Right, :Center, :Up, :Down, :Default ]) )
		  
			return TRUE

		else
			return FALSE
		ok

	def IsUpToNCharsNamedParam()
		if This.NumberOfItems() = 2 and
 		   isString(This[1]) and  This[1] = :UpToNChars
		  
			return TRUE

		else
			return FALSE
		ok

	def IsUpToNItemsNamedParam()
		if ( This.NumberOfItems() = 2 ) and
 		   ( isString(This[1]) and  This[1] = :UpToNItems )
		  
			return TRUE

		else
			return FALSE
		ok

	def IsBeforeNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :Before )

			return TRUE
		else
			return FALSE
		ok

	def IsBeforePositionNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :BeforePosition )

			return TRUE
		else
			return FALSE
		ok

	def IsBeforeThisPositionNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :BeforeThisPosition )

			return TRUE
		else
			return FALSE
		ok

	def IsBeforePositionsNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :BeforePositions )

			return TRUE
		else
			return FALSE
		ok

	def IsBeforeThesePositionsNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :BeforeThesePositions )

			return TRUE
		else
			return FALSE
		ok

	#--

	def IsBeforeSubStringNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :BeforeSubString )

			return TRUE
		else
			return FALSE
		ok

	def IsBeforeThisSubStringNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :BeforeThisSubString )

			return TRUE
		else
			return FALSE
		ok

	def IsBeforeSubStringsNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :BeforeSubStrings )

			return TRUE
		else
			return FALSE
		ok

	def IsBeforeTheseSubStringsNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :BeforeTheseSubStrings )

			return TRUE
		else
			return FALSE
		ok

	def IsBeforeSubStringPositionNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :BeforeSubStringPosition )

			return TRUE
		else
			return FALSE
		ok

	def IsBeforeThisSubStringPositionNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :BeforeThisSubStringPosition )

			return TRUE
		else
			return FALSE
		ok

	def IsBeforeSubStringsPositionsNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :BeforeSubStringsPositions )

			return TRUE
		else
			return FALSE
		ok

	def IsBeforeTheseSubStringsPositionsNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :BeforeTheseSubStringsPositions )

			return TRUE
		else
			return FALSE
		ok

	#--

	def IsAfterSubStringNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :AfterSubString )

			return TRUE
		else
			return FALSE
		ok

	def IsAfterThisSubStringNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :AfterThisSubString )

			return TRUE
		else
			return FALSE
		ok

	def IsAfterSubStringsNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :AfterSubStrings )

			return TRUE
		else
			return FALSE
		ok

	def IsAfterTheseSubStringsNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :AfterTheseSubStrings )

			return TRUE
		else
			return FALSE
		ok

	def IsAfterSubStringPositionNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :AfterSubStringPosition )

			return TRUE
		else
			return FALSE
		ok

	def IsAfterThisSubStringPositionNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :AfterThisSubStringPosition )

			return TRUE
		else
			return FALSE
		ok

	def IsAfterSubStringsPositionsNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :AfterSubStringsPositions )

			return TRUE
		else
			return FALSE
		ok

	def IsAfterTheseSubStringsPositionsNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :AfterTheseSubStringsPositions )

			return TRUE
		else
			return FALSE
		ok

	#--

	def IsBeforeSectionNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :BeforeSection )

			return TRUE
		else
			return FALSE
		ok

	def IsBeforeThisSectionNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :BeforeThisSection )

			return TRUE
		else
			return FALSE
		ok

	def IsBeforeSectionsNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :BeforeSections )

			return TRUE
		else
			return FALSE
		ok

	def IsBeforeTheseSectionsNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :BeforeTheseSections )

			return TRUE
		else
			return FALSE
		ok

	#--

	def IsAfterSectionNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :AfterSection )

			return TRUE
		else
			return FALSE
		ok

	def IsAfterThisSectionNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :AfterThisSection )

			return TRUE
		else
			return FALSE
		ok

	def IsAfterSectionsNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :AfterSections )

			return TRUE
		else
			return FALSE
		ok

	def IsAfterTheseSectionsNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :AfterTheseSections )

			return TRUE
		else
			return FALSE
		ok

	#--

	def IsBeforeOrAtNamedParam()
		if This.IsBeforeNamedParam() or This.IsAtNamedParam()
			return TRUE
		else
			return FALSE
		ok

		def IsAtOrBeforeNamedParam()
			return This.IsBeforeOrAtNamedParam()

	def IsAfterNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :After )

			return TRUE
		else
			return FALSE
		ok

	def IsAfterPositionNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :AfterPosition )

			return TRUE
		else
			return FALSE
		ok

	def IsAfterThisPositionNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :AfterThisPosition )

			return TRUE
		else
			return FALSE
		ok

	def IsAfterPositionsNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :AfterPositions )

			return TRUE
		else
			return FALSE
		ok

	def IsAfterThesePositionsNamedParam()
		if ( This.NumberOfItems() = 2 ) and
		   ( isString(This[1]) and This[1] = :AfterThesePositions )

			return TRUE
		else
			return FALSE
		ok

	def IsAfterOrAtNamedParam()
		if This.IsAfterNamedParam() or This.IsAtNamedParam()
			return TRUE
		else
			return FALSE
		ok

		def IsAtOrAfterNamedParam()
			return This.IsAfterOrAtNamedParam()

	def IsBeforeOrAfterNamedParam()
		if This.IsBeforeNamedPAram() or This.IsAfterNamedParam()
			return TRUE
		else
			return FALSE
		ok

		def IsAfterOrBeforeNamedParam()
			return This.IsBeforeOrAfterNamedParam()

	def IsWidthNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Width )

			return TRUE

		else
			return FALSE
		ok

	def IsMadeOfNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :MadeOf )

			return TRUE

		else
			return FALSE
		ok

	def IsNthTofirstNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :NthToFirst )

			return TRUE

		else
			return FALSE
		ok

	def IsNthToFirstCharNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :NthToFirstChar )

			return TRUE

		else
			return FALSE
		ok

	def IsNthToFirstItemNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :NthToFirstItem )

			return TRUE

		else
			return FALSE
		ok

	def IsNthToLastNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :NthToLast )

			return TRUE

		else
			return FALSE
		ok

	def IsNthToLastCharNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :NthToLastChar )

			return TRUE

		else
			return FALSE
		ok

	def IsNthToLastItemNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :NthToLastItem )

			return TRUE

		else
			return FALSE
		ok

	def IsStringNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :String )

			return TRUE

		else
			return FALSE
		ok

	def IsThisStringNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ThisString )

			return TRUE

		else
			return FALSE
		ok

	def IsStringItemNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :StringItem )

			return TRUE

		else
			return FALSE
		ok

	def IsThisStringItemNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ThisStringItem )

			return TRUE

		else
			return FALSE
		ok

	def IsStringOrStringItemNamedParam()
		if This.IsStringNamedParam() or This.IsStringItemNamedParam()
			return TRUE
		else
			return FALSE
		ok

		def IsStringItemOrStringNamedParam()
			return This.IsStringOrStringItemNamedParam()

	#--

	def IsNumberNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Number )

			return TRUE

		else
			return FALSE
		ok

	def IsThisNumberNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ThisNumber )

			return TRUE

		else
			return FALSE
		ok

	def IsNumbersNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Numbers )

			return TRUE

		else
			return FALSE
		ok

	def IsTheseNumbersNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :TheseNumbers )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsCharNamedParam()
		if This.CharOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Char )

			return TRUE

		else
			return FALSE
		ok

	def IsThisCharNamedParam()
		if This.CharOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ThisChar )

			return TRUE

		else
			return FALSE
		ok

	def IsCharsNamedParam()
		if This.CharOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Chars )

			return TRUE

		else
			return FALSE
		ok

	def IsTheseCharsNamedParam()
		if This.CharOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :TheseChars )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsItemNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Item )

			return TRUE

		else
			return FALSE
		ok

	def IsItemsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Items )

			return TRUE

		else
			return FALSE
		ok

	def IsItemAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ItemAt )

			return TRUE

		else
			return FALSE
		ok

	def IsItemsAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Items )

			return TRUE

		else
			return FALSE
		ok

	def IsItemAtPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ItemAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsItemsAtPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ItemsAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsStringsAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Strings )

			return TRUE

		else
			return FALSE
		ok

	def IsTheseStringsAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :TheseStrings )

			return TRUE

		else
			return FALSE
		ok

	def IsStringAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :StringAt )

			return TRUE

		else
			return FALSE
		ok

	def IsThisStringAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ThisStringAt )

			return TRUE

		else
			return FALSE
		ok

	def IsStringAtPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :StringAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsStringAtPositionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :StringAtPositions )

			return TRUE

		else
			return FALSE
		ok

	def IsItemAtPositionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ItemAtPositions )

			return TRUE

		else
			return FALSE
		ok

	def IsItemsAtPositionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ItemsAtPositions )

			return TRUE

		else
			return FALSE
		ok

	def IsStringItemAtPositionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :StringItemAtPositions )

			return TRUE

		else
			return FALSE
		ok

	def IsCharAtPositionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :CharAtPositions )

			return TRUE

		else
			return FALSE
		ok

	def IsCharsAtPositionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :CharsAtPositions )

			return TRUE

		else
			return FALSE
		ok

	def IsStringItemAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :StringItemAt )

			return TRUE

		else
			return FALSE
		ok

	def IsStringItemAtPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :StringItemAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsSubStringAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :SubStringAt )

			return TRUE

		else
			return FALSE
		ok

	def IsThisSubStringAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ThisSubStringAt )

			return TRUE

		else
			return FALSE
		ok

	def IsSubStringsAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :SubStringsAt )

			return TRUE

		else
			return FALSE
		ok

	def IsTheseSubStringsAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :TheseSubStringsAt )

			return TRUE

		else
			return FALSE
		ok

	def IsSubStringAtPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :SubStringAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsSubStringsAtPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :SubStringsAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Between )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenXTNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenXT )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenCSNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenCS )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenPositionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenPositions )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsBetweenRowNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenRow )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenRowAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenRowAt )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenRowAtPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenRowAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenRowsAtPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenRowsAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenRowsAtPositionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenRowsAtPositions )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenRowsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenRows )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenRowsAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenRowsAt )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsBetweenColNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenCol )

			return TRUE

		else
			return FALSE
		ok

		def IsBetweenColumnNamedParam()
			if This.NumberOfItems() = 2 and
			   ( isString(This[1]) and  This[1] = :BetweenColumn )
	
				return TRUE
	
			else
				return FALSE
			ok

	def IsBetweenColAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenColAt )

			return TRUE

		else
			return FALSE
		ok

		def IsBetweenColumnAtNamedParam()
			if This.NumberOfItems() = 2 and
			   ( isString(This[1]) and  This[1] = :BetweenColumnAt )
	
				return TRUE
	
			else
				return FALSE
			ok

	def IsBetweenColAtPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenColAtPosition )

			return TRUE

		else
			return FALSE
		ok

		def IsBetweenColumnAtPositionNamedParam()
			if This.NumberOfItems() = 2 and
			   ( isString(This[1]) and  This[1] = :BetweenColumnAtPosition )
	
				return TRUE
	
			else
				return FALSE
			ok
	
	def IsBetweenColsAtPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenColsAtPosition )

			return TRUE

		else
			return FALSE
		ok

		def IsBetweenColumnsAtPositionNamedParam()
			if This.NumberOfItems() = 2 and
			   ( isString(This[1]) and  This[1] = :BetweenColumnsAtPosition )
	
				return TRUE
	
			else
				return FALSE
			ok

	def IsBetweenColsAtPositionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenColsAtPositions )

			return TRUE

		else
			return FALSE
		ok

		def IsBetweenColumnsAtPositionsNamedParam()
			if This.NumberOfItems() = 2 and
			   ( isString(This[1]) and  This[1] = :BetweenColumnsAtPositions )
	
				return TRUE
	
			else
				return FALSE
			ok

	def IsBetweenColsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenCols )

			return TRUE

		else
			return FALSE
		ok

		def IsBetweenColumnsNamedParam()
			if This.NumberOfItems() = 2 and
			   ( isString(This[1]) and  This[1] = :BetweenColumns )
	
				return TRUE
	
			else
				return FALSE
			ok

	def IsBetweenColsAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenColsAt )

			return TRUE

		else
			return FALSE
		ok

		def IsBetweenColumnsAtNamedParam()
			if This.NumberOfItems() = 2 and
			   ( isString(This[1]) and  This[1] = :BetweenColumnsAt )
	
				return TRUE
	
			else
				return FALSE
			ok

	#--

	def IsFromPositionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromPositions )

			return TRUE

		else
			return FALSE
		ok

	def IsToPositionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ToPositions )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsItemFromPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ItemFromPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsItemsFromPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ItemsFromPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsItemFromNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ItemFrom )

			return TRUE

		else
			return FALSE
		ok

	def IsItemsFromNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ItemsFrom )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenItemAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenItemAt )

			return TRUE

		else
			return FALSE
		ok

	def IsFromItemAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromItemAt )

			return TRUE

		else
			return FALSE
		ok

	def IsToItemAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ToItemAt )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenItemsAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenItemsAt )

			return TRUE

		else
			return FALSE
		ok

	def IsFromItemsAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromItemsAt )

			return TRUE

		else
			return FALSE
		ok

	def IsToItemsAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ToItemsAt )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenItemAtPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenItemAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsFromItemAtPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromItemAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsToItemAtPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ToItemAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenItemNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenItem )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenItemsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenItems )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenItemAtPositionsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenItemAtPositions )

			return TRUE

		else
			return FALSE
		ok

	def IsToItemAtPositionsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ToItemAtPositions )

			return TRUE

		else
			return FALSE
		ok

	def IsFromItemAtPositionsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromItemAtPositions )

			return TRUE

		else
			return FALSE
		ok

	def IsFromItemPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromItemPosition )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsStringFromPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :StringFromPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsStringsFromPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :StringsFromPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsStringFromNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :StringFrom )

			return TRUE

		else
			return FALSE
		ok

	def IsStringsFromNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :StringsFrom )

			return TRUE

		else
			return FALSE
		ok

	def IsFromStringPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromStringPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenStringNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenString )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenStringsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenStrings )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenStringItemNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenStringItem )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenStringItemsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenStringItems )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenStringAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenStringAt )

			return TRUE

		else
			return FALSE
		ok

	def IsToStringAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ToStringAt )

			return TRUE

		else
			return FALSE
		ok

	def IsFromStringAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromStringAt )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenStringAtPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenStringAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsFromStringAtPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromStringAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsToStringAtPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ToStringAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenStringAtPositionsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenStringAtPositions )

			return TRUE

		else
			return FALSE
		ok

	def IsFromStringAtPositionsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromStringAtPositions )

			return TRUE

		else
			return FALSE
		ok

	def IsToStringAtPositionsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ToStringAtPositions )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsStringItemFromPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :StringItemFromPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsStringItemsFromPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :StringItemsFromPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsStringItemFromNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :StringItemFrom )

			return TRUE

		else
			return FALSE
		ok

	def IsStringItemsFromNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :StringItemsFrom )

			return TRUE

		else
			return FALSE
		ok

	def IsFromStringItemPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromStringItemPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenStringItemAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenStringItemAt )

			return TRUE

		else
			return FALSE
		ok

	def IsFromStringItemAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromStringItemAt )

			return TRUE

		else
			return FALSE
		ok

	def IsToStringItemAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ToStringItemAt )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenStringItemAtPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenStringItemAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsFromStringItemAtPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromStringItemAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsToStringItemAtPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ToStringItemAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenStringItemAtPositionsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenStringItemAtPositions )

			return TRUE

		else
			return FALSE
		ok

	def IsFromStringItemAtPositionsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromStringItemAtPositions )

			return TRUE

		else
			return FALSE
		ok

	def IsToStringItemAtPositionsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ToStringItemAtPositions )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsCharFromPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :CharFromPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsCharsFromPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :CharsFromPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsCharFromNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :CharFrom )

			return TRUE

		else
			return FALSE
		ok

	def IsCharsFromNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :CharsFrom )

			return TRUE

		else
			return FALSE
		ok

	def IsFromCharPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromCharPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsCharAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :CharAt )

			return TRUE

		else
			return FALSE
		ok

	def IsCharAtPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :CharAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenCharNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenChar )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenCharsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenChars )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenCharAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenCharAt )

			return TRUE

		else
			return FALSE
		ok

	def IsFromCharAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromCharAt )

			return TRUE

		else
			return FALSE
		ok

	def IsFirstPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FirstPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsLastPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :LastPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsToCharAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ToCharAt )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenCharsAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenCharsAt )

			return TRUE

		else
			return FALSE
		ok

	def IsFromCharsAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromCharsAt )

			return TRUE

		else
			return FALSE
		ok

	def IsToCharsAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ToCharsAt )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenCharAtPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenCharAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsFromCharAtPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromCharAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsToCharAtPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ToCharAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenCharAtPositionsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenCharAtPositions )

			return TRUE

		else
			return FALSE
		ok

	def IsToCharAtPositionsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ToCharAtPositions )

			return TRUE

		else
			return FALSE
		ok

	def IsFromCharAtPositionsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromCharAtPositions )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsStringsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Strings )

			return TRUE

		else
			return FALSE
		ok

	def IsTheseStringsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :TheseStrings )

			return TRUE

		else
			return FALSE
		ok

	def IsStringsAtPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :StringsAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsTheseStringsAtPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :theseStringsAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsStringsAtPositionsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :StringsAtPositions )

			return TRUE

		else
			return FALSE
		ok

	def IsTheseStringsAtPositionsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :TheseStringsAtPositions )

			return TRUE

		else
			return FALSE
		ok

	def IsFromStringsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromStrings )

			return TRUE

		else
			return FALSE
		ok

	def IsToStringsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ToStrings )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenStringsAtNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenStringsAt )

			return TRUE

		else
			return FALSE
		ok

	def IsFromStringsAtNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromStringsAt )

			return TRUE

		else
			return FALSE
		ok

	def IsToStringsAtNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ToStringsAt )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenStringsAtPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenStringsAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsFromStringsAtPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromStringsAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsToStringsAtPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ToStringsAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenStringsAtPositionsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenStringsAtPositions )

			return TRUE

		else
			return FALSE
		ok

	def IsFromStringsAtPositionsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromStringsAtPositions )

			return TRUE

		else
			return FALSE
		ok

	def IsToStringsAtPositionsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ToStringsAtPositions )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsStringItemsFromPositionsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :StringItemsFromPositions )

			return TRUE

		else
			return FALSE
		ok

	def IsStringItemsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :StringItems )

			return TRUE

		else
			return FALSE
		ok

	def IsStringItemsAtNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :StringItemsAt )

			return TRUE

		else
			return FALSE
		ok

	def IsStringItemsAtPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :StringItemsAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsStringItemsAtPositionsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :StringItemsAtPositions )

			return TRUE

		else
			return FALSE
		ok

	def IsFromStringItemsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromStringItems )

			return TRUE

		else
			return FALSE
		ok

	def IsToStringItemsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ToStringItems )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenStringItemsAtNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenStringItemsAt )

			return TRUE

		else
			return FALSE
		ok

	def IsFromStringItemsAtNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromStringItemsAt )

			return TRUE

		else
			return FALSE
		ok

	def IsToStringItemsAtNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ToStringItemsAt )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenStringItemsAtPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenStringItemsAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsFromStringItemsAtPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromStringItemsAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsToStringItemsAtPositionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ToStringItemsAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsBetweenStringItemsAtPositionsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :BetweenStringItemsAtPositions )

			return TRUE

		else
			return FALSE
		ok

	def IsFromStringItemsAtPositionsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :FromStringItemsAtPositions )

			return TRUE

		else
			return FALSE
		ok

	def IsToStringItemsAtPositionsNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ToStringItemsAtPositions )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsAndColNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :AndCol )

			return TRUE

		else
			return FALSE
		ok

	def IsAndColumnNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :AndColumn )

			return TRUE

		else
			return FALSE
		ok

	def IsAndColAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :AndColat )

			return TRUE

		else
			return FALSE
		ok

	def IsAndColumnAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :AndColumnAt )

			return TRUE

		else
			return FALSE
		ok

	def IsAndColAtPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :AndColAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsAndColumnAtPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :AndColumnAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsAndColNamedNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :AndColNamed )

			return TRUE

		else
			return FALSE
		ok

	def IsAndColumnNamedNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :AndColumnNamed )

			return TRUE

		else
			return FALSE
		ok

	def IsColsAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Cols )

			return TRUE

		else
			return FALSE
		ok

	def IsColumnsAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Columns )

			return TRUE

		else
			return FALSE
		ok

	def IsColsAtPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ColsAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsColumnsAtPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ColumnsAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsColsAtPositionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ColsAtPositions )

			return TRUE

		else
			return FALSE
		ok

	def IsColumnsAtPositionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :ColumnsAtPositions )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsAndRowNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :AndRow )

			return TRUE

		else
			return FALSE
		ok

	def IsAndRowAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :AndRowAt )

			return TRUE

		else
			return FALSE
		ok

	def IsAndRowAtPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :AndRowAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsRowsAtNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :RowsAt )

			return TRUE

		else
			return FALSE
		ok

	def IsRowsAtPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :RowsAtPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsRowsAtPositionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :RowsAtPositions )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsThisNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :This )

			return TRUE

		else
			return FALSE
		ok

	def IsAndThisNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :AndThis )

			return TRUE

		else
			return FALSE
		ok

	def IsAndThatNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :AndThat )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsEvalNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Eval )

			return TRUE

		else
			return FALSE
		ok

	def IsEvaluateNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Evaluate )

			return TRUE

		else
			return FALSE
		ok

	def IsEvalFromNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :EvalFrom )

			return TRUE

		else
			return FALSE
		ok

	def IsEvaluateFromNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :EvaluateFrom )

			return TRUE

		else
			return FALSE
		ok

	def IsEvalDirectionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :EvalDirection )

			return TRUE

		else
			return FALSE
		ok

	def IsEvaluationDirectionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :EvaluationDirection )

			return TRUE

		else
			return FALSE
		ok

	def IsOrThisNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :OrThis )

			return TRUE

		else
			return FALSE
		ok

	def IsOrThatNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :OrThat )

			return TRUE

		else
			return FALSE
		ok

	#--

	def IsSubStringNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :SubString )

			return TRUE
		else
			return FALSE
		ok

	def IsThisSubStringNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :ThisSubString )

			return TRUE
		else
			return FALSE
		ok

	def IsAndSubStringNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :AndSubString )

			return TRUE
		else
			return FALSE
		ok

	def IsOfSubStringNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :OfSubString )

			return TRUE
		else
			return FALSE
		ok

	def IsInSubStringNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :InSubString )

			return TRUE
		else
			return FALSE
		ok

	def IsBetweenSubStringNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :BetweenSubString )

			return TRUE
		else
			return FALSE
		ok

	def IsBoundedBySubStringNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :BoundedBySubString )

			return TRUE
		else
			return FALSE
		ok

	def IsSubStringsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :SubStrings )

			return TRUE
		else
			return FALSE
		ok

	def IsTheseSubStringsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :TheseSubStrings )

			return TRUE

		else
			return FALSE
		ok

	def IsAndSubStringsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :AndSubStrings )

			return TRUE
		else
			return FALSE
		ok

	def IsOfSubStringsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :OfSubStrings )

			return TRUE
		else
			return FALSE
		ok

	def IsInSubStringsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :InSubStrings )

			return TRUE
		else
			return FALSE
		ok

	def IsBetweenSubStringsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :BetweenSubStrings )

			return TRUE
		else
			return FALSE
		ok

	def IsBoundedBySubStringsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :BoundedBySubStrings )

			return TRUE
		else
			return FALSE
		ok

	#--

	def IsBoundedByNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :BoundedBy )

			return TRUE
		else
			return FALSE
		ok

	def IsBoundedByXTNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :BoundedByXT )

			return TRUE
		else
			return FALSE
		ok


	def IsIsBoundedByNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :IsBoundedBy )

			return TRUE
		else
			return FALSE
		ok

	#--

	def IsSectionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :Section )

			return TRUE
		else
			return FALSE
		ok

	def IsThisSectionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :ThisSection )

			return TRUE
		else
			return FALSE
		ok

	def IsAndSectionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :AndSection )

			return TRUE
		else
			return FALSE
		ok

	def IsOfSectionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :OfSection )

			return TRUE
		else
			return FALSE
		ok

	def IsInSectionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :InSection )

			return TRUE
		else
			return FALSE
		ok

	def IsSectionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :Sections )

			return TRUE
		else
			return FALSE
		ok

	def IsTheseSectionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :TheseSections )

			return TRUE
		else
			return FALSE
		ok

	def IsAndSectionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :AndSections )

			return TRUE
		else
			return FALSE
		ok

	def IsOfSubSectionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :OfSections )

			return TRUE
		else
			return FALSE
		ok

	def IsInSectionsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and This[1] = :InSections )

			return TRUE
		else
			return FALSE
		ok

	def IsOfSizeNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :OfSize )

			return TRUE

		else
			return FALSE
		ok

	def IsSizeNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Size )

			return TRUE

		else
			return FALSE
		ok

	def IsDoNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Do )

			return TRUE

		else
			return FALSE
		ok

	def IsUntilNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Until )

			return TRUE

		else
			return FALSE
		ok

	def IsUntilPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :UntilPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsUntilXTNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :UntilXT )

			return TRUE

		else
			return FALSE
		ok

	def IsUptoNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :UpTo )

			return TRUE

		else
			return FALSE
		ok

	def IsUptoPositionNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :UpToPosition )

			return TRUE

		else
			return FALSE
		ok

	def IsUpToNNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :UpToN or This[1] = :UpToN@ ) )

			return TRUE

		else
			return FALSE
		ok



	def IsExpressionNamedParam()

		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and  This[1] = :Expression )

			return TRUE

		else
			return FALSE
		ok

	def IsLastSepNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :LastSep or This[1] = :LastSep@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsToEachNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :ToEach or This[1] = :ToEach@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsBeforeEachNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :BeforeEach or This[1] = :BeforeEach@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsAfterEachNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :AfterEach or This[1] = :AfterEach@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsToNthNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :ToNth or This[1] = :ToNth@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsToFirstNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :ToFirst or This[1] = :ToFirst@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsToLastNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :ToLast or This[1] = :ToLast@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsAfterNthNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :AfterNth or This[1] = :AfterNth@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsAfterFirstNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :AfterFirst or This[1] = :AfterFirst@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsAfterLastNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :AfterLast or This[1] = :AfterLast@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsBeforeNthNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :BeforeNth or This[1] = :BeforeNth@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsBeforeFirstNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :BeforeFirst or This[1] = :BeforeFirst@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsBeforeLastNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :BeforeLast or This[1] = :BeforeLast@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsAroundNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :Around or This[1] = :Around@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsAroundEachNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :AroundEach or This[1] = :AroundEach@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsAroundNthNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :AroundNth or This[1] = :AroundNth@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsAroundFirstNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :AroundFirst or This[1] = :AroundFirst@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsAroundLastNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :AroundLast or This[1] = :AroundLast@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsEachNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :Each or This[1] = :Each@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsFirstNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :First or This[1] = :First@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsLastNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :Last or This[1] = :Last@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsConcatenatedNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :Concatenated or This[1] = :Concatenated@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsConcatenatedUsingNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :ConcatenatedUsing or This[1] = :ConcatenatedUsing@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsConcatenatedWithNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :ConcatenatedWith or This[1] = :ConcatenatedWith@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsEachNCharsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :EachNChars or This[1] = :EachNChars@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsEachNItemsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :EachNItems or This[1] = :EachNItems@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsEachNStringsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :EachNStrings or This[1] = :EachNStrings@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsEachNNumbersNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :EachNNumbers or This[1] = :EachNNumbers@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsEachNListsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :EachNLists or This[1] = :EachNLists@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsEachNPairsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :EachNPairs or This[1] = :EachNPairs@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsEachNObjectsNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :EachNObjects or This[1] = :EachNObjects@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsGoingNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :Going or This[1] = :Going@ ) )

			return TRUE

		else
			return FALSE
		ok

	def IsSteppingNamedParam()
		if This.NumberOfItems() = 2 and
		   ( isString(This[1]) and
			(This[1] = :Stepping or This[1] = :Stepping@ ) )

			return TRUE

		else
			return FALSE
		ok

	  #===========#
	 #   MISC.   #
	#===========#

	def ToStzListOfChars()
		if NOT This.IsListOfChars()
			StzRaise("Can't cast the list into a stzListOfChars!")
		ok

		return new stzListOfChars( This.Content() )

	def FirstAndLastItems()
		aResult = [ This.FirstItem(), This.LastItem() ]
		return aResult

	def LastAndFirstItems()
		aResult = [ This.LastItem(), FirstItem() ]
		return aResult

	def ToListInStringInShortForm()
		cResult = This.ToCodeQ().ToListInShortForm()
		return cResult

		def ToListInShortForm()
			return This.ToListInStringInShortForm()

	#---------#
	#  WHERE  #
	#---------#

	def Where(pcCondition)
		/* EXAMPLE

		o1 = new stzList([ :StartingAt, 5 ])
		? o1.IsAPairQ().Where('{ isString(@pair[1]) and isNumber(@pair[2]) }')
		#--> TRUE

		o1 = new stzList([ "ONE", "TWO", "THREE" ])
		? o1.IsAPairQ().Where('{ Q(@Pair).AllItemsAre([ :Uppercase, :Strings ]) }')
		#--> FALSE

		*/

		if NOT isString(pcCondition)
			StzRaise("Incorrect param type! pcCondition must be a string.")
		ok

		cCondition = Q(pcCondition).
				TrimQ().
				RemoveBoundsQ(["{","}"]).
				ReplaceManyCSQ([ "@list", "@pair" ], "This", :CS = FALSE).
				Content()

		cCode = 'bOk = (' + cCondition + ')'

		eval(cCode)
		return bOk
