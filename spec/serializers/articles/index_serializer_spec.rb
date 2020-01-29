RSpec.describe Articles::IndexSerializer, type: :serializer do
  let!(:article) { create(:article,
                          title: 'Breaking News',
                          body: 'Some breaking but also long content.' *  5 )}
  let(:serialization) { Articles::IndexSerializer.new(article) }
  subject { JSON.parse(serialization.to_json) }

  it 'contains id, title, body and category' do
    expected_keys = ['id', 'title', 'body', 'category']
    expect(subject.keys).to match expected_keys
  end

  it 'truncates body to 75 chars' do
    expect(subject['body'].length).to eq 75
  end
end