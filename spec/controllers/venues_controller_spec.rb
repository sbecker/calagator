require File.dirname(__FILE__) + '/../spec_helper'

describe VenuesController do
  integrate_views
  fixtures :events, :venues

  #Delete this example and add some real ones
  it "should use VenuesController" do
    controller.should be_an_instance_of(VenuesController)
  end

  it "should redirect duplicate venues to their master" do
    venue_master = venues(:cubespace)
    venue_duplicate = venues(:duplicate_venue)

    get 'show', :id => venue_duplicate.id
    response.should_not be_redirect
    assigns(:venue).id.should == venue_duplicate.id

    venue_duplicate.duplicate_of = venue_master
    venue_duplicate.save!

    get 'show', :id => venue_duplicate.id
    response.should be_redirect
    response.should redirect_to(venue_url(venue_master.id))
  end

  it "should display an error message if given invalid arguments" do
    get 'duplicates', :type => 'omgwtfbbq'

    response.should be_success
    response.should have_tag('.failure', :text => /omgwtfbbq/)
  end
  
  describe "when creating venues" do
    it "should stop evil robots" do
      post :create, :trap_field => "I AM AN EVIL ROBOT, I EAT OLD PEOPLE'S MEDICINE FOR FOOD!"
      response.should render_template(:new)
    end
  end
  
  describe "when updating venues" do 
    before(:each) do
      @venue = stub_model(Venue)
      Venue.stub!(:find).and_return(@venue)
    end
    
    it "should stop evil robots" do
      put :update,:id => '1', :trap_field => "I AM AN EVIL ROBOT, I EAT OLD PEOPLE'S MEDICINE FOR FOOD!"
      response.should render_template(:edit)
    end
  end
      
  
end
