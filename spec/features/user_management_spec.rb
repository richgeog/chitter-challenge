feature 'user sign up' do

  scenario 'I can sign up as a new user' do
    expect { sign_up }.to change(User, :count).by 1
    expect(page).to have_content('Welcome, rich@gmail.com')
    expect(User.first.email).to eq('rich@gmail.com')
  end

  scenario 'requires a matching confirmation password' do
    expect { sign_up(password_confirmation: 'wrong')}.not_to change(User, :count)
  end

  scenario 'password that does not match' do
    expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Password does not match the confirmation'
  end

  scenario "I can't sign up without an email address" do
	  expect { sign_up(email: nil) }.not_to change(User, :count)
	  expect(current_path).to eq('/users')
	  expect(page).to have_content('Email must not be blank')
  end

  scenario "I can't sign up with an invaild email address" do
    expect { sign_up(email: "false@gmail") }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content('Email has an invalid format')
  end

  scenario "I can not sign up with an exisiting email address" do
	sign_up
	expect { sign_up }.to_not change(User, :count)
	expect(page).to have_content('Email is already taken')
  end
end

feature 'user can sign in' do

	let(:user) do
		User.create(email: 'rich@gmail.com',
			    password: '12345678',
			    password_confirmation: '12345678')
	end

	scenario 'with the correct credentails' do
		sign_in(email: user.email, password: user.password)
		expect(page).to have_content "Welcome, #{user.email}"
	end
end

feature 'users can log out' do

	before(:each) do
		User.create(email: 'rich@gmail.com',
			    password: '12345678',
			    password_confirmation: '12345678')
	end

	scenario 'while being signed in' do
		sign_in(email: 'rich@gmail.com', password: '12345678')
		click_button 'Sign Out'
		expect(page).to have_content('Thanks for visiting, come back soon')
		expect(page).not_to have_content('Welcome, rich@gmail.com')
	end
end

feature 'Resetting password' do

	scenario 'when i forget my password i can see a link to reset it' do
		visit '/sessions/new'
		click_link 'Forgotten password'
		expect(page).to have_content("Please enter your email address")
	end

	scenario 'when i enter my email i am told to check my inbox' do
		visit 'users/recover'
		fill_in 'email', with: 'rich@gmail.com'
		click_button 'Submit'
		expect(page).to have_content "Thanks, please check your inbox for the link"
	end
end
