require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがある
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'Nickname', with: @user.nickname
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password_confirmation
      # サインアップボタンを押すとユーザーモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # カーソルを合わせるとログアウトボタンが表示される
      expect(find(".user_nav").find("span").hover).to have_content("ログアウト")
      # サインアップページへ遷移するボタンやログインページで遷移するボタンが表示されていない
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがある
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'Nickname', with: ""
      fill_in 'Email', with: ""
      fill_in 'Password', with: ""
      fill_in 'Password confirmation', with: ""
      # サインアップボタンを押してもユーザーモデルのカウントは上がらない
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻される
      expect(current_path).to eq "/users"
    end
  end
end

  RSpec.describe 'ログイン', type: :system do
    before do
      @user = FactoryBot.create(:user)
    end
    context 'ログインができるとき' do
      it '保存されているユーザーの情報と合致すればログインができる' do
        # トップページに移動する
        visit root_path
        # トップページにログインページへ遷移するボタンがある
        expect(page).to have_content('ログイン')
        # ログインページへ遷移する
        visit new_user_session_path
        # 正しいユーザー情報を入力する
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        # ログインボタンを押す
        find('input[name="commit"]').click
        # トップページへ遷移する
        expect(current_path).to eq root_path
        # カーソルを合わせるとログアウトボタンが表示される
        expect{
          (find(".user_nav").find("span").hover).to have_content("ログアウト")
        }
        # サインアップページへ遷移するボタンやログインページで遷移するボタンが表示されていない
        expect{
          (find(".user_nav").find("span").hover).to havs_no_content("ログイン")
        }
        expect{
          (find(".user_nav").find("span").hover).to havs_no_content("新規登録")
        }
      end
    end
    context 'ログインができないとき' do
      it '保存されているユーザーの情報と合致しないとログインができない' do
        #トップページに移動する
        visit root_path
        # トップページにログインページへ遷移するボタンがある
        expect(page).to have_content("ログイン")
        # ログインページへ遷移する
        visit new_user_session_path
        # ユーザー情報を入力する
        fill_in 'Email', with: ""
        fill_in 'Password', with: ""
        # ログインボタンを押す
        find('input[name="commit"]').click
        # 新規登録ページへ戻される
        expect(current_path).to eq "/users/sign_in"
      end
    end
  end

