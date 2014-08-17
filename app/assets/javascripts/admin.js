(function(){
  W.ns("Chima.Admin");

  Chima.Admin = {
    newModel: function(){
      var html = "<tr>" + $("#models tr:last").html() + "</tr>";
      $("#models tr:visible:last").after(html);
    },
    // 更换 下拉框的options
    // select => select jquery object
    // newOptions => { key: value }
    changeUpSizeCategory: function(select,newOptions){
      var $select = select;
      var options;
      if($select.prop) {
        options = $select.prop('options');
      }
      else {
        options = $select.attr('options');
      }
      $('option', $select).remove();
      $.each(newOptions, function(val, text) {
        options[options.length] = new Option(text, val);
      });
    }

  };
})();

