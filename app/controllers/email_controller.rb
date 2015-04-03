class EmailController < ApplicationController

  before_filter :ensure_sign_in

  def index
  end
  
  def send_message
    if params[:send_msg]
      send_email params[:email]
      flash[:notice] = "Message sent successfully"
    else
      save_draft params[:email]
      flash[:notice] = "Message saved in your Gmail Draftbox"
    end

    redirect_to email_index_path
  end

  def delete_message
    flash[:notice] = "Message is deleted"
    redirect_to email_index_path
  end

  @@categories = [{"Asian"=>"asian", "White"=>"white","Black"=>"black"},{"Male"=>"M","Female"=>"F"},{"2010"=>"2010","2011"=>"2011","2012"=>"2012"}]

  def generate_email(filters, lvl, emails)
    if lvl == @@categories.length
      return emails.map {|email| email + "@gmail.com"}
    end
    new_emails = []
    category = @@categories[lvl]
    all = true
    filters.each do |filter|
      if category.include? filter
        all = false
      end
    end
    if all
      category.each do |key, value|
        new_emails += emails.map {|email| email + value}
      end
    end
    category.each do |key,value|
      if filters.include? key
        new_emails += emails.map {|email| email + value}
      end
    end
    return generate_email(filters, lvl + 1, new_emails)
  end

  def email_list
    filters = params[:filters]
    render plain: generate_email(filters, 0, [""]).join(", ")
  end
end