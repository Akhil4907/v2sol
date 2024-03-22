require_relative 'main.rb'

class Student < CSVFileReader
    end
     
    s = Student.new
    s.student_id = 10
    s.student_name = "Amit"
    s.teacher_name = "Shilesh"
    s.subject = "Physics"
     
    s1 = Student.find_by(:student_id, "3")
    puts s1.student_name  # Output should be "kiran"
    puts s1.teacher_name  # Output should be "manoj"