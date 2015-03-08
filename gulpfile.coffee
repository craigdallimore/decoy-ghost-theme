###############################################################################
#
# gulpfile.coffee
#
# [About gulp](https://github.com/gulpjs/gulp/)
# [About coffeescript](http://coffeescript.org/)
#
# Make sure you have coffee-script:
# ---------------------------------
# $ npm install coffee-script -s
#
# To run:
# -------
# $ gulp
#
#### IMPORTS ##################################################################

gulp       = require 'gulp'
gutil      = require 'gulp-util'
sass       = require 'gulp-sass'           # Presently gulp-sass is not as
                                            # stable and feature rich as
                                            # gulp-ruby-sass.
#sass       = require 'gulp-ruby-sass'
rename     = require 'gulp-rename'
sourcemaps = require 'gulp-sourcemaps'
livereload = require 'gulp-livereload'

#### HELPERS ##################################################################

handleError = (err) ->
  gutil.log(err)
  this.emit 'end'

#### FILES / FOLDERS  #########################################################

scssEntryFile  = './assets/scss/main.scss'
scssPath       = './assets/scss/'
cssBundle      = 'bundle.css'

destFolder     = './assets/css'

#### CSS TASKS ################################################################

gulp.task 'css', ->

  gulp.src scssEntryFile
  .on 'error', handleError
  .pipe sourcemaps.init()
    .pipe sass()
    .pipe rename cssBundle
  .pipe sourcemaps.write('./maps') # ./assets/css/maps
  .pipe gulp.dest destFolder
  .pipe livereload()

#### WATCH TASK ###############################################################

gulp.task 'watch', ->

  livereload.listen()

  gulp.watch [
    scssPath + '**/*.scss'
  ], [ 'css' ]

#### DEFAULT TASK #############################################################

# For development

gulp.task 'default', [ 'css', 'watch' ]

#### DEPLOY TASK ##############################################################

gulp.task 'deploy', [ 'css' ]

#### KAIZEN ###################################################################
