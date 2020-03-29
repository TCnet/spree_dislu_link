module Spree
  module Admin
    class DisluSettingsController < Spree::Admin::BaseController
      def edit
        @config      = Spree::DisluConfiguration.new
        @preferences = [:show_best_sellers,
                        :max_best_sellers,
                        :days_is_new,
                        :address,
                        :phone,
                        :email,
                        :work_time,
                        :facebook,
                        :twitter,
                        :instagram
                        ]
      end

      def update
        config = Spree::DisluConfiguration.new

        params.each do |name, value|
          next unless config.has_preference? name
          config[name] = value
        end


        flash[:success] = Spree.t(:successfully_updated, resource: Spree.t('dislu_settings.title'))
        redirect_to edit_admin_dislu_settings_path
      end
    end
  end
end