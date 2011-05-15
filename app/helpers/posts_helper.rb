module PostsHelper

  # displays different output depending on the user who made the post
  def publish_info(post)

      if post.user == current_user
        link_to "you", user_path(current_user)
      else
        link_to post.user.full_name, user_path(post.user)
      end
  end

end

