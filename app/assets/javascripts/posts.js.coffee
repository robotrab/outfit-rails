# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

this.PreviewImage = ->
  oFReader = new FileReader()
  oFReader.readAsDataURL document.getElementById("uploadImage").files[0]
  oFReader.onload = (oFREvent) ->
    document.getElementById("uploadPreview").src = oFREvent.target.result
