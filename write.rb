require "csv"

student_details=[
    ["student_id","student_name"",teacher_name"",subject"],

[1,"abbas","lakshmi","science"],

[2,"priya","surya","social"],


[3,"kiran","manoj","maths"]
    
]

csv_file_path='students.csv'
CSV.open(csv_file_path,'w') do|csv|
    student_details.each do |row|
        csv <<row
    end
end