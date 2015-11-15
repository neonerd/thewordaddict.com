gulp = require "gulp"

sass = require "gulp-sass"
jade = require "gulp-jade"
rename = require "gulp-rename"

content = require "./content"

# RENDER ISSUES - LIST OF ARTICLES AND ARTICLES THEMSELVES
gulp.task 'render.issues', () ->

	categoryPages = {
		'prose' : 'prose'
		'poem' : 'poetry'
		'essay' : 'essays'
	}
	categoryPieces = {
		'prose' : {}
		'poetry' : {}
		'essays' : {}
	}
	
	issues = [1, 2, 3]
	issueTitles = {
		1 : 'Absorbing People'
		2 : 'Tech Dystopias'
		3 : 'Primitivism'
	}

	for issue in issues

		pieces = content.processIssue( __dirname + "/../content", issue )

		for piece in pieces

			categoryPieces[ categoryPages[piece.type] ][issue] = [] unless categoryPieces[ categoryPages[piece.type] ][issue]?
			categoryPieces[ categoryPages[piece.type] ][issue].push piece

			gulp.src("./templates/piece.jade")
			.pipe(rename("#{ piece.slug }.html"))
			.pipe(jade({
				pretty : true
				locals : {
					wordaddict : {
						issueNumber : issue
					}
					piece : piece
				}
			}))
			.pipe(gulp.dest("./public/issues/#{ issue }/"))

		for category, categoryIssues of categoryPieces

			# compose a list of issues
			issuesList = []

			for issueNumber, pieces of categoryIssues

				issuesList.unshift {
					issueNumber : issueNumber
					issueTitle : issueTitles[issueNumber]
					pieces : pieces
				}
				
			# render
			gulp.src('./templates/category.jade')
			.pipe(rename("#{ category }.html"))
			.pipe(jade({
				pretty : true
				locals : {
					issues : issuesList
					wordaddict : {
						issueNumber : 3
					}
				}
			}))
			.pipe(gulp.dest('./public/'))

# RENDER THE STATIC PAGES
gulp.task 'render.static', () ->

	gulp.src("./templates/index.jade")
	.pipe(jade({
		pretty : true
		locals : {
			wordaddict : {
				issueNumber : 3
				issueTitle : "Primitivism"
			}
		}
	}))
	.pipe(gulp.dest('./public/'))

	gulp.src("./templates/about.jade")
	.pipe(jade({
		pretty : true
		locals : {
			wordaddict : {
				issueNumber : 1
			}
		}
	}))
	.pipe(gulp.dest('./public/'))

# MOVE THE STATIC CONTENT

gulp.task 'move.static', () ->

	gulp.src("./static/img/*.*")
	.pipe(gulp.dest("./public/img/"))

	gulp.src("./static/css/*.css")
	.pipe(gulp.dest("./public/css/"))

# COMPILE THE CSS

gulp.task 'css', () ->
	gulp.src('./styles/*.scss')
	.pipe(sass().on('error', sass.logError))
	.pipe(gulp.dest('./public/css'))

# DEV WATCH FEATURE

gulp.task 'watch', () ->
	gulp.watch('./styles/*.scss', ['css'])

# MAIN TASKS

# builds the whole site into the /public folder
gulp.task 'build', ['css', 'render.issues', 'render.static', 'move.static']
# in default, acts as a development daemon
gulp.task 'default', ['css', 'watch']