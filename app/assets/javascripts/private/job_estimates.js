jQuery(document).ready(function() {
  updateTable();
  chosenSelect();
  jQuery('tr.item input').change(function(event) {
    updateTable();
  });

  jQuery("#job_estimate_emails").selectize({
    delimiter: ', ',
    persist: false,
    maxItems: null,
    create: function(input) {
      return {
        value: input,
        text: input
      }
    }
  });

  jQuery("#job_estimate_name_client").selectize({
    create: true,
    sortField: 'text'
  });
});

jQuery(function () {
  jQuery(".job_estimate").nestedFields({
    itemSelector: ".item",
    containerSelector: "tbody",
    afterInsert: function(item) {
      jQuery('tr.item input').change(function(event) {
        updateTable();
      });
      chosenSelect();
    },

    afterRemove: function(item) {
      jQuery("tr:hidden").remove();
      updateTable();
    }
  });
});

function chosenSelect() {
  jQuery('.chosen-select').chosen({
    allow_single_deselect: true,
    no_results_text: 'No results matched'
  });
}

function updateTable() {
  var sum = 0;
  jQuery("#table_item tbody tr").each(function(){
   el1 = Number(jQuery(this).find("td.quantity").find('input').val()) * Number(jQuery(this).find("td.price").find('input').val())
   td = jQuery(this).find("td").eq(3)
   td.find('input').val(el1);
   td.find('div.total-price').html(el1);
   sum += Number(td.find('input').val());
  });
  jQuery('.total_amount').html(sum)
  jQuery('#job_estimate_total_amount').val(sum)
};

