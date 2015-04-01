require 'gmail'

class EmailController < ApplicationController

  def index
    access_token = Token.last.fresh_token
    gmail = Gmail.connect(:xoauth2, current_user.email, access_token)
    gmail.deliver do
      to "llss14@daum.net"
      bcc "hchang239@berkeley.edu, llss14@naver.com"
      subject "This is test-email from CollegeTrack"
      html_part do
        content_type 'text/html; charset=UTF-8'
        body "<p>Text of <em>html</em> message.</p>"
      end
    end
  end

end