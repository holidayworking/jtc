$ ->
  $('form').submit ->
    $('#result').empty()

    query = $('#demo [name=query]').val()
    $.get "/api/classify?query=#{query}", (data) ->
      answers = data.sort((a, b) ->
        b[1] - a[1]
      )

      html = '<h2>分類結果</h2>'
      if answers.length == 0
        html += '<p>分類結果はありません。</p>'
      else
        html += '<table class="table">' +
                '<tr><th style="width: 25%">カテゴリー</th><th>推定値</th></tr>'
        for answer in answers
          html += "<tr><td>#{answer[0]}</td><td>#{round(answer[1])}</td></tr>"
        html += '</table>'

      $('#result').append html

    return false

round = (n) ->
  n = n * 10000
  n = Math.round(n)
  return n / 10000
