# frozen_string_literal: true

class FrontendController < ApplicationController
  before_action :check_location

  protected

  def check_location
    return if params[:country_user_country].present? && params[:user_city].present?

    if cookies[:country] != params[:country_user_country] || cookies[:city] != params[:user_city]
      user_ip = Rails.env.development? ? '158.140.178.94' : request.ip
      geocoded = Geocoder.search(user_ip).first
      country = Country.create_with(name: IsoCountryCodes.find(geocoded.country).name).create_or_find_by(slug: geocoded.country.downcase)
      cookies[:country] = country.slug
      city = country.cities.create_with(name: geocoded.city).create_or_find_by(slug: geocoded.city.parameterize)
      cookies[:city] = city.slug
    end

    redirect_to "/#{cookies[:country]}/#{cookies[:city]}"
  end
end
