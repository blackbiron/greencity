# frozen_string_literal: true

class FrontendController < ApplicationController
  before_action :check_location

  protected

  def check_location
    return if cookies[:country] == params[:country_user_country] && cookies[:city] == params[:user_city]

    if params[:country_user_country].present? && params[:user_city].present?
      @country = Country.find_by(slug: params[:country_user_country])
      @city = @country&.cities&.find_by(slug: params[:user_city])
    else
      user_ip = Rails.env.development? ? '158.140.178.94' : request.ip
      geocoded = Geocoder.search(user_ip).first
      @country = Country.create_with(name: IsoCountryCodes.find(geocoded.country).name)
                        .create_or_find_by(slug: geocoded.country.downcase)
      @city = @country.cities.create_with(name: geocoded.city)
                      .create_or_find_by(slug: geocoded.city.parameterize)

      redirect_to "/#{@country.slug}/#{@city.slug}"
    end

    cookies[:country] = @country.slug
    cookies[:city] = @city.slug
  end
end
