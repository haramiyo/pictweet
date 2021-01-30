require 'rails_helper'
describe User do
  before do
    @user = build(:user)
  end
  describe '#create' do
    it "nicknameとemail、passwordとpassword_confirmationが存在すれば登録できる" do
      expect(@user).to be_valid
    end



    it "nicknameが空の場合登録できない" do
      # user = User.new(nickname: "", email: "kkk@gmail.com", password: "00000000", password_confirmation: "00000000")
      @user.nickname = ""
      @user.valid?
      expect(@user.errors[:nickname]).to include("can't be blank")    
    end

    it "emailが空の場合保存できない" do
      # user = User.new(nickname: "miyo", email: "", password: "00000000", password_confirmation: "00000000")
      @user.email = nil
      @user.valid?
      expect(@user.errors[:email]).to include("can't be blank")
      
    end
    
#     it "passwordが空では登録できない" do
#       user = build(:user, password: nil)
#       user.valid?
#       expect(user.errors[:password]).to include("can't be blank")
#     end

    it "passwordが存在してもpassword_confirmationが空では登録できない" do
      user = build(:user, password_confirmation: nil)
      binding.pry
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end


#     it "nicknameが7文字以上であれば登録できない" do
#       user = build(:user, nickname: "aaaaaaa")
#       user.valid?
#       expect(user.errors[:nickname]).to include("is too long (maximum is 6 characters)")
#     end
    
#     it "nicknameが6文字以下では登録できること" do
#       user =build(:user, nickname: "aaa")
#       expect(user).to be_valid
#     end


#     it "重複したemailが存在する場合登録できない" do
#       user =create(:user)
#       another_user = build(:user, email: user.email)
#       another_user.valid?
#       expect(another_user.errors[:email]).to include("has already been taken")
#     end

#     it "passwordが6文字以上であれば登録できる" do
#       user = build(:user, password: "000000", password_confirmation: "000000")
#       expect(user).to be_valid
#     end

#     it"passwordが5文字以下であれば登録できないこと" do
#       user = build(:user, password: "00000", password_confirmation: "00000")
#       user.valid?
#       expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
#     end
  end
end