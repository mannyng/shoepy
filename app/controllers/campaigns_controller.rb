class CampaignsController < ApplicationController
    before_action :authenticate_request!
    
    def create
     @campaign = Campaign.new(campaign_params)
     
      if @campaign.save
          render json: {campaign: @campaign, status: :sent}
         else
          render json: { errors: @campaign.errors.full_campaigns }, status: :bad_request
      end
    end
    
    private
    
    def campaign_params
        params.require(:campaign).permit(:title, pictures: {})
    end
end    