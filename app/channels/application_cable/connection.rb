module ApplicationCable
  class Connection < ActionCable::Connection::
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected

    # wardenを使用して、ユーザー情報を取得する
    #   情報が見つからなかった場合、例外として処理される
    #   例外処理で未ログインとして処理
    def find_verified_user
      User.find_by(id: env['warden'].user.id)
    rescue
      reject_unauthorized_connection
    end
  end
end
