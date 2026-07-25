# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

admin = User.find_or_initialize_by(email: "admin@example.com")
admin.role = "admin"
admin.password = "admin123"
admin.password_confirmation = "admin123"
admin.save!
