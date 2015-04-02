require 'gmail'

class EmailController < ApplicationController

  before_filter :ensure_sign_in

  def index
  end

  def send_message
    # Gmail.connect(:xoauth2, current_user.email, current_user.token.fresh_token) do |gmail|
      # gmail.deliver do
      #   to "llss14@daum.net"
      #   bcc "hchang239@berkeley.edu, llss14@naver.com"
      #   subject "This is test-email from CollegeTrack"
      #   html_part do
      #     content_type 'text/html; charset=UTF-8'
      #     body "<p>Text of <em>html</em> message.</p>"
      # end
    # end

    redirect_to email_index_path
  end

end