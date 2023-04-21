require 'cgi'
class ChallengesController < ApplicationController
    @@challenges = [
        # {
        #     title: "Printing",
        #     subtitle: "Print your response to Ruby using puts",
        #     topic: "puts",
        #     topicdesc: "<strong>puts</strong> is a method that stands for <b>'put string'</b>, It is used to output a string to the console followed by a newline character. You can put it inside <b>double quotes(\")</b> or <b>single quotes(')</b> either way the compiler will still consider it as a string.",
        #     examples: ["<p><strong>puts \"Hello World!\"</strong> prints Hello World!</p>", "<p><strong>puts 'Coding Dojo!'</strong>  prints Coding Dojo!"],
        #     dothis: "Respond by printing 'Hello Ruby!' using puts",
        #     expected_output: ["Hello Ruby!\n"],
        #     rubysays: "Ruby says Hi!"
        # },
        # {
        #     title: "Printing",
        #     subtitle: "Print your response to Ruby using print",
        #     topic: "print",
        #     topicdesc: "the <strong>print</strong> method works just like the puts method, except it doesn't add a newline character to the end of the output. You can put it inside <b>double quotes(\")</b> or <b>single quotes(')</b> either way the compiler will still consider it as a string.",
        #     examples: ["<p><strong>print \"Hello World!\"</strong> prints Hello World!</p>", "<p><strong>print 'Coding Dojo!'</strong> prints Coding Dojo!</p>"],
        #     dothis: "Respond by printing 'Hello Ruby!' using print",
        #     expected_output: ["Hello Ruby!"],
        #     rubysays: "Ruby says Hi!"
        # },
        {
            title: "Data Types",
            subtitle: "Create a String",
            # method: ".class",
            # methoddesc: "In Ruby, <strong>.class</strong> is a method that can be called on an object to determine data type. Refer to the examples below to get the correct response to Ruby.",
            examples: ["<p><strong>\"Hello Ruby!\"</strong></p>", "<p><strong>'This is Ruby!'</strong></p>"],
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
            examples: ["<p><strong>200</strong></p>", "<p><strong>-250</strong></p>"],
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
            examples: ["<p><strong>69.420</strong></p>", "<p><strong>666.444</strong></p>"],
            dothis: "Ruby asks you to create a Float",
            expected_output: ["Float", "Float\n"],
            rubysays: "Can you create a Float object?",
            # rubyprovide: "69.420\n",
            topic: "Float",
            topicdesc: "<p>A <b>float</b> is a data type that represents numbers with decimal points. It is a type of numerical data that can be used in calculations and comparisons where a higher level of precision is required.</p>"
        },
        {
            title: "Data Types",
            subtitle: "Create an Array",
            # method: ".class",
            # methoddesc: "In Ruby, <strong>.class</strong> is a method that can be called on an object to determine data type. Refer to the examples below to get the correct response to Ruby.",
            examples: ["<p><strong>[4,5,6,7,8]</strong></p>", "<p><strong>[2,4.5,3,'kirt','Reguyal']</strong></p>"],
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
            examples: ["<p><strong>{\"Alice\" => 25, \"Bob\" => 30, \"Charlie\" => 35}</strong></p>", "<p><strong>{ name: \"John\", age: 30, occupation: \"Developer\" }</strong></p>"],
            dothis: "Ruby asks you to create a Hash",
            expected_output: ["Hash", "Hash\n"],
            rubysays: "Can you create a Hash object?",
            # rubyprovide: "[1,3,4]",
            topic: "Hash",
            topicdesc: "<p>a <b>hash</b> is a data structure that allows you to store a collection of key-value pairs. A key-value pair is made up of a key (also called a \"symbol\") and a corresponding value.</p>"
        },
        {
            title: "Variables",
            subtitle: "Create a variable and store any valid data to it.",
            method: "Variables",
            methoddesc: "<b>Variables</b> are used to <i>store</i> values or objects. They act as placeholders for values that can change or be updated during the execution of the program.",
            examples: ["<p><strong>variableName = \"This is a sting\"</strong></p>", "<p><strong>anyName = 214</strong></p>"],
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
            methoddesc: "<b>Variables</b> are used to <i>store</i> values or objects. They act as placeholders for values that can change or be updated during the execution of the program",
            examples: ["<p><strong>puts \"Hello \#{name}\"</strong></p>", "<p><strong>print \"Sum of 2 numbers \#{sum}\"</strong></p>"],
            dothis: "Ruby asks you to use Interpolation",
            expected_output: ["Hello World!", "Hello World!\n"],
            rubysays: "Use ",
            rubyprovide: "sample = \" World!\"",
            topic: "Interpolation",
            topicdesc: "<p>Interpolation is a technique used in programming to <b>combine</b> variables and strings into a single, cohesive output.</p>"
        }
    ]

    def index
        gon.challenges = @@challenges
    end

    def run 
        # begin
        #     eval(params[:answer])
        #     output = capture_stdout { 
        #         eval("puts #{params[:answer]}.class")
        #     }
        # rescue SyntaxError => e
        #     output = 'Syntax Error'
        # rescue => e
        #     output = 'Error'
        # end
        output = ''
        challenge = @@challenges[params[:challenge].to_i]
        if(challenge[:title] == "Data Types")
            output = verifyDataType(params[:answer])
        elsif(challenge[:title] == "Variables")
            if(challenge[:topic] == "Interpolation")
                output = verifyInterpo(params[:answer])
            else
                output = verifyVariables(params[:answer])
            end
        end

        puts output
        
        render plain: output
    end

    private 
    def verifyDataType(data)
        begin
            if data == ''
                data = 'error'
            end

            eval(data)
            output = capture_stdout { 
                eval("var = #{data}\nputs var.class")
            }
        rescue SyntaxError => e
            output = 'Syntax Error'
        rescue => e
            output = 'Error'
        end

        output
    end

    def verifyVariables(data)
        data_arr = data.split('=')
        var_name = data_arr[0]
        var_value = data_arr[1]
        
        # begin
        #     if data == ''
        #         data = 'error'
        #     end

        #     # if var_value = ''
        #     #     data = 'error'
        #     # end

        #     eval("#{data}\nputs #{var_name}")
        #     output = 'isavariable'
        # rescue SyntaxError => e
        #     output = 'Syntax Error'
        # rescue => e
        #     output = 'Error'
        # end
        variable_declaration_pattern = /^[a-zA-Z_]+[a-zA-Z0-9_]*\s*=\s*.*$/

        if data =~ variable_declaration_pattern
            if var_value === ' '
                output = 'is not valid'
            else
                output = 'isavariable'
            end
        else
            output = 'isnotavariable'
        end

        output
    end

    def capture_stdout
        buffer = StringIO.new
        original_stdout = $stdout
        $stdout = buffer
        yield
        $stdout = original_stdout
        buffer.string
    end
end
