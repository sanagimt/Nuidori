module Public::PostsHelper

  def body_with_hashtag_links(body)
    return '' if body.blank?
    
    linked= body.gsub(/#([a-zA-Z0-9ぁ-んァ-ヶ一-龥ー]+)/) do |match|
      tag = Regexp.last_match(1)
      ActionController::Base.helpers.link_to(
        "##{tag}",
        hashtag_posts_path(name: tag),
        class: "hashtag-link"
      )
    end


    linked.gsub("\n", "<br>").html_safe
  end

end
