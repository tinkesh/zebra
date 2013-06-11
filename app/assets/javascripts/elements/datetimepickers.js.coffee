jQuery ->
  jQuery("[data-role='datetimepicker']").datetimepicker
    dateFormat: "yy-mm-dd"
    stepMinute: 15
    hourGrid: 6
    minuteGrid: 15

  jQuery("[data-role='datepicker']").datepicker
    dateFormat: "yy-mm-dd"
    changeMonth: true
    changeYear: true

  jQuery("[data-role='monthpicker']").each ->
    $this = jQuery(this)
    $this.datepicker
      dateFormat: 'yy-mm-dd'
      changeMonth: true
      changeYear: true
      showButtonPanel: true
      defaultDate: $this.data('preselected-date')
      onChangeMonthYear: (year, month, inst) ->
        location.pathname = location.pathname + '/' + "#{year}-#{month}-01"
    $this.hide()

  jQuery("[data-role='show-monthpicker']").click (e) ->
    jQuery("[data-role='monthpicker']").show().addClass('monthpicker')
    jQuery(this).hide()
