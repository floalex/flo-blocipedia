class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def new
    if current_user.role == "premium"
      flash[:error] = "You are already a premium member!"
      redirect_to root_path
    end
    @subscription = Subscription.new
    @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "Premium Membership - #{current_user.name}"
     }
  end

  def create
    subscription = Subscription.new
      stripe_sub = nil
    if current_user.stripe_customer_id.blank?
      # Creates a Stripe Customer object, for associating with the charge
      customer = Stripe::Customer.create(
        email: current_user.email,
        card: params[:stripeToken],
        plan: 'premium_plan'
        )
      current_user.stripe_customer_id = customer.id
      current_user.save!
      stripe_sub = customer.subscriptions.first
    else
      customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)
      stripe_sub = customer.subscriptions.create(
        plan: 'premium_plan'
        )
    end

    current_user.subid = stripe_sub.id

    current_user.subscription.save!

    update_user_to_premium
    flash[:success] = "Thank you for your subscription!"
    
    redirect_to root_path 

    # Handle exceptions
    rescue Stripe::CardError => e
     flash[:error] = e.message
     redirect_to new_subscriptions_path
  end
  

  def downgrade
    @user = current_user

    customer = Stripe::Customer.retrieve(id: @user.stripe_customer_id)
    customer.subscriptions.retrieve(@user.subid).delete
    
       downgrade_user_to_standard
       flash[:success] = "Sorry to see you go."
       redirect_to user_path(current_user)

  end
end
