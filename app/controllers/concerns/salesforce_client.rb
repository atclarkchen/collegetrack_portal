module SalesforceClient
  extend ActiveSupport::Concern

  cattr_accessor :client

  def change_password(new_password, new_token)
    ENV['SALESFORCE_PASSWORD'] = new_password
    ENV['SALESFORCE_SECURITY_TOKEN'] = new_token
    self.client = Restforce.new :host => "test.salesforce.com", :password => new_password, :security_token => new_token
  end

  def connect_salesforce
    self.client = Restforce.new :host => "test.salesforce.com", :password => ENV['SALESFORCE_PASSWORD'], :security_token => ENV['SALESFORCE_SECURITY_TOKEN']
    self.client.authenticate!
  end

  def generate_email(filters)
    sf_keys = []
    email = ""
    filters.each_key do |category|
      if category === "Parent/Student"
        email = grab_email(filters[category])
      else
        sf_key = get_column(category);
        or_query = ""
        filters[category].each do |filter|
          if or_query === ""
            or_query = "#{sf_key} = '#{filter}'"
          else
            or_query << " or #{sf_key} = '#{filter}'"
          end
        end
        sf_keys << "(#{or_query})"
      end
    end
    query = sf_keys.join(" and ")
    values = self.client.query("select #{email} from Contact where #{query}")
    emails = []
    email.split(', ').each do |column|
      emails.concat(values.map{ |value| value["#{column}"] }.uniq)
    end
    emails.compact.sort { |x,y| y <=> x }
  end

  def get_filter_values
    locations = get_values("Site__c")
    races = get_values("Race__c")
    genders = get_values("Gender__c")
    years = get_values("Class_Level__c").sort_by { |x| x[/\d+/].to_i }
    high_schools = get_values("High_School__r").sort
    parent_student = ["Student", "Parent"]
    {"Locations" => locations, "Race" => races, "Gender" => genders, "Year" => years, "High School" => high_schools, "Parent/Student" => parent_student}
  end

  def get_values(column)
    if column.ends_with?("__r")
      values = self.client.query("select #{column}.Name from Contact")
      values.map{ |value| value["#{column}"]["Name"] }.uniq
    else
      values = self.client.query("select #{column} from Contact")
      values.map{ |value| value["#{column}"] }.uniq
    end
  end

  def get_column(category)
    case category
    when "Locations"
      "Site__c"
    when "Race"
      "Race__c"
    when "Gender"
      "Gender__c"
    when "Year"
      "Class_Level__c"
    when "High School"
      "High_School__r.Name"
    else
    end
  end

  def grab_email(values)
    if values.length == 2
      "Email, Parent_Guardian_Email_1__c, Parent_Guardian_Email_2__c"
    elsif values.include? "Student"
      "Email"
    else
      "Parent_Guardian_Email_1__c, Parent_Guardian_Email_2__c"
    end      
  end
end
