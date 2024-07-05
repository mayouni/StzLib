#< ring_pluging_file #>

@plugin_desc   = "Plugin for replacing a substring by an other in a given string"
@plugin_name   = "plugin_string_replace"

@plugin_value  = "Hello Ring in Ring!"
@plugin_param  = [ "Hello", "Embedding" ]

@plugin_result = pluginFunc(@plugin_value, @plugin_param)
#--> Embedding Ring in Ring!

func pluginFunc(value, aParams)
	cResult = substr(value, aParams[1], aParams[2])
	return cResult
