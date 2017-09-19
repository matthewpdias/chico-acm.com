puts "Enter the name of the file you want to convert:"

input = gets.chomp

output = input.sub('.md', '.html')

system("showdown", "makehtml", "-i", "#{input}", "-o", "#{output}")
