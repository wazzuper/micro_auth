# frozen_string_literal: true

class User < Sequel::Model
  NAME_FORMAT = %r{\A\w+\z}

  plugin :secure_password, include_validations: false
  plugin :association_dependencies

  one_to_many :sessions, class: :UserSession
  add_association_dependencies sessions: :delete

  def validate
    super
    validates_presence :name, message: I18n.t(:blank, scope: 'model.errors.user.name')
    validates_presence :email, message: I18n.t(:blank, scope: 'model.errors.user.email')
    validates_presence :password, message: I18n.t(:blank, scope: 'model.errors.user.password') if new?

    validates_format NAME_FORMAT, :name, message: I18n.t(:invalid, scope: 'model.errors.user.name')
  end
end
