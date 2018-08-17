class ContactMailer < ApplicationMailer
def contact_mail(picture)
 @picture = picture
 @user = User.find_by(id: @picture.user_id)
    mail to: @user.email, subject: "ブログ投稿確認メール"
end
end