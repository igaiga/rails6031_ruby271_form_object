class EmailValidator < ActiveModel::EachValidator
  # validate_eachメソッドをつくるお約束（この名前で）
  def validate_each(record, attribute, value)
    # record: バリデーション対象のオブジェクト
    # attribute: バリデーション対象の属性名
    # value: 属性の値
    unless value =~ URI::MailTo::EMAIL_REGEXP
      # optionsは、呼び出し元から validates :email, email: options で渡せる
      # p "===== options:"
      # p options
      # p options.class
      record.errors.add(attribute, :invalid, options.merge(value: value))
#      record.errors.add(attribute, :invalid, value: value) でもいいのだけど、options渡せるように書いておくと便利
    end
  end
end
