class EmailController < ApplicationController

  before_filter :ensure_sign_in

  def index
    @filter_values = get_filter_values
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
    render json: generate_email(filters, 0, [""]).to_json
  end

  protected

  @@client = Restforce.new :host => "test.salesforce.com"

  def get_filter_values
    locations = ["Oakland"]
    races = get_values("Race__c")
    genders = get_values("Gender__c")
    years = get_values("Class_Level__c").sort
    high_schools = get_values("High_School__c")
    parent_student = ["Parent", "Student"]
    {"Locations" => locations, "Race" => races, "Gender" => genders, "Year" => years, "High School" => high_schools, "Parent/Student" => parent_student}
  end

  def get_values(column)
    values = @@client.query("select #{column} from Contact")
    values.map{ |value| value["#{column}"] }.uniq
  end
end