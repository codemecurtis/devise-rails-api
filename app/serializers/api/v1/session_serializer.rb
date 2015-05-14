module Api
	module V1
		class SessionSerializer < ActiveModel::Serializer

			attributes :email, :token_type, :client_id, :access_token

			def client_id
				object.id
			end

			def token_type
				'Bearer'
			end

		end
	end
end