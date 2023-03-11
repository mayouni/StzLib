load "stzlib.ring"

/*--------------

pron()

? Q("SOFTANZA").Section(:From = "F", :To = "A") #--> "FTA"

? Q("SOFTANZA").CharsQ().Section(:From = "F", :To = "A")
#--> ["F", "T", "A"]

proff()

/*--------------

pron()

o1 = new stzString("1234567")

? o1.Section(3, 5)
#--> 345

? o1.Section(5, 3)
#--> 543

? o1.Section(3, -3)
#--> 345

? o1.Section(-3, 3)
#--> 543

? o1.Range(3, 3)
#--> 345

? o1.Range(3, -3)
#--> 123

? o1.Range(-5, -3)
#--> 123

proff()
# Executed in 0.04 second(s)

/*--------------
*/
pron()

o1 = new stzList([ "1", "2", "3", "4", "5", "6", "7" ])

? o1.Section(3, 5)
#--> [ "3", "4", "5" ]

? o1.Section(5, 3)
#--> [ "5", "4", "3" ]

? o1.Section(3, -3)
#--> [ "3", "4", "5" ]

? o1.Section(-3, 3)
#--> [ "5", "4", "3" ]

? o1.Range(3, 3)
#--> [ "3", "4", "5" ]

? o1.Range(3, -3)
#--> [ "1", "2", "3" ]

? o1.Range(-5, -3)
#--> [ "1", "2", "3" ]

proff()
# Executed in 0.02 second(s)

/*-----------

pron()

# Let's take this string of text:

o1 = new stzString("<<♥♥♥>>--<<stars>>--<<♥♥♥>>")

# You may want to get the section between two positions:

? o1.Between(3, 5)
#--> ♥♥♥

# You can also tell:
? o1.Section(3, 5)
#--> ♥♥♥
# But let's stick with the Between() function
# to see how it is flexible...

# Ok. What if you want to get all the substrings bounded by << and >>:
? o1.Between("<<", ">>")
#--> ["♥♥♥", "stars", "♥♥♥"]

# They are 3, 2 of them are the same! No worry, you can get
# a unique instance of each of them by extending the function
# name by the "U" letter (for Unique):

? o1.BetweenU("<<", ">>")
#--> ["♥♥♥", "stars"]

# Sometimes, people have different interpretations for the
# term BETWEEN, and they may want to have the strings inbetween
# along with the bounds themselves...

# You can do it simply by adding the IB extensions to the name
# of the fuction ("IB" for "Include Bounds")

? o1.BetweenIB("<<", ">>")
#--> [ "<<♥♥♥>>", "<<stars>>", "<<♥♥♥>>" ]

# Oh, great! But "<<♥♥♥>>" is repeated twice...
# Well, you know how to manage it: just add the "U" extension:

 ? o1.BetweenIBU("<<", ">>")
#--> [ "<<♥♥♥>>", "<<stars>>", "<<♥♥♥>>" ]

proff()
# Executed in 0.12 second(s)

/*-------- TODO:ERROR
pron()

? StzCharQ("0x10481").Content() #--> ERR, should be "𐒁"
/*
//? Q("Schöne Grüße").Length() # means "Kind Regards" in german
#--> 12

? StzUnicodeDataQ().CharByName("OSMANYA LETTER BA")
#--> 0x10481
#--> 66689

? StzCharQ("ҁ").Name()
#--> CYRILLIC SMALL LETTER KOPPA

? StzCharQ("𐒁") # TODO-ERROR
#--> Can't create char object!

? Q("𐒁").CharName() # TODO-ERROR: correct it to be OSMANYA LETTER BA
#--> QUESTION MARK

? StzCharQ("OSMANYA LETTER BA").Content()
#--> ҁ
*/
proff()

#------
/*
pron()

? Smile()
#--> 😆

? Heart()
#--> ♥

? Flower()
#--> ❀

? Sun()
#--> 🌞

? Moon()
#--> 🌔

? Handshake()
#--> 🤝

? Dot()
#--> •

? Tick()
#--> ✓

proff()

/*======== REMOVE XT

StartProfiler()
	
	o1 = new stzString("Ring programming♥ language")
	o1.RemoveXT("♥", :From = "programming♥")
	
	? o1.Content()
	#--> Ring programming language
	
StopProfiler()
# Executed in 0.02 second(s)
	
/*----------------
	
StartProfiler()
	
	o1 = new stzString("Ring *progr*amming* language")
	o1.RemoveXT( :Each = "*", :From = "*progr*amming*")
	
	? o1.Content()
	#--> Ring programming language
	
StopProfiler()
# Executed in 0.02 second(s)
	
/*----------------

StartProfiler()
	
	o1 = new stzString("Ring *progr*amming* language")
	o1.RemoveXT( :Nth = [ 2, "*" ], :From = "*progr*amming*")
	
	? o1.Content()
	#--> Ring *programming* language
	
StopProfiler()
# Executed in 0.02 second(s)
	
/*----------------

StartProfiler()
	
	o1 = new stzString("Ring *progr*amming* language")
	o1.RemoveXT( :First = "*", :From = "*progr*amming*")
	
	? o1.Content()
	#--> Ring progr*amming* language
	
StopProfiler()
# Executed in 0.02 second(s)
	
/*----------------

StartProfiler()
	
	o1 = new stzString("Ring *progr*amming* language")
	o1.RemoveXT( :Last = "*", :From = "*progr*amming*")
	
	? o1.Content()
	#--> Ring *progr*amming language
	
StopProfiler()
# Executed in 0.02 second(s)
	
/*----------------

StartProfiler()
	
	o1 = new stzString("Ring *progr*amming* language")
	o1.RemoveXT( :Nth = [ [1,3], "*" ], :From = "*progr*amming*")
	
	? o1.Content()
	#--> Ring progr*amming language
	
StopProfiler()
# Executed in 0.02 second(s)

/*==---------

StartProfiler()
	
	o1 = new stzString("programming*")
	o1.RemoveFromEnd("*")
	? o1.Content()
	#--> programming

StopProfiler()
# Executed in 0.01 second(s)

/*======== REMOVING AFTER

StartProfiler()
	
	Q("Ring programming* language.") {
	
		RemoveXT("*", :After = "programming")
		? Content()
		#--> Ring programming language.
	
	}
	
StopProfiler()
#--> Executed in 0.02 second(s)
	
/*-----------

StartProfiler()
	
	Q("__♥)__♥)__♥)__") {
	
		RemoveXT( ")", :AfterEach = "♥" ) # ... you can also say :After = "♥"
		? Content()
		#--> __♥__♥__♥__
	}
	
StopProfiler()
# Executed in 0.03 second(s)
	
/*-----------
	
StartProfiler()
	
	Q("__♥__♥)__♥__") {
	
		RemoveXT( ")", :AfterNth = [2, "♥"] )
		? Content()
		#--> __♥__♥__♥__
	
	}
	
StopProfiler()
# Executed in 0.03 second(s)
	
/*-----------------

StartProfiler()
	
	Q("__♥)__♥__♥__") {
	
		RemoveXT( ")", :AfterFirst = "♥" )
		? Content()
		#--> __♥__♥__♥__
	}
	
StopProfiler()
# Executed in 0.03 second(s)
	
/*-----------------

StartProfiler()
	
	Q("__♥__♥__♥)__") {
	
		RemoveXT( ")", :AfterLast = "♥" )
		? Content()
		#--> __♥__♥__♥__
	}
	
StopProfiler()
# Executed in 0.04 second(s)

/*========== REMOVING BEFORE

StartProfiler()
	
	Q("Ring ***programming language.") {
	
		RemoveXT("***", :Before = "programming")
		? Content()
		#--> Ring programming language.
	
	}
	
StopProfiler()
#--> Executed in 0.05 second(s)
	
/*-----------

StartProfiler()
	
	Q("__(♥__(♥__(♥__") {
	
		RemoveXT( "(", :BeforeEach = "♥" ) # ... you can also say :Before = "♥"
		? Content()
		#--> __♥__♥__♥__
	}
	
StopProfiler()
# Executed in 0.04 second(s)
	
/*-----------

StartProfiler()
	
	Q("__♥__(♥__♥__") {
	
		RemoveXT( "(", :BeforeNth = [2, "♥"] )
		? Content()
		#--> __♥__♥__♥__
	
	}
	
StopProfiler()
# Executed in 0.05 second(s)
	
/*-----------------
	
StartProfiler()
	
	Q("__(♥__♥__♥__") {
	
		RemoveXT( "(", :BeforeFirst = "♥" )
		? Content()
		#--> __♥__♥__♥__
	}
	
StopProfiler()
# Executed in 0.05 second(s)
	
/*-----------------

StartProfiler()
	
	Q("__♥__♥__(♥__") {
	
		RemoveXT( "(", :BeforeLast = "♥" )
		? Content()
		#--> __♥__♥__♥__
	}
	
StopProfiler()
# Executed in 0.05 second(s)
	
------- REMOVING AROUND

StartProfiler()
	
	Q("_-♥-_-♥-_-♥-_") {
	
		RemoveXT("-", :AroundEach = "♥") # Or simplt :Around
		? Content()
		#--> _♥_♥_♥_
	}
	
StopProfiler()
# Executed in 0.06 second(s)

/*-----------------

StartProfiler()
	
	Q("__/♥\__/♥\__/♥\__") {
	
		RemoveXT([ "/","\" ], :AroundEach = "♥") # or just :Around = "♥" if you want
		? Content()
		#--> __♥__♥__♥__
	}
	# Executed in 0.06 second(s)
	
StopProfiler()
# Executed in 0.06 second(s)

/*-----------------

StartProfiler()
	
	Q("__♥__/♥\__♥__") {

		RemoveXT([ "/","\" ], :AroundNth = [2, "♥"])
		? Content()
		#--> __♥__♥__♥__
	}
	
StopProfiler()
# Executed in 0.06 second(s)

/*-----------------

StartProfiler()
	
	Q("__/♥\__♥__♥__") {
	
		RemoveXT( [ "/","\" ], :AroundFirst = "♥" )
		? Content()
		#--> __♥__♥__♥__
	}
	
StopProfiler()
# Executed in 0.10 second(s)
	
/*-----------------

StartProfiler()
	
	Q("__♥__♥__/♥\__") {
	
		RemoveXT( [ "/","\" ], :AroundLast = "♥" )
		? Content()
		#--> __♥__♥__♥__
	}
	
StopProfiler()
# Executed in 0.11 second(s)

/*==------

StartProfiler()

o1 = new stzString("/♥♥♥\__/\/\__/♥♥♥\__")
? o1.FindThisBetweenAsSections("♥♥♥", "/", "\")	# FindXT( "♥", :Between = ["/","\"], :ReturnedAS = :Sections )
#--> [ [2, 14], [15, 17] )

StopProfiler()
# Executed in 0.02 second(s)

/*------

StartProfiler()

	o1 = new stzString("__/♥\__")

	o1.RemoveThisBetween("♥", "/", "\")
	? o1.Content()
	#--> __/\__

StopProfiler()
# Executed in 0.02 second(s)

/*---------

StartProfiler()

	o1 = new stzString("__/♥\__")

	o1.RemoveThisBetweenIB("♥", "/", "\") # ..XT() -> Bounds are also removed
	? o1.Content()
	#--> ____

StopProfiler()
# Executed in 0.02 second(s)

/*---------

StartProfiler()

	Q("/♥♥♥\__/\/\__/♥♥♥\__") {
		RemoveXT("♥♥♥", :Between = ["/", :And = "\"])
		? Content()
		#--> /\__/\/\__/\__
	}

StopProfiler()
# Executed in 0.08 second(s)

/*---------

StartProfiler()

	Q("__/\/\__/♥\__") {
		RemoveXT("♥", :BetweenIB = ["/", "\"]) # BetweenIB -> Bounds are also removed
		? Content()
		#--> __/\/\____
	}

StopProfiler()
# Executed in 0.07 second(s)

/*---------

StartProfiler()

	Q("__^^^__^^♥^^__") {
		RemoveXT("♥", :BoundedBy = "^^")
		? Content()
		#--> __^^^__^^^^__
	}

StopProfiler()
# Executed in 0.09 second(s)

/*---------

StartProfiler()

	Q("__/\/\__^^♥^^__") {
		RemoveXT("♥", :BoundedByIB = "^^")
		? Content()
		#--> __/\/\____
	}

StopProfiler()
# Executed in 0.09 second(s)

/*---------

StartProfiler()

	Q("__/\/\_^^♥^^_") {
		RemoveXT("♥", :BoundedByIB = "^^") # ..XT -> Bounds also removed
		? Content()
		#--> __/\/\__
	}

StopProfiler()
# Executed in 0.09 second(s)

/*---------

StartProfiler()

	Q("/♥^♥\__/♥\/vv\__/^^^\__") {
		RemoveXT([], :Between = ["/", :And = "\"])
		? Content()
		#--> /\__/\/\__/\__
	}

StopProfiler()
# Executed in 0.08 second(s)

/*---------

StartProfiler()

	Q("/♥^♥\__/♥\/vv\__/^^^\__") {
		RemoveXT([], :BetweenIB = ["/", :And = "\"]) # XT -> Bounds are also removed
		? Content()
		#--> ______
	}

StopProfiler()
# Executed in 0.08 second(s)

/*---------

StartProfiler()

	Q("/♥♥♥\__/♥\/♥♥\__/♥\__") {
		RemoveXT("♥", [])
		? Content()
		#--> /\__/\/\__/\__
	}

StopProfiler()
# Executed in 0.02 second(s)

/*---------

StartProfiler()

	Q("/♥♥♥\__/♥\/♥♥\__/♥\__") {
		RemoveXT([], "♥")
		? Content()
		#--> /\__/\/\__/\__
	}

StopProfiler()
# Executed in 0.02 second(s)

/*---------

StartProfiler()

	Q("_/♥\_/♥\_/♥♥\_/♥\_") {
		RemoveXT(:Nth = 4, "♥")
		? Content()
		#--> _/♥\_/♥\_/♥\_/♥\_
	}

StopProfiler()
# Executed in 0.02 second(s)

/*---------

StartProfiler()

	Q("_/♥\_/♥\_/♥♥\_/♥\_") {
		RemoveXT(:Nth = 4, "♥")
		? Content()
		#--> _/♥\_/♥\_/♥\_/♥\_
	}

StopProfiler()

/*---------
*/
StartProfiler()

? Q("^^♥♥♥^^").ContainsSubStringBoundedBy("♥♥♥", ["^^","^^"])

StopProfiler()

/*---------

StartProfiler()

? Q("^^♥^^").ContainsAt(3, "♥")
#--> TRUE

StopProfiler()
# Executed in 0.03 second(s)
 
/*---------
*/
StartProfiler()

? Q("^^♥♥♥^^").ContainsBetween("♥♥♥", 3, 5)
#--> TRUE

StopProfiler()
# Executed in 0.01 second(s)

/*---------

StartProfiler()

	Q("^^♥^^") {
		RemoveXT( "♥", :AtPosition = 3)
		? Content()
		#--> ^^^^
	}

StopProfiler()
# Executed in 0.03 second(s)

/*==================

StartProfiler()

o1 = new stzString("__♥♥♥__/♥♥♥\__♥♥♥__")
? o1.FindNthAsSection(2, "♥♥♥")
#--> [9, 11]

StopProfiler()

/*-----------------

StartProfiler()

o1 = new stzString("__♥♥♥__/♥♥♥\__♥♥♥__")

? o1.Enclose(
	:Section = o1.FindNthAsSection(2, "♥♥♥"),

	:AndYield = [
		:NCharsBefore = 3,
		:NCharsAfter  = 3
	]
)
#--> [ "__/", "\__" ]

StopProfiler()
# Executed in 0.04

/*========= CHECKING BOUNDS - XT
	
StartProfiler()
		
	o1 = new stzString("♥")
	? o1.IsBoundedByIB("-", :In = "...-♥-...") # You can use :Inside instead of :In
	#--> TRUE
	
	? o1.IsBoundedByIB(["/", "\"], :InSide = "__/♥\__")
	#--> TRUE
		
	? o1.IsBetweenIB(["/", "\"], :InSide = "__/♥\__")
	#--> TRUE
	
	? o1.IsBetweenIB(["/", :And = "\"], :InSide = "__/♥\__")
	#--> TRUE
	
StopProfiler()
# Executed in 0.20 second(s)

/*====  FINDING SUBSTRING, BASIC & EXTENDED

StartProfiler()

	o1 = new stzListOfStrings([
		"What's your name please?",
		"Mabrooka!",
		"Your name and my name are not the same...",
		"I see.",
		"Nice to meet you,",
		"Mabrooka!"
	])
	
	? @@S( o1.FindSubString("name") )
	#--> [ [ 1, [ 13 ] ], [ 3, [6, 18 ] ] ]

	? @@S( o1.FindSubstringXT("name") )
	#--> [ [ 1, 13 ], [ 3, 6 ], [ 3, 18 ] ]

StopProfiler()
# Executed in 0.04 second(s)

/*========== CHECKING CONTAINMENT

StartProfiler()
	
	? Q("\__♥__/").Contains("♥")
	#--> TRUE
	
	? Q("\__♥__/").ContainsMany("_") # Or .ContainsMoreThenOne("_")
	#--> TRUE
	
	? Q("\__♥__/").ContainsThese(["_","♥"])
	#--> TRUE
	
	? Q("\__♥__/").IsMadeOf(["\", "_", "♥", "/" ])
	#--> TRUE
	
StopProfiler()
# Executed in 0.04 second(s)

/*======== CHECKING CONTAINMENT - EXTENDED

StartProfiler()

	? Q("__♥__").ContainsXT("♥", "_")
	#--> TRUE

	? Q("__♥__♥__").ContainsXT(2, "♥")
	#--> TRUE

	? Q("__♥__").ContainsXT("♥", [])
	#--> TRUE

	? Q("_-♥-_").ContainsXT("♥", :BoundedBy = "-")
	#--> TRUE

	? Q("_/♥\_").ContainsXT("♥", :Between = ["/", :And = "\"])
	#--> TRUE

	? Q("__-♥-__").ContainsXT(["_", "-", "♥"], [])
	#--> TRUE

	? Q("__-♥-__-•-__").ContainsXT(["♥", "•"], :BoundedBy = "-")
	#--> TRUE
	
	? Q("__/♥\__/•\__").ContainsXT(["♥", "•"], :Between = ["/", :And = "\"])
	#--> TRUE

	? Q("__♥__").ContainsXT([], "♥")
	#--> TRUE

	? Q("__/♥\__/^^^\__").ContainsXT( [], :BoundedBy = ["/", :And = "\"] )
	#--> TRUE

	? Q("__/♥\__/^^\__").ContainsXT( [], :Between = ["/", "\"] )	
	#--> TRUE

StopProfiler()
# Executed in 0.04 second(s)

/*----------

StartProfiler()

	? Q("").ContainsXT(:Chars, []) # You can use NULL or FALSE instead of []
	#--> FALSE
	? Q("").ContainsXT([], :Chars) # You can use NULL or FALSE instead of []
	#--> FALSE

	? Q("__-♥-__").ContainsXT(:Chars, ["_", "-"])
	#--> TRUE
	? Q("__-♥-__").ContainsXT(:TheseChars, ["♥", "-"])
	#--> TRUE

	? Q("__-♥-__").ContainsXT(:SomeOfTheseChars, ["_", "-", "_"])
	#--> TRUE

	? Q("__-♥-__").ContainsXT(:OneOfTheseChars, ["A", "♥", "B"])
	#--> TRUE
	? Q("__-♥-__").ContainsXT(:NoneOfTheseChars, ["A", "*", "B"])
	#--> TRUE

	? Q("__---_^_").ContainsXT(:CharsWhere, '@charQ.IsEither("A", :Or = "^")' )
	#--> TRUE
	? Q("__---__").ContainsXT(:CharsW, '@charQ.IsEither("_", :Or = "-")')
	#--> TRUE
	? Q("__---__").ContainsXT(:Chars, :Where = '@charQ.IsEither("_", :Or = "-")')
	#--> TRUE
	? Q("__---__").ContainsXT(:Chars, Where('@charQ.IsEither("_", :Or = "-")'))
	#--> TRUE
	? Q("__---__").ContainsXT(:Chars, W('@charQ.IsEither("_", :Or = "-")'))
	#--> TRUE

StopProfiler()
# Executed in 0.58 second(s)

/*------

StartProfiler()
	
	? Q("_softanza_loves_ring_").ContainsXT(:SubStrings, ["softanza", "ring"])
	#--> TRUE
	? Q("_softanza_loves_ring_").ContainsXT(:TheseSubStrings, ["softanza", "ring"])
	#--> TRUE

	? Q("_softanza_loves_ring_").ContainsXT(:SomeOfTheseSubStrings, ["ring", "php", "softanza"])
	#--> TRUE
	? Q("_softanza_loves_ring_").ContainsXT(:SomeOfThese, ["ring", "php", "softanza"])
	#--> TRUE

	? Q("_softanza_loves_ring_").ContainsXT(:OneOfTheseSubStrings, ["python", "php", "ring"])
	#--> TRUE
	? Q("_softanza_loves_ring_").ContainsXT(:OneOfThese, ["python", "php", "ring"])
	#--> TRUE

	? Q("_softanza_loves_ring_").ContainsXT(:NoneOfTheseSubStrings, ["python", "php", "ruby"])
	#--> TRUE
	? Q("_softanza_loves_ring_").ContainsXT(:NoneOfThese, ["python", "php", "ruby"])
	#--> TRUE

	? Q("_softanza_LOVES_ring_").ContainsXT(:SubStringsWhere, '@SubStringQ.IsUppercase()')
	#--> TRUE
	? Q("_softanza_LOVES_ring_").ContainsXT(:SubStringsW, '@SubStringQ.IsUppercase()')
	#--> TRUE
	? Q("_softanza_LOVES_ring_").ContainsXT(:SubStringsW, :Where = '@SubStringQ.IsUppercase()')
	#--> TRUE
	? Q("_softanza_LOVES_ring_").ContainsXT(:SubStringsW, Where('@SubStringQ.IsUppercase()') )
	#--> TRUE
	? Q("_softanza_LOVES_ring_").ContainsXT(:SubStringsW, W('@SubStringQ.IsUppercase()') )
	#--> TRUE

StopProfiler()

/*======== USING ADDXT() - EXTENDED

	StartProfiler()
	
	Q("Ring programmin guage.") {
	
		AddXT("g", :After = "programmin") # You can use :To instead of :After
		? Content()
		#--> Ring programming guage.
	
	}
	
	StopProfiler()
	#--> Executed in 0.02 second(s)
	
/*-----------

	StartProfiler()
	
	Q("__(♥__(♥__(♥__") {
	
		AddXT( ")", :AfterEach = "♥" ) # ... you can also say :After = "♥"
		? Content()
		#--> __(♥)__(♥)__(♥)__
	}
	
	StopProfiler()
	# Executed in 0.02 second(s)

/*-----------

	StartProfiler()
	
	Q("__♥__(♥__♥__") {
	
		AddXT( ")", :AfterNth = [2, "♥"] )
		? Content()
		#--> __♥__(♥)__♥__
	}
	
	StopProfiler()
	# Executed in 0.03 second(s)

/*-----------------

	StartProfiler()
	
	Q("__(♥__♥__♥__") {
	
		AddXT( ")", :AfterFirst = "♥" ) # ... or :ToFirst
		? Content()
		#--> __♥__(♥)__♥__
	}
	
	StopProfiler()
	# Executed in 0.04 second(s)
	
/*-----------------

	StartProfiler()
	
	Q("__♥__♥__(♥__") {
	
		AddXT( ")", :AfterLast = "♥" ) # ... or :ToLast
		? Content()
		#--> __♥__♥__(♥)__
	}
	
	StopProfiler()
	# Executed in 0.04 second(s)

/*===------------

	StartProfiler()
	
	Q("Ring programming guage.") {	
		AddXT("lan", :Before = "guage")
		? Content()
		#--> Ring programming language.
	}
	
	StopProfiler()
	# Executed in 0.04 second(s)

/*---------

	StartProfiler()
	
	Q("__♥)__♥)__♥)__") {
	
		AddXT( "(", :BeforeEach = "♥" ) # ... you can also say :Before = "♥"
		? Content()
		#--> __(♥)__(♥)__(♥)__
	}
	
	StopProfiler()
	# Executed in 0.02 second(s)

/*---------

	StartProfiler()
	
	Q("__♥__♥)__♥__") {
	
		AddXT( "(", :BeforeNth = [2, "♥"] )
		? Content()
		#--> __♥__(♥)__♥__
	}
	
	StopProfiler()
	# Executed in 0.05 second(s)

/*---------

	StartProfiler()
	
	Q("__♥)__♥__♥__") {
	
		AddXT( "(", :BeforeFirst = "♥" )
		? Content()
		#--> __(♥)__♥__♥__
	}
	
	StopProfiler()
	# Executed in 0.04 second(s)

/*---------

	StartProfiler()
	
	Q("__♥__♥__♥)__") {
	
		AddXT( "(", :BeforeLast = "♥" )
		? Content()
		#--> __♥__♥__(♥)__
	}
	
	StopProfiler()
	# Executed in 0.05 second(s)

/*===------------

	StartProfiler()
	
	Q("__♥__♥__♥__") {
	
		AddXT(" ", :AroundEach = "♥")
		? Content()
		#--> __ ♥ __ ♥ __ ♥ __
	}
	
	StopProfiler()
	# Executed in 0.06 second(s)

/*-----------------
*/
	StartProfiler()
	
	Q("__♥__♥__♥__") {
	
		AddXT([ "/","\" ], :AroundEach = "♥") # ... or just :Around = "♥" if you want
		? Content()
		#--> __/♥\__/♥\__/♥\__
	}
	# Executed in 0.06 second(s)
	
	StopProfiler()

/*-----------------

	StartProfiler()
	
	Q("__♥__♥__♥__") {
	
		AddXT([ "/","\" ], :AroundNth = [2, "♥"])
		? Content()
		#--> __♥__/♥\__♥__
	}
	
	StopProfiler()
	# Executed in 0.06 second(s)


/*-----------------

	StartProfiler()
	
	Q("__♥__/♥\__/♥\__") {
	
		AddXT( [ "/","\" ], :AroundFirst = "♥" )
		? Content()
		#--> __/♥\__/♥\__/♥\__
	}
	
	StopProfiler()
	# Executed in 0.06 second(s)

/*-----------------

	StartProfiler()
	
	Q("__/♥\__/♥\__♥__") {
	
		AddXT( [ "/","\" ], :AroundLast = "♥" )
		? Content()
		#--> __/♥\__/♥\__/♥\__
	}
	
	StopProfiler()
	# Executed in 0.07 second(s)

