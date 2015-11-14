# -- GLOBALS
contentTypes = {
	"essay" : {
		format : "long"
	}
	"poem" : {
		format : "wysiwyg"
	}
	"prose" : {
		format : "long"
	}
}

# -- MODULES

fs = require "fs"

content = 

	# parse one text
	parsePiece : (piecePath) ->

		pieceContent = fs.readFileSync(piecePath, 'utf-8').split("===", 1)
		pieceText = pieceContent[1]
		pieceMeta = pieceContent[0]

	# process an issue based on its number
	processIssue : () ->


	# get a list of all issues in descending order
	getIssues : () ->



module.exports = content