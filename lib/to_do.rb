require_relative './to_dos'

class ToDo
    # def initialize
    #   @todo=[]
    # end
    def start
    loop do
      system('clear')

      puts "---- TODO.rb ----"

      # view_todos

      puts "What would you like to do?"
      puts "1) Exit 2) Add Todo 3) Mark Todo As Complete"
      print " > "
      action = gets.chomp.to_i
      case action
      when 1 then exit
      when 2 then add_todo
      when 3 then mark_todo
      else
        puts "\a"
        puts "Not a valid choice"
      end
    end
  end

  # def view_todos
  #   view_todos_by_status("Unfinished","no")
  #   view_todos_by_status("Completed","yes")
  # end

  # def view_todos_by_status(header,status)
  #   puts header
  #   arr_name = []
  #   @todos.each do |x|
  #     if x["completed"] == status
  #       arr_name.push(x["name"])
  #     end
  #   end
  #   arr_name.each_with_index do |element, index|
  #     puts "#{index+1}) #{element}"
  #   end
  # end
  def add_todo
      puts "Name of Todo > "
      input = gets.chomp
      ToDos.create(todo: input, complete: "no")
  end

  def mark_todo
    puts "Which todo have you finished?"
    action = gets.chomp
    ToDos.where(:todo => action).update_all(:complete => 'yes')
    # arr_index = 0
    # @todos.each do |x|
    #   if x["completed"] == "no"
    #     arr_index = arr_index + 1
    #     if arr_index == action
    #       x["completed"] = "yes"
    #       save!
          # break
    #     end
    #   end
    # end
  end
end
