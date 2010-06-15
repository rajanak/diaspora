require File.dirname(__FILE__) + '/../spec_helper'
 
describe FriendsController do
  render_views
  before do
    #TODO(dan) Mocking Warden; this is a temp fix
    request.env['warden'] = mock_model(Warden, :authenticate? => @user, :authenticate! => @user)
    Friend.create(:username => "max", :url => "http://max.com/")
  end
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Friend.first.id
    response.should render_template(:show)
  end
  
  it "destroy action should destroy model and redirect to index action" do
    friend = Friend.first
    delete :destroy, :id => friend.id
    response.should redirect_to(friends_url)
    Friend.first(:conditions => {:id => friend.id}).should be_nil
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Friend.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Friend.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(friend_url(assigns[:friend]))
  end
  
  it 'should test that a real creation adds to the database' do 
  end
  
  it 'should have test that a delete removes a friend from the database' do
  end
  
end
