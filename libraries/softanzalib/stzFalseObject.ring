
# Used, in particular, to enable chains of truth, like
# when we make multiple equality check :

# ? Q(2+5) = Q(3+4) = Q(9-2) = 7
#--> TRUE

func StzFalseObjectQ()
	return new stzFalseObject

	func FalseObject()
		return new stzFalseObject

	func AFalseObject()
		return new stzFalseObject

#< @ClassMisspelledForms

class stzFalsObject from stzFalseObject
class stzFlaseObject from stzFalseObject

#>

class stzFalseObject from stzObject
	@cVarName = :@falseobject

	def Content()
		return FALSE

		def Value()
			return Content()

	def Where(pcCondition)
		return FALSE

		def W(pcCondition)
			return FALSE

	def IsEqualToCSQ(p, pCaseSensitie)
		return This

		def IsEqualToQ(p)
			return This

	def IsEqualToCS(p, pCaseSensitive)
		return FALSE

		def ISEqualTo(p)
			return FALSE
