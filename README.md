# Trick Phish

This project is a Ruby on Rails storefront built as a blank-slate, professional-looking shop you can customize later. It includes:

- a public product catalog
- product detail pages
- a cart with add/remove actions
- customer account sign-up and sign-in
- guest-style checkout flow
- a contact page
- an admin panel for creating and managing products

## Requirements

- Ruby 3.4+
- Rails 8.0+
- SQLite3

## Local setup

1. Open the project folder:
   ```bash
   cd /workspaces/Trick_phish
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Set up the database:
   ```bash
   bundle exec rails db:migrate
   ```

4. Start the app:
   ```bash
   bin/rails server -b 0.0.0.0 -p 3000
   ```

5. Open the site in your browser:
   ```text
   http://127.0.0.1:3000
   ```

## How to use the storefront

### Browse products
- Visit the homepage to see the product grid.
- Click any product card to open its detail page.
- Use the Add to cart button to add products.

### Cart
- Open the cart at:
  ```text
  http://127.0.0.1:3000/cart
  ```
- Remove items with the Remove button.

### Create a customer account
- Go to:
  ```text
  http://127.0.0.1:3000/users/new
  ```
- Fill in an email and password.
- After signup, you will be signed in automatically.

### Sign in
- Go to:
  ```text
  http://127.0.0.1:3000/session/new
  ```
- Use your created account or an admin account.

## Admin panel

### Admin login
The admin panel is accessed through the normal sign-in page.

To sign in as admin, create a user with the role set to `admin` in the database, or create one manually with a Rails console.

Example:
```bash
bundle exec rails console
```

Then run:
```ruby
User.create!(email: "admin@example.com", password: "password123", password_confirmation: "password123", role: "admin")
```

After that, sign in at:
```text
http://127.0.0.1:3000/session/new
```

If the sign-in succeeds and the user has the `admin` role, the app redirects to the admin dashboard.

### Admin dashboard
After logging in as admin, visit:
```text
http://127.0.0.1:3000/admin
```

From the admin dashboard you can manage products.

### Add a product
1. Go to the admin product list.
2. Click New product.
3. Enter:
   - product name
   - price
   - description
   - image file
4. Click Create product.

The product will appear on the homepage product grid.

## Customizing the storefront

You can change the visual style in:
- app/assets/stylesheets/application.css

You can change the product logic in:
- app/controllers/products_controller.rb
- app/controllers/admin/products_controller.rb

You can change the layout/navigation in:
- app/views/layouts/application.html.erb

## Notes

- The project uses SQLite for simplicity.
- The current build is a starter storefront and is designed to be customized further.
- If you want to connect real supplier APIs later, you can add integration logic in the admin product flow or a separate import service.

## Troubleshooting

If the app does not start:
```bash
bundle install
bundle exec rails db:migrate
```

If you want to reset the database:
```bash
rm db/development.sqlite3
bundle exec rails db:migrate
```

