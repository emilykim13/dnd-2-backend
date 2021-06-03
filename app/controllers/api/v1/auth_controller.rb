class Api::V1::AuthController < ApplicationController
    skip_before_action :authorized, only: [:login]

    def login
        user = User.find_by(email: auth_param[:email])
            if user && user.authenticate(auth_param[:password])
                token = encode_token({user_id: user.id})
                render json: {user: user, token: JWT.encode({user_id: user.id}, ENV['SECRET'])
            }, 
                status: :accepted
            else
                render json: {error: "Incorrect email or password"}, status: :unathorized
            end
    end

    private 

    def auth_param 
        params.require(:auth).permit(:email, :password)
    end

end
