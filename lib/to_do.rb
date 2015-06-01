require_relative './to_dos'

class ToDo
    # def initialize
    #   @todo=[]
    # end
    def start
    loop do
      system('clear')

      puts "---- TODO.rb ----"

      view_todos

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

  def view_todos
    show_table = ToDos.select('*')
    show_table.each do|item|
     puts "Todo: #{item.todo}              Complete: #{item.complete}"
   end
     puts  "-------------------------------------------------------------------"
 end


  def add_todo
      puts "Name of Todo > "
      input = gets.chomp
      ToDos.create(todo: input, complete: "no")
  end

  def mark_todo
    puts "Which todo have you finished?"
    action = gets.chomp
    ToDos.where(:todo => action).update_all(:complete => 'yes')

  end
end
