module TweetsHelper
  def tweet_lists(tweets)
    html = ''
    tweets.each do |tweet|
      html += render(partial: 'tweet',locals: { tweet: tweet })
    end
    return raw(html)
    # raw HTMLを正常に表示するためのメソッド 「<」「>」「&」などの、特殊文字を意図するように扱う
  end
end