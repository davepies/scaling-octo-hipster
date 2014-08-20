gulp            = require 'gulp'
clean           = require 'gulp-clean'
runWintersmith  = require 'run-wintersmith'
cssshrink       = require 'gulp-cssshrink'
uglify          = require 'gulp-uglify'

BUILD_DIR       = 'build'
CONTENT_DIR     = 'contents'
TEMPLATES_DIR   = 'templates'
DIST_DIR        = 'dist'

gulp.task 'clean', ->
  gulp.src([BUILD_DIR, DIST_DIR], { read: false })
    .pipe clean()

gulp.task 'build', ['clean'], (cb) ->
  runWintersmith.build ->
    console.log "Wintersmith has finished building!"

    cb()

gulp.task 'default', ->
  runWintersmith.preview()

gulp.task 'styles', ->
  gulp.src "#{BUILD_DIR}/styles/main.css"
    .pipe cssshrink()
    .pipe gulp.dest "#{DIST_DIR}/styles"

gulp.task 'js', ->
  gulp.src "#{BUILD_DIR}/js/main.js"
    .pipe uglify()
    .pipe gulp.dest "#{DIST_DIR}/js"

gulp.task 'copy', ['build'], (cb) ->
  gulp.src ["#{BUILD_DIR}/about/*", "#{BUILD_DIR}/index.html", "#{BUILD_DIR}/vendor/**/*"], {base: "build"}
    .pipe gulp.dest "#{DIST_DIR}"
  cb()

# We also want to run imageoptim
# We also want to deploy I guess
gulp.task 'min', ['styles', 'js']

gulp.task 'dist', ['copy'], ->
  gulp.start 'min'
