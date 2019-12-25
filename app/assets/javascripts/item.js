$(function() {
  function buildHTML(params){
    var category_option = ''
    params.forEach(function (category) {
      category_option += `<option value=${category.id}>${category.name}</option>`
    });
    var html = `<select name="item[category_id]" id="item_category_id middle_category">
                  <option value>---</option>
                  ${category_option}
                </select>`
    return html;
  };
  $('.category__large').change(function() {
    var category_id = $('.category__large option:selected').val();
    if (category_id == "") {
      $('.category__middle').empty();
      $('.category__small').empty();
    } else {
      $.ajax({
        type: 'GET',
        url: '/items/category',
        dataType: 'json',
        data: {id: category_id}
      })
      .done(function(params) {
        var html = buildHTML(params);
        $('.category__middle').append(html);
      })
      .fail(function() {
        alert('error');
      });
    }
  });

  $('.category__middle').change(function() {
    var category_id = $('.category__middle option:selected').val();
    if (category_id == "") {
      $('.category__small').empty();
    } else {
      $.ajax({
        type: 'GET',
        url: '/items/category',
        dataType: 'json',
        data: {id: category_id}
      })
      .done(function(params) {
        var html = buildHTML(params);
        $('.category__small').append(html);
      })
      .fail(function() {
        alert('error');
      });
    }
  });
});