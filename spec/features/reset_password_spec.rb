feature 'password reset' do

	before do
		sign_up
		Capybara.reset!
	end

	let(:user) { User.first }

	scenario 'it doesn\'t allow you to use the token after an hour' do
		recover_password
		Timecop.travel(60 * 60 * 60) do
			visit("/users/reset_password?token=#{user.password_token}")
			expect(page).to have_content 'Your token has expired'
		end
	end

	scenario 'it asks for your new password when your token is valid' do
		recover_password
		visit("/users/reset_password?token=#{user.password_token}")
		expect(page).to have_content 'Please enter your new password'
	end

  def recover_password
    visit '/users/recover'
    fill_in :email, with: 'rich@gmail.com'
    click_button 'Submit'
  end
end
