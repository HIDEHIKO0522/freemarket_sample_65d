$(document).on('turbolinks:load', function() {
  // カテゴリー選択機能
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
  $('#large-category').change(function() {
    var category_id = $('#large-category option:selected').val();
    $('#middle-category').empty();
    $('#small-category').empty();
    if (category_id != "") {
      $.ajax({
        type: 'GET',
        url: '/items/category',
        dataType: 'json',
        data: {id: category_id}
      })
      .done(function(params) {
        var html = buildHTML(params);
        $('#middle-category').append(html);
      })
      .fail(function() {
        alert('error');
      });
    }
  });

  $('#middle-category').change(function() {
    var category_id = $('#middle-category option:selected').val();
    $('#small-category').empty();
    if (category_id != "") {
      $.ajax({
        type: 'GET',
        url: '/items/category',
        dataType: 'json',
        data: {id: category_id}
      })
      .done(function(params) {
        var html = buildHTML(params);
        $('#small-category').append(html);
      })
      .fail(function() {
        alert('error');
      });
    }
  });

  //販売手数料、販売利益
  function separate(num){
    return String(num).replace( /(\d)(?=(\d\d\d)+(?!\d))/g, '$1,');
  };
  $('#price-input input').on('keyup', function() {
    var tax = Math.floor($(this).val() * 0.1);
    var profit = Math.floor($(this).val() - tax);
    if ($(this).val() >= 300 && $(this).val() <= 9999999) {
      $('#tax').text(separate(tax));
      $('#profit').text(separate(profit));
    } else {
      $('#tax').text('-');
      $('#profit').text('-');
    }
  });

  //商品詳細ページ 価格表示にカンマを付ける
  function commaPrice(price) {
    value = $(price).text();
    $(price).text(separate(value));
  }
  commaPrice('.item-show-container__item__price__price');

  //商品画像削除
  $('.sell-form__upload__thumbnails__thumbnail__btn__delete').click(function(){
    thumbnail = $(this).parent().parent();
    $(thumbnail).remove();
  });
});