gulp = require "gulp"
sass = require "gulp-sass"

gulp.task 'css', () ->
	gulp.src('./styles/*.scss')
	.pipe(sass().on('error', sass.logError))
	.pipe(gulp.dest('./public/css'))

gulp.task 'watch', () ->
	gulp.watch('./styles/*.scss', ['css'])

gulp.task 'default', ['css', 'watch']