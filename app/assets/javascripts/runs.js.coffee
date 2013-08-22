# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.exec-runs .btn').click ->
    execForm = $('.exec-form')
    execForm.find('#total').val($(this).data('total'))
    execForm.submit()

