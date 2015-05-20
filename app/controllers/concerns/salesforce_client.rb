module SalesforceClient
  extend ActiveSupport::Concern

  cattr_accessor :client

  def connect_salesforce
    self.client = Restforce.new :host => "login.salesforce.com", :password => ENV['SALESFORCE_PASSWORD'], :security_token => ENV['SALESFORCE_SECURITY_TOKEN']
    self.client.authenticate!
  end

  def generate_email(filters)
    return "" unless filters
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
    query = ""
    unless sf_keys === []
      query = "where "
      query << sf_keys.join(" and ")
    end
    unless email === ""
      values = self.client.query("select #{email} from Contact #{query}")
      emails = []
      email.split(', ').each do |column|
        emails.concat(values.map{ |value| value["#{column}"] }.uniq)
      end
      emails.compact.sort.reverse
    end
  end

  def get_filter_values
    races = get_values("Race__c")
    genders = get_values("Gender__c")
    years = get_values("Class_Level__c")
    years = years.nil? ? years : years.sort_by { |x| x[/\d+/].to_i }
    high_schools = get_values("High_School__r")
    high_schools = high_schools.nil? ? high_schools : high_schools.sort
    parent_student = ["Student", "Parent"]
    {"Parent/Student" => parent_student, "Race" => races, "Gender" => genders, "Year" => years, "High School" => high_schools}
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