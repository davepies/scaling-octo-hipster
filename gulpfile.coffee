gulp            = require 'gulp'
clean           = require 'gulp-clean'
runWintersmith  = require 'run-wintersmith'
cssshrink       = require 'gulp-cssshrink'
uglify          = require 'gulp-uglify'
uncss           = require 'gulp-uncss'
image           = require 'gulp-image'
deploy          = require 'gulp-gh-pages'
concat          = require 'gulp-concat'

BUILD_DIR       = 'build'
CONTENT_DIR     = 'contents'
TEMPLATES_DIR   = 'templates'
DIST_DIR        = 'dist'

config =
  deploy: "config.deploy.json"
  dev:    "config.json"

paths =
  scripts: [
    "#{BUILD_DIR}/js/main.js",
    "#{BUILD_DIR}/js/foot.js"
  ]
  styles: [
    "contents/vendor/css-modal/build/modal.css",
    "contents/vendor/owl-carousel/owl-carousel/owl.carousel.css",
    "contents/vendor/owl-carousel/owl-carousel/owl.transitions.css"
    "#{BUILD_DIR}/styles/main.css"
  ]
  images: "#{BUILD_DIR}/images/**/*"
  pages: [
    "#{BUILD_DIR}/index.html",
    "#{BUILD_DIR}/about/index.html"
  ]
  dist: "dist/**/*"

ghpages =
  push: true

gulp.task 'clean', ->
  gulp.src([BUILD_DIR, DIST_DIR], { read: false })
    .pipe clean()

gulp.task 'build', ['clean'], (cb) ->
  runWintersmith.settings.configFile = config.deploy
  runWintersmith.build ->
    console.log "Wintersmith has finished building!"

    cb()

gulp.task 'default', ->
  runWintersmith.settings.configFile = config.dev
  runWintersmith.preview()

gulp.task 'styles', ['copy'], ->
  gulp.src paths.styles
    .pipe concat 'main.css'
    .pipe uncss(
      html: paths.pages,
      ignore: [/modal/, /overlay/, /owl/, /grabbing/]
      ignoreSheets: [/fonts.googleapis/, /modal.css/]
    )
    .pipe cssshrink()
    .pipe gulp.dest "#{DIST_DIR}/styles"

gulp.task 'js', ['copy'], ->
  gulp.src paths.scripts
    .pipe uglify()
    .pipe gulp.dest "#{DIST_DIR}/js"

gulp.task 'images', ['copy'], ->
  gulp.src paths.images
    .pipe image()
    .pipe gulp.dest "#{DIST_DIR}/images"

gulp.task 'copy', ['build'], (cb) ->
  gulp.src paths.pages.concat(paths.images), {base: "build"}
    .pipe gulp.dest "#{DIST_DIR}"
  cb()

gulp.task 'min', ['styles', 'images', 'js']

gulp.task 'gh', ['min'], () ->
  gulp.src paths.dist
    .pipe deploy(ghpages)
