require 'spec_helper'

describe "activities/edit.html.erb" do
  before(:each) do
    @activity = assign(:activity, stub_model(Activity,
      :title => "MyString",
      :description => "MyText",
      :limit => 1
    ))
  end

  it "renders the edit activity form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => activities_path(@activity), :method => "post" do
      assert_select "input#activity_title", :name => "activity[title]"
      assert_select "textarea#activity_description", :name => "activity[description]"
      assert_select "input#activity_limit", :name => "activity[limit]"
    end
  end
end
