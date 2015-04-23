class ChargesController < ApplicationController
  before_action :authenticate_user!

  

    
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership - #{current_user.name}",
      amount: Amount.default
    }
  end

  class Amount

    def self.default
      15_00  # 15 dollars
    end

  end

    
end
