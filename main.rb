require 'csv'

class CSVFileReader
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  class << self
    attr_accessor :data, :csv_headers
    
    def inherited(subclass)
      file_name = subclass.name.downcase + 's.csv'
      csv_data = CSV.read(file_name, headers: true)
      @csv_headers = csv_data.headers
      define_accessor_methods(subclass, @csv_headers)
    end
    
    def define_accessor_methods(class_to_modify, headers)
      headers.each do |header|
        next if header.nil?
        
        attribute_name = header.downcase.gsub(/\s+/, '_').gsub(/\W+/, '').to_sym
        
        class_to_modify.class_eval do
          attr_accessor attribute_name
        end
      end
    end
    
        def read_csv
          file_name = to_s.downcase + 's.csv'
          @data = CSV.read(file_name, headers: true, header_converters: :symbol).map(&:to_hash)
        end


    def find_by(attribute, value)
      read_csv if data.nil? || data.empty?
      data.map { |row| new(row) }.find { |record| record.send(attribute) == value }
    end
  end
end


