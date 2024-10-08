
func IsQChar(p)
	if isObject(p) and classname(p) = "qchar"
		return TRUE
	else
		return FALSE
	ok

	#< @fUNCtionAlternativeForms

	func IsQCharObject(p)
		return IsQChar(p)

	func @IsQChar(p)
		return This.IsQChar(p)

	func @IsQCharObject(p)
		return IsQChar(p)

	#--

	func IsAQChar(p)
		return IsQChar(p)

	func IsAQCharObject(p)
		return IsQChar(p)

	func @IsAQChar(p)
		return This.IsQChar(p)

	func @IsAQCharObject(p)
		return IsQChar(p)

	#>

func QCharToString(oQChar)
	if IsQChar(oQChar)
		oChar = new stzChar(oQChar.unicode())
		return oChar.Content()
	else
		StzRaise(stzCharError(:CanNotTransformQCharToString))
	ok

func StringToQChar(c)
	oChar = new stzChar(c)
	return oChar.QCharObject()

func QCharToStzChar(oQchar)
	return new stzChar(QCharToString(oQChar))

func StzCharToQChar(oChar)
	return oQChar.QCharObject()

func QCharToQString(oQChar)
	oQStr = new QString2()
	oQStr.append_2(oQChar)
	return oQStr

func QCharToStzString(oQChar)
	oQStr = QCharToQString(oQChar)
	cStr = oQStr.NLeftChars(oQStr.count())
	oStzStr = new stzString(cStr)
	return oStzStr

#---

func IsQByteArray(p)
	if isObject(p) and classname(p) = :QByteArray
		return TRUE
	else
		return FALSE
	ok

	#< @functionAlternativeForms

	func IsQByteArrayObject(p)
		return IsQByteArray(p)

	func @IsQByteArray(p)
		return IsQByteArray(p)

	func @IsQByteArrayObject(p)
		return IsQByteArray(p)

	#--

	func IsAQByteArray(p)
		return IsQByteArray(p)

	func IsAQByteArrayObject(p)
		return IsQByteArray(p)

	func @IsAQByteArray(p)
		return IsQByteArray(p)

	func @IsAQByteArrayObject(p)
		return IsQByteArray(p)

	#>

func ToQByteArray(p)
	if IsListOfBytes(p)
		if IsQByteArrayObject(p)
			return p

		but isString(p)
			oQByteArray = new QByteArray()
			oQByteArray.append(p)
			return oQByteArray

		but @IsStzString(p)
			oQByteArray = new QByteArray()
			oQByteArray.append(p.Content())
			return oQByteArray

		but @IsStzListOfBytes(p)
			return p.QByteArrayObject()

		ok
	ok

	func ToQByteArrayObject(p)
		return ToQByteArray(p)

func QByteArrayToListOfUnicodes(oQByteArray)
	if IsQByteArrayObject(oQByteArray)
		return StzStringQ(oQByteArray.data()).Unicodes()
	else
		StzRaise(stzListOfBytesError(:CanNotConvertQByteArray))
	ok

	func QByteArrayObjectToListOfUnicodes(oQByteArray)
		return QByteArrayToListOfUnicodes(oQByteArray)

	#--

	func QByteArrayToListOfBytecodes(oQByteArray)
		return QByteArrayToListOfUnicodes(oQByteArray)

	func QByteArrayObjectToListOfBytecodes(oQByteArray)
		return QByteArrayToListOfUnicodes(oQByteArray)

func QByteArrayToListOfChars(oQByteArray)
	/*
	Can also be solved like this:
	oString = new stzString(oQByteArray.data())
	return oString.ToListOfChars()
	*/

	oListOfBytes = new stzListOfBytes(oQByteArray)
	return oListOfBytes.ToStzString().Chars()

	func QByteArrayObjectToListOfChars(oQByteArray)
		return QByteArrayToListOfChars(oQByteArray)

func QByteArrayToListOfUnicodesPerChar(oQByteArray)
	oListOfBytes = new stzListOfBytes(oQByteArray)
	return oListOfBytes.UnicodesPerChar()

	func QByteArrayObjectToListOfUnicodesPerChar(oQByteArray)
		return QByteArrayToListOfUnicodesPerChar(oQByteArray)
	
	#--

	func QByteArrayToListOfBytecodesPerChar(oQByteArray)
		return QByteArrayToListOfUnicodesPerChar(oQByteArray)

	func QByteArrayObjectToListOfBytecodesPerChar(oQByteArray)
		return QByteArrayToListOfUnicodesPerChar(oQByteArray)

#---

func IsQStringList(p)
	if isObject(p) and classname(p) = "qstringlist"
		return TRUE
	else
		return FALSE
	ok

	func IsQStringListObject(p)
		return IsQStringList(p)

	func IsAQStringList(p)
		return IsQStringList(p)

	func IsAQStringListObject(p)
		return IsQStringList(p)

func QStringListToList(oQStrList)
	if NOT IsQStringList(oQStrList)
		StzRaise(stzListOfStringsError(:CanNotTransformQStringListToRingList))
	ok

	aResult = []
	for i = 0 to oQStrList.size()-1
		aResult + oQStrList.at(i)	
	next

	return aResult

	#< @FunctionAlternativeForms

	func QStringListObjectToList(oQStrList)
		return QStringListToList(oQStrList)

	func QStringListContent(oQStrList)
		return QStringListToList(oQStrList)

	func QStringListObjectContent(oQStrList)
		return QStringListToList(oQStrList)

	func QStringListToRingList(oQStrList)
		return QStringListToList(oQStrList)

	func QStringListObjectToRingList(oQStrList)
		return QStringListToList(oQStrList)

	#>

func QStringListToStzListOfStrings(oQStrList)
	return new stzListOfStrings(QStringListToList(oQStrList))

	func QStringListObjectToStzListOfStrings(oQStrList)
		return QStringListToStzListOfStrings(oQStrList)

#---

func IsQLocale(p)
	if isObject(p) and classname(p) = "qlocale"
		return TRUE
	else
		return FALSE
	ok

	func IsQLocaleObject(p)
		return IsQLocale(p)

	func IsAQLocale(p)
		return IsQLocale(p)

	func IsAQLocaleObject(p)
		return IsQLocale(p)

	#--

	func @IsQLocale(p)
		return IsQLocale(p)

	func @IsQLocaleObject(p)
		return IsQLocale(p)

	func @IsAQLocale(p)
		return IsQLocale(p)

	func @IsAQLocaleObject(p)
		return IsQLocale(p)

	#>

func QLocaleToStzLocale(oQLocale)
	return new stzLocale(oQLocale)

	func QLocaleObjectToStzLoclae(QLocale)

func StzLocaleToQLocale(oLocale)
	return oLocale.QLocaleObject()

	func StzLoclaeToQLocaleObject(oLocale)
		return StzLocaleToQLocale(oLocale)

func SystemLocale() # Returned as a string
	oQLocale = new QLocale("C")
	return oQLocale.system()

	func SystemLocaleAbbreviation()
		return SystemLocale()

#---

func IsQString(p)

	if isObject(p) and ( classname(p) = "qstring" or classname(p) = "qstring2" )
		return TRUE
	else
		return FALSE
	ok

	#< @functionAlternativeForms

	func IsQStringObject(p)
		return IsQString(p)

	func @IsQString(p)
		return IsQString(p)

	func @IsQStringObject(p)
		return IsQString(p)

	#--

	func IsAQString(p)
		return IsQString(p)

	func IsAQStringObject(p)
		return IsQString(p)

	func @IsAQString(p)
		return IsQString(p)

	func @IsAQStringObject(p)
		return IsQString(p)

	#>

func QStringContent(oQStr)

	if IsQString(oQStr)
		return oQStr.left(oQStr.count())

	else
		stzRaise(stzStringError(:CanNotTransformQStringToString))
	ok

	#--

	func QStringObjectContent(oQStr)
		return QStringContent(oQStr)

	func QStringToString(oQStr)
		return QStringContent(oQStr)

	func QStringObjectToString(oQStr)
		return QStringContent(oQStr)

	#--

	func @QStringObjectContent(oQStr)
		return QStringContent(oQStr)

	func @QStringToString(oQStr)
		return QStringContent(oQStr)

	func @QStringObjectToString(oQStr)
		return QStringContent(oQStr)

func StringToQStringObject(str)
	if CheckParams()
		if NOT isString(str)
			StzRaise("Incorrect param type! str must be a string.")
		ok
	ok

	oQStr = new QString2()
	oQStr.append(str)

	return oQStr

	func StringToQString(str)
		return StringToQStringObject(str)

	func ToQStringObject(str)
		return StringToQStringObject(str)

	func ToQString(str)
		return StringToQStringObject(str)

	func @ToQStringObject(str)
		return StringToQStringObject(str)

	func @ToQString(str)
		return StringToQStringObject(str)

	func QStringObject(str)
		return StringToQStringObject(str)

	func @QStringObject(str)
		return StringToQStringObject(str)

	func QStringObjectQ(str)
		return StringToQStringObject(str)

	func @QStringObjectQ(str)
		return StringToQStringObject(str)

func QStringToStzString(oQString)
	return new stzString(QStringToString(oQString))

	func QStringObjectToStzString(oQString)
		return QStringToStzString(oQString)

#---

func IsQTime(p)
	if isObject(p) and classname(p) = "qtime"
		return TRUE
	else
		return FALSE
	ok

	#< @FunctionAlternativeForms

	func IsQTimeObject(p)
		return IsQTime(p)

	func IsAQTime(p)
		return IsQTime(p)

	func IsAQTimeObject(p)
		return IsQTime(p)

	#--

	func @IsQTime(p)
		return IsQTime(p)

	func @IsQTimeObject(p)
		return IsQTime(p)

	func @IsAQTime(p)
		return IsQTime(p)

	func @IsAQTimeObject(p)
		return IsQTime(p)

	#>

func QTimeToString(oQTime, cFormat)
	if IsQTime(oQTime)
		return oQTime.ToString(cFormat)
	else
		StzRaise(stzTimeError(:CanNotTransformQTimeToString))
	ok

	func QTimeObjectToString(oQTime, cFormat)
		return QTimeToString(oQTime, cFormat)

#---

func IsQObject(p)
	if not isObject(p)
		return FALSE
	ok

	return StzStringQ( classname(p) ).ExistsIn( RingQtClasses() )

	#< @FunctionAlternativeForms

	func IsQtObject(p)
		return IsQObject(p)

	func ObjectIsQObject(p)
		return IsQObject(p)

	func ObjectisQtObject(p)
		return IsQObject(p)

	#--

	func @IsQObject(p)
		return IsQObject(p)

	func @IsQtObject(p)
		return IsQObject(p)

	func @ObjectIsQObject(p)
		return IsQObject(p)

	func @ObjectisQtObject(p)
		return IsQObject(p)

	#==

	func IsAQObject(p)
		return IsQObject(p)

	func IsAQtObject(p)
		return IsQObject(p)

	func ObjectIsAQObject(p)
		return IsQObject(p)

	func ObjectIsAQtObject(p)
		return IsQObject(p)

	#--

	func @IsAQObject(p)
		return IsQObject(p)

	func @IsAQtObject(p)
		return IsQObject(p)

	func @ObjectIsAQObject(p)
		return IsQObject(p)

	func @ObjectisAQtObject(p)
		return IsQObject(p)

	#>
