RSpec.ddescribe 'GET /api/v1/articles', type: :request do
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }
  let!(:article) do
    10.times do
      create(:article,
            title: 'Breaking News',
            body: 'Some breaking content'*10)
    end
  end

  describe 'Get first page' do
    before do
      get '/api/v1/articles', headers: headers
    end

    it 'return a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns 4 articles' do
      expect(response_json['articles'].count).to eq 4
    end

    it 'returns only first 75 characters of each article' do
      expect(response_json['articles'][0]['body'].length).to eq 75
    end

    it 'returns metadata for current page' do

    end  
  end

  describe 'Get second page' do
    before do
      get '/api/v1/articles', params: { page: 2 }, headers: headers
    end

    it 'return a 200 response status' do
      expect(response).to have_http_status 200
    end
    
    it 'returns metadata for second page' do
    
    end
  end
end