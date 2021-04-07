module Users
  class CreateService
    prepend BaseService

    param :name
    param :email
    param :password

    attr_reader :user

    def call
      @user = ::User.new(
        name: name,
        email: email,
        password: password
      )

      return fail!(@user.errors) unless @user.valid?

      @user.save
    end
  end
end
