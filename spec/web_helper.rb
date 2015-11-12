def sign_up
  visit '/users/new'
  expect(page.status_code).to eq 200
  fill_in :email, with: 'rich@gmail.com'
  fill_in :password, with: '12345678'
  click_button 'Sign Up'
end