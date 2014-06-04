class PeopleController < ApplicationController
  def show
    @candidate = Person.friendly_find(params)
    render text: @candidate.name
  end

  def redirect_show
    person = Person.find_by(name: params[:name_slug].gsub('_', ' '))
    if person
      redirect_to person_url(id: person.id, slug: person.slug), status: 301
    else
      fail ActiveRecord::RecordNotFound
    end
  end
end