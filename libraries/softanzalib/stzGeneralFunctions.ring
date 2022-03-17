
_cSoftanzaLogo =
'
╭━━━┳━━━┳━━━┳━━━━┳━━━┳━╮╱╭┳━━━━┳━━━╮
┃╭━╮┃╭━╮┃╭━━┫╭╮╭╮┃╭━╮┃┃╰╮┃┣━━╮━┃╭━╮┃
┃╰━━┫┃╱┃┃╰━━╋╯┃┃╰┫┃╱┃┃╭╮╰╯┃╱╭╯╭┫┃╱┃┃
╰━━╮┃┃╱┃┃╭━━╯╱┃┃╱┃╰━╯┃┃╰╮┃┃╭╯╭╯┃╰━╯┃
┃╰━╯┃╰━╯┃┃╱╱╱╱┃┃╱┃╭━╮┃┃╱┃┃┣╯━╰━┫╭━╮┃
╰━━━┻━━━┻╯╱╱╱╱╰╯╱╰╯╱╰┻╯╱╰━┻━━━━┻╯╱╰━

Programming, by Heart! By: M.Ayouni╭
━━╮╭━━━━━━━━━━━━━━━━━━━━╮╱╭━━━━━━━━╯
  ╰╯
'
	
func SoftanzaLogo()
	return _cSoftanzaLogo

func stzRaise(paMessage)

	if NOT (isString(paMessage) or isList(paMessage) )

		stzRaise("Error in stzRaise param type!")
	ok

	if isString(paMessage)
		stzRaise(paMessage)
	ok

	if isList(paMessage) and StzListQ(paMessage).IsRaiseParamList()
		cWhere = paMessage[ :Where ]
		cWhat  = paMessage[ :What   ]
		cWhy   = paMessage[ :Why    ]
		cTodo  = paMessage[ :Todo   ]

	

		if NOT StzListQ([ cWhere, cWhat, cWhy, cTodo ]).IsListOfStrings()
			stzRaise("Error in stzRaise param type!")
		ok
	
		cFile = StzStringQ(cWhere).WithoutSpaces()
		if isNull(cWhere)
			stzRaise("Error in stzRaise --> Where the error happened!")
		ok
	
		cWhat = StzStringQ(cWhat).Simplified()
		cwhay = StzStringQ(cWhy).Simplified()
		cTodo = StzStringQ(cTodo).Simplified()
	
		cErrorMsg = "in file " + paMessage[:Where] + ":" + NL
	
		if cWhat != NULL
			cErrorMsg += "   What : " + paMessage[:What] + NL
		ok
	
		if cWhy != NULL
			cErrorMsg += "   Why  : " + paMessage[:Why]  + NL
		ok
	
		if cTodo != NULL
			cErrorMsg += "   Todo : " + paMessage[:Todo] + NL
		ok

		stzRaise(cErrorMsg)
	else
		stzRaise("Error in stzRaise > Incorrect param type!")
	ok

func IsNumberOrString(p)
	if isNumber(p) or isString(p)
		return TRUE
		else
		return FALSE
	ok

	func IsStringOrNumber(p)
		return func IsNumberOrString(p)

func IsNumberOrList(p)
	if isNumber(p) or isList(p)
		return TRUE
		else
		return FALSE
	ok

	func IsListOrNumber(p)
		return This.IsNumberOrList(p)

func IsNumberOrObject(p)
	if isNumber(p) or isObject(p)
		return TRUE
		else
		return FALSE
	ok

	func IsObjectOrNumber(p)
		return This.IsNumberOrObject(p)

func IsStringOrList(p)
	if isString(p) or isList(p)
		return TRUE
	else
		return FALSE
	ok

	def IsListOrString(p)
		return IsStringOrList(p)

func IsStringOrObject(p)
	if isString(p) or isObject(p)
		return TRUE
		else
		return FALSE
	ok

	def IsObjectOrString(p)
		return IsStringOrObject(p)

func IsListOrObject(p)
	if isList(p) or isObject(p)
		return TRUE
		else
		return FALSE
	ok

func ListOfListsOfStzTypes() # TODO: complete the list
	return [
		:ListOfStzNumbers,
		:ListOfStzStrings,
		:ListOfStzLists,
		:ListOfStzObjects,
		:ListOfStzChars,
		:ListOfStzHashlists,
		:ListOfStzPairs,
		:ListOfStzSets,
		:ListOfStzGrids
	]

func InfereDataTypeFromString(pcStr)

	pcStr = _(pcStr).Q.Lowercased()

	if  _(pcStr).Q.BeginsWith("listsofstz")
		pcStr = _(pcStr).Q.ReplaceFirstOccurrenceQ("listsofstz", :With = "listofstz").Content()

	but _(pcStr).Q.BeginsWith("listsof")
		pcStr = _(pcStr).Q.ReplaceFirstOccurrenceQ("listsof", :With = "listof").Content()

	but _(pcStr).Q.BeginsWith("stzlistsof")
		pcStr = _(pcStr).Q.ReplaceFirstOccurrenceQ("stzlistsof", :With = "stzlistof").Content()

	ok

	if StringIsStzClassName(pcStr) or
	   StringIsStzClassName(pcStr) or
	   StringIsStzClassName("stz" + pcStr)

		return pcStr

	ok

	if StringIsStzClassName( Q(pcStr).LastCharRemovedW('@char = "s"') ) or
	   StringIsStzClassName( Q(pcStr).LastCharRemovedW('@char = "s"') )

		return Q(pcStr).LastCharRemovedW('@char = "s"')

	ok

	if Q(pcStr).IsOneOfThese( StzClasses() )
		return pcStr
	ok


	func InfereTypeFromString(pcStr)
		return InfereDataTypeFromString(pcStr)

func DataType(p)
	return lower(type(p))


# DO TWO VARIABLES HAVE SAME TYPE

func BothAreNumbers(p1, p2)
	if isNumber(p1) and isNumber(p2)
		return TRUE
	else
		return FALSE
	ok

	func AreBothNumbers(p1, p2)
		return BothAreNumbers(p1, p2)

func BothAreStzNumbers(p1, p2)
	if IsStzNumber(p1) and IsStzNumber(p2)
		return TRUE
	else
		return FALSE
	ok

	func AreBothStzNumbers(p1, p2)
		return BothAreStzNumbers(p1, p2)

func BothAreStrings(p1, p2)
	if isString(p1) and isString(p2)
		return TRUE
	else
		return FALSE
	ok

	func AreBothStrings(p1, p2)
		return BothAreStrings(p1, p2)

func BothAreStzStrings(p1, p2)
	if IsStzString(p1) and IsStzString(p2)
		return TRUE
	else
		return FALSE
	ok

	func AreBothStzStrings(p1, p2)
		return BothAreStzStrings(p1, p2)

func BothAreLists(p1, p2)
	if isList(p1) and isList(p2)
		return TRUE
	else
		return FALSE
	ok

	func AreBothLists(p1, p2)
		return BothAreLists(p1, p2)

func BothAreStzLists(p1, p2)
	if IsStzList(p1) and IsStzList(p2)
		return TRUE
	else
		return FALSE
	ok

	func AreBothStzLists()
		return BothAreStzLists()

func BothAreObjects(p1, p2)
	if isObject(p1) and isObject(p2)
		return TRUE
	else
		return FALSE
	ok

	func AreBothObjects(p1, p2)
		return BothAreObjects(p1, p2)

func BothAreStzObjects(p1, p2)
	if IsStzObject(p1) and IsStzObject(p2)
		return TRUE
	else
		return FALSE
	ok

	func AreBothStzObjects(p1, p2)
		return BothAreStzObjects(p1, p2)

# 'SAMEBILITY" OF TWO OBJECTS

func AreSameObject(pcObjectName1, pcObjectName2) # TODO
	return StzObjectQ(pcObjectName1).IsEqualTo( pcObjectName2 )

# OTHER STAFF

func IsRingType(pcString)
	return StzStringQ(pcString).LowercaseQ().ExistsIn( RingTypes() )

	def IsRingDataType(pcString)
		return IsRingType(pcString)

func StringIsStzClassName(pcString)
	return StzStringQ(pcString).IsStzClassName()

func StringIsChar(pcStr)
	oStzString = new stzString(pcStr)
	return oStzString.IsChar()

func CharIsLetter(pcStr)
	oStzChar = new stzChar(pcStr)
	return oStzChar.IsLetter()

/*
The following two functions ( IsTrue() and IsFalse() ) are made
to simplify code like this:

	def StartsWithCS(pcSubStr, pCaseSensitive)
		bResult = TRUE

		if pCaseSensitive = TRUE
			// do this
		else
			// do that
		ok

So it becomes wrtitten more expressively like this:

	def StartsWithCS(pcSubStr, pCaseSensitive)
		bResult = TRUE

		if IsTrue(pCaseSensitive)
			// do this
		else
			// do that
		ok

*/
func IsTrue(p)
	if isNumber(p) and p = 1
		return TRUE
	ok

	if isList(p) and len(p) = 2 and isString(p[1]) and p[2] = TRUE
		return TRUE
	ok

	# else

	return FALSE

func IsFalse(p)
	if isNumber(p) and p = 0
		return TRUE
	ok

	if isList(p) and len(p) = 2 and isString(p[1]) and p[2] = FALSE
		return TRUE
	ok

	# else

	return FALSE

func StzLen(p)
	if isString(p)
		return StzStringQ(p).NumberOfChars()

	but IsStzString(p)
		return p.NumberOfChars()

	but isList(p)
		return len(p)

	but IsStzList(p)
		return p.NumberOfItems()

	else
		stzRaise("Unsupported parameter type!")
	ok

func Unicode(p)

	if isString(p) and StringIsChar(p)
		return CharUnicode(p)

	but isString(p)
		return StringUnicodes(p)

	but isList(p) and ListIsListOfChars(p)
		return CharsUnicodes(p)

	but isList(p) and ListIsListOfStrings(p)
		return StringsUnicodes(p)

	else
		stzRaise("Incorrect param type!")
	ok

	#< @FunctionAlternativeForm

	func Unicodes(p)
		return Unicode(p)

	#>

func Scripts(paListStr)
	return StzListOfStringsQ(paListStr).Scripts()

func ComputableForm(pValue) # TODO: case of object --> return its name

	if isNumber(pValue)
		return pValue

	but isString(pValue)
		return '"' + pValue + '"'

	but isList(pValue)
		return ListToCode(pValue)
	ok

	func @@(pValue)
		return ComputableForm(pValue)

	func C@(pValue)
		return ComputableForm(pValue)

	func CF(pValue)
		return ComputableForm(pValue)

func YaAllah()
	return "يَا أَلله"

func YaMuhammed()
	return "يا مُحَمَّدْ"
