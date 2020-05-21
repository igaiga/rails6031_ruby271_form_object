class UserRegistrationForm
  include ActiveModel::Model

  include ActiveModel::Attributes
  attribute :name, :string
  attribute :email, :string
  attribute :terms_of_service, :string # このattributeはDB保存しない

  # このFormObject用のバリデーション（なのでUserモデルと違って良い）
  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :terms_of_service, acceptance: true

  # (雑) saveメソッドを生やしておくとモデルと同じ使い心地に
  def save
    return false if invalid?
    @user = User.new(name: name, email: email).save
  end
end
