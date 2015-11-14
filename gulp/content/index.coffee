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
path = require "path"
marked = require "marked"
slug = require "slug"

# -- FUNCTIONS

content = 

	# parse one text
	parsePiece : (piecePath) ->

		pieceContent = fs.readFileSync(piecePath, 'utf-8').split("===", 2)
		
		# assing the text
		pieceText = pieceContent[1]

		# parse meta information
		try
			pieceMeta = JSON.parse(pieceContent[0])
		catch e
			throw new Error("Could not parse meta information of piece '#{ piecePath }'!")

		data = {
			title : pieceMeta.title
			author : pieceMeta.author
			type : pieceMeta.type

			slug : slug(pieceMeta.title)
		}

		if(contentTypes[data.type].format=="wysiwyg")
			data.html = "#{ pieceText }"
		else
			data.html = marked(pieceText)

		return data
	
	# process an issue based on its number
	processIssue : (contentPath, issueNumber) ->

		issueNumber = String(issueNumber)

		pieces = []
		piecePaths = fs.readdirSync(path.join(contentPath, issueNumber))

		for piecePath in piecePaths

			pieces.push content.parsePiece( path.join(contentPath, issueNumber, piecePath) )

		return pieces

	# get a list of all issues in descending order
	getIssues : () ->



module.exports = content