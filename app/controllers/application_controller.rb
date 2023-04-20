class ApplicationController < ActionController::API

    def jwt_key
        Rails.application.credentials.jwt_key
    end

    def issue_token(user, type = 'access')
        expired_time = type == 'refresh' ? ENV['REFRESH_TOKEN_EXPIRED_DAYS'].to_i.days : ENV['ACCESS_TOKEN_EXPIRED_HOURS'].to_i.hour
        jwt_algorithm = ENV['JWT_ALGORITHM']
        payload = { user_id: user.id, exp: expired_time.from_now.to_i}
        return {
            code: JWT.encode(payload, jwt_key, jwt_algorithm),
            exp: Time.now + expired_time
        }
    end

    def invalidate_token(token)
        begin
            jwt_payload, jwt_header = JWT.decode(request_token,jwt_key, true, { algorithm: 'HS256' })
            jwt_payload['exp'] = Time.now.to_i
            JWT.encode(jwt_payload, jwt_key, 'HS256')
        rescue JWT::DecodeError
            [{error: "Invalid Token"}]
        end
    end


    def decoded_token
        puts "into decoded_token"
        begin
            jwt_payload, jwt_header = JWT.decode(request_token,jwt_key, true, { algorithm: 'HS256' })

            if Time.at(jwt_payload['exp']) < Time.now
                return [{error: "Token Expired"}]
            else
                return JWT.decode(request_token,jwt_key, true, { algorithm: 'HS256' })
            end
        rescue JWT::DecodeError
          [{error: "Invalid Token"}]
        end
    end

    def authorized
        render json: { error: "Unauthorized", message: 'Please log in' }, status: :unauthorized unless logged_in?
    end

    def request_token
        #use Bearer token with format "Bearer <token>"
        puts "Into request_token"
        header = request.headers[:Authorization]
        header.split(' ').last if header
    end

    def user_id
        decoded_token.first['user_id']
    end

    def current_user
        @user ||= User.find_by(id: user_id)
    end

    def logged_in?
        !!current_user
    end
end
