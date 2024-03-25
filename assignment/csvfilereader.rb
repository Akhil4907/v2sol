require 'csv'

class CSVFileReader
    # DEFAULT_CSV_FILE_PATH ='students.csv'

    def file_name
    "#{self.class.name.downcase}s.csv"
  end

  def initialize(csv_file_path=file_name)
    @csv_file_path = file_name
    @csv_data = load_csv(file_name)
    define_accessor_methods
    # puts self.name
  end

 

  def load_csv(csv_file_path)
    @csv_data = CSV.read(csv_file_path, headers: true)
    # save_to_csv
  end

  

  def define_accessor_methods
    class_name=self.class.name
    class_object = Object.const_get(class_name)
    @csv_data.headers.each do |header|
      next if header.nil?

      attribute_name = header.downcase.gsub(/\s+/, '_').gsub(/\W+/, '')
      class_object.class_eval do
        attr_accessor attribute_name.to_sym
      end
    end
  end

  def self.find_by(attribute, value)
    csv_file_name = "#{self.to_s.downcase.gsub('csvfilereader', '')}s.csv"
    reader = new(csv_file_name)
    reader.find_by(attribute, value)
  end
         
  def find_by(attribute, value)
    return nil unless @csv_data
    row = @csv_data.find { |data| data[attribute.to_s] == value.to_s }
    
   
    return nil unless row
    # puts row
    convert_to_object(row)
  end

  def convert_to_object(data)
    obj = Object.new
    data.each do |key, value|
      # Define getter methods dynamically for each attribute
      obj.define_singleton_method(key.to_sym) { value }
    end
    obj
  end


  
end
