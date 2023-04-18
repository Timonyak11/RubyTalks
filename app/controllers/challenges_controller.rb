class ChallengesController < ApplicationController
    @@output = ''

    def index
        @content = [
            {
                title: "Printing",
                subtitle: "Print your response to Ruby using puts",
                method: "puts",
                help: "puts is a method that stands for 'put string', It is used to output a string to the console followed by a newline character.",
                examples: ["puts 'Hello World!' prints Hello World!", "puts 'Coding Dojo!' prints Coding Dojo!"],
                dothis: "Respond by printing 'Hello Ruby!'",
                expected_output: "Hello Ruby!\n",
                rubysays: "Ruby says Hi!"
            },
            {
                title: "Printing",
                subtitle: "Print your response to Ruby using print",
                method: "print",
                help: "the print method works just like the puts method, except it doesn't add a newline character to the end of the output. The print method is used to output a string to the console without adding a newline character.",
                examples: ["print 'Hello World!' prints Hello World!", "print 'Coding Dojo!' prints Coding Dojo!"],
                dothis: "Respond by printing 'Hello Ruby!'",
                expected_output: "Hello Ruby!",
                rubysays: "Ruby says Hi!"
            }
        ]
        @answer = @@output
        if @@output != ''
            @@output = ''
        end
    end

    def run
        begin
            eval(params[:answer])
            @@output = capture_stdout do 
                eval(params[:answer])
            end
        rescue SyntaxError => e
            @@output = 'Error'
        rescue => e
            @@output = 'Error'
        end

        expects = "Hello Ruby!\n"

        puts expects
        puts @@output
        puts expects === @@output

        redirect_to '/challenges'
    end

    private 
    def capture_stdout
        buffer = StringIO.new
        original_stdout = $stdout
        $stdout = buffer
        yield
        $stdout = original_stdout
        buffer.string
    end
end
