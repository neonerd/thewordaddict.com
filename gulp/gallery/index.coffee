module.exports =

	getMeta : (galleryDir) ->

		meta = require galleryDir + "/meta"
		return meta.galleries