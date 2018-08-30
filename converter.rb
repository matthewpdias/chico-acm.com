puts "Enter the name of the file you want to convert:"

input = gets.chomp

output = input.sub('.md', '.html')

system("showdown", "makehtml", "-i", "#{input}", "-o", "#{output}")

File.open(output);

#for syntax highlighting
#gsub("<pre>","<pre class=\"prettyprint\">")

#sub('</body>' ,'<scriptsrc=\"https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js\"></script><script src=\"https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js\" integrity=\"sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1\" crossorigin=\"anonymous\"></script><script src="https://cdn.rawgit.com/google/code-prettify/master/loader/run_prettify.js?skin=desert"></script></body>')

#insert this at the text-top
#'<head><title>ACM Website</title><link href=\"https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css\"rel=\"stylesheet\"integrity=\"sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M\" crossorigin=\"anonymous\"/></head>'
