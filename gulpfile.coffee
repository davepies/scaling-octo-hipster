gulp            = require 'gulp'
clean           = require 'gulp-clean'
runWintersmith  = require 'run-wintersmith'
cssshrink       = require 'gulp-cssshrink'
uglify          = require 'gulp-uglify'
uncss           = require 'gulp-uncss'
image           = require 'gulp-image'
deploy          = require 'gulp-gh-pages'

BUILD_DIR       = 'build'
CONTENT_DIR     = 'contents'
TEMPLATES_DIR   = 'templates'
DIST_DIR        = 'dist'

paths =
  scripts: "#{BUILD_DIR}/js/main.js",
  styles: "#{BUILD_DIR}/styles/main.css"
  images: "#{BUILD_DIR}/images/**/*"
  pages: [
    "#{BUILD_DIR}/index.html",
    "#{BUILD_DIR}/about/index.html"
  ],
  dist: "dist/**/*"

ghpages =
  push: true

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
  gulp.src paths.styles
    .pipe uncss({html: paths.pages})
    .pipe cssshrink()
    .pipe gulp.dest "#{DIST_DIR}/styles"

gulp.task 'js', ->
  gulp.src paths.scripts
    .pipe uglify()
    .pipe gulp.dest "#{DIST_DIR}/js"

gulp.task 'images', ->
  gulp.src paths.images
    .pipe image()
    .pipe gulp.dest "#{DIST_DIR}/images"

gulp.task 'copy', ['build'], (cb) ->
  gulp.src paths.pages.concat(paths.images), {base: "build"}
    .pipe gulp.dest "#{DIST_DIR}"
  cb()

gulp.task 'gh', (cb) ->
  gulp.src paths.dist
    .pipe deploy(ghpages)

gulp.task 'min', ['styles', 'images', 'js']

gulp.task 'dist', ['copy'], ->
  gulp.start 'min'

