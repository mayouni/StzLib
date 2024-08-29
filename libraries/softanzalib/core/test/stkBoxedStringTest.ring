load "../string/stkBoxedString.ring"
load "../string/stkStringArt.ring"

decimals(3)
t0 = clock()

? BoxedString( StringArt("MAHMOUD") ) + NL

#~~~~~~

? BoxedString("Hello, Ring!")
#-->
'
╭──────────────╮
│ Hello, Ring! │
╰──────────────╯
'

? BoxedString("Hello, World!") 
#-->
'
╭───────────────╮
│ Hello, World! │
╰───────────────╯
'

? BoxedString("This is a
multi-line
string example.")
#-->
'
╭─────────────────╮
│ This is a       │
│ multi-line      │
│ string example. │
╰─────────────────╯
'

? BoxedChars("RING")
#-->
'
╭───┬───┬───┬───╮
│ R │ I │ N │ G │
╰───┴───┴───┴───╯
'

? BoxedString("")
#-->
'
╭──╮
╰──╯
'

? BoxedChars("")
#-->
'
╭──╮
╰──╯
'

? BoxedtringArt("MAHMOUD")

# Executed in 0.001 seconds.

#~~~~~~

? NL + "~~~~~~~"

t = (clock() - t0) / clockspersecond()
? "Executed in " + t + " seconds."
