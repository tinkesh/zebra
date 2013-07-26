window.toggleCheckboxes = (checked_status) ->
  jQuery("input[type='checkbox']").prop('checked', checked_status)

jQuery(document).on 'focus', "input[value='0']", ->
  $this = jQuery(this)
  $this.val '' if $this.val() == '0'

jQuery(document).on 'blur', "input[value='0']", ->
  $this = jQuery(this)
  $this.val '0' if $this.val() == ''
