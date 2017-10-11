# Preview all emails at http://localhost:3000/rails/mailers/signup_mailer
class SignupMailerPreview < ActionMailer::Preview
  def singup_mail_preview
    ExampleMailer.singup_email(User.first)
  end
end
