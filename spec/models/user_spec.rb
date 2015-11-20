describe User do

	let!(:user) do
		User.create(email: 'rich@gmail.com',
			    password: '12345678',
			    password_confirmation: '12345678')
	end

	it 'authenticates when given a valid email address and password' do
		authenticated_user = User.authenticate(user.email, user.password)
		expect(authenticated_user).to eq user
	end

	it 'does not authenticate when given an incorrect password' do
		expect(User.authenticate(user.email, 'wrong_password')).to be_nil
	end

	it 'saves a password recovery token when we generate a token' do
		expect{user.generate_token}.to change{user.password_token}
	end
end
