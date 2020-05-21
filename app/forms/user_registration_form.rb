class UserRegistrationForm
  include ActiveModel::Model #バリデーション機能やform_withに渡せる機能などを足す

  # UserRegistrationForm.new({name: "foo", email: "bar, ...}) とかするため
  include ActiveModel::Attributes
  attribute :name, :string
  attribute :email, :string
  attribute :terms_of_service, :boolean # このattributeはDB保存しない

  # このFormObject用のバリデーション（なのでUserモデルと違って良い）
  validates :name, presence: true
#  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
#  validates :email, email: true
  validates :email, email: { message: "Invalid Error!" }
#  validates :email, email: true, presence: true # 他のオプション渡しても良い
  validates :terms_of_service, acceptance: { allow_nil: false }
  # acceptanceはチェックボックス確認用 https://railsguides.jp/active_record_validations.html#acceptance

  # (雑) saveメソッドを生やしておくとモデルと同じ使い心地に
  def save
    return false if invalid? # これしなくてもいいかも
    user.save
  end

  # redirect_to @user のときにUserオブジェクト取りたいので取れるようにする
  def user
    @user ||= User.new(name: name, email: email)
  end

end
