class ContactMailer < ApplicationMailer
def contact_mail(blog)
 @blog = blog
 @user = User.find_by(id: @blog.user_id)
    mail to: @user.email, subject: "ブログ投稿確認メール"
end
end