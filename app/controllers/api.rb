Jtc.controllers :api do
  get :classify do
    query = params[:query]

    if query.empty?
      answer = []
    else
      classifier = Classifier.new
      answer = classifier.classify(query)
    end

    content_type :json
    answer.to_json
  end
end
