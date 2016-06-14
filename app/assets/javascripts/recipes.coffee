# @Author: Ronnie Nyaga <Ronnie>
# @Date:   2016-06-11T20:28:57+03:00
# @Email:  ronnienyaga@gmail.com
# @Last modified by:   Ronnie
# @Last modified time: 2016-06-14T17:53:44+03:00



# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  $('#recipes').imagesLoaded ->
    $('#recipes').masonry
      itemSelector: '.box'
      isFitWidth: true
