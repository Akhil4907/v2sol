require 'csv'

class CSVFileReader
    def self.inherited(subclass)
        file_name = "#{subclass.to_s.downcase}s.csv"
        headings = CSV.open(file_name, 'r', &:readline).map(&:strip)
        
        subclass.class_eval do
          attr_accessor(*headings)


          define_singleton_method :find_by do |attribute, value|
            CSV.foreach(file_name, headers: true) do |row|
              if row[attribute.to_s] == value.to_s
                obj = subclass.new  # Create a new instance of the subclass
                headings.each { |h| obj.send("#{h}=", row[h]) }  # Set attributes from CSV
                return obj
              end
            end
            nil 
          end
        end
    end
       
end
