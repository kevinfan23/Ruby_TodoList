# Module Menu
module Menu
	
	# Prompt Menu for the users
	def menu
		"Welcome to the TodoList Program!
         This menu will help you use the Task List System
         1) Add
         2) Show 
         3) Update
         4) Delete
         5) Write to a File
         6) Read from a File
         7) Toggle Status
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
        
	# Add task to list
	def add(task)
		begin
			@all_tasks << task
		rescue=>detail
			puts detail.backtrace.join("\n")
		end
	end
	
	#Show all tasks
	def show
		@all_tasks.map.with_index { |l, i| 
			"#{i.next}) #{l.display}\n"
		}
	end
	
	# Read a task from a file
	def read_from_file(filename)
		IO.readlines(filename).each{ |line|
			*description, status = line.split(':')
			status = status.include?('X')
			add(Task.new(description.join(':').strip, status))
		}
	end
	
	# Write a list to a file
	def write_to_file(filename)
        IO.write(filename, @all_tasks.map(&:display).join("\n"))
	end
	
	# Delete a task
	def delete(task_number)
		@all_tasks.delete_at(task_number-1)
	end
	
	# Update a task
	def update(task_number, task)
		@all_tasks[task_number-1] = task
	end
	
	# Toggle status
	def toggle(task_number)
		@all_tasks[task_number-1].toggle_status
	end
	
end
	
	
# Task Class

class Task
	
	attr_reader :description	
	attr_accessor :status
	
	def initialize(description, status = false)
        @description = description
        @status = status
    end
    
    def display
	    "#{description} : #{represent_status}"
	end
	
	def toggle_status
		@status = !status
	end
	
	private
	def represent_status
		@status ? '[X]' : '[ ]'
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
			when '3', 'update'
				puts my_list.show
				my_list.update(prompt('Which task would you like to update?').to_i, 
                Task.new(prompt('New task name please?')))
			when '4', 'delete'
	            puts my_list.show
				my_list.delete(prompt('Which task would you like to delete?').to_i)
			when '5', 'write to a file'
				my_list.write_to_file(prompt('Enter a file name'))
			when '6', 'read from a file'
				begin
					my_list.read_from_file(prompt('Enter a file name'))
				rescue Errno::ENOENT
                    puts 'File name not found, please verify your file name and path.'
                end
            when '7', 'toggle status'
            	puts my_list.show
            	my_list.toggle(prompt('Which task would you change the status for').to_i)
			else
				puts 'Sorry, I did not understand?'
		end
		prompt('Press enter to continue', '')
    end
    puts 'Thanks for using the TODOList system!'
end 