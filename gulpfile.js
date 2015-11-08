'use strict';

var gulp = require('gulp');
var sourcemaps = require('gulp-sourcemaps');
var coffee = require('gulp-coffee');
var streamqueue = require('streamqueue');
var rimraf = require('gulp-rimraf');
var coffeelint = require('gulp-coffeelint');
var watch = require('gulp-watch');
var nodemon = require('gulp-nodemon');
var lab = require('gulp-lab');

gulp.task('default', ['coffee'], function() {
  nodemon({
    script: 'server/app.js',
    ext: 'coffee',
    watch: ['server'],
    tasks: ['coffee']
  });
});

gulp.task('test', ['coffee'], function() {
  return gulp.src(['server/tests/*.js', '!server/tests/common.js'])
    .pipe(lab('-c -C -v --reporter html --output coverage'));
});

gulp.task('coffee', function() {
  return streamqueue({ objectMode: true },
    gulp.src('server/**/*.js')
      .pipe(rimraf()),
  	gulp.src('server/**/*.coffee')
      .pipe(coffeelint())
      .pipe(coffeelint.reporter())
      .pipe(sourcemaps.init())
      .pipe(coffee())
      .pipe(sourcemaps.write())
      .pipe(gulp.dest(function(file) { return file.base; }))
  )
});