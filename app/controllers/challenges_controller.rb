# require 'cgi'
class ChallengesController < ApplicationController
    @@challenges = [
        {
            title: "Data Types",
            subtitle: "Create a String",
            # method: ".class",
            # methoddesc: "In Ruby, <strong>.class</strong> is a method that can be called on an object to determine data type. Refer to the examples below to get the correct response to Ruby.",
            examples: ["<div class = 'examp'>\"Hello Ruby!\"</div>", "<div class = 'examp'>'This is Ruby!'</div>"],
            dothis: "Ruby asks you to create a String",
            expected_output: ["String", "String\n"],
            rubysays: "Can you create a String object?",
            # rubyprovide: "\"Sample Object\"",
            topic: "String",
            topicdesc: "<p>A <b>string</b> is a collection of letters, numbers, and symbols that can be created using quotes, either double quotes <b>\"...\"</b> or single quotes <b>'...'</b>.</p>"
        },
        {
            title: "Data Types",
            subtitle: "Create an Integer",
            # method: ".class",
            # methoddesc: "In Ruby, <strong>.class</strong> is a method that can be called on an object to determine data type. Refer to the examples below to get the correct response to Ruby.",
            examples: ["<div class = 'examp'>200</div>", "<div class = 'examp'>-250</div>"],
            dothis: "Ruby asks you to create an Integer",
            expected_output: ["Integer", "Integer\n"],
            rubysays: "Can you create an Integer object?",
            # rubyprovide: "69",
            topic: "Integer",
            topicdesc: "<p>An <b>integer</b> is a data type that represents whole numbers, both positive and negative from <b>-2,147,483,648</b> to <b>2,147,483,647</b>. It is a type of numerical data that can be used in calculations and comparisons.</p>"
        },
        {
            title: "Data Types",
            subtitle: "Create a Float",
            # method: ".class",
            # methoddesc: "In Ruby, <strong>.class</strong> is a method that can be called on an object to determine data type. Refer to the examples below to get the correct response to Ruby.",
            examples: ["<div class = 'examp'>69.420</div>", "<div class = 'examp'>666.444</div>"],
            dothis: "Ruby asks you to create a Float",
            expected_output: ["Float", "Float\n"],
            rubysays: "Can you create a Float object?",
            # rubyprovide: "69.420\n",
            topic: "Float",
            topicdesc: "<p>A <b>float</b> is a data type that represents numbers with decimal points. It is a type of numerical data that can be used in calculations and comparisons where a higher level of precision is required.</p>"
        },
        {
            title: "Data Types",
            subtitle: "Create a Boolean",
            # method: ".class",
            # methoddesc: "In Ruby, <strong>.class</strong> is a method that can be called on an object to determine data type. Refer to the examples below to get the correct response to Ruby.",
            examples: ["<div class = 'examp'>true</div>", "<div class = 'examp'>false</div>"],
            dothis: "Ruby asks you to create a Boolean",
            expected_output: ["TrueClass", "TrueClass\n", "FalseClass", "FalseClass\n"],
            rubysays: "Can you create a Boolean object?",
            # rubyprovide: "69.420\n",
            topic: "Boolean",
            topicdesc: "<p>A boolean is a data type in programming that can only have one of two values: <b>true</b> or <b>false</b>. It is typically used to represent a logical value, such as whether a statement is true or false.</p>"
        },
        {
            title: "Data Types",
            subtitle: "Create an Array",
            # method: ".class",
            # methoddesc: "In Ruby, <strong>.class</strong> is a method that can be called on an object to determine data type. Refer to the examples below to get the correct response to Ruby.",
            examples: ["<div class = 'examp'>[4,5,6,7,8]</div>", "<div class = 'examp'>[2,4.5,3,'kirt','Reguyal']</div>"],
            dothis: "Ruby asks you to create an Array",
            expected_output: ["Array", "Array\n"],
            rubysays: "Can you create an Array object?",
            # rubyprovide: "[1,3,4]",
            topic: "Array",
            topicdesc: "<p>An <b>array</b> in Ruby is a collection of elements of the same or different data types. Arrays are often used to store and manipulate data retrieved from a database or obtained from user input.</p>"
        },
        {
            title: "Data Types",
            subtitle: "Create a Hash",
            # method: ".class",
            # methoddesc: "In Ruby, <strong>.class</strong> is a method that can be called on an object to determine data type. Refer to the examples below to get the correct response to Ruby.",
            examples: ["<div class = 'examp'>{ \"Alice\" => 25, \"Charlie\" => 35 }</div>", "<div class = 'examp'>{ name: \"John\", occupation: \"Developer\" }</div>"],
            dothis: "Ruby asks you to create a Hash",
            expected_output: ["Hash", "Hash\n"],
            rubysays: "Can you create a Hash object?",
            # rubyprovide: "[1,3,4]",
            topic: "Hash",
            topicdesc: "<p>a <b>hash</b> is a data structure that allows you to store a collection of key-value pairs. A key-value pair is made up of a key (also called a \"symbol\") and a corresponding value. To create a hash in Ruby, you use curly braces <b>'{}'</b> and separate each key-value pair with a comma.</p>"
        },
        {
            title: "Printing",
            subtitle: "Print your response to Ruby using puts",
            topic: "puts",
            topicdesc: "<strong>puts</strong> is a method that stands for <b>'put string'</b>, It is used to output a string to the console followed by a newline character. You can put it inside <b>double quotes(\")</b> or <b>single quotes(')</b> either way the compiler will still consider it as a string.",
            examples: ["<div class = 'examp'>puts \"Hello World!\"</div>", "<div class = 'examp'>puts 'Coding Dojo!'</div>"],
            dothis: "Respond by printing 'Hello Ruby!' using puts",
            expected_output: ["Hello Ruby!\n"],
            rubysays: "Ruby says Hi!"
        },
        {
            title: "Printing",
            subtitle: "Print your response to Ruby using print",
            topic: "print",
            topicdesc: "the <strong>print</strong> method works just like the puts method, except it doesn't add a newline character to the end of the output. You can put it inside <b>double quotes(\")</b> or <b>single quotes(')</b> either way the compiler will still consider it as a string.",
            examples: ["<div class = 'examp'>print \"Hello World!\"</div>", "<div class = 'examp'>print 'Coding Dojo!'</div>"],
            dothis: "Respond by printing 'Hello Ruby!' using print",
            expected_output: ["Hello Ruby!"],
            rubysays: "Ruby says Hi!"
        },
        {
            title: "Variables",
            subtitle: "Create a variable and store any valid data to it.",
            method: "Variables",
            methoddesc: "<b>Variables</b> are used to <i>store</i> values or objects. They act as placeholders for values that can change or be updated during the execution of the program.",
            examples: ["<div class = 'examp'>variableName = \"This is a sting\"</div>", "<div class = 'examp'>anyName = 214</div>"],
            dothis: "Ruby asks you to create a variable <br>and assign any data type in it.",
            expected_output: ["isavariable"],
            rubysays: "Can you create a variable and store any object in it?",
            # rubyprovide: "[1,3,4]",
            topic: "Assignment",
            topicdesc: "<p>To assign a value to a variable, you use an equal sign <b>(=)</b> and write the variable name on the left side, followed by the value you want to assign to it on the right side.</p>"
        },
        {
            title: "Variables",
            subtitle: "Do interpolation by using the provided variable.",
            method: "Variables",
            methoddesc: "<b>Variables</b> are used to <i>store</i> values or objects. They act as placeholders for values that can change or be updated during the execution of the program.",
            examples: ["<div class = 'examp'>puts \"Hello \#{variable_name}\"</div>", "<div class = 'examp'>print \'Sum of 2 numbers \' + variable_sum</div>"],
            dothis: "Ruby asks you to use Interpolation and<br> print 'Hello Wordl!'",
            expected_output: ["Hello World!", "Hello World!\n"],
            rubysays: "Print 'Hello World!' but use the variable I have provided.",
            rubyprovide: "sample = \"World!\"\n#Enter your code below\n",
            topic: "Interpolation",
            topicdesc: "<p>Interpolation is a technique used in programming to <b>combine</b> variables and strings into a single, cohesive output.</p>"
        },
        {
            title: "Control Structures",
            subtitle: "Create an if/else statement to print \"Greater than 20\" if the given num is greater than 20, and \"Less than 20\" if it is not.",
            method: "if/else",
            methoddesc: "<b>if-else</b> statements are used to control the flow of a program based on certain conditions. It allows you to execute a block of code when a certain condition is met, and execute a different block of code when the condition is not met.",
            examples: ["<div class = 'examp'>age = 20<br><br>if age >= 18 <br>&emsp;puts \"You are an adult\"<br>else<br>&emsp; puts \"You are not yet an adult\"<br> end</div>"],
            dothis: "Ruby asks you to create an if else statement",
            expected_output: ["greater than 20", "greater than 20\n"],
            rubysays: "Is the given variable num greater than or less than 20?",
            rubyprovide: "num = 24\n#Enter your codes below\n",
            topic: "Comparison operators",
            topicdesc: "<p>Comparison operators are used to compare two values.<br><br><b>==</b> : This operator checks if two values are equal to each other.<br><br><b>!=</b> : This operator checks if two values are not equal to each other.<br><br><b>\<</b> : This operator checks if one value is less than another.<br><br><b><=</b> : This operator checks if one value is less than or equal to another.</p>"
        }
    ]

    def index
        gon.challenges = @@challenges
    end

    def run 
        output = ''
        challenge = @@challenges[params[:challenge].to_i]
        if(challenge[:title] == "Data Types")
            output = verifyDataType()
        elsif(challenge[:title] == "Variables")
            if(challenge[:topic] == "Interpolation")
                output = verifyInterpo()
            else
                output = verifyVariables()
            end
        elsif(challenge[:title] == "Control Structures")
            if(challenge[:topic] == "if/else")
                output = verifyIfElse()
            end
        else
            begin
                eval(params[:answer])
                output = capture_stdout { 
                    eval(params[:answer])
                }
            rescue SyntaxError => e
                output = 'error'
            rescue => e
                output = 'error'
            end
        end

        puts output
        
        render plain: output
    end

    
    ###################
    # Private methods #
    ###################
    private 
    def verifyDataType()
        begin
            if params[:answer] == ''
                params[:answer] = 'error'
            end

            eval(params[:answer])
            output = capture_stdout { 
                eval("var = #{params[:answer]}\nputs var.class")
            }
        rescue SyntaxError => e
            output = 'Syntax Error'
        rescue => e
            output = 'Error'
        end

        output
    end

    def verifyVariables()
        data_arr = params[:answer].split('=')
        var_name = data_arr[0]
        var_value = data_arr[1]

        isString = valid_string?(var_value)
        isInteger = valid_integer?(var_value)
        isFloat = valid_float?(var_value)
        isBoolean = valid_boolean?(var_value)
        isArray = valid_array?(var_value)
        isHash = valid_hash?(var_value)

        variable_declaration_pattern = /^[a-zA-Z_]+[a-zA-Z0-9_]*\s*=\s*.*$/

        if params[:answer] =~ variable_declaration_pattern
            if var_value === ' '
                output = 'is not valid'
            elsif isString == true || isInteger == true || isFloat == true || isBoolean == true || isArray == true || isHash == true
                output = 'isavariable'
            else 
                output = 'is not valid'
            end
        else
            output = 'is not valid'
        end

        output
    end

    def verifyInterpo()
        hasInterpo = has_interpolation?(params[:answer])

        begin
            if hasInterpo != true
                params[:answer] = 'error'
            end

            eval(params[:answer])
            output = capture_stdout { 
                eval(params[:answer])
            }
        rescue SyntaxError => e
            output = 'error'
        rescue => e
            output = 'error'
        end
    end


    ########################
    # Methods for checking #
    ########################

    # Gets the output of any block of code
    def capture_stdout
        buffer = StringIO.new
        original_stdout = $stdout
        $stdout = buffer
        yield
        $stdout = original_stdout
        buffer.string
    end

    # Check if a string is a valid string
    def valid_string?(str)
        regex = /["'](?:\\.|[^"\\])*["']/
        if str =~ regex
            true
        else
            false   
        end
    end

    # Check if a string is a valid integer
    def valid_integer?(str)
        Integer(str)
        true
    rescue ArgumentError
        false
    end
    
    # # Check if a string is a valid float
    def valid_float?(str)
        Float(str)
        true
    rescue ArgumentError
        false
    end
    
    # Check if a string is a valid boolean
    def valid_boolean?(str)
        ['true', 'false'].include?(str.downcase)
    end
  
    # Check if a string is a valid array
    def valid_array?(str)
        JSON.parse(str).is_a?(Array)
        true
    rescue JSON::ParserError
        false
    end

    # Check if a string is a valid hash
    def valid_hash?(str)
        JSON.parse(str).is_a?(Hash)
        true
    rescue JSON::ParserError
        false
    end

    # Check if a string contains any type of interpolation
    def has_interpolation?(str)
        return true if str.include?('#{') || str.include?('+')
  
        return str.scan(/\#\{.+?\}/).any?
    end
end
