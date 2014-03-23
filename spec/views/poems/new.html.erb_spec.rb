require 'spec_helper'

describe "poems/new" do
  before(:each) do
    assign(:poem, stub_model(Poem,
      :title => "MyString",
      :content => "MyText",
      :author_id => 1
    ).as_new_record)
  end

  it "renders new poem form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", poems_path, "post" do
      assert_select "input#poem_title[name=?]", "poem[title]"
      assert_select "textarea#poem_content[name=?]", "poem[content]"
      assert_select "input#poem_author_id[name=?]", "poem[author_id]"
    end
  end
end
