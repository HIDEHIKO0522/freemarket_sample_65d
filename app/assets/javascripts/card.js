$(document).on('turbolinks:load', function() {
  var form = $("#new_card");
  $('#new_card').on("click", "#card-submit-button", function() {
    // e.preventDefault();
    Payjp.setPublicKey('pk_test_fb1ae90bf0b9bcca1ba9f8db');
    form.find("input[type=submit]").prop("disabled", true);
    var number = form.find('input[name="card[number]"]'),
      cvc = form.find('input[name="card[security_code]"]'),
      exp_month = form.find('select[name="card[expiration_month]"] option:selected'),
      exp_year = form.find('select[name="card[expiration_year]"] option:selected');
    var card = {
      number: number.val(),
      cvc: cvc.val(),
      exp_month: exp_month.text(),
      exp_year: '20' + exp_year.text()
    };
    Payjp.createToken(card, function(s, response) {
      if (response.error) {
        form.find("input[type=submit]").prop('disabled', false);
        alert("カード情報が正しくありません。");
      }
      else {
        var token = response.id;
        form.append($('<input type="hidden" name="token" />').val(token));
        form.submit();
      }
    });
  });
});