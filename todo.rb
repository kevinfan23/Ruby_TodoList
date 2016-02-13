# Module Menu
module Menu
	
	# Prompt Menu for the users
	def menu
		"Welcome to the TodoList Program!
         This menu will help you use the Task List System
         1) Add
         2) Show 
         3) Write to a File
         4) Read from a File
         Q) Quit"
	end
	
	# Show the menu
	def show
		menu
	end
end

# Module prompts the user for input
module Promptable
	
	# Prompt
	def prompt(message = 'What would you like to do?', symbol = ':> ')
        print message
        print symbol
        gets.chomp
    end
end

# List Class
class List
	attr_reader :all_tasks

	# Initializer
	def initialize
		@all_tasks = []
	end
	
	# Helper functions
	def to_s
        description
    end
        
	# Add task to list
	def add(task)
		if task.is_a? Task
			@all_tasks << task.description
		else
			@all_tasks << task
		end
	end
	
	#Show all tasks
	def show
		@all_tasks
	end
	
	# Read a task from a file
	def read_from_file(filename)
		IO.readline(filename).each{ |line|
			add(Task.new(line.chomp))
		}
	end
	
	# Write a list to a file
	def write_to_file(filename)
        IO.write(filename, @all_tasks.map(&:to_s).join("\n"))
	end
	
	# Delete a task
	def delete
		
	end
	
	# Update a task
	def update
		
	end
	
end
	
	
# Task Class

class Task
	
	attr_reader :description	
	
	def initialize(description)
        @description = description
    end
    
    def show
	    @description
	end
          
	
end

if __FILE__ == $PROGRAM_NAME
    include Menu
	include Promptable
    my_list = List.new
	puts 'Please choose from the following list'  
	until 'q'.include?(user_input = prompt(show).downcase)
		case user_input
			when '1', 'add'
				my_list.add(Task.new(prompt('What is the task you would like to accomplish?')))
			when '2', 'show'
				puts my_list.show
			when '3', 'write to a file'
				my_list.write_to_file(prompt('Enter a file name'))
			when '4', 'read from a file'
				begin
					my_list.read_from_file(prompt('Enter a file name'))
				rescue Errno::ENOENT
                    puts 'File name not found, please verify your file name and path.'
                end
			else
				puts 'Sorry, I did not understand?'
		end
		prompt('Press enter to continue', '')
    end
    puts 'Thanks for using the TODOList system!'
end 