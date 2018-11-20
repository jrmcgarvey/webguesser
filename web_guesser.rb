require 'sinatra'
require 'sinatra/reloader'

number=rand(100)
message="Give a try"
@@guess_count=7

get '/' do
    if params["cheat"]=="true"
        message2=" Try " + number.to_s
    else
        message2=""
    end
    if params["guess"]!=nil && params["guess"]!=number
        @@guess_count-=1
    end
    if @@guess_count==0
        number=rand(100)
        @@guess_count=7
        message="Too many guesses.  The secret number has now changed"
     else
        if params["guess"]==nil
            message="Guess the number from 0 to 99."
            color="LightYellow"
        elsif params["guess"].to_i > number + 5
            message="Way too high."
            color="Red"
        elsif params["guess"].to_i > number
            message="Too high."
            color="Pink"
        elsif params["guess"].to_i < number - 5
            message="Way too low."
            color="Blue"
        elsif params["guess"].to_i < number
            message="Too low."
            color="LightBlue"
        else      
            message="Correct, the answer is " + params["guess"]
            number=rand(100)
            @@guess_count=7
            color="Green"
        end
    end
    erb :index, :locals => {:message => message,:color => color,:message2 => message2}
end