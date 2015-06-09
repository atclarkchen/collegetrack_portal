module SalesforceClient
  extend ActiveSupport::Concern

  cattr_accessor :client

  def connect_salesforce
    # :cache => Rails.cache, 
    self.client = Restforce.new :host => "login.salesforce.com", 
      :password => ENV['SALESFORCE_PASSWORD'], 
      :security_token => ENV['SALESFORCE_SECURITY_TOKEN']
    self.client.authenticate!
  end

  def generate_email(filters)
    return "" unless filters
    # Set default options
    options = ["Site__c = 'Oakland'",
               "RecordType.Name = 'CT High School Student'",
               "Status__c = 'Youth is currently a student with CT'"]

    # Set Student/Parent filter options
    emailFields = grab_email(filters.delete("Parent/Student"))
    options << "(" + emailFields.map { |v| "#{v} != null" }.join(' OR ') + ")"

    # Set Additional Options
    filters.each do |category, values|
      query_key = get_column(category)
      group = values.map {|v| "'#{v}'"}.join(', ')
      options << "#{query_key} IN (#{group})"
    end

    # Join all options as a String and request to Salesforce
    query = options.join(' AND ')
    response = self.client.query("SELECT #{emailFields.join(', ')}
                   FROM Contact 
                  WHERE #{query}")

    # Extract emails according to Student/Parent filter values
    result = emailFields.flat_map do |field|
      response.map(&field.intern).compact
    end.sort { |x,y| y <=> x }
  end

  def get_filter_values
    races = get_values("Race__c")
    genders = get_values("Gender__c")
    years = ["12th Grade",
             "11th Grade",
             "10th Grade",
             "9th Grade",
             "Not started high school"].sort_by { |x| x[/\d+/].to_i }
    high_schools = client.query("SELECT High_School__r.Name FROM Contact
                                  WHERE Site__c = 'Oakland' AND 
                                  RecordType.Name = 'CT High School Student' AND 
                                  High_School__r.Name != null 
                                 GROUP BY High_School__r.Name").map(&:Name)
    parent_student = ["Student", "Parent"]
    {"Parent/Student" => parent_student, "Race" => races, "Gender" => genders, "Year" => years, "High School" => high_schools}
  end

  def get_values(column)
    command = "SELECT #{column} FROM Contact 
                WHERE #{column} != null AND 
                RecordType.Name = 'CT High School Student' 
               GROUP BY #{column}"
    # column.intern.to_proc generates block of object
    values = self.client.query(command).map(&column.intern)
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
    # check if the values are nil
    return "" if values.blank?

    values.flat_map do |v|
      if v.eql? "Student"
        "Email"
      elsif v.eql? "Parent"
        ["Parent_Guardian_Email_1__c", "Parent_Guardian_Email_2__c"]
      end
    end
  end
end