class Spree::DisluConfiguration < Spree::Preferences::Configuration

  preference :show_best_sellers, :boolean, :default => true
  preference :max_best_sellers, :string, :default => 8
  preference :days_is_new, :string, :default => 20

  preference :address, :string
  preference :phone, :string
  preference :email, :string
  preference :work_time, :string

  preference :twitter, :string
  preference :facebook, :string
  preference :facebook, :string
  preference :instagram, :string
  
end