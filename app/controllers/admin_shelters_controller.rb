class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_reverse_name
    @shelters_with_apps = Shelter.applications?
  end
end
