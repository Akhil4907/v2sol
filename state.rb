require_relative "main.rb"

class State < CSVFileReader
    end
     
    st = State.new
    st.name = "Bihar"
    st.capital = "Patna"
    st.population = "22Crore"
     
    st1 = State.find_by(:name, "Karnataka")
    puts st1.capital     # Output should be "bangalore"
    puts st1.population  # Output should be "6crore"
     