require "rails_helper"

RSpec.describe User, type: :model do
  describe "ユーザー新規登録" do
    # ユーザー新規登録についてのテストコードを記述します
    it "nicknameが空では登録できない" do
      user = User.new(nickname: "", email: "test@example", password: "000000", password_confirmation: "000000")
      user.valid?
      expect(user.errors.full_messages).to include("Nickname can't be blank")
      # nicknameが空では登録できないテストコードを記述します
    end
    it "emailが空では登録できない" do
      user = User.new(nickname: "test", email: "", password: "000000", password_confirmation: "000000")
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank")
      # emailが空では登録できないテストコードを記述します
    end
  end
end
